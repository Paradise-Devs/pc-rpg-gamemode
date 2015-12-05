/*******************************************************************************
* FILENAME :        modules/faction/cnn.pwn
*
* DESCRIPTION :
*       Adds cnn faction to the server.
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

YCMD:noticia(playerid, params[], help)
{
	if(GetFactionType(GetPlayerFactionID(playerid)) != FACTION_TYPE_NEWS)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

	if(!IsPlayerInAnyVehicle(playerid) || GetVehicleFactionID(GetPlayerVehicleID(playerid)) != GetPlayerFactionID(playerid))
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não está em um veículo da CNN News.");

	if(isnull(params))
	  return SendClientMessage(playerid, COLOR_INFO, "* /noticia [mensagem]");

	new message[208];
	format(message, sizeof(message), "* {51792B}CNN News{75AD3E} Reporter {51792B}%s{75AD3E}: %s", GetPlayerNamef(playerid), params);
	SendMultiMessageToAll(0x75AD3EFF, message);
	return 1;
}
