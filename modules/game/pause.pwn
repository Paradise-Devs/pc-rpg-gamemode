/*******************************************************************************
* FILENAME :        modules/game/pause.pwn
*
* DESCRIPTION :
*       Adds functions to detect if the player is paused.
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

static gPlayerTickCount[MAX_PLAYERS];

//------------------------------------------------------------------------------

hook OnPlayerUpdate(playerid)
{
    gPlayerTickCount[playerid] = GetTickCount();
    return 1;
}

//------------------------------------------------------------------------------

IsPlayerPaused(playerid)
    return ((gPlayerTickCount[playerid] + 3000) < GetTickCount());
