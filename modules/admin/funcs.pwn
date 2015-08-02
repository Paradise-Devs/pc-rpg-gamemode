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
CreateAdminCar(playerid, index)
{
	new
		Float:x,
		Float:y,
		Float:z,
		Float:a,
		vehicleid;

	GetPlayerPos(playerid, x, y, z);
	GetXYInFrontOfPlayer(playerid, x, y, 5.0);
	GetPlayerFacingAngle(playerid, a);

	vehicleid = CreateVehicle(index, x, y, z + 2.0, a, -1, -1, 5000);

	if(GetAdminCreatedCars(playerid) == 0) {
		gAdminCreatedCars[playerid][0] = vehicleid;
	} else {
		gAdminCreatedCars[playerid][GetAdminCreatedCars(playerid) + 1] = vehicleid;
	}

	LinkVehicleToInterior(vehicleid, GetPlayerInterior(playerid));
	PutPlayerInVehicle(playerid, vehicleid, 0);
	SetVehicleEngineState(vehicleid, true);
	SetVehicleFuel(vehicleid, 100);

    gAdminCCarsCount[playerid]++;

	SendClientMessagef(playerid, COLOR_ADMIN_ACTION, "* Você criou um \"%s\" (modelid: %d - vehid: %d)", aVehicleNames[index - 400], index, vehicleid);

	return 1;
}

DestroyAdminCars(playerid) {
	for(new i = 0; i <= MAX_CREATED_VEH_PER_ADMIN; i++)
		DestroyVehicle(gAdminCreatedCars[playerid][i]);

    gAdminCCarsCount[playerid] = 0;

	return 1;
}
