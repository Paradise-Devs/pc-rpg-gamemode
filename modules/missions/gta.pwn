/*******************************************************************************
* FILENAME :        modules/missions/gta.pwn
*
* DESCRIPTION :
*       Adds car theft missions to the server.
*
* NOTES :
*       Players can talk to a NPC to ask for missions of stealing vehicles.
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
static g_pTargetVehicleID[MAX_PLAYERS] = {INVALID_VEHICLE_ID, ...};

//------------------------------------------------------------------------------

static Float:g_fCarSpawnPosition[][] =
{
	// Near bus driver job
	{1062.3079, -1775.6611, 13.2977, -90.0600},
	{1062.3079, -1772.6611, 13.2977, -90.0600},
	{1062.3079, -1769.6611, 13.2977, -90.0600},
	{1062.3079, -1766.6611, 13.2977, -90.0600},
	{1062.3079, -1763.6611, 13.2977, -90.0600},
	{1062.3079, -1760.6611, 13.2977, -90.0600},
	{1062.3079, -1765.6611, 13.2977, -90.0600},
	{1062.3079, -1754.6611, 13.2977, -90.0600},
	{1062.3079, -1751.6611, 13.2977, -90.0600},
	{1062.3079, -1748.6611, 13.2977, -90.0600},
	{1062.3079, -1745.6611, 13.2977, -90.0600},
	{1062.3079, -1742.6611, 13.2977, -90.0600},
	{1062.3079, -1739.6611, 13.2977, -90.0600},
	{1062.3079, -1736.6611, 13.2977, -90.0600},

	// Near lottery
	{1722.4868, -1061.1561, 23.8234, 0.0000},
	{1718.4868, -1061.1561, 23.8234, 0.0000},
	{1714.4868, -1061.1561, 23.8234, 0.0000},
	{1710.4868, -1061.1561, 23.8234, 0.0000},
	{1706.4868, -1061.1561, 23.8234, 0.0000},
	{1702.4868, -1061.1561, 23.8234, 0.0000},
	{1698.4868, -1061.1561, 23.8234, 0.0000},
	{1694.4868, -1061.1561, 23.8234, 0.0000},

	// Near Jefferson Motel
	{2161.7751, -1196.9597, 23.9217, 90.0000},
	{2161.7751, -1192.9597, 23.9217, 90.0000},
	{2161.7751, -1188.9597, 23.9217, 90.0000},
	{2161.7751, -1184.9597, 23.9217, 90.0000},
	{2161.7751, -1180.9597, 23.9217, 90.0000},
	{2161.7751, -1176.9597, 23.9217, 90.0000},
	{2161.7751, -1172.9597, 23.9217, 90.0000},
	{2161.7751, -1168.9597, 23.9217, 90.0000},
	{2161.7751, -1164.9597, 23.9217, 90.0000},
	{2161.7751, -1160.9597, 23.9217, 90.0000},
	{2161.7751, -1156.9597, 23.9217, 90.0000},
	{2161.7751, -1152.9597, 23.9217, 90.0000},

	// Near glen park
	{1978.8868, -1274.7711, 23.8197, 180.0000},
	{1981.8868, -1274.7711, 23.8197, 180.0000},
	{1984.8868, -1274.7711, 23.8197, 180.0000},
	{1987.8868, -1274.7711, 23.8197, 180.0000},
	{1990.8868, -1274.7711, 23.8197, 180.0000},
	{1993.8868, -1274.7711, 23.8197, 180.0000},
	{1996.8868, -1274.7711, 23.8197, 180.0000},
	{1999.8868, -1274.7711, 23.8197, 180.0000},
	{2002.8868, -1274.7711, 23.8197, 180.0000},
	{2005.8868, -1274.7711, 23.8197, 180.0000},
	{2008.8868, -1274.7711, 23.8197, 180.0000},

	// Near Nude Shop airport
	{1938.2191, -2080.0437, 13.5325, 270.0000},
	{1938.2191, -2083.0437, 13.5325, 270.0000},
	{1938.2191, -2086.0437, 13.5325, 270.0000},
	{1938.2191, -2089.0437, 13.5325, 270.0000},
	{1938.2191, -2092.0437, 13.5325, 270.0000},

	// Near Pizzaria
	{2052.7656, -1903.8796, 13.4948, 180.0000},
	{2056.7656, -1903.8796, 13.4948, 180.0000},
	{2060.7656, -1903.8796, 13.4948, 180.0000},
	{2064.7656, -1903.8796, 13.4948, 180.0000},
	{2068.7656, -1903.8796, 13.4948, 180.0000},
	{2072.7656, -1903.8796, 13.4948, 180.0000},

	// Verona beach
	{337.4342, -1788.8113, 4.8668, 180.0000},
	{334.4342, -1788.8113, 4.8668, 180.0000},
	{331.4342, -1788.8113, 4.8668, 180.0000},
	{328.4342, -1788.8113, 4.8668, 180.0000},
	{325.4342, -1788.8113, 4.8668, 180.0000},
	{322.4342, -1788.8113, 4.8668, 180.0000},
	{319.4342, -1788.8113, 4.8668, 180.0000},
	{316.4342, -1788.8113, 4.8668, 180.0000},
	{313.4342, -1788.8113, 4.8668, 180.0000}
};

static g_nVehicles[] =
{
	400, 401, 402, 404, 405, 409, 410, 412,
	415, 418, 419, 421, 422, 426, 429, 436,
	445, 451, 458, 459, 466, 474, 475, 477,
	479, 480, 482, 489, 495, 500, 507, 516,
	517, 518, 526, 527, 529, 533, 534, 535
};

static Float:g_fVehicleDeliverPositions[][] =
{
	{2464.4736, -1413.5564, 23.4553},
	{2463.0166, -1424.1638, 23.4545}
};

//------------------------------------------------------------------------------

hook OnGameModeInit()
{
    gActorid = CreateActor(268, 2445.1362, -1425.0587, 23.9922, 275.0087);
	ApplyActorAnimation(gActorid, "COP_AMBIENT", "COPLOOK_LOOP", 4.1, 1, 0, 0, 1, 0);

    gCheckpointid = CreateDynamicCP(2445.45, -1425.0587, 23.9922, 1.0, 0, 0);
    return 1;
}

//------------------------------------------------------------------------------

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch(dialogid)
    {
        case DIALOG_GTA_MISSION:
        {
            if(!response)
                PlayCancelSound(playerid);
            else
            {
				new modelid = random(sizeof(g_nVehicles));
				new randpos = random(sizeof(g_fCarSpawnPosition));
				new location[MAX_ZONE_NAME];

                Get2DZoneName(location, g_fCarSpawnPosition[randpos][0], g_fCarSpawnPosition[randpos][1]);
				g_pTargetVehicleID[playerid] = CreateVehicle(g_nVehicles[modelid], g_fCarSpawnPosition[randpos][0], g_fCarSpawnPosition[randpos][1], g_fCarSpawnPosition[randpos][2], g_fCarSpawnPosition[randpos][3], random(126), random(126), -1);

                foreach(new i: Player)
                {
					if(i != playerid)
                    {
						SetVehicleParamsForPlayer(g_pTargetVehicleID[playerid], i, 0, 1);
                    }
                }

                PlaySelectSound(playerid);
				SetVehicleFuel(g_pTargetVehicleID[playerid], 100.0);
				SetVehicleParamsForPlayer(g_pTargetVehicleID[playerid], playerid, 1, 0);

                SetPlayerCPID(playerid, CHECKPOINT_GTA);
                SetPlayerRaceCheckpoint(playerid, 0, g_fCarSpawnPosition[randpos][0], g_fCarSpawnPosition[randpos][1], g_fCarSpawnPosition[randpos][2], 2464.4736, -1413.5564, 23.4553, 5.0);

                SendClientMessagef(playerid, COLOR_TITLE, "* O veículo é um %s localizado em %s.", GetVehicleName(g_pTargetVehicleID[playerid]), location);
                SendClientMessage(playerid, COLOR_SUB_TITLE, "* Quanto menos o veículo for danificado, maior o pagamento.");
            }
            return -1;
        }
    }
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerEnterRaceCPT(playerid)
{
    switch(GetPlayerCPID(playerid))
    {
        case CHECKPOINT_GTA:
        {
            if(!IsPlayerInVehicle(playerid, g_pTargetVehicleID[playerid]))
            {
                SendClientMessage(playerid, COLOR_ERROR, "* Você não está no veículo da missão.");
                return -2;
            }

            new Float:health;
            new money;

            GetVehicleHealth(g_pTargetVehicleID[playerid], health);
            money = ((floatround(health) * 5) / 2);

            SendClientMessagef(playerid, COLOR_TITLE, "* Você entregou o %s.", GetVehicleName(g_pTargetVehicleID[playerid]));
            SendClientMessagef(playerid, COLOR_SUB_TITLE, "* Seu pagamento foi de $%s.", formatnumber(money));

            GivePlayerCash(playerid, money);
            DisablePlayerRaceCheckpoint(playerid);
            SetPlayerCPID(playerid, CHECKPOINT_NONE);

            DestroyVehicle(g_pTargetVehicleID[playerid]);
            g_pTargetVehicleID[playerid] = INVALID_VEHICLE_ID;
            return -2;
        }
    }
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
    switch(newstate)
    {
        case PLAYER_STATE_DRIVER:
        {
            if(GetPlayerVehicleID(playerid) == g_pTargetVehicleID[playerid])
            {
                SetPlayerCPID(playerid, CHECKPOINT_GTA);

                new rand = random(sizeof(g_fVehicleDeliverPositions));
                SetPlayerRaceCheckpoint(playerid, 1, g_fVehicleDeliverPositions[rand][0], g_fVehicleDeliverPositions[rand][1], g_fVehicleDeliverPositions[rand][2], 0.0, 0.0, 0.0, 5.0);
            }
        }
    }
    return 1;
}

//------------------------------------------------------------------------------


hook OnPlayerDisconnect(playerid, reason)
{
    if(g_pTargetVehicleID[playerid] != INVALID_VEHICLE_ID)
    {
        DestroyVehicle(g_pTargetVehicleID[playerid]);
        g_pTargetVehicleID[playerid] = INVALID_VEHICLE_ID;
    }
    return 1;
}

//------------------------------------------------------------------------------

hook OnVehicleStreamIn(vehicleid, forplayerid)
{
	foreach(new i: Player)
	{
		if(vehicleid == g_pTargetVehicleID[i] && vehicleid != g_pTargetVehicleID[forplayerid])
		{
			SetVehicleParamsForPlayer(g_pTargetVehicleID[forplayerid], forplayerid, 0, 1);
		}
	}

    if(g_pTargetVehicleID[forplayerid] == vehicleid)
    {
		SetVehicleParamsForPlayer(g_pTargetVehicleID[forplayerid], forplayerid, 1, 0);
		DisablePlayerRaceCheckpoint(forplayerid);
	}
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerEnterDynamicCP(playerid, STREAMER_TAG_CP checkpointid)
{
    if(checkpointid == gCheckpointid)
    {
        if(g_pTargetVehicleID[playerid] != INVALID_VEHICLE_ID)
        {
            SendClientMessage(playerid, COLOR_ERROR, "* Você já está aceitou uma missão.");
            return -1;
        }

        new info[130];
		format(info, sizeof(info), "Eaí %s,\n\nTô precisando de uns veículos aqui no meu desmanche.\nVocê estaria interessado em me ajudar?", GetPlayerNamef(playerid));
		ShowPlayerDialog(playerid, DIALOG_GTA_MISSION, DIALOG_STYLE_MSGBOX, "Dwayne -> Missão", info, "Sim", "Não");
        PlaySelectSound(playerid);
        return -2;
    }
    return 1;
}
