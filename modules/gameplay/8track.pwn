/*******************************************************************************
* FILENAME :        modules/gameplay/8track.pwn
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
	TRACK_STATE_NONE,
	TRACK_STATE_SPECTATING,
	TRACK_STATE_RACING
}

// If player is inside 8 track, racing or spectating
static gPState[MAX_PLAYERS];

// Current race lap
static gPCurrentLap[MAX_PLAYERS];

// Current CP
static gPCurrentCP[MAX_PLAYERS];

// Max race laps
static const MAX_LAPS = 3;

// Max players per race
#define MAX_PLAYER_8TRACK_RACE		9

// If the race already started
static bool:gStarted = false;

// Amount of player racing in 8track
static gTrackPlayerPoolSize = 0;

// Player vehicleID
static gPVehicleID[MAX_PLAYERS] = {INVALID_VEHICLE_ID, ...};

// Countdown
static gCountdown = 0;

// Finish position
static gFinishPosition = 1;

// Vehicle positions
static Float:gVehiclePositions[MAX_PLAYER_8TRACK_RACE][] =
{
	{-1403.1183, -186.6745, 1043.1227, 6.9041},
	{-1399.1628, -186.5082, 1043.1238, 4.2384},
	{-1394.8102, -186.3568, 1043.1260, 4.9388},
	{-1402.3909, -195.6464, 1043.0277, 4.6080},
	{-1398.5103, -195.5055, 1043.0313, 1.8762},
	{-1394.0662, -195.7233, 1043.0330, 3.3594},
	{-1401.7980, -204.9406, 1042.9889, 1.9933},
	{-1398.2251, -204.7869, 1042.9940, 0.8310},
	{-1393.6208, -205.1537, 1042.9937, 0.8247}
};

// Max players
static gPlayers[MAX_PLAYER_8TRACK_RACE] = {INVALID_PLAYER_ID, ...};

// Checkpoints
static Float:gCheckpoint[][] =
{
	{-1530.2100, -219.9608, 1050.5674},
	{-1401.3370, -237.8412, 1050.9252},
	{-1265.0635, -215.8522, 1050.5961},
	{-1398.2631, -196.2943, 1043.0255}
};

//------------------------------------------------------------------------------

IsPlayerIn8Track(playerid)
	return (gPState[playerid] != 0);

//------------------------------------------------------------------------------

hook OnGameModeInit()
{
	CreateDynamicPickup(2993, 1, 2695.6104, -1704.6708, 11.0, 0, 0, -1, MAX_PICKUP_RANGE);
	CreateDynamic3DTextLabel("Corrida: 8-Track", 0xFFFFFFFF, 2695.6104, -1704.6708, 11.8438, MAX_TEXT3D_RANGE, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
}

//------------------------------------------------------------------------------

hook OnPlayerPickUpDynPickup(playerid, pickupid)
{
	if(IsPlayerInRangeOfPoint(playerid, 2.0, 2695.6104, -1704.6708, 11.8438))
	{
		if(gStarted)
		{
			SendClientMessage(playerid, -1, "* A {FFA050}corrida já foi iniciada{FFFFFF}, você ficará de espectador até o termino dela.");
			SendClientMessage(playerid, -1, "* Para sair pressione {FFA050}F{FFFFFF}.");
			SetPlayerInterior(playerid, 7);
			SetPlayerPos(playerid, -1405.7427, -260.4151, 1043.6563);
			SetPlayerCameraPos(playerid, -1357.6572, -206.2773, 1070.7604);
			SetPlayerCameraLookAt(playerid, -1356.6584, -206.2695, 1070.7957);

			gPState[playerid] = TRACK_STATE_SPECTATING;
		}
		else
		{
			new modelid[] = {494, 502, 503};

			new freePos = gTrackPlayerPoolSize;
			for(new i = 0; i < MAX_PLAYER_8TRACK_RACE; i++)
			{
				if(gPlayers[i] == INVALID_PLAYER_ID)
				{
					freePos = i;
					gPlayers[i] = playerid;
					break;
				}
			}

			gPVehicleID[playerid] = CreateVehicle(modelid[random(sizeof(modelid))], gVehiclePositions[freePos][0], gVehiclePositions[freePos][1], gVehiclePositions[freePos][2], gVehiclePositions[freePos][3], random(126), random(126), -1);
			LinkVehicleToInterior(gPVehicleID[playerid], 7);
			SetPlayerInterior(playerid, 7);
			PutPlayerInVehicle(playerid, gPVehicleID[playerid], 0);
			DisableRemoteVehicleCollisions(playerid, true);

			gPState[playerid] = TRACK_STATE_RACING;
			gTrackPlayerPoolSize++;

			defer StartRaceAutoTrack();

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

timer StartRaceAutoTrack[60000]()
{
	if(!gStarted && gTrackPlayerPoolSize > 0)
		StartRace();
}

//------------------------------------------------------------------------------

static StartRace()
{
	gStarted = true;
	gCountdown = 10;
	defer RaceCountdownTrack();
	foreach(new i: Player)
	{
		if(IsPlayerIn8Track(i))
		{
			SendClientMessage(i, -1, "* A corrida irá começar em {FFA050}10{FFFFFF}, liguem os motores.");
			SetVehicleFuel(GetPlayerVehicleID(i), 100.0);
			TogglePlayerControllable(i, false);
		}
	}
}

//------------------------------------------------------------------------------

timer RaceCountdownTrack[1000]()
{
	if(gCountdown > 0)
	{
		new str[6];
		format(str, sizeof(str), "~w~%i", gCountdown);
		foreach(new i: Player)
		{
			if(IsPlayerIn8Track(i))
			{
				GameTextForPlayer(i, str, 1000, 3);
				PlayerPlaySound(i, 1056, 0.0, 0.0, 0.0);
			}
		}
		defer RaceCountdownTrack();
		gCountdown--;
	}
	else
	{
		foreach(new i: Player)
		{
			if(IsPlayerIn8Track(i))
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
	if(IsPlayerIn8Track(playerid) && gPState[playerid] == TRACK_STATE_RACING)
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
			SetPlayerCameraPos(playerid, -1357.6572, -206.2773, 1070.7604);
			SetPlayerCameraLookAt(playerid, -1356.6584, -206.2695, 1070.7957);
			gPState[playerid] = TRACK_STATE_SPECTATING;

			new message[68 + MAX_PLAYER_NAME];
			format(message, sizeof(message), "* {FFA050}%s{FFFFFF} terminou a corrida em {FFA050}%iº{FFFFFF}.", GetPlayerNamef(playerid), gFinishPosition);
			foreach(new i: Player)
			{
				if(IsPlayerIn8Track(i))
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
		if(IsPlayerIn8Track(i))
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
	if(gPState[playerid] == TRACK_STATE_RACING)
	{
		DestroyVehicle(gPVehicleID[playerid]);
		gPVehicleID[playerid] = INVALID_VEHICLE_ID;
		DisableRemoteVehicleCollisions(playerid, false);

		new message[23 + MAX_PLAYER_NAME];
		format(message, sizeof(message), "* %s saiu da corrida.", GetPlayerNamef(playerid));

		foreach(new i: Player)
			if(IsPlayerIn8Track(i))
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
	else if(gPState[playerid] == TRACK_STATE_SPECTATING)
		gPState[playerid] = 0;
}

//------------------------------------------------------------------------------

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(gPState[playerid] == TRACK_STATE_RACING && newstate == PLAYER_STATE_ONFOOT)
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
			if(IsPlayerIn8Track(i) && i != playerid)
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
	if((newkeys == KEY_SECONDARY_ATTACK) && gPState[playerid] == TRACK_STATE_SPECTATING)
	{
		gPState[playerid] = 0;
		SetPlayerInterior(playerid, 0);
		SetPlayerPos(playerid, 2692.6216 + random(5), -1700.3165 + random(5), 10.3789);
		SetPlayerFacingAngle(playerid, 34.4769);
		SetCameraBehindPlayer(playerid);
	}
}
