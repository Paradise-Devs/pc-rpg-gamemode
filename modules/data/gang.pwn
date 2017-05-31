//limits
#define MAX_GANGS 5000
#define INVALID -1

//callbacks
forward OnSetPlayerGang(playerid, gang, charge);
forward OnCreateGangForPlayer(playerid, member_1, member_2, member_3);
forward OnLoadPlayerGangData(playerid);
forward OnGangLoad(gangid);

//structures
enum GangData
{
    gang_name[24],
    gang_description[256],
    founder_id,
    leader_id,
    gang_color,
    filliation,
    gang_patrimony,
    g_level,
    symbol[64],
    symbol_color,
    created_at,
    updated_at
}
static GangInfo[MAX_GANGS][GangData];

enum PlayerGangData
{
    gang_id,
    gang_rank,
    contribution,
    reputation,
    joined_at
}
static PlayerGangInfo[MAX_PLAYERS][PlayerGangData];

enum PlayerGangInvitationData{
    invite_timer[4],
    bool:active_token[4],
    receiver_id[4],
    sender_id,
    users_list[100],
    bool:accepted[4],
    menu_slot
}
new PlayerGangInvitationInfo[MAX_PLAYERS][PlayerGangInvitationData];


//usado para criar gangs
enum GangMenuData
{
    bool:in_gang_menu,
    current_selection,
    g_name[24],
    members[3],
    g_matrix
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

static GangSkins[] =
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

//Models
stock LoadPlayerGangData(playerid)
{
    new query[128];
    mysql_format(mysql, query, sizeof(query), "SELECT * FROM `gangs_members` WHERE `player_id` = '%d';", GetPlayerDatabaseID(playerid));
    mysql_tquery(mysql, query, "OnLoadPlayerGangData", "i", playerid);
    return 1;
}

stock LoadGangs()
{
    for(new g; g < MAX_GANGS; g++)
        LoadGang(g);
    return 1;
}

stock LoadGang(gangid)
{
    new query[128];
    mysql_format(mysql, query, sizeof(query), "SELECT * FROM `gangs` WHERE `id` = '%d';", gangid);
    mysql_tquery(mysql, query, "OnGangLoad", "i", gangid);
    return 1;
}

stock SavePlayerGangData(playerid)
{
    new query[256];
    mysql_format(mysql, query, sizeof(query), "UPDATE `gangs_members` SET `gang_id` = '%d', `rank` = '%d', `contribution` = '%d' \
    `reputation` = '%d', `joined_at` = '%d' WHERE `player_id` = '%d';", PlayerGangInfo[playerid][gang_id], PlayerGangInfo[playerid][gang_rank], PlayerGangInfo[playerid][contribution], PlayerGangInfo[playerid][reputation], PlayerGangInfo[playerid][joined_at], GetPlayerDatabaseID(playerid));
    mysql_tquery(mysql, query, "", "");
    return 1;
}

stock SaveGangs()
{
    for(new g; g < MAX_GANGS; g++)
    {
        if(!strlen(GangInfo[g][gang_name])) continue;
        SaveGang(g);
    }
    return 1;
}

stock SaveGang(gangid)
{
    new query[256];
    mysql_format(mysql, query, sizeof(query), "UPDATE `gangs` SET `name` = '%s', `description` = '%s', `founder_id` = '%d' \
    `leader_id` = '%d', `gang_color` = '%d', `filliation` = '%d', `gang_patrimony` = '%d', `g_level` = '%d', `symbol` = '%s' \
    `symbol_color` = '%d', `updated_at` = '%d' WHERE `id` = '%d';", GangInfo[gangid][gang_name], GangInfo[gangid][gang_description], GangInfo[gangid][founder_id], GangInfo[gangid][leader_id], GangInfo[gangid][gang_color], GangInfo[gangid][filliation], GangInfo[gangid][gang_patrimony], GangInfo[gangid][g_level], GangInfo[gangid][symbol], GangInfo[gangid][symbol_color], gettime(), gangid);
    mysql_tquery(mysql, query, "", "");
    return 1;
}

//Events
public OnLoadPlayerGangData(playerid)
{
    new rows, fields;
    cache_get_data(rows, fields, mysql);

    if(rows != 0)
    {
        PlayerGangInfo[playerid][gang_id] = cache_get_field_content_int(0, "gang_id");
        PlayerGangInfo[playerid][gang_rank] = cache_get_field_content_int(0, "rank");
        PlayerGangInfo[playerid][contribution] = cache_get_field_content_int(0, "contribution");
        PlayerGangInfo[playerid][reputation] = cache_get_field_content_int(0, "reputation");
        PlayerGangInfo[playerid][joined_at] = cache_get_field_content_int(0, "joined_at");
    }
    return 1;
}

public OnGangLoad(gangid)
{
    new rows, fields;
    cache_get_data(rows, fields, mysql);

    if(rows != 0)
    {
        cache_get_field_content(0, "name", GangInfo[gangid][gang_name], mysql);
        cache_get_field_content(0, "description", GangInfo[gangid][gang_description], mysql);
        GangInfo[gangid][founder_id] = cache_get_field_content_int(0, "founder_id");
        GangInfo[gangid][leader_id] = cache_get_field_content_int(0, "leader_id");
        GangInfo[gangid][gang_color] = cache_get_field_content_int(0, "gang_color");
        GangInfo[gangid][filliation] = cache_get_field_content_int(0, "filliation");
        GangInfo[gangid][gang_patrimony] = cache_get_field_content_int(0, "gang_patrimony");
        GangInfo[gangid][g_level] = cache_get_field_content_int(0, "level");
        cache_get_field_content(0, "symbol", GangInfo[gangid][symbol]);
        GangInfo[gangid][symbol_color] = cache_get_field_content_int(0, "symbol_color");
        GangInfo[gangid][created_at] = cache_get_field_content_int(0, "created_at");
        GangInfo[gangid][updated_at] = cache_get_field_content_int(0, "updated_at");
    }
    return 1;
}

public OnCreateGangForPlayer(playerid, member_1, member_2, member_3)
{
    new gangid = cache_insert_id();

    LoadGang(gangid);

    SetPlayerGang(playerid, gangid, 0);
    SetPlayerGang(member_1, gangid, 5);
    SetPlayerGang(member_2, gangid, 5);
    SetPlayerGang(member_3, gangid, 5);
    return 1;
}

public OnSetPlayerGang(playerid, gang, charge)
{
    static string[64];
    format(string, sizeof(string), "Parabéns, você entrou para a gangue {%x}%s{FFFFFF}!", GetGangRawColor(GetGangFilliation(gang)), GetGangName(gang));
    SendClientMessage(playerid, -1, string);
    format(string, sizeof(string), "[{%x}Gangue{FFFFFF}] Seu cargo na gangue agora é: {%x}%s{FFFFFF}!", GetGangRawColor(GetGangFilliation(gang)),  GetGangRawColor(GetGangFilliation(gang)), GetGangRankName(charge));
    return 1;
}

//Set Methods
stock SetPlayerGangMenuState(playerid, bool:toggle = false)
{
    PlayerGangMenuInfo[playerid][in_gang_menu] = toggle;
    return 1;
}

stock SetPlayerGangMenuName(playerid, gangname[])
{
    format(PlayerGangMenuInfo[playerid][g_name], 24, "%s", gangname);
    UpdatePlayerGangMenuName(playerid, gangname);
    return 1;
}

stock SetPlayerGangMenuSelection(playerid, selected_slot)
{
    PlayerGangMenuInfo[playerid][current_selection] = selected_slot;
    return 1;
}

stock SetPlayerGang(playerid, gang, charge)
{
    static query[256];
    mysql_format(mysql, query, sizeof(query), "DELETE FROM `gangs_members` WHERE `player_id` = '%d';", GetPlayerDatabaseID(playerid));
    mysql_tquery(mysql, query, "", "");

    mysql_format(mysql, query, sizeof(query), "INSERT INTO `gangs_members` (`player_id`, `gang_id`, `rank`, `contribution`, `reputation`, `joined_at`) VALUES('%d', '%d', '%d', '0', '0', '%d');", GetPlayerDatabaseID(playerid), gang, charge, gettime());
    mysql_tquery(mysql, query, "OnSetPlayerGang", "iii", playerid, gang, charge);
    return 1;
}

stock CreateGangForPlayer(playerid, gangname[], matrix, member[3])
{
    static query[512];
    mysql_format(mysql, query, sizeof(query), "INSERT INTO `gangs` (`name`, `description`, `founder_id`, `leader_id`, \
    `gang_color`, `filliation`, `gang_patrimony`, `level`, `symbol`, `symbol_color`, `created_at`, `updated_at`) \
    VALUES('%s', 'Sem descrição', '%d', '%d', '%d', '%d', '5000', '1', 'defaut.png', '-1', '%d', '%d');", gangname,
    GetPlayerDatabaseID(playerid), GetPlayerDatabaseID(member[0]), GetGangRawColor(matrix), matrix, gettime(), gettime());
    mysql_tquery(mysql, query, "OnCreateGangForPlayer", "iiii", playerid, member[0], member[1], member[2]);
}

stock ResetPlayerGangData(playerid)
{
    PlayerGangInfo[playerid][gang_id] = INVALID;
    PlayerGangInfo[playerid][gang_rank] = 0;
    PlayerGangInfo[playerid][contribution] = 0;
    PlayerGangInfo[playerid][reputation] = 0;
    PlayerGangInfo[playerid][joined_at] = 0;
    return 1;
}

stock ResetPlayerGangInvitationData(senderid, receiverid, slot)
{
    //clean senderid slot
    KillTimer(PlayerGangInvitationInfo[senderid][invite_timer][slot]);
    PlayerGangInvitationInfo[senderid][active_token][slot] = false;
    PlayerGangInvitationInfo[senderid][accepted][slot] = false;
    PlayerGangInvitationInfo[receiverid][menu_slot] = 3;

    //clean receiverid
    PlayerGangInvitationInfo[receiverid][sender_id] = INVALID;

    return 1;
}


stock ResetPlayerGangMenuData(playerid)
{
    PlayerGangMenuInfo[playerid][in_gang_menu] = false;
    PlayerGangMenuInfo[playerid][g_matrix] = INVALID;
    PlayerGangMenuInfo[playerid][current_selection] = INVALID;
    format(PlayerGangMenuInfo[playerid][g_name], 24, "");
    for(new x; x < 3; x++) PlayerGangMenuInfo[playerid][members][x] = INVALID;
    return 1;
}

stock SetPlayerGangMenuMatrix(playerid, mtxid)
{
    if(0 > mtxid > 9) return SendClientMessage(playerid, -1, "* Filiação de gangue inválida, contate um administrador!");
    PlayerGangMenuInfo[playerid][g_matrix] = mtxid;
    return 1;
}

stock ResetGangsData()
{
    for(new g; g < MAX_GANGS; g++) ResetGangData(g);
    return 1;
}

stock ResetGangData(gangid)
{
    strdel(GangInfo[gangid][gang_name], 0, sizeof(GangInfo[gangid][gang_name]));
    strdel(GangInfo[gangid][gang_description], 0, sizeof(GangInfo[gangid][gang_description]));
    GangInfo[gangid][founder_id] = INVALID;
    GangInfo[gangid][leader_id] = INVALID;
    GangInfo[gangid][gang_color] = 0;
    GangInfo[gangid][filliation] = INVALID;
    GangInfo[gangid][gang_patrimony] = 0;
    GangInfo[gangid][g_level] = 0;
    strdel(GangInfo[gangid][symbol], 0, sizeof(GangInfo[gangid][symbol]));
    GangInfo[gangid][symbol_color] = 0;
    GangInfo[gangid][created_at] = 0;
    GangInfo[gangid][updated_at] = 0;
    return 1;
}

//Get Methods
stock GetGangSkins(gangid, &skin, &skin1, &skin2)
{
    if(0 > gangid > 9) return 0;
    skin = GangSkins[gangid][0];
    skin1 = GangSkins[gangid][1];
    skin2 = GangSkins[gangid][2];
    return 1;
}

GetGangFilliation(gangid)
{
    return GangInfo[gangid][filliation];
}

GetGangName(gangid)
{
    return GangInfo[gangid][gang_name];
}

GetGangRankName(charge)
{
    new str[32];
    switch (charge)
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

GetGangRawColor(gangtype)
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

GetPlayerGang(playerid)
{
    return PlayerGangInfo[playerid][gang_id];
}

ResetGangUsersList(playerid)
{
    for(new x; x < 100; x++) PlayerGangInvitationInfo[playerid][users_list][x] = INVALID;
    return 1;
}

SetPlayerInGangMenu(senderid, receiverid, slot)
{
    if(slot > 2) return 0;
    PlayerGangInvitationInfo[senderid][receiver_id][slot] = receiverid;
    PlayerGangInvitationInfo[senderid][accepted][slot] = true;
    return 1;
}
