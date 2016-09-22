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

new gCurrentHour = 05;
new gCurrentMinute = 00;
new Text:gClockTD;
new bool:gplClockLoaded[MAX_PLAYERS];

forward OnLoadClock();

//------------------------------------------------------------------------------

hook OnPlayerDisconnect(playerid, reason)
{
    gplClockLoaded[playerid] = false;
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerSpawn(playerid)
{
    if(IsPlayerNPC(playerid))
        return 1;

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
    mysql_tquery(mysql, "SELECT * FROM `clock`", "OnLoadClock");

    gClockTD = TextDrawCreate(552.000000, 26.000000, "05:00");
    TextDrawBackgroundColor(gClockTD, 255);
    TextDrawFont(gClockTD, 3);
    TextDrawLetterSize(gClockTD, 0.4, 1.0);
    TextDrawColor(gClockTD, 0xc3c3c3ff);
    TextDrawBoxColor(gClockTD, 0x000000ff);
    TextDrawSetOutline(gClockTD, 2);
    TextDrawSetShadow(gClockTD, 0);
    TextDrawSetProportional(gClockTD, 1);
    return 1;
}

//------------------------------------------------------------------------------

GetServerClock(&hour, &minute)
{
    hour = gCurrentHour;
    minute = gCurrentMinute;
}

//------------------------------------------------------------------------------

/*
	OnLoadClock
		Called when the server loads the clock from database
*/
public OnLoadClock()
{
	new rows, fields;
	cache_get_data(rows, fields, mysql);
	if(rows)
	{
		gCurrentHour      = cache_get_field_content_int(0, "hour");
		gCurrentMinute    = cache_get_field_content_int(0, "minute");

        new sCT[12];
        format(sCT, sizeof(sCT), "%02d:%02d", gCurrentHour, gCurrentMinute);
        TextDrawSetString(gClockTD, sCT);
	}
	else
	{
		new query[64];
		mysql_format(mysql, query, sizeof(query), "INSERT INTO `clock` (`hour`, `minute`) VALUES (%d, %d)", gCurrentHour, gCurrentMinute);
		mysql_tquery(mysql, query);
	}
}

/*
	SaveClock
		Called when the server saves the clock to database
*/
SaveClock()
{
	new query[120];
	mysql_format(mysql, query, sizeof(query), "UPDATE `clock` SET `hour`=%d, `minute`=%d WHERE `ID`=1", gCurrentHour, gCurrentMinute);
	mysql_tquery(mysql, query);
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
