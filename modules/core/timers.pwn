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
	if(!IsPlayerLogged(playerid))
		return 1;

    if(GetPVarInt(playerid, "PickupDelay") > 0)
        SetPVarInt(playerid, "PickupDelay", GetPVarInt(playerid, "PickupDelay") - 1);

	// If the player is seeing /stats textdraw, update time played text color
	if(GetPVarInt(playerid, "isDataHudVisible"))
	{
		new stats_color[12] = "~b~~h~";
		if(GetPlayerStatsColor(playerid) == PLAYER_STATS_COLOR_YELLOW)
			format(stats_color, sizeof(stats_color), "~y~");
		else if(GetPlayerStatsColor(playerid) == PLAYER_STATS_COLOR_GREEN)
			format(stats_color, sizeof(stats_color), "~g~");
		else if(GetPlayerStatsColor(playerid) == PLAYER_STATS_COLOR_RED)
			format(stats_color, sizeof(stats_color), "~r~");
		else if(GetPlayerStatsColor(playerid) == PLAYER_STATS_COLOR_PURPLE)
			format(stats_color, sizeof(stats_color), "~p~");

		new time_played_str[40];
		format(time_played_str, sizeof(time_played_str), "Tempo Jogado: %s%s", stats_color, GetPlayerPlayedTimeStamp(playerid));
		PlayerTextDrawSetString(playerid, gpt_data_hud[24][playerid], time_played_str);
	}

	if(GetPlayerMoney(playerid) != GetPlayerCash(playerid))
	{
		if(GetPlayerCash(playerid) > GetPlayerMoney(playerid) && GetPlayerCash(playerid) < (GetPlayerMoney(playerid) + 500))
			SetPlayerCash(playerid, GetPlayerMoney(playerid));
		else
		{
			ResetPlayerMoney(playerid);
			GivePlayerMoney(playerid, GetPlayerCash(playerid));
		}
	}

	SetPlayerPlayedTime(playerid, GetPlayerPlayedTime(playerid) + 1);
	UpdatePlayerGPS(playerid);
    return 1;
}
