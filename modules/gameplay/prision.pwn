/*******************************************************************************
* FILENAME :        modules/gameplay/prision.pwn
*
* DESCRIPTION :
*       Adds prision to the server.
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

static const Float:gfPrisionSpawns[][] =
{
    {198.0363,  161.7579,   1003.0300,  180.0},
    {197.9514,  175.9870,   1003.0234,  0.0},
    {193.8542,  176.2215,   1003.0234,  0.0}
};

static const Float:gfReleaseSpawn[] =
{
    200.9720, 167.8305, 1003.0234, 57.6417
};

//------------------------------------------------------------------------------

static gplPrisionTime[MAX_PLAYERS];
static bool:gplIsInPrision[MAX_PLAYERS];

//------------------------------------------------------------------------------

PutPlayerInPrision(playerid, time)
{
    if(time < 1)
        return;

    gplIsInPrision[playerid] = true;
    gplPrisionTime[playerid] = time;

    new rand = random(sizeof(gfPrisionSpawns));
    SetPlayerInterior(playerid, 3);
    SetPlayerVirtualWorld(playerid, 0);
    SetPlayerFacingAngle(playerid, gfPrisionSpawns[rand][3]);
    SetPlayerPos(playerid, gfPrisionSpawns[rand][0], gfPrisionSpawns[rand][1], gfPrisionSpawns[rand][2]);
}

bool:IsPlayerInPrision(playerid)
{
    if(gplIsInPrision[playerid])
        return true;
    return false;
}

SetPlayerPrisionTime(playerid, time)
{
    if(!IsPlayerInPrision(playerid))
        PutPlayerInPrision(playerid, time);
    else
    {
        if(time >= 0)
            gplPrisionTime[playerid] = time;
    }
}

GetPlayerPrisionTime(playerid)
{
    return gplPrisionTime[playerid];
}

//------------------------------------------------------------------------------

ptask OnPlayerPrisionUpdate[1000](playerid)
{
    if(!IsPlayerLogged(playerid) || !IsPlayerInPrision(playerid))
		return 1;

    new sTimeText[148];
	format(sTimeText, sizeof sTimeText, ConvertToGameText("~n~~n~~n~~n~~n~~n~~n~                                           ~r~Prisão...~n~                                          %02d:%02d"), (GetPlayerPrisionTime(playerid) - 1) / 60, (GetPlayerPrisionTime(playerid) - 1) % 60);
	GameTextForPlayer(playerid, sTimeText, 1500, 3);
	SetPlayerPrisionTime(playerid, GetPlayerPrisionTime(playerid) - 1);

    if(GetPlayerPrisionTime(playerid) < 1)
    {
        gplIsInPrision[playerid] = false;

        SetPlayerPos(playerid, gfReleaseSpawn[0], gfReleaseSpawn[1], gfReleaseSpawn[2]);
        SetPlayerFacingAngle(playerid, gfReleaseSpawn[3]);

        SendClientMessage(playerid, 0xB6B6B6FF, "Oficial diz: Sua pena foi cumprida, tente seguir as regras de agora em diante.");
    }
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerDisconnect(playerid, reason)
{
    gplPrisionTime[playerid] = 0;
    gplIsInPrision[playerid] = false;
    return 1;
}
