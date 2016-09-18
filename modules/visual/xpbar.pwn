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

static PlayerText:xpBar[MAX_PLAYERS];

//------------------------------------------------------------------------------


hook OnPlayerConnect(playerid)
{
	xpBar[playerid] = CreatePlayerProgressBar(playerid, 0.00, 442.00, 644.00, 5.50, 16777215, 100.0, BAR_DIRECTION_RIGHT);
    return 1;
}

//------------------------------------------------------------------------------

ShowPlayerXPBar(playerid)
{
    UpdatePlayerBar(playerid);
	ShowPlayerProgressBar(playerid, xpBar[playerid]);
	PlayerTextDrawShow(playerid, xp_bar_val[playerid]);
}

HidePlayerXPBar(playerid)
{
	HidePlayerProgressBar(playerid, xpBar[playerid]);
	PlayerTextDrawHide(playerid, xp_bar_val[playerid]);
}

UpdatePlayerBar(playerid)
{
    SetPlayerProgressBarValue(playerid, xpBar[playerid], GetPlayerXP(playerid));
	SetPlayerProgressBarMaxValue(playerid, xpBar[playerid], GetPlayerRequiredXP(playerid));

	new xp_val[32];
	format(xp_val, sizeof(xp_val), "%i / %i", GetPlayerXP(playerid), GetPlayerRequiredXP(playerid));
	PlayerTextDrawSetString(playerid, xp_bar_val[playerid], xp_val);
}
