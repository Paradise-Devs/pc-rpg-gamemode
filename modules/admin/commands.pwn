/*******************************************************************************
* FILENAME :        modules/admin/commands.pwn
*
* DESCRIPTION :
*       Adds admins commands to the server.
*
* NOTES :
*       This file should only contain admin commands.
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

//------------------------------------------------------------------------------

#include <YSI\y_hooks>

static gplMarkExt[MAX_PLAYERS][2];
static Float:gplMarkPos[MAX_PLAYERS][3];

static gPlayerSpecInt[MAX_PLAYERS];
static gPlayerSpecWorld[MAX_PLAYERS];
static gPlayerSpecState[MAX_PLAYERS];
static gPlayerSpecTarget[MAX_PLAYERS] = {INVALID_PLAYER_ID, ...};
static Timer:gPlayerSpecTimer[MAX_PLAYERS] = {Timer:-1, ...};

//------------------------------------------------------------------------------

YCMD:acmds(playerid, params[], help)
{
    if(GetPlayerRank(playerid) < PLAYER_RANK_PARADISER)
 		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

	SendClientMessage(playerid, COLOR_TITLE, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Comandos Administrativos ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	if(GetPlayerRank(playerid) >= PLAYER_RANK_PARADISER)
    {
        SendClientMessage(playerid, COLOR_SUB_TITLE, "* /ir - /puxar - /check - /kick - /fuelveh - /pm - /aprision - /spec");
    }

	if(GetPlayerRank(playerid) >= PLAYER_RANK_MODERATOR)
    {
        SendClientMessage(playerid, COLOR_SUB_TITLE, "* /flip - /reparar - /ls - /sf - /lv - /sairdohospital - /setskin - /ban - /irpos");
        SendClientMessage(playerid, COLOR_SUB_TITLE, "* /rtc - /ircar - /tpcar - /puxarcar - /tdist - /marcar - /irmarca - /sethp - /setarmour - /dararma - /tirardohospital");
        SendClientMessage(playerid, COLOR_SUB_TITLE, "* /say - /alibertar - /spec - /setneeds");
    }

	if(GetPlayerRank(playerid) >= PLAYER_RANK_ADMIN)
        SendClientMessage(playerid, COLOR_SUB_TITLE, "* /criarcar - /setmoney - /setjob - /setfaction - /setfrank - /lotto - /jetpack - /fakeban");


    if(IsPlayerAdmin(playerid))
        SendClientMessage(playerid, COLOR_SUB_TITLE, "* /avehcmds - /abuildingcmds - /apartcmds - /ahousecmds - /abusinesscmds - /afactioncmds");

	SendClientMessage(playerid, COLOR_TITLE, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Comandos Administrativos ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerDisconnect(playerid, reason)
{
    if(gPlayerSpecTarget[playerid] != INVALID_PLAYER_ID)
    {
        gPlayerSpecState[playerid] = 0;
        gPlayerSpecTarget[playerid] = INVALID_PLAYER_ID;
        gPlayerSpecTimer[playerid] = Timer:-1;
    }
    return 1;
}

//------------------------------------------------------------------------------

 YCMD:ir(playerid, params[], help)
 {
 	if(GetPlayerRank(playerid) < PLAYER_RANK_PARADISER)
 		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

 	new targetid;
 	if(sscanf(params, "u", targetid))
 		return SendClientMessage(playerid, COLOR_INFO, "* /ir [playerid]");

 	else if(!IsPlayerLogged(targetid))
 		return SendClientMessage(playerid, COLOR_ERROR, "* O jogador não está conectado.");

 	else if(targetid == playerid)
 		return SendClientMessage(playerid, COLOR_ERROR, "* Você não pode ir até você mesmo.");

 	new Float:x, Float:y, Float:z;
    GetPlayerPos(targetid, x, y, z);

    SetPlayerInterior(playerid, GetPlayerInterior(targetid));
    SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(targetid));
    if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) { SetPlayerPos(playerid, x, y, z); }
    else
    {
        new vehicleid = GetPlayerVehicleID(playerid);
        SetVehiclePos(vehicleid, x, y, z);
        LinkVehicleToInterior(vehicleid, GetPlayerInterior(targetid));
        SetVehicleVirtualWorld(vehicleid, GetPlayerVirtualWorld(targetid));
    }

    SendClientMessagef(targetid, COLOR_ADMIN_ACTION, "* %s veio até você.", GetPlayerNamef(playerid));
    SendClientMessagef(playerid, COLOR_ADMIN_ACTION, "* Você foi até %s.", GetPlayerNamef(targetid));

    DisablePlayerRaceCheckpoint(playerid);
    SetPlayerCPID(playerid, CHECKPOINT_NONE);
 	return 1;
 }

 //------------------------------------------------------------------------------

YCMD:puxar(playerid, params[], help)
{
    if(GetPlayerRank(playerid) < PLAYER_RANK_PARADISER)
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

    new targetid;
    if(sscanf(params, "u", targetid))
        return SendClientMessage(playerid, COLOR_INFO, "* /puxar [playerid]");

    else if(!IsPlayerLogged(targetid))
        return SendClientMessage(playerid, COLOR_ERROR, "* O jogador não está conectado.");

    else if(targetid == playerid)
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não pode puxar você mesmo.");

    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);

    SetPlayerInterior(targetid, GetPlayerInterior(playerid));
    SetPlayerVirtualWorld(targetid, GetPlayerVirtualWorld(playerid));
    if(GetPlayerState(targetid) != PLAYER_STATE_DRIVER) { SetPlayerPos(targetid, x, y, z); }
    else
    {
        new vehicleid = GetPlayerVehicleID(targetid);
        SetVehiclePos(vehicleid, x, y, z);
        LinkVehicleToInterior(vehicleid, GetPlayerInterior(playerid));
        SetVehicleVirtualWorld(vehicleid, GetPlayerVirtualWorld(playerid));
    }

    SendClientMessagef(targetid, COLOR_ADMIN_ACTION, "* %s puxou você.", GetPlayerNamef(playerid));
    SendClientMessagef(playerid, COLOR_ADMIN_ACTION, "* Você puxou %s.", GetPlayerNamef(targetid));

    DisablePlayerRaceCheckpoint(targetid);
    SetPlayerCPID(targetid, CHECKPOINT_NONE);
    return 1;
}

//------------------------------------------------------------------------------

YCMD:check(playerid, params[], help)
{
   if(GetPlayerRank(playerid) < PLAYER_RANK_PARADISER)
       return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

   new targetid;
   if(sscanf(params, "u", targetid))
       return SendClientMessage(playerid, COLOR_INFO, "* /check [playerid]");

   else if(!IsPlayerLogged(targetid))
       return SendClientMessage(playerid, COLOR_ERROR, "* O jogador não está conectado.");

   ShowPlayerDataHud(targetid, playerid);
   return 1;
}

//------------------------------------------------------------------------------

YCMD:kick(playerid, params[], help)
{
    if(GetPlayerRank(playerid) < PLAYER_RANK_MODERATOR)
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

    new targetid, reason[128];

    if(sscanf(params, "us[128]", targetid, reason))
        return SendClientMessage(playerid, COLOR_INFO, "* /kick [playerid] [motivo]");

    else if(!IsPlayerLogged(targetid))
        return SendClientMessage(playerid, COLOR_ERROR, "* O jogador não está conectado.");

    else if(playerid == targetid)
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não pode kickar você mesmo.");

    else if(IsPlayerNPC(targetid))
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não pode kickar um NPC.");

    else if(GetPlayerRank(targetid) > PLAYER_RANK_PLAYER)
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não pode kickar um membro da administração.");

    KickEx(targetid, playerid, reason);
    return 1;
}

//------------------------------------------------------------------------------

YCMD:aprision(playerid, params[], help)
{
    if(GetPlayerRank(playerid) < PLAYER_RANK_MODERATOR)
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

    new targetid, time, reason[128];
    if(sscanf(params, "uis[128]", targetid, time, reason))
        return SendClientMessage(playerid, COLOR_INFO, "* /aprision [playerid] [tempo(minutos)] [motivo]");

    else if(!IsPlayerLogged(targetid))
        return SendClientMessage(playerid, COLOR_ERROR, "* O jogador não está conectado.");

    else if(playerid == targetid)
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não pode prender você mesmo.");

    else if(IsPlayerNPC(targetid))
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não pode prender um NPC.");

    else if(GetPlayerRank(targetid) > PLAYER_RANK_PLAYER)
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não pode prender um membro da administração.");

    else if(time < 5)
        return SendClientMessage(playerid, COLOR_ERROR, "* Tempo de prisão não pode ser inferior a 5 minutos.");

    new output[144];
    format(output, sizeof(output), "* %s foi preso por %s. Motivo: %s", GetPlayerNamef(targetid), GetPlayerNamef(playerid), reason);
    SendClientMessageToAll(COLOR_SERVER_ANN, output);

    PutPlayerInPrision(targetid, time * 60);
    return 1;
}

//------------------------------------------------------------------------------

YCMD:spec(playerid, params[], help)
{
    if(GetPlayerRank(playerid) < PLAYER_RANK_PARADISER)
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

    if(gPlayerSpecTarget[playerid] == INVALID_PLAYER_ID)
    {
        new targetid;
        if(sscanf(params, "u", targetid))
            return SendClientMessage(playerid, COLOR_INFO, "* /spec [playerid]");

        else if(!IsPlayerLogged(targetid))
            return SendClientMessage(playerid, COLOR_ERROR, "* O jogador não está conectado.");

        else if(IsPlayerNPC(targetid))
            return SendClientMessage(playerid, COLOR_ERROR, "* Jogador inválido.");

        else if(targetid == playerid)
            return SendClientMessage(playerid, COLOR_ERROR, "* Você não pode dar spec em você mesmo.");

        new Float:x, Float:y, Float:z, Float:a;
        gPlayerSpecInt[playerid] = GetPlayerInterior(playerid);
        gPlayerSpecWorld[playerid] = GetPlayerVirtualWorld(playerid);
        GetPlayerPos(playerid, x, y, z);
        GetPlayerFacingAngle(playerid, a);
        SetSpawnInfo(playerid, 255, GetPlayerSkin(playerid), x, y, z, a, 0, 0, 0, 0, 0, 0);

        TogglePlayerSpectating(playerid, true);
        SetPlayerInterior(playerid, GetPlayerInterior(targetid));
        SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(targetid));
        if(IsPlayerInAnyVehicle(targetid))
        {
            gPlayerSpecState[playerid] = 1;
            PlayerSpectateVehicle(playerid, GetPlayerVehicleID(targetid));
        }
        else
        {
            gPlayerSpecState[playerid] = 0;
            PlayerSpectatePlayer(playerid, targetid);
        }
        gPlayerSpecTarget[playerid] = targetid;
        gPlayerSpecTimer[playerid] = repeat UpdateSpectator(playerid);
    }
    else
    {
        gPlayerSpecState[playerid] = 0;
        gPlayerSpecTarget[playerid] = INVALID_PLAYER_ID;
        stop gPlayerSpecTimer[playerid];
        gPlayerSpecTimer[playerid] = Timer:-1;
        TogglePlayerSpectating(playerid, false);

        SetPlayerInterior(playerid, gPlayerSpecInt[playerid]);
        SetPlayerVirtualWorld(playerid, gPlayerSpecWorld[playerid]);
    }
    return 1;
}

timer UpdateSpectator[1000](playerid)
{
    new targetid = gPlayerSpecTarget[playerid];

    if(GetPlayerInterior(playerid) != GetPlayerInterior(targetid))
        SetPlayerInterior(playerid, GetPlayerInterior(targetid));

    if(GetPlayerVirtualWorld(playerid) != GetPlayerVirtualWorld(targetid))
        SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(targetid));

    if(IsPlayerInAnyVehicle(targetid) && gPlayerSpecState[playerid] != 1)
    {
        gPlayerSpecState[playerid] = 1;
        PlayerSpectateVehicle(playerid, GetPlayerVehicleID(targetid));
    }
    else if(!IsPlayerInAnyVehicle(targetid) && gPlayerSpecState[playerid] != 0)
    {
        gPlayerSpecState[playerid] = 0;
        PlayerSpectatePlayer(playerid, targetid);
    }
}

//------------------------------------------------------------------------------

YCMD:fuelveh(playerid, params[], help)
{
    if(GetPlayerRank(playerid) < PLAYER_RANK_PARADISER)
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

    else if(!IsPlayerInAnyVehicle(playerid))
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não está em um veículo.");

	SetVehicleFuel(GetPlayerVehicleID(playerid), 100.0);
	return 1;
}

//------------------------------------------------------------------------------

YCMD:pm(playerid, params[], help)
{
   if(GetPlayerRank(playerid) < PLAYER_RANK_MODERATOR)
       return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

   new targetid, message[128];
   if(sscanf(params, "us[128]", targetid, message))
       return SendClientMessage(playerid, COLOR_INFO, "* /pm [playerid] [mensagem]");

   else if(!IsPlayerLogged(targetid))
       return SendClientMessage(playerid, COLOR_ERROR, "* O jogador não está conectado.");

   else if(playerid == targetid)
       return SendClientMessage(playerid, COLOR_ERROR, "* Você não pode mandar mensagem privada para você mesmo.");

   new output[144];
   format(output, sizeof(output), "* [MP] %s(ID: %d): %s", GetPlayerNamef(playerid), playerid, message);
   SendClientMessage(targetid, 0x26b4cdff, output);
   format(output, sizeof(output), "* [MP] de %s para %s(ID: %d): %s", GetPlayerNamef(playerid), GetPlayerNamef(targetid), targetid, message);
   SendAdminMessage(PLAYER_RANK_MODERATOR, 0x26b4cdff, output);
   return 1;
}

/***
 *
 *     #    #  ####  #####  ###### #####    ##   #####  ####  #####
 *     ##  ## #    # #    # #      #    #  #  #    #   #    # #    #
 *     # ## # #    # #    # #####  #    # #    #   #   #    # #    #
 *     #    # #    # #    # #      #####  ######   #   #    # #####
 *     #    # #    # #    # #      #   #  #    #   #   #    # #   #
 *     #    #  ####  #####  ###### #    # #    #   #    ####  #    #
 *
 */

//------------------------------------------------------------------------------

 YCMD:flip(playerid, params[], help)
 {
 	if(GetPlayerRank(playerid) < PLAYER_RANK_MODERATOR)
 		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

    else if(!IsPlayerInAnyVehicle(playerid))
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não está em um veículo.");

    new Float:a, vehicleid = GetPlayerVehicleID(playerid);
    GetVehicleZAngle(vehicleid, a);
    SetVehicleZAngle(vehicleid, a);
    SendClientMessage(playerid, COLOR_ADMIN_ACTION, "* Você flipou seu veículo.");
 	return 1;
 }

//------------------------------------------------------------------------------

YCMD:reparar(playerid, params[], help)
{
    if(GetPlayerRank(playerid) < PLAYER_RANK_MODERATOR)
 		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

	if(IsPlayerInAnyVehicle(playerid))
	{
		RepairVehicle(GetPlayerVehicleID(playerid));
		SendClientMessage(playerid, COLOR_ADMIN_ACTION, "* Você reparou seu veículo.");
	}
    else
    {
		new
			Float:playerPosition[3],
            Float:vehicleDistance = 15.0,
			vehicleid = INVALID_VEHICLE_ID;

		GetPlayerPos(playerid, playerPosition[0], playerPosition[1], playerPosition[2]);
		foreach(new i: Vehicle)
		{
			if(GetVehicleDistanceFromPoint(i, playerPosition[0], playerPosition[1], playerPosition[2]) < vehicleDistance)
			{
				vehicleid = i;
				vehicleDistance = GetVehicleDistanceFromPoint(i, playerPosition[0], playerPosition[1], playerPosition[2]);
			}
		}

		if (vehicleid != INVALID_VEHICLE_ID)
		{
			SendClientMessage(playerid, COLOR_ADMIN_ACTION, "* Você reparou o veículo mais próximo.");
			RepairVehicle(vehicleid);
		}
        else
			SendClientMessage(playerid, COLOR_ERROR, "* Não há veículos príximo a você.");
	}
	return 1;
}

//------------------------------------------------------------------------------

YCMD:ls(playerid, params[], help)
{
 	if(GetPlayerRank(playerid) < PLAYER_RANK_MODERATOR)
 		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

    if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
        SetPlayerPos(playerid, 1540.3774, -1675.6068, 13.5505);
    else
        SetVehiclePos(GetPlayerVehicleID(playerid), 1540.3774, -1675.6068, 13.5505);

    SetPlayerInterior(playerid, 0);
    SetPlayerVirtualWorld(playerid, 0);
 	return 1;
}

//------------------------------------------------------------------------------

YCMD:sf(playerid, params[], help)
{
	if(GetPlayerRank(playerid) < PLAYER_RANK_MODERATOR)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

    if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
        SetPlayerPos(playerid, -1816.0549, 590.1733, 35.1641);
    else
        SetVehiclePos(GetPlayerVehicleID(playerid), -1816.0549, 590.1733, 35.1641);

    SetPlayerInterior(playerid, 0);
    SetPlayerVirtualWorld(playerid, 0);
	return 1;
}

//------------------------------------------------------------------------------

YCMD:lv(playerid, params[], help)
{
    if(GetPlayerRank(playerid) < PLAYER_RANK_MODERATOR)
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

    if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
        SetPlayerPos(playerid, 2023.5212, 1341.9235, 10.82035);
    else
        SetVehiclePos(GetPlayerVehicleID(playerid), 2023.5212, 1341.9235, 10.8203);

    SetPlayerInterior(playerid, 0);
    SetPlayerVirtualWorld(playerid, 0);
    return 1;
}

//------------------------------------------------------------------------------

YCMD:virtualworld(playerid, params[], help)
{
    SendClientMessagef(playerid, 0xA9C4E4FF, "Current virtualworld: %d", GetPlayerVirtualWorld(playerid));
    return 1;
}
//------------------------------------------------------------------------------

YCMD:vehicleid(playerid, params[], help)
{
    SendClientMessagef(playerid, 0xA9C4E4FF, "Current vehicleid: %d", GetPlayerVehicleID(playerid));
    return 1;
}

//------------------------------------------------------------------------------

YCMD:sairdohospital(playerid, params[], help)
{
    if(GetPlayerRank(playerid) < PLAYER_RANK_MODERATOR)
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

    else if(GetPlayerHospitalTime(playerid) < 1)
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não está no hospital.");

    SetPlayerHospitalTime(playerid, 1);
    return 1;
}

//------------------------------------------------------------------------------

 YCMD:setskin(playerid, params[], help)
 {
 	if(GetPlayerRank(playerid) < PLAYER_RANK_MODERATOR)
 		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

 	new targetid, skinid;
 	if(sscanf(params, "ui", targetid, skinid))
 		return SendClientMessage(playerid, COLOR_INFO, "* /setskin [playerid] [skin]");

 	else if(!IsPlayerLogged(targetid))
 		return SendClientMessage(playerid, COLOR_ERROR, "* O jogador não está conectado.");

    else if(skinid < 0 || skinid > 311)
 		return SendClientMessage(playerid, COLOR_ERROR, "* Skin inválida.");

 	SetPlayerSkin(targetid, skinid, true);
    if(playerid != targetid)
        SendClientMessagef(targetid, COLOR_ADMIN_ACTION, "* %s alterou sua skin para %d.", GetPlayerNamef(playerid), skinid);
    SendClientMessagef(playerid, COLOR_ADMIN_ACTION, "* Você alterou a skin de %s para %d.", GetPlayerNamef(targetid), skinid);
    SetSpawnInfo(targetid, 255, skinid, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 0, 0);
 	return 1;
 }

//------------------------------------------------------------------------------

YCMD:alibertar(playerid, params[], help)
{
    if(GetPlayerRank(playerid) < PLAYER_RANK_MODERATOR)
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

    new targetid;
    if(sscanf(params, "u", targetid))
        return SendClientMessage(playerid, COLOR_INFO, "* /alibertar [playerid]");

    else if(!IsPlayerLogged(targetid))
        return SendClientMessage(playerid, COLOR_ERROR, "* O jogador não está conectado.");

    else if(IsPlayerNPC(targetid))
        return SendClientMessage(playerid, COLOR_ERROR, "* Jogador inválido.");

    else if(!IsPlayerInPrision(targetid))
        return SendClientMessage(playerid, COLOR_ERROR, "* O jogador não está preso.");

    SendClientMessagef(playerid, COLOR_ADMIN_ACTION, "* Você libertou %s da prisão.", GetPlayerNamef(targetid));
    if(playerid != targetid)
        SendClientMessagef(targetid, COLOR_ADMIN_ACTION, "* Você foi liberto da prisão por %s.", GetPlayerNamef(playerid));

    SetPlayerPrisionTime(targetid, 1);
    return 1;
}

//------------------------------------------------------------------------------

YCMD:permaban(playerid, params[], help)
{
    if(GetPlayerRank(playerid) < PLAYER_RANK_MODERATOR)
    return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

    new targetid, reason[128];
    if(sscanf(params, "us", targetid, reason))
        return SendClientMessage(playerid, COLOR_INFO, "* /permaban [playerid] [motivo]");

    else if(!IsPlayerLogged(targetid))
        return SendClientMessage(playerid, COLOR_ERROR, "* O jogador não está conectado.");

    else if(playerid == targetid)
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não pode banir você mesmo.");

    else if(IsPlayerNPC(targetid))
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não pode banir um NPC.");

    else if(GetPlayerRank(targetid) > PLAYER_RANK_PLAYER)
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não pode banir um membro da administração.");

    PermaBan(targetid, playerid, reason);
    return 1;
}

//------------------------------------------------------------------------------

YCMD:tempban(playerid, params[], help)
{
    if(GetPlayerRank(playerid) < PLAYER_RANK_MODERATOR)
    return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

    new targetid, reason[128], days;
    if(sscanf(params, "usd", targetid, reason, days)) {
        SendClientMessage(playerid, COLOR_INFO, "* /tempban [playerid] [dias] [motivo]");
        SendClientMessage(playerid, COLOR_INFO, "* DICA: Utilize prisão para punir por horas.");
        return 1;
    }

    if(!IsPlayerLogged(targetid))
        return SendClientMessage(playerid, COLOR_ERROR, "* O jogador não está conectado.");

    else if(playerid == targetid)
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não pode banir você mesmo.");

    else if(IsPlayerNPC(targetid))
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não pode banir um NPC.");

    else if(GetPlayerRank(targetid) > PLAYER_RANK_PLAYER)
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não pode banir um membro da administração.");

    else if(days <= 0)
        return SendClientMessage(playerid, COLOR_ERROR, "* Dias não pode ser negativo ou 0.");

    else if(days > 30)

    TempBan(targetid, playerid, reason, days);

    return 1;
}

//------------------------------------------------------------------------------

YCMD:irpos(playerid, params[], help)
{
    if(GetPlayerRank(playerid) < PLAYER_RANK_MODERATOR)
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

	new Float:x, Float:y, Float:z, i, w;
	if(sscanf(params, "fffI(0)I(0)", x, y, z, i, w))
		SendClientMessage(playerid, COLOR_INFO, "* /irpos [float x] [float y] [float z] [interior<opcional>] [world<opcional>]");
	else
    {
		SetPlayerInterior(playerid, i);
		SetPlayerVirtualWorld(playerid, w);
		SetPlayerPos(playerid, x, y, z);
	}
	return 1;
}

//------------------------------------------------------------------------------

YCMD:rtc(playerid, params[], help)
{
    if(GetPlayerRank(playerid) < PLAYER_RANK_MODERATOR)
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

    else if(!IsPlayerInAnyVehicle(playerid))
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não está em um veículo.");

	SetVehicleToRespawn(GetPlayerVehicleID(playerid));
	return 1;
}

//------------------------------------------------------------------------------

YCMD:ircar(playerid, params[], help)
{
    if(GetPlayerRank(playerid) < PLAYER_RANK_MODERATOR)
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

	new vehicleid;
	if(sscanf(params, "i", vehicleid))
		SendClientMessage(playerid, COLOR_INFO, "* /ircar [veículo id]");
    else if(GetVehicleModel(vehicleid) == 0)
		SendClientMessage(playerid, COLOR_ERROR, "* Veículo não existe.");
	else
    {
		SendClientMessagef(playerid, COLOR_ADMIN_ACTION, "* Você foi até o veículo %d.", vehicleid);

        new Float:x, Float:y, Float:z;
        GetVehiclePos(vehicleid, x, y, z);
        SetPlayerPos(playerid, x, y, z);
	}
	return 1;
}

//------------------------------------------------------------------------------

YCMD:tpcar(playerid, params[], help)
{
    if(GetPlayerRank(playerid) < PLAYER_RANK_MODERATOR)
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

	new vehicleid;
	if(sscanf(params, "i", vehicleid))
		SendClientMessage(playerid, COLOR_INFO, "* /tpcar [veículo id]");
    else if(GetVehicleModel(vehicleid) == 0)
		SendClientMessage(playerid, COLOR_ERROR, "* Veículo não existe.");
	else
    {
        if(!IsVehicleOccupied(vehicleid))
        {
            PutPlayerInVehicle(playerid, vehicleid, 0);
            SendClientMessagef(playerid, COLOR_ADMIN_ACTION, "* Você foi até o veículo %d.", vehicleid);
        }
        else
        {
            SendClientMessage(playerid, COLOR_ERROR, "* Este veículo está ocupado.");
        }
	}
	return 1;
}

//------------------------------------------------------------------------------

YCMD:puxarcar(playerid, params[], help)
{
    if(GetPlayerRank(playerid) < PLAYER_RANK_MODERATOR)
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

	new vehicleid;
	if(sscanf(params, "i", vehicleid))
		SendClientMessage(playerid, COLOR_INFO, "* /puxarcar [veículo id]");
    else if(GetVehicleModel(vehicleid) == 0)
    	SendClientMessage(playerid, COLOR_ERROR, "* Veículo não existe.");
	else
    {
		SendClientMessagef(playerid, COLOR_ADMIN_ACTION, "* Você puxou o veículo %d.", vehicleid);

        new Float:x, Float:y, Float:z;
        GetPlayerPos(playerid, x, y, z);
        SetVehiclePos(vehicleid, x, y, z);
        LinkVehicleToInterior(vehicleid, GetPlayerInterior(playerid));
        SetVehicleVirtualWorld(vehicleid, GetPlayerVirtualWorld(playerid));
	}
	return 1;
}

//------------------------------------------------------------------------------

YCMD:tdist(playerid, params[], help)
{
    if(GetPlayerRank(playerid) < PLAYER_RANK_MODERATOR)
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

    new targetid;
    if(sscanf(params, "u", targetid))
        SendClientMessage(playerid, COLOR_INFO, "* /tdist [playerid]");
    else if(!IsPlayerLogged(targetid))
        SendClientMessage(playerid, COLOR_ERROR, "* O jogador não está conectado.");
	else
		SendClientMessagef(playerid, COLOR_ADMIN_ACTION, "* Você está a %.2f units de distância do jogador.", GetPlayerDistanceFromPlayer(playerid, targetid));
	return 1;
}

//------------------------------------------------------------------------------

YCMD:marcar(playerid, params[], help)
{
    if(GetPlayerRank(playerid) < PLAYER_RANK_MODERATOR)
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

    gplMarkExt[playerid][0] = GetPlayerInterior(playerid);
    gplMarkExt[playerid][1] = GetPlayerVirtualWorld(playerid);
    GetPlayerPos(playerid, gplMarkPos[playerid][0], gplMarkPos[playerid][1], gplMarkPos[playerid][2]);
	SendClientMessagef(playerid, COLOR_ADMIN_ACTION, "* Você marcou sua posição atual. (%.2f, %.2f, %.2f, %d, %d)", gplMarkPos[playerid][0], gplMarkPos[playerid][1], gplMarkPos[playerid][2], gplMarkExt[playerid][0], gplMarkExt[playerid][1]);
	return 1;
}
//------------------------------------------------------------------------------

YCMD:irmarca(playerid, params[], help)
{
    if(GetPlayerRank(playerid) < PLAYER_RANK_MODERATOR)
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

    SetPlayerInterior(playerid, gplMarkExt[playerid][0]);
    SetPlayerVirtualWorld(playerid, gplMarkExt[playerid][1]);
    if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
        SetPlayerPos(playerid, gplMarkPos[playerid][0], gplMarkPos[playerid][1], gplMarkPos[playerid][2]);
    else
        SetVehiclePos(GetPlayerVehicleID(playerid), gplMarkPos[playerid][0], gplMarkPos[playerid][1], gplMarkPos[playerid][2]);
	SendClientMessagef(playerid, COLOR_ADMIN_ACTION, "* Você foi até a posição marcada. (%.2f, %.2f, %.2f, %d, %d)", gplMarkPos[playerid][0], gplMarkPos[playerid][1], gplMarkPos[playerid][2], gplMarkExt[playerid][0], gplMarkExt[playerid][1]);
	return 1;
}

//------------------------------------------------------------------------------

 YCMD:sethp(playerid, params[], help)
 {
 	if(GetPlayerRank(playerid) < PLAYER_RANK_MODERATOR)
 		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

 	new targetid, Float:health;
 	if(sscanf(params, "uf", targetid, health))
 		return SendClientMessage(playerid, COLOR_INFO, "* /sethp [playerid] [valor]");

 	else if(!IsPlayerLogged(targetid))
 		return SendClientMessage(playerid, COLOR_ERROR, "* O jogador não está conectado.");

 	SetPlayerHealth(targetid, health);
    if(playerid != targetid)
        SendClientMessagef(targetid, COLOR_ADMIN_ACTION, "* %s alterou sua HP para %.2f.", GetPlayerNamef(playerid), health);
    SendClientMessagef(playerid, COLOR_ADMIN_ACTION, "* Você alterou a HP de %s para %.2f.", GetPlayerNamef(targetid), health);
 	return 1;
 }

//------------------------------------------------------------------------------

 YCMD:setneeds(playerid, params[], help)
 {
 	if(GetPlayerRank(playerid) < PLAYER_RANK_MODERATOR)
 		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

 	new targetid, Float:value, option[6];
 	if(sscanf(params, "rs[6]f", targetid, option, value))
    {
        SendClientMessage(playerid, COLOR_INFO, "* /setneeds [playerid] [opção] [valor]");
        SendClientMessage(playerid, COLOR_SUB_TITLE, "* fome, sede, vicio, sono");
    }

 	else if(!IsPlayerLogged(targetid))
 	{
        SendClientMessage(playerid, COLOR_ERROR, "* O jogador não está conectado.");
    }

    else if(!strcmp(option, "fome"))
    {
        SetPlayerHunger(playerid, value);
    }

    else if(!strcmp(option, "sede"))
    {
        SetPlayerThirst(playerid, value);
    }

    else if(!strcmp(option, "vicio"))
    {
        SetPlayerAddiction(playerid, value);
    }

    else if(!strcmp(option, "sono"))
    {
        SetPlayerSleep(playerid, value);
    }
    else
    {
        SendClientMessage(playerid, COLOR_ERROR, "* Opção inválida.");
        return 1;
    }

    if(playerid != targetid)
    {
        SendClientMessagef(targetid, COLOR_ADMIN_ACTION, "* %s alterou sua necessidade \"%s\" para %.2f.", GetPlayerNamef(playerid), option, value);
    }
    SendClientMessagef(playerid, COLOR_ADMIN_ACTION, "* Você alterou a necessidade \"%s\" de %s para %.2f.", GetPlayerNamef(targetid), option, value);
 	return 1;
 }

//------------------------------------------------------------------------------

 YCMD:setarmour(playerid, params[], help)
 {
 	if(GetPlayerRank(playerid) < PLAYER_RANK_MODERATOR)
 		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

 	new targetid, Float:armour;
 	if(sscanf(params, "uf", targetid, armour))
 		return SendClientMessage(playerid, COLOR_INFO, "* /setarmour [playerid] [valor]");

 	else if(!IsPlayerLogged(targetid))
 		return SendClientMessage(playerid, COLOR_ERROR, "* O jogador não está conectado.");

 	SetPlayerArmour(targetid, armour);
    if(playerid != targetid)
        SendClientMessagef(targetid, COLOR_ADMIN_ACTION, "* %s alterou seu colete para %.2f.", GetPlayerNamef(playerid), armour);
    SendClientMessagef(playerid, COLOR_ADMIN_ACTION, "* Você alterou o colete de %s para %.2f.", GetPlayerNamef(targetid), armour);
 	return 1;
 }

//------------------------------------------------------------------------------

YCMD:dararma(playerid, params[], help)
{
   if(GetPlayerRank(playerid) < PLAYER_RANK_MODERATOR)
       return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

   new targetid, weaponid, ammo;
   if(sscanf(params, "uii", targetid, weaponid, ammo))
       return SendClientMessage(playerid, COLOR_INFO, "* /dararma [playerid] [arma] [munição]");

   else if(!IsPlayerLogged(targetid))
       return SendClientMessage(playerid, COLOR_ERROR, "* O jogador não está conectado.");

   else if(weaponid < 0 || weaponid > 46)
       return SendClientMessage(playerid, COLOR_ERROR, "* Arma inválida.");

   else if(ammo < 1)
       return SendClientMessage(playerid, COLOR_ERROR, "* Munição inválida.");

   new weaponname[32];
   GivePlayerWeapon(targetid, weaponid, ammo);
   GetWeaponName(weaponid, weaponname, sizeof(weaponname));
   if(playerid != targetid)
       SendClientMessagef(targetid, COLOR_ADMIN_ACTION, "* %s deu uma %s com %d balas para você.", GetPlayerNamef(playerid), weaponname, ammo);
   SendClientMessagef(playerid, COLOR_ADMIN_ACTION, "* Você deu uma %s com %d balas para %s.", weaponname, ammo, GetPlayerNamef(targetid));
   return 1;
}

//------------------------------------------------------------------------------

YCMD:tirardohospital(playerid, params[], help)
{
   if(GetPlayerRank(playerid) < PLAYER_RANK_MODERATOR)
       return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

   new targetid;
   if(sscanf(params, "u", targetid))
       return SendClientMessage(playerid, COLOR_INFO, "* /tirardohospital [playerid]");

   else if(!IsPlayerLogged(targetid))
       return SendClientMessage(playerid, COLOR_ERROR, "* O jogador não está conectado.");

   else if(GetPlayerHospitalTime(targetid) < 1)
       return SendClientMessage(playerid, COLOR_ERROR, "* O jogador não está no hospital.");

   SetPlayerHospitalTime(targetid, 1);
   if(playerid != targetid)
       SendClientMessagef(targetid, COLOR_ADMIN_ACTION, "* %s tirou você do hospital.", GetPlayerNamef(playerid));
   SendClientMessagef(playerid, COLOR_ADMIN_ACTION, "* Você tirou %s do hospital.", GetPlayerNamef(targetid));
   return 1;
}

//------------------------------------------------------------------------------

YCMD:say(playerid, params[], help)
{
   if(GetPlayerRank(playerid) < PLAYER_RANK_MODERATOR)
       return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

   new message[128];
   if(sscanf(params, "s[128]", message))
       return SendClientMessage(playerid, COLOR_INFO, "* /say [mensagem]");

   new output[144];
   format(output, sizeof(output), "* Admin %s: %s", GetPlayerNamef(playerid), message);
   SendClientMessageToAll(0x97e632ff, output);
   return 1;
}

//------------------------------------------------------------------------------

/***
 *
 *       ##   #####  #    # # #    # #  ####  ##### #####    ##   #####  ####  #####
 *      #  #  #    # ##  ## # ##   # # #        #   #    #  #  #    #   #    # #    #
 *     #    # #    # # ## # # # #  # #  ####    #   #    # #    #   #   #    # #    #
 *     ###### #    # #    # # #  # # #      #   #   #####  ######   #   #    # #####
 *     #    # #    # #    # # #   ## # #    #   #   #   #  #    #   #   #    # #   #
 *     #    # #####  #    # # #    # #  ####    #   #    # #    #   #    ####  #    #
 *
 ***/

YCMD:criarcar(playerid, params[], help)
{
    if(GetPlayerRank(playerid) < PLAYER_RANK_ADMIN)
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

    new
  		idx,
  		iString[ 128 ];

  	if (params[0] == '\0')
  		return SendClientMessage(playerid, COLOR_INFO, "* /criarcar [modeloid/nome]" );

  	idx = GetVehicleModelIDFromName(params);

  	if(idx == -1)
  	{
  		idx = strval(iString);

  		if(idx < 400 || idx > 611)
  			return SendClientMessage(playerid, COLOR_ERROR, "* Veículo inválido.");
  	}

    if(GetAdminCreatedCars(playerid) >= MAX_CREATED_VEH_PER_ADMIN)
    {
		DestroyAdminCars(playerid);
		SendClientMessage(playerid, COLOR_ADMIN_ACTION, "* Veículos criados anteriormente por você foram automaticamente destruídos.");
	}

    CreateAdminCar(playerid, idx);
    return 1;
}

//------------------------------------------------------------------------------

YCMD:setmoney(playerid, params[], help)
{
   if(GetPlayerRank(playerid) < PLAYER_RANK_ADMIN)
       return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

   new targetid, value;
   if(sscanf(params, "ui", targetid, value))
       return SendClientMessage(playerid, COLOR_INFO, "* /setmoney [playerid] [dinheiro]");

   else if(!IsPlayerLogged(targetid))
       return SendClientMessage(playerid, COLOR_ERROR, "* O jogador não está conectado.");

   SetPlayerCash(targetid, value);

   if(playerid != targetid)
       SendClientMessagef(targetid, COLOR_ADMIN_ACTION, "* %s alterou seu dinheiro para $%s.", GetPlayerNamef(playerid), formatnumber(value));

   SendClientMessagef(playerid, COLOR_ADMIN_ACTION, "* Você alterou o dinheiro de %s para $%s.", GetPlayerNamef(targetid), formatnumber(value));
   return 1;
}

//------------------------------------------------------------------------------

YCMD:setjob(playerid, params[], help)
{
   if(GetPlayerRank(playerid) < PLAYER_RANK_ADMIN)
       return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

   new targetid, value;
   if(sscanf(params, "ui", targetid, value))
   {
       SendClientMessage(playerid, COLOR_INFO, "* /setjob [playerid] [emprego]");
       SendClientMessagef(playerid, COLOR_SUB_TITLE, "* (%i)%s - (%i)%s - (%i)%s - (%i)%s - (%i)%s - (%i)%s - (%i)%s",
       _:INVALID_JOB_ID, GetJobName(INVALID_JOB_ID),
       _:PILOT_JOB_ID, GetJobName(PILOT_JOB_ID),
       _:TRUCKER_JOB_ID, GetJobName(TRUCKER_JOB_ID),
       _:LUMBERJACK_JOB_ID, GetJobName(LUMBERJACK_JOB_ID),
       _:NAVIGATOR_JOB_ID, GetJobName(NAVIGATOR_JOB_ID),
       _:PARAMEDIC_JOB_ID, GetJobName(PARAMEDIC_JOB_ID),
       _:GARBAGE_JOB_ID, GetJobName(GARBAGE_JOB_ID));
       return 1;
   }

   else if(!IsPlayerLogged(targetid))
       return SendClientMessage(playerid, COLOR_ERROR, "* O jogador não está conectado.");

   else if(value < 0)
       return SendClientMessage(playerid, COLOR_ERROR, "* Emprego inválido.");

   new Job:job = Job:value;
   SetPlayerJobID(targetid, job);

   if(playerid != targetid)
       SendClientMessagef(targetid, COLOR_ADMIN_ACTION, "* %s alterou seu emprego para %s.", GetPlayerNamef(playerid), GetJobName(job));

   SendClientMessagef(playerid, COLOR_ADMIN_ACTION, "* Você alterou o emprego de %s para %s.", GetPlayerNamef(targetid), GetJobName(job));
   return 1;
}

//------------------------------------------------------------------------------

YCMD:setjoblvl(playerid, params[], help)
{
    if(GetPlayerRank(playerid) < PLAYER_RANK_ADMIN)
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

    new targetid, level;
    if(sscanf(params, "ui", targetid, level))
    {
        SendClientMessage(playerid, COLOR_INFO, "* /setjoblvl [playerid] [level]");
        return 1;
    }

    else if(!IsPlayerLogged(targetid))
        return SendClientMessage(playerid, COLOR_ERROR, "* O jogador não está conectado.");

    SetPlayerJobLV(playerid, level);

    if(playerid != targetid)
        SendClientMessagef(targetid, COLOR_ADMIN_ACTION, "* %s alterou seu level de emprego para %d.", GetPlayerNamef(playerid), level);

    SendClientMessagef(playerid, COLOR_ADMIN_ACTION, "* Você alterou o level do emprego de %s para %d.", GetPlayerNamef(targetid), level);

    return 1;
}

//------------------------------------------------------------------------------

YCMD:setfaction(playerid, params[], help)
{
   if(GetPlayerRank(playerid) < PLAYER_RANK_ADMIN)
       return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

   new targetid, fid;
   if(sscanf(params, "ui", targetid, fid))
   {
       SendClientMessage(playerid, COLOR_INFO, "* /setfaction [playerid] [fID]");
       return 1;
   }

   else if(!IsPlayerLogged(targetid))
       return SendClientMessage(playerid, COLOR_ERROR, "* O jogador não está conectado.");

   else if(fid < 0 || fid > (GetFactionCount() - 1))
       return SendClientMessagef(playerid, COLOR_ERROR, "* Facção inválido, apenas valores entre 0 e %d.", GetFactionCount() - 1);

   SetPlayerFactionID(targetid, fid);
   SetPlayerFactionRankID(targetid, GetFactionMaxRanks(fid) - 1);

   if(playerid != targetid)
       SendClientMessagef(targetid, COLOR_ADMIN_ACTION, "* %s alterou sua facção para %s.", GetPlayerNamef(playerid), GetFactionName(fid));

   SendClientMessagef(playerid, COLOR_ADMIN_ACTION, "* Você alterou a facção de %s para %s.", GetPlayerNamef(targetid), GetFactionName(fid));
   return 1;
}

//------------------------------------------------------------------------------

YCMD:setfrank(playerid, params[], help)
{
   if(GetPlayerRank(playerid) < PLAYER_RANK_ADMIN)
       return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

   new targetid, fid;
   if(sscanf(params, "ui", targetid, fid))
   {
       SendClientMessage(playerid, COLOR_INFO, "* /setfaction [playerid] [frank]");
       return 1;
   }

   else if(!IsPlayerLogged(targetid))
       return SendClientMessage(playerid, COLOR_ERROR, "* O jogador não está conectado.");

   else if(GetPlayerFactionID(targetid) == FACTION_NONE)
       return SendClientMessage(playerid, COLOR_ERROR, "* O jogador não está em uma facção.");

   else if(fid < 0 || fid > (GetFactionMaxRanks(GetPlayerFactionID(targetid)) - 1))
       return SendClientMessagef(playerid, COLOR_ERROR, "* Cargo inválido, apenas valores entre 0 e %d.", GetFactionMaxRanks(GetPlayerFactionID(targetid)) - 1);

   SetPlayerFactionRankID(targetid, fid);

   if(playerid != targetid)
       SendClientMessagef(targetid, COLOR_ADMIN_ACTION, "* %s alterou seu cargo da facção para %s.", GetPlayerNamef(playerid), GetFactionRankName(GetPlayerFactionID(targetid), fid));

   SendClientMessagef(playerid, COLOR_ADMIN_ACTION, "* Você alterou a facção de %s para %s.", GetPlayerNamef(targetid), GetFactionRankName(GetPlayerFactionID(targetid), fid));
   return 1;
}

//------------------------------------------------------------------------------

YCMD:jetpack(playerid, params[], help)
{
   if(GetPlayerRank(playerid) < PLAYER_RANK_ADMIN)
       return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

   SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USEJETPACK);
   return 1;
}

//------------------------------------------------------------------------------

YCMD:fakeban(playerid, params[], help)
{
   if(GetPlayerRank(playerid) < PLAYER_RANK_ADMIN)
       return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

   new targetid, reason[128];
   if(sscanf(params, "us[128]", targetid, reason))
       return SendClientMessage(playerid, COLOR_INFO, "* /fakeban [playerid] [motivo]");

   else if(!IsPlayerLogged(targetid))
       return SendClientMessage(playerid, COLOR_ERROR, "* O jogador não está conectado.");

   else if(playerid == targetid)
       return SendClientMessage(playerid, COLOR_ERROR, "* Você não pode banir você mesmo.");

   else if(GetPlayerRank(targetid) > PLAYER_RANK_PLAYER)
       return SendClientMessage(playerid, COLOR_ERROR, "* Você não pode banir um membro da administração.");

   new output[144];
   format(output, sizeof(output), "* %s foi banido por %s. Motivo: %s", GetPlayerNamef(targetid), GetPlayerNamef(playerid), reason);
   SendClientMessage(playerid, COLOR_SERVER_ANN, output);
   SendClientMessage(targetid, COLOR_SERVER_ANN, output);
   SendClientMessage(targetid, 0xA9C4E4FF, "Server closed the connection.");
   return 1;
}

//------------------------------------------------------------------------------

/***
 *
 *     #####  ###### #    # ###### #       ####  #####  ###### #####
 *     #    # #      #    # #      #      #    # #    # #      #    #
 *     #    # #####  #    # #####  #      #    # #    # #####  #    #
 *     #    # #      #    # #      #      #    # #####  #      #####
 *     #    # #       #  #  #      #      #    # #      #      #   #
 *     #####  ######   ##   ###### ######  ####  #      ###### #    #
 *
 */

YCMD:setrank(playerid, params[], help)
{
	if(IsPlayerAdmin(playerid) || GetPlayerRank(playerid) >= PLAYER_RANK_DEVELOPER)
	{
    	new	targetid, rank;
    	if(sscanf(params, "ui", targetid, rank))
        {
    		SendClientMessage(playerid, COLOR_INFO, "* /setrank [playerid] [rankid]");
            return 1;
        }

        else if(!IsPlayerLogged(targetid))
        {
            SendClientMessage(playerid, COLOR_ERROR, "* O jogador não está conectado.");
        }

        else
        {
            SetPlayerRank(targetid, rank);
            SendClientMessagef(targetid, COLOR_ADMIN_ACTION, "* %s alterou seu rank para %s.", GetPlayerNamef(playerid), GetPlayerRankName(targetid));
            SendClientMessagef(playerid, COLOR_ADMIN_ACTION, "* Você alterou o rank de %s para %s.", GetPlayerNamef(targetid), GetPlayerRankName(targetid));
        }
    }
    else
    {
        SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");
    }
	return 1;
}
