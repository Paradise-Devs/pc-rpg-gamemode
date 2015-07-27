/*******************************************************************************
* FILENAME :        modules/vehicle/reserve.pwn
*
* DESCRIPTION :
*       Avoid player entering vehicles that they have not permission.
*
* NOTES :
*       This file should only contain information about vehicle reservation.
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    new vfactionid = GetVehicleFactionID(vehicleid);
    new pfactionid = GetPlayerFactionID(playerid);
    if(vfactionid != 0 && pfactionid != vfactionid)
    {
        new output[58];
        format(output, sizeof(output), "* Você não pertence a %s.", GetFactionName(vfactionid));
        SendClientMessage(playerid, COLOR_ERROR, output);
        ClearAnimations(playerid);
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
            new vfactionid = GetVehicleFactionID(GetPlayerVehicleID(playerid));
            new pfactionid = GetPlayerFactionID(playerid);
            if(vfactionid != 0 && pfactionid != vfactionid)
            {
                new output[58];
                format(output, sizeof(output), "* Você não pertence a %s.", GetFactionName(vfactionid));
                SendClientMessage(playerid, COLOR_ERROR, output);
                RemovePlayerFromVehicle(playerid);
            }
        }
    }
    return 1;
}
