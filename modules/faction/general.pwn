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

YCMD:ajudafaccao(playerid, params[], help)
{
	if(GetPlayerFactionID(playerid) == FACTION_NONE)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não pertence a uma organização.");

    SendClientMessage(playerid, COLOR_TITLE, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Comandos ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	SendClientMessage(playerid, COLOR_SUB_TITLE, "* /(r)adio");
    if(GetPlayerFactionID(playerid) == FACTION_TYPE_NEWS)
        SendClientMessage(playerid, COLOR_SUB_TITLE, "* /(n)oticia");
    else if(GetPlayerFactionID(playerid) == FACTION_TYPE_POLICE)
        SendClientMessage(playerid, COLOR_SUB_TITLE, "* /servico - /megafone - /prender - /ajustarpena - /libertar");
	SendClientMessage(playerid, COLOR_TITLE, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Comandos ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	return 1;
}
