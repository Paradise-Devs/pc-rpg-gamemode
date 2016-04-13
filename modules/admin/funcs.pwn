/*******************************************************************************
* FILENAME :        modules/admin/funcs.pwn
*
* DESCRIPTION :
*       Adds admins functions.
*
* NOTES :
*       This file should only contain admin funcs.
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

//------------------------------------------------------------------------------

#include <YSI\y_hooks>

#define MAX_CREATED_VEH_PER_ADMIN	1

//------------------------------------------------------------------------------

static gAdminCreatedCars[MAX_PLAYERS][MAX_CREATED_VEH_PER_ADMIN];
static gAdminCCarsCount[MAX_PLAYERS];

//------------------------------------------------------------------------------

hook OnPlayerDisconnect(playerid, reason)
{
	if(gAdminCCarsCount[playerid] > 0)
		DestroyAdminCars(playerid);
	return 1;
}

//------------------------------------------------------------------------------

GetAdminCreatedCars(playerid)
{
	return gAdminCCarsCount[playerid];
}

//------------------------------------------------------------------------------

CreateAdminCar(playerid, index)
{
	new	Float:x, Float:y, Float:z, Float:a, vehicleid;
	GetPlayerPos(playerid, x, y, z);
	GetXYInFrontOfPlayer(playerid, x, y, 5.0);
	GetPlayerFacingAngle(playerid, a);

	vehicleid = CreateVehicle(index, x, y, z + 2.0, a, -1, -1, 5000);

	gAdminCreatedCars[playerid][gAdminCCarsCount[playerid]] = vehicleid;

	LinkVehicleToInterior(vehicleid, GetPlayerInterior(playerid));
	PutPlayerInVehicle(playerid, vehicleid, 0);
	SetVehicleEngineState(vehicleid, true);
	SetVehicleFuel(vehicleid, 100);

    gAdminCCarsCount[playerid]++;

	SendClientMessagef(playerid, COLOR_ADMIN_ACTION, "* Você criou um \"%s\" (modelid: %d - vehid: %d)", aVehicleNames[index - 400], index, vehicleid);
	return 1;
}

//------------------------------------------------------------------------------

DestroyAdminCars(playerid)
{
	for(new i = 0; i < MAX_CREATED_VEH_PER_ADMIN; i++)
	{
		if(gAdminCreatedCars[playerid][i] != 0)
		{
			DestroyVehicle(gAdminCreatedCars[playerid][i]);
			gAdminCreatedCars[playerid][i] = 0;
		}
	}

    gAdminCCarsCount[playerid] = 0;
	return 1;
}

//------------------------------------------------------------------------------

KickEx(playerid, admin, reason[]) {
	new outputAll[144];
	format(outputAll, sizeof(outputAll), "* %s foi kickado por %s. Motivo: %s", GetPlayerNamef(playerid), GetPlayerNamef(admin), reason);

	new outputPlayer[144];
	format(outputPlayer, sizeof(outputPlayer), "* Você foi kickado do servidor por %s. Motivo: %s", GetPlayerNamef(admin), reason);

	foreach(new i: Player) {
		if(i != playerid) {
			SendClientMessage(i, COLOR_SERVER_ANN, outputAll);
		} else {
			SendClientMessage(i, COLOR_SERVER_ANN, outputPlayer);
		}
	}
	SetTimerEx("KickPlayer", 800, false, "i", playerid);
	return 1;
}

//------------------------------------------------------------------------------

PermaBan(playerid, admin, reason[]) {
	new outputAll[144];
	format(outputAll, sizeof(outputAll), "* %s foi banido permanentemente por %s. Motivo: %s", GetPlayerNamef(playerid), GetPlayerNamef(admin), reason);

	new outputPlayer[144];
	format(outputPlayer, sizeof(outputPlayer), "* Você foi banido permanentemente do servidor por %s. Motivo: %s", GetPlayerNamef(admin), reason);

	foreach(new i: Player) {
		if(i != playerid) {
			SendClientMessage(i, COLOR_SERVER_ANN, outputAll);
		} else {
			SendClientMessage(i, COLOR_SERVER_ANN, outputPlayer);
		}
	}
	SetTimerEx("PermaBanPlayer", 800, false, "i", playerid);
	return 1;
}

//------------------------------------------------------------------------------

TempBan(playerid, admin, reason[], days) {
	new outputAll[144];
	format(outputAll, sizeof(outputAll), "* %s foi banido durante %d dias por %s. Motivo: %s", GetPlayerNamef(playerid), days, GetPlayerNamef(admin), reason);

	new outputPlayer[144];
	format(outputPlayer, sizeof(outputPlayer), "* Você foi banido durante %d dias por %s. Motivo: %s", days, GetPlayerNamef(admin), reason);

	foreach(new i: Player) {
		if(i != playerid) {
			SendClientMessage(i, COLOR_SERVER_ANN, outputAll);
		} else {
			SendClientMessage(i, COLOR_SERVER_ANN, outputPlayer);
		}
	}
	SetTimerEx("TempBanPlayer", 800, false, "ii", playerid, admin, reason, days);
	return 1;
}

//------------------------------------------------------------------------------

forward KickPlayer(playerid);
public KickPlayer(playerid) {
	return Kick(playerid);
}

forward PermaBanPlayer(playerid, adminid, reason[], days);
public PermaBanPlayer(playerid, adminid, reason[], days) {
	new r = gettime();
	new query[250], playerIP[16];
	GetPlayerIp(playerid, playerIP, 16);
	mysql_format(mysql, query, sizeof(query), "INSERT INTO `bans` (`username`, `IP`, `reason`, `initial_unix`, `final_unix`, `admin`) VALUES ('%e', '%e', '%e', %d, '-255', '%e')", GetPlayerNamef(playerid), playerIP, reason, r, GetPlayerNamef(adminid));
	mysql_tquery(mysql, query, "OnPlayerAccountBanned", "i", playerid);
	return Kick(playerid);
}

forward TempBanPlayer(playerid, adminid, reason[], days);
public TempBanPlayer(playerid, adminid, reason[], days) {
	new r = gettime();
	new totald = r + (86400 * days);
	new query[250], playerIP[16];
	GetPlayerIp(playerid, playerIP, 16);
	mysql_format(mysql, query, sizeof(query), "INSERT INTO `bans` (`username`, `IP`, `reason`, `initial_unix`, `final_unix`, `admin`) VALUES ('%e', '%e', '%e', %d, %d, '%e')", GetPlayerNamef(playerid), playerIP, reason, r, totald, GetPlayerNamef(adminid));
	mysql_tquery(mysql, query, "OnPlayerAccountBanned", "i", playerid);
	return Kick(playerid);
}

forward OnPlayerAccountBanned(playerid);
public OnPlayerAccountBanned(playerid) {
	cache_insert_id();
	printf("[mysql] new account banned on database. Username: %s", GetPlayerNamef(playerid));
	return 1;
}
