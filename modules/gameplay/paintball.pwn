/* *************************************************************************** *
*  Description: Paintball module file.
*
*  Assignment: A script that adds paintball to the server.
*
*           Copyright Paradise Devs 2015.  All rights reserved.
* *************************************************************************** */

#if defined _MODULE_paintball
	#endinput
#endif
#define _MODULE_paintball

#include <YSI\y_hooks>

// constants
#define MAX_PAINTBALL_MAPS	2
#define MAX_PAINTBALL_MODES	3
#define MAX_CAPTURE_POINTS	10

// Paintball Game Modes
enum
{
	PAINTBALL_CAPTURE_FLAG,
	PAINTBALL_TEAMDEATHMATCH,
	PAINTBALL_FREE_FOR_ALL
}

// Paintball Maps
enum
{
	PAINTBALL_RC_BATTLEFIELD,
	PAINTBALL_SHIP
}

// Player states
enum (<<=1)
{
	PAINTBALL_PLAYER_NONE,
	PAINTBALL_PLAYER_SPECTATING,
	PAINTBALL_PLAYER_PLAYING
}

// Checks if a player is inside paintball
new bool:gIsPlayerInPaintBall[MAX_PLAYERS];

// Player state
static gPlayerState[MAX_PLAYERS];

// The map the player is in
new gPlayerPaintBallMap[MAX_PLAYERS];

// The mode the player is in
new gPlayerPaintBallMode[MAX_PLAYERS];

// The team the player is in
new gPlayerPaintBallTeam[MAX_PLAYERS];

// Checks if the player is seeing dialog
static bool:gIsDialogVisible[MAX_PLAYERS];

// Player death time
new gPlayerDeathTime[MAX_PLAYERS];

// Checks if the player has the flag
new bool:gPlayerHasTheFlag[MAX_PLAYERS];

// Player class
static gPlayerPaintballClass[MAX_PLAYERS];

// Capture flag player spawn positions
new Float:gCaptureSpawnPositions[][][] =
{
	// RC Battlefield
	{
		{-975.9354,		1089.7307,	1344.9690,	89.9275},// Team 1
		{-1131.5193,	1028.9076,	1345.7299,	272.6025}// Team 2
	}
};

// Capture flag, flag positions
new Float:gCaptureFlagPositions[][][] =
{
	// RC Battlefield
	{
		{-1052.9255, 1064.2675, 1343.5070},// Center of map
		{-1045.6592, 1099.6080, 1345.1169},
		{-1059.9111, 1019.8990, 1345.0715}
	}
};


// Amount of players in paintball
new gPaintBallPlayerPool[MAX_PAINTBALL_MAPS][MAX_PAINTBALL_MODES];

// Paintball state
new bool:gPaintBallStarted[MAX_PAINTBALL_MAPS][MAX_PAINTBALL_MODES];

// Paintball team players
new gPaintBallTeamPlayers[MAX_PAINTBALL_MAPS][MAX_PAINTBALL_MODES][2];

// Flag pickupid
new gPaintBallFlagID[MAX_PAINTBALL_MAPS];

// Pickupid for capture flag
new gPaintballBasePickup[MAX_PAINTBALL_MAPS][2];

// Pickup for class changing
new gPaintballClassPickup[MAX_PAINTBALL_MAPS][4];

// Capture flag team points
new gPaintBallCapturePoints[MAX_PAINTBALL_MAPS][2];

// Capture flag textdraw
new Text:gTDCapFlag[MAX_PAINTBALL_MAPS][5];

// Get how many players are in a specific map
GetPaintBallPlayers(map)
{
	switch(map)
	{
		case PAINTBALL_RC_BATTLEFIELD:
			return gPaintBallPlayerPool[PAINTBALL_RC_BATTLEFIELD][PAINTBALL_CAPTURE_FLAG] + gPaintBallPlayerPool[PAINTBALL_RC_BATTLEFIELD][PAINTBALL_TEAMDEATHMATCH] + gPaintBallPlayerPool[PAINTBALL_RC_BATTLEFIELD][PAINTBALL_FREE_FOR_ALL];
		case PAINTBALL_SHIP:
			return gPaintBallPlayerPool[PAINTBALL_SHIP][PAINTBALL_CAPTURE_FLAG] + gPaintBallPlayerPool[PAINTBALL_SHIP][PAINTBALL_TEAMDEATHMATCH] + gPaintBallPlayerPool[PAINTBALL_SHIP][PAINTBALL_FREE_FOR_ALL];
	}
	return 0;
}

// Checks if a player is in paintball
IsPlayerInPaintball(playerid)
	return gIsPlayerInPaintBall[playerid];

// Created capture flag textdraw
CreateCaptureFlagTextdraw(map)
{
	switch (map) {
		case PAINTBALL_RC_BATTLEFIELD: {
			gTDCapFlag[PAINTBALL_RC_BATTLEFIELD][0] = TextDrawCreate(16.666656, 146.029556, "box");
			TextDrawLetterSize(gTDCapFlag[PAINTBALL_RC_BATTLEFIELD][0], 0.000000, 5.400003);
			TextDrawTextSize(gTDCapFlag[PAINTBALL_RC_BATTLEFIELD][0], 65.333297, 0.000000);
			TextDrawAlignment(gTDCapFlag[PAINTBALL_RC_BATTLEFIELD][0], 1);
			TextDrawColor(gTDCapFlag[PAINTBALL_RC_BATTLEFIELD][0], 97);
			TextDrawUseBox(gTDCapFlag[PAINTBALL_RC_BATTLEFIELD][0], 1);
			TextDrawBoxColor(gTDCapFlag[PAINTBALL_RC_BATTLEFIELD][0], 97);
			TextDrawSetShadow(gTDCapFlag[PAINTBALL_RC_BATTLEFIELD][0], 0);
			TextDrawSetOutline(gTDCapFlag[PAINTBALL_RC_BATTLEFIELD][0], 0);
			TextDrawBackgroundColor(gTDCapFlag[PAINTBALL_RC_BATTLEFIELD][0], 255);
			TextDrawFont(gTDCapFlag[PAINTBALL_RC_BATTLEFIELD][0], 1);
			TextDrawSetProportional(gTDCapFlag[PAINTBALL_RC_BATTLEFIELD][0], 1);
			TextDrawSetShadow(gTDCapFlag[PAINTBALL_RC_BATTLEFIELD][0], 0);

			gTDCapFlag[PAINTBALL_RC_BATTLEFIELD][1] = TextDrawCreate(19.666627, 161.756027, "hud:radar_police");
			TextDrawLetterSize(gTDCapFlag[PAINTBALL_RC_BATTLEFIELD][1], 0.000000, 0.000000);
			TextDrawTextSize(gTDCapFlag[PAINTBALL_RC_BATTLEFIELD][1], 7.666668, 8.281496);
			TextDrawAlignment(gTDCapFlag[PAINTBALL_RC_BATTLEFIELD][1], 1);
			TextDrawColor(gTDCapFlag[PAINTBALL_RC_BATTLEFIELD][1], -1);
			TextDrawSetShadow(gTDCapFlag[PAINTBALL_RC_BATTLEFIELD][1], 0);
			TextDrawSetOutline(gTDCapFlag[PAINTBALL_RC_BATTLEFIELD][1], 0);
			TextDrawBackgroundColor(gTDCapFlag[PAINTBALL_RC_BATTLEFIELD][1], 255);
			TextDrawFont(gTDCapFlag[PAINTBALL_RC_BATTLEFIELD][1], 4);
			TextDrawSetProportional(gTDCapFlag[PAINTBALL_RC_BATTLEFIELD][1], 0);
			TextDrawSetShadow(gTDCapFlag[PAINTBALL_RC_BATTLEFIELD][1], 0);

			gTDCapFlag[PAINTBALL_RC_BATTLEFIELD][2] = TextDrawCreate(43.233352, 158.059249, "00");
			TextDrawLetterSize(gTDCapFlag[PAINTBALL_RC_BATTLEFIELD][2], 0.190001, 1.490000);
			TextDrawAlignment(gTDCapFlag[PAINTBALL_RC_BATTLEFIELD][2], 1);
			TextDrawColor(gTDCapFlag[PAINTBALL_RC_BATTLEFIELD][2], -1);
			TextDrawSetShadow(gTDCapFlag[PAINTBALL_RC_BATTLEFIELD][2], 0);
			TextDrawSetOutline(gTDCapFlag[PAINTBALL_RC_BATTLEFIELD][2], 1);
			TextDrawBackgroundColor(gTDCapFlag[PAINTBALL_RC_BATTLEFIELD][2], 255);
			TextDrawFont(gTDCapFlag[PAINTBALL_RC_BATTLEFIELD][2], 2);
			TextDrawSetProportional(gTDCapFlag[PAINTBALL_RC_BATTLEFIELD][2], 1);
			TextDrawSetShadow(gTDCapFlag[PAINTBALL_RC_BATTLEFIELD][2], 0);

			gTDCapFlag[PAINTBALL_RC_BATTLEFIELD][3] = TextDrawCreate(19.666627, 174.456802, "hud:radar_fire");
			TextDrawLetterSize(gTDCapFlag[PAINTBALL_RC_BATTLEFIELD][3], 0.000000, 0.000000);
			TextDrawTextSize(gTDCapFlag[PAINTBALL_RC_BATTLEFIELD][3], 7.666668, 8.281496);
			TextDrawAlignment(gTDCapFlag[PAINTBALL_RC_BATTLEFIELD][3], 1);
			TextDrawColor(gTDCapFlag[PAINTBALL_RC_BATTLEFIELD][3], -1);
			TextDrawSetShadow(gTDCapFlag[PAINTBALL_RC_BATTLEFIELD][3], 0);
			TextDrawSetOutline(gTDCapFlag[PAINTBALL_RC_BATTLEFIELD][3], 0);
			TextDrawBackgroundColor(gTDCapFlag[PAINTBALL_RC_BATTLEFIELD][3], 255);
			TextDrawFont(gTDCapFlag[PAINTBALL_RC_BATTLEFIELD][3], 4);
			TextDrawSetProportional(gTDCapFlag[PAINTBALL_RC_BATTLEFIELD][3], 0);
			TextDrawSetShadow(gTDCapFlag[PAINTBALL_RC_BATTLEFIELD][3], 0);

			gTDCapFlag[PAINTBALL_RC_BATTLEFIELD][4] = TextDrawCreate(42.900020, 169.759963, "00");
			TextDrawLetterSize(gTDCapFlag[PAINTBALL_RC_BATTLEFIELD][4], 0.190001, 1.490000);
			TextDrawAlignment(gTDCapFlag[PAINTBALL_RC_BATTLEFIELD][4], 1);
			TextDrawColor(gTDCapFlag[PAINTBALL_RC_BATTLEFIELD][4], -1);
			TextDrawSetShadow(gTDCapFlag[PAINTBALL_RC_BATTLEFIELD][4], 0);
			TextDrawSetOutline(gTDCapFlag[PAINTBALL_RC_BATTLEFIELD][4], 1);
			TextDrawBackgroundColor(gTDCapFlag[PAINTBALL_RC_BATTLEFIELD][4], 255);
			TextDrawFont(gTDCapFlag[PAINTBALL_RC_BATTLEFIELD][4], 2);
			TextDrawSetProportional(gTDCapFlag[PAINTBALL_RC_BATTLEFIELD][4], 1);
			TextDrawSetShadow(gTDCapFlag[PAINTBALL_RC_BATTLEFIELD][4], 0);
		}
	}
}

// Created capture flag textdraw
DestroyCaptureFlagTextdraw(map)
{
	switch (map)
	{
		case PAINTBALL_RC_BATTLEFIELD:
		{
			for(new i = 0; i < sizeof(gTDCapFlag[]); i++)
				TextDrawDestroy(gTDCapFlag[PAINTBALL_RC_BATTLEFIELD][i]);
		}
	}
}

// Sends a message to everyone who is in paintball
SendPaintBallMessage(color, message[], map, mode, sound = true)
{
	foreach(new i: Player)
	{
		if(gPlayerPaintBallMap[i] == map && gPlayerPaintBallMode[i] == mode && gIsPlayerInPaintBall[i])
		{
			SendClientMessage(i, color, message);
			if(sound) PlayerPlaySound(i, 1083, 0.0, 0.0, 0.0);
		}
	}
}

// Show player capture flag hud
ShowPlayerCaptureFlagTextdraw(playerid, map)
{
	switch(map)
	{
		case PAINTBALL_RC_BATTLEFIELD:
			for(new i = 0; i < sizeof(gTDCapFlag[]); i++)
				TextDrawShowForPlayer(playerid, gTDCapFlag[PAINTBALL_RC_BATTLEFIELD][i]);
	}
}

// Hide player capture flag hud
HidePlayerCaptureFlagTextdraw(playerid, map)
{
	switch(map)
	{
		case PAINTBALL_RC_BATTLEFIELD:
			for(new i = 0; i < sizeof(gTDCapFlag[]); i++)
				TextDrawHideForPlayer(playerid, gTDCapFlag[PAINTBALL_RC_BATTLEFIELD][i]);
	}
}

hook OnGameModeInit()
{
	CreateDynamicPickup(1239, 1, 560.8210,	-1506.7863,	14.5440, 0, 0, -1, MAX_PICKUP_RANGE);
	CreateDynamic3DTextLabel("Paintball", 0xFFFFFFFF, 560.8210,	-1506.7863,	14.5440, MAX_TEXT3D_RANGE, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);

	/* Maps
		RC Battlefield
	*/

	// Flag
	new rand = random(sizeof(gCaptureFlagPositions[]));
	gPaintBallFlagID[PAINTBALL_RC_BATTLEFIELD] = CreateDynamicPickup(2993, 1, gCaptureFlagPositions[PAINTBALL_RC_BATTLEFIELD][rand][0], gCaptureFlagPositions[PAINTBALL_RC_BATTLEFIELD][rand][1], gCaptureFlagPositions[PAINTBALL_RC_BATTLEFIELD][rand][2], (PAINTBALL_RC_BATTLEFIELD + PAINTBALL_CAPTURE_FLAG), 10, -1, MAX_PICKUP_RANGE);

	// Base pickup
	gPaintballBasePickup[PAINTBALL_RC_BATTLEFIELD][0] = CreateDynamicPickup(1579, 1, -974.6151, 1061.0194, 1345.6774, (PAINTBALL_RC_BATTLEFIELD + PAINTBALL_CAPTURE_FLAG), 10, -1, MAX_PICKUP_RANGE); // Blue
	gPaintballBasePickup[PAINTBALL_RC_BATTLEFIELD][1] = CreateDynamicPickup(1580, 1, -1130.3920, 1057.8748, 1346.4141, (PAINTBALL_RC_BATTLEFIELD + PAINTBALL_CAPTURE_FLAG), 10, -1, MAX_PICKUP_RANGE);// Red

	// Class
	gPaintballClassPickup[PAINTBALL_RC_BATTLEFIELD][0] = CreateDynamicPickup(356, 1, -980.9835, 1091.6716, 1344.9453, (PAINTBALL_RC_BATTLEFIELD + PAINTBALL_CAPTURE_FLAG), 10, -1, MAX_PICKUP_RANGE); // Team Blue Assault
	CreateDynamic3DTextLabel("Classe: Assalto", 0xFFFFFFFF, -980.9835, 1091.6716, 1344.9453, MAX_TEXT3D_RANGE, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, (PAINTBALL_RC_BATTLEFIELD + PAINTBALL_CAPTURE_FLAG));
	gPaintballClassPickup[PAINTBALL_RC_BATTLEFIELD][1] = CreateDynamicPickup(358, 1, -980.9835, 1087.3135, 1344.9480, (PAINTBALL_RC_BATTLEFIELD + PAINTBALL_CAPTURE_FLAG), 10, -1, MAX_PICKUP_RANGE); // Team Blue Marksman
	CreateDynamic3DTextLabel("Classe: Atirador", 0xFFFFFFFF, -980.9835, 1087.3135, 1344.9480, MAX_TEXT3D_RANGE, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, (PAINTBALL_RC_BATTLEFIELD + PAINTBALL_CAPTURE_FLAG));

	gPaintballClassPickup[PAINTBALL_RC_BATTLEFIELD][2] = CreateDynamicPickup(356, 1, -1124.5203, 1027.3217, 1345.6896, (PAINTBALL_RC_BATTLEFIELD + PAINTBALL_CAPTURE_FLAG), 10, -1, MAX_PICKUP_RANGE); // Team Red Assault
	CreateDynamic3DTextLabel("Classe: Assalto", 0xFFFFFFFF, -1124.5203, 1027.3217, 1345.6896, MAX_TEXT3D_RANGE, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, (PAINTBALL_RC_BATTLEFIELD + PAINTBALL_CAPTURE_FLAG));
	gPaintballClassPickup[PAINTBALL_RC_BATTLEFIELD][3] = CreateDynamicPickup(358, 1, -1124.5203, 1031.1110, 1345.6837, (PAINTBALL_RC_BATTLEFIELD + PAINTBALL_CAPTURE_FLAG), 10, -1, MAX_PICKUP_RANGE); // Team Red Marksman
	CreateDynamic3DTextLabel("Classe: Atirador", 0xFFFFFFFF, -1124.5203, 1031.1110, 1345.6837, MAX_TEXT3D_RANGE, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, (PAINTBALL_RC_BATTLEFIELD + PAINTBALL_CAPTURE_FLAG));
}

hook OnPlayerPickUpDynPickup(playerid, pickupid)
{
	if(IsPlayerInRangeOfPoint(playerid, 2.0, 560.8210,	-1506.7863,	14.5440) && !gIsDialogVisible[playerid] && !gIsPlayerInPaintBall[playerid])
	{
		new info[52];
		format(info, sizeof(info), "Mapa\tJogadores\nRC Battlefield\t%i\nNavio\t%i", GetPaintBallPlayers(PAINTBALL_RC_BATTLEFIELD), GetPaintBallPlayers(PAINTBALL_SHIP));
		ShowPlayerDialog(playerid, DIALOG_PAINTBALL, DIALOG_STYLE_TABLIST_HEADERS, "Paintball", info, "Entrar", "Cancelar");
		PlaySelectSound(playerid);
		gIsDialogVisible[playerid] = true;
	}
	else if(pickupid == gPaintBallFlagID[PAINTBALL_RC_BATTLEFIELD] && gIsPlayerInPaintBall[playerid])
	{
		DestroyDynamicPickup(gPaintBallFlagID[PAINTBALL_RC_BATTLEFIELD]);
		SetPlayerAttachedObject(playerid, 0, 2993, 1, 0.0, 0.0, 0.0, 0.0, 90.0);
		gPlayerHasTheFlag[playerid] = true;

		new message[39 + MAX_PLAYER_NAME];
		if(gPlayerPaintBallTeam[playerid] == 0)
			format(message, sizeof(message), "* {0b80ec}%s{FFFFFF} pegou a bandeira!", GetPlayerNamef(playerid));
		else
			format(message, sizeof(message), "* {991515}%s{FFFFFF} pegou a bandeira!", GetPlayerNamef(playerid));
		SendPaintBallMessage(0xFFFFFFFF, message, PAINTBALL_RC_BATTLEFIELD, PAINTBALL_CAPTURE_FLAG);
	}
	else if(gPaintballBasePickup[PAINTBALL_RC_BATTLEFIELD][0] == pickupid && !gPlayerPaintBallTeam[playerid] && gPlayerHasTheFlag[playerid])
	{
		new message[42 + MAX_PLAYER_NAME];
		if(gPlayerPaintBallTeam[playerid] == 0)
			format(message, sizeof(message), "* {0b80ec}%s{FFFFFF} entregou a bandeira!", GetPlayerNamef(playerid));
		else
			format(message, sizeof(message), "* {991515}%s{FFFFFF} entregou a bandeira!", GetPlayerNamef(playerid));
		SendPaintBallMessage(0xFFFFFFFF, message, PAINTBALL_RC_BATTLEFIELD, PAINTBALL_CAPTURE_FLAG);

		gPaintBallCapturePoints[PAINTBALL_RC_BATTLEFIELD][0]++;

		new sTPoints[5];
		format(sTPoints, sizeof(sTPoints), "%02d", gPaintBallCapturePoints[PAINTBALL_RC_BATTLEFIELD][0]);
		TextDrawSetString(gTDCapFlag[PAINTBALL_RC_BATTLEFIELD][2], sTPoints);

		new rand = random(sizeof(gCaptureFlagPositions[]));
		gPaintBallFlagID[PAINTBALL_RC_BATTLEFIELD] = CreateDynamicPickup(2993, 1, gCaptureFlagPositions[PAINTBALL_RC_BATTLEFIELD][rand][0], gCaptureFlagPositions[PAINTBALL_RC_BATTLEFIELD][rand][1], gCaptureFlagPositions[PAINTBALL_RC_BATTLEFIELD][rand][2], (PAINTBALL_RC_BATTLEFIELD + PAINTBALL_CAPTURE_FLAG), 10, -1, MAX_PICKUP_RANGE);

		RemovePlayerAttachedObject(playerid, 0);
		gPlayerHasTheFlag[playerid] = false;

		if(gPaintBallCapturePoints[PAINTBALL_RC_BATTLEFIELD][0] == MAX_CAPTURE_POINTS)
		{
			foreach(new i: Player)
			{
				if(IsPlayerInPaintball(i) && gPlayerPaintBallMap[i] == gPlayerPaintBallMap[playerid] && gPlayerPaintBallMode[i] == gPlayerPaintBallMode[playerid])
				{
					SendClientMessage(i, -1, "* O time {0b80ec}azul{ffffff} venceu!");

					ResetPlayerWeapons(i);
					GivePlayerWeapons(i);

					SetPlayerInterior(i, 0);
					SetPlayerVirtualWorld(i, 0);
					SetPlayerPos(i, 556.5995, -1506.6682, 14.5518);
					SetPlayerFacingAngle(i, 93.8834);
					SetCameraBehindPlayer(i);

					gIsPlayerInPaintBall[i]	= false;
					gPlayerPaintBallMap[i]	= 0;
					gPlayerPaintballClass[i] = 0;
					gPlayerPaintBallMode[i]	= 0;
					gPlayerState[i]			= PAINTBALL_PLAYER_NONE;
					gPlayerPaintBallTeam[i]	= 0;
					gPlayerDeathTime[i]		= 0;
					HidePlayerCaptureFlagTextdraw(i, PAINTBALL_RC_BATTLEFIELD);
				}
			}
			gPaintBallStarted[PAINTBALL_RC_BATTLEFIELD][PAINTBALL_CAPTURE_FLAG] = false;
			gPaintBallCapturePoints[PAINTBALL_RC_BATTLEFIELD][0] = 0;
			gPaintBallCapturePoints[PAINTBALL_RC_BATTLEFIELD][1] = 0;
			gPaintBallTeamPlayers[PAINTBALL_RC_BATTLEFIELD][PAINTBALL_CAPTURE_FLAG][0]  = 0;
			gPaintBallTeamPlayers[PAINTBALL_RC_BATTLEFIELD][PAINTBALL_CAPTURE_FLAG][1]  = 0;
			gPaintBallPlayerPool[PAINTBALL_RC_BATTLEFIELD][PAINTBALL_CAPTURE_FLAG] = 0;
			DestroyCaptureFlagTextdraw(PAINTBALL_RC_BATTLEFIELD);
		}
	}
	else if(gPaintballBasePickup[PAINTBALL_RC_BATTLEFIELD][1] == pickupid && gPlayerPaintBallTeam[playerid] && gPlayerHasTheFlag[playerid])
	{
		new message[42 + MAX_PLAYER_NAME];
		if(gPlayerPaintBallTeam[playerid] == 0)
			format(message, sizeof(message), "* {0b80ec}%s{FFFFFF} entregou a bandeira!", GetPlayerNamef(playerid));
		else
			format(message, sizeof(message), "* {991515}%s{FFFFFF} entregou a bandeira!", GetPlayerNamef(playerid));
		SendPaintBallMessage(0xFFFFFFFF, message, PAINTBALL_RC_BATTLEFIELD, PAINTBALL_CAPTURE_FLAG);

		gPaintBallCapturePoints[PAINTBALL_RC_BATTLEFIELD][1]++;

		new sTPoints[5];
		format(sTPoints, sizeof(sTPoints), "%02d", gPaintBallCapturePoints[PAINTBALL_RC_BATTLEFIELD][1]);
		TextDrawSetString(gTDCapFlag[PAINTBALL_RC_BATTLEFIELD][4], sTPoints);

		new rand = random(sizeof(gCaptureFlagPositions[]));
		gPaintBallFlagID[PAINTBALL_RC_BATTLEFIELD] = CreateDynamicPickup(2993, 1, gCaptureFlagPositions[PAINTBALL_RC_BATTLEFIELD][rand][0], gCaptureFlagPositions[PAINTBALL_RC_BATTLEFIELD][rand][1], gCaptureFlagPositions[PAINTBALL_RC_BATTLEFIELD][rand][2], (PAINTBALL_RC_BATTLEFIELD + PAINTBALL_CAPTURE_FLAG), 10, -1, MAX_PICKUP_RANGE);

		RemovePlayerAttachedObject(playerid, 0);
		gPlayerHasTheFlag[playerid] = false;

		if(gPaintBallCapturePoints[PAINTBALL_RC_BATTLEFIELD][1] == MAX_CAPTURE_POINTS)
		{
			foreach(new i: Player)
			{
				if(IsPlayerInPaintball(i) && gPlayerPaintBallMap[i] == gPlayerPaintBallMap[playerid] && gPlayerPaintBallMode[i] == gPlayerPaintBallMode[playerid])
				{
					SendClientMessage(i, -1, "* O time {991515}vermelho{ffffff} venceu!");

					ResetPlayerWeapons(i);
					GivePlayerWeapons(i);

					SetPlayerInterior(i, 0);
					SetPlayerVirtualWorld(i, 0);
					SetPlayerPos(i, 556.5995, -1506.6682, 14.5518);
					SetPlayerFacingAngle(i, 93.8834);
					SetCameraBehindPlayer(i);

					gIsPlayerInPaintBall[i]	= false;
					gPlayerPaintBallMap[i]	= 0;
					gPlayerPaintballClass[i] = 0;
					gPlayerPaintBallMode[i]	= 0;
					gPlayerState[i]			= PAINTBALL_PLAYER_NONE;
					gPlayerPaintBallTeam[i]	= 0;
					gPlayerDeathTime[i]		= 0;
					HidePlayerCaptureFlagTextdraw(i, PAINTBALL_RC_BATTLEFIELD);
				}
			}
			gPaintBallStarted[PAINTBALL_RC_BATTLEFIELD][PAINTBALL_CAPTURE_FLAG] = false;
			gPaintBallCapturePoints[PAINTBALL_RC_BATTLEFIELD][0] = 0;
			gPaintBallCapturePoints[PAINTBALL_RC_BATTLEFIELD][1] = 0;
			gPaintBallTeamPlayers[PAINTBALL_RC_BATTLEFIELD][PAINTBALL_CAPTURE_FLAG][0]  = 0;
			gPaintBallTeamPlayers[PAINTBALL_RC_BATTLEFIELD][PAINTBALL_CAPTURE_FLAG][1]  = 0;
			gPaintBallPlayerPool[PAINTBALL_RC_BATTLEFIELD][PAINTBALL_CAPTURE_FLAG] = 0;
			DestroyCaptureFlagTextdraw(PAINTBALL_RC_BATTLEFIELD);
		}
	}
	else if(gPaintballClassPickup[PAINTBALL_RC_BATTLEFIELD][0] == pickupid && !gPlayerPaintBallTeam[playerid] && gPlayerPaintballClass[playerid] != 1)
	{
		ResetPlayerWeapons(playerid);
		gPlayerPaintballClass[playerid] = 1;
		GivePlayerWeapon(playerid, 24, 99999);
		GivePlayerWeapon(playerid, 29, 99999);
		GivePlayerWeapon(playerid, 31, 99999);
	}
	else if(gPaintballClassPickup[PAINTBALL_RC_BATTLEFIELD][1] == pickupid && !gPlayerPaintBallTeam[playerid] && gPlayerPaintballClass[playerid] != 2)
	{
		ResetPlayerWeapons(playerid);
		gPlayerPaintballClass[playerid] = 2;
		GivePlayerWeapon(playerid, 22, 99999);
		GivePlayerWeapon(playerid, 26, 99999);
		GivePlayerWeapon(playerid, 34, 99999);
	}
	else if(gPaintballClassPickup[PAINTBALL_RC_BATTLEFIELD][2] == pickupid && gPlayerPaintBallTeam[playerid] && gPlayerPaintballClass[playerid] != 1)
	{
		ResetPlayerWeapons(playerid);
		gPlayerPaintballClass[playerid] = 1;
		GivePlayerWeapon(playerid, 24, 99999);
		GivePlayerWeapon(playerid, 29, 99999);
		GivePlayerWeapon(playerid, 31, 99999);
	}
	else if(gPaintballClassPickup[PAINTBALL_RC_BATTLEFIELD][3] == pickupid && gPlayerPaintBallTeam[playerid] && gPlayerPaintballClass[playerid] != 2)
	{
		ResetPlayerWeapons(playerid);
		gPlayerPaintballClass[playerid] = 2;
		GivePlayerWeapon(playerid, 22, 99999);
		GivePlayerWeapon(playerid, 26, 99999);
		GivePlayerWeapon(playerid, 34, 99999);
	}
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		case DIALOG_PAINTBALL:
		{
			if(!response)
			{
				gIsDialogVisible[playerid] = false;
				PlayCancelSound(playerid);
			}
			else
			{
				switch(listitem)
				{
					case 0:
					{
						new info[158];
                        format(info, sizeof(info), "Modo de Jogo\tJogadores\tIniciado\nCapture a Bandeira\t%i\t%s\nTeam DeathMatch\t%i\t%s\nCada um por si\t%i\t%s",
						gPaintBallPlayerPool[PAINTBALL_RC_BATTLEFIELD][PAINTBALL_CAPTURE_FLAG],		(gPaintBallStarted[PAINTBALL_RC_BATTLEFIELD][PAINTBALL_CAPTURE_FLAG]) ? "Sim" : "Não",
                        gPaintBallPlayerPool[PAINTBALL_RC_BATTLEFIELD][PAINTBALL_TEAMDEATHMATCH],	(gPaintBallStarted[PAINTBALL_RC_BATTLEFIELD][PAINTBALL_TEAMDEATHMATCH]) ? "Sim" : "Não",
                        gPaintBallPlayerPool[PAINTBALL_RC_BATTLEFIELD][PAINTBALL_FREE_FOR_ALL],		(gPaintBallStarted[PAINTBALL_RC_BATTLEFIELD][PAINTBALL_FREE_FOR_ALL]) ? "Sim" : "Não");
                        ShowPlayerDialog(playerid, DIALOG_PAINTBALL_RC, DIALOG_STYLE_TABLIST_HEADERS, "Paintball -> RC Battlefield", info, "Entrar", "Voltar");
						PlaySelectSound(playerid);
                    }
                    case 1:
					{
						PlayCancelSound(playerid);
						SendClientMessage(playerid, 0x9e2b00ff, "* Mapa em desenvolvimento.");
						gIsDialogVisible[playerid] = false;
					}
                }
			}
			return -2;
		}
		case DIALOG_PAINTBALL_RC:
		{
			if(!response)
			{
				new info[52];
				format(info, sizeof(info), "Mapa\tJogadores\nRC Battlefield\t%i\nNavio\t%i", GetPaintBallPlayers(PAINTBALL_RC_BATTLEFIELD), GetPaintBallPlayers(PAINTBALL_SHIP));
				ShowPlayerDialog(playerid, DIALOG_PAINTBALL, DIALOG_STYLE_TABLIST_HEADERS, "Paintball", info, "Entrar", "Cancelar");
				PlayCancelSound(playerid);
			}
			else
			{
				switch(listitem)
				{
					case 0:
					{
						new message[53 + MAX_PLAYER_NAME];
						format(message, sizeof(message), "* {d0ec25}%s{ffffff} entrou na partida de paintball.", GetPlayerNamef(playerid));
						foreach(new i: Player)
							if(IsPlayerInPaintball(i) && gPlayerPaintBallMap[i] == PAINTBALL_RC_BATTLEFIELD && gPlayerPaintBallMode[i] == PAINTBALL_CAPTURE_FLAG && i != playerid)
								SendClientMessage(i, -1, message);

						if(gPaintBallPlayerPool[PAINTBALL_RC_BATTLEFIELD][PAINTBALL_CAPTURE_FLAG] == 1)
						{
							gPaintBallStarted[PAINTBALL_RC_BATTLEFIELD][PAINTBALL_CAPTURE_FLAG] = true;
							foreach(new i: Player)
							{
								if(IsPlayerInPaintball(i) && gPlayerPaintBallMap[i] == PAINTBALL_RC_BATTLEFIELD && gPlayerPaintBallMode[i] == PAINTBALL_CAPTURE_FLAG)
								{
									TogglePlayerControllable(i, true);
									SendClientMessage(i, -1, "* A partida de paintball {d0ec25}começou{ffffff}!");
								}
							}
						}

						if(!gPaintBallStarted[PAINTBALL_RC_BATTLEFIELD][PAINTBALL_CAPTURE_FLAG])
						{
							TogglePlayerControllable(playerid, false);
							SendClientMessage(playerid, -1, "* Aguardando mais jogadores, aguarde...");
						}

						gPlayerState[playerid] |= PAINTBALL_PLAYER_PLAYING;
						if(gPaintBallTeamPlayers[PAINTBALL_RC_BATTLEFIELD][PAINTBALL_CAPTURE_FLAG][0] > gPaintBallTeamPlayers[PAINTBALL_RC_BATTLEFIELD][PAINTBALL_CAPTURE_FLAG][1])
						{
							gPaintBallTeamPlayers[PAINTBALL_RC_BATTLEFIELD][PAINTBALL_CAPTURE_FLAG][1]++;
							gPlayerPaintBallTeam[playerid] = 1;
						}
						else
						{
							gPaintBallTeamPlayers[PAINTBALL_RC_BATTLEFIELD][PAINTBALL_CAPTURE_FLAG][0]++;
							gPlayerPaintBallTeam[playerid] = 0;
						}

						SendClientMessage(playerid, 0xFFFFFFFF, "* Para sair da partida, use {d0ec25}/sairpaintball{FFFFFF}.");
						SetPlayerInterior(playerid, 10);
						SetPlayerVirtualWorld(playerid, PAINTBALL_RC_BATTLEFIELD + PAINTBALL_CAPTURE_FLAG);
						SetPlayerPos(playerid, gCaptureSpawnPositions[PAINTBALL_RC_BATTLEFIELD][gPlayerPaintBallTeam[playerid]][0], gCaptureSpawnPositions[PAINTBALL_RC_BATTLEFIELD][gPlayerPaintBallTeam[playerid]][1], gCaptureSpawnPositions[PAINTBALL_RC_BATTLEFIELD][gPlayerPaintBallTeam[playerid]][2]);
						SetPlayerFacingAngle(playerid, gCaptureSpawnPositions[PAINTBALL_RC_BATTLEFIELD][gPlayerPaintBallTeam[playerid]][3]);
						SetCameraBehindPlayer(playerid);

						if(gPaintBallPlayerPool[PAINTBALL_RC_BATTLEFIELD][PAINTBALL_CAPTURE_FLAG] == 0)
							CreateCaptureFlagTextdraw(PAINTBALL_RC_BATTLEFIELD);

						gPaintBallPlayerPool[PAINTBALL_RC_BATTLEFIELD][PAINTBALL_CAPTURE_FLAG]++;
						gPlayerPaintBallMap[playerid] = PAINTBALL_RC_BATTLEFIELD;
						gPlayerPaintBallMode[playerid] = PAINTBALL_CAPTURE_FLAG;
						gIsPlayerInPaintBall[playerid] = true;
						gIsDialogVisible[playerid] = false;
						ShowPlayerCaptureFlagTextdraw(playerid, PAINTBALL_RC_BATTLEFIELD);
						StorePlayerHealth(playerid);
						SetPlayerHealth(playerid, 100.0);
						defer OnPlayerPaintballUpdate(playerid);
					}
					case 1, 2:
					{
						PlayCancelSound(playerid);
						SendClientMessage(playerid, 0x9e2b00ff, "* Modo em desenvolvimento.");
						gIsDialogVisible[playerid] = false;
					}
				}
			}
		}
	}
	return 1;
}

hook OnPlayerDeath(playerid, killerid, reason)
{
	if(IsPlayerInPaintball(playerid))
	{
		if(gPlayerPaintBallMode[playerid] == PAINTBALL_CAPTURE_FLAG)
		{
			if(gPlayerHasTheFlag[playerid])
			{
				new Float:x, Float:y, Float:z;
				GetPlayerPos(playerid, x, y, z);
				switch (gPlayerPaintBallMode[playerid])
				{
					case PAINTBALL_RC_BATTLEFIELD:
						gPaintBallFlagID[PAINTBALL_RC_BATTLEFIELD] = CreateDynamicPickup(2993, 1, x, y, z, (PAINTBALL_RC_BATTLEFIELD + PAINTBALL_CAPTURE_FLAG), 10, -1, MAX_PICKUP_RANGE);
				}
				RemovePlayerAttachedObject(playerid, 0);
				gPlayerHasTheFlag[playerid] = false;

				new message[42 + MAX_PLAYER_NAME];
				if(gPlayerPaintBallTeam[playerid] == 0)
					format(message, sizeof(message), "* {0b80ec}%s{FFFFFF} derrubou a bandeira!", GetPlayerNamef(playerid));
				else
					format(message, sizeof(message), "* {991515}%s{FFFFFF} derrubou a bandeira!", GetPlayerNamef(playerid));
				SendPaintBallMessage(0xFFFFFFFF, message, PAINTBALL_RC_BATTLEFIELD, PAINTBALL_CAPTURE_FLAG);
			}
		}
		gPlayerPaintballClass[playerid] = 0;
	}
}

hook OnPlayerDisconnect(playerid, reason)
{
	if(IsPlayerInPaintball(playerid))
	{
		switch (gPlayerPaintBallMap[playerid])
		{
			case PAINTBALL_RC_BATTLEFIELD:
			{
				switch (gPlayerPaintBallMode[playerid])
				{
					case PAINTBALL_CAPTURE_FLAG:
					{
						gPaintBallTeamPlayers[PAINTBALL_RC_BATTLEFIELD][PAINTBALL_CAPTURE_FLAG][gPlayerPaintBallTeam[playerid]]--;
						gPaintBallPlayerPool[PAINTBALL_RC_BATTLEFIELD][PAINTBALL_CAPTURE_FLAG]--;
						HidePlayerCaptureFlagTextdraw(playerid, PAINTBALL_RC_BATTLEFIELD);
						if(gPaintBallPlayerPool[PAINTBALL_RC_BATTLEFIELD][PAINTBALL_CAPTURE_FLAG] == 0)
						{
							gPaintBallCapturePoints[PAINTBALL_RC_BATTLEFIELD][0] = 0;
							gPaintBallCapturePoints[PAINTBALL_RC_BATTLEFIELD][1] = 0;
							DestroyCaptureFlagTextdraw(PAINTBALL_RC_BATTLEFIELD);
						}
					}
				}
			}
		}

		gIsPlayerInPaintBall[playerid]	= false;
		gPlayerPaintBallMap[playerid]	= 0;
		gPlayerPaintballClass[playerid] = 0;
		gPlayerPaintBallMode[playerid]	= 0;
		gPlayerState[playerid]			= PAINTBALL_PLAYER_NONE;
		gPlayerPaintBallTeam[playerid]	= 0;
		gPlayerDeathTime[playerid]		= 0;
		if(gPlayerHasTheFlag[playerid])
		{
			new Float:x, Float:y, Float:z;
			GetPlayerPos(playerid, x, y, z);
			switch (gPlayerPaintBallMode[playerid])
			{
				case PAINTBALL_RC_BATTLEFIELD:
					gPaintBallFlagID[PAINTBALL_RC_BATTLEFIELD] = CreateDynamicPickup(2993, 1, x, y, z, (PAINTBALL_RC_BATTLEFIELD + PAINTBALL_CAPTURE_FLAG), 10, -1, MAX_PICKUP_RANGE);
			}
			RemovePlayerAttachedObject(playerid, 0);
			gPlayerHasTheFlag[playerid]		= false;
		}
	}
}

hook OnPlayerSpawn(playerid)
{
	if(IsPlayerNPC(playerid))
        return 1;

	if(IsPlayerInPaintball(playerid))
	{
		switch(gPlayerPaintBallMap[playerid])
		{
			case PAINTBALL_RC_BATTLEFIELD:
			{
				switch(gPlayerPaintBallMode[playerid])
				{
					case PAINTBALL_CAPTURE_FLAG:
					{
						SetPlayerInterior(playerid, 10);
						SetPlayerVirtualWorld(playerid, (PAINTBALL_RC_BATTLEFIELD + PAINTBALL_CAPTURE_FLAG));
						SetPlayerPos(playerid, gCaptureSpawnPositions[PAINTBALL_RC_BATTLEFIELD][gPlayerPaintBallTeam[playerid]][0], gCaptureSpawnPositions[PAINTBALL_RC_BATTLEFIELD][gPlayerPaintBallTeam[playerid]][1], gCaptureSpawnPositions[PAINTBALL_RC_BATTLEFIELD][gPlayerPaintBallTeam[playerid]][2]);
						SetPlayerFacingAngle(playerid, gCaptureSpawnPositions[PAINTBALL_RC_BATTLEFIELD][gPlayerPaintBallTeam[playerid]][3]);
					}
				}
			}
		}
	}
	return 1;
}

timer OnPlayerPaintballUpdate[1000](playerid)
{
	if(IsPlayerInPaintball(playerid))
	{
		switch(gPlayerPaintBallMap[playerid])
		{
			case PAINTBALL_RC_BATTLEFIELD:
			{
				switch(gPlayerPaintBallMode[playerid])
				{
					case PAINTBALL_CAPTURE_FLAG:
					{
						if((gPlayerState[playerid] & PAINTBALL_PLAYER_SPECTATING) && gPlayerDeathTime[playerid] > 0)
						{
							new sGametext[80];
							format(sGametext, sizeof(sGametext), "~n~~n~~n~~n~~n~~n~~n~                                           ~y~~h~%02d", gPlayerDeathTime[playerid]);
							GameTextForPlayer(playerid, sGametext, 1111, 3);
							gPlayerDeathTime[playerid]--;
							if(gPlayerDeathTime[playerid] == 0)
							{
								TogglePlayerSpectating(playerid, false);
							}
						}
					}
				}
			}
		}
		defer OnPlayerPaintballUpdate(playerid);
	}
}

YCMD:sairpaintball(playerid, params[], help)
{
	if(!IsPlayerInPaintball(playerid))
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não está no paintball.");

    switch (gPlayerPaintBallMap[playerid])
	{
		case PAINTBALL_RC_BATTLEFIELD:
		{
			switch (gPlayerPaintBallMode[playerid])
			{
				case PAINTBALL_CAPTURE_FLAG:
				{
					gPaintBallTeamPlayers[PAINTBALL_RC_BATTLEFIELD][PAINTBALL_CAPTURE_FLAG][gPlayerPaintBallTeam[playerid]]--;
					gPlayerPaintBallTeam[playerid] = 0;
					gPaintBallPlayerPool[PAINTBALL_RC_BATTLEFIELD][PAINTBALL_CAPTURE_FLAG]--;
					HidePlayerCaptureFlagTextdraw(playerid, PAINTBALL_RC_BATTLEFIELD);
					if(gPaintBallPlayerPool[PAINTBALL_RC_BATTLEFIELD][PAINTBALL_CAPTURE_FLAG] == 0)
					{
						gPaintBallCapturePoints[PAINTBALL_RC_BATTLEFIELD][0] = 0;
						gPaintBallCapturePoints[PAINTBALL_RC_BATTLEFIELD][1] = 0;
						DestroyCaptureFlagTextdraw(PAINTBALL_RC_BATTLEFIELD);
					}

					if(gPlayerHasTheFlag[playerid])
					{
						new Float:x, Float:y, Float:z;
						GetPlayerPos(playerid, x, y, z);
						gPaintBallFlagID[PAINTBALL_RC_BATTLEFIELD] = CreateDynamicPickup(2993, 1, x, y, z, (PAINTBALL_RC_BATTLEFIELD + PAINTBALL_CAPTURE_FLAG), 10, -1, MAX_PICKUP_RANGE);

						RemovePlayerAttachedObject(playerid, 0);
						gPlayerHasTheFlag[playerid] = false;

						new message[50 + MAX_PLAYER_NAME];
						if(gPlayerPaintBallTeam[playerid] == 0)
							format(message, sizeof(message), "* {0b80ec}%s{FFFFFF} saiu e derrubou a bandeira!", GetPlayerNamef(playerid));
						else
							format(message, sizeof(message), "* {991515}%s{FFFFFF} saiu e derrubou a bandeira!", GetPlayerNamef(playerid));
						SendPaintBallMessage(0xFFFFFFFF, message, PAINTBALL_RC_BATTLEFIELD, PAINTBALL_CAPTURE_FLAG);
					}
				}
			}
		}
	}

	if(gPlayerState[playerid] & PAINTBALL_PLAYER_SPECTATING)
		TogglePlayerSpectating(playerid, false);

	gIsPlayerInPaintBall[playerid]	= false;
	gPlayerPaintBallMap[playerid]	= 0;
	gPlayerPaintBallMode[playerid]	= 0;
	gPlayerState[playerid]			= PAINTBALL_PLAYER_NONE;
	gPlayerDeathTime[playerid]		= 0;

	ResetPlayerWeapons(playerid);
	GivePlayerWeapons(playerid);

    SendClientMessage(playerid, -1, "* Você {d0ec25}saiu{ffffff} do paintball.");
    SetPlayerInterior(playerid, 0);
	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerPos(playerid, 556.5995, -1506.6682, 14.5518);
	SetPlayerFacingAngle(playerid, 93.8834);
	SetPlayerHealth(playerid, playerHealth(playerid));
	TogglePlayerControllable(playerid, true);
	SetCameraBehindPlayer(playerid);
	return 1;
}
