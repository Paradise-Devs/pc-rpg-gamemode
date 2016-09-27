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


public OnPlayerCheat(playerid, cheatid)
{
    switch(cheatid)
    {
        case CHEAT_NPCSPOOF: SetPlayerCheatPunishment(playerid, -1, "kick", 0, "NPC Spoof");
        case CHEAT_PLAYERSPOOF: SetPlayerCheatPunishment(playerid, -1, "kick", 0, "Connection Spoof");
    }
    return 1;
}

//punishment time -> -1 = permmanent / future-timestamp = temporary
SetPlayerCheatPunishment(playerid, issuerid, punishment[], punishment_time, reason[])
{
    if(!strcmp(punishment, "kick"))
    {
        new str[128], pname[24];
        GetPlayerName(playerid, pname, 24);
        format(str, sizeof(str), "{%s}Anti-cheater{FFFFFF}: o usuário {FF0000}%s{FFFFFF} foi kickado por suspeita de {FF0000}%s{FFFFFF}!", AC_TITLE_COLOR, pname, reason);
        SendClientMessageToAll(-1, str);
        return kick(playerid);
    }
    if(!strcmp(punishment, "ban"))
    {
        new query[128], str[128], pname[24], admname[24, cmd[32], playerip[16];
        GetPlayerName(playerid, pname, 24);
        if(issuerid != -1) GetPlayerName(issuerid, admname, 24);
        else format(admname, 24, "Paradise Anti-cheater");
        format(str, sizeof(str), "{%s}Anti-cheater{FFFFFF}: o usuário {FF0000}%s{FFFFFF} foi banido pelo uso de {FF0000}%s{FFFFFF}!", AC_TITLE_COLOR, pname, reason);
        SendClientMessageToAll(-1, str);
        mysql_format(mysql, query, sizeof(query), "INSERT INTO `bans` VALUES('NULL', '%s', '%s', '%d', '%d', '%s');", pname, reason, gettime(), punishment_time, admname);
        mysql_tquery(mysql, query, "", "");
        //inserir bans_details futuramente
        GetPlayerIp(playerid, playerip, 16);
        format(cmd, sizeof(cmd), "ban %d", playerid);
        SendRconCommand(cmd);
        format(cmd, sizeof(cmd), "banip %s", playerip);
        SendRconCommand(cmd);
    }
    if(!strcmp(punishment, "advert"))
    {
        foreach(new i : playerid)
        {
            if(GetPlayerRank(i) >= PLAYER_RANK_PARADISER)
            {
                new str[128], pname[24];
                GetPlayerName(playerid, pname, 24);
                format(str, sizeof(str), "{%s}Anti-cheater{FFFFFF}: o usuário {FF0000}%s{FFFFFF} foi identificado como suspeito de usar {FF0000}%s{FFFFFF}!", AC_TITLE_COLOR, pname, reason);
                SendClientMessage(playerid, -1, str);
                format(str, sizeof(str), "{%s}Anti-cheater{FFFFFF}: use o comando /spec <%d/%s> para monitorá-lo!", AC_TITLE_COLOR, playerid, pname);
                SendClientMessage(playerid, -1, str);
            }
        }
        return 1;
    }
    return 1;
}
