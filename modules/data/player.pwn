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
*/

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

#define         START_X         1449.01
#define         START_Y         -2287.10
#define         START_Z         13.54
#define         START_A         96.36
#define         START_INT       0
#define         START_VW        0
#define         START_SKIN      0

//------------------------------------------------------------------------------

forward OnWeaponsLoad(playerid);
forward OnAccountLoad(playerid);
forward OnAccountCheck(playerid);
forward OnAccountRegister(playerid);

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
    mysql_format(mysql, query, sizeof(query), "SELECT weaponid, ammo FROM player_weapons WHERE userid = %d;", GetPlayerDatabaseID(playerid));
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
    new query[650];
	mysql_format(mysql, query, sizeof(query),
	"UPDATE `players` SET \
    `x`=%.2f, `y`=%.2f, `z`=%.2f, `a`=%.2f, `interior`=%d, `virtual_world`=%d, \
    `rank`=%d, `skin`=%d, `faction`=%d, `faction_rank`=%d, \
    `gender`=%d, `money`=%d, \
    `hospital`=%d, `health`=%.2f, `armour`=%.2f, \
    `ip`='%s', `last_login`=%d, \
    `achievements`=%d, `ticket`=%d, \
    `jobid`=%d, `jobxp`=%d, `joblv`=%d, \
    `ftime`=%d, \
    `phone_number`=%d, `phone_network`=%d, `phone_credits`=%d, `phone_state`=%d, \
    `hunger`=%.3f, `thirst`=%.3f, `sleep`=%.3f, `addiction`=%.3f \
    WHERE `id`=%d",
    x, y, z, a, GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid),
    GetPlayerRankVar(playerid), GetPlayerSkin(playerid), GetPlayerFactionID(playerid), GetPlayerFactionRank(playerid),
    GetPlayerGender(playerid), GetPlayerCash(playerid),
    GetPlayerHospitalTime(playerid), health, armour,
    GetPlayerIPf(playerid), gettime(),
    GetPlayerAchievements(playerid), GetPlayerLotteryTicket(playerid),
    _:GetPlayerJobID(playerid), GetPlayerJobXP(playerid), GetPlayerJobLV(playerid),
    GetPlayerFirstTimeVar(playerid),
    GetPlayerPhoneNumber(playerid), GetPlayerPhoneNetwork(playerid), GetPlayerPhoneCredit(playerid), GetPlayerPhoneState(playerid),
    GetPlayerHunger(playerid), GetPlayerThirst(playerid), GetPlayerSleep(playerid), GetPlayerAddiction(playerid),
    GetPlayerDatabaseID(playerid));

	mysql_pquery(mysql, query);

    // Weapon saving
    new weaponid, ammo;
    for(new i; i < 13; i++)
    {
    	GetPlayerWeaponData(playerid, i, weaponid, ammo);

    	if(!weaponid)
            continue;

    	mysql_format(mysql, query, sizeof(query), "INSERT INTO player_weapons VALUES (%d, %d, %d) ON DUPLICATE KEY UPDATE ammo = %d;", GetPlayerDatabaseID(playerid), weaponid, ammo, ammo);
    	mysql_pquery(mysql, query);
    }
    return 1;
}

//------------------------------------------------------------------------------

public OnAccountRegister(playerid)
{
    SetPlayerDatabaseID(playerid,cache_insert_id());

    SetPlayerColor(playerid, 0xFFFFFFFF);
    SetPlayerInterior(playerid, START_INT);
    SetPlayerVirtualWorld(playerid, START_VW);
    SetSpawnInfo(playerid, 255, START_SKIN, START_X, START_Y, START_Z, START_A, 0, 0, 0, 0, 0, 0);
    ShowTutorialForPlayer(playerid);

    new playerName[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playerName, sizeof(playerName));
	printf("[mysql] new account registered on database. ID: %d, Username: %s", GetPlayerDatabaseID(playerid), playerName);
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
        new Float:x = cache_get_field_content_float(0, "x", mysql);
        new Float:y = cache_get_field_content_float(0, "y", mysql);
        new Float:z = cache_get_field_content_float(0, "z", mysql);
        new Float:a = cache_get_field_content_float(0, "a", mysql);
        SetSpawnInfo(playerid, 255, cache_get_field_content_int(0, "skin", mysql), x, y, z, a, 0, 0, 0, 0, 0, 0);

        SpawnPlayer(playerid);

        SetPlayerIP(playerid, GetPlayerIPf(playerid));
        SetPlayerLastLogin(playerid, cache_get_field_content_int(0, "last_login", mysql));

        SetPlayerInterior(playerid, cache_get_field_content_int(0, "interior", mysql));
        SetPlayerVirtualWorld(playerid, cache_get_field_content_int(0, "virtual_world", mysql));

        SetPlayerHealth(playerid, cache_get_field_content_float(0, "health", mysql));
        SetPlayerArmour(playerid, cache_get_field_content_float(0, "armour", mysql));
        SetPlayerFaction(playerid, cache_get_field_content_int(0, "faction", mysql));
        SetPlayerFactionRank(playerid, cache_get_field_content_int(0, "faction_rank", mysql));
        SetPlayerGender(playerid, cache_get_field_content_int(0, "gender", mysql));
        SetPlayerCash(playerid, cache_get_field_content_int(0, "money", mysql));
        SetPlayerLotteryTicket(playerid, cache_get_field_content_int(0, "ticket", mysql));
        SetPlayerJobID(playerid, Job:cache_get_field_content_int(0, "jobid", mysql));
        SetPlayerJobXP(playerid, cache_get_field_content_int(0, "jobxp", mysql));
        SetPlayerJobLV(playerid,cache_get_field_content_int(0, "joblv", mysql ));
        SetPlayerHunger(playerid, cache_get_field_content_float(0, "hunger"));
    	SetPlayerThirst(playerid, cache_get_field_content_float(0, "thirst"));
    	SetPlayerSleep(playerid, cache_get_field_content_float(0, "sleep"));
    	SetPlayerAddiction(playerid, cache_get_field_content_float(0, "addiction"));
        LoadPlayerWeapons(playerid);

        SetPlayerPhoneNumber(playerid, cache_get_field_content_int(0, "phone_number"));
        SetPlayerPhoneNetwork(playerid, cache_get_field_content_int(0, "phone_network"));
        SetPlayerPhoneCredit(playerid, cache_get_field_content_int(0, "phone_credits"));
        SetPlayerPhoneState(playerid, cache_get_field_content_int(0, "phone_state"));

        SetPlayerHospitalTime(playerid, cache_get_field_content_int(0, "hospital", mysql));
        SetPlayerAchievements(playerid, cache_get_field_content_int(0, "achievements", mysql));
        SetPlayerRankVar(playerid, cache_get_field_content_int(0, "rank", mysql));
        SetPlayerFirstTimeVar(playerid, cache_get_field_content_int(0, "ftime", mysql));

        LoadPlayerPets(playerid);

        SetPlayerColor(playerid, 0xFFFFFFFF);
        SetPlayerLogged(playerid, true);
    }
    return 1;
}

//------------------------------------------------------------------------------

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch(dialogid)
    {
        case DIALOG_LOGIN:
        {
            if(!response)
                return Kick(playerid);

            new playerPass[MAX_PLAYER_PASSWORD];
            format(playerPass, MAX_PLAYER_PASSWORD, "%s", GetPlayerPassword(playerid));

            if(!strcmp(playerPass, inputtext) && !isnull(playerPass) && !isnull(inputtext))
            {
                ClearPlayerScreen(playerid);
                SendClientMessage(playerid, COLOR_SUCCESS, "Conectado com sucesso!");
                PlayConfirmSound(playerid);
                LoadPlayerAccount(playerid);
            } else
            {
                ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_INPUT, "Conta Registrada->Senha Incorreta", "Senha incorreta!\nTente novamente:", "Conectar", "Sair"),
                PlayErrorSound(playerid);
            }
            return -2;
        }
        case DIALOG_REGISTER:
        {
            if(!response)
                Kick(playerid);
            else if(strlen(inputtext) < 6)
                ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_INPUT, "Conta Registrada->Senha muito curta", "Senha muito curta!\n\nSua senha precisa de pelo menos 6 characteres.\nTente novamente:", "Registrar", "Sair"),
                PlayErrorSound(playerid);
            else if(strlen(inputtext) > MAX_PLAYER_PASSWORD-1)
                ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_INPUT, "Conta Registrada->Senha muito longa", "Senha muito longa!\n\nSua senha pode no máximo ter 30 characteres.\nTente novamente:", "Registrar", "Sair"),
                PlayErrorSound(playerid);
            else
            {
                SendClientMessage(playerid, COLOR_SUCCESS, "* Registrado com sucesso!");
                PlayConfirmSound(playerid);
                SetPlayerLogged(playerid, true);

                new playerIP[16], playerName[MAX_PLAYER_NAME];
                GetPlayerName(playerid, playerName, sizeof(playerName));
                GetPlayerIp(playerid, playerIP, sizeof(playerIP));

                new Float:playerPos[4];
                GetPlayerPos(playerid, playerPos[0], playerPos[1], playerPos[2]);
                GetPlayerFacingAngle(playerid, playerPos[3]);
                new playerInt = GetPlayerInterior(playerid);
                new playerVW = GetPlayerVirtualWorld(playerid);

                new query[250];
                mysql_format(mysql, query, sizeof(query), "INSERT INTO `players` (`username`, `password`, `ip`, `regdate`, `x`, `y`, `z`, `a`, `interior`, `virtual_world`) VALUES ('%e', '%e', '%s', %d, %.2f, %.2f, %.2f, %.2f, %d, %d)", playerName, inputtext, playerIP, gettime(), playerPos[0], playerPos[1], playerPos[2], playerPos[3], playerInt, playerVW);
            	mysql_tquery(mysql, query, "OnAccountRegister", "i", playerid);
            }
            return -2;
        }
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
        new password[MAX_PLAYER_PASSWORD];
        cache_get_field_content(0, "password", password, mysql, MAX_PLAYER_PASSWORD);
        SetPlayerPassword(playerid, password);
        SetPlayerDatabaseID(playerid, cache_get_field_content_int(0, "ID", mysql));

        new info[130];
        format(info, sizeof(info), "Bem-vindo de volta %s!\n\nSua conta já está registrada em nosso banco de dados.\nDigite sua senha para se conectar.", GetPlayerFirstName(playerid));
        ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Conta Registrada", info, "Conectar", "Sair");
        PlaySelectSound(playerid);
	}
    else
    {
        new info[130];
        format(info, sizeof(info), "Bem-vindo %s!\n\nSua conta não está registrada em nosso banco de dados.\nDigite sua senha para se registrar.", GetPlayerFirstName(playerid));
        ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_INPUT, "Conta Registrada", info, "Registrar", "Sair");
        PlaySelectSound(playerid);
    }
	SendClientMessage(playerid, COLOR_SUCCESS, "Conectado.");
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

hook OnPlayerSpawn(playerid)
{
    SetPlayerCash(playerid, GetPlayerCash(playerid));
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
    SetPlayerColor(playerid, 0xacacacff);
    ClearPlayerScreen(playerid);
    SendClientMessage(playerid, COLOR_INFO, "Conectando ao banco de dados, por favor aguarde...");
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
