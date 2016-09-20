/*******************************************************************************
* FILENAME :        modules/job/atm_technical.pwn
*
* DESCRIPTION :
*       Adds technical job to the server.
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

// Amount of XP multipled by job level to level up.
static const REQUIRED_XP = 125;

// Amount of XP multipled by job level the player will recieve for deliver.
static const XP_SCALE = 15;

// Car model
static const g_nCarModel = 552;

// Available services
static const g_sTechnicalServices[][][] =
{
    {2000, "Consertar caixas eletrônicos"}
};

// Car spawns
static const Float:g_fCarSpawns[][] =
{
    {2640.5815, -1969.1792, 13.2475, 269.4641},
    {2653.0166, -1969.0017, 13.2388, 270.6952},
    {2667.2422, -1968.8082, 13.2440, 271.1554},
    {2682.2119, -1968.5063, 13.2350, 271.1554},
    {2698.9282, -1952.0002, 13.2404, 183.3220}
};

// Objects coords
static const Float:g_fAtmObjectSpawns[][] =
{
    {1240.4332, -1735.5450, 13.2760, 0.0000, 0.0000, 183.6000},
    {1497.0391, -1661.9976, 13.6919, 0.0000, 0.0000, 181.6801},
    {1928.6533, -1782.0975, 13.2235, 0.0000, 0.0000, 90.4800},
    {2404.9275, -1512.8546, 23.6609, 0.0000, 0.0000, 90.0001},
    {2139.3643, -1165.9001, 23.6658, 0.0000, 0.0000, 90.7800}
};

// Checkpoints coords
static const Float:g_fAtmCheckpoints[][] =
{
    {1240.4446, -1734.3862, 13.2760},
    {1497.1085, -1660.4584, 13.6919},
    {1929.6310, -1782.2368, 13.2235},
    {2405.9868, -1512.9456, 23.6609},
    {2140.2046, -1165.9263, 23.6658},
    {2695.6824, -1970.3691, 13.5469},
    {0.0,       0.0,        0.0}
};

//------------------------------------------------------------------------------

static gplCar[MAX_PLAYERS] = {INVALID_VEHICLE_ID, ...};
static gplObject[MAX_PLAYERS] = {INVALID_OBJECT_ID, ...};
static gplOldObject[MAX_PLAYERS] = {INVALID_OBJECT_ID, ...};
static gplCurrentCP[MAX_PLAYERS];
static gplCurrentSC[MAX_PLAYERS];
static bool:g_isOnDuty[MAX_PLAYERS];

//------------------------------------------------------------------------------

hook OnGameModeInit()
{
    print("Loading technical job.");
    CreateDynamicPickup(1210, 1, 2700.3381, -1964.1322, 13.5469, 0, 0, -1, MAX_PICKUP_RANGE);
	CreateDynamic3DTextLabel("Técnico\nPressione {1add69}Y", 0xFFFFFFFF, 2700.3381, -1964.1322, 13.5469, MAX_TEXT3D_RANGE, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
    gCheckpointid = CreateDynamicCP(2691.8669, -1964.6219, 13.5469, 1.0, 0, 0);
}

//------------------------------------------------------------------------------

hook OnPlayerDisconnect(playerid, reason)
{
    if(gplCar[playerid] != INVALID_VEHICLE_ID)
    {
        DestroyVehicle(gplCar[playerid]);
        gplCar[playerid] = INVALID_VEHICLE_ID;
    }
    gplCurrentSC[playerid] = 0;

    if(gplObject[playerid] != INVALID_OBJECT_ID)
        DestroyDynamicObject(gplObject[playerid]), gplObject[playerid] = INVALID_OBJECT_ID;

    if(gplOldObject[playerid] != INVALID_OBJECT_ID)
        DestroyDynamicObject(gplOldObject[playerid]), gplOldObject[playerid] = INVALID_OBJECT_ID;
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerDeath(playerid, killerid, reason)
{
    if(gplCar[playerid] != INVALID_VEHICLE_ID)
    {
        DestroyVehicle(gplCar[playerid]);
        gplCar[playerid] = INVALID_VEHICLE_ID;
        SendClientMessage(playerid, COLOR_ERROR, "* Você não conseguiu completar o serviço.");
        DisablePlayerRaceCheckpoint(playerid);
        SetPlayerCPID(playerid, CHECKPOINT_NONE);

        if(gplObject[playerid] != INVALID_OBJECT_ID)
            DestroyDynamicObject(gplObject[playerid]), gplObject[playerid] = INVALID_OBJECT_ID;

        if(gplOldObject[playerid] != INVALID_OBJECT_ID)
            DestroyDynamicObject(gplOldObject[playerid]), gplOldObject[playerid] = INVALID_OBJECT_ID;
        return 1;
    }
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerEnterDynamicCP(playerid, STREAMER_TAG_CP checkpointid)
{
    if(checkpointid == gCheckpointid)
    {
        if(GetPlayerJobID(playerid) != TECHNICAL_JOB_ID)
        {
            PlayErrorSound(playerid);
            SendClientMessage(playerid, COLOR_ERROR, "* Você não é um técnico.");
        }
        else
        {
            PlaySelectSound(playerid);
            new info[300], buffer[60];
            strcat(info, "Serviço\tPagamento\tNível");
            for(new i = 0; i < sizeof(g_sTechnicalServices); i++)
            {
                format(buffer, sizeof(buffer), "\n%s\t$%s\t%i", g_sTechnicalServices[i][1], formatnumber(g_sTechnicalServices[i][0][0]), i+1);
                strcat(info, buffer);
            }
            ShowPlayerDialog(playerid, DIALOG_TECHNICAL_SERVICES,  DIALOG_STYLE_TABLIST_HEADERS, "Técnico -> Serviços", info, "Aceitar", "Recusar");
        }
        return -2;
    }
    return 1;
}

//------------------------------------------------------------------------------

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch(dialogid)
    {
        case DIALOG_TECHNICAL_JOB:
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
                    SetPlayerJobID(playerid, TECHNICAL_JOB_ID);
                    SendClientMessage(playerid, COLOR_SPECIAL, "* Agora você é um técnico!");
                    SendClientMessage(playerid, COLOR_SUB_TITLE, "* Vá ao lado para procurar por serviços.");
                    PlayConfirmSound(playerid);
                }
            }
        }
        case DIALOG_TECHNICAL_SERVICES:
        {
            if(!response)
                PlayCancelSound(playerid);
            else if(gplCar[playerid] != INVALID_VEHICLE_ID || gplCurrentSC[playerid] != 0 || g_isOnDuty[playerid])
                SendClientMessage(playerid, COLOR_ERROR, "* Você já está em um serviço.");
            else if(GetPlayerJobLV(playerid) < listitem+1)
            {
                PlayErrorSound(playerid);
                SendClientMessage(playerid, COLOR_ERROR, "* Você não tem nível de emprego suficiente para este serviço.");
            }
            else
            {
                if(listitem == 0)
                {
                    SendClientMessage(playerid, COLOR_SPECIAL, "* Siga os checkpoints e concerte os caixas eletrônicos.");
                    new rand = random(sizeof(g_fCarSpawns));
                    gplCar[playerid] = CreateVehicle(g_nCarModel, g_fCarSpawns[rand][0], g_fCarSpawns[rand][1], g_fCarSpawns[rand][2], g_fCarSpawns[rand][3], 1, 3, -1);
                    PutPlayerInVehicle(playerid, gplCar[playerid], 0);
                    SetVehicleFuel(gplCar[playerid], 100.0);

                    gplObject[playerid] = CreateDynamicObject(2943, g_fAtmObjectSpawns[0][0], g_fAtmObjectSpawns[0][1], g_fAtmObjectSpawns[0][2], g_fAtmObjectSpawns[0][3], g_fAtmObjectSpawns[0][4], g_fAtmObjectSpawns[0][5], 0, 0, playerid);
                    SetPlayerRaceCheckpoint(playerid, 2, g_fAtmCheckpoints[0][0], g_fAtmCheckpoints[0][1], g_fAtmCheckpoints[0][2], g_fAtmCheckpoints[0][0], g_fAtmCheckpoints[0][1],g_fAtmCheckpoints[0][2], 1.0);
                    SetPlayerCPID(playerid, CHECKPOINT_TECHNICAL);
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

hook OnPlayerEnterRaceCPT(playerid)
{
    if(GetPlayerCPID(playerid) == CHECKPOINT_TECHNICAL)
    {
        new i = ++gplCurrentCP[playerid];
        new f = gplCurrentSC[playerid];
        PlaySelectSound(playerid);
        if(g_fAtmCheckpoints[i][0] == 0.0 && g_fAtmCheckpoints[i][1] == 0.0)
        {
            SendClientMessage(playerid, COLOR_SPECIAL, "* Você terminou o serviço!");

            new output[50];
            format(output, sizeof(output), "* Você recebeu seu pagamento: $%s.", formatnumber(g_sTechnicalServices[f][0][0]));
            SendClientMessage(playerid, COLOR_SUB_TITLE, output);
            GivePlayerCash(playerid, g_sTechnicalServices[f][0][0]);

            DisablePlayerRaceCheckpoint(playerid);

            DestroyVehicle(gplCar[playerid]);
            gplCar[playerid] = INVALID_VEHICLE_ID;
            gplCurrentSC[playerid] = 0;

            if(gplObject[playerid] != INVALID_OBJECT_ID)
                DestroyDynamicObject(gplObject[playerid]), gplObject[playerid] = INVALID_OBJECT_ID;

            if(gplOldObject[playerid] != INVALID_OBJECT_ID)
                DestroyDynamicObject(gplOldObject[playerid]), gplOldObject[playerid] = INVALID_OBJECT_ID;

            SetPlayerCPID(playerid, CHECKPOINT_NONE);
            SetPlayerXP(playerid, GetPlayerXP(playerid) + 1);
            SetPlayerJobXP(playerid, GetPlayerJobXP(playerid) + (GetPlayerJobLV(playerid) * XP_SCALE));
            if(GetPlayerJobXP(playerid) > (GetPlayerJobLV(playerid) * REQUIRED_XP))
            {
                SendClientMessage(playerid, COLOR_SPECIAL, " ");
                SendClientMessage(playerid, COLOR_SPECIAL, "* Você subiu de nível no emprego!");
                if(GetPlayerJobLV(playerid) <= sizeof(g_sTechnicalServices))
                    SendClientMessage(playerid, COLOR_SUB_TITLE, "* Você liberou um novo serviço.");
                SetPlayerJobXP(playerid, 0);
                SetPlayerJobLV(playerid, GetPlayerJobLV(playerid) + 1);
                PlayConfirmSound(playerid);
            }
        }
        else if(i == sizeof(g_fAtmCheckpoints[])-1)
        {
            if(f == 0)
            {
                SetPlayerRaceCheckpoint(playerid, 2, g_fAtmCheckpoints[i][0], g_fAtmCheckpoints[i][1], g_fAtmCheckpoints[i][2], 0.0, 0.0, 0.0, 1.0);
                ApplyAnimation(playerid, "INT_SHOP", "SHOP_LOOP", 4.1, 1, 1, 1, 0, 0, 1);
                GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~g~concertando...", 5000, 3);
                SendClientMessage(playerid, COLOR_TITLE, "* Volte para a empresa para receber.");
                defer Fix(playerid, i);
            }
        }
        else
        {
            if(f == 0)
            {
                SetPlayerRaceCheckpoint(playerid, 2, g_fAtmCheckpoints[i][0], g_fAtmCheckpoints[i][1], g_fAtmCheckpoints[i][2], 0.0, 0.0, 0.0, 1.0);
                ApplyAnimation(playerid, "INT_SHOP", "SHOP_LOOP", 4.1, 1, 1, 1, 0, 0, 1);
                GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~g~concertando...", 5000, 3);

                defer Fix(playerid, i);
            }
        }
        return -2;
    }
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if((newkeys == KEY_YES) && IsPlayerInRangeOfPoint(playerid, 3.0, 2700.3381, -1964.1322, 13.5469))
	{
        ShowPlayerDialog(playerid, DIALOG_TECHNICAL_JOB, DIALOG_STYLE_MSGBOX, "Emprego: Técnico", "Você deseja ser um técnico?", "Sim", "Não");
		return 1;
	}
	return 1;
}

//------------------------------------------------------------------------------


timer Fix[5000](playerid, f)
{
    f--;

    DestroyDynamicObject(gplObject[playerid]);
    gplObject[playerid] = INVALID_OBJECT_ID;

    if(!IsPlayerConnected(playerid))
        return 0;

    if((f+1) < sizeof(g_fAtmObjectSpawns) && f > -1)
    {
        gplOldObject[playerid] = CreateDynamicObject(19324, g_fAtmObjectSpawns[f][0], g_fAtmObjectSpawns[f][1], g_fAtmObjectSpawns[f][2], g_fAtmObjectSpawns[f][3], g_fAtmObjectSpawns[f][4], g_fAtmObjectSpawns[f][5], 0, 0, playerid);
        gplObject[playerid] = CreateDynamicObject(2943, g_fAtmObjectSpawns[f+1][0], g_fAtmObjectSpawns[f+1][1], g_fAtmObjectSpawns[f+1][2], g_fAtmObjectSpawns[f+1][3], g_fAtmObjectSpawns[f+1][4], g_fAtmObjectSpawns[f+1][5], 0, 0, playerid);
    }

    ClearAnimations(playerid);
    defer Reset(playerid);
    return 1;
}

//------------------------------------------------------------------------------

timer Reset[10000](playerid)
{
    if(gplOldObject[playerid] != INVALID_OBJECT_ID) {
        DestroyDynamicObject(gplOldObject[playerid]);
        gplOldObject[playerid] = INVALID_OBJECT_ID;
    }
}
