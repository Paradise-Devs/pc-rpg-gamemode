/*******************************************************************************
* FILENAME :        modules/job/lumberjack.pwn
*
* DESCRIPTION :
*       Adds lumberjack job to the server.
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
static const XP_SCALE = 5;

// Truck spawns
static const Float:g_fTruckPositions[][] =
{
    {-60.2119,  -1131.3918, 1.7022, 66.9555},
    {-62.1630,  -1135.5721, 1.7756, 67.2424},
    {-63.9874,  -1140.1875, 1.7036, 66.4234},
    {-50.2119,  -1135.3918, 1.7022, 66.9555},
    {-52.1630,  -1139.5721, 1.7756, 67.2424},
    {-53.8657,  -1144.4619, 1.7081, 66.9230},
    {-40.2119,  -1139.3918, 1.7022, 66.9555},
    {-42.1630,  -1143.5721, 1.7756, 67.2424},
    {-43.8657,  -1148.4619, 1.7081, 66.9230}
};

// Trees
static const Float:g_fTreePositions[][] =
{
    {-57.4415,  -1178.8361, 2.5063},
    {-45.4158,  -1187.4178, 3.9320},
    {-54.8692,  -1198.9314, 3.6370},
    {-49.0132,  -1214.4027, 4.2994},
    {-64.2599,  -1212.8302, 3.3633}
};

// Available services
static g_sLumberServices[][][] =
{
    {1000, "Transportar para madeireira"},
    {2500, "Transportar para construção"},
    {5000, "Transportar para fazenda"},
    {10000, "Transportar para Las Venturas"}
};

// Services destination
static Float:g_fLumberServices[][] =
{
    {-528.9730, -190.2834, 78.9779},
    {-528.9730, -190.2834, 78.9779},
    {-528.9730, -190.2834, 78.9779},
    {-528.9730, -190.2834, 78.9779}
};

//------------------------------------------------------------------------------

static gSpawnPositions[9] = {INVALID_PLAYER_ID, ...};

//------------------------------------------------------------------------------

static gplCurrentCP[MAX_PLAYERS];
static gplCurrentSC[MAX_PLAYERS];
static gplAttachmentIndex[MAX_PLAYERS];
static bool:gplIsLoading[MAX_PLAYERS] = {true, ...};
static gplTruck[MAX_PLAYERS] = {INVALID_VEHICLE_ID, ...};
static gplObj[MAX_PLAYERS][5];

//------------------------------------------------------------------------------

hook OnPlayerDisconnect(playerid, reason)
{
    if(gplTruck[playerid] != INVALID_VEHICLE_ID)
    {
        DestroyVehicle(gplTruck[playerid]);
        gplTruck[playerid] = INVALID_VEHICLE_ID;

        for(new i = 0; i < sizeof(gplObj[]); i++)
        {
            if(gplObj[playerid][i] != INVALID_OBJECT_ID)
            {
                DestroyDynamicObject(gplObj[playerid][i]);
                gplObj[playerid][i] = INVALID_OBJECT_ID;
            }
        }

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

        for(new i = 0; i < sizeof(gplObj[]); i++)
        {
            if(gplObj[playerid][i] != INVALID_OBJECT_ID)
            {
                DestroyDynamicObject(gplObj[playerid][i]);
                gplObj[playerid][i] = INVALID_OBJECT_ID;
            }
        }

        for(new i = 0; i < sizeof(gSpawnPositions); i++)
        {
            if(gSpawnPositions[i] == playerid)
            {
                gSpawnPositions[i] = INVALID_PLAYER_ID;
                break;
            }
        }

        DisablePlayerRaceCheckpoint(playerid);
        SendClientMessage(playerid, COLOR_ERROR, "* Você não conseguiu completar o serviço.");
    }
    return 1;
}

//------------------------------------------------------------------------------

hook OnGameModeInit()
{
    print("Loading lumberjack job.");
	CreateDynamicPickup(1210, 1, -77.3012, -1136.5502, 1.0781, 0, 0, -1, MAX_PICKUP_RANGE);
	CreateDynamic3DTextLabel("Lenhador\nPressione {1add69}Y", 0xFFFFFFFF, -77.3012, -1136.5502, 1.0781, MAX_TEXT3D_RANGE, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
    gCheckpointid = CreateDynamicCP(-35.3831, -1126.4756, 1.0781, 1.0, 0, 0);
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerEnterDynamicCP(playerid, STREAMER_TAG_CP checkpointid)
{
    if(checkpointid == gCheckpointid)
    {
        if(GetPlayerJobID(playerid) != LUMBERJACK_JOB_ID)
        {
            PlayErrorSound(playerid);
            SendClientMessage(playerid, COLOR_ERROR, "* Você não é um lenhador.");
        }
        else
        {
            PlaySelectSound(playerid);
            new info[300], buffer[60];
            strcat(info, "Serviço\tPagamento\tNível");
            for(new i = 0; i < sizeof(g_sLumberServices); i++)
            {
                format(buffer, sizeof(buffer), "\n%s\t$%s\t%i", g_sLumberServices[i][1], formatnumber(g_sLumberServices[i][0][0]), i+1);
                strcat(info, buffer);
            }
            ShowPlayerDialog(playerid, DIALOG_LUMBER_SERVICES,  DIALOG_STYLE_TABLIST_HEADERS, "Lenhador -> Serviços", info, "Aceitar", "Recusar");
        }
        return -2;
    }
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if((newkeys == KEY_YES) && IsPlayerInRangeOfPoint(playerid, 3.0, -77.3012, -1136.5502, 1.0781))
	{
        ShowPlayerDialog(playerid, DIALOG_LUMBERJACK_JOB, DIALOG_STYLE_MSGBOX, "Emprego: Lenhador", "Você deseja ser um lenhador?", "Sim", "Não");
		return 1;
	}
	return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerEnterRaceCPT(playerid)
{
    switch(GetPlayerCPID(playerid))
    {
        case CHECKPOINT_LUMBER:
        {
            PlaySelectSound(playerid);
            if(gplCurrentCP[playerid] < sizeof(g_fTreePositions) || (gplCurrentCP[playerid] == sizeof(g_fTreePositions) && gplIsLoading[playerid]))
            {
                if(IsPlayerInAnyVehicle(playerid))
                    return SendClientMessage(playerid, COLOR_ERROR, "* Você não pode fazer isso em um veículo.");

                if(gplIsLoading[playerid])
                {
                    defer OnPlayerCutTree(playerid);
                    TogglePlayerControllable(playerid, false);
                    GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~w~cortando...", 5000, 3);
                    ApplyAnimation(playerid, "BASEBALL", "BAT_4", 4.1, 1, 1, 1, 1, 0, 1);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_SPECIAL, "* Colete mais madeira.");
                    RemovePlayerAttachedObject(playerid, gplAttachmentIndex[playerid]);
                    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);

                    for(new i = 0; i < sizeof(gplObj[]); i++)
                    {
                        if(gplObj[playerid][i] == INVALID_OBJECT_ID)
                        {
                            new Float:OffsetY = 1.5 - (i * 1.5);
                            gplObj[playerid][i] = CreateDynamicObject(1463, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
                            AttachDynamicObjectToVehicle(gplObj[playerid][i], gplTruck[playerid], 0.0, OffsetY, 0.0, 0.0, 0.0, 0.0);
                            break;
                        }
                    }

                    new Float:x, Float:y, Float:z;
                    GetVehiclePos(gplTruck[playerid], x, y, z);
                    SetPlayerRaceCheckpoint(playerid, 0, g_fTreePositions[gplCurrentCP[playerid]][0], g_fTreePositions[gplCurrentCP[playerid]][1], g_fTreePositions[gplCurrentCP[playerid]][2], x, y, z, 1.0);
                    gplCurrentCP[playerid]++;
                    gplIsLoading[playerid] = true;
                }
            }
            else if(gplCurrentCP[playerid] == sizeof(g_fTreePositions))
            {
                if(IsPlayerInAnyVehicle(playerid))
                    return SendClientMessage(playerid, COLOR_ERROR, "* Você não pode fazer isso em um veículo.");

                RemovePlayerAttachedObject(playerid, gplAttachmentIndex[playerid]);
                SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);

                for(new i = 0; i < sizeof(gplObj[]); i++)
                {
                    if(gplObj[playerid][i] == INVALID_OBJECT_ID)
                    {
                        new Float:OffsetY = 1.5 - (i * 1.5);
                        gplObj[playerid][i] = CreateDynamicObject(1463, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
                        AttachDynamicObjectToVehicle(gplObj[playerid][i], gplTruck[playerid], 0.0, OffsetY, 0.0, 0.0, 0.0, 0.0);
                        break;
                    }
                }

                for(new i = 0; i < sizeof(gSpawnPositions); i++)
                {
                    if(gSpawnPositions[i] == playerid)
                    {
                        gSpawnPositions[i] = INVALID_PLAYER_ID;
                        break;
                    }
                }

                new engine, lights, alarm, doors, bonnet, boot, objective;
                GetVehicleParamsEx(gplTruck[playerid], engine, lights, alarm, doors, bonnet, boot, objective);
                SetVehicleParamsEx(gplTruck[playerid], engine, lights, alarm, VEHICLE_PARAMS_OFF, bonnet, boot, objective);

                SendClientMessage(playerid, COLOR_SPECIAL, "* Leve a madeira ao destino.");
                SetPlayerRaceCheckpoint(playerid, 0, g_fLumberServices[gplCurrentSC[playerid]][0], g_fLumberServices[gplCurrentSC[playerid]][1], g_fLumberServices[gplCurrentSC[playerid]][2], -79.4407, -1126.8350, 1.7517, 5.0);
                gplCurrentCP[playerid]++;
            }
            else if(gplCurrentCP[playerid] == sizeof(g_fTreePositions)+1)
            {
                if(!IsPlayerInVehicle(playerid, gplTruck[playerid]))
                    return SendClientMessage(playerid, COLOR_ERROR, "* Você não está em seu caminhão.");

                defer OnUnloadTruck(playerid);
                TogglePlayerControllable(playerid, false);
                GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~w~descarregando...", 5000, 3);
                SetPlayerRaceCheckpoint(playerid, 1, -79.4407, -1126.8350, 1.7517, 0.0, 0.0, 0.0, 5.0);
                gplCurrentCP[playerid]++;
            }
            else
            {
                if(!IsPlayerInVehicle(playerid, gplTruck[playerid]))
                    return SendClientMessage(playerid, COLOR_ERROR, "* Você não está em seu caminhão.");

                SetPlayerCPID(playerid, CHECKPOINT_NONE);
                SetPlayerJobXP(playerid, GetPlayerJobXP(playerid) + (GetPlayerJobLV(playerid) * XP_SCALE));
                if(GetPlayerJobXP(playerid) > (GetPlayerJobLV(playerid) * REQUIRED_XP))
                {
                    SetPlayerJobXP(playerid, 0);
                    SetPlayerJobLV(playerid, GetPlayerJobLV(playerid) + 1);
                }

                SendClientMessage(playerid, COLOR_SPECIAL, "* Você terminou o serviço!");

                new output[50];
                format(output, sizeof(output), "* Você recebeu seu pagamento: $%s.", formatnumber(g_sLumberServices[gplCurrentSC[playerid]][0][0]));
                SendClientMessage(playerid, COLOR_SUB_TITLE, output);
                GivePlayerCash(playerid, g_sLumberServices[gplCurrentSC[playerid]][0][0]);

                DisablePlayerRaceCheckpoint(playerid);
                DestroyVehicle(gplTruck[playerid]);
                gplTruck[playerid] = INVALID_VEHICLE_ID;
            }
        }
    }
    return 1;
}

//------------------------------------------------------------------------------

timer OnUnloadTruck[5000](playerid)
{
    if(!IsPlayerLogged(playerid))
        return 1;

    TogglePlayerControllable(playerid, true);
    SendClientMessage(playerid, COLOR_SPECIAL, "* Traga o caminhão de volta para receber o pagamento.");
    PlaySelectSound(playerid);
    for(new i = 0; i < sizeof(gplObj[]); i++)
    {
        if(gplObj[playerid][i] != INVALID_OBJECT_ID)
        {
            DestroyDynamicObject(gplObj[playerid][i]);
            gplObj[playerid][i] = INVALID_OBJECT_ID;
        }
    }
    return 1;
}

//------------------------------------------------------------------------------

timer OnPlayerCutTree[5000](playerid)
{
    if(!IsPlayerLogged(playerid))
        return 1;

    TogglePlayerControllable(playerid, true);
    ClearAnimations(playerid);
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
    SendClientMessage(playerid, COLOR_SUB_TITLE, "* Traga a madeira para o caminhão.");
    gplIsLoading[playerid] = false;

    new Float:x, Float:y, Float:z;
    GetVehiclePos(gplTruck[playerid], x, y, z);
    SetPlayerRaceCheckpoint(playerid, 0, x-1.0, y-2.0, z, g_fTreePositions[0][0], g_fTreePositions[0][1], g_fTreePositions[0][2], 1.0);

    for(new i=7; i<MAX_PLAYER_ATTACHED_OBJECTS; i++)
    {
        if(!IsPlayerAttachedObjectSlotUsed(playerid, i))
        {
            SetPlayerAttachedObject(playerid, i, 1463, 1, 0.20, 0.36, 0.0, 0.0, 90.0, 0.0, 0.4, 0.3, 0.6);
            gplAttachmentIndex[playerid] = i;
            break;
        }
    }
    return 1;
}

//------------------------------------------------------------------------------

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch(dialogid)
    {
        case DIALOG_LUMBERJACK_JOB:
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
                    SetPlayerJobID(playerid, LUMBERJACK_JOB_ID);
                    SendClientMessage(playerid, COLOR_SPECIAL, "* Agora você é um lenhador!");
                    SendClientMessage(playerid, COLOR_SUB_TITLE, "* Vá atrás do galpão procurar por serviços.");
                    PlayConfirmSound(playerid);
                }
            }
        }
        case DIALOG_LUMBER_SERVICES:
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
                    SendClientMessage(playerid, COLOR_ERROR, "* As vagas dos caminhões estão ocupadas, aguarde um jogador terminar de cortar madeira.");
                    return 1;
                }

                gSpawnPositions[rand] = playerid;
                gplTruck[playerid] = CreateVehicle(578, g_fTruckPositions[rand][0], g_fTruckPositions[rand][1], g_fTruckPositions[rand][2], g_fTruckPositions[rand][3], -1, -1, -1);
                SetVehicleFuel(gplTruck[playerid], 100.0);

                for(new i = 0; i < sizeof(gplObj[]); i++)
                    gplObj[playerid][i] = INVALID_OBJECT_ID;

                new engine, lights, alarm, doors, bonnet, boot, objective;
                GetVehicleParamsEx(gplTruck[playerid], engine, lights, alarm, doors, bonnet, boot, objective);
                SetVehicleParamsEx(gplTruck[playerid], engine, lights, alarm, VEHICLE_PARAMS_ON, bonnet, boot, objective);

                SetPlayerRaceCheckpoint(playerid, 0, g_fTreePositions[0][0], g_fTreePositions[0][1], g_fTreePositions[0][2], g_fTruckPositions[rand][0], g_fTruckPositions[rand][1], g_fTruckPositions[rand][2], 1.0);
                SetPlayerCPID(playerid, CHECKPOINT_LUMBER);

                gplCurrentSC[playerid] = listitem;
                gplCurrentCP[playerid] = 1;

                SendClientMessage(playerid, COLOR_SPECIAL, "* Colete madeira.");
                PlaySelectSound(playerid);
            }
            return -2;
        }
    }
    return 1;
}

//------------------------------------------------------------------------------
