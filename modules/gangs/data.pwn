CreateGangForPlayer(playerid, gname[24], filliation_id, member_1, member_2, member_3)
{
    if(GangInfo[MAX_GANGS-1][founder_id] != 0) return 0;

    mysql_format(mysql, query, sizeof(query), "INSERT INTO `gangs` VALUES('NULL', '%s', 'Sem descrição', '%d', '%d', '%d', '1000', '1', 'no symbol', '255', '%d', '0');",
    gname, playerid, playerid, filliation_id, gettime());
    mysql_tquery(mysql, query, "OnCreateGangForPlayer", "iiii", playerid, member_1, member_2, member_3);

    format(query, sizeof(query), "Parabéns, você criou a gangue {%x}%s{FFFFFF}com sucesso!", GetGangRawColor(filliation_id), gname);
    SendClientMessage(playerid, -1, query);
    return 1;
}


public OnCreateGangForPlayer(playerid, member1, member2, member3)
{
    new gangid = cache_insert_id();
    SetPlayerGang(playerid, gangid, 0);
    SetPlayerGang(member1, gangid, 5);
    SetPlayerGang(member2, gangid, 5);
    SetPlayerGang(member3, gangid, 5);
    return 1;
}
