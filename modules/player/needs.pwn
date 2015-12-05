/*******************************************************************************
* FILENAME :        modules/player/needs.pwn
*
* DESCRIPTION :
*       A script that adds player needs to the server.
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

#include <YSI\y_hooks>

//--------------------------------------------------------------------

enum
{
	WARNING_HUNGER,
	WARNING_THIRST,
	WARNING_SLEEP,
	WARNING_ADDICTION,
	WARNING_PET
}
static gPlayerWarningMessage[MAX_PLAYERS][5];
static bool:gpIsSleeping[MAX_PLAYERS];

#define INTERVAL_BETWEEN_WARNING	180000 // 3 minutes

new Float:gfBedPositions[][] =
{
	{2495.25,	-1702.38,	1019.04,	2.52,		3.0}, // The Johnson House
	{245.41,	302.18,		1000.00,	267.27,		1.0}, // Denise's Bedroom
	{270.17,	307.74,		1000.02,	93.39,		2.0}, // Katie's Lovenest
	{1272.36,	-791.97,	1090.68,	174.93,		5.0}, // Madd Dogg's Mansion Bed #1
	{1272.07,	-802.70,	1090.44,	173.70,		5.0}, // Madd Dogg's Mansion Bed #2
	{1272.08,	-806.06,	1090.44,	173.70,		5.0}, // Madd Dogg's Mansion Bed #3
	{1292.22,	-806.18,	1090.47,	2.64,		5.0}, // Madd Dogg's Mansion Bed #4
	{1272.02,	-817.09,	1090.44,	179.05,		5.0}, // Madd Dogg's Mansion Bed #5
	{1271.93,	-820.13,	1090.44,	179.05,		5.0}, // Madd Dogg's Mansion Bed #6
	{1292.29,	-817.02,	1090.68,	0.47,		5.0}, // Madd Dogg's Mansion Bed #7
	{2573.39,	-1281.58,	1066.09,	91.65,		2.0}, // Big Smoke's Crack Palace
	{2335.93,	-1187.38,	1028.64,	269.94,		5.0}, // Burning Desire Building
	{2348.90,	-1175.33,	1028.63,	1.75,		5.0}, // Burning Desire Building #2
	{2335.81,	-1187.29,	1032.65,	275.22,		5.0}, // Burning Desire Building #3
	{2348.96,	-1175.33,	1032.65,	4.21,		5.0}, // Burning Desire Building #4
	{416.41,	2541.63,	10.45,		89.27,		10.0}, // Abandoned AC tower
	{2229.91,	-1106.12,	1051.59,	180.76,		5.0}, // Safe House Group 1
	{2326.51,	-1008.24,	1055.24,	90.52,		9.0}, // Safe House Group 3
	{2262.33,	-1141.29,	1051.32,	266.59,		10.0}, // Safe House Group 4 #1
	{2269.07,	-1134.10,	1051.27,	91.15,		10.0}, // Safe House Group 4 #2
	{2236.06,	-1154.38,	1030.49,	88.93,		15.0}, // Jefferson Motel #1
	{2229.56,	-1161.56,	1030.44,	268.16,		15.0}, // Jefferson Motel #2
	{2246.38,	-1165.11,	1030.49,	271.29,		15.0}, // Jefferson Motel #3
	{2253.08,	-1157.89,	1030.44,	92.40,		15.0}, // Jefferson Motel #4
	{2235.97,	-1165.39,	1030.49,	89.27,		15.0}, // Jefferson Motel #5
	{2229.49,	-1172.65,	1030.44,	265.99,		15.0}, // Jefferson Motel #6
	{2230.98,	-1183.50,	1030.52,	2.16,		15.0}, // Jefferson Motel #7
	{2223.77,	-1176.89,	1030.43,	175.43,		15.0}, // Jefferson Motel #8
	{2204.07,	-1193.76,	1030.52,	177.00,		15.0}, // Jefferson Motel #9
	{2211.51,	-1200.39,	1030.43,	357.17,		15.0}, // Jefferson Motel #10
	{2198.22,	-1178.47,	1030.49,	262.23,		15.0}, // Jefferson Motel #11
	{2204.92,	-1171.12,	1030.44,	88.98,		15.0}, // Jefferson Motel #12
	{2198.29,	-1162.35,	1030.49,	270.37,		15.0}, // Jefferson Motel #13
	{2204.82,	-1155.11,	1030.44,	88.35,		15.0}, // Jefferson Motel #14
	{2188.05,	-1151.67,	1030.49,	90.86,		15.0}, // Jefferson Motel #15
	{2181.42,	-1158.86,	1030.44,	267.26,		15.0}, // Jefferson Motel #16
	{223.81,	1199.63,	1080.96,	176.11,		3.0}, // Burglary House X1 #1
	{234.16,	1206.15,	1085.12,	262.92,		3.0}, // Burglary House X1 #2
	{228.81,	1196.13,	1085.10,	355.02,		3.0}, // Burglary House X1 #3
	{224.14,	1249.32,	1082.77,	265.72,		2.0}, // Burglary House X2
	{233.07,	1289.77,	1082.81,	359.75,		1.0}, // Burglary House X3
	{230.01,	1106.71,	1081.50,	276.08,		5.0}, // Burglary House X4 #1
	{240.47,	1120.76,	1085.51,	89.00,		5.0}, // Burglary House X4 #2
	{243.21,	1106.73,	1085.55,	272.93,		5.0}, // Burglary House X4 #3
	{234.82,	1106.76,	1085.52,	272.01,		5.0}, // Burglary House X4 #4
	{303.80,	1475.42,	1080.97,	88.73,		15.0}, // 4 Burglary Houses
	{290.38,	1473.24,	1081.01,	277.05,		15.0}, // 4 Burglary Houses #2
	{448.09,	515.04,		1002.08,	79.67,		12.0}, // Budget Inn Motel Room
	{455.92,	1404.30,	1084.98,	356.56,		2.0}, // Pair of Buglary Houses #1
	{437.58,	1398.29,	1084.92,	175.16,		2.0}, // Pair of Buglary Houses #2
	{266.60,	1288.36,	1080.99,	90.25,		4.0}, // Burglary Houses X12 #1
	{26.22,		1347.09,	1089.56,	270.75,		10.0}, // Burglary Houses X14
	{227.37,	1149.22,	1083.26,	261.33,		4.0}, // Burglary Houses X13
	{2338.11,	-1136.15,	1054.82,	87.43,		12.0}, // Unused safe house
	{2308.80,	-1141.46,	1055.15,	265.71,		12.0}, // Unused safe house #2
	{345.21,	301.73,		999.93,		265.40,		6.0}, // Millie's Bedroom
	{-275.64,	1448.76,	1089.41,	181.72,		4.0}, // Burglary Houses X15
	{16.43,		1406.27,	1085.15,	178.63,		5.0}, // Burglary Houses X16
	{20.15,		1417.91,	1085.14,	180.53,		5.0}, // Burglary Houses X16 #2
	{140.52,	1386.33,	1084.52,	88.26,		5.0}, // Burglary Houses X17 #1
	{152.81,	1376.59,	1089.05,	80.11,		5.0}, // Burglary Houses X17 #2
	{147.38,	1385.73,	1088.96,	183.20,		5.0}, // Burglary Houses X17 #3
	{135.25,	1385.54,	1089.05,	186.36,		5.0}, // Burglary Houses X17 #4
	{246.97,	1075.48,	1084.82,	91.75,		6.0}, // Burglary Houses X18 #1
	{247.02,	1082.53,	1084.82,	91.75,		6.0}, // Burglary Houses X18 #2
	{238.64,	1083.20,	1088.45,	87.05,		6.0}, // Burglary Houses X18 #3
	{737.48,	1436.98,	1103.43,	175.12,		6.0}, // Fanny Batter's Whore House
	{734.93,	1436.31,	1103.43,	0.33,		6.0}, // Fanny Batter's Whore House #2
	{2817.17,	-1169.24,	1029.90,	271.65,		8.0}, // Colonel Furhberger's
	{2210.14,	-1071.65,	1051.33,	85.84,		1.0}, // The Camel's Toe Safehouse
	{2206.61,	-1071.55,	1051.33,	85.84,		1.0}, // The Camel's Toe Safehouse #2
	{2358.57,	-1132.55,	1051.40,	187.34,		8.0}, // Verdant Bluffs Safehouse
	{2362.09,	-1122.18,	1051.57,	182.98,		8.0}, // Verdant Bluffs Safehouse #2
	{92.37,		1341.23,	1089.02,	88.37,		9.0}, // Burglary House X22
	{77.84,		1337.40,	1089.02,	264.46,		9.0}, // Burglary House X22 #2
	{259.82,	1253.90,	1085.00,	5.65,		9.0} // Burglary House X23
};

//--------------------------------------------------------------------

bool:IsPlayerInBed(playerid)
{
	for(new i = 0; i < sizeof(gfBedPositions); i++)
	{
		if(IsPlayerInRangeOfPoint(playerid, 3.0, gfBedPositions[i][0], gfBedPositions[i][1], gfBedPositions[i][2]) && GetPlayerInterior(playerid) == floatround(gfBedPositions[i][4]))
			return true;
	}
	return false;
}

//--------------------------------------------------------------------

PutPlayerInNearestBed(playerid, Float:range = 5.0)
{
	for(new i = 0; i < sizeof(gfBedPositions); i++)
	{
		if(IsPlayerInRangeOfPoint(playerid, range, gfBedPositions[i][0], gfBedPositions[i][1], gfBedPositions[i][2]) && GetPlayerInterior(playerid) == floatround(gfBedPositions[i][4]))
		{
			SetPlayerPos(playerid, gfBedPositions[i][0], gfBedPositions[i][1], gfBedPositions[i][2]);
			SetPlayerFacingAngle(playerid, gfBedPositions[i][3]);
			break;
		}
	}
	return 0;
}

//--------------------------------------------------------------------

IsPlayerSleeping(playerid)
	return gpIsSleeping[playerid];

//--------------------------------------------------------------------

SetPlayerSleeping(playerid, bool:status)
{
	gpIsSleeping[playerid] = status;
}

//--------------------------------------------------------------------

ptask OnClientUpdate[1000](playerid)
{
	if(!IsPlayerLogged(playerid))
		return 1;

	SetPlayerHunger(playerid, GetPlayerHunger(playerid) - 0.005);
	SetPlayerThirst(playerid, GetPlayerThirst(playerid) - 0.01);
	SetPlayerSleep(playerid, GetPlayerSleep(playerid) - 0.002);

	if(GetPlayerAddiction(playerid) > 0.01)
		SetPlayerAddiction(playerid, GetPlayerAddiction(playerid) - 0.006);

	// Dont spam messages if the player is away
	if(!IsPlayerPaused(playerid))
	{
	    if(gPlayerWarningMessage[playerid][WARNING_SLEEP] < tickcount() && GetPlayerSleep(playerid) < 7.5)
		{
	        SendClientActionMessage(playerid, 20.0, "bocejou.");
	    	gPlayerWarningMessage[playerid][WARNING_SLEEP] = tickcount() + INTERVAL_BETWEEN_WARNING;
	    }

	    else if(gPlayerWarningMessage[playerid][WARNING_HUNGER] < tickcount() && GetPlayerHunger(playerid) < 7.5)
		{
			if(GetPlayerHunger(playerid) < 2.5)
				SendClientMessage(playerid, COLOR_WARNING, "* Você está faminto.");
	        SendActionMessage(playerid, 20.0, "Estômago roncando.");
	        gPlayerWarningMessage[playerid][WARNING_HUNGER] = tickcount() + INTERVAL_BETWEEN_WARNING;
		}

	    else if(gPlayerWarningMessage[playerid][WARNING_ADDICTION] < tickcount() && GetPlayerAddiction(playerid) < 2.5 && GetPlayerAddiction(playerid) > 0.0)
		{
			SendClientMessage(playerid, COLOR_WARNING, "* Você está a muito tempo sem se drogar, sua HP começará a descer em breve.");
	        SendClientActionMessage(playerid, 20.0, "começa a tremer.");
	        gPlayerWarningMessage[playerid][WARNING_ADDICTION] = tickcount() + INTERVAL_BETWEEN_WARNING;
		}

		else if(gPlayerWarningMessage[playerid][WARNING_THIRST] < tickcount() && GetPlayerThirst(playerid) < 7.5)
		{
			if(GetPlayerThirst(playerid) < 2.5)
				SendClientMessage(playerid, COLOR_WARNING, "* Você está sedento.");
	        else if(GetPlayerThirst(playerid) < 5.0)
	    		SendClientMessage(playerid, COLOR_WARNING, "* Você está com sede.");
	        else
	    		SendClientMessage(playerid, COLOR_WARNING, "* Você está ficando com sede.");
	        gPlayerWarningMessage[playerid][WARNING_THIRST] = tickcount() + INTERVAL_BETWEEN_WARNING;
		}
	}

    if(GetPlayerHunger(playerid) == 0.0)
	{
		new Float:health;
		GetPlayerHealth(playerid, health);

		if(health == 1.0)
		{
			SendClientMessage(playerid, COLOR_WARNING, "* Você desmaiou de fome.");
            SetPlayerHunger(playerid, 50.0);
		}
		SetPlayerHealth(playerid, health - 1.0);
	}
	else if(GetPlayerThirst(playerid) == 0.0)
	{
		new Float:health;
		GetPlayerHealth(playerid, health);

		if(health == 1.0)
		{
			SendClientMessage(playerid, COLOR_WARNING, "* Você desmaiou de desidratação.");
            SetPlayerThirst(playerid, 50.0);
		}
		SetPlayerHealth(playerid, health - 1.0);
	}
	else if(GetPlayerAddiction(playerid) > 0.0 && GetPlayerAddiction(playerid) < 0.1)
	{
		new Float:health;
		GetPlayerHealth(playerid, health);

		if(health == 1.0)
			SetPlayerAddiction(playerid, 12.0);

		SetPlayerHealth(playerid, health - 1.0);
	}
	else if(GetPlayerSleep(playerid) == 0.0)
	{
		PutPlayerInNearestBed(playerid);
		SetPlayerSleeping(playerid, true);
		ApplyAnimation(playerid, "CRACK", "crckidle2", 4.1, 1, 0, 0, 1, 0, 1);
		SendClientActionMessage(playerid, 20.0, "desmaiou de sono.");
	}

    if(IsPlayerSleeping(playerid))
	{
		if(GetPlayerAnimationIndex(playerid) != 390)
			ApplyAnimation(playerid, "CRACK", "crckidle2", 4.1, 1, 0, 0, 1, 0, 1);

		SetPlayerSleep(playerid, GetPlayerSleep(playerid) + 1.0);
		GameTextForPlayer(playerid,"~n~~n~~n~~n~~n~~n~~n~~n~~w~dormindo...", 5000, 3);

		if(GetPlayerSleep(playerid) > 25.0)
		{
			if(!IsPlayerInBed(playerid))
			{
				SendClientActionMessage(playerid, 20.0, "acordou dolorido.");
				SetPlayerSleeping(playerid, false);
				ClearAnimations(playerid);
			}
			else if(GetPlayerSleep(playerid) == 100.0)
			{
				SendClientActionMessage(playerid, 20.0, "acordou revigorado.");
				SetPlayerSleeping(playerid, false);
				ClearAnimations(playerid);
			}
		}

		new sleepstr[8];
		switch(random(2))
		{
			case 0: sleepstr = "z Z z Z";
			case 1: sleepstr = "Z z Z z";
		}

		SetPlayerChatBubble(playerid, sleepstr, -1, 20.0, 1250);
	}
	OnPlayerPetUpdate(playerid);
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerDeath(playerid, killerid, reason)
{
	if(GetPlayerHunger(playerid) < 5.0)
		SetPlayerHunger(playerid, 5.0);

	if(GetPlayerThirst(playerid) < 5.0)
		SetPlayerThirst(playerid, 5.0);

	if(GetPlayerAddiction(playerid) < 5.0 && GetPlayerAddiction(playerid) > 0.0)
		SetPlayerAddiction(playerid, 5.0);
	return 1;
}

/********************************************************************************
 *     ######   #######  ##     ## ##     ##    ###    ##    ## ########   ######
 *    ##    ## ##     ## ###   ### ###   ###   ## ##   ###   ## ##     ## ##    ##
 *    ##       ##     ## #### #### #### ####  ##   ##  ####  ## ##     ## ##
 *    ##       ##     ## ## ### ## ## ### ## ##     ## ## ## ## ##     ##  ######
 *    ##       ##     ## ##     ## ##     ## ######### ##  #### ##     ##       ##
 *    ##    ## ##     ## ##     ## ##     ## ##     ## ##   ### ##     ## ##    ##
 *     ######   #######  ##     ## ##     ## ##     ## ##    ## ########   ######
********************************************************************************/

YCMD:dormir(playerid, params[], help)
{
	if(IsPlayerSleeping(playerid))
		return SendClientMessage(playerid, COLOR_ERROR, "* Você já está dormindo.");

    if(GetPlayerSleep(playerid) > 10.0)
    	return SendClientMessage(playerid, COLOR_ERROR, "* Você não está com sono.");

	ApplyAnimation(playerid, "CRACK", "crckidle2", 4.1, 1, 0, 0, 1, 0, 1);
	PutPlayerInNearestBed(playerid);
	SetPlayerSleeping(playerid, true);
	SendClientActionMessage(playerid, 20.0, "deitou e dormiu.");
	return 1;
}

//------------------------------------------------------------------------------

YCMD:acordar(playerid, params[], help)
{
	new targetid;
	if(sscanf(params, "u", targetid))
		return SendClientMessage(playerid, COLOR_INFO, "* /acordar [playerid]");

	else if(GetPlayerDistanceFromPlayer(playerid, targetid) > 3.0)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não está próximo do jogador.");

    else if(!IsPlayerSleeping(targetid))
		return SendClientMessage(playerid, COLOR_ERROR, "* O jogador não está dormindo.");

    else if(playerid == targetid)
    	return SendClientMessage(playerid, COLOR_ERROR, "* Você não pode acordar você mesmo.");

    SetPlayerSleeping(targetid, false);
	ClearAnimations(targetid, 1);

	new message[13 + MAX_PLAYER_NAME];
	format(message, sizeof(message), "acordou %s.", GetPlayerNamef(targetid));
	SendClientActionMessage(playerid, 20.0, message);
	return 1;
}
