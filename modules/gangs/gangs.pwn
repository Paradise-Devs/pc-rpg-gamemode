
#include <YSI\y_hooks>

#define MAX_GANGS 5000
#define INVALID_GANG_ID -1


forward OnGangMenuResponse(playerid, gangname[], gangid, gangmembers[], bool:response);
forward OnSetPlayerGang(playerid, gang, chargerank);
forward OnCreateGangForPlayer(playerid, member1, member2, member3);

enum GangData
{
    name[24],
    description[256],
    founder_id,
    leader_id,
    gang_color,
    filliation,
    gang_patrimony,
    level,
    symbol[64],
    symbol_color,
    created_at,
    updated_at
}
static GangInfo[MAX_GANGS][GangData];

enum PlayerGangData
{
    gang_id,
    rank,
    contribution,
    reputation,
    joined_at
}
static PlayerGangInfo[MAX_PLAYERS][PlayerGangData];

//usado para criar gangs
enum GangMenuData
{
    bool:in_gang_menu,
    current_selection,
    gang_name[24],
    members[3]
}
new PlayerGangMenuInfo[MAX_PLAYERS][GangMenuData];


enum
{
    GANG_GROVE = 0,
    GANG_BALLAS = 1,
    GANG_AZTECAS = 2,
    GANG_VAGOS = 3,
    GANG_RIFA = 4,
    GANG_TRIADS = 5,
    GANG_DA_NANG = 6,
    GANG_RUSSIAN_MAFIA = 7,
    GANG_ITALIAN_MAFIA = 8,
    GANG_BIKERS = 9
}

new GangSkins[] =
{
    //grove street
    { 105, 106, 107},
    //ballas
    { 102, 103, 104},
    //aztecas
    { 114, 115, 116},
    //vagos
    { 108, 109, 110},
    //rifa
    { 173, 174, 175},
    //triads
    { 117, 118, 120},
    //da nang
    { 121, 122, 123},
    //russians
    { 111, 112, 113},
    //italians
    { 124, 125, 126},
    //bikers
    { 247, 248, 254}
};

stock SetPlayerGang(playerid, gang, chargerank)
{
    static query[128];
    mysql_format(mysql, query, sizeof(query), "DELETE FROM `gangs_members` WHERE `user_id` = '%d';", GetPlayerDatabaseID(playerid));
    mysql_tquery(mysql, query, "", "");

    mysql_format(mysql, query, sizeof(query), "INSERT INTO `gangs_members` VALUES('%d', '%d', '%d', '0', '0', '%d');", playerid, gang, chargerank, gettime());
    mysql_tquery(mysql, query, "OnSetPlayerGang", "iii", playerid, gang, chargerank);
    return 1;
}

public OnSetPlayerGang(playerid, gang, chargerank)
{
    static string[64];
    format(string, sizeof(string), "Parabéns, você entrou para a gangue {%x}%s{FFFFFF}!", GetGangRawColor(GetGangFilliation(gang)), GetGangName(gang));
    SendClientMessage(playerid, -1, string);
    format(string, sizeof(string), "[{%x}Gangue{FFFFFF}] Seu cargo na gangue agora é: {%x}%s{FFFFFF}!", GetGangRawColor(GetGangFilliation(gang)),  GetGangRawColor(GetGangFilliation(gang)), GetGangRankName(chargerank));
    return 1;
}

IsPlayerInAnyGang(playerid)
{
    if(PlayerGangInfo[playerid][gang_id] != 0) return true;
    return false;
}

stock GetGangFilliation(gangid)
{
    return GangInfo[gangid][filliation];
}

stock GetGangName(gangid)
{
    return GangInfo[gangid][name];
}

stock GetGangRankName(chargerank)
{
    new str[32];
    switch (chargerank)
    {
        case 5: format(str, 32, "novato");
        case 4: format(str, 32,"membro");
        case 3: format(str, 32,"veterano");
        case 2: format(str, 32, "orgnizador");
        case 1: format(str, 32,"administrador");
        case 0: format(str, 32,"fundador");
        default: format(str, 32,"desconhecido");
    }
    return str;
}

stock GetGangRawColor(gangtype)
{
    switch (gangtype)
    {
        case GANG_GROVE: return 0x079358;
        case GANG_BALLAS: return 0x900493;
        case GANG_AZTECAS: return 0xf4f909;
        case GANG_VAGOS: return 0x06b3f4;
        case GANG_RIFA: return 0x0afcee;
        case GANG_TRIADS: return 0xb50510;
        case GANG_DA_NANG: return 0xb1ab59;
        case GANG_RUSSIAN_MAFIA: return 0x6a686b;
        case GANG_ITALIAN_MAFIA: return 0x40863a;
        case GANG_BIKERS: return 0x080990;
        default: return 0x0;
    }
    return 0;
}

stock GetGangSkins(gangid, &skin, &skin1, &skin2)
{
    if(0 > gangid > 9) return 0;
    skin = GangSkins[gangid][0];
    skin1 = GangSkins[gangid][1];
    skin2 = GangSkins[gangid][2];
    return 1;
}

public OnGangMenuResponse(playerid, gangname[], gangid, gangmembers[], bool:response)
{
    if(!response) return HidePlayerGangMenu(playerid);
    return 1;
}

SetPlayerGangMenuState(playerid, bool:toggled = false)
{
    if(toggled) PlayerGangMenuInfo[playerid][in_gang_menu] = true;
    else PlayerGangMenuInfo[playerid][in_gang_menu] = false;
    return 1;
}

SetPlayerGangMenuName(playerid, gname[])
{
    format(PlayerGangMenuInfo[playerid][gang_name], 24, "%s", gname);
    return 1;
}
