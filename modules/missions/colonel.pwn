/*******************************************************************************
* FILENAME :        modules/missions/colonel.pwn
*
* DESCRIPTION :
*       Adds house invasion mission to the server.
*
* NOTES :
*       Players can talk to ryder to ask for missions of house invasion.
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

// Actor ID
static gActorid;

// Checkpoint ID
static STREAMER_TAG_CP gCheckpointid;

// Vehicle ID
static g_pVehicleID[MAX_PLAYERS] = {INVALID_VEHICLE_ID, ...};

// Entering CPs
static STREAMER_TAG_CP gEnteringCP[MAX_PLAYERS][2];

// Part of mission
static gplCurrentCP[MAX_PLAYERS];

// Tickcount for CP
static gplCPtickcount[MAX_PLAYERS];

// Player Colonel Actor
static gColonelActorID[MAX_PLAYERS] = {INVALID_ACTOR_ID, ...};

// Player Objects
static gplObjects[MAX_PLAYERS][6];

// Player Text3D
static Text3D:gplTexts3D[MAX_PLAYERS][6];

// Attachment index
static gplAttachmentIndex[MAX_PLAYERS];

// Is player carrying box
static bool:gplIsCarrying[MAX_PLAYERS];

// Amount of loaded objects
static gplLoadedObj[MAX_PLAYERS];

//------------------------------------------------------------------------------

static const Float:g_fObjectSpawns[][] =
{
    {2803.72314, -1161.26672, 1028.28613, 0.00000, 0.00000, 0.0000000},
    {2812.77051, -1168.82214, 1028.28613, 0.00000, 0.00000, 180.00000},
    {2816.92798, -1164.94678, 1028.28613, 0.00000, 0.00000, 0.0000000},
    {2819.59717, -1170.68005, 1028.28613, 0.00000, 0.00000, 180.00000},
    {2812.64673, -1172.56079, 1024.67639, 0.00000, 0.00000, 180.00000},
    {2820.35132, -1165.96423, 1024.69434, 0.00000, 0.00000, 270.00000}
};

//------------------------------------------------------------------------------

hook OnGameModeInit()
{
    gActorid = CreateActor(271, 2463.6670, -1688.3129, 13.5152, 354.9363);
	ApplyActorAnimation(gActorid, "COP_AMBIENT", "COPLOOK_LOOP", 4.1, 1, 0, 0, 1, 0);

    gCheckpointid = CreateDynamicCP(2463.6123, -1687.6267, 13.5219, 1.0, 0, 0);
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerEnterDynamicCP(playerid, STREAMER_TAG_CP checkpointid)
{
    if(checkpointid == gCheckpointid)
    {
        new info[130];
		format(info, sizeof(info), "Eaí %s,\n\nTa afim de cumprir um serviço pra mim. nigga?\nNegócio simples... Ir, pegar, voltar.", GetPlayerNamef(playerid));
		ShowPlayerDialog(playerid, DIALOG_COLONEL_MISSION, DIALOG_STYLE_MSGBOX, "Ryder -> Missão", info, "Sim", "Não");
        PlaySelectSound(playerid);
        return -2;
    }
    else if(checkpointid == gEnteringCP[playerid][0] && gEnteringCP[playerid][0] != 0 && gplCPtickcount[playerid] < tickcount())
    {
        SetPlayerPos(playerid, 2807.6067, -1174.5070, 1025.5703);
        SetPlayerFacingAngle(playerid, 12.9679);
        SetPlayerInterior(playerid, 8);
        SetPlayerVirtualWorld(playerid, playerid);

        if(gColonelActorID[playerid] == INVALID_ACTOR_ID)
        {
            gColonelActorID[playerid] = CreateActor(62, 2817.4827, -1169.0739, 1029.9033, 266.9666);
            ApplyActorAnimation(gColonelActorID[playerid], "CRACK", "CRCKIDLE2", 4.1, 1, 0, 0, 1, 0);
            SetActorVirtualWorld(gColonelActorID[playerid], playerid);
        }

        gplCPtickcount[playerid] = tickcount() + 1500;
    }
    else if(checkpointid == gEnteringCP[playerid][1] && gEnteringCP[playerid][1] != 0 && gplCPtickcount[playerid] < tickcount())
    {
        SetPlayerPos(playerid, 2807.8914, -1176.0724, 25.3853);
        SetPlayerFacingAngle(playerid, 175.5660);
        SetPlayerInterior(playerid, 0);
        SetPlayerVirtualWorld(playerid, 0);
        gplCPtickcount[playerid] = tickcount() + 1500;
    }
    return 1;
}

//------------------------------------------------------------------------------

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch(dialogid)
    {
        case DIALOG_COLONEL_MISSION:
        {
            if(!response)
                PlayCancelSound(playerid);
            else
            {
				if(IsPlayerInMission(playerid))
				{
					SendClientMessage(playerid, COLOR_ERROR, "* Você já está em uma missão.");
					return -1;
				}

                g_pVehicleID[playerid] = CreateVehicle(498, 2473.4927, -1693.4933, 13.5833, 359.4650, 0, 0, -1);
                SetVehicleFuel(g_pVehicleID[playerid], 100.0);
                PutPlayerInVehicle(playerid, g_pVehicleID[playerid], 0);
                SetPlayerRaceCheckpoint(playerid, 1, 2837.1470, -1182.6567, 24.6219, 0.0, 0.0, 0.0, 10.0);

                SendClientMessage(playerid, COLOR_TITLE, "* Leve o Boxville até o local indicado.");

                gplCurrentCP[playerid] = 0;
                gplLoadedObj[playerid] = 0;
                gplIsCarrying[playerid] = false;

                SetPlayerCPID(playerid, CHECKPOINT_COLONEL);
				SetPlayerMission(playerid, MISSION_COLONEL);
            }
            return -1;
        }
    }
    return 1;
}

//------------------------------------------------------------------------------

static DestroyMissionObjects(playerid)
{
    if(gColonelActorID[playerid] != INVALID_ACTOR_ID)
    {
        DestroyActor(gColonelActorID[playerid]);
        gColonelActorID[playerid] = INVALID_ACTOR_ID;
    }

    if(g_pVehicleID[playerid] != INVALID_VEHICLE_ID)
    {
        DestroyVehicle(g_pVehicleID[playerid]);
        g_pVehicleID[playerid] = INVALID_VEHICLE_ID;
    }

    if(gEnteringCP[playerid][0] != 0)
    {
        DestroyDynamicCP(gEnteringCP[playerid][0]);
        DestroyDynamicCP(gEnteringCP[playerid][1]);

        gEnteringCP[playerid][0] = 0;
        gEnteringCP[playerid][1] = 0;
    }

    for(new i = 0; i < sizeof(gplObjects[]); i++)
    {
        if(gplObjects[playerid][i] != 0)
            DestroyDynamicObject(gplObjects[playerid][i]);

        gplObjects[playerid][i] = 0;
    }

    for(new i = 0; i < sizeof(gplTexts3D[]); i++)
    {
        if(gplTexts3D[playerid][i] != Text3D:0)
            DestroyDynamic3DTextLabel(gplTexts3D[playerid][i]);

        gplTexts3D[playerid][i] = Text3D:0;
    }
}

//------------------------------------------------------------------------------

hook OnPlayerDisconnect(playerid, reason)
{
    DestroyMissionObjects(playerid);
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(g_pVehicleID[playerid] == INVALID_VEHICLE_ID)
        return 1;

    if(!gplIsCarrying[playerid])
    {
        for(new i = 0; i < sizeof(g_fObjectSpawns); i++)
        {
            if((newkeys == KEY_YES) && IsPlayerInRangeOfPoint(playerid, 1.5, g_fObjectSpawns[i][0], g_fObjectSpawns[i][1], g_fObjectSpawns[i][2]))
        	{
                DestroyDynamic3DTextLabel(gplTexts3D[playerid][i]);
                DestroyDynamicObject(gplObjects[playerid][i]);
                gplObjects[playerid][i] = 0;
                gplTexts3D[playerid][i] = Text3D:0;

                gplIsCarrying[playerid] = true;

                SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
                for(new j = 7; j < MAX_PLAYER_ATTACHED_OBJECTS; j++)
                {
                    if(!IsPlayerAttachedObjectSlotUsed(playerid, j))
                    {
                        SetPlayerAttachedObject(playerid, j, 2358, 6, 0.039999, 0.125000, -0.189000, -110.499961, -11.299997, 78.199943, 1.000000, 1.000000, 1.000000);
                        gplAttachmentIndex[playerid] = j;
                        break;
                    }
                }
                SendClientMessage(playerid, COLOR_SUB_TITLE, "* Leve a caixa para o caminhão.");
        		break;
        	}
        }
    }
    else
    {
        new Float:x, Float:y, Float:z;
        GetVehiclePos(g_pVehicleID[playerid], x, y, z);
        if(IsPlayerInRangeOfPoint(playerid, 5.0, x, y, z))
        {
            gplLoadedObj[playerid]++;
            gplIsCarrying[playerid] = false;
            RemovePlayerAttachedObject(playerid, gplAttachmentIndex[playerid]);
            SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
            ApplyAnimation(playerid, "CARRY", "LIFTUP105", 4.1, 0, 1, 1, 0, 0, 1);
            PlaySelectSound(playerid);

            if(gplLoadedObj[playerid] == sizeof(gplObjects[]))
            {
                SendClientMessage(playerid, COLOR_TITLE, "* Leve o caminhão para o local.");
                SetPlayerRaceCheckpoint(playerid, 1, 2742.5559, -1999.3014, 13.4838, 0.0, 0.0, 0.0, 10.0);
                gplCurrentCP[playerid]++;
            }
        }
    }
	return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerDeath(playerid, killerid, reason)
{
    if(g_pVehicleID[playerid] != INVALID_VEHICLE_ID)
    {
        SendClientMessage(playerid, COLOR_ERROR, "* Você não conseguiu completar a missão.");
        DestroyMissionObjects(playerid);
    }
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerEnterRaceCPT(playerid)
{
    switch(GetPlayerCPID(playerid))
    {
        case CHECKPOINT_COLONEL:
        {
            if(!IsPlayerInVehicle(playerid, g_pVehicleID[playerid]))
            {
                SendClientMessage(playerid, COLOR_ERROR, "* Você não está no veículo da missão.");
                return -2;
            }

            if(gplCurrentCP[playerid] == 0)
            {
                gEnteringCP[playerid][0] = CreateDynamicCP(2807.8914, -1176.0724, 25.3853, 1.0, 0, 0, playerid); // Outside
                gEnteringCP[playerid][1] = CreateDynamicCP(2807.6067, -1174.5070, 1025.5703, 1.0, playerid, 8, playerid); // Inside

                for(new i = 0; i < sizeof(gplObjects[]); i++)
                {
                    gplObjects[playerid][i] = CreateDynamicObject(2358, g_fObjectSpawns[i][0], g_fObjectSpawns[i][1], g_fObjectSpawns[i][2], g_fObjectSpawns[i][3], g_fObjectSpawns[i][4], g_fObjectSpawns[i][5], playerid, 8);
                    gplTexts3D[playerid][i] = CreateDynamic3DTextLabel("Caixa\nPressione {1add69}Y", 0xFFFFFFFF, g_fObjectSpawns[i][0], g_fObjectSpawns[i][1], g_fObjectSpawns[i][2], 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, playerid, 8);
                }

                SendClientMessage(playerid, COLOR_SUB_TITLE, "* Posicione o veículo para facilitar o carregamento.");
                DisablePlayerRaceCheckpoint(playerid);
            }
            else if(gplCurrentCP[playerid] == 1)
            {
                DestroyMissionObjects(playerid);
                DisablePlayerRaceCheckpoint(playerid);
                SetPlayerCPID(playerid, CHECKPOINT_NONE);

                SendClientMessage(playerid, COLOR_TITLE, "* Você completou a missão!");
                SendClientMessage(playerid, COLOR_SUB_TITLE, "* Parabéns.");
                SetPlayerXP(playerid, GetPlayerXP(playerid) + (GetPlayerLevel(playerid) * 50));
            }
            return -2;
        }
    }
    return 1;
}

//------------------------------------------------------------------------------
