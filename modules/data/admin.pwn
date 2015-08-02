/*******************************************************************************
* FILENAME :        modules/data/admin.pwn
*
* DESCRIPTION :
*       Manages all admin data
*
* NOTES :
*       This file should only contain information about admin's data.
*       This is not intended to handle admin actions and such.
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

#include <YSI\y_hooks>

#define MAX_CREATED_VEH_PER_ADMIN	1

new gAdminCreatedCars[MAX_PLAYERS][MAX_CREATED_VEH_PER_ADMIN];
new gAdminCCarsCount[MAX_PLAYERS];

GetAdminCreatedCars(playerid) {
	return gAdminCCarsCount[playerid];
}

hook OnPlayerConnect(playerid)
{
    gAdminCCarsCount[playerid] = 0;

    for(new i = 0; i <= MAX_CREATED_VEH_PER_ADMIN; i++)
        gAdminCreatedCars[playerid][i] = -1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	if(GetAdminCreatedCars(playerid) > 1) {
		DestroyAdminCars(playerid);
	}
}
