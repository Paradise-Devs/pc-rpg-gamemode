/*******************************************************************************
* FILENAME :        modules/job/busdriver.pwn
*
* DESCRIPTION :
*       Adds busdriver job to the server.
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

static const PAYMENT = 350;

//------------------------------------------------------------------------------

static const Float:gBusWestRoute[][] =
{
	{1129.4520,	-1849.6158,	13.4908},
	{829.3793,	-1766.7526,	13.5028},
	{354.7368,	-1642.8058,	32.9723},
	{416.6568,	-1484.0966,	30.8132},
	{517.2944,	-1362.0804,	16.0643},
	{907.8797,	-987.7831,	37.7406},
	{1237.8813,	-943.4121,	42.6093},
	{1350.4315,	-1018.5638,	26.6661},
	{1339.3550,	-1261.3525,	13.4771},
	{1192.4088,	-1336.0619,	13.4985},
	{1324.6855,	-1408.9948,	13.4133},
	{1426.2798,	-1623.3300,	13.4824},
	{1332.8517,	-1729.3368,	13.4828},
	{1203.4222,	-1738.1320,	13.6883}
};

//------------------------------------------------------------------------------

static const Float:gBusEastRoute[][] =
{
	{1227.4983,	-1715.2743,	13.4834},
	{1502.8929,	-1735.2737,	13.4823},
	{1892.3320,	-1755.4720,	13.4864},
	{2259.5483,	-1752.2601,	13.4843},
	{2410.8020,	-1877.6637,	13.4826},
	{2231.9189,	-1969.0092,	13.4611},
	{2209.5554,	-2149.9580,	13.4907},
	{1979.3408,	-2163.3359,	13.4764},
	{1532.9624,	-1887.5037,	13.6882},
	{1202.6517,	-1831.2938,	13.5047}
};

//------------------------------------------------------------------------------

static const Float:gBusEastSpawn[][] =
{
    { 1181.8003,	-1748.5946,	13.5318,	0.0 },
    { 1181.8003,	-1762.5946,	13.5318,	0.0 },
    { 1181.8003,	-1776.5946,	13.5319,	0.0 },
    { 1181.8003,	-1790.5946,	13.5319,	0.0 },
    { 1181.8003,	-1804.5946,	13.5319,	0.0 }
};

//------------------------------------------------------------------------------

static const Float:gBusWestSpawn[][] =
{
    { 1173.0861,	-1748.5946,	13.5313,	180.0 },
    { 1173.0861,	-1762.5946,	13.5313,	180.0 },
    { 1173.0861,	-1776.5946,	13.5313,	180.0 },
    { 1173.0861,	-1790.5946,	13.5313,	180.0 },
    { 1173.0861,	-1804.5946,	13.5313,	180.0 }
};

//------------------------------------------------------------------------------

static g_PlayerBus[MAX_PLAYERS] = {INVALID_VEHICLE_ID, ...};

//------------------------------------------------------------------------------

enum
{
	ROUTE_NONE,
	ROUTE_NORTH,
	ROUTE_SOUTH,
	ROUTH_WEST,
	ROUTH_EAST
}

//------------------------------------------------------------------------------

stock IsPlayerBusDriver(playerid)
    return (GetPlayerJobID(playerid) == BUSDRIVER_JOB_ID);

//------------------------------------------------------------------------------

/*
	Called when the server starts
*/
hook OnGameModeInit()
{
	CreateDynamicPickup(1210, 1, 1167.4186, -1764.3025, 13.5703, 0, 0, -1, MAX_PICKUP_RANGE);// Job service
    CreateDynamic3DTextLabel("Motorista de ônibus\nDigite {1add69}/iniciarrota", 0xFFFFFFFF, 1167.4186, -1764.3025, 13.5703, MAX_TEXT3D_RANGE, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
	CreateDynamicPickup(1210, 1, 1193.7578, -1768.7865, 13.5822, 0, 0, -1, MAX_PICKUP_RANGE);// Job place
	CreateDynamic3DTextLabel("Motorista de ônibus\nPressione {1add69}Y", 0xFFFFFFFF, 1193.7578, -1768.7865, 13.5822, MAX_TEXT3D_RANGE, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
	return 1;
}

/*
	Called when a player enters a vehicle
		playerid - ID of the player
		vehicleid - ID of the vehicle
		ispassenger - If player is entering as passenger
*/
hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    if(!ispassenger)
    {
        foreach(new i: Player)
        {
            if(vehicleid == g_PlayerBus[i] && playerid != i)
            {
                ClearAnimations(playerid);
                SendClientMessage(playerid, COLOR_ERROR, "* Você não é o motorista deste ônibus.");
            }
    	}
    }
	return 1;
}

/*
	Called when a player exits a vehicle
		playerid - ID of the player
		vehicleid - ID of the vehicle
*/
hook OnPlayerExitVehicle(playerid, vehicleid)
{
	if(GetPlayerCPID(playerid) == CHECKPOINT_BUSDRIVER)
	{
		SendClientMessage(playerid, COLOR_INFO, "* Você abandonou o serviço.");
		DisablePlayerRaceCheckpoint(playerid);

		DeletePVar(playerid, "job_cp_route");
		DeletePVar(playerid, "bus_route");

        DestroyVehicle(g_PlayerBus[playerid]);
        g_PlayerBus[playerid] = INVALID_VEHICLE_ID;
	}
	return 1;
}

/*
	Called when a player dies
		playerid - ID of the player
		killerid - ID of the killer
        reason - ID of the reason the player died
*/
hook OnPlayerDeath(playerid, killerid, reason)
{
	if(GetPlayerCPID(playerid) == CHECKPOINT_BUSDRIVER)
	{
		SendClientMessage(playerid, COLOR_INFO, "* Você não conseguiu completar o serviço.");
		DisablePlayerRaceCheckpoint(playerid);

		DeletePVar(playerid, "job_cp_route");
		DeletePVar(playerid, "bus_route");

        DestroyVehicle(g_PlayerBus[playerid]);
        g_PlayerBus[playerid] = INVALID_VEHICLE_ID;
	}
	return 1;
}

/*
	Called when a player disconnects
		playerid - ID of the player
        reason - ID of the reason the player left
*/
hook OnPlayerDisconnect(playerid, reason)
{
	if(GetPlayerCPID(playerid) == CHECKPOINT_BUSDRIVER)
	{
        DestroyVehicle(g_PlayerBus[playerid]);
        g_PlayerBus[playerid] = INVALID_VEHICLE_ID;
	}
	return 1;
}

/*
	Called when a player clicks on a dialog
		playerid - ID of the player
		dialogid - ID of the dialog
		response - If clicked button 0 or button 1
		listitem - If used DIALOG_STYLE_INPUT_LIST
		inputtext - If used DIALOG_STYLE_INPUT_TEXT
*/
hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		case DIALOG_BUSDRIVER_JOB:
		{
			if(!response)
			{
				PlayCancelSound(playerid);
				return 1;
			}

            PlaySelectSound(playerid);
            SetPlayerJobID(playerid, BUSDRIVER_JOB_ID);
			SendClientMessage(playerid, COLOR_SUCCESS, "* Você agora é um motorista de ônibus.");
			SendClientMessage(playerid, COLOR_INFO, "* Use /iniciarrota para trabalhar.");
			return 1;
		}
		case DIALOG_BUSDRIVER_SERVICES:
		{
			if(!response)
				return 1;

			else if(!IsPlayerBusDriver(playerid))
				return SendClientMessage(playerid, COLOR_ERROR, "* Você não é um motorista de ônibus.");

			else if(!IsPlayerInRangeOfPoint(playerid, 5.0, 1167.4186, -1764.3025, 13.5703))
				return SendClientMessage(playerid, COLOR_ERROR, "* Você não está no local de serviço.");

			switch(listitem)
			{
				case 0:// West
				{
					SetPVarInt(playerid, "bus_route", ROUTH_WEST);
                    SetPlayerCPID(playerid, CHECKPOINT_BUSDRIVER);
					SetPlayerRaceCheckpoint(playerid, 2, gBusWestRoute[0][0], gBusWestRoute[0][1], gBusWestRoute[0][2], 0.0, 0.0, 0.0, 3.5);

                    new rand = random(sizeof(gBusWestSpawn));
                    g_PlayerBus[playerid] = CreateVehicle(437, gBusWestSpawn[rand][0], gBusWestSpawn[rand][1], gBusWestSpawn[rand][2], gBusWestSpawn[rand][3], 157, 166, -1);
                    PutPlayerInVehicle(playerid, g_PlayerBus[playerid], 0);
                    SetVehicleFuel(g_PlayerBus[playerid], 100.0);
				}
				case 1:// East
				{
					SetPVarInt(playerid, "bus_route", ROUTH_EAST);
                    SetPlayerCPID(playerid, CHECKPOINT_BUSDRIVER);
					SetPlayerRaceCheckpoint(playerid, 2, gBusEastRoute[0][0], gBusEastRoute[0][1], gBusEastRoute[0][2], 0.0, 0.0, 0.0, 3.5);

                    new rand = random(sizeof(gBusEastSpawn));
                    g_PlayerBus[playerid] = CreateVehicle(437, gBusEastSpawn[rand][0], gBusEastSpawn[rand][1], gBusEastSpawn[rand][2], gBusEastSpawn[rand][3], 157, 166, -1);
                    PutPlayerInVehicle(playerid, g_PlayerBus[playerid], 0);
                    SetVehicleFuel(g_PlayerBus[playerid], 100.0);
				}
			}

			SetPVarInt(playerid, "job_cp_route", 1);
			SendClientMessage(playerid, 0x00D900C8, "* Siga os checkpoints determinados.");
			return 1;
		}
	}
	return 1;
}

/*
	Called when a player enters a checkpoint
		playerid - ID of the player
*/
hook OnPlayerEnterRaceCPT(playerid)
{
	switch(GetPlayerCPID(playerid))
	{
		case CHECKPOINT_BUSDRIVER:
		{
			new checkpointid = GetPVarInt(playerid, "job_cp_route");

			if(GetPVarInt(playerid, "bus_route") == ROUTH_WEST)
			{
				if(checkpointid > (sizeof(gBusWestRoute)-1))
				{
					new cash = minrand(0, 25) + (PAYMENT * GetPlayerJobLV(playerid));
					GivePlayerCash(playerid, cash);
					SendClientMessagef(playerid, 0x00D900C8, "*** Você finalizou a viagem e recebeu seu pagamento de {00A300}$%i{00D900}.", cash);

					DisablePlayerRaceCheckpoint(playerid);
					SetVehicleToRespawn(GetPlayerVehicleID(playerid));
					SetPlayerXP(playerid, GetPlayerXP(playerid) + 1);
					SetPlayerJobXP(playerid, GetPlayerJobXP(playerid) + 1);

					DeletePVar(playerid, "job_cp_route");
					DeletePVar(playerid, "bus_route");
				}
				else
				{
					SetVehicleVelocity(GetPlayerVehicleID(playerid), 0.0, 0.0, 0.0);
					TogglePlayerControllable(playerid, false);
					GameTextForPlayer(playerid,"~n~~n~~n~~n~~n~~n~~n~~n~~w~aguarde...", 5000, 3);

					defer OnPlayerUnfreeze(playerid);

					SetPlayerRaceCheckpoint(playerid, 2, gBusWestRoute[checkpointid][0], gBusWestRoute[checkpointid][1], gBusWestRoute[checkpointid][2], 0.0, 0.0, 0.0, 3.5);
					SetPVarInt(playerid, "job_cp_route", GetPVarInt(playerid, "job_cp_route") + 1);
				}
			}
			else if(GetPVarInt(playerid, "bus_route") == ROUTH_EAST)
			{
				if(checkpointid > (sizeof(gBusEastRoute)-1))
				{
					new cash = minrand(0, 25) + (PAYMENT * GetPlayerJobLV(playerid));
					GivePlayerCash(playerid, cash);
					SendClientMessagef(playerid, 0x00D900C8, "*** Você finalizou a viagem e recebeu seu pagamento de {00A300}$%i{00D900}.", cash);

					DisablePlayerRaceCheckpoint(playerid);
					SetVehicleToRespawn(GetPlayerVehicleID(playerid));
					SetPlayerXP(playerid, GetPlayerXP(playerid) + 1);
					SetPlayerJobXP(playerid, GetPlayerJobXP(playerid) + 1);

					DeletePVar(playerid, "job_cp_route");
					DeletePVar(playerid, "bus_route");
				}
				else
				{
					SetVehicleVelocity(GetPlayerVehicleID(playerid), 0.0, 0.0, 0.0);
					TogglePlayerControllable(playerid, false);
					GameTextForPlayer(playerid,"~n~~n~~n~~n~~n~~n~~n~~n~~w~aguarde...", 5000, 3);
					defer OnPlayerUnfreeze(playerid);

					SetPlayerRaceCheckpoint(playerid, 2, gBusEastRoute[checkpointid][0], gBusEastRoute[checkpointid][1], gBusEastRoute[checkpointid][2], 0.0, 0.0, 0.0, 3.5);
					SetPVarInt(playerid, "job_cp_route", GetPVarInt(playerid, "job_cp_route") + 1);
				}
			}
		}
	}
	return 1;
}

/*
	Called when a player press a key
		playerid - ID of the player
		newkeys - new key pressed
		oldkeys - old key pressed
*/
hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if((newkeys == KEY_YES) && IsPlayerInRangeOfPoint(playerid, 3.0, 1193.7578, -1768.7865, 13.5822))
	{
		if(GetPlayerJobID(playerid) != INVALID_JOB_ID)
			return SendClientMessage(playerid, COLOR_ERROR, "* Você já possui um emprego.");

		ShowPlayerDialog(playerid, DIALOG_BUSDRIVER_JOB, DIALOG_STYLE_MSGBOX, "Emprego: Motorista", "Você deseja ser um motorista de ônibus?", "Sim", "Não");
		PlaySelectSound(playerid);
		return -2;
	}
	return 1;
}

timer OnPlayerUnfreeze[5000](playerid)
{
    TogglePlayerControllable(playerid, true);
    GameTextForPlayer(playerid,"~n~~n~~n~~n~~n~~n~~n~~n~~g~vai!", 5000, 3);
}

//------------------------------------------------------------------------------

/***
 *     ######   #######  ##     ## ##     ##    ###    ##    ## ########   ######
 *    ##    ## ##     ## ###   ### ###   ###   ## ##   ###   ## ##     ## ##    ##
 *    ##       ##     ## #### #### #### ####  ##   ##  ####  ## ##     ## ##
 *    ##       ##     ## ## ### ## ## ### ## ##     ## ## ## ## ##     ##  ######
 *    ##       ##     ## ##     ## ##     ## ######### ##  #### ##     ##       ##
 *    ##    ## ##     ## ##     ## ##     ## ##     ## ##   ### ##     ## ##    ##
 *     ######   #######  ##     ## ##     ## ##     ## ##    ## ########   ######
 ***/

//------------------------------------------------------------------------------

YCMD:iniciarrota(playerid, params[], help)
{
	if(!IsPlayerBusDriver(playerid))
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não é um motorista de ônibus.");

    else if(!IsPlayerInRangeOfPoint(playerid, 5.0, 1167.4186, -1764.3025, 13.5703))
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não está no local de serviço.");

    else if(GetPlayerCPID(playerid) == CHECKPOINT_BUSDRIVER)
        return SendClientMessage(playerid, COLOR_ERROR, "* Você já está em um serviço.");

	ShowPlayerDialog(playerid, DIALOG_BUSDRIVER_SERVICES, DIALOG_STYLE_LIST, "Rotas", "1.\tOeste\n2.\tLeste", "Confirmar", "Cancelar");
	return 1;
}

//------------------------------------------------------------------------------
