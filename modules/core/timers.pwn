/* *************************************************************************** *
*  Description: Business module file.
*
*  Assignment: A script to make business available to players buy & sell.
*
*           Copyright Paradise Devs 2015.  All rights reserved.
* *************************************************************************** */

#if defined _MODULE_timers
	#endinput
#endif
#define _MODULE_timers

#include <YSI\y_hooks>

ptask UpdatePlayerData[1000](playerid)
{
    if(GetPVarInt(playerid, "PickupDelay") > 0)
        SetPVarInt(playerid, "PickupDelay", GetPVarInt(playerid, "PickupDelay") - 1);

	UpdatePlayerGPS(playerid);
    return 1;
}
