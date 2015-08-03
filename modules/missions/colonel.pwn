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

#include "../modules/visual/colonel.pwn"

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
static gplIsCarrying[MAX_PLAYERS] = {-1, ...};

// Amount of loaded objects
static gplLoadedObj[MAX_PLAYERS];

// Last snoring sound tickcount
new gplLastSnoringSound[MAX_PLAYERS];

// TimerID
static Timer:gplMissionTimer[MAX_PLAYERS] = {Timer:-1, ...};

// Noise amount
static Float:gplNoise[MAX_PLAYERS];

// Noise warnings
static gplNoiseWarn[MAX_PLAYERS];

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

hook OnPlayerGiveDamageActor(playerid, damaged_actorid, Float:amount, weaponid, bodypart)
{
    if(damaged_actorid == gColonelActorID[playerid])
    {
        DestroyMissionElements(playerid);
        SendClientMessage(playerid, COLOR_ERROR, "* Você acordou o coronel.");
        GameTextForPlayer(playerid, ConvertToGameText("~r~missão falha!"), 9000, 0);

        SetPlayerPos(playerid, 2807.8914, -1176.0724, 25.3853);
        SetPlayerFacingAngle(playerid, 175.5660);
        SetPlayerInterior(playerid, 0);
        SetPlayerVirtualWorld(playerid, 0);
    }
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

        ShowPlayerColonelNoiseBar(playerid);

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
        HidePlayerColonelNoiseBar(playerid);
        gplNoise[playerid] = 0.0;
    }
    return 1;
}

//------------------------------------------------------------------------------

timer OnColonelMissionUpdate[100](playerid)
{
    if(gplLastSnoringSound[playerid] < tickcount())
    {
        // Clock update
        new hour, minute;
        GetServerClock(hour, minute);

        hour = 4 - hour;
        minute = 59 - minute;
        UpdatePlayerColonelClock(playerid, hour, minute);

        // Snoring sound
        PlayerPlaySound(playerid, random(4) + 19601, 2817.4827, -1169.0739, 1029.9033);
        gplLastSnoringSound[playerid] = tickcount() + 5000;
    }

    // Check if the player is inside
    if(GetPlayerInterior(playerid) == 8)
    {
        if(gplNoise[playerid] > 0.0)
            gplNoise[playerid] -= 1.0;

        if(IsPlayerRunning(playerid))
            gplNoise[playerid] += 7.5;

        if(GetPlayerAnimationIndex(playerid) == 1195)
            gplNoise[playerid] += 15.0;

        if(gplNoise[playerid] > 100.0)
        {
            gplNoiseWarn[playerid]++;
            gplNoise[playerid] = 0.0;

            new warnSound[] = {33621, 33622, 33624};
            gplLastSnoringSound[playerid] = tickcount() + 5000;
            PlayerPlaySound(playerid, warnSound[random(sizeof(warnSound))], 2817.4827, -1169.0739, 1029.9033);
        }

        if(gplNoiseWarn[playerid] == 3)
        {
            DestroyMissionElements(playerid);
            SendClientMessage(playerid, COLOR_ERROR, "* Você acordou o coronel.");
            GameTextForPlayer(playerid, ConvertToGameText("~r~missão falha!"), 9000, 0);

            SetPlayerPos(playerid, 2807.8914, -1176.0724, 25.3853);
            SetPlayerFacingAngle(playerid, 175.5660);
            SetPlayerInterior(playerid, 0);
            SetPlayerVirtualWorld(playerid, 0);
            return 1;
        }

        UpdatePlayerColonelNoiseBar(playerid, gplNoise[playerid]);
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

                new hour, minute;
                GetServerClock(hour, minute);
                if(hour > 3)
                {
                    SendClientMessage(playerid, COLOR_ERROR, "* Essa missão só está disponível entre 00:00 e 03:59.");
                    return 1;
                }

                g_pVehicleID[playerid] = CreateVehicle(498, 2473.4927, -1693.4933, 13.5833, 359.4650, 0, 0, -1);
                SetVehicleFuel(g_pVehicleID[playerid], 100.0);
                PutPlayerInVehicle(playerid, g_pVehicleID[playerid], 0);
                SetPlayerRaceCheckpoint(playerid, 1, 2837.1470, -1182.6567, 24.6219, 0.0, 0.0, 0.0, 10.0);

                SendClientMessage(playerid, COLOR_TITLE, "* Leve o Boxville até o local indicado.");
                gplMissionTimer[playerid] = repeat OnColonelMissionUpdate(playerid);

                gplCurrentCP[playerid] = 0;
                gplLoadedObj[playerid] = 0;
                gplIsCarrying[playerid] = -1;
                gplNoiseWarn[playerid] = 0;

                SetPlayerCPID(playerid, CHECKPOINT_COLONEL);
				SetPlayerMission(playerid, MISSION_COLONEL);

                ShowPlayerColonelUI(playerid);
            }
            return -1;
        }
    }
    return 1;
}

//------------------------------------------------------------------------------

static DestroyMissionElements(playerid)
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

    if(gplMissionTimer[playerid] != Timer:-1)
    {
        stop gplMissionTimer[playerid];
        gplMissionTimer[playerid] = Timer:-1;
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

    if(IsPlayerAttachedObjectSlotUsed(playerid, gplAttachmentIndex[playerid]))
    {
        RemovePlayerAttachedObject(playerid, gplAttachmentIndex[playerid]);
        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
    }

    SetPlayerMission(playerid, INVALID_MISSION_ID);
    HidePlayerColonelUI(playerid);
}

//------------------------------------------------------------------------------

hook OnPlayerDisconnect(playerid, reason)
{
    DestroyMissionElements(playerid);
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(g_pVehicleID[playerid] == INVALID_VEHICLE_ID || newkeys != KEY_YES)
        return 1;

    if(gplIsCarrying[playerid] == -1)
    {
        new Float:x, Float:y, Float:z;
        for(new i = 0; i < sizeof(g_fObjectSpawns); i++)
        {
            if(gplObjects[playerid][i] == 0)
                continue;

            GetDynamicObjectPos(gplObjects[playerid][i], x, y, z);
            if(IsPlayerInRangeOfPoint(playerid, 1.5, x, y, z))
        	{
                DestroyDynamic3DTextLabel(gplTexts3D[playerid][i]);
                DestroyDynamicObject(gplObjects[playerid][i]);
                gplObjects[playerid][i] = 0;
                gplTexts3D[playerid][i] = Text3D:0;

                gplIsCarrying[playerid] = i;

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
                ApplyAnimation(playerid, "CARRY", "LIFTUP", 4.1, 0, 1, 1, 0, 0, 1);
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
            gplIsCarrying[playerid] = -1;
            RemovePlayerAttachedObject(playerid, gplAttachmentIndex[playerid]);
            SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
            ApplyAnimation(playerid, "CARRY", "PUTDWN", 4.1, 0, 1, 1, 0, 0, 1);
            PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);

            if(gplLoadedObj[playerid] == sizeof(gplObjects[]))
            {
                SendClientMessage(playerid, COLOR_TITLE, "* Leve o caminhão para o local.");
                SetPlayerRaceCheckpoint(playerid, 1, 2742.5559, -1999.3014, 13.4838, 0.0, 0.0, 0.0, 10.0);
                gplCurrentCP[playerid]++;
            }
        }
        else
        {
            gplNoise[playerid] += 25.0;
            new i = gplIsCarrying[playerid];
            gplIsCarrying[playerid] = -1;
            GetPlayerPos(playerid, x, y, z);
            SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
            ApplyAnimation(playerid, "CARRY", "PUTDWN", 4.1, 0, 1, 1, 0, 0, 1);
            gplObjects[playerid][i] = CreateDynamicObject(2358, x, y, z-0.88, g_fObjectSpawns[i][3], g_fObjectSpawns[i][4], g_fObjectSpawns[i][5], GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
            gplTexts3D[playerid][i] = CreateDynamic3DTextLabel("Caixa\nPressione {1add69}Y", 0xFFFFFFFF, x, y, z-0.88, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
            RemovePlayerAttachedObject(playerid, gplAttachmentIndex[playerid]);
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
        DestroyMissionElements(playerid);
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
                PlayErrorSound(playerid);
                SendClientMessage(playerid, COLOR_ERROR, "* Você não está no veículo da missão.");
                return -2;
            }

            if(gplCurrentCP[playerid] == 0)
            {
                PlaySelectSound(playerid);
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
                DestroyMissionElements(playerid);
                DisablePlayerRaceCheckpoint(playerid);
                SetPlayerCPID(playerid, CHECKPOINT_NONE);

                GameTextForPlayer(playerid, ConvertToGameText("missão completa!~n~~w~exp +"), 9000, 0);
                PlayAudioStreamForPlayer(playerid, "https://dl.dropboxusercontent.com/u/118147782/MissionPassed.mp3");

                SetPlayerXP(playerid, GetPlayerXP(playerid) + (GetPlayerLevel(playerid) * 50));
            }
            return -2;
        }
    }
    return 1;
}

//------------------------------------------------------------------------------
