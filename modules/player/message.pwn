/*******************************************************************************
* FILENAME :        modules/player/message.pwn
*
* DESCRIPTION :
*       Handles player functions related to messages.
*
* NOTES :
*       This file should only contain information about messages.
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
* AUTHOR :    Larceny           START DATE :    25 Jul 15
*
*/

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

SendActionMessage(playerid, Float:radius, action[])
{
	new	Float:fDist[3];
	GetPlayerPos(playerid, fDist[0], fDist[1], fDist[2]);

	foreach(new i: Player)
	{
		if(!IsPlayerLogged(i))
			continue;

		if(GetPlayerDistanceFromPoint(i, fDist[0], fDist[1], fDist[2]) <= radius && GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(playerid))
		{
			new	message[128];
			format(message, sizeof(message), "* %s (( %s ))", action, GetPlayerNamef(playerid));
			SendClientMessage(i, COLOR_ACTION, message);
		}
	}
}

//------------------------------------------------------------------------------

SendClientLocalMessage(playerid, color, Float:radius, string[])
{
	SetPlayerChatBubble(playerid, string, color, radius, 5000);
	new Float:fDist[3];
	GetPlayerPos(playerid, fDist[0], fDist[1], fDist[2]);
	foreach(new i: Player)
	{
		if(GetPlayerDistanceFromPoint(i, fDist[0], fDist[1], fDist[2]) <= radius)
		{
			SendClientMessage(i, color, string);
		}
	}
}

//------------------------------------------------------------------------------

SendClientActionMessage(playerid, Float:radius, action[])
{
	new	Float:fDist[3];
	GetPlayerPos(playerid, fDist[0], fDist[1], fDist[2]);

	foreach(new i: Player)
	{
		if(!IsPlayerLogged(i))
			continue;

		if(GetPlayerDistanceFromPoint(i, fDist[0], fDist[1], fDist[2]) <= radius && GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(playerid))
		{
			new	message[128];
			format(message, sizeof(message), "* %s %s", GetPlayerNamef(playerid), action);
			SendClientMessage(i, COLOR_ACTION, message);
		}
	}
}
