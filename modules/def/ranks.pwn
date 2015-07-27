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

// Maximum 32 ranks
enum PLAYER_RANK (<<=1)
{
    PLAYER_RANK_PLAYER,
    PLAYER_RANK_DONATOR = 1,
    PLAYER_RANK_BACKUP,
    PLAYER_RANK_DESIGNER,
    PLAYER_RANK_BETATESTER,
    PLAYER_RANK_MODERATOR,
	PLAYER_RANK_SUPERVISOR,
	PLAYER_RANK_ADMIN,
	PLAYER_RANK_DEVELOPER
}

static PLAYER_RANK:gPlayerRanks[MAX_PLAYERS];
//------------------------------------------------------------------------------

stock PLAYER_RANK:GetPlayerHighestRank(playerid)
{
    if(gPlayerRanks[playerid] & PLAYER_RANK_DEVELOPER)
        return PLAYER_RANK_DEVELOPER;
    else if(gPlayerRanks[playerid] & PLAYER_RANK_ADMIN)
        return PLAYER_RANK_ADMIN;
    else if(gPlayerRanks[playerid] & PLAYER_RANK_SUPERVISOR)
        return PLAYER_RANK_SUPERVISOR;
    else if(gPlayerRanks[playerid] & PLAYER_RANK_MODERATOR)
        return PLAYER_RANK_MODERATOR;
    else if(gPlayerRanks[playerid] & PLAYER_RANK_BETATESTER)
        return PLAYER_RANK_BETATESTER;
    else if(gPlayerRanks[playerid] & PLAYER_RANK_DESIGNER)
        return PLAYER_RANK_DESIGNER;
    else if(gPlayerRanks[playerid] & PLAYER_RANK_BACKUP)
        return PLAYER_RANK_BACKUP;
    else if(gPlayerRanks[playerid] & PLAYER_RANK_DONATOR)
        return PLAYER_RANK_DONATOR;
    else
        return PLAYER_RANK_PLAYER;
}

//------------------------------------------------------------------------------

stock GetPlayerRankColor(playerid)
{
    new rankColor = 0xFFFFFFFF;
    if(GetPlayerHighestRank(playerid) == PLAYER_RANK_DEVELOPER)
        rankColor = 0x35a700ff;
    else if(GetPlayerHighestRank(playerid) == PLAYER_RANK_ADMIN)
        rankColor = 0x00AEFFFF;
    else if(GetPlayerHighestRank(playerid) == PLAYER_RANK_SUPERVISOR)
        rankColor = 0x009CE5FF;
    else if(GetPlayerHighestRank(playerid) == PLAYER_RANK_MODERATOR)
        rankColor = 0x008BCCFF;
    else if(GetPlayerHighestRank(playerid) == PLAYER_RANK_BETATESTER)
        rankColor = 0x992A2AFF;
    else if(GetPlayerHighestRank(playerid) == PLAYER_RANK_DESIGNER)
        rankColor = 0xe48200ff;
    else if(GetPlayerHighestRank(playerid) == PLAYER_RANK_BACKUP)
        rankColor = 0xCE8500FF;
    return rankColor;
}

//------------------------------------------------------------------------------

stock GetPlayerRankName(playerid, bool:capitalize = false)
{
    new rankName[12];
    if(GetPlayerHighestRank(playerid) == PLAYER_RANK_DEVELOPER)
        rankName = "developer";
    else if(GetPlayerHighestRank(playerid) == PLAYER_RANK_ADMIN)
        rankName = "admin";
    else if(GetPlayerHighestRank(playerid) == PLAYER_RANK_SUPERVISOR)
        rankName = "supervisor";
    else if(GetPlayerHighestRank(playerid) == PLAYER_RANK_MODERATOR)
        rankName = "moderador";
    else if(GetPlayerHighestRank(playerid) == PLAYER_RANK_BETATESTER)
        rankName = "beta tester";
    else if(GetPlayerHighestRank(playerid) == PLAYER_RANK_DESIGNER)
        rankName = "designer";
    else if(GetPlayerHighestRank(playerid) == PLAYER_RANK_BACKUP)
        rankName = "backup";
    else if(GetPlayerHighestRank(playerid) == PLAYER_RANK_DONATOR)
        rankName = "donator";
    else
        rankName = "comum";
    if(capitalize == true)
        rankName[0] = toupper(rankName[0]);
    if(capitalize == true && GetPlayerHighestRank(playerid) == PLAYER_RANK_BETATESTER)
        rankName[5] = toupper(rankName[5]);
    return rankName;
}

//------------------------------------------------------------------------------

stock bool:IsPlayerDonator(playerid)
{
    if(gPlayerRanks[playerid] & PLAYER_RANK_DONATOR)
        return true;
    return false;
}

//------------------------------------------------------------------------------

stock SetPlayerRankVar(playerid, val)
    gPlayerRanks[playerid] = PLAYER_RANK:val;

//------------------------------------------------------------------------------

stock GetPlayerRankVar(playerid)
    return _:gPlayerRanks[playerid];

//------------------------------------------------------------------------------

stock SetPlayerRank(PLAYER_RANK:rank, playerid, bool:set)
{
    switch(rank)
    {
        case PLAYER_RANK_DEVELOPER:
        {
            if(set)
                gPlayerRanks[playerid] |= PLAYER_RANK_DEVELOPER;
            else
                gPlayerRanks[playerid] &= ~PLAYER_RANK_DEVELOPER;
        }
        case PLAYER_RANK_ADMIN:
        {
            if(set)
                gPlayerRanks[playerid] |= PLAYER_RANK_ADMIN;
            else
                gPlayerRanks[playerid] &= ~PLAYER_RANK_ADMIN;
        }
        case PLAYER_RANK_SUPERVISOR:
        {
            if(set)
                gPlayerRanks[playerid] |= PLAYER_RANK_SUPERVISOR;
            else
                gPlayerRanks[playerid] &= ~PLAYER_RANK_SUPERVISOR;
        }
        case PLAYER_RANK_MODERATOR:
        {
            if(set)
                gPlayerRanks[playerid] |= PLAYER_RANK_MODERATOR;
            else
                gPlayerRanks[playerid] &= ~PLAYER_RANK_MODERATOR;
        }
        case PLAYER_RANK_BETATESTER:
        {
            if(set)
                gPlayerRanks[playerid] |= PLAYER_RANK_BETATESTER;
            else
                gPlayerRanks[playerid] &= ~PLAYER_RANK_BETATESTER;
        }
        case PLAYER_RANK_DESIGNER:
        {
            if(set)
                gPlayerRanks[playerid] |= PLAYER_RANK_DESIGNER;
            else
                gPlayerRanks[playerid] &= ~PLAYER_RANK_DESIGNER;
        }
        case PLAYER_RANK_BACKUP:
        {
            if(set)
                gPlayerRanks[playerid] |= PLAYER_RANK_BACKUP;
            else
                gPlayerRanks[playerid] &= ~PLAYER_RANK_BACKUP;
        }
        case PLAYER_RANK_DONATOR:
        {
            if(set)
                gPlayerRanks[playerid] |= PLAYER_RANK_DONATOR;
            else
                gPlayerRanks[playerid] &= ~PLAYER_RANK_DONATOR;
        }
    }
}
