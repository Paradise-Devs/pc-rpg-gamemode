/*******************************************************************************
* FILENAME :        modules/job/garbage.pwn
*
* DESCRIPTION :
*       Adds garbage job to the server.
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

// Minimum serivce time in ms
static const MINIMUM_SERVICE_TIME = 600000;

// Amount of XP multipled by job level to level up.
static const REQUIRED_XP = 125;

// Amount of XP multipled by job level the player will recieve for deliver.
static const XP_SCALE = 15;

// Truck model
static const g_nTruckModel = 408;

// Available services
static const g_sGarbageServices[][][] =
{
    {1200, "Coletar lixo"},
    {1500, "Reciclar lixo"},
    {12000, "Transportar lixo"}
};

// Services destination
static Float:gGarbageCheckpoints[][][] =
{
    {
        {2298.9539, -2101.1147, 13.8624},
        {2647.0383, -2409.0696, 13.9908},
        {2757.4863, -2456.7590, 14.0348},
        {2510.8328, -2500.6458, 14.0761},
        {2481.7734, -2629.2898, 14.0251},
        {2228.5701, -2617.9771, 13.9379},
        {2308.2920, -2358.1396, 13.9024},
        {2254.6841, -2217.1396, 13.8625},
        {2274.9158, -2093.7158, 14.0436},
        {2183.8413, -1978.3206, 14.1079},
        {0.0,       0.0,        0.0}
    },
    {
        {2194.4797, -1969.3091, 13.7841},
        {2192.4099, -1985.8644, 13.5506},
        {2194.4744, -1969.3270, 13.7841},
        {0.0,       0.0,        0.0},
        {0.0,       0.0,        0.0},
        {0.0,       0.0,        0.0},
        {0.0,       0.0,        0.0},
        {0.0,       0.0,        0.0},
        {0.0,       0.0,        0.0},
        {0.0,       0.0,        0.0},
        {0.0,       0.0,        0.0}
    },
    {
        {-1884.5793, -1702.4432, 21.7500},
        {2183.8413,  -1978.3206, 14.1079},
        {0.0,        0.0,        0.0},
        {0.0,        0.0,        0.0},
        {0.0,        0.0,        0.0},
        {0.0,        0.0,        0.0},
        {0.0,        0.0,        0.0},
        {0.0,        0.0,        0.0},
        {0.0,        0.0,        0.0},
        {0.0,        0.0,        0.0},
        {0.0,        0.0,        0.0}
    }
};

// Truck spawns
static const Float:g_fTruckSpawns[][] =
{
    {2129.1328, -1971.3038, 14.0908, 230.5886},
    {2137.8606, -1971.1577, 14.0965, 236.0211},
    {2147.7615, -1971.4302, 14.1010, 240.5255},
    {2155.3765, -1970.9470, 14.1066, 241.4003}
};

//------------------------------------------------------------------------------

static gplCurrentCP[MAX_PLAYERS];
static gplCurrentSC[MAX_PLAYERS];
static gplStartTime[MAX_PLAYERS];
static gplTruck[MAX_PLAYERS] = {INVALID_VEHICLE_ID, ...};

//------------------------------------------------------------------------------

hook OnPlayerDisconnect(playerid, reason)
{
    if(gplTruck[playerid] != INVALID_VEHICLE_ID)
    {
        DestroyVehicle(gplTruck[playerid]);
        gplTruck[playerid] = INVALID_VEHICLE_ID;
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
        DisablePlayerRaceCheckpoint(playerid);
        SendClientMessage(playerid, COLOR_ERROR, "* Você não conseguiu completar o serviço.");
    }
    return 1;
}

//------------------------------------------------------------------------------

hook OnVehicleSpawn(vehicleid)
{
    foreach(new i: Player)
    {
        if(gplTruck[i] == vehicleid)
        {
            DestroyVehicle(gplTruck[i]);
            gplTruck[i] = INVALID_VEHICLE_ID;
            DisablePlayerRaceCheckpoint(i);
            SendClientMessage(i, COLOR_ERROR, "* Você não conseguiu completar o serviço.");
            SendClientMessage(i, COLOR_ERROR, "* Seu caminhão foi destruido, você teve que pagar R$2.000 pelo concerto.");
            GivePlayerCash(i, -2000);
        }
    }
    return 1;
}

//------------------------------------------------------------------------------

hook OnGameModeInit()
{
    print("Loading garbage job.");
	CreateDynamicPickup(1210, 1, 2195.4722, -1973.8459, 13.5590, 0, 0, -1, MAX_PICKUP_RANGE);
	CreateDynamic3DTextLabel("Lixeiro\nPressione {1add69}Y", 0xFFFFFFFF, 2195.4722, -1973.8459, 13.5590, MAX_TEXT3D_RANGE, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
    gCheckpointid = CreateDynamicCP(2201.0278, -1970.2985, 13.7841, 1.0, 0, 0);
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerEnterDynamicCP(playerid, STREAMER_TAG_CP checkpointid)
{
    if(checkpointid == gCheckpointid)
    {
        if(GetPlayerJobID(playerid) != GARBAGE_JOB_ID)
        {
            PlayErrorSound(playerid);
            SendClientMessage(playerid, COLOR_ERROR, "* Você não é um lixeiro.");
        }
        else
        {
            PlaySelectSound(playerid);
            new info[300], buffer[60];
            strcat(info, "Serviço\tPagamento\tNível");
            for(new i = 0; i < sizeof(g_sGarbageServices); i++)
            {
                format(buffer, sizeof(buffer), "\n%s\t$%s\t%i", g_sGarbageServices[i][1], formatnumber(g_sGarbageServices[i][0][0]), i+1);
                strcat(info, buffer);
            }
            ShowPlayerDialog(playerid, DIALOG_GARBAGE_SERVICES,  DIALOG_STYLE_TABLIST_HEADERS, "Lixeiro -> Serviços", info, "Aceitar", "Recusar");
        }
        return -2;
    }
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if((newkeys == KEY_YES) && IsPlayerInRangeOfPoint(playerid, 3.0, 2195.4722, -1973.8459, 13.5590))
	{
        ShowPlayerDialog(playerid, DIALOG_GARBAGE_JOB, DIALOG_STYLE_MSGBOX, "Emprego: Lixeiro", "Você deseja ser um lixeiro?", "Sim", "Não");
		return 1;
	}
	return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerEnterRaceCPT(playerid)
{
    if(GetPlayerCPID(playerid) == CHECKPOINT_GARBAGE)
    {
        new i = ++gplCurrentCP[playerid];
        new f = gplCurrentSC[playerid];
        PlaySelectSound(playerid);
        if(gGarbageCheckpoints[f][i][0] == 0.0 && gGarbageCheckpoints[f][i][1] == 0.0)
        {
            SendClientMessage(playerid, COLOR_SPECIAL, "* Você terminou o serviço!");

            if(gplStartTime[playerid] > tickcount())
            {
                DestroyVehicle(gplTruck[playerid]);
                DisablePlayerRaceCheckpoint(playerid);
                SetPlayerCPID(playerid, CHECKPOINT_NONE);
                gplTruck[playerid] = INVALID_VEHICLE_ID;
                SendClientMessage(playerid, COLOR_ERROR, "* Devido a suspeita de trapaça, seu serviço não foi registrado.");
                return -2;
            }

            new output[50];
            format(output, sizeof(output), "* Você recebeu seu pagamento: $%s.", formatnumber(g_sGarbageServices[f][0][0]));
            SendClientMessage(playerid, COLOR_SUB_TITLE, output);
            GivePlayerCash(playerid, g_sGarbageServices[f][0][0]);

            DisablePlayerRaceCheckpoint(playerid);

            DestroyVehicle(gplTruck[playerid]);
            gplTruck[playerid] = INVALID_VEHICLE_ID;

            SetPlayerCPID(playerid, CHECKPOINT_NONE);
            SetPlayerJobXP(playerid, GetPlayerJobXP(playerid) + (GetPlayerJobLV(playerid) * XP_SCALE));
            if(GetPlayerJobXP(playerid) > (GetPlayerJobLV(playerid) * REQUIRED_XP))
            {
                SendClientMessage(playerid, COLOR_SPECIAL, " ");
                SendClientMessage(playerid, COLOR_SPECIAL, "* Você subiu de nível no emprego!");
                if(GetPlayerJobLV(playerid) <= sizeof(g_sGarbageServices))
                    SendClientMessage(playerid, COLOR_SUB_TITLE, "* Você liberou um novo serviço.");
                SetPlayerJobXP(playerid, 0);
                SetPlayerJobLV(playerid, GetPlayerJobLV(playerid) + 1);
                PlayConfirmSound(playerid);
            }
        }
        else if(i == sizeof(gGarbageCheckpoints[])-1)
        {
            if(f == 0 || f == 2)
            {
                SetPlayerRaceCheckpoint(playerid, 1, gGarbageCheckpoints[f][i][0], gGarbageCheckpoints[f][i][1], gGarbageCheckpoints[f][i][2], 0.0, 0.0, 0.0, 2.5);
                defer UnfreezePlayer(playerid);
                TogglePlayerControllable(playerid, false);
                GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~g~descarregando...", 5000, 3);
            }
            else
            {
                defer Recycle(playerid, f, i, 1);
                GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~g~finalizando...", 15000, 3);
                ApplyAnimation(playerid, "INT_SHOP", "SHOP_LOOP", 4.1, 1, 1, 1, 0, 0, 1);
                DisablePlayerRaceCheckpoint(playerid);
            }
        }
        else
        {
            if(f == 0 || f == 2)
            {
                SetPlayerRaceCheckpoint(playerid, 0, gGarbageCheckpoints[f][i][0], gGarbageCheckpoints[f][i][1], gGarbageCheckpoints[f][i][2], gGarbageCheckpoints[f][i+1][0], gGarbageCheckpoints[f][i+1][1], gGarbageCheckpoints[f][i+1][2], 2.5);
                defer UnfreezePlayer(playerid);
                TogglePlayerControllable(playerid, false);
                GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~g~coletando...", 5000, 3);
            }
            else
            {
                defer Recycle(playerid, f, i, 0);
                GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~g~reciclando...", 15000, 3);
                ApplyAnimation(playerid, "INT_SHOP", "SHOP_LOOP", 4.1, 1, 1, 1, 0, 0, 1);
                DisablePlayerRaceCheckpoint(playerid);
            }
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
        case DIALOG_GARBAGE_JOB:
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
                    SetPlayerJobID(playerid, GARBAGE_JOB_ID);
                    SendClientMessage(playerid, COLOR_SPECIAL, "* Agora você é um lixeiro!");
                    SendClientMessage(playerid, COLOR_SUB_TITLE, "* Vá dentro do container procurar por serviços.");
                    PlayConfirmSound(playerid);
                }
            }
        }
        case DIALOG_GARBAGE_SERVICES:
        {
            if(!response)
                PlayCancelSound(playerid);
            else if(gplTruck[playerid] != INVALID_VEHICLE_ID)
                SendClientMessage(playerid, COLOR_ERROR, "* Você já está em um serviço.");
            else if(GetPlayerJobLV(playerid) < listitem+1)
            {
                PlayErrorSound(playerid);
                SendClientMessage(playerid, COLOR_ERROR, "* Você não tem nível de emprego suficiente para este serviço.");
            }
            else
            {
                SendClientMessage(playerid, COLOR_SPECIAL, "* Siga os checkpoints para completar o serviço.");
                if(listitem != 1)
                {
                    new rand = random(sizeof(g_fTruckSpawns));
                    gplTruck[playerid] = CreateVehicle(g_nTruckModel, g_fTruckSpawns[rand][0], g_fTruckSpawns[rand][1], g_fTruckSpawns[rand][2], g_fTruckSpawns[rand][3], -1, -1, -1);
                    PutPlayerInVehicle(playerid, gplTruck[playerid], 0);
                    SetVehicleFuel(gplTruck[playerid], 100.0);
                    SendClientMessage(playerid, COLOR_SUB_TITLE, "* Caso você destrua o caminhão será descontado de seu dinheiro.");
                }

                gplCurrentCP[playerid] = 0;
                gplCurrentSC[playerid] = listitem;

                if(listitem == 2)
                    gplStartTime[playerid] = tickcount() + MINIMUM_SERVICE_TIME;

                SetPlayerRaceCheckpoint(playerid, 0, gGarbageCheckpoints[listitem][0][0], gGarbageCheckpoints[listitem][0][1], gGarbageCheckpoints[listitem][0][2], gGarbageCheckpoints[listitem][1][0], gGarbageCheckpoints[listitem][1][1], gGarbageCheckpoints[listitem][1][2], 2.5);
                SetPlayerCPID(playerid, CHECKPOINT_GARBAGE);
            }
            return -2;
        }
    }
    return 1;
}

//------------------------------------------------------------------------------

timer Recycle[15000](playerid, f, i, last)
{
    new rand = random(3);

    if(rand == 1 || last == 1)
    {
        ClearAnimations(playerid);
        SetPlayerRaceCheckpoint(playerid, 2, gGarbageCheckpoints[f][i][0], gGarbageCheckpoints[f][i][1], gGarbageCheckpoints[f][i][2], gGarbageCheckpoints[f][i+1][0], gGarbageCheckpoints[f][i+1][1], gGarbageCheckpoints[f][i+1][2], 1.0);
    }
    else
    {
        defer Recycle(playerid, f, i, 0);
        GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~g~reciclando...", 15000, 3);
        SendClientMessage(playerid, COLOR_SPECIAL, "* Você falhou a reciclagem, tentando novamente...");
    }
}
