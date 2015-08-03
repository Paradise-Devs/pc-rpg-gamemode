/*******************************************************************************
* FILENAME :        modules/visual/needs.pwn
*
* DESCRIPTION :
*       Create/Destroy and Show player needs GUI functions.
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

#include <YSI\y_hooks>

//--------------------------------------------------------------------

new	PlayerText:StatsText[7][MAX_PLAYERS],
	PlayerBar:StatsBar[5][MAX_PLAYERS];

//--------------------------------------------------------------------

ShowPlayerStatsHUD(playerid)
{
	if(!GetPVarInt(playerid, "isHudVisible"))
	{
		SetPVarInt(playerid, "isHudVisible", true);
		StatsText[0][playerid] = CreatePlayerTextDraw(playerid, 17.000000, 170.000000, "Stats");
		PlayerTextDrawBackgroundColor(playerid, StatsText[0][playerid], 255);
		PlayerTextDrawFont(playerid, StatsText[0][playerid], 0);
		PlayerTextDrawLetterSize(playerid, StatsText[0][playerid], 0.539999, 1.399999);
		PlayerTextDrawColor(playerid, StatsText[0][playerid], -1);
		PlayerTextDrawSetOutline(playerid, StatsText[0][playerid], 1);
		PlayerTextDrawSetProportional(playerid, StatsText[0][playerid], 1);
		PlayerTextDrawSetSelectable(playerid, StatsText[0][playerid], 0);

		StatsText[1][playerid] = CreatePlayerTextDraw(playerid, 13.000000, 178.000000, "_");
		PlayerTextDrawBackgroundColor(playerid, StatsText[1][playerid], 255);
		PlayerTextDrawFont(playerid, StatsText[1][playerid], 1);
		PlayerTextDrawLetterSize(playerid, StatsText[1][playerid], 2.539999, 7.599994);
		PlayerTextDrawColor(playerid, StatsText[1][playerid], 0);
		PlayerTextDrawSetOutline(playerid, StatsText[1][playerid], 0);
		PlayerTextDrawSetProportional(playerid, StatsText[1][playerid], 1);
		PlayerTextDrawSetShadow(playerid, StatsText[1][playerid], 1);
		PlayerTextDrawUseBox(playerid, StatsText[1][playerid], 1);
		PlayerTextDrawBoxColor(playerid, StatsText[1][playerid], 127);
		PlayerTextDrawTextSize(playerid, StatsText[1][playerid], 136.000000, 3.000000);
		PlayerTextDrawSetSelectable(playerid, StatsText[1][playerid], 0);

		StatsText[2][playerid] = CreatePlayerTextDraw(playerid, 16.000000, 190.000000, "Fome");
		PlayerTextDrawBackgroundColor(playerid, StatsText[2][playerid], 0);
		PlayerTextDrawFont(playerid, StatsText[2][playerid], 1);
		PlayerTextDrawLetterSize(playerid, StatsText[2][playerid], 0.320000, 0.899999);
		PlayerTextDrawColor(playerid, StatsText[2][playerid], -1);
		PlayerTextDrawSetOutline(playerid, StatsText[2][playerid], 0);
		PlayerTextDrawSetProportional(playerid, StatsText[2][playerid], 1);
		PlayerTextDrawSetShadow(playerid, StatsText[2][playerid], 1);
		PlayerTextDrawSetSelectable(playerid, StatsText[2][playerid], 0);

		StatsText[3][playerid] = CreatePlayerTextDraw(playerid, 17.000000, 200.000000, "Sede");
		PlayerTextDrawBackgroundColor(playerid, StatsText[3][playerid], 0);
		PlayerTextDrawFont(playerid, StatsText[3][playerid], 1);
		PlayerTextDrawLetterSize(playerid, StatsText[3][playerid], 0.320000, 0.899999);
		PlayerTextDrawColor(playerid, StatsText[3][playerid], -1);
		PlayerTextDrawSetOutline(playerid, StatsText[3][playerid], 0);
		PlayerTextDrawSetProportional(playerid, StatsText[3][playerid], 1);
		PlayerTextDrawSetShadow(playerid, StatsText[3][playerid], 1);
		PlayerTextDrawSetSelectable(playerid, StatsText[3][playerid], 0);

		StatsText[4][playerid] = CreatePlayerTextDraw(playerid, 17.000000, 210.000000, "Sono");
		PlayerTextDrawBackgroundColor(playerid, StatsText[4][playerid], 0);
		PlayerTextDrawFont(playerid, StatsText[4][playerid], 1);
		PlayerTextDrawLetterSize(playerid, StatsText[4][playerid], 0.320000, 0.899999);
		PlayerTextDrawColor(playerid, StatsText[4][playerid], -1);
		PlayerTextDrawSetOutline(playerid, StatsText[4][playerid], 0);
		PlayerTextDrawSetProportional(playerid, StatsText[4][playerid], 1);
		PlayerTextDrawSetShadow(playerid, StatsText[4][playerid], 1);
		PlayerTextDrawSetSelectable(playerid, StatsText[4][playerid], 0);

		StatsText[5][playerid] = CreatePlayerTextDraw(playerid, 17.000000, 220.000000, "Vicio");
		PlayerTextDrawBackgroundColor(playerid, StatsText[5][playerid], 0);
		PlayerTextDrawFont(playerid, StatsText[5][playerid], 1);
		PlayerTextDrawLetterSize(playerid, StatsText[5][playerid], 0.320000, 0.899999);
		PlayerTextDrawColor(playerid, StatsText[5][playerid], -1);
		PlayerTextDrawSetOutline(playerid, StatsText[5][playerid], 0);
		PlayerTextDrawSetProportional(playerid, StatsText[5][playerid], 1);
		PlayerTextDrawSetShadow(playerid, StatsText[5][playerid], 1);
		PlayerTextDrawSetSelectable(playerid, StatsText[5][playerid], 0);

		StatsText[6][playerid] = CreatePlayerTextDraw(playerid, 17.000000, 230.000000, "Pet");
		PlayerTextDrawBackgroundColor(playerid, StatsText[6][playerid], 0);
		PlayerTextDrawFont(playerid, StatsText[6][playerid], 1);
		PlayerTextDrawLetterSize(playerid, StatsText[6][playerid], 0.320000, 0.899999);
		PlayerTextDrawColor(playerid, StatsText[6][playerid], -1);
		PlayerTextDrawSetOutline(playerid, StatsText[6][playerid], 0);
		PlayerTextDrawSetProportional(playerid, StatsText[6][playerid], 1);
		PlayerTextDrawSetShadow(playerid, StatsText[6][playerid], 1);
		PlayerTextDrawSetSelectable(playerid, StatsText[6][playerid], 0);

		StatsBar[0][playerid] = CreatePlayerProgressBar(playerid, 73.00, 193.00, 55.50, 5.20, 0xD2D2D2FF, 100.0); // Fome
		StatsBar[1][playerid] = CreatePlayerProgressBar(playerid, 73.00, 203.00, 55.50, 5.20, 0xD2D2D2FF, 100.0); // Sede
		StatsBar[2][playerid] = CreatePlayerProgressBar(playerid, 73.00, 213.00, 55.50, 5.20, 0xD2D2D2FF, 100.0); // Sono
		StatsBar[3][playerid] = CreatePlayerProgressBar(playerid, 73.00, 223.00, 55.50, 5.20, 0xD2D2D2FF); // Vicio
		StatsBar[4][playerid] = CreatePlayerProgressBar(playerid, 73.00, 233.00, 55.50, 5.20, 0xD2D2D2FF); // Fome Pet

		SetPlayerProgressBarValue(playerid, StatsBar[0][playerid], GetPlayerHunger(playerid));
		SetPlayerProgressBarValue(playerid, StatsBar[1][playerid], GetPlayerThirst(playerid));
		SetPlayerProgressBarValue(playerid, StatsBar[2][playerid], GetPlayerSleep(playerid));
		SetPlayerProgressBarValue(playerid, StatsBar[3][playerid], GetPlayerAddiction(playerid));
		SetPlayerProgressBarValue(playerid, StatsBar[4][playerid], GetPlayerPetHunger(playerid));

		for (new i = 0; i < sizeof(StatsText); i++)
			PlayerTextDrawShow(playerid, StatsText[i][playerid]);

		for (new i = 0; i < sizeof(StatsBar); i++)
			ShowPlayerProgressBar(playerid, StatsBar[i][playerid]);
	}
	return 1;
}

//--------------------------------------------------------------------

stock HidePlayerStatsHUD(playerid)
{
	if(GetPVarInt(playerid, "isHudVisible"))
	{
		for (new i = 0; i < sizeof(StatsText); i++)
			PlayerTextDrawDestroy(playerid, StatsText[i][playerid]);

		for (new i = 0; i < sizeof(StatsBar); i++)
			DestroyPlayerProgressBar(playerid, StatsBar[i][playerid]);

		DeletePVar(playerid, "isHudVisible");
	}
	return 1;
}

//--------------------------------------------------------------------

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(IsPlayerLogged(playerid))
	{
		if(newkeys == KEY_NO)
			ShowPlayerStatsHUD(playerid);
		else if(oldkeys == KEY_NO)
			HidePlayerStatsHUD(playerid);
	}
	return 1;
}
