/*******************************************************************************
* FILENAME :        modules/faction/lspd.pwn
*
* DESCRIPTION :
*       Adds LSPD faction to the server.
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

YCMD:megafone(playerid, params[], help)
{
	if(GetFactionType(GetPlayerFactionID(playerid)) != FACTION_TYPE_POLICE)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

	if(!IsPlayerInAnyVehicle(playerid) || GetVehicleFactionID(GetPlayerVehicleID(playerid)) != GetPlayerFactionID(playerid))
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não está em um veículo da LSPD.");

	if(isnull(params))
	  return SendClientMessage(playerid, COLOR_INFO, "* /megafone [mensagem]");

    new message[208];
    foreach(new i: Player)
    {
        if(GetPlayerDistanceFromPlayer(playerid, i) < 40.0)
        {
        	format(message, sizeof(message), "* {D9E15A}Megafone{ffff00} %s %s: %s", GetFactionRankName(GetPlayerFactionID(playerid), GetPlayerFactionRankID(playerid)), GetPlayerNamef(playerid), params);
        	SendMultiMessage(i, 0xffff00ff, message);
        }
    }
	return 1;
}
