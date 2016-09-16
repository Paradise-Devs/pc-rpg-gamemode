/*******************************************************************************
* FILENAME :        modules/data/faction.pwn
*
* DESCRIPTION :
*       Saves and Loads faction data.
*
* NOTES :
*       This file should only contain information about faction's data.
*       This is not intended to handle player commands, etc.
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

#define MAX_FACTION_NAME    32
#define MAX_FACTION_RANKS   10

//------------------------------------------------------------------------------

forward OnFactionLoad();
forward OnInsertFaction(factionid);

//------------------------------------------------------------------------------

// enumaration of faction's data
enum e_faction_data
{
    // index
    e_faction_database_id,

    // Positions
    Float:e_faction_spawn_x,
    Float:e_faction_spawn_y,
    Float:e_faction_spawn_z,
    Float:e_faction_spawn_a,

    // Info
    e_faction_name[MAX_FACTION_NAME],
    e_faction_type,
    e_faction_max_ranks,
    e_faction_custom,
    e_faction_color,
    e_faction_skin[MAX_FACTION_RANKS]
}
static gFactionData[MAX_FACTIONS][e_faction_data];
static gFactionRankNames[MAX_FACTIONS][MAX_FACTION_RANKS][MAX_FACTION_NAME];
static gCreatedFaction;

enum
{
    FACTION_TYPE_NONE,
    FACTION_TYPE_NEWS,
    FACTION_TYPE_POLICE,
    FACTION_TYPE_CRIMINAL,
    FACTION_TYPE_HITMAN,
    FACTION_TYPE_DEALER
}

enum
{
    FACTION_NONE,
    FACTION_CNN
}

//------------------------------------------------------------------------------

GetFactionName(factionid)
{
    new factionName[MAX_FACTION_NAME];
    if(factionid < 0 || factionid > MAX_FACTIONS-1)
        printf("[ERROR] GetFactionName tried to access invalid factionid. Factionid: %d", factionid);
    else
    {
        format(factionName, sizeof(factionName), "%s", gFactionData[factionid][e_faction_name]);
        return factionName;
    }
    factionName = "Nenhuma";
    return factionName;
}

GetFactionRankName(factionid, rank)
{
    new factionName[MAX_FACTION_NAME];
    if(factionid < 0 || factionid > MAX_FACTIONS-1)
        printf("[ERROR] GetFactionRankName tried to access invalid factionid. Factionid: %d", factionid);
    else if(rank < 0 || rank > MAX_FACTION_RANKS-1)
        printf("[ERROR] GetFactionRankName tried to access invalid rankid. rankid: %d", rank);
    else
    {
        format(factionName, sizeof(factionName), "%s", gFactionRankNames[factionid][rank]);
        return factionName;
    }
    factionName = "Nenhum";
    return factionName;
}

GetFactionTypeName(factionid)
{
    new typeName[32];
    switch(GetFactionType(factionid))
    {
        case FACTION_TYPE_NONE:
            typeName = "Nenhum";
        case FACTION_TYPE_NEWS:
            typeName = "Noticias";
        case FACTION_TYPE_POLICE:
            typeName = "Policial";
        default:
            typeName = "Inválido";
    }
    return typeName;
}

GetFactionCount() { return gCreatedFaction; }
GetFactionType(factionid){ return gFactionData[factionid][e_faction_type]; }
GetFactionMaxRanks(factionid) { return gFactionData[factionid][e_faction_max_ranks]; }

SetPlayerFactionSkin(playerid)
{
    if(GetPlayerFactionID(playerid) == FACTION_NONE)
        return 0;

    new j = GetPlayerFactionID(playerid);
    new i = GetPlayerFactionRankID(playerid);
    SetPlayerSkin(playerid, gFactionData[j][e_faction_skin][i]);
    return 1;
}

IsPlayerUsingFactionSkin(playerid)
{
    if(GetPlayerFactionID(playerid) == FACTION_NONE)
        return false;

    new skinid = GetPlayerSkin(playerid);
    new j = GetPlayerFactionID(playerid);
    new i = GetPlayerFactionRankID(playerid);
    if(gFactionData[j][e_faction_skin][i] == skinid)
        return true;
    return false;
}

IsPlayerOnDuty(playerid)
{
    return (IsPlayerUsingFactionSkin(playerid));
}

SendPlayerFactionTypeMessage(playerid, message[])
{
    new factionid = GetPlayerFactionID(playerid);
    if(factionid == FACTION_NONE)
        return;

    foreach(new i: Player)
	{
		if(GetFactionType(GetPlayerFactionID(i)) == GetFactionType(factionid))
		{
			new radioMessage[181];
			format(radioMessage, sizeof(radioMessage), "(Depart.) %s %s diz: %s", GetFactionRankName(GetPlayerFactionID(playerid), GetPlayerFactionRankID(playerid)), GetPlayerNamef(playerid), message);
			SendMultiMessage(i, 0xEE7878FF, radioMessage);
		}
		else if(GetFactionType(GetPlayerFactionID(i)) != GetFactionType(factionid) && i != playerid)
		{
			new Float:x, Float:y, Float:z;
			GetPlayerPos(playerid, x, y, z);
			if(IsPlayerInRangeOfPoint(i, 8.0, x, y, z))
			{
				new localMessage[181];
				format(localMessage, sizeof(localMessage), "(Radio) %s diz: %s", GetPlayerNamef(playerid), message);
				SendMultiMessage(i, 0xB6B6B6FF, localMessage);
			}
		}
	}
}

SendPlayerFactionMessage(playerid, message[])
{
	new factionid = GetPlayerFactionID(playerid);
	if(factionid == FACTION_NONE)
		return 0;

	foreach(new i: Player)
	{
		if(GetPlayerFactionID(i) == factionid)
		{
			new radioMessage[181];
			format(radioMessage, sizeof(radioMessage), "(Radio) %s %s diz: %s", GetFactionRankName(GetPlayerFactionID(playerid), GetPlayerFactionRankID(playerid)), GetPlayerNamef(playerid), message);
			SendMultiMessage(i, gFactionData[factionid][e_faction_color], radioMessage);
		}
		else if(GetPlayerFactionID(i) != factionid && i != playerid)
		{
			new Float:x, Float:y, Float:z;
			GetPlayerPos(playerid, x, y, z);
			if(IsPlayerInRangeOfPoint(i, 8.0, x, y, z))
			{
				new localMessage[181];
				format(localMessage, sizeof(localMessage), "(Radio) %s diz: %s", GetPlayerNamef(playerid), message);
				SendMultiMessage(i, 0xB6B6B6FF, localMessage);
			}
		}
	}
	return 1;
}

SendFactionMessage(factionid, color, message[])
{
	if(factionid == FACTION_NONE)
		return 0;

	foreach(new i: Player)
		if(GetPlayerFactionID(i) == factionid)
			SendMultiMessage(i, color, message);
	return 1;
}

//------------------------------------------------------------------------------

public OnFactionLoad()
{
    for(new i, j = cache_get_row_count(mysql); i < j; i++)
	{
		gFactionData[i][e_faction_database_id]    = cache_get_row_int(i, 0, mysql);

        gFactionData[i][e_faction_spawn_x]        = cache_get_row_float(i, 1, mysql);
		gFactionData[i][e_faction_spawn_y]        = cache_get_row_float(i, 2, mysql);
		gFactionData[i][e_faction_spawn_z]        = cache_get_row_float(i, 3, mysql);
		gFactionData[i][e_faction_spawn_a]        = cache_get_row_float(i, 4, mysql);

        cache_get_row(i, 5, gFactionData[i][e_faction_name], mysql);
		gFactionData[i][e_faction_type]           = cache_get_row_int(i, 6, mysql);
		gFactionData[i][e_faction_max_ranks]      = cache_get_row_int(i, 7, mysql);
		gFactionData[i][e_faction_custom]         = cache_get_row_int(i, 8, mysql);
		gFactionData[i][e_faction_color]          = cache_get_row_int(i, 9, mysql);

        for(new h = 0; h < MAX_FACTION_RANKS; h++)
            cache_get_row(i, (h + 10), gFactionRankNames[i][h], mysql);

        for(new h = 0; h < MAX_FACTION_RANKS; h++)
            gFactionData[i][e_faction_skin][h]    = cache_get_row_int(i, (h + 11 + (MAX_FACTION_RANKS-1)), mysql);

        gCreatedFaction++;
	}
    printf("Number of factions loaded: %d", gCreatedFaction);
    return 1;
}

//------------------------------------------------------------------------------

hook OnGameModeInit()
{
    mysql_pquery(mysql, "SELECT * FROM `factions`", "OnFactionLoad");
    return 1;
}

//------------------------------------------------------------------------------

public OnInsertFaction(factionid)
{
    new index = cache_insert_id();
    gFactionData[factionid][e_faction_database_id] = index;
    gCreatedFaction++;

    printf("[mysql] inserted faction %d on database.", index);
}

//------------------------------------------------------------------------------

YCMD:afactioncmds(playerid, params[], help)
{
    if(!IsPlayerAdmin(playerid))
 		return SendClientMessage(playerid, COLOR_ERROR, "* Você precisa estar logado na RCON para isto.");

	SendClientMessage(playerid, COLOR_TITLE, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Comandos Facção - Banco de Dados ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");

    SendClientMessage(playerid, COLOR_SUB_TITLE, "* /factions - /insertfaction - /updatefaction - /deletefaction");

	SendClientMessage(playerid, COLOR_TITLE, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Comandos Facção - Banco de Dados ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	return 1;
}

//------------------------------------------------------------------------------

YCMD:factions(playerid, params[], help)
{
    if(!IsPlayerAdmin(playerid))
 		return SendClientMessage(playerid, COLOR_ERROR, "* Você precisa estar logado na RCON para isto.");

    SendClientMessage(playerid, COLOR_TITLE, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Facção - Banco de Dados ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
    for(new i = 0; i < MAX_FACTIONS; i++)
    {
        if(gFactionData[i][e_faction_database_id] == 0)
            continue;

        SendClientMessagef(playerid, COLOR_SUB_TITLE, "* ID: %i - DBID: %i - Nome: %s - Max Ranks: %i - Tipo: %i - Personalizada: %i",
        i, gFactionData[i][e_faction_database_id], gFactionData[i][e_faction_name], gFactionData[i][e_faction_max_ranks], gFactionData[i][e_faction_type], gFactionData[i][e_faction_custom]);
    }
	SendClientMessage(playerid, COLOR_TITLE, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Facção - Banco de Dados ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	return 1;
}

//------------------------------------------------------------------------------

YCMD:insertfaction(playerid, params[], help)
{
    if(!IsPlayerAdmin(playerid))
        return SendClientMessage(playerid, COLOR_ERROR, "* Você precisa estar logado na RCON para isto.");

    new fid = -1;
    for(new i = 0; i < MAX_FACTIONS; i++)
	{
        if(gFactionData[i][e_faction_database_id] != 0)
            continue;
        fid = i;
        break;
    }

    if(fid == -1)
        return SendClientMessage(playerid, COLOR_ERROR, "* O limite de facções foi atingido.");

    new Float:x, Float:y, Float:z, Float:a;
    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, a);

    gFactionData[fid][e_faction_spawn_x] = x;
    gFactionData[fid][e_faction_spawn_y] = y;
    gFactionData[fid][e_faction_spawn_z] = z;
    gFactionData[fid][e_faction_spawn_a] = a;

    SendClientMessagef(playerid, COLOR_ADMIN_ACTION, "* Você inseriu uma facção no banco de dados, fid: %d.", fid);

    new query[220];
    mysql_format(mysql, query, sizeof(query), "INSERT INTO `factions` (`spawn_x`, `spawn_y`, `spawn_z`, `spawn_a`) VALUES (%f, %f, %f, %f)", x, y, z, a);
    mysql_pquery(mysql, query, "OnInsertFaction", "i", fid);
    return 1;
}

//------------------------------------------------------------------------------

YCMD:updatefaction(playerid, params[], help)
{
    if(!IsPlayerAdmin(playerid))
        return SendClientMessage(playerid, COLOR_ERROR, "* Você precisa estar logado na RCON para isto.");

    new fid, option[12];
	if(sscanf(params, "is[12]S[128]", fid, option))
		SendClientMessage(playerid, COLOR_INFO, "* /updatefaction [id] [spawn - name - type - maxranks - custom - color - rankname - rankskin]");
    else if(fid < 0 || fid > MAX_FACTIONS-1)
        SendClientMessagef(playerid, COLOR_ERROR, "* Facção inválida, valores de 0 à %i.", MAX_FACTIONS);
    else if(gFactionData[fid][e_faction_database_id] == 0)
        SendClientMessage(playerid, COLOR_ERROR, "* Esta facção não existe.");
    else if(!strcmp(option, "spawn"))
    {
        new Float:x, Float:y, Float:z, Float:a;
        GetPlayerPos(playerid, x, y, z);
        GetPlayerFacingAngle(playerid, a);

        gFactionData[fid][e_faction_spawn_x]    = x;
        gFactionData[fid][e_faction_spawn_y]    = y;
        gFactionData[fid][e_faction_spawn_z]    = z;
        gFactionData[fid][e_faction_spawn_a]    = a;

        SendClientMessagef(playerid, COLOR_ADMIN_ACTION, "* Você alterou o spawn da facção %d.", fid);

        new query[210];
        mysql_format(mysql, query, sizeof(query), "UPDATE `factions` SET `spawn_x`=%f, `spawn_y`=%f, `spawn_z`=%f, `spawn_a`=%f WHERE `ID`=%d", x, y, z, a, gFactionData[fid][e_faction_database_id]);
        mysql_pquery(mysql, query);
    }
    else if(!strcmp(option, "name"))
    {
        new name[MAX_FACTION_NAME];
        if(sscanf(params, "is[8]s["#MAX_FACTION_NAME"]", fid, option, name))
            SendClientMessagef(playerid, COLOR_INFO, "* /updatefaction %i %s [nome]", fid, option);
        else
        {
            SendClientMessagef(playerid, COLOR_ADMIN_ACTION, "* Você alterou o nome da facção %s(ID: %i) para %s.", gFactionData[fid][e_faction_name], fid, name);
            format(gFactionData[fid][e_faction_name], MAX_FACTION_NAME, name);

            new query[128];
            mysql_format(mysql, query, sizeof(query), "UPDATE `factions` SET `name`='%s' WHERE `ID`=%d", name, gFactionData[fid][e_faction_database_id]);
            mysql_pquery(mysql, query);
        }
    }
    else if(!strcmp(option, "type"))
    {
        new type;
        if(sscanf(params, "is[8]i", fid, option, type))
            SendClientMessagef(playerid, COLOR_INFO, "* /updatefaction %i %s [tipo]", fid, option);
        else
        {
            gFactionData[fid][e_faction_type] = type;
            SendClientMessagef(playerid, COLOR_ADMIN_ACTION, "* Você alterou o tipo da facção %s(ID: %i) para %s(ID: %i).", gFactionData[fid][e_faction_name], fid, GetFactionTypeName(fid), type);

            new query[128];
            mysql_format(mysql, query, sizeof(query), "UPDATE `factions` SET `type`=%i WHERE `ID`=%d", type, gFactionData[fid][e_faction_database_id]);
            mysql_pquery(mysql, query);
        }
    }
    else if(!strcmp(option, "maxranks"))
    {
        new maxranks;
        if(sscanf(params, "is[8]i", fid, option, maxranks))
            SendClientMessagef(playerid, COLOR_INFO, "* /updatefaction %i %s [max. ranks]", fid, option);
        else
        {
            if(maxranks < 0 || maxranks > MAX_FACTION_RANKS)
                return SendClientMessagef(playerid, COLOR_ERROR, "* Apenas valores entre 0 e %i.", MAX_FACTION_RANKS);

            SendClientMessagef(playerid, COLOR_ADMIN_ACTION, "* Você alterou a quantia max. de ranks da facção %s(ID: %i) para %i.", gFactionData[fid][e_faction_name], fid, maxranks);
            gFactionData[fid][e_faction_max_ranks] = maxranks;

            new query[128];
            mysql_format(mysql, query, sizeof(query), "UPDATE `factions` SET `max_ranks`=%i WHERE `ID`=%d", maxranks, gFactionData[fid][e_faction_database_id]);
            mysql_pquery(mysql, query);
        }
    }
    else if(!strcmp(option, "custom"))
    {
        new custom;
        if(sscanf(params, "is[8]i", fid, option, custom))
            SendClientMessagef(playerid, COLOR_INFO, "* /updatefaction %i %s [custom]", fid, option);
        else
        {
            if(custom < 0 || custom > 1)
                return SendClientMessage(playerid, COLOR_ERROR, "* Apenas valores entre 0 e 1.");

            if(custom == 0)
                SendClientMessagef(playerid, COLOR_ADMIN_ACTION, "* Você definiu a facção %s(ID: %i) como personalizada.", gFactionData[fid][e_faction_name], fid);
            else
                SendClientMessagef(playerid, COLOR_ADMIN_ACTION, "* Você definiu a facção %s(ID: %i) como não-personalizada.", gFactionData[fid][e_faction_name], fid);
            gFactionData[fid][e_faction_custom] = custom;

            new query[128];
            mysql_format(mysql, query, sizeof(query), "UPDATE `factions` SET `custom`=%i WHERE `ID`=%d", custom, gFactionData[fid][e_faction_database_id]);
            mysql_pquery(mysql, query);
        }
    }
    else if(!strcmp(option, "color"))
    {
        new color;
        if(sscanf(params, "is[8]x", fid, option, color))
            SendClientMessagef(playerid, COLOR_INFO, "* /updatefaction %i %s [color]", fid, option);
        else
        {
            SendClientMessagef(playerid, COLOR_ADMIN_ACTION, "* Você definiu a cor da facção %s(ID: %i) para {%06x}%06x.", gFactionData[fid][e_faction_name], fid, color >>> 8, color);
            gFactionData[fid][e_faction_color] = color;

            new query[128];
            mysql_format(mysql, query, sizeof(query), "UPDATE `factions` SET `color`=%i WHERE `ID`=%d", color, gFactionData[fid][e_faction_database_id]);
            mysql_pquery(mysql, query);
        }
    }
    else if(!strcmp(option, "rankname"))
    {
        new rank, rankname[32];
        if(sscanf(params, "is[8]is[32]", fid, option, rank, rankname))
            SendClientMessagef(playerid, COLOR_INFO, "* /updatefaction %i %s [rankid] [rankname]", fid, option);
        else
        {
            if(rank < 0 || rank > gFactionData[fid][e_faction_max_ranks])
                return SendClientMessagef(playerid, COLOR_ERROR, "* Rank inválido. Essa facção tem ranks de 0 à %i.", gFactionData[fid][e_faction_max_ranks]);

            format(gFactionRankNames[fid][rank], 32, "%s", rankname);
            SendClientMessagef(playerid, COLOR_ADMIN_ACTION, "* Você definiu o nome do cargo %d da facção %s(ID: %i) para %s.", rank, gFactionData[fid][e_faction_name], fid, rankname);

            new query[128];
            mysql_format(mysql, query, sizeof(query), "UPDATE `factions` SET `rank_name_%i`='%s' WHERE `ID`=%d", rank, gFactionRankNames[fid][rank], gFactionData[fid][e_faction_database_id]);
            mysql_pquery(mysql, query);
        }
    }
    else if(!strcmp(option, "rankskin"))
    {
        new rank, rankskin;
        if(sscanf(params, "is[8]ii", fid, option, rank, rankskin))
            SendClientMessagef(playerid, COLOR_INFO, "* /updatefaction %i %s [rankid] [rankskin]", fid, option);
        else
        {
            if(rank < 0 || rank > gFactionData[fid][e_faction_max_ranks])
                return SendClientMessagef(playerid, COLOR_ERROR, "* Rank inválido. Essa facção tem ranks de 0 à %i.", gFactionData[fid][e_faction_max_ranks]);

            gFactionData[fid][e_faction_skin][rank] = rankskin;
            SendClientMessagef(playerid, COLOR_ADMIN_ACTION, "* Você definiu a skin do cargo %d da facção %s(ID: %i) para %i.", rank, gFactionData[fid][e_faction_name], fid, rankskin);

            new query[128];
            mysql_format(mysql, query, sizeof(query), "UPDATE `factions` SET `skin_%i`=%i WHERE `ID`=%d", rank, rankskin, gFactionData[fid][e_faction_database_id]);
            mysql_pquery(mysql, query);
        }
    }
    else SendClientMessage(playerid, COLOR_ERROR, "* Opção inválida.");
    return 1;
}

//------------------------------------------------------------------------------

YCMD:deletefaction(playerid, params[], help)
{
    if(!IsPlayerAdmin(playerid))
        return SendClientMessage(playerid, COLOR_ERROR, "* Você precisa estar logado na RCON para isto.");

    new fid;
	if(sscanf(params, "i", fid))
		SendClientMessage(playerid, COLOR_INFO, "* /deletefaction [id]");
    else if(fid < 0 || fid > MAX_FACTIONS-1)
        SendClientMessagef(playerid, COLOR_ERROR, "* Facção inválida, valores de 0 à %i.", MAX_FACTIONS);
    else if(gFactionData[fid][e_faction_database_id] == 0)
        SendClientMessage(playerid, COLOR_ERROR, "* Esta facção não existe.");
    else
    {
        SendClientMessagef(playerid, COLOR_ADMIN_ACTION, "* Você deletou a facção %d.", fid);

        new query[60];
        mysql_format(mysql, query, sizeof(query), "DELETE FROM `factions` WHERE `ID`=%d", gFactionData[fid][e_faction_database_id]);
        mysql_pquery(mysql, query);

        gFactionData[fid][e_faction_database_id] = 0;
    }
    return 1;
}

//------------------------------------------------------------------------------
