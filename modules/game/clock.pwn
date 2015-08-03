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

new gCurrentHour = 07;
new gCurrentMinute = 00;
new Text:gClockTD;
new bool:gplClockLoaded[MAX_PLAYERS];

//------------------------------------------------------------------------------

hook OnPlayerDisconnect(playerid, reason)
{
    gplClockLoaded[playerid] = false;
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerSpawn(playerid)
{
    if(!gplClockLoaded[playerid])
    {
        TextDrawShowForPlayer(playerid, gClockTD);
        gplClockLoaded[playerid] = true;
    }
    return 1;
}

//------------------------------------------------------------------------------

ShowPlayerClock(playerid)
{
    TextDrawShowForPlayer(playerid, gClockTD);
}

//------------------------------------------------------------------------------

HidePlayerClock(playerid)
{
    TextDrawHideForPlayer(playerid, gClockTD);
}

//------------------------------------------------------------------------------

hook OnGameModeInit()
{
    gClockTD = TextDrawCreate(605.0, 25.0, "00:00");
	TextDrawUseBox(gClockTD, 0);
	TextDrawFont(gClockTD, 3);
	TextDrawSetShadow(gClockTD, 0);
    TextDrawSetOutline(gClockTD, 2);
    TextDrawBackgroundColor(gClockTD, 0x000000FF);
    TextDrawColor(gClockTD, 0xfbfbfbff);
    TextDrawAlignment(gClockTD, 3);
	TextDrawLetterSize(gClockTD, 0.5, 1.5);
    return 1;
}

//------------------------------------------------------------------------------

task UpdateServerClock[5000]()
{
    gCurrentMinute++;
    if(gCurrentMinute > 59)
    {
        gCurrentHour++;
        gCurrentMinute = 0;
        if(gCurrentHour > 23)
            gCurrentHour = 0;
    }

    new sCT[12];
    format(sCT, sizeof(sCT), "%02d:%02d", gCurrentHour, gCurrentMinute);
    TextDrawSetString(gClockTD, sCT);

    foreach(new i: Player)
        SetPlayerTime(i, gCurrentHour, gCurrentMinute);
}
