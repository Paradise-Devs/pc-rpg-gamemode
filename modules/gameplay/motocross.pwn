/*******************************************************************************
* FILENAME :        modules/gameplay/motocross.pwn
*
* DESCRIPTION :
*       Adds 8-track race at Los Santos Stadium
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

enum
{
	CROSS_STATE_NONE,
	CROSS_STATE_SPECTATING,
	CROSS_STATE_RACING
}

// If player is inside motocross: racing or spectating
static gPState[MAX_PLAYERS];

// Current race lap
static gPCurrentLap[MAX_PLAYERS];

// Current CP
static gPCurrentCP[MAX_PLAYERS];

// Max race laps
static const MAX_LAPS = 3;

// Max players per race
#define MAX_PLAYER_MCROSS_RACE	12

// If the race already started
static bool:gStarted = false;

// Amount of player racing in motocross
static gTrackPlayerPoolSize = 0;

// Player vehicleID
static gPVehicleID[MAX_PLAYERS] = {INVALID_VEHICLE_ID, ...};

// Countdown
static gCountdown = 0;

// Finish position
static gFinishPosition = 1;

// Vehicle positions
static Float:gVehiclePositions[MAX_PLAYER_MCROSS_RACE][] =
{
	{-1383.1257,-592.3108,1056.3213,89.3717},
	{-1383.1167,-590.4079,1056.0464,85.1170},
	{-1383.1920,-587.9711,1055.7090,88.4649},
	{-1383.3445,-585.0005,1055.3837,80.5266},
	{-1377.4275,-592.4870,1056.1542,90.8640},
	{-1377.4109,-590.7714,1055.9067,87.6129},
	{-1377.5500,-588.8147,1055.6331,84.4706},
	{-1377.2230,-586.1389,1055.3052,82.9532},
	{-1371.9447,-592.5481,1056.0585,86.2583},
	{-1371.7285,-591.0809,1055.9015,86.2915},
	{-1371.7394,-589.0543,1055.5596,86.3940},
	{-1371.6768,-586.6129,1055.3008,86.5187}
};

// Max players
static gPlayers[MAX_PLAYER_MCROSS_RACE] = {INVALID_PLAYER_ID, ...};

// Checkpoints
static Float:gCheckpoint[][] =
{
	{-1443.9749,-589.0208,1055.2324},
	{-1515.6848,-651.5577,1049.2742},
	{-1474.2023,-731.1159,1049.6451},
	{-1352.3446,-741.7247,1053.4587},
	{-1423.9653,-663.7010,1059.4490},
	{-1469.4022,-611.1839,1055.0544},
	{-1446.1676,-700.5908,1054.1521},
	{-1361.1116,-687.6579,1054.6267},
	{-1361.1826,-623.8066,1052.7212},
	{-1389.6388,-588.9465,1056.4077}
};

//------------------------------------------------------------------------------

IsPlayerInMotocross(playerid)
	return (gPState[playerid] != 0);

//------------------------------------------------------------------------------

hook OnGameModeInit()
{
	CreateDynamicPickup(2993, 1, 2693.0874, -1706.2458, 11.0, 0, 0, -1, MAX_PICKUP_RANGE);
	CreateDynamic3DTextLabel("Corrida: Motocross", 0xFFFFFFFF, 2693.0874, -1706.2458, 11.8478, MAX_TEXT3D_RANGE, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
}

//------------------------------------------------------------------------------

hook OnPlayerPickUpDynPickup(playerid, pickupid)
{
	if(IsPlayerInRangeOfPoint(playerid, 2.0, 2693.0874, -1706.2458, 11.8478))
	{
		if(gStarted)
		{
			SendClientMessage(playerid, -1, "* A {FFA050}corrida já foi iniciada{FFFFFF}, você ficará de espectador até o termino dela.");
			SendClientMessage(playerid, -1, "* Para sair pressione {FFA050}F{FFFFFF}.");
			SetPlayerInterior(playerid, 4);
			SetPlayerPos(playerid, -1405.7427, -260.4151, 1043.6563);
			SetPlayerCameraPos(playerid, -1332.6400,-770.6528,1085.1444);
			SetPlayerCameraLookAt(playerid, -1444.4102,-672.3134,1052.8842);

			gPState[playerid] = CROSS_STATE_SPECTATING;
		}
		else
		{
			new freePos = gTrackPlayerPoolSize;
			for(new i = 0; i < MAX_PLAYER_MCROSS_RACE; i++)
			{
				if(gPlayers[i] == INVALID_PLAYER_ID)
				{
					freePos = i;
					gPlayers[i] = playerid;
					break;
				}
			}

			gPVehicleID[playerid] = CreateVehicle(468, gVehiclePositions[freePos][0], gVehiclePositions[freePos][1], gVehiclePositions[freePos][2], gVehiclePositions[freePos][3], random(126), random(126), -1);
			LinkVehicleToInterior(gPVehicleID[playerid], 4);
			SetPlayerInterior(playerid, 4);
			PutPlayerInVehicle(playerid, gPVehicleID[playerid], 0);
			DisableRemoteVehicleCollisions(playerid, true);

			gPState[playerid] = CROSS_STATE_RACING;
			gTrackPlayerPoolSize++;

			defer StartRaceAutoCross();

			if(gTrackPlayerPoolSize == (sizeof(gVehiclePositions)-1))
				StartRace();
			else
				SendClientMessage(playerid, -1, "* A {FFA050}corrida irá começar em breve{FFFFFF}, aguardando mais jogadores...");
			SendClientMessage(playerid, -1, "* Caso você abandone seu veículo será automaticamente {FFA050}desclassificado{FFFFFF}.");
		}
		return -2;
	}
	return 1;
}

//------------------------------------------------------------------------------

timer StartRaceAutoCross[60000]()
{
	if(!gStarted && gTrackPlayerPoolSize > 0)
		StartRace();
}

//------------------------------------------------------------------------------

static StartRace()
{
	gStarted = true;
	gCountdown = 10;
	defer RaceCountdownCross();
	foreach(new i: Player)
	{
		if(IsPlayerInMotocross(i))
		{
			SendClientMessage(i, -1, "* A corrida irá começar em {FFA050}10{FFFFFF}, liguem os motores.");
			TogglePlayerControllable(i, false);
		}
	}
}

//------------------------------------------------------------------------------

timer RaceCountdownCross[1000]()
{
	if(gCountdown > 0)
	{
		new str[6];
		format(str, sizeof(str), "~w~%i", gCountdown);
		foreach(new i: Player)
		{
			if(IsPlayerInMotocross(i))
			{
				GameTextForPlayer(i, str, 1000, 3);
				PlayerPlaySound(i, 1056, 0.0, 0.0, 0.0);
			}
		}
		defer RaceCountdownCross();
		gCountdown--;
	}
	else
	{
		foreach(new i: Player)
		{
			if(IsPlayerInMotocross(i))
			{
				GameTextForPlayer(i, "~g~Vai!", 1000, 3);
				PlayerPlaySound(i, 1057, 0.0, 0.0, 0.0);
				TogglePlayerControllable(i, true);
				SetPlayerRaceCheckpoint(i, 0, gCheckpoint[0][0], gCheckpoint[0][1], gCheckpoint[0][2], gCheckpoint[1][0], gCheckpoint[1][1], gCheckpoint[1][2], 10.0);
			}
		}
	}
}

//------------------------------------------------------------------------------

hook OnPlayerEnterRaceCPT(playerid)
{
	if(IsPlayerInMotocross(playerid) && gPState[playerid] == CROSS_STATE_RACING)
	{
		PlaySelectSound(playerid);

		new cpid = gPCurrentCP[playerid];
		new clap = gPCurrentLap[playerid];
		if(clap == MAX_LAPS && cpid == (sizeof(gCheckpoint)-1))
		{
			SetPlayerRaceCheckpoint(playerid, 1, gCheckpoint[cpid][0], gCheckpoint[cpid][1], gCheckpoint[cpid][2], 0.0, 0.0, 0.0, 10.0);
			gPCurrentCP[playerid]++;
		}
		else if(cpid == sizeof(gCheckpoint) && clap == MAX_LAPS)
		{
			DestroyVehicle(gPVehicleID[playerid]);
			gPVehicleID[playerid] = INVALID_VEHICLE_ID;
			DisableRemoteVehicleCollisions(playerid, false);

			SetPlayerPos(playerid, -1405.7427, -260.4151, 1043.6563);
			SetPlayerCameraPos(playerid, -1332.6400,-770.6528,1085.1444);
			SetPlayerCameraLookAt(playerid, -1444.4102,-672.3134,1052.8842);
			gPState[playerid] = CROSS_STATE_SPECTATING;

			new message[68 + MAX_PLAYER_NAME];
			format(message, sizeof(message), "* {FFA050}%s{FFFFFF} terminou a corrida em {FFA050}%iº{FFFFFF}.", GetPlayerNamef(playerid), gFinishPosition);
			foreach(new i: Player)
			{
				if(IsPlayerInMotocross(i))
				{
					SendClientMessage(i, 0xFFFFFFFF, message);
				}
			}

			gFinishPosition++;
			if(gFinishPosition > gTrackPlayerPoolSize)
				EndRace();
		}
		else if((cpid + 1) <= (sizeof(gCheckpoint)-1))
		{
			SetPlayerRaceCheckpoint(playerid, 0, gCheckpoint[cpid][0], gCheckpoint[cpid][1], gCheckpoint[cpid][2], gCheckpoint[cpid+1][0], gCheckpoint[cpid+1][1], gCheckpoint[cpid+1][2], 10.0);
			gPCurrentCP[playerid]++;
		}
		else if((cpid + 1) > (sizeof(gCheckpoint)-1))
		{
			SetPlayerRaceCheckpoint(playerid, 0, gCheckpoint[cpid][0], gCheckpoint[cpid][1], gCheckpoint[cpid][2], gCheckpoint[0][0], gCheckpoint[0][1], gCheckpoint[0][2], 10.0);
			gPCurrentLap[playerid]++;
			gPCurrentCP[playerid] = 0;
		}
	}
}

//------------------------------------------------------------------------------

static EndRace()
{
	gFinishPosition = 1;
	gTrackPlayerPoolSize = 0;
	gStarted = false;

	for(new i = 0; i < sizeof(gPlayers); i++)
		gPlayers[i] = INVALID_PLAYER_ID;


	foreach(new i: Player)
	{
		if(IsPlayerInMotocross(i))
		{
			SendClientMessage(i, 0xFFFFFFFF, "* Todos os jogadores chegaram ao fim, {FFA050}a corrida terminou{FFFFFF}.");
			SetPlayerInterior(i, 0);
			SetPlayerPos(i, 2692.6216 + random(5), -1700.3165 + random(5), 10.3789);
			SetPlayerFacingAngle(i, 34.4769);
			SetCameraBehindPlayer(i);
			DisablePlayerRaceCheckpoint(i);

			gPState[i] = 0;
			gPCurrentLap[i] = 0;
			gPCurrentCP[i] = 0;
		}
	}
}

//------------------------------------------------------------------------------

hook OnPlayerDisconnect(playerid, reason)
{
	if(gPState[playerid] == CROSS_STATE_RACING)
	{
		DestroyVehicle(gPVehicleID[playerid]);
		gPVehicleID[playerid] = INVALID_VEHICLE_ID;
		DisableRemoteVehicleCollisions(playerid, false);

		new message[23 + MAX_PLAYER_NAME];
		format(message, sizeof(message), "* %s saiu da corrida.", GetPlayerNamef(playerid));

		foreach(new i: Player)
			if(IsPlayerInMotocross(i))
				SendClientMessage(i, 0xFFFFFFFF, message);

		gPState[playerid]		= 0;
		gPCurrentLap[playerid]	= 0;
		gPCurrentCP[playerid]	= 0;

		for(new i = 0; i < sizeof(gPlayers); i++)
			if(gPlayers[i] == playerid)
				gPlayers[i] = INVALID_PLAYER_ID;

		gTrackPlayerPoolSize--;

		if(gFinishPosition > gTrackPlayerPoolSize)
			EndRace();
	}
	else if(gPState[playerid] == CROSS_STATE_SPECTATING)
		gPState[playerid] = 0;
}

//------------------------------------------------------------------------------

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(gPState[playerid] == CROSS_STATE_RACING && newstate == PLAYER_STATE_ONFOOT)
	{
		DestroyVehicle(gPVehicleID[playerid]);
		gPVehicleID[playerid] = INVALID_VEHICLE_ID;
		DisableRemoteVehicleCollisions(playerid, false);

		new message[23 + MAX_PLAYER_NAME];
		format(message, sizeof(message), "* %s saiu da corrida.", GetPlayerNamef(playerid));

		SetPlayerInterior(playerid, 0);
		SetPlayerPos(playerid, 2692.6216 + random(5), -1700.3165 + random(5), 10.3789);
		SetPlayerFacingAngle(playerid, 34.4769);

		foreach(new i: Player)
			if(IsPlayerInMotocross(i) && i != playerid)
				SendClientMessage(i, 0xFFFFFFFF, message);

		gPState[playerid]		= 0;
		gPCurrentLap[playerid]	= 0;
		gPCurrentCP[playerid]	= 0;

		for(new i = 0; i < sizeof(gPlayers); i++)
			if(gPlayers[i] == playerid)
				gPlayers[i] = INVALID_PLAYER_ID;

		gTrackPlayerPoolSize--;

		if(gFinishPosition > gTrackPlayerPoolSize)
			EndRace();

		DisablePlayerRaceCheckpoint(playerid);
	}
}

//------------------------------------------------------------------------------

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if((newkeys == KEY_SECONDARY_ATTACK) && gPState[playerid] == CROSS_STATE_SPECTATING)
	{
		gPState[playerid] = 0;
		SetPlayerInterior(playerid, 0);
		SetPlayerPos(playerid, 2692.6216 + random(5), -1700.3165 + random(5), 10.3789);
		SetPlayerFacingAngle(playerid, 34.4769);
		SetCameraBehindPlayer(playerid);
	}
}
