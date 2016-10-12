#define MAX_GANGS 5000

enum GangData
{
    name[24],
    description[256],
    founder_id,
    leader_id,
    color,
    filliation,
    patrimony,
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
};

stock CreateGangForPlayer(playerid, gang_name[24], filliation_id, member_1, member_2)
{
    if(GangInfo[MAX_GANGS-1][founder_id] != 0) return 0;

    mysql_format(mysql, query, sizeof(query), "INSERT INTO `gangs` VALUES('NULL', '%s', 'Sem descrição', '%d', '%d', '%d', '1000', '1', 'no symbol', '255', '%d', '0');",
    gang_name, playerid, playerid, filliation_id, gettime());
    mysql_tquery(mysql, query, "OnCreateGangForPlayer", "iii", playerid, member_1, member_2);

    format(query, sizeof(query), "Parabéns, você criou a gangue {%x}%s{FFFFFF}com sucesso!", GetGangRawColor(filliation_id), gang_name);
    SendClientMessage(playerid, -1, query);
    return 1;
}

forward OnCreateGangForPlayer(playerid, member_1, member_2);
public OnCreateGangForPlayer(playerid, member_1, member_2)
{
    SetPlayerGang(playerid, gang_id, 0);
    SetPlayerGang(member_1, gang_id, 1);
    SetPlayerGang(member_2, gang_id, 1);
    return 1;
}

stock SetPlayerGang(playeid, gang, rank)
{
    static query[128];
    mysql_format(mysql, query, sizeof(query), "DELETE FROM `gangs_members` WHERE `user_id` = '%d';", GetPlayerDatabaseID(playerid));
    mysql_tquery(mysql, query, "", "");

    mysql_format(mysql, query, sizeof(query), "INSERT INTO `gangs_members` VALUES('%d', '%d', '%d', '0', '0', '%d');", playerid, gang, rank, gettime());
    mysql_tquery(mysql, query, "OnSetPlayerGang", "iii", playerid, gang, rank);
    return 1;
}

forward OnSetPlayerGang(playerid gang, rank);
public OnSetPlayerGang(playerid, gang, rank)
{
    static string[64];
    format(string, sizeof(string), "Parabéns, você entrou para a gangue {%x}%s{FFFFFF}!", GetGangRawColor(GetGangFilliation(gangid)), GetGangName(gangid));
    SendClientMesage(playerid, -1, string);
    format(string, sizeof(string), "[{%x}Gangue{FFFFFF}] Seu cargo na gangue agora é: {%x}%s{FFFFFF}!",
    GetGangRawColor(GetGangFilliation(gangid)),  GetGangRawColor(GetGangFilliation(gangid)), GetGangRankName(rank));
    return 1;
}

stock bool:IsPlayerInAnyGang(playerid)
{
    if(PlayerGangInfo[playerid][gangid] != INVALID_GANG_ID) return true;
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

stock GetGangRankName(rank)
{
    switch (rank)
    {
        case 5: return "novato";
        case 4: return "membro";
        case 3: return "veterano";
        case 2: return "orgnizador";
        case 1: return "administrador";
        case 0: return "fundador";
        default: return "desconhecido";
    }
    return 0;
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
        case GANG_RUSSIAN_MAFIA: 0x6a686b;
        case GANG_ITALIAN_MAFIA: return 0x40863a;
        case GANG_BIKERS: return 0x080990;
        default: return 0x0;
    }
    return 0;
}
