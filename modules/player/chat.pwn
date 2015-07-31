/*******************************************************************************
* FILENAME :        modules/player/chat.pwn
*
* DESCRIPTION :
*       Adds local chat to the server.
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

hook OnPlayerText(playerid, text[])
{
    if(!IsPlayerLogged(playerid))
    {
        SendClientMessage(playerid, COLOR_ERROR, "* Você não está logado.");
        return -1;
    }
    else if(GetPlayerHospitalTime(playerid) > 0)
    {
        SendClientMessage(playerid, COLOR_ERROR, "* Você está em coma.");
        return -1;
    }
    else if(GetPlayerHighestRank(playerid) >= PLAYER_RANK_BETATESTER && strfind(text, "@", true) == 0 && strlen(text) > 1)
	{
		strdel(text, 0, 1);
		new message[200];
		format(message, 200, "@ [{%06x}%s{ededed}] %s: {e3e3e3}%s", GetPlayerRankColor(playerid) >>> 8, GetPlayerRankName(playerid, true), GetPlayerNamef(playerid), text);
		SendAdminMessage(PLAYER_RANK_BETATESTER, 0xedededff, message);
		return -1;
	}

    new	Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    SetPlayerChatBubble(playerid, text, 0xFFFFFFFF, 20.0, 5000);

    foreach(new i: Player)
    {
        new	Float:dist = GetPlayerDistanceFromPoint(i, x, y, z);
        if(IsPlayerInVehicle(i, GetPlayerVehicleID(playerid)) || dist <= 5)
        {
            new message[172];
            format(message, 172, "%s diz: %s", GetPlayerNamef(playerid), text);
            SendClientMessage(i, 0xC6C6C6FF, message);
        }

        else if(dist > 5 && dist <= 10)
        {
            new message[172];
            format(message, 172, "%s diz: %s", GetPlayerNamef(playerid), text);
            SendClientMessage(i, 0xB6B6B6FF, message);
        }

        else if(dist > 10 && dist <= 20)
        {
            new message[172];
            format(message, 172, "%s diz: %s", GetPlayerNamef(playerid), text);
            SendClientMessage(i, 0xA3A3A3FF, message);
        }
        SendPetLocalMessage(playerid, text);
    }
    return -1;
}
