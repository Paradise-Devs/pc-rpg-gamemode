/*******************************************************************************
* FILENAME :        modules/job/hotdog.pwn
*
* DESCRIPTION :
*       Adds icecream seller job to the server.
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

// Gangzone Area
static g_fZone;

// Amount of XP multipled by job level to level up.
static const REQUIRED_XP = 125;

// Amount of XP multipled by job level the player will recieve for deliver.
static const XP_SCALE = 15;

// Boat model
static const g_nBoatModel = 473;

// Available services
static const g_sFisherServices[][][] =
{
    {1500, "Peixes pequenos"},
    {3000, "Peixes médios"},
    {5000, "Peixes grandes"}
};

// Boat spawns
static const Float:g_fBoatSpawns[][] =
{
    {354.8208, -2090.9666, -0.2147, 180.5354},
    {368.2997, -2091.3770,  0.2779, 186.6305},
    {380.6415, -2091.6348, -0.2071, 184.1831},
    {392.5590, -2091.0032, -0.0215, 174.6285},
    {404.7088, -2092.0747, -0.1621, 186.0271}
};

// Stick positions
static const Float:g_fStickPositions[][] =
{
    {403.9424, -2088.7983, 7.8359},
    {398.7199, -2088.7983, 7.8359},
    {396.1908, -2088.7983, 7.8359},
    {383.4395, -2088.7964, 7.8359},
    {374.9176, -2088.7983, 7.8359},
    {369.8795, -2088.7983, 7.8359},
    {367.3274, -2088.7976, 7.8359},
    {362.1120, -2088.7981, 7.8359},
    {354.4984, -2088.7971, 7.8359}
};

//------------------------------------------------------------------------------

static gplBoat[MAX_PLAYERS] = {INVALID_VEHICLE_ID, ...};
static gplCurrentSC[MAX_PLAYERS];
static gplFishs[MAX_PLAYERS];
static gplFishing[MAX_PLAYERS];
static bool:g_isOnDuty[MAX_PLAYERS];

//------------------------------------------------------------------------------

hook OnGameModeInit()
{
    print("Loading fisher job.");
    CreateDynamicPickup(1210, 1, 391.8892, -2050.9883, 7.8359, 0, 0, -1, MAX_PICKUP_RANGE);
	CreateDynamic3DTextLabel("Pescador\nPressione {1add69}Y", 0xFFFFFFFF, 391.8892, -2050.9883, 7.8359, MAX_TEXT3D_RANGE, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
    gCheckpointid = CreateDynamicCP(392.2991, -2054.9233, 7.8359, 1.0, 0, 0);
    g_fZone = GangZoneCreate(304.6875, -2871.09375, 1136.71875, -2613.28125);
}

//------------------------------------------------------------------------------

hook OnPlayerDisconnect(playerid, reason)
{
    if(gplBoat[playerid] != INVALID_VEHICLE_ID)
    {
        DestroyVehicle(gplBoat[playerid]);
        gplBoat[playerid] = INVALID_VEHICLE_ID;
    }
    gplCurrentSC[playerid] = 0;
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerDeath(playerid, killerid, reason)
{
    if(gplBoat[playerid] != INVALID_VEHICLE_ID)
    {
        DestroyVehicle(gplBoat[playerid]);
        gplBoat[playerid] = INVALID_VEHICLE_ID;
        SendClientMessage(playerid, COLOR_ERROR, "* Você não conseguiu completar o serviço.");
        DisablePlayerRaceCheckpoint(playerid);
        SetPlayerCPID(playerid, CHECKPOINT_NONE);
    }
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerEnterDynamicCP(playerid, STREAMER_TAG_CP checkpointid)
{
    if(checkpointid == gCheckpointid)
    {
        if(GetPlayerJobID(playerid) != FISHER_JOB_ID)
        {
            PlayErrorSound(playerid);
            SendClientMessage(playerid, COLOR_ERROR, "* Você não é um pescador.");
        }
        else
        {
            PlaySelectSound(playerid);
            new info[300], buffer[60];
            strcat(info, "Serviço\tPagamento\tNível");
            for(new i = 0; i < sizeof(g_sFisherServices); i++)
            {
                format(buffer, sizeof(buffer), "\n%s\t$%s\t%i", g_sFisherServices[i][1], formatnumber(g_sFisherServices[i][0][0]), i+1);
                strcat(info, buffer);
            }
            ShowPlayerDialog(playerid, DIALOG_FISHER_SERVICES,  DIALOG_STYLE_TABLIST_HEADERS, "Pescador -> Serviços", info, "Aceitar", "Recusar");
        }
        return -2;
    }
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if((newkeys == KEY_YES) && IsPlayerInRangeOfPoint(playerid, 3.0, 391.8892, -2050.9883, 7.8359))
	{
        ShowPlayerDialog(playerid, DIALOG_FISHER_JOB, DIALOG_STYLE_MSGBOX, "Emprego: Pescador", "Você deseja ser um pescador?", "Sim", "Não");
		return 1;
	}
	return 1;
}

//------------------------------------------------------------------------------

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch(dialogid)
    {
        case DIALOG_FISHER_JOB:
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
                    SetPlayerJobID(playerid, FISHER_JOB_ID);
                    SendClientMessage(playerid, COLOR_SPECIAL, "* Agora você é um pescador!");
                    SendClientMessage(playerid, COLOR_SUB_TITLE, "* Vá ao lado para procurar por serviços.");
                    PlayConfirmSound(playerid);
                }
            }
        }
        case DIALOG_FISHER_SERVICES:
        {
            if(!response)
                PlayCancelSound(playerid);
            else if(gplBoat[playerid] != INVALID_VEHICLE_ID || gplCurrentSC[playerid] != 0 || g_isOnDuty[playerid])
                SendClientMessage(playerid, COLOR_ERROR, "* Você já está em um serviço.");
            else if(GetPlayerJobLV(playerid) < listitem+1)
            {
                PlayErrorSound(playerid);
                SendClientMessage(playerid, COLOR_ERROR, "* Você não tem nível de emprego suficiente para este serviço.");
            }
            else
            {
                if(listitem == 2)
                {
                    SendClientMessage(playerid, COLOR_SPECIAL, "* Vá até o alto mar e digite /pescar, a área foi marcada no seu mapa.");
                    new rand = random(sizeof(g_fBoatSpawns));
                    gplBoat[playerid] = CreateVehicle(g_nBoatModel, g_fBoatSpawns[rand][0], g_fBoatSpawns[rand][1], g_fBoatSpawns[rand][2], g_fBoatSpawns[rand][3], -1, -1, -1);
                    PutPlayerInVehicle(playerid, gplBoat[playerid], 0);
                    SetVehicleFuel(gplBoat[playerid], 100.0);
                    GangZoneShowForPlayer(playerid, g_fZone, COLOR_ERROR);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_SPECIAL, "* Vá até o pier e digite /pescar para começar a pescar.");
                }
                gplCurrentSC[playerid] = listitem;
                g_isOnDuty[playerid] = true;
            }
            return -2;
        }
    }
    return 1;
}

//------------------------------------------------------------------------------

YCMD:pescar(playerid, params[], help)
{
    if(!g_isOnDuty[playerid])
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não está em serviço.");

    if(gplFishing[playerid])
        return SendClientMessage(playerid, COLOR_ERROR, "* Você já está pescando! Aguarde terminar.");

    if(gplCurrentSC[playerid] != 2)
    {
        if(!IsPlayerInStick(playerid))
            return SendClientMessage(playerid, COLOR_ERROR, "* Você não está em uma varinha de pescar.");

        GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~r~Pescando...", 10000, 3);
        SetPlayerFacingAngle(playerid, 180.1535);
        ApplyAnimation(playerid, "SAMP", "FishingIdle", 4.1, 1, 1, 1, 1, 0, 1);
        gplFishing[playerid] = true;

        defer FishTimer(playerid);
    }
    else
    {
        if(!IsPlayerInFishArea(playerid))
            return SendClientMessage(playerid, COLOR_ERROR, "* Você não está na área para pescar.");

        GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~r~Pescando...", 10000, 3);
        TogglePlayerControllable(playerid, false);
        defer UnfreezePlayer[10000](playerid);
        gplFishing[playerid] = true;

        defer FishTimer(playerid);
    }
    return 1;
}

//------------------------------------------------------------------------------

IsPlayerInFishArea(playerid)
{
    new Float:playerPos[3];
    GetPlayerPos(playerid, playerPos[0], playerPos[1], playerPos[2]);

    if((playerPos[0] < 1136.71875) && (playerPos[0] > 304.6875) && (playerPos[1] < -2613.28125) && (playerPos[1] > -2871.09375))
        return 1;

    return 0;
}

//------------------------------------------------------------------------------

IsPlayerInStick(playerid)
{
   for(new i = 0, j = sizeof(g_fStickPositions); i < j; i++)
   {
       if(IsPlayerInRangeOfPoint(playerid, 2.0, g_fStickPositions[i][0], g_fStickPositions[i][1], g_fStickPositions[i][2]))
       {
           return 1;
       }
   }
   return 0;
}

//------------------------------------------------------------------------------

hook OnPlayerEnterRaceCPT(playerid)
{
    if(GetPlayerCPID(playerid) == CHECKPOINT_FISHER)
    {
        new f = gplCurrentSC[playerid];
        PlaySelectSound(playerid);
        SendClientMessage(playerid, COLOR_SPECIAL, "* Você terminou o serviço!");

        if(gplFishs[playerid] < 10)
            return SendClientMessage(playerid, COLOR_ERROR, "* Você não pegou peixes suficientes (10).");

        new output[50];
        format(output, sizeof(output), "* Você recebeu seu pagamento: $%s.", formatnumber(g_sFisherServices[f][0][0]));
        SendClientMessage(playerid, COLOR_SUB_TITLE, output);
        GivePlayerCash(playerid, g_sFisherServices[f][0][0]);

        DisablePlayerRaceCheckpoint(playerid);
        g_isOnDuty[playerid] = false;
        gplFishs[playerid] = 0;

        if(f == 2)
            SetPlayerPos(playerid, 396.7126, -2058.4263, 7.8359);

        DestroyVehicle(gplBoat[playerid]);
        gplBoat[playerid] = INVALID_VEHICLE_ID;
        gplCurrentSC[playerid] = 0;

        SetPlayerCPID(playerid, CHECKPOINT_NONE);
        SetPlayerJobXP(playerid, GetPlayerJobXP(playerid) + (GetPlayerJobLV(playerid) * XP_SCALE));
        if(GetPlayerJobXP(playerid) > (GetPlayerJobLV(playerid) * REQUIRED_XP))
        {
            SendClientMessage(playerid, COLOR_SPECIAL, " ");
            SendClientMessage(playerid, COLOR_SPECIAL, "* Você subiu de nível no emprego!");
            if(GetPlayerJobLV(playerid) <= sizeof(g_sFisherServices))
                SendClientMessage(playerid, COLOR_SUB_TITLE, "* Você liberou um novo serviço.");
            SetPlayerJobXP(playerid, 0);
            SetPlayerJobLV(playerid, GetPlayerJobLV(playerid) + 1);
            PlayConfirmSound(playerid);
        }
    }
    return 1;
}

//------------------------------------------------------------------------------

timer FishTimer[10000](playerid)
{
    new rand = random(3);
    gplFishs[playerid] += rand;

    if(gplFishs[playerid] >= 10)
        gplFishs[playerid] = 10, rand = 1;

    SendClientMessagef(playerid, COLOR_TITLE, "* Você pescou %d peixes, agora você possuí %d peixes!", rand, gplFishs[playerid]);
    if(gplFishs[playerid] == 10)
    {
        SendClientMessage(playerid, COLOR_SUB_TITLE, "* Você pescou o máximo de peixes que consegue carregar (10), volte e entregue os peixes.");

        if(gplCurrentSC[playerid] != 2)
            SetPlayerRaceCheckpoint(playerid, 2, 396.7126, -2058.4263, 7.8359, 396.7126, -2058.4263, 7.8359, 1.0);
        else
            SetPlayerRaceCheckpoint(playerid, 2, 378.5382, -2095.0498, -0.6554, 378.5382, -2095.0498, -0.6554, 5.0);

        SetPlayerCPID(playerid, CHECKPOINT_FISHER);
    }

    if(!IsPlayerInAnyVehicle(playerid))
        ClearAnimations(playerid);

    gplFishing[playerid] = false;
}
