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
* AUTHOR :    Larceny           START DATE :    25 Jul 15
*
*/

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

hook OnPlayerText(playerid, text[])
{
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
            SendMultiMessage(i, 0xC6C6C6FF, message);
        }

        else if(dist > 5 && dist <= 10)
        {
            new message[172];
            format(message, 172, "%s diz: %s", GetPlayerNamef(playerid), text);
            SendMultiMessage(i, 0xB6B6B6FF, message);
        }

        else if(dist > 10 && dist <= 20)
        {
            new message[172];
            format(message, 172, "%s diz: %s", GetPlayerNamef(playerid), text);
            SendMultiMessage(i, 0xA3A3A3FF, message);
        }
    }
    return -1;
}
