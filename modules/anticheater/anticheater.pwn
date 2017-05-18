/*******************************************************************************
* FILENAME :        modules/anticheater/main.pwn
*
* DESCRIPTION :
*       Anti-cheater main file
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2016.  All rights reserved.
*
*/

#include "../modules/anticheater/configs.pwn"

//patches
#include "../modules/anticheater/patches/punishments.pwn"
#include "../modules/anticheater/patches/npcspoof.pwn"
#include "../modules/anticheater/patches/connectionspoof.pwn"
#include "../modules/anticheater/patches/autobullet.pwn"
#include "../modules/anticheater/patches/lagtroll.pwn"

public OnPlayerCheat(playerid, cheatid, const format[], {Float,_}:...)
{
    switch(cheatid)
    {
        case CHEAT_NPCSPOOF: SetPlayerCheatPunishment(playerid, -1, "kick", 0, "NPC Spoof");
        case CHEAT_PLAYERSPOOF: SetPlayerCheatPunishment(playerid, -1, "kick", 0, "Connection Spoof");
        case CHEAT_AUTOBULLET: SetPlayerCheatPunishment(playerid, -1, "ban", -1, "Auto-bullet");
        case CHEAT_LAGTROLL: SetPlayerCheatPunishment(playerid, -1, "kick", 0, "LagTroll.cs");
    }
    return 1;
}
