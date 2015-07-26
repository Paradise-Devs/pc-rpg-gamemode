/*******************************************************************************
* FILENAME :        modules/data/player.pwn
*
* DESCRIPTION :
*       Saves and Loads all player data
*
* NOTES :
*       This file should only contain information about player's data.
*       This is not intended to handle player actions and such.
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
* AUTHOR :    Larceny           START DATE :    25 Jul 15
*
*/

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

forward OnWeaponsLoad(playerid);
forward OnAccountLoad(playerid);
forward OnAccountCheck(playerid);
forward OnAccountRegister(playerid);

//------------------------------------------------------------------------------

// enumaration of player's account data
enum e_player_adata
{
    e_player_database_id,
    e_player_password[MAX_PLAYER_PASSWORD],
    e_player_regdate,
    e_player_ip[16],
    e_player_lastlogin
}
static gPlayerAccountData[MAX_PLAYERS][e_player_adata];

//------------------------------------------------------------------------------

// enumaration of player's position data
enum e_player_pdata
{
    Float:e_player_x,
    Float:e_player_y,
    Float:e_player_z,
    Float:e_player_a,
    e_player_int,
    e_player_vw
}
static gPlayerPositionData[MAX_PLAYERS][e_player_pdata];

//------------------------------------------------------------------------------

// enumaration of player's character data
enum e_player_cdata
{
    e_player_skin,
    e_player_gender,
    Float:e_player_health,
    Float:e_player_armour
}
static gPlayerCharacterData[MAX_PLAYERS][e_player_cdata];

//------------------------------------------------------------------------------

// enumaration of player's weapon data
enum e_player_wdata
{
    e_player_weapon[13],
    e_player_ammo[13]
}
static gPlayerWeaponData[MAX_PLAYERS][e_player_wdata];

//------------------------------------------------------------------------------

// enumaration of player's states (max 32 states)
enum E_PLAYER_STATES (<<= 1)
{
    E_PLAYER_STATE_NONE,
    E_PLAYER_STATE_LOGGED = 1
}
static E_PLAYER_STATES:gPlayerStates[MAX_PLAYERS];

//------------------------------------------------------------------------------

// Getters & Setters

IsPlayerLogged(playerid)
{
    if(gPlayerStates[playerid] & E_PLAYER_STATE_LOGGED)
        return 1;
    return 0;
}

SetPlayerLogged(playerid, bool:status)
{
    if(!status)
        gPlayerStates[playerid] &= ~E_PLAYER_STATE_LOGGED;
    else
        gPlayerStates[playerid] |= E_PLAYER_STATE_LOGGED;
}


//------------------------------------------------------------------------------

ResetPlayerData(playerid)
{
    // Current Time
    new ct = gettime();

    // Reset all player status
    gPlayerStates[playerid] = E_PLAYER_STATE_NONE;

    gPlayerAccountData[playerid][e_player_database_id]  = 0;
    gPlayerAccountData[playerid][e_player_regdate]      = ct;
    gPlayerAccountData[playerid][e_player_lastlogin]    = ct;

    gPlayerPositionData[playerid][e_player_x]           = 1449.01;
    gPlayerPositionData[playerid][e_player_y]           = -2287.10;
    gPlayerPositionData[playerid][e_player_z]           = 13.54;
    gPlayerPositionData[playerid][e_player_a]           = 96.36;
    gPlayerPositionData[playerid][e_player_int]         = 0;
    gPlayerPositionData[playerid][e_player_vw]          = 0;

    gPlayerCharacterData[playerid][e_player_gender]     = 0;
    gPlayerCharacterData[playerid][e_player_skin]       = 299;
    gPlayerCharacterData[playerid][e_player_health]     = 100.0;
    gPlayerCharacterData[playerid][e_player_armour]     = 0.0;

    for (new i = 0; i < sizeof(gPlayerWeaponData[][]); i++)
        gPlayerWeaponData[playerid][e_player_weapon][i] = 0;
}

//------------------------------------------------------------------------------

LoadPlayerAccount(playerid)
{
    new query[57 + MAX_PLAYER_NAME + 1], playerName[MAX_PLAYER_NAME + 1];
    GetPlayerName(playerid, playerName, sizeof(playerName));
    mysql_format(mysql, query, sizeof(query),"SELECT * FROM `players` WHERE `username` = '%e' LIMIT 1", playerName);
    mysql_tquery(mysql, query, "OnAccountLoad", "i", playerid);
}

//------------------------------------------------------------------------------

LoadPlayerWeapons(playerid)
{
    new query[66];
    mysql_format(mysql, query, sizeof(query), "SELECT weaponid, ammo FROM player_weapons WHERE userid = %d;", gPlayerAccountData[playerid][e_player_database_id]);
    mysql_tquery(mysql, query, "OnWeaponsLoad", "i", playerid);
}

//------------------------------------------------------------------------------

SavePlayerAccount(playerid)
{
    if(!IsPlayerLogged(playerid))
        return 0;

    new Float:x, Float:y, Float:z, Float:a;
    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, a);

    new Float:health, Float:armour;
    GetPlayerHealth(playerid, health);
    GetPlayerArmour(playerid, armour);

    // Account saving
    new query[250];
	mysql_format(mysql, query, sizeof(query),
	"UPDATE `players` SET `x`=%.2f, `y`=%.2f, `z`=%.2f, `a`=%.2f, `interior`=%d, `virtual_world`=%d, `skin`=%d, `gender`=%d, `health`=%.2f, `armour`=%.2f, `ip`='%s', `last_login`=%d WHERE `id`=%d",
    x, y, z, a, GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid), GetPlayerSkin(playerid), gPlayerCharacterData[playerid][e_player_gender], health, armour, gPlayerAccountData[playerid][e_player_ip], gettime(), gPlayerAccountData[playerid][e_player_database_id]);
	mysql_tquery(mysql, query);

    // Weapon saving
    new weaponid, ammo;
    for(new i; i < 13; i++)
    {
    	GetPlayerWeaponData(playerid, i, weaponid, ammo);
    	if(!weaponid)
            continue;
    	mysql_format(mysql, query, sizeof(query), "INSERT INTO player_weapons VALUES (%d, %d, %d) ON DUPLICATE KEY UPDATE ammo = %d;", gPlayerAccountData[playerid][e_player_database_id], weaponid, ammo, ammo);
    	mysql_pquery(mysql, query);
    }
    return 1;
}

//------------------------------------------------------------------------------

public OnAccountRegister(playerid)
{
	gPlayerAccountData[playerid][e_player_database_id] = cache_insert_id();

    SetPlayerInterior(playerid, gPlayerPositionData[playerid][e_player_int]);
    SetPlayerVirtualWorld(playerid, gPlayerPositionData[playerid][e_player_vw]);
    SetSpawnInfo(playerid, 255, gPlayerCharacterData[playerid][e_player_skin], gPlayerPositionData[playerid][e_player_x], gPlayerPositionData[playerid][e_player_y], gPlayerPositionData[playerid][e_player_z], gPlayerPositionData[playerid][e_player_a], 0, 0, 0, 0, 0, 0);
    SpawnPlayer(playerid);

    new playerName[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playerName, sizeof(playerName));
	printf("[mysql] new account registered on database. ID: %d, Username: %s", gPlayerAccountData[playerid][e_player_database_id], playerName);
	return 1;
}

//------------------------------------------------------------------------------

public OnWeaponsLoad(playerid)
{
	new weaponid, ammo;
	for(new i, j = cache_get_row_count(mysql); i < j; i++)
	{
	    weaponid 	= cache_get_row_int(i, 0, mysql);
	    ammo    	= cache_get_row_int(i, 1, mysql);

		if(!(0 <= weaponid <= 46))
		{
			printf("[info] Warning: OnWeaponsLoad - Unknown weaponid '%d'. Skipping.", weaponid);
			continue;
		}

		GivePlayerWeapon(playerid, weaponid, ammo);
	}
	return;
}

//------------------------------------------------------------------------------

public OnAccountLoad(playerid)
{
	new rows, fields;
	cache_get_data(rows, fields, mysql);
	if(rows > 0)
	{
        // Loading...
        GetPlayerIp(playerid, gPlayerAccountData[playerid][e_player_ip], 16);
        gPlayerAccountData[playerid][e_player_lastlogin] = cache_get_field_content_int(0, "last_login", mysql);

        gPlayerPositionData[playerid][e_player_x]       = cache_get_field_content_float(0, "x", mysql);
        gPlayerPositionData[playerid][e_player_y]       = cache_get_field_content_float(0, "y", mysql);
        gPlayerPositionData[playerid][e_player_z]       = cache_get_field_content_float(0, "z", mysql);
        gPlayerPositionData[playerid][e_player_a]       = cache_get_field_content_float(0, "a", mysql);
        gPlayerPositionData[playerid][e_player_int]     = cache_get_field_content_int(0, "interior", mysql);
        gPlayerPositionData[playerid][e_player_vw]      = cache_get_field_content_int(0, "virtual_world", mysql);

        gPlayerCharacterData[playerid][e_player_health] = cache_get_field_content_float(0, "health", mysql);
        gPlayerCharacterData[playerid][e_player_armour] = cache_get_field_content_float(0, "armour", mysql);
        gPlayerCharacterData[playerid][e_player_skin]   = cache_get_field_content_int(0, "skin", mysql);
        gPlayerCharacterData[playerid][e_player_gender] = cache_get_field_content_int(0, "gender", mysql);

        // Setting...
        SetPlayerInterior(playerid, gPlayerPositionData[playerid][e_player_int]);
        SetPlayerVirtualWorld(playerid, gPlayerPositionData[playerid][e_player_vw]);
        SetSpawnInfo(playerid, 255, gPlayerCharacterData[playerid][e_player_skin], gPlayerPositionData[playerid][e_player_x], gPlayerPositionData[playerid][e_player_y], gPlayerPositionData[playerid][e_player_z], gPlayerPositionData[playerid][e_player_a], 0, 0, 0, 0, 0, 0);
        SpawnPlayer(playerid);

        SetPlayerHealth(playerid, gPlayerCharacterData[playerid][e_player_health]);
        SetPlayerArmour(playerid, gPlayerCharacterData[playerid][e_player_armour]);

        LoadPlayerWeapons(playerid);

        SetPlayerLogged(playerid, true);
    }
    return 1;
}

//------------------------------------------------------------------------------

public OnAccountCheck(playerid)
{
	new rows, fields;
	cache_get_data(rows, fields, mysql);
	if(rows > 0)
	{
		cache_get_field_content(0, "password", gPlayerAccountData[playerid][e_player_password], mysql, MAX_PLAYER_PASSWORD);
		gPlayerAccountData[playerid][e_player_database_id] = cache_get_field_content_int(0, "ID", mysql);

        inline Response(pid, dialogid, response, listitem, string:inputtext[])
        {
            #pragma unused pid, dialogid, listitem
            if(!response)
                Kick(playerid);
            else if(!strcmp(gPlayerAccountData[playerid][e_player_password], inputtext) && !isnull(gPlayerAccountData[playerid][e_player_password]) && !isnull(inputtext))
            {
                ClearPlayerScreen(playerid);
                SendClientMessage(playerid, 0x88aa62FF, "Conectado com sucesso!");
                PlayerPlaySound(playerid,1058,0.0,0.0,0.0);
                LoadPlayerAccount(playerid);
            }
            else
                Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_INPUT, "Conta Registrada->Senha Incorreta", "Senha incorreta!\nTente novamente:", "Conectar", "Sair"),
                PlayErrorSound(playerid);
        }
        new info[130];
        format(info, sizeof(info), "Bem-vindo de volta %s!\n\nSua conta já está registrada em nosso banco de dados.\nDigite sua senha para se conectar.", GetPlayerFirstName(playerid));
        Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_PASSWORD, "Conta Registrada", info, "Conectar", "Sair");
        PlaySelectSound(playerid);
	}
    else
    {
        inline Response(pid, dialogid, response, listitem, string:inputtext[])
        {
            #pragma unused pid, dialogid, listitem
            if(!response)
                Kick(playerid);
            else if(strlen(inputtext) < 6)
                Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_INPUT, "Conta Registrada->Senha muito curta", "Senha muito curta!\n\nSua senha precisa de pelo menos 6 characteres.\nTente novamente:", "Registrar", "Sair"),
                PlayErrorSound(playerid);
            else
            {
                SendClientMessage(playerid, 0x88aa62FF, "* Registrado com sucesso!");
                PlayerPlaySound(playerid,1058,0.0,0.0,0.0);
                SetPlayerLogged(playerid, true);

                new playerIP[16], playerName[MAX_PLAYER_NAME];
                GetPlayerName(playerid, playerName, sizeof(playerName));
                GetPlayerIp(playerid, playerIP, sizeof(playerIP));

                new query[250];
                mysql_format(mysql, query, sizeof(query), "INSERT INTO `players` (`username`, `password`, `ip`, `regdate`, `x`, `y`, `z`, `a`, `interior`, `virtual_world`) VALUES ('%e', '%e', '%s', %d, %.2f, %.2f, %.2f, %.2f, %d, %d)", playerName, inputtext, playerIP, gettime(), gPlayerPositionData[playerid][e_player_x], gPlayerPositionData[playerid][e_player_y], gPlayerPositionData[playerid][e_player_z], gPlayerPositionData[playerid][e_player_a], gPlayerPositionData[playerid][e_player_int], gPlayerPositionData[playerid][e_player_vw]);
            	mysql_tquery(mysql, query, "OnAccountRegister", "i", playerid);
            }
        }
        new info[130];
        format(info, sizeof(info), "Bem-vindo %s!\n\nSua conta não está registrada em nosso banco de dados.\nDigite sua senha para se registrar.", GetPlayerFirstName(playerid));
        Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_PASSWORD, "Conta Registrada", info, "Registrar", "Sair");
        PlaySelectSound(playerid);
    }
	SendClientMessage(playerid, 0x88aa62FF, "* Conectado com sucesso.");
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerRequestClass(playerid, classid)
{
    // Checks if the player account is registered
    new query[57 + MAX_PLAYER_NAME + 1], playerName[MAX_PLAYER_NAME + 1];
    GetPlayerName(playerid, playerName, sizeof(playerName));
    mysql_format(mysql, query, sizeof(query),"SELECT * FROM `players` WHERE `username` = '%e' LIMIT 1", playerName);
    mysql_tquery(mysql, query, "OnAccountCheck", "i", playerid);
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerRequestSpawn(playerid)
{
    if(!IsPlayerLogged(playerid))
    {
        SendClientMessage(playerid, COLOR_ERROR, "* Você não está conectado em sua conta.");
        return -1;
    }
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerConnect(playerid)
{
    SendClientMessage(playerid, 0xA9C4E4FF, "* Conectando ao banco de dados, por favor aguarde...");
    ResetPlayerData(playerid);
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerDisconnect(playerid, reason)
{
    SavePlayerAccount(playerid);
    SetPlayerLogged(playerid, false);
    return 1;
}

//------------------------------------------------------------------------------

hook OnGameModeInit()
{
    // Create player table if not exists
    print("Creating player tables if not exists.");
    mysql_pquery(mysql, "CREATE TABLE IF NOT EXISTS `players` (`ID` int(11) NOT NULL AUTO_INCREMENT, `username` VARCHAR(25), `password` VARCHAR(32), `ip` VARCHAR(16), `email` VARCHAR(128), `x` FLOAT, `y` FLOAT, `z` FLOAT, `a` FLOAT, `interior` INT(11), `virtual_world` INT(11), `health` FLOAT, `armour` FLOAT, `skin` INT(11), `last_login` INT(11), `regdate` INT(11), `gender` TINYINT(1), PRIMARY KEY (ID), KEY (ID)) ENGINE = InnoDB DEFAULT CHARSET = latin1 AUTO_INCREMENT = 1;");
    mysql_pquery(mysql, "CREATE TABLE IF NOT EXISTS `player_weapons` ( `userid` INT UNSIGNED NOT NULL , `weaponid` TINYINT UNSIGNED NOT NULL , `ammo` INT UNSIGNED NOT NULL) ENGINE = InnoDB;");
    return 1;
}
