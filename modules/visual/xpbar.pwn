/*******************************************************************************
* FILENAME :        modules/visual/xpbar.pwn
*
* DESCRIPTION :
*       Adds XP bars like mmo
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

//------------------------------------------------------------------------------

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

static PlayerText:exp_bar_txd[MAX_PLAYERS][7];

//------------------------------------------------------------------------------


#define bar_percent(%1,%2,%3,%4) ((%1 - 6.0) + ((((%1 + 6.0 + %2 - 2.0) - %1) / %3) * %4))
//bar_percent(x, width, max, value)

stock SetPlayerTextBarValue(playerid, PlayerText:playertextid, Float:bar_x, Float:bar_width, Float:bar_max, Float:value)
{
    if(IsPlayerNPC(playerid)) return 0;

    if(bar_percent(bar_x, bar_width, bar_max, value) >= bar_x + bar_width)
        PlayerTextDrawTextSize(playerid, playertextid, bar_x + bar_width, -1.0 );

    else if(bar_percent(bar_x,bar_width, bar_max, value) <= bar_x)
        PlayerTextDrawTextSize(playerid, playertextid, bar_x, - 1.0);

    else PlayerTextDrawTextSize(playerid, playertextid, bar_percent(bar_x, bar_width, bar_max, value), -1.0 );

    PlayerTextDrawShow(playerid, playertextid);
    return 0;
}


hook OnPlayerConnect(playerid)
{
	exp_bar_txd[playerid][0] = CreatePlayerTextDraw(playerid,493.000000, 20.000000, "_");
	PlayerTextDrawBackgroundColor(playerid,exp_bar_txd[playerid][0], 255);
	PlayerTextDrawFont(playerid,exp_bar_txd[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid,exp_bar_txd[playerid][0], 0.500000, -0.100000);
	PlayerTextDrawColor(playerid,exp_bar_txd[playerid][0], -1);
	PlayerTextDrawSetOutline(playerid,exp_bar_txd[playerid][0], 0);
	PlayerTextDrawSetProportional(playerid,exp_bar_txd[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid,exp_bar_txd[playerid][0], 1);
	PlayerTextDrawUseBox(playerid,exp_bar_txd[playerid][0], 1);
	PlayerTextDrawBoxColor(playerid,exp_bar_txd[playerid][0], 255);
	PlayerTextDrawTextSize(playerid,exp_bar_txd[playerid][0], 624.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid,exp_bar_txd[playerid][0], 0);

	exp_bar_txd[playerid][1] = CreatePlayerTextDraw(playerid,494.000000, 21.000000, "_");
	PlayerTextDrawBackgroundColor(playerid,exp_bar_txd[playerid][1], 255);
	PlayerTextDrawFont(playerid,exp_bar_txd[playerid][1], 1);
	PlayerTextDrawLetterSize(playerid,exp_bar_txd[playerid][1], 0.479999, -0.300000);
	PlayerTextDrawColor(playerid,exp_bar_txd[playerid][1], -2686721);
	PlayerTextDrawSetOutline(playerid,exp_bar_txd[playerid][1], 0);
	PlayerTextDrawSetProportional(playerid,exp_bar_txd[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid,exp_bar_txd[playerid][1], 1);
	PlayerTextDrawUseBox(playerid,exp_bar_txd[playerid][1], 1);
	PlayerTextDrawBoxColor(playerid,exp_bar_txd[playerid][1], -2686721);
	PlayerTextDrawTextSize(playerid,exp_bar_txd[playerid][1], 623.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid,exp_bar_txd[playerid][1], 0);

	exp_bar_txd[playerid][2] = CreatePlayerTextDraw(playerid,544.000000, 14.000000, "HUD:radar_mafiaCasino");
	PlayerTextDrawBackgroundColor(playerid,exp_bar_txd[playerid][2], 255);
	PlayerTextDrawFont(playerid,exp_bar_txd[playerid][2], 4);
	PlayerTextDrawLetterSize(playerid,exp_bar_txd[playerid][2], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid,exp_bar_txd[playerid][2], -1);
	PlayerTextDrawSetOutline(playerid,exp_bar_txd[playerid][2], 0);
	PlayerTextDrawSetProportional(playerid,exp_bar_txd[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid,exp_bar_txd[playerid][2], 1);
	PlayerTextDrawUseBox(playerid,exp_bar_txd[playerid][2], 1);
	PlayerTextDrawBoxColor(playerid,exp_bar_txd[playerid][2], 255);
	PlayerTextDrawTextSize(playerid,exp_bar_txd[playerid][2], 10.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,exp_bar_txd[playerid][2], 0);

	exp_bar_txd[playerid][3] = CreatePlayerTextDraw(playerid,561.000000, 17.000000, "HUD:radar_mafiaCasino");
	PlayerTextDrawBackgroundColor(playerid,exp_bar_txd[playerid][3], 255);
	PlayerTextDrawFont(playerid,exp_bar_txd[playerid][3], 4);
	PlayerTextDrawLetterSize(playerid,exp_bar_txd[playerid][3], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid,exp_bar_txd[playerid][3], -1);
	PlayerTextDrawSetOutline(playerid,exp_bar_txd[playerid][3], 0);
	PlayerTextDrawSetProportional(playerid,exp_bar_txd[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid,exp_bar_txd[playerid][3], 1);
	PlayerTextDrawUseBox(playerid,exp_bar_txd[playerid][3], 1);
	PlayerTextDrawBoxColor(playerid,exp_bar_txd[playerid][3], 255);
	PlayerTextDrawTextSize(playerid,exp_bar_txd[playerid][3], -10.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,exp_bar_txd[playerid][3], 0);

	exp_bar_txd[playerid][4] = CreatePlayerTextDraw(playerid,558.000000, 14.000000, "HUD:radar_mafiaCasino");
	PlayerTextDrawBackgroundColor(playerid,exp_bar_txd[playerid][4], 255);
	PlayerTextDrawFont(playerid,exp_bar_txd[playerid][4], 4);
	PlayerTextDrawLetterSize(playerid,exp_bar_txd[playerid][4], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid,exp_bar_txd[playerid][4], -1);
	PlayerTextDrawSetOutline(playerid,exp_bar_txd[playerid][4], 0);
	PlayerTextDrawSetProportional(playerid,exp_bar_txd[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid,exp_bar_txd[playerid][4], 1);
	PlayerTextDrawUseBox(playerid,exp_bar_txd[playerid][4], 1);
	PlayerTextDrawBoxColor(playerid,exp_bar_txd[playerid][4], 255);
	PlayerTextDrawTextSize(playerid,exp_bar_txd[playerid][4], 10.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,exp_bar_txd[playerid][4], 0);

	exp_bar_txd[playerid][5] = CreatePlayerTextDraw(playerid,547.000000, 2.000000, "NIVEL");
	PlayerTextDrawBackgroundColor(playerid,exp_bar_txd[playerid][5], 255);
	PlayerTextDrawFont(playerid,exp_bar_txd[playerid][5], 1);
	PlayerTextDrawLetterSize(playerid,exp_bar_txd[playerid][5], 0.209999, 0.799998);
	PlayerTextDrawColor(playerid,exp_bar_txd[playerid][5], -1);
	PlayerTextDrawSetOutline(playerid,exp_bar_txd[playerid][5], 1);
	PlayerTextDrawSetProportional(playerid,exp_bar_txd[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid,exp_bar_txd[playerid][5], 0);

	exp_bar_txd[playerid][6] = CreatePlayerTextDraw(playerid,556.000000, 8.000000, "1");
	PlayerTextDrawAlignment(playerid,exp_bar_txd[playerid][6], 2);
	PlayerTextDrawBackgroundColor(playerid,exp_bar_txd[playerid][6], 255);
	PlayerTextDrawFont(playerid,exp_bar_txd[playerid][6], 2);
	PlayerTextDrawLetterSize(playerid,exp_bar_txd[playerid][6], 0.259999, 1.000000);
	PlayerTextDrawColor(playerid,exp_bar_txd[playerid][6], -2686721);
	PlayerTextDrawSetOutline(playerid,exp_bar_txd[playerid][6], 1);
	PlayerTextDrawSetProportional(playerid,exp_bar_txd[playerid][6], 1);
	PlayerTextDrawSetSelectable(playerid,exp_bar_txd[playerid][6], 0);
    return 1;
}

//------------------------------------------------------------------------------

ShowPlayerXPBar(playerid)
{
	for(new t; t < 6; t++)
		PlayerTextDrawShow(playerid, exp_bar_txd[playerid][t]);
	return 1;
}

stock HidePlayerXPBar(playerid)
{
	for(new t; t < 6; t++)
		PlayerTextDrawHide(playerid, exp_bar_txd[playerid][t]);
	return 1;
}

UpdatePlayerBar(playerid)
{
    SetPlayerTextBarValue(playerid, exp_bar_txd[playerid][1], 494.0, 129.0, GetPlayerRequiredXP(playerid), GetPlayerXP(playerid));
    new str[32];
    format(str, 32, "%d", GetPlayerLevel(playerid));
    PlayerTextDrawSetString(playerid, exp_bar_txd[playerid][6], str);
    PlayerTextDrawShow(playerid, exp_bar_txd[playerid][6]);
    return 1;
}
