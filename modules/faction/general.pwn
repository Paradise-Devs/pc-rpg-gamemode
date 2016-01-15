/*******************************************************************************
* FILENAME :        modules/faction/general.pwn
*
* DESCRIPTION :
*       Commands and functions related to ALL factions.
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

YCMD:radio(playerid, params[], help)
{
	if(GetPlayerFactionID(playerid) == FACTION_NONE)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não pertence a uma organização.");

	if(isnull(params))
	  return SendClientMessage(playerid, COLOR_INFO, "* /radio [mensagem]");

	SendPlayerFactionMessage(playerid, params);
	return 1;
}

//------------------------------------------------------------------------------

YCMD:departamento(playerid, params[], help)
{
	if(GetPlayerFactionID(playerid) == FACTION_NONE)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não pertence a uma organização.");

	if(isnull(params))
	  return SendClientMessage(playerid, COLOR_INFO, "* /departamento [mensagem]");

	SendPlayerFactionTypeMessage(playerid, params);
	return 1;
}

//------------------------------------------------------------------------------

YCMD:membros(playerid, params[], help)
{
	if(GetFactionType(GetPlayerFactionID(playerid)) == FACTION_NONE)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não é membro de uma facção.");

	new	string[128];
	SendClientMessage(playerid, COLOR_TITLE, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Membros ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	SendClientMessage(playerid, COLOR_TITLE, "- Membros da organização online:");
	foreach(new i: Player)
	{
		if(GetPlayerFactionID(i) == GetPlayerFactionID(playerid))
		{
			format(string, sizeof string, "[{b4b4b4}%s{ffffff}] {b4b4b4}%s{ffffff} - ID: {b4b4b4}%i", GetFactionRankName(GetPlayerFactionID(i), GetPlayerFactionRankID(i)), GetPlayerNamef(i), i);
			SendClientMessage(playerid, -1, string);
		}
	}
	SendClientMessage(playerid, COLOR_TITLE, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Membros ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	return 1;
}

//------------------------------------------------------------------------------

YCMD:ajudafaccao(playerid, params[], help)
{
	if(GetPlayerFactionID(playerid) == FACTION_NONE)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não pertence a uma organização.");

    SendClientMessage(playerid, COLOR_TITLE, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Comandos ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	SendClientMessage(playerid, COLOR_SUB_TITLE, "* /(r)adio - /membros - (/d)epartamento");
    if(GetPlayerFactionID(playerid) == FACTION_TYPE_NEWS)
        SendClientMessage(playerid, COLOR_SUB_TITLE, "* /(n)oticia");
    else if(GetPlayerFactionID(playerid) == FACTION_TYPE_POLICE)
        SendClientMessage(playerid, COLOR_SUB_TITLE, "* /servico - /megafone - /prender - /ajustarpena - /libertar - /algemar - /desalgemar");
	SendClientMessage(playerid, COLOR_TITLE, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Comandos ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	return 1;
}
