/*******************************************************************************
* FILENAME :        modules/anticheater/patches/connectionspoof.pwn
*
* DESCRIPTION :
*       Player Connection Spoof protection module
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2016.  All rights reserved.
*
*/

#include <YSI\y_hooks>

hook OnPlayerConnect(playerid)
{
	if(PlayerCheatInfo[playerid][PlayerSpoof_IsConnected])
	{
		SetPlayerName(playerid, PlayerCheatInfo[playerid][PlayerSpoof_PlayerName]);
		CallLocalFunction("OnPlayerCheat", "ii", playerid, CHEAT_PLAYERSPOOF);
		return 1;
	}
	else
	{
		GetPlayerName(playerid, PlayerCheatInfo[playerid][PlayerSpoof_PlayerName], MAX_PLAYER_NAME);
		PlayerCheatInfo[playerid][PlayerSpoof_IsConnected] = true;
	}
  	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	PlayerCheatInfo[playerid][PlayerSpoof_IsConnected] = false;
  	return 1;
}
