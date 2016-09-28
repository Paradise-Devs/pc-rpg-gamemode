/*******************************************************************************
* FILENAME :        modules/anticheater/patches/npcspoof.pwn
*
* DESCRIPTION :
*       NPCSpoof protection module
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2016.  All rights reserved.
*
*/

#include <YSI\y_hooks>

//------------------------------------------------------------------------------



hook OnPlayerConnect(playerid)
{
    if(IsPlayerNPC(playerid))
	{
		new ip[16];
		GetPlayerIp(playerid, ip, sizeof(ip));
		if (!!strcmp(ip, "127.0.0.1"))
		{
			new name[MAX_PLAYER_NAME];
			format(name, sizeof(name), "%i", gettime());
			SetPlayerName(playerid, name);
			CallLocalFunction("OnPlayerCheat", "ii", playerid, CHEAT_NPCSPOOF);
			return 1;
		}
	}
    return 1;
}
