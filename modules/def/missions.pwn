/*******************************************************************************
* FILENAME :        modules/def/missions.pwn
*
* DESCRIPTION :
*       Global constants of missions.
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*/

//------------------------------------------------------------------------------

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

enum Mission (+=1)
{
    INVALID_MISSION_ID,
    MISSION_GTA = 1,
    MISSION_COLONEL
}
static Mission:gplCurrentMission[MAX_PLAYERS];

//------------------------------------------------------------------------------

hook OnPlayerDisconnect(playerid, reason)
{
    gplCurrentMission[playerid] = INVALID_MISSION_ID;
    return 1;
}

//------------------------------------------------------------------------------

stock SetPlayerMission(playerid, Mission:id)
    gplCurrentMission[playerid] = id;

//------------------------------------------------------------------------------

stock bool:IsPlayerInMission(playerid)
{
    if(gplCurrentMission[playerid])
        return true;
    return false;
}

//------------------------------------------------------------------------------

stock Mission:GetPlayerMission(playerid)
    return gplCurrentMission[playerid];
