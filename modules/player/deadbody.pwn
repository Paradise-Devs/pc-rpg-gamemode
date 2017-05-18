/*******************************************************************************
* FILENAME :        modules/player/deadbody.pwn
*
* DESCRIPTION :
*       Adds an actor where the player dies.
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

enum E_DEADBODY_DATA
{
    // IDs
    E_DEADBODY_ACTOR,
    Text3D:E_DEADBODY_TEXT3D,

    // Models
    E_DEADBODY_SKIN,

    // States
    bool:E_DEADBODY_ACTIVE,

    // Positions
    Float:E_DEADBODY_X,
    Float:E_DEADBODY_Y,
    Float:E_DEADBODY_Z,
    E_DEADBODY_WORLD,
    E_DEADBODY_INTERIOR
}
static gPDeadBodyData[MAX_PLAYERS][E_DEADBODY_DATA];

//------------------------------------------------------------------------------

hook OnPlayerDeath(playerid, killerid, reason)
{
    if(IsPlayerInPaintball(playerid)) return 1;
    // Only create an actor if there is no actor of this player active
    if(gPDeadBodyData[playerid][E_DEADBODY_ACTIVE] == false)
    {
        // Set the body as active
        gPDeadBodyData[playerid][E_DEADBODY_ACTIVE] = true;

        // Get player position
        gPDeadBodyData[playerid][E_DEADBODY_SKIN] = GetPlayerSkin(playerid);
        gPDeadBodyData[playerid][E_DEADBODY_WORLD] = GetPlayerVirtualWorld(playerid);
        gPDeadBodyData[playerid][E_DEADBODY_INTERIOR] = GetPlayerInterior(playerid);
        GetPlayerPos(playerid, gPDeadBodyData[playerid][E_DEADBODY_X], gPDeadBodyData[playerid][E_DEADBODY_Y], gPDeadBodyData[playerid][E_DEADBODY_Z]);

        // Create the actor
        gPDeadBodyData[playerid][E_DEADBODY_ACTOR] = CreateActor(
            gPDeadBodyData[playerid][E_DEADBODY_SKIN],
            gPDeadBodyData[playerid][E_DEADBODY_X],
            gPDeadBodyData[playerid][E_DEADBODY_Y],
            gPDeadBodyData[playerid][E_DEADBODY_Z],
            0.0
        );

        SetActorVirtualWorld(gPDeadBodyData[playerid][E_DEADBODY_ACTOR], gPDeadBodyData[playerid][E_DEADBODY_WORLD]);
        // ApplyActorAnimation(gPDeadBodyData[playerid][E_DEADBODY_ACTOR], "SWAT", "Rail_fall_crawl", 4.1, 0, 1, 1, 1, 0);
        ApplyActorAnimation(gPDeadBodyData[playerid][E_DEADBODY_ACTOR], "KNIFE", "KILL_Knife_Ped_Die", 4.1, 0, 1, 1, 1, 0);

        // Create the 3D label
        new sTextLabel[94];
        format(sTextLabel, sizeof(sTextLabel), "Cadaver de {a5f413}%s\n{ffffff}Morto as {a5f413}%s", GetPlayerNamef(playerid), convertTimestamp(gettime()));
        gPDeadBodyData[playerid][E_DEADBODY_TEXT3D] = CreateDynamic3DTextLabel(sTextLabel, -1, gPDeadBodyData[playerid][E_DEADBODY_X], gPDeadBodyData[playerid][E_DEADBODY_Y], gPDeadBodyData[playerid][E_DEADBODY_Z], 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, gPDeadBodyData[playerid][E_DEADBODY_WORLD], -1, -1, 10.0);
    }
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerDisconnect(playerid, reason)
{
    // If the player has an actor active destroy it
    if(gPDeadBodyData[playerid][E_DEADBODY_ACTIVE] == true)
    {
        gPDeadBodyData[playerid][E_DEADBODY_ACTIVE] = false;
        DestroyActor(gPDeadBodyData[playerid][E_DEADBODY_ACTOR]);
        DestroyDynamic3DTextLabel(gPDeadBodyData[playerid][E_DEADBODY_TEXT3D]);
    }
    return 1;
}

//------------------------------------------------------------------------------

OnDestroyPlayerDeadbody(playerid)
{
    // If the player has an actor active destroy it
    if(gPDeadBodyData[playerid][E_DEADBODY_ACTIVE] == true)
    {
        gPDeadBodyData[playerid][E_DEADBODY_ACTIVE] = false;
        DestroyActor(gPDeadBodyData[playerid][E_DEADBODY_ACTOR]);
        DestroyDynamic3DTextLabel(gPDeadBodyData[playerid][E_DEADBODY_TEXT3D]);
    }
}

//------------------------------------------------------------------------------

IsActorADeadbody(actorid)
{
    foreach(new i: Player)
    {
        if(actorid == gPDeadBodyData[i][E_DEADBODY_ACTOR])
            return true;
    }
    return false;
}

//------------------------------------------------------------------------------

YCMD:roubar(playerid, params[], help)
{
    // Check for closer dead bodies
    new targetid = INVALID_PLAYER_ID;
	foreach(new i: Player)
        if(IsPlayerInRangeOfPoint(playerid, 2.5, gPDeadBodyData[i][E_DEADBODY_X], gPDeadBodyData[i][E_DEADBODY_Y], gPDeadBodyData[i][E_DEADBODY_Z]) && gPDeadBodyData[i][E_DEADBODY_ACTIVE] == true)
            targetid = i;

    // If no bodies was found
    if(targetid == INVALID_PLAYER_ID)
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não está perto de nenhum cadaver.");

    if(GetPlayerCash(targetid) <= 0)
        return SendClientMessage(playerid, COLOR_ERROR, "* Este cadaver não tem dinheiro.");

    new output[111];
    format(output, sizeof(output), "* Você roubou {a5f413}$%s{ffffff} do cadaver de {a5f413}%s{ffffff}.", formatnumber(GetPlayerCash(targetid)), GetPlayerNamef(targetid));
    SendClientMessage(playerid, 0xffffffff, output);
    SendClientMessage(targetid, 0xffffffff, "* {a5f413}Roubaram{ffffff} o seu dinheiro enquanto você estava desmaido.");

    GivePlayerCash(playerid, GetPlayerCash(targetid));
    GivePlayerCash(targetid, -GetPlayerCash(targetid));
	return 1;
}
