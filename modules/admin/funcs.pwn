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
