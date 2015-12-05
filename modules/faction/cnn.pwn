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

static g_CnnVehicles[5];

hook OnGameModeInit()
{
    g_CnnVehicles[0] = AddStaticVehicle(582, 1632.4592, -1364.8932, 17.5077, 90.0673, 41, 20);
    g_CnnVehicles[1] = AddStaticVehicle(582, 1632.6024, -1352.1423, 17.5072, 90.3681, 41, 20);
    g_CnnVehicles[2] = AddStaticVehicle(582, 1632.3887, -1339.8220, 17.5108, 90.0059, 41, 20);
    g_CnnVehicles[3] = AddStaticVehicle(582, 1632.8242, -1327.8719, 17.5126, 89.5518, 41, 20);
    g_CnnVehicles[4] = AddStaticVehicle(488, 1641.7244, -1322.1550, 17.6265, 89.0014, 41, 20);
    for(new i = 0; i < sizeof(g_CnnVehicles); i++)
        SetVehicleFuel(g_CnnVehicles[i], 100.0);
    return 1;
}

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    for(new i = 0; i < sizeof(g_CnnVehicles); i++)
    {
        if(vehicleid == g_CnnVehicles[i] && GetFactionType(GetPlayerFactionID(playerid)) != FACTION_TYPE_NEWS)
        {
            ClearAnimations(playerid);
            SendClientMessage(playerid, COLOR_ERROR, "* Você não é da CNN.");
        }
    }
    return 1;
}

IsCnnVehicle(vehicleid)
{
    for(new i = 0; i < sizeof(g_CnnVehicles); i++)
    {
        if(vehicleid == g_CnnVehicles[i])
            return true;
    }
    return false;
}

YCMD:noticia(playerid, params[], help)
{
	if(GetFactionType(GetPlayerFactionID(playerid)) != FACTION_TYPE_NEWS)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

	if(!IsPlayerInAnyVehicle(playerid) || !IsCnnVehicle(GetPlayerVehicleID(playerid)))
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não está em um veículo da CNN News.");

	if(isnull(params))
	  return SendClientMessage(playerid, COLOR_INFO, "* /noticia [mensagem]");

	new message[208];
	format(message, sizeof(message), "* {51792B}CNN News{75AD3E} Reporter {51792B}%s{75AD3E}: %s", GetPlayerNamef(playerid), params);
	SendMultiMessageToAll(0x75AD3EFF, message);
	return 1;
}
