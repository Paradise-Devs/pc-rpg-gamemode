/* *************************************************************************** *
*  Description: Bus info visual module file.
*
*  Assignment: A script to show info about the bus.
*
*           Copyright Paradise Devs 2015.  All rights reserved.
* *************************************************************************** */

#if defined _MODULE_vsbusinfo
	#endinput
#endif
#define _MODULE_vsbusinfo

#include <YSI\y_hooks>

static gPickupID;
static PlayerText:g_pt_businfo[2][MAX_PLAYERS];

hook OnGameModeInit()
{
    gPickupID = CreateDynamicPickup(1239, 1, 1439.2063, -2281.7297, 13.5469, 0, 0, -1, MAX_PICKUP_RANGE);
    return 1;
}

hook OnPlayerPickUpDynPickup(playerid, pickupid)
{
    if(pickupid == gPickupID)
    {
        ShowPlayerBusInfo(playerid);
    }
}

ShowPlayerBusInfo(playerid)
{
	if(!GetPVarInt(playerid, "isBusInfoVisible"))
	{
		SetPVarInt(playerid, "isBusInfoVisible", true);
		g_pt_businfo[0][playerid] = CreatePlayerTextDraw(playerid, 134.000030, 171.159271, "usebox");
		PlayerTextDrawLetterSize(playerid, g_pt_businfo[0][playerid], 0.000000, 5.276336);
		PlayerTextDrawTextSize(playerid, g_pt_businfo[0][playerid], 23.666666, 0.000000);
		PlayerTextDrawAlignment(playerid, g_pt_businfo[0][playerid], 1);
		PlayerTextDrawColor(playerid, g_pt_businfo[0][playerid], 0);
		PlayerTextDrawUseBox(playerid, g_pt_businfo[0][playerid], true);
		PlayerTextDrawBoxColor(playerid, g_pt_businfo[0][playerid], 102);
		PlayerTextDrawSetShadow(playerid, g_pt_businfo[0][playerid], 0);
		PlayerTextDrawSetOutline(playerid, g_pt_businfo[0][playerid], 0);
		PlayerTextDrawFont(playerid, g_pt_businfo[0][playerid], 0);

		g_pt_businfo[1][playerid] = CreatePlayerTextDraw(playerid, 28.000001, 177.540725, "Aproximadamente, a cada~n~~r~1~w~ minuto um onibus vira~n~para buscar os jogadores~n~~n~aguarde...");
		PlayerTextDrawLetterSize(playerid, g_pt_businfo[1][playerid], 0.160666, 0.778666);
		PlayerTextDrawAlignment(playerid, g_pt_businfo[1][playerid], 1);
		PlayerTextDrawColor(playerid, g_pt_businfo[1][playerid], -1);
		PlayerTextDrawSetShadow(playerid, g_pt_businfo[1][playerid], 0);
		PlayerTextDrawSetOutline(playerid, g_pt_businfo[1][playerid], 1);
		PlayerTextDrawBackgroundColor(playerid, g_pt_businfo[1][playerid], 51);
		PlayerTextDrawFont(playerid, g_pt_businfo[1][playerid], 2);
		PlayerTextDrawSetProportional(playerid, g_pt_businfo[1][playerid], 1);

		for(new i = 0; i < sizeof(g_pt_businfo); i++)
			PlayerTextDrawShow(playerid, g_pt_businfo[i][playerid]);

		PlaySelectSound(playerid);
		defer HidePlayerBusInfo(playerid);
	}
}

timer HidePlayerBusInfo[5000](playerid)
{
	if(GetPVarInt(playerid, "isBusInfoVisible"))
	{
		DeletePVar(playerid, "isBusInfoVisible");
		for(new i = 0; i < sizeof(g_pt_businfo); i++)
			PlayerTextDrawDestroy(playerid, g_pt_businfo[i][playerid]);
	}
}
