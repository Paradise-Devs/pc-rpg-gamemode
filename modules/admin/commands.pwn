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

static gplMarkExt[MAX_PLAYERS][2];
static Float:gplMarkPos[MAX_PLAYERS][3];

//------------------------------------------------------------------------------

YCMD:acmds(playerid, params[], help)
{
    if(GetPlayerHighestRank(playerid) < PLAYER_RANK_MODERATOR)
 		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

	SendClientMessage(playerid, COLOR_TITLE, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Comandos Administrativos ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	if(GetPlayerHighestRank(playerid) >= PLAYER_RANK_MODERATOR)
    {
        SendClientMessage(playerid, COLOR_SUB_TITLE, "* /ir - /puxar - /flip - /reparar - /ls - /sf - /lv - /sairdohospital - /setskin - /kick - /ban - /irpos - /fuelveh");
        SendClientMessage(playerid, COLOR_SUB_TITLE, "* /rtc - /ircar - /puxarcar - /tdist - /marcar - /irmarca - /sethp - /setarmour - /dararma - /tirardohospital");
        SendClientMessage(playerid, COLOR_SUB_TITLE, "* /pm - /say");
    }

	if(GetPlayerHighestRank(playerid) >= PLAYER_RANK_ADMIN)
        SendClientMessage(playerid, COLOR_SUB_TITLE, "* /criarcar - /setmoney - /setjob - /lotto - /jetpack - /fakeban");

    if(IsPlayerAdmin(playerid))
        SendClientMessage(playerid, COLOR_SUB_TITLE, "* /avehcmds");

	SendClientMessage(playerid, COLOR_TITLE, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Comandos Administrativos ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	return 1;
}

//------------------------------------------------------------------------------

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

 YCMD:ir(playerid, params[], help)
 {
 	if(GetPlayerHighestRank(playerid) < PLAYER_RANK_MODERATOR)
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
 	return 1;
 }

//------------------------------------------------------------------------------

 YCMD:puxar(playerid, params[], help)
 {
 	if(GetPlayerHighestRank(playerid) < PLAYER_RANK_MODERATOR)
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
 	return 1;
 }

//------------------------------------------------------------------------------

 YCMD:flip(playerid, params[], help)
 {
 	if(GetPlayerHighestRank(playerid) < PLAYER_RANK_MODERATOR)
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
    if(GetPlayerHighestRank(playerid) < PLAYER_RANK_MODERATOR)
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
 	if(GetPlayerHighestRank(playerid) < PLAYER_RANK_MODERATOR)
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
	if(GetPlayerHighestRank(playerid) < PLAYER_RANK_MODERATOR)
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
    if(GetPlayerHighestRank(playerid) < PLAYER_RANK_MODERATOR)
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

YCMD:sairdohospital(playerid, params[], help)
{
    if(GetPlayerHighestRank(playerid) < PLAYER_RANK_MODERATOR)
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

    else if(GetPlayerHospitalTime(playerid) < 1)
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não está no hospital.");

    SetPlayerHospitalTime(playerid, 1);
    return 1;
}

//------------------------------------------------------------------------------

 YCMD:setskin(playerid, params[], help)
 {
 	if(GetPlayerHighestRank(playerid) < PLAYER_RANK_MODERATOR)
 		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

 	new targetid, skinid;
 	if(sscanf(params, "ui", targetid, skinid))
 		return SendClientMessage(playerid, COLOR_INFO, "* /setskin [playerid] [skin]");

 	else if(!IsPlayerLogged(targetid))
 		return SendClientMessage(playerid, COLOR_ERROR, "* O jogador não está conectado.");

    else if(skinid < 0 || skinid > 311)
 		return SendClientMessage(playerid, COLOR_ERROR, "* Skin inválida.");

 	SetPlayerSkin(targetid, skinid);
    if(playerid != targetid)
        SendClientMessagef(targetid, COLOR_ADMIN_ACTION, "* %s alterou sua skin para %d.", GetPlayerNamef(playerid), skinid);
    SendClientMessagef(playerid, COLOR_ADMIN_ACTION, "* Você alterou a skin de %s para %d.", GetPlayerNamef(targetid), skinid);
    SetSpawnInfo(targetid, 255, skinid, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 0, 0);
 	return 1;
 }

//------------------------------------------------------------------------------

YCMD:kick(playerid, params[], help)
{
   if(GetPlayerHighestRank(playerid) < PLAYER_RANK_MODERATOR)
       return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

   new targetid, reason[128];
   if(sscanf(params, "us[128]", targetid, reason))
       return SendClientMessage(playerid, COLOR_INFO, "* /kick [playerid] [motivo]");

   else if(!IsPlayerLogged(targetid))
       return SendClientMessage(playerid, COLOR_ERROR, "* O jogador não está conectado.");

   else if(playerid == targetid)
       return SendClientMessage(playerid, COLOR_ERROR, "* Você não pode kickar você mesmo.");

   else if(GetPlayerHighestRank(targetid) > PLAYER_RANK_BETATESTER)
       return SendClientMessage(playerid, COLOR_ERROR, "* Você não pode kickar um membro da administração.");

   new output[144];
   format(output, sizeof(output), "* %s foi kickado por %s. Motivo: %s", GetPlayerNamef(targetid), GetPlayerNamef(playerid), reason);
   SendClientMessageToAll(0xf26363ff, output);
   Kick(targetid);
   return 1;
}

//------------------------------------------------------------------------------

YCMD:ban(playerid, params[], help)
{
   if(GetPlayerHighestRank(playerid) < PLAYER_RANK_MODERATOR)
       return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

   new targetid, reason[128];
   if(sscanf(params, "us", targetid, reason))
       return SendClientMessage(playerid, COLOR_INFO, "* /kick [playerid] [motivo]");

   else if(!IsPlayerLogged(targetid))
       return SendClientMessage(playerid, COLOR_ERROR, "* O jogador não está conectado.");

   else if(playerid == targetid)
       return SendClientMessage(playerid, COLOR_ERROR, "* Você não pode banir você mesmo.");

   else if(GetPlayerHighestRank(targetid) > PLAYER_RANK_BETATESTER)
       return SendClientMessage(playerid, COLOR_ERROR, "* Você não pode banir um membro da administração.");

   new output[144];
   format(output, sizeof(output), "* %s foi banido por %s. Motivo: %s", GetPlayerNamef(targetid), GetPlayerNamef(playerid), reason);
   SendClientMessageToAll(0xf26363ff, output);
   Ban(targetid);
   return 1;
}

//------------------------------------------------------------------------------

YCMD:irpos(playerid, params[], help)
{
    if(GetPlayerHighestRank(playerid) < PLAYER_RANK_MODERATOR)
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

YCMD:fuelveh(playerid, params[], help)
{
    if(GetPlayerHighestRank(playerid) < PLAYER_RANK_MODERATOR)
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

    else if(!IsPlayerInAnyVehicle(playerid))
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não está em um veículo.");

	SetVehicleFuel(GetPlayerVehicleID(playerid), 100.0);
	return 1;
}
//------------------------------------------------------------------------------

YCMD:rtc(playerid, params[], help)
{
    if(GetPlayerHighestRank(playerid) < PLAYER_RANK_MODERATOR)
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

    else if(!IsPlayerInAnyVehicle(playerid))
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não está em um veículo.");

	SetVehicleToRespawn(GetPlayerVehicleID(playerid));
	return 1;
}

//------------------------------------------------------------------------------

YCMD:ircar(playerid, params[], help)
{
    if(GetPlayerHighestRank(playerid) < PLAYER_RANK_MODERATOR)
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

YCMD:puxarcar(playerid, params[], help)
{
    if(GetPlayerHighestRank(playerid) < PLAYER_RANK_MODERATOR)
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
    if(GetPlayerHighestRank(playerid) < PLAYER_RANK_MODERATOR)
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
    if(GetPlayerHighestRank(playerid) < PLAYER_RANK_MODERATOR)
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
    if(GetPlayerHighestRank(playerid) < PLAYER_RANK_MODERATOR)
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
 	if(GetPlayerHighestRank(playerid) < PLAYER_RANK_MODERATOR)
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

 YCMD:setarmour(playerid, params[], help)
 {
 	if(GetPlayerHighestRank(playerid) < PLAYER_RANK_MODERATOR)
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
   if(GetPlayerHighestRank(playerid) < PLAYER_RANK_MODERATOR)
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
   if(GetPlayerHighestRank(playerid) < PLAYER_RANK_MODERATOR)
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

YCMD:pm(playerid, params[], help)
{
   if(GetPlayerHighestRank(playerid) < PLAYER_RANK_MODERATOR)
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
   format(output, sizeof(output), "* [MP] para %s(ID: %d): %s", GetPlayerNamef(targetid), targetid, message);
   SendClientMessage(playerid, 0x26b4cdff, output);
   return 1;
}
//------------------------------------------------------------------------------

YCMD:say(playerid, params[], help)
{
   if(GetPlayerHighestRank(playerid) < PLAYER_RANK_MODERATOR)
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
    if(GetPlayerHighestRank(playerid) < PLAYER_RANK_ADMIN)
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

    new
  		idx,
  		iString[ 128 ];

  	if ( params[ 0 ] == '\0' )
  		return SendClientMessage(playerid, COLOR_INFO, "* /criarcar [modeloid/nome]" );

  	idx = GetVehicleModelIDFromName(params);

  	if(idx == -1)
  	{
  		idx = strval(iString);

  		if (idx < 400 || idx > 611)
  			return SendClientMessage(playerid, COLOR_ERROR, "* Veículo inválido.");
  	}

  	new	Float:x, Float:y, Float:z, Float:a;
  	GetPlayerPos(playerid, x, y, z);
  	GetXYInFrontOfPlayer(playerid, x, y, 5.0);
  	GetPlayerFacingAngle(playerid, a);

    new vehicleid = CreateVehicle(idx, x, y, z + 2.0, a + 90.0, -1, -1, 5000);
    LinkVehicleToInterior(vehicleid, GetPlayerInterior(playerid));
    SetVehicleFuel(vehicleid, 100.0);

    SendClientMessagef(playerid, COLOR_ADMIN_ACTION, "* Você criou um \"%s\" (ModeloID: %d, VeículoID: %d)", aVehicleNames[idx - 400], idx, vehicleid);
    return 1;
}

//------------------------------------------------------------------------------

YCMD:setmoney(playerid, params[], help)
{
   if(GetPlayerHighestRank(playerid) < PLAYER_RANK_ADMIN)
       return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

   new targetid, value;
   if(sscanf(params, "ui", targetid, value))
       return SendClientMessage(playerid, COLOR_INFO, "* /setmoney [playerid] [dinheiro]");

   else if(!IsPlayerLogged(targetid))
       return SendClientMessage(playerid, COLOR_ERROR, "* O jogador não está conectado.");

   SetPlayerCash(playerid, value);

   if(playerid != targetid)
       SendClientMessagef(playerid, COLOR_ADMIN_ACTION, "* %s alterou seu dinheiro para $%s.", GetPlayerNamef(playerid), formatnumber(value));

   SendClientMessagef(playerid, COLOR_ADMIN_ACTION, "* Você alterou o dinheiro de %s para $%s.", GetPlayerNamef(targetid), formatnumber(value));
   return 1;
}

//------------------------------------------------------------------------------

YCMD:setjob(playerid, params[], help)
{
   if(GetPlayerHighestRank(playerid) < PLAYER_RANK_ADMIN)
       return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

   new targetid, value;
   if(sscanf(params, "ui", targetid, value))
       return SendClientMessage(playerid, COLOR_INFO, "* /setjob [playerid] [emprego]");

   else if(!IsPlayerLogged(targetid))
       return SendClientMessage(playerid, COLOR_ERROR, "* O jogador não está conectado.");

   new Job:job = Job:value;
   SetPlayerJobID(targetid, job);

   if(playerid != targetid)
       SendClientMessagef(targetid, COLOR_ADMIN_ACTION, "* %s alterou seu emprego para %s.", GetPlayerNamef(playerid), GetJobName(job));

   SendClientMessagef(playerid, COLOR_ADMIN_ACTION, "* Você alterou o emprego de %s para %s.", GetPlayerNamef(targetid), GetJobName(job));
   return 1;
}

//------------------------------------------------------------------------------

YCMD:jetpack(playerid, params[], help)
{
   if(GetPlayerHighestRank(playerid) < PLAYER_RANK_ADMIN)
       return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

   SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USEJETPACK);
   return 1;
}

//------------------------------------------------------------------------------

YCMD:fakeban(playerid, params[], help)
{
   if(GetPlayerHighestRank(playerid) < PLAYER_RANK_ADMIN)
       return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

   new targetid, reason[128];
   if(sscanf(params, "us[128]", targetid, reason))
       return SendClientMessage(playerid, COLOR_INFO, "* /fakeban [playerid] [motivo]");

   else if(!IsPlayerLogged(targetid))
       return SendClientMessage(playerid, COLOR_ERROR, "* O jogador não está conectado.");

   else if(playerid == targetid)
       return SendClientMessage(playerid, COLOR_ERROR, "* Você não pode banir você mesmo.");

   else if(GetPlayerHighestRank(targetid) > PLAYER_RANK_BETATESTER)
       return SendClientMessage(playerid, COLOR_ERROR, "* Você não pode banir um membro da administração.");

   new output[144];
   format(output, sizeof(output), "* %s foi banido por %s. Motivo: %s", GetPlayerNamef(targetid), GetPlayerNamef(playerid), reason);
   SendClientMessage(playerid, 0xf26363ff, output);
   SendClientMessage(targetid, 0xf26363ff, output);
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
	if(IsPlayerAdmin(playerid) || GetPlayerHighestRank(playerid) >= PLAYER_RANK_DEVELOPER)
	{
    	new	targetid, rankName[9], option[8];

    	if(sscanf(params, "us[9]s[8]", targetid, rankName, option))
        {
    		SendClientMessage(playerid, COLOR_INFO, "* /setrank [playerid] [nome do rank] [add / remover]");
    		SendClientMessage(playerid, COLOR_INFO, "* Ranks: donator, designer, beta, mod, super, admin, dev");
            return 1;
        }

        else if(!strcmp(rankName, "donator", true))
        {
            if(!strcmp(option, "add", true))
            {
                if(targetid == playerid)
                    SendClientMessage(playerid, COLOR_SUCCESS, "* Você alterou sua conta para donator com sucesso.");
                else
                {
                    SendClientMessagef(playerid, COLOR_SUCCESS, "* Conta de %s foi alterada para donator com sucesso.", GetPlayerNamef(targetid));
                    SendClientMessagef(targetid, COLOR_SUCCESS, "* %s alterou sua conta para donator.", GetPlayerNamef(playerid));
                }
                SetPlayerRank(PLAYER_RANK_DONATOR, targetid, true);
            }
            else if(!strcmp(option, "remover", true))
            {
                if(targetid == playerid)
                    SendClientMessage(playerid, COLOR_SUCCESS, "* Você removeu seu rank de donator com sucesso.");
                else
                {
                    SendClientMessagef(playerid, COLOR_SUCCESS, "* Conta de %s foi removida de donator com sucesso.", GetPlayerNamef(targetid));
                    SendClientMessagef(targetid, COLOR_SUCCESS, "* %s removeu seu rank de donator.", GetPlayerNamef(playerid));
                }
                SetPlayerRank(PLAYER_RANK_DONATOR, targetid, false);
            }
            else
                SendClientMessage(playerid, COLOR_ERROR, "* Opção inválida.");
        }
        else if(!strcmp(rankName, "designer", true))
        {
            if(!strcmp(option, "add", true))
            {
                if(targetid == playerid)
                    SendClientMessage(playerid, COLOR_SUCCESS, "* Você alterou sua conta para designer com sucesso.");
                else
                {
                    SendClientMessagef(playerid, COLOR_SUCCESS, "* Conta de %s alterada para designer com sucesso.", GetPlayerNamef(targetid));
                    SendClientMessagef(targetid, COLOR_SUCCESS, "* %s alterou sua conta para designer.", GetPlayerNamef(playerid));
                }
                SetPlayerRank(PLAYER_RANK_DESIGNER, targetid, true);
            }
            else if(!strcmp(option, "remover", true))
            {
                if(targetid == playerid)
                    SendClientMessage(playerid, COLOR_SUCCESS, "* Você removeu seu rank de designer com sucesso.");
                else
                {
                    SendClientMessagef(playerid, COLOR_SUCCESS, "* Conta de %s foi removida de designer com sucesso.", GetPlayerNamef(targetid));
                    SendClientMessagef(targetid, COLOR_SUCCESS, "* %s removeu seu rank de designer.", GetPlayerNamef(playerid));
                }
                SetPlayerRank(PLAYER_RANK_DESIGNER, targetid, false);
            }
            else
                SendClientMessage(playerid, COLOR_ERROR, "* Opção inválida.");
        }
        else if(!strcmp(rankName, "beta", true))
        {
            if(!strcmp(option, "add", true))
            {
                if(targetid == playerid)
                    SendClientMessage(playerid, COLOR_SUCCESS, "* Você alterou sua conta para beta-tester com sucesso.");
                else
                {
                    SendClientMessagef(playerid, COLOR_SUCCESS, "* Conta de %s alterada para beta-tester com sucesso.", GetPlayerNamef(targetid));
                    SendClientMessagef(targetid, COLOR_SUCCESS, "* %s alterou sua conta para beta-tester.", GetPlayerNamef(playerid));
                }
                SetPlayerRank(PLAYER_RANK_BETATESTER, targetid, true);
            }
            else if(!strcmp(option, "remover", true))
            {
                if(targetid == playerid)
                    SendClientMessage(playerid, COLOR_SUCCESS, "* Você removeu seu rank de beta-tester com sucesso.");
                else
                {
                    SendClientMessagef(playerid, COLOR_SUCCESS, "* Conta de %s foi removida de beta-tester com sucesso.", GetPlayerNamef(targetid));
                    SendClientMessagef(targetid, COLOR_SUCCESS, "* %s removeu seu rank de beta-tester.", GetPlayerNamef(playerid));
                }
                SetPlayerRank(PLAYER_RANK_BETATESTER, targetid, false);
            }
            else
                SendClientMessage(playerid, COLOR_ERROR, "* Opção inválida.");
        }
        else if(!strcmp(rankName, "mod", true))
        {
            if(!strcmp(option, "add", true))
            {
                if(targetid == playerid)
                    SendClientMessage(playerid, COLOR_SUCCESS, "* Você alterou sua conta para moderador com sucesso.");
                else
                {
                    SendClientMessagef(playerid, COLOR_SUCCESS, "* Conta de %s alterada para moderador com sucesso.", GetPlayerNamef(targetid));
                    SendClientMessagef(targetid, COLOR_SUCCESS, "* %s alterou sua conta para moderador.", GetPlayerNamef(playerid));
                }
                SetPlayerRank(PLAYER_RANK_MODERATOR, targetid, true);
            }
            else if(!strcmp(option, "remover", true))
            {
                if(targetid == playerid)
                    SendClientMessage(playerid, COLOR_SUCCESS, "* Você removeu seu rank de moderador com sucesso.");
                else
                {
                    SendClientMessagef(playerid, COLOR_SUCCESS, "* Conta de %s foi removida de moderador com sucesso.", GetPlayerNamef(targetid));
                    SendClientMessagef(targetid, COLOR_SUCCESS, "* %s removeu seu rank de moderador.", GetPlayerNamef(playerid));
                }
                SetPlayerRank(PLAYER_RANK_MODERATOR, targetid, false);
            }
            else
                SendClientMessage(playerid, COLOR_ERROR, "* Opção inválida.");
        }
        else if(!strcmp(rankName, "super", true))
        {
            if(!strcmp(option, "add", true))
            {
                if(targetid == playerid)
                    SendClientMessage(playerid, COLOR_SUCCESS, "* Você alterou sua conta para supervisor com sucesso.");
                else
                {
                    SendClientMessagef(playerid, COLOR_SUCCESS, "* Conta de %s alterada para supervisor com sucesso.", GetPlayerNamef(targetid));
                    SendClientMessagef(targetid, COLOR_SUCCESS, "* %s alterou sua conta para supervisor.", GetPlayerNamef(playerid));
                }
                SetPlayerRank(PLAYER_RANK_SUPERVISOR, targetid, true);
            }
            else if(!strcmp(option, "remover", true))
            {
                if(targetid == playerid)
                    SendClientMessage(playerid, COLOR_SUCCESS, "* Você removeu seu rank de supervisor com sucesso.");
                else
                {
                    SendClientMessagef(playerid, COLOR_SUCCESS, "* Conta de %s foi removida de supervisor com sucesso.", GetPlayerNamef(targetid));
                    SendClientMessagef(targetid, COLOR_SUCCESS, "* %s removeu seu rank de supervisor.", GetPlayerNamef(playerid));
                }
                SetPlayerRank(PLAYER_RANK_SUPERVISOR, targetid, false);
            }
            else
                SendClientMessage(playerid, COLOR_ERROR, "* Opção inválida.");
        }
        else if(!strcmp(rankName, "admin", true))
        {
            if(!strcmp(option, "add", true))
            {
                if(targetid == playerid)
                    SendClientMessage(playerid, COLOR_SUCCESS, "* Você alterou sua conta para administrador com sucesso.");
                else
                {
                    SendClientMessagef(playerid, COLOR_SUCCESS, "* Conta de %s alterada para administrador com sucesso.", GetPlayerNamef(targetid));
                    SendClientMessagef(targetid, COLOR_SUCCESS, "* %s alterou sua conta para administrador.", GetPlayerNamef(playerid));
                }
                SetPlayerRank(PLAYER_RANK_ADMIN, targetid, true);
            }
            else if(!strcmp(option, "remover", true))
            {
                if(targetid == playerid)
                    SendClientMessage(playerid, COLOR_SUCCESS, "* Você removeu seu rank de administrador com sucesso.");
                else
                {
                    SendClientMessagef(playerid, COLOR_SUCCESS, "* Conta de %s foi removida de administrador com sucesso.", GetPlayerNamef(targetid));
                    SendClientMessagef(targetid, COLOR_SUCCESS, "* %s removeu seu rank de administrador.", GetPlayerNamef(playerid));
                }
                SetPlayerRank(PLAYER_RANK_ADMIN, targetid, false);
            }
            else
                SendClientMessage(playerid, COLOR_ERROR, "* Opção inválida.");
        }
        else if(!strcmp(rankName, "dev", true))
        {
            if(!strcmp(option, "add", true))
            {
                if(targetid == playerid)
                    SendClientMessage(playerid, COLOR_SUCCESS, "* Você alterou sua conta para developer com sucesso.");
                else
                {
                    SendClientMessagef(playerid, COLOR_SUCCESS, "* Conta de %s alterada para developer com sucesso.", GetPlayerNamef(targetid));
                    SendClientMessagef(targetid, COLOR_SUCCESS, "* %s alterou sua conta para developer.", GetPlayerNamef(playerid));
                }
                SetPlayerRank(PLAYER_RANK_DEVELOPER, targetid, true);
            }
            else if(!strcmp(option, "remover", true))
            {
                if(targetid == playerid)
                    SendClientMessage(playerid, COLOR_SUCCESS, "* Você removeu seu rank de developer com sucesso.");
                else
                {
                    SendClientMessagef(playerid, COLOR_SUCCESS, "* Conta de %s foi removida de developer com sucesso.", GetPlayerNamef(targetid));
                    SendClientMessagef(targetid, COLOR_SUCCESS, "* %s removeu seu rank de developer.", GetPlayerNamef(playerid));
                }
                SetPlayerRank(PLAYER_RANK_DEVELOPER, targetid, false);
            }
            else
                SendClientMessage(playerid, COLOR_ERROR, "* Opção inválida.");
        }
    }
    else
        SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");
	return 1;
}
