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

// Ambulance spawns
static const Float:g_fAmbulanceSpawns[][] =
{
    {1177.9297, -1308.4379, 14.0030, 269.1813},
    {1178.2739, -1338.7297, 14.0304, 270.2344},
    {1192.5576, -1332.4583, 13.5491, 179.3243},
    {1192.5452, -1324.4142, 13.5477, 179.8259},
    {1192.4919, -1316.4365, 13.5476, 180.3060}
};

// Job position
static const Float:JOB_POSITION[] = { 1183.1554, -1313.3402, 13.5681 };

// Service position
static const Float:SERVICE_POSITION[] = { 1183.1333, -1332.5238, 13.5808 };

new gPlayerAmbulanceID[MAX_PLAYERS] = INVALID_VEHICLE_ID;
new gAmbulancePickupID[MAX_PLAYERS] = -1;

//------------------------------------------------------------------------------
DestroyPlayerParamedicInfo(playerid)
{
    DestroyVehicle(gPlayerAmbulanceID[playerid]);
    DestroyDynamicPickup(gAmbulancePickupID[playerid]);

    gPlayerAmbulanceID[playerid] = INVALID_VEHICLE_ID;
    gAmbulancePickupID[playerid] = -1;

    SetPlayerWorking(playerid, false);
    DisablePlayerRaceCheckpoint(playerid);
    return 1;
}

//------------------------------------------------------------------------------

hook OnGameModeInit()
{
    print("Loading paramedic job.");

	CreateDynamicPickup(1210, 1, JOB_POSITION[0], JOB_POSITION[1], JOB_POSITION[2], 0, 0, -1, MAX_PICKUP_RANGE);
	CreateDynamic3DTextLabel("Paramédico\nPressione {1add69}Y", 0xFFFFFFFF, JOB_POSITION[0], JOB_POSITION[1], JOB_POSITION[2], MAX_TEXT3D_RANGE, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);

    CreateDynamicPickup(1239, 1, SERVICE_POSITION[0], SERVICE_POSITION[1], SERVICE_POSITION[2], 0, 0, -1, MAX_PICKUP_RANGE);
    CreateDynamic3DTextLabel("Trabalhar\nPressione {1add69}Y", 0xFFFFFFFF, SERVICE_POSITION[0], SERVICE_POSITION[1], SERVICE_POSITION[2], MAX_TEXT3D_RANGE, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);

    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if((newkeys == KEY_YES) && IsPlayerInRangeOfPoint(playerid, 1.5, JOB_POSITION[0], JOB_POSITION[1], JOB_POSITION[2]))
    {
        PlaySelectSound(playerid);
        ShowPlayerDialog(playerid, DIALOG_PARAMEDIC_JOB, DIALOG_STYLE_MSGBOX, "Emprego: Paramédico", "Você deseja se tornar um paramédico?", "Sim", "Não");
        return 1;
    }
    else if((newkeys == KEY_YES) && IsPlayerInRangeOfPoint(playerid, 1.5, SERVICE_POSITION[0], SERVICE_POSITION[1], SERVICE_POSITION[2]))
    {
        PlaySelectSound(playerid);

        if(GetPlayerJobID(playerid) != PARAMEDIC_JOB_ID)
            return SendClientMessage(playerid, COLOR_ERROR, "* Você não é um paramédico.");

        if(IsPlayerWorking(playerid))
            return SendClientMessage(playerid, COLOR_ERROR, "* Você já está trabalhando! Para parar digite /servico.");

        ShowPlayerDialog(playerid, DIALOG_PARAMEDIC_SERVICES, DIALOG_STYLE_MSGBOX, "Trabalhar", "Você deseja começar a trabalhar?", "Sim", "Não");
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
                return PlayCancelSound(playerid);

            if(GetPlayerJobID(playerid) != INVALID_JOB_ID)
            {
                PlayErrorSound(playerid);
                SendClientMessage(playerid, COLOR_ERROR, "* Você já possui um emprego.");
            }
            else
            {
                SetPlayerJobID(playerid, PARAMEDIC_JOB_ID);
                SendClientMessage(playerid, COLOR_SPECIAL, "* Agora você é um paramédico!");
                SendClientMessage(playerid, COLOR_SUB_TITLE, "* Vá até o ícone ao lado para começar a trabalhar.");
                SendClientMessage(playerid, COLOR_SUB_TITLE, "* Para obter mais informações digite /ajuda e selecione a opção de emprego ou digite /ajudaemprego.");
                PlayConfirmSound(playerid);
            }
        }
        case DIALOG_PARAMEDIC_SERVICES:
        {
            if(!response)
                return PlayCancelSound(playerid);

            SetPlayerSkin(playerid, 274);
            SetPlayerWorking(playerid, true);

            new rand = random(sizeof(g_fAmbulanceSpawns));
            gPlayerAmbulanceID[playerid] = CreateVehicle(416, g_fAmbulanceSpawns[rand][0], g_fAmbulanceSpawns[rand][1], g_fAmbulanceSpawns[rand][2], g_fAmbulanceSpawns[rand][3], 1, 3, 50000);
            gAmbulancePickupID[playerid] = CreateDynamicPickup(1559, 1, g_fAmbulanceSpawns[rand][0], g_fAmbulanceSpawns[rand][1], g_fAmbulanceSpawns[rand][2] + 3, 0, 0, -1, MAX_PICKUP_RANGE);
            SetVehicleFuel(gPlayerAmbulanceID[playerid], 100);

            SendClientMessage(playerid, COLOR_SPECIAL, "* Entre na ambulância indicada e aguarde até um chamado.");
            SendClientMessage(playerid, COLOR_SUB_TITLE, "* A ambulância é de sua responsabilidade, caso ela seja destruída, seu trabalho será cancelado automaticamente.");
        }
    }
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerDisconnect(playerid, reason)
{
    if(IsPlayerWorking(playerid))
        DestroyPlayerParamedicInfo(playerid);

    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerDeath(playerid, killerid, reason)
{
    if(IsPlayerWorking(playerid)) {
        DestroyPlayerParamedicInfo(playerid);
        SendClientMessage(playerid, COLOR_ERROR, "* Você saiu do trabalho.");
    }
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
    if(oldstate == PLAYER_STATE_ONFOOT && newstate == PLAYER_STATE_DRIVER)
    {
        new vehicleid = GetPlayerVehicleID(playerid);

        if(vehicleid == gPlayerAmbulanceID[playerid])
            DestroyDynamicPickup(gAmbulancePickupID[playerid]);
    }
    return 1;
}

//------------------------------------------------------------------------------

ptask CheckPlayerWorking[5000](playerid)
{
    if(GetPlayerJobID(playerid) == PARAMEDIC_JOB_ID)
        if(!IsPlayerWorking(playerid))
            if(gPlayerAmbulanceID[playerid] != INVALID_VEHICLE_ID)
                DestroyPlayerParamedicInfo(playerid);

    return 1;
}
