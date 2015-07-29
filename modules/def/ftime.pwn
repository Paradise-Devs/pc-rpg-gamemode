/*******************************************************************************
* FILENAME :        modules/def/ftime.pwn
*
* DESCRIPTION :
*       Global constants and functions to check if the player is doing something
*       for the first time.
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*/

//------------------------------------------------------------------------------

#include <YSI\y_hooks>

// Maximum 32 values per variable
enum FIRST_TIME:(<<= 1)
{
	FIRST_TIME_DRIVING_SCHOOL = 1,
	FIRST_TIME_CITY_HALL
}
static FIRST_TIME:gplFirstTime[MAX_PLAYERS];

//------------------------------------------------------------------------------

SetPlayerFirstTime(playerid, FIRST_TIME:id, bool:set)
{
    switch(id)
    {
        case FIRST_TIME_DRIVING_SCHOOL:
        {
            if(set)
                gplFirstTime[playerid] |= FIRST_TIME_DRIVING_SCHOOL;
            else
                gplFirstTime[playerid] &= ~FIRST_TIME_DRIVING_SCHOOL;
        }
		case FIRST_TIME_CITY_HALL:
		{
			if(set)
                gplFirstTime[playerid] |= FIRST_TIME_CITY_HALL;
            else
                gplFirstTime[playerid] &= ~FIRST_TIME_CITY_HALL;
		}
    }
}

//------------------------------------------------------------------------------

bool:GetPlayerFirstTime(playerid, FIRST_TIME:id)
{
    if(gplFirstTime[playerid] & id)
        return true;
    return false;
}

//------------------------------------------------------------------------------

GetPlayerFirstTimeVar(playerid)
    return _:gplFirstTime[playerid];

//------------------------------------------------------------------------------

SetPlayerFirstTimeVar(playerid, val)
    gplFirstTime[playerid] = FIRST_TIME:val;

//------------------------------------------------------------------------------

hook OnPlayerConnect(playerid)
{
    gplFirstTime[playerid] = FIRST_TIME:0;
    return 1;
}
