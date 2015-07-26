/*******************************************************************************
* FILENAME :        modules/data/admin.pwn
*
* DESCRIPTION :
*       Adds admins commands to the server.
*
* NOTES :
*       This file should only contain admin data.
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
* AUTHOR :    Larceny           START DATE :    25 Jul 15
*
*/

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

YCMD:criarcar(playerid, params[], help)
{
    new
		idx,
		iString[ 128 ];

	if ( params[ 0 ] == '\0' )
		return SendClientMessage( playerid, COLOR_INFO, "* /criarcar [modeloid/nome]" );

	idx = GetVehicleModelIDFromName( params );

	if( idx == -1 )
	{
		idx = strval(iString);

		if ( idx < 400 || idx > 611 )
			return SendClientMessage(playerid, COLOR_ERROR, "* Veículo inválido.");
	}

	new	Float:x, Float:y, Float:z, Float:a;
	GetPlayerPos(playerid, x, y, z);
	GetXYInFrontOfPlayer(playerid, x, y, 5.0);
	GetPlayerFacingAngle(playerid, a);

	new vehicleid = CreateVehicle(idx, x, y, z + 2.0, a + 90.0, -1, -1, 5000);
	LinkVehicleToInterior(vehicleid, GetPlayerInterior(playerid));
    SetVehicleFuel(vehicleid, 100.0);

    format(iString, 128, "* Você criou um \"%s\" (ModeloID: %d, VeículoID: %d)", aVehicleNames[idx - 400], idx, vehicleid);
	SendClientMessage(playerid, COLOR_SUCCESS, iString);
    return 1;
}
