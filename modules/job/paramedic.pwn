/*******************************************************************************
* FILENAME :        modules/job/paramedic.pwn
*
* DESCRIPTION :
*       Adds paramedic job to the server.
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

// Checkpointid
static STREAMER_TAG_CP gCheckpointid;

/*
// Amount of XP multipled by job level to level up.
static const REQUIRED_XP = 125;

// Amount of XP multipled by job level the player will recieve for revivals.
static const XP_SCALE = 5;
*/

// Truck spawns
static const Float:g_fTruckPositions[][] =
{
    {1177.9297, -1308.4379, 14.0030, 269.1813},
    {1178.2739, -1338.7297, 14.0304, 270.2344},
    {1192.5576, -1332.4583, 13.5491, 179.3243},
    {1192.5452, -1324.4142, 13.5477, 179.8259},
    {1192.4919, -1316.4365, 13.5476, 180.3060}
};

// Paramedic services
static gParaServices[][][] =
{
    {500, "Entrar em serviço p/ atender chamados"}
};

//------------------------------------------------------------------------------

static gSpawnPositions[5] = {INVALID_PLAYER_ID, ...};

//------------------------------------------------------------------------------

static gplTruck[MAX_PLAYERS] = {INVALID_VEHICLE_ID, ...};

//------------------------------------------------------------------------------

hook OnPlayerDisconnect(playerid, reason)
{
    if(gplTruck[playerid] != INVALID_VEHICLE_ID)
    {
        DestroyVehicle(gplTruck[playerid]);
        gplTruck[playerid] = INVALID_VEHICLE_ID;

        for(new i = 0; i < sizeof(gSpawnPositions); i++)
        {
            if(gSpawnPositions[i] == playerid)
            {
                gSpawnPositions[i] = INVALID_PLAYER_ID;
                break;
            }
        }
    }
    return 1;
}
//------------------------------------------------------------------------------

hook OnPlayerDeath(playerid, killerid, reason)
{
    if(gplTruck[playerid] != INVALID_VEHICLE_ID)
    {
        DestroyVehicle(gplTruck[playerid]);
        gplTruck[playerid] = INVALID_VEHICLE_ID;

        for(new i = 0; i < sizeof(gSpawnPositions); i++)
        {
            if(gSpawnPositions[i] == playerid)
            {
                gSpawnPositions[i] = INVALID_PLAYER_ID;
                break;
            }
        }
    }
    return 1;
}

//------------------------------------------------------------------------------

hook OnGameModeInit()
{
    print("Loading paramedic job.");
	CreateDynamicPickup(1210, 1, 1183.1554, -1313.3402, 13.5681, 0, 0, -1, MAX_PICKUP_RANGE);
	CreateDynamic3DTextLabel("Paramédico\nPressione {1add69}Y", 0xFFFFFFFF, 1183.1554, -1313.3402, 13.5681, MAX_TEXT3D_RANGE, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
    gCheckpointid = CreateDynamicCP(1172.0778, -1321.5398, 15.3990, 1.0, 0, 0);
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerEnterDynamicCP(playerid, STREAMER_TAG_CP checkpointid)
{
    if(checkpointid == gCheckpointid)
    {
        if(GetPlayerJobID(playerid) != PARAMEDIC_JOB_ID)
        {
            PlayErrorSound(playerid);
            SendClientMessage(playerid, COLOR_ERROR, "* Você não é um paramédico.");
        }
        else
        {
            PlaySelectSound(playerid);
            new info[300], buffer[60];
            strcat(info, "Serviço\tPagamento\tNível");
            for(new i = 0; i < sizeof(gParaServices); i++)
            {
                format(buffer, sizeof(buffer), "\n%s\t$%s\t%i", gParaServices[i][1], formatnumber(gParaServices[i][0][0]), i+1);
                strcat(info, buffer);
            }
            ShowPlayerDialog(playerid, DIALOG_PARAMEDIC_SERVICES,  DIALOG_STYLE_TABLIST_HEADERS, "Paramédico -> Serviços", info, "Aceitar", "Recusar");
        }
        return -2;
    }
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    foreach(new i: Player)
    {
        if(vehicleid == gplTruck[i] && !ispassenger && playerid != i)
        {
            SendClientMessagef(playerid, COLOR_ERROR, "* Ambulância reservada para %s.", GetPlayerNamef(i));
            ClearAnimations(playerid);
        }
    }
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if((newkeys == KEY_YES) && IsPlayerInRangeOfPoint(playerid, 3.0, 1183.1554, -1313.3402, 13.5681))
	{
        if(GetPlayerLevel(playerid) < 3)
        {
            SendClientMessage(playerid, COLOR_ERROR, "* Você precisa ser nível 3.");
        }
        else
        {
            ShowPlayerDialog(playerid, DIALOG_PARAMEDIC_JOB, DIALOG_STYLE_MSGBOX, "Emprego: Paramédico", "Você deseja ser um paramédico?", "Sim", "Não");
        }
	}
	return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerEnterRaceCPT(playerid)
{
    switch(GetPlayerCPID(playerid))
    {
        case CHECKPOINT_PARAMEDIC:
        {
            // TO DO: on entering a checkpoint of a deadbody offer revival for $500
        }
    }
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
    if(newstate == PLAYER_STATE_DRIVER)
    {
        if(IsPlayerInVehicle(playerid, gplTruck[playerid]))
        {
            for(new i = 0; i < sizeof(gSpawnPositions); i++)
            {
                if(gSpawnPositions[i] == playerid)
                {
                    gSpawnPositions[i] = INVALID_PLAYER_ID;
                    break;
                }
            }
        }
    }
    return 1;
}

//------------------------------------------------------------------------------

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch(dialogid)
    {
        case DIALOG_PARAMEDIC_JOB:
        {
            if(!response)
                PlayCancelSound(playerid);
            else
            {
                if(GetPlayerJobID(playerid) != INVALID_JOB_ID)
                {
                    PlayErrorSound(playerid);
                    SendClientMessage(playerid, COLOR_ERROR, "* Você já possui um emprego.");
                }
                else
                {
                    SetPlayerJobID(playerid, PARAMEDIC_JOB_ID);
                    SendClientMessage(playerid, COLOR_SPECIAL, "* Agora você é um paramédico!");
                    SendClientMessage(playerid, COLOR_SUB_TITLE, "* Entre em serviço e aguarde algum chamado.");
                    PlayConfirmSound(playerid);
                }
            }
        }
        case DIALOG_PARAMEDIC_SERVICES:
        {
            if(!response)
                PlayCancelSound(playerid);
            else if(GetPlayerJobLV(playerid) < listitem+1)
            {
                PlayErrorSound(playerid);
                SendClientMessage(playerid, COLOR_ERROR, "* Você não tem nível de emprego suficiente para este serviço.");
            }
            else
            {
                if(gplTruck[playerid] != INVALID_VEHICLE_ID)
                {
                    SendClientMessage(playerid, COLOR_ERROR, "* Você já está em serviço.");
                    return 1;
                }

                new rand = -2;
                for(new i = 0; i < sizeof(gSpawnPositions); i++)
                {
                    if(gSpawnPositions[i] == INVALID_PLAYER_ID)
                    {
                        rand = i;
                        break;
                    }
                }

                if(rand == -2)
                {
                    SendClientMessage(playerid, COLOR_ERROR, "* As vagas dos caminhões estão ocupadas, aguarde um jogador liberar a vaga.");
                    return 1;
                }

                SendClientMessage(playerid, COLOR_SPECIAL, "* Aguarde algum chamado para atender.");
                SendClientMessage(playerid, COLOR_SUB_TITLE, "* Caso você destrua a ambulância será descontado de seu dinheiro.");

                gSpawnPositions[rand] = playerid;
                gplTruck[playerid] = CreateVehicle(416, g_fTruckPositions[rand][0], g_fTruckPositions[rand][1], g_fTruckPositions[rand][2], g_fTruckPositions[rand][3], 0, 1, -1);
                SetVehicleFuel(gplTruck[playerid], 100.0);

                SetPlayerSkin(playerid, 274, false);
                PlaySelectSound(playerid);
            }
            return -2;
        }
    }
    return 1;
}

//------------------------------------------------------------------------------

YCMD:curar(playerid, params[], help)
{
    if(GetPlayerJobID(playerid) != PARAMEDIC_JOB_ID)
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não é um paramédico.");

    new targetid;
	if(sscanf(params, "k<u>", targetid))
		return SendClientMessage(playerid, COLOR_INFO, "* /curar [playerid]");

    if(gplTruck[playerid] == INVALID_VEHICLE_ID)
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não está trabalhando.");

    if(!IsPlayerInVehicle(playerid, gplTruck[playerid]) || !IsPlayerInVehicle(targetid, gplTruck[playerid]))
        return SendClientMessage(playerid, COLOR_ERROR, "* Vocês precisam estar na ambulância.");

    new Float:health;
    GetPlayerHealth(targetid, health);

    if(health > 99.9)
		return SendClientMessage(playerid, COLOR_ERROR, "* O jogador está com a vida cheia.");

    if(playerid == targetid)
    	return SendClientMessage(playerid, COLOR_ERROR, "* Você não pode curar você mesmo.");

    new message[64];
    format(message, sizeof(message), "trata dos ferimentos de %s.", GetPlayerNamef(targetid));
    SendClientActionMessage(playerid, 20.0, message);
    SetPlayerHealth(targetid, 100.0);
    return 1;
}
