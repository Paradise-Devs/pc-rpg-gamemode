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

forward OnPlayerCheat(playerid, cheatid);

#define CHEAT_NONE 0
#define CHEAT_NPCSPOOF 1
#define CHEAT_PLAYERSPOOF 2


public OnPlayerCheat(playerid, cheatid)
{
    switch(cheatid)
    {
        case CHEAT_NPCSPOOF: SetPlayerCheatPunishment(playerid, "kick", "", "NPC Spoof");
        case CHEAT_PLAYERSPOOF: SetPlayerCheatPunishment(playerid, "kick", "", "Connection Spoof");

    }
    return 1;
}

//punishment time -> -1 = permmanent / future-timestamp = temporary
SetPlayerCheatPunishment(playerid, punishment[], punishment_time, reason[])
{
    if(!strcmp(punishment, "kick"))
    {
        new str[128], pname[24];
        GetPlayerName(playerid, pname, 24);
        format(str, sizeof(str), "{0475eb}Anti-cheater{FFFFFF}: o usuário {FF0000}%s{FFFFFF} foi kickado por suspeita de {FF0000}%s{FFFFFF}!", pname, reason);
        SendClientMessageToAll(-1, str);
    }
    if(!strcmp(punishment, "ban"))
    {

    }
    if(GetPlayerRank(i) >= PLAYER_RANK_PARADISER)
    return 1;
}
