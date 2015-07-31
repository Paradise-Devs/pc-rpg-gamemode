/*******************************************************************************
* FILENAME :        modules/admin/def.pwn
*
* DESCRIPTION :
*       Adds messages functions.
*
* NOTES :
*       This file should only contain message functions.
*
* FUNCTION LIST :
*			SendClientMessagef
*			SendAdminMessage
*			SendActionMessage
*			SendClientActionMessage
*			SendClientLocalMessage
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

//------------------------------------------------------------------------------

SendClientMessagef(playerid, color, const message[], va_args<>)
{
   new string[145];
   va_format(string, sizeof(string), message, va_start<3>);
   return SendClientMessage(playerid, color, string);
}

//------------------------------------------------------------------------------

SendAdminMessage(PLAYER_RANK:rank, color, const message[], va_args<>)
{
	if(numargs() > 3)
	{
		new string[145];
		va_format(string, sizeof(string), message, va_start<3>);
		foreach(new i: Player)
		{
			if(GetPlayerHighestRank(i) < rank || !IsPlayerLogged(i))
	            continue;

	        SendClientMessage(i, color, string);
		}
	}
	else
	{
		foreach(new i: Player)
		{
			if(GetPlayerHighestRank(i) < rank || !IsPlayerLogged(i))
	            continue;

	        SendClientMessage(i, color, message);
		}
	}
	return 1;
}

//------------------------------------------------------------------------------

SendActionMessage(playerid, Float:radius, action[])
{
	new	Float:fDist[3], message[145];
	GetPlayerPos(playerid, fDist[0], fDist[1], fDist[2]);
	format(message, sizeof(message), "* %s (( %s ))", action, GetPlayerNamef(playerid));
	foreach(new i: Player)
	{
		if(GetPlayerDistanceFromPoint(i, fDist[0], fDist[1], fDist[2]) <= radius && GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(playerid))
		{
			SendClientMessage(i, COLOR_ACTION, message);
		}
	}
}

//------------------------------------------------------------------------------

SendClientLocalMessage(playerid, color, Float:radius, string[])
{
	new Float:fDist[3];
	GetPlayerPos(playerid, fDist[0], fDist[1], fDist[2]);
	SetPlayerChatBubble(playerid, string, color, radius, 5000);
	foreach(new i: Player)
	{
		if(GetPlayerDistanceFromPoint(i, fDist[0], fDist[1], fDist[2]) <= radius && GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(playerid))
		{
			SendClientMessage(i, color, string);
		}
	}
}

//------------------------------------------------------------------------------

SendClientActionMessage(playerid, Float:radius, action[])
{
	new	Float:fDist[3], message[145];
	GetPlayerPos(playerid, fDist[0], fDist[1], fDist[2]);
	format(message, sizeof(message), "* %s %s", GetPlayerNamef(playerid), action);
	foreach(new i: Player)
	{
		if(GetPlayerDistanceFromPoint(i, fDist[0], fDist[1], fDist[2]) <= radius && GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(playerid))
		{
			SendClientMessage(i, COLOR_ACTION, message);
		}
	}
}
