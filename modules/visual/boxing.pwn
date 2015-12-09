/* *************************************************************************** *
*  Description: boxing info visual module file.
*
*  Assignment: A script to show info about the boxing.
*
*           Copyright Paradise Devs 2015.  All rights reserved.
* *************************************************************************** */

#if defined _MODULE_vsboxinginfo
	#endinput
#endif
#define _MODULE_vsboxinginfo

#include <YSI\y_hooks>

static gPickupID;
static PlayerText:g_pt_boxinginfo[2][MAX_PLAYERS];

hook OnGameModeInit()
{
    gPickupID = CreateDynamicPickup(1239, 1, 761.2108, 5.5640, 1000.7095, -1, 5, -1, MAX_PICKUP_RANGE);
    return 1;
}

hook OnPlayerPickUpDynPickup(playerid, pickupid)
{
    if(pickupid == gPickupID)
    {
        ShowPlayerboxingInfo(playerid);
    }
}

ShowPlayerboxingInfo(playerid)
{
	if(!GetPVarInt(playerid, "isboxingInfoVisible"))
	{
		SetPVarInt(playerid, "isboxingInfoVisible", true);
		g_pt_boxinginfo[0][playerid] = CreatePlayerTextDraw(playerid, 134.000030, 171.159271, "usebox");
		PlayerTextDrawLetterSize(playerid, g_pt_boxinginfo[0][playerid], 0.000000, 5.276336);
		PlayerTextDrawTextSize(playerid, g_pt_boxinginfo[0][playerid], 23.666666, 0.000000);
		PlayerTextDrawAlignment(playerid, g_pt_boxinginfo[0][playerid], 1);
		PlayerTextDrawColor(playerid, g_pt_boxinginfo[0][playerid], 0);
		PlayerTextDrawUseBox(playerid, g_pt_boxinginfo[0][playerid], true);
		PlayerTextDrawBoxColor(playerid, g_pt_boxinginfo[0][playerid], 102);
		PlayerTextDrawSetShadow(playerid, g_pt_boxinginfo[0][playerid], 0);
		PlayerTextDrawSetOutline(playerid, g_pt_boxinginfo[0][playerid], 0);
		PlayerTextDrawFont(playerid, g_pt_boxinginfo[0][playerid], 0);

		g_pt_boxinginfo[1][playerid] = CreatePlayerTextDraw(playerid, 28.000001, 177.540725, ConvertToGameText("Você pode ~r~desafiar outros jogadores,~n~~w~através do comando~n~/desafiar"));
		PlayerTextDrawLetterSize(playerid, g_pt_boxinginfo[1][playerid], 0.160666, 0.778666);
		PlayerTextDrawAlignment(playerid, g_pt_boxinginfo[1][playerid], 1);
		PlayerTextDrawColor(playerid, g_pt_boxinginfo[1][playerid], -1);
		PlayerTextDrawSetShadow(playerid, g_pt_boxinginfo[1][playerid], 0);
		PlayerTextDrawSetOutline(playerid, g_pt_boxinginfo[1][playerid], 1);
		PlayerTextDrawBackgroundColor(playerid, g_pt_boxinginfo[1][playerid], 51);
		PlayerTextDrawFont(playerid, g_pt_boxinginfo[1][playerid], 2);
		PlayerTextDrawSetProportional(playerid, g_pt_boxinginfo[1][playerid], 1);

		for(new i = 0; i < sizeof(g_pt_boxinginfo); i++)
			PlayerTextDrawShow(playerid, g_pt_boxinginfo[i][playerid]);

		PlaySelectSound(playerid);
		defer HidePlayerboxingInfo(playerid);
	}
}

timer HidePlayerboxingInfo[5000](playerid)
{
	if(GetPVarInt(playerid, "isboxingInfoVisible"))
	{
		DeletePVar(playerid, "isboxingInfoVisible");
		for(new i = 0; i < sizeof(g_pt_boxinginfo); i++)
			PlayerTextDrawDestroy(playerid, g_pt_boxinginfo[i][playerid]);
	}
}
