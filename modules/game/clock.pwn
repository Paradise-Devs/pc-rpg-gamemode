/*******************************************************************************
* FILENAME :        modules/game/clock.pwn
*
* DESCRIPTION :
*       Synchronize the clock to all the players.
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

static gCurrentHour = 07;
static gCurrentMinute = 00;

//------------------------------------------------------------------------------

hook OnPlayerConnect(playerid)
{
    SetPlayerTime(playerid, gCurrentHour, gCurrentMinute);
    TogglePlayerClock(playerid, true);
    return 1;
}

//------------------------------------------------------------------------------

task UpdateServerClock[60000]()
{
    gCurrentMinute++;
    if(gCurrentMinute > 59)
    {
        gCurrentHour++;
        gCurrentMinute = 0;
        if(gCurrentHour > 23)
            gCurrentHour = 0;
    }
}
