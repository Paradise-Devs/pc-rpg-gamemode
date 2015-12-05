/* *************************************************************************** *
*  Description: NPCs module file.
*
*  Assignment: A script to add npcs on the server.
*
*           Copyright Paradise Devs 2015.  All rights reserved.
* *************************************************************************** */

#include <YSI\y_hooks>

static g_AirPortBus;

hook OnGameModeInit()
{
    g_AirPortBus = AddStaticVehicle(437, 1431.9888, -2283.2092, 13.5162, 1.1216, 79, 7);
    SetVehicleFuel(g_AirPortBus, 100.0);

    defer ConnectNPCs();
    return 1;
}

timer ConnectNPCs[5000]()
{
	printf("Connecting NPCs...");
	ConnectNPC("BusDriver", "bus_driver_airport");
}

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    if(vehicleid == g_AirPortBus && !ispassenger)
    {
        ClearAnimations(playerid);
    }
    return 1;
}

hook OnPlayerSpawn(playerid)
{
    // Bypassing if the player is a NPC
	if(IsPlayerNPC(playerid))
	{
		new npcname[MAX_PLAYER_NAME];
		GetPlayerName(playerid, npcname, sizeof(npcname));
		if(!strcmp(npcname, "BusDriver", true))
        {
			SetPlayerSkin(playerid, 253);
			PutPlayerInVehicle(playerid, g_AirPortBus, 0);
		}
		return 1;
	}
    return 1;
}
