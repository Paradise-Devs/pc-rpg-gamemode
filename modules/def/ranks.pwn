/*******************************************************************************
* FILENAME :        modules/def/ranks.pwn
*
* DESCRIPTION :
*       Global constants of ranks.
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*/

//------------------------------------------------------------------------------

enum
{
    PLAYER_RANK_PLAYER,
    PLAYER_RANK_PARADISER,
    PLAYER_RANK_MODERATOR,
	PLAYER_RANK_SUPERVISOR,
	PLAYER_RANK_ADMIN,
	PLAYER_RANK_DEVELOPER
}

static gPlayerRanks[MAX_PLAYERS];
static gPlayerDonator[MAX_PLAYERS];

//------------------------------------------------------------------------------

stock GetPlayerRank(playerid)
{
    if(gPlayerRanks[playerid] == PLAYER_RANK_DEVELOPER)
        return PLAYER_RANK_DEVELOPER;
    else if(gPlayerRanks[playerid] == PLAYER_RANK_ADMIN)
        return PLAYER_RANK_ADMIN;
    else if(gPlayerRanks[playerid] == PLAYER_RANK_SUPERVISOR)
        return PLAYER_RANK_SUPERVISOR;
    else if(gPlayerRanks[playerid] == PLAYER_RANK_MODERATOR)
        return PLAYER_RANK_MODERATOR;
    else if(gPlayerRanks[playerid] == PLAYER_RANK_PARADISER)
        return PLAYER_RANK_PARADISER;
    else
        return PLAYER_RANK_PLAYER;
}

//------------------------------------------------------------------------------

stock GetPlayerRankColor(playerid)
{
    new rankColor = 0xFFFFFFFF;
    if(GetPlayerRank(playerid) == PLAYER_RANK_DEVELOPER)
        rankColor = COLOR_RANK_DEVELOPER;
    else if(GetPlayerRank(playerid) == PLAYER_RANK_ADMIN)
        rankColor = COLOR_RANK_ADMIN;
    else if(GetPlayerRank(playerid) == PLAYER_RANK_SUPERVISOR)
        rankColor = COLOR_RANK_SUPERVISOR;
    else if(GetPlayerRank(playerid) == PLAYER_RANK_MODERATOR)
        rankColor = COLOR_RANK_MODERATOR;
    else if(GetPlayerRank(playerid) == PLAYER_RANK_PARADISER)
        rankColor = COLOR_RANK_PARADISER;
    return rankColor;
}

//------------------------------------------------------------------------------

stock GetPlayerRankName(playerid, bool:capitalize = false)
{
    new rankName[12];
    if(GetPlayerRank(playerid) == PLAYER_RANK_DEVELOPER)
        rankName = "developer";
    else if(GetPlayerRank(playerid) == PLAYER_RANK_ADMIN)
        rankName = "admin";
    else if(GetPlayerRank(playerid) == PLAYER_RANK_SUPERVISOR)
        rankName = "supervisor";
    else if(GetPlayerRank(playerid) == PLAYER_RANK_MODERATOR)
        rankName = "moderador";
    else if(GetPlayerRank(playerid) == PLAYER_RANK_PARADISER)
        rankName = "paradiser";
    else
        rankName = "comum";
    if(capitalize == true)
        rankName[0] = toupper(rankName[0]);
    return rankName;
}

//------------------------------------------------------------------------------

stock SetPlayerRank(playerid, rank)
{
    gPlayerRanks[playerid] = rank;
}

//------------------------------------------------------------------------------

IsPlayerDonator(playerid)
{
    return gPlayerDonator[playerid];
}
