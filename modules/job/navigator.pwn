/*******************************************************************************
* FILENAME :        modules/job/navigator.pwn
*
* DESCRIPTION :
*       Adds navigator job to the server.
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

// Minimum serivce time in ms
static const MINIMUM_SERVICE_TIME = 450000;

// Checkpointid
static STREAMER_TAG_CP gCheckpointid;

// Amount of XP multipled by job level to level up.
static const REQUIRED_XP = 125;

// Amount of XP multipled by job level the player will recieve for deliver.
static const XP_SCALE = 15;

// Available services
static const g_sNavigatorServices[][][] =
{
    {7500, "Transportar comida"},
    {10000, "Transportar roupas"},
    {15000, "Transportar materiais"},
    {20000, "Transportar armas"},
    {25000, "Transportar dinheiro"}
};

// Services destination
static const Float:g_fNavigatorServices[][] =
{
    {-1589.3778,	156.05010,   0.0493},
    {2098.3931,     -106.2863,   0.0431},
    {2362.2576,	    517.46980,	 0.1323},
    {1628.7311,	    571.38600,   0.0241},
    {1628.7311,	    571.38600,   0.0241}
};

// Boat spawns
static const Float:g_fBoatSpawns[][] =
{
    {2328.0276, -2402.4590, 0.0590, 227.5506},
    {2322.6733, -2408.4851, 0.0721, 227.2060},
    {2316.2969, -2415.3245, 0.3203, 225.4732},
    {2307.6697, -2424.0635, 0.0883, 224.7595},
    {2301.4182, -2430.3838, 0.2091, 223.2098},
    {2293.8931, -2437.3140, 0.2085, 221.9006}
};

// Boat models
static const g_nBoatModel[] =
{
    472, 453, 595, 454, 484
};

//------------------------------------------------------------------------------

static gplCurrentCP[MAX_PLAYERS];
static gplCurrentSC[MAX_PLAYERS];
static gplStartTime[MAX_PLAYERS];
static gplBoat[MAX_PLAYERS] = {INVALID_VEHICLE_ID, ...};

//------------------------------------------------------------------------------

hook OnPlayerDisconnect(playerid, reason)
{
    if(gplBoat[playerid] != INVALID_VEHICLE_ID)
    {
        DestroyVehicle(gplBoat[playerid]);
        gplBoat[playerid] = INVALID_VEHICLE_ID;
    }
    return 1;
}
//------------------------------------------------------------------------------

hook OnPlayerDeath(playerid, killerid, reason)
{
    if(gplBoat[playerid] != INVALID_VEHICLE_ID)
    {
        DestroyVehicle(gplBoat[playerid]);
        gplBoat[playerid] = INVALID_VEHICLE_ID;
        DisablePlayerRaceCheckpoint(playerid);
        SendClientMessage(playerid, COLOR_ERROR, "* Você não conseguiu completar o serviço.");
    }
    return 1;
}

//------------------------------------------------------------------------------

hook OnGameModeInit()
{
    print("Loading navigator job.");
	CreateDynamicPickup(1210, 1, 2280.0159, -2417.9700, 3.0000, 0, 0, -1, MAX_PICKUP_RANGE);
	CreateDynamic3DTextLabel("Navegador\nPressione {1add69}Y", 0xFFFFFFFF, 2280.0159, -2417.9700, 3.0000, MAX_TEXT3D_RANGE, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
    gCheckpointid = CreateDynamicCP(2309.0281, -2385.8604, 3.0000, 1.0, 0, 0);
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerEnterDynamicCP(playerid, STREAMER_TAG_CP checkpointid)
{
    if(checkpointid == gCheckpointid)
    {
        if(GetPlayerJobID(playerid) != NAVIGATOR_JOB_ID)
        {
            PlayErrorSound(playerid);
            SendClientMessage(playerid, COLOR_ERROR, "* Você não é um navegador.");
        }
        else
        {
            PlaySelectSound(playerid);
            new info[300], buffer[60];
            strcat(info, "Serviço\tPagamento\tNível");
            for(new i = 0; i < sizeof(g_sNavigatorServices); i++)
            {
                format(buffer, sizeof(buffer), "\n%s\t$%s\t%i", g_sNavigatorServices[i][1], formatnumber(g_sNavigatorServices[i][0][0]), i+1);
                strcat(info, buffer);
            }
            ShowPlayerDialog(playerid, DIALOG_NAVIGATOR_SERVICES,  DIALOG_STYLE_TABLIST_HEADERS, "Navegador -> Serviços", info, "Aceitar", "Recusar");
        }
        return -2;
    }
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if((newkeys == KEY_YES) && IsPlayerInRangeOfPoint(playerid, 3.0, 2280.0159, -2417.9700, 3.0000))
	{
        if(GetPlayerLevel(playerid) < 2)
        {
            SendClientMessage(playerid, COLOR_ERROR, "* Você precisa ser nível 2.");
        }
        else
        {
            ShowPlayerDialog(playerid, DIALOG_NAVIGATOR_JOB, DIALOG_STYLE_MSGBOX, "Emprego: Navegador", "Você deseja ser um navegador?", "Sim", "Não");
        }
		return 1;
	}
	return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerEnterRaceCPT(playerid)
{
    switch(GetPlayerCPID(playerid))
    {
        case CHECKPOINT_NAVIGATOR:
        {
            if(!IsPlayerInVehicle(playerid, gplBoat[playerid]))
            {
                PlayErrorSound(playerid);
                SendClientMessage(playerid, COLOR_ERROR, "* Você não está em seu barco.");
                return -2;
            }

            PlaySelectSound(playerid);
            if(!gplCurrentCP[playerid])
            {
                gplCurrentCP[playerid]++;
                defer UnfreezePlayer(playerid);
                TogglePlayerControllable(playerid, false);
                GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~w~descarregando...", 5000, 3);
                SetPlayerRaceCheckpoint(playerid, 1, 2306.5503, -2427.2678, 0.0200, 0.0, 0.0, 0.0, 10.0);
                SendClientMessage(playerid, COLOR_SUB_TITLE, "* Traga o barco de volta para receber seu pagamento.");
            }
            else
            {
                SetCameraBehindPlayer(playerid);
                if(gplStartTime[playerid] > GetTickCount())
                {
                    DestroyVehicle(gplBoat[playerid]);
                    DisablePlayerRaceCheckpoint(playerid);
                    gplBoat[playerid] = INVALID_VEHICLE_ID;
                    SendClientMessage(playerid, COLOR_ERROR, "* Devido a suspeita de trapaça, seu serviço não foi registrado.");
                    return -2;
                }

                SetPlayerCPID(playerid, CHECKPOINT_NONE);
                SetPlayerJobXP(playerid, GetPlayerJobXP(playerid) + (GetPlayerJobLV(playerid) * XP_SCALE));
                if(GetPlayerJobXP(playerid) > (GetPlayerJobLV(playerid) * REQUIRED_XP))
                {
                    SetPlayerJobXP(playerid, 0);
                    SetPlayerJobLV(playerid, GetPlayerJobLV(playerid) + 1);
                }

                SendClientMessage(playerid, COLOR_SPECIAL, "* Você terminou o serviço!");

                new output[50];
                format(output, sizeof(output), "* Você recebeu seu pagamento: $%s.", formatnumber(g_sNavigatorServices[gplCurrentSC[playerid]][0][0]));
                SendClientMessage(playerid, COLOR_SUB_TITLE, output);
                GivePlayerCash(playerid, g_sNavigatorServices[gplCurrentSC[playerid]][0][0]);

                DisablePlayerRaceCheckpoint(playerid);
                DestroyVehicle(gplBoat[playerid]);
                gplBoat[playerid] = INVALID_VEHICLE_ID;
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
        case DIALOG_NAVIGATOR_JOB:
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
                    SetPlayerJobID(playerid, NAVIGATOR_JOB_ID);
                    SendClientMessage(playerid, COLOR_SPECIAL, "* Agora você é um navegador!");
                    SendClientMessage(playerid, COLOR_SUB_TITLE, "* Vá atrás da escada procurar por serviços.");
                    PlayConfirmSound(playerid);
                }
            }
        }
        case DIALOG_NAVIGATOR_SERVICES:
        {
            if(!response)
                PlayCancelSound(playerid);
            else if(gplBoat[playerid] != INVALID_VEHICLE_ID)
                SendClientMessage(playerid, COLOR_ERROR, "* Você já está em um serviço.");
            else if(GetPlayerJobLV(playerid) < listitem+1)
            {
                PlayErrorSound(playerid);
                SendClientMessage(playerid, COLOR_ERROR, "* Você não tem nível de emprego suficiente para este serviço.");
            }
            else
            {
                new rand = random(sizeof(g_fBoatSpawns));
                gplBoat[playerid] = CreateVehicle(g_nBoatModel[listitem], g_fBoatSpawns[rand][0], g_fBoatSpawns[rand][1], g_fBoatSpawns[rand][2], g_fBoatSpawns[rand][3], -1, -1, -1);
                SetVehicleFuel(gplBoat[playerid], 100.0);
                PutPlayerInVehicle(playerid, gplBoat[playerid], 0);
                SetCameraBehindPlayer(playerid);

                SetPlayerRaceCheckpoint(playerid, 0, g_fNavigatorServices[listitem][0], g_fNavigatorServices[listitem][1], g_fNavigatorServices[listitem][2], 2306.5503, -2427.2678, 0.0200, 10.0);
                SetPlayerCPID(playerid, CHECKPOINT_NAVIGATOR);

                gplCurrentCP[playerid] = 0;
                gplCurrentSC[playerid] = listitem;
                gplStartTime[playerid] = GetTickCount() + MINIMUM_SERVICE_TIME;

                SendClientMessage(playerid, COLOR_SPECIAL, "* Entregue a carga.");
                PlaySelectSound(playerid);
            }
            return -2;
        }
    }
    return 1;
}
