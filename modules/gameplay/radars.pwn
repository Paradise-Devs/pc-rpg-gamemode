/* *************************************************************************** *
*  Description: Radars file.
*
*  Assignment: A script that adds radars to the server.
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
* *************************************************************************** */

//------------------------------------------------------------------------------

#if defined _MODULE_radars
	#endinput
#endif
#define _MODULE_radars

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

/*
	OnGameModeInit
		Called when the server starts
*/
hook OnGameModeInit()
{
	CreateRadar(857.47510, -1389.90039, 12.56080,  0.00000, 0.00000, 270.00000,  200.0, 60.0);
	CreateRadar(1611.7036, -977.6210,   37.3305,   0.0000,  0.0000,  80.0000,    200.0, 60.0);
	CreateRadar(2917.0669, -1405.4592,  9.8472,    0.0000,  0.0000,  181.9199,   200.0, 80.0);
	CreateRadar(-132.1991, -1245.1445,  2.0132,    0.0000,  0.0000,  161.4780,   200.0, 80.0);
	CreateRadar(1622.6321, -1244.0808,  47.1722,   0.0000,  0.0000,  -186.0000,  200.0, 80.0);
}

public OnPlayerEnterRadar(playerid, radarid, Float:speed)
{
	if(GetVehicleCategory(GetPlayerVehicleID(playerid)) == VEHICLE_CATEGORY_BICYCLE)
		return 1;

	if(GetPlayerVehicleID(playerid) == g_p_EnabledDealershipVehicleID[playerid])
	{
		new i = g_p_EnabledDealershipVehicleKey[playerid];
		SendClientMessage(playerid, COLOR_TITLE, "~~~~~~~~~~~~~~~~~~~~ Radar ~~~~~~~~~~~~~~~~~~~~");
		SendClientMessage(playerid, -1, "* Uma {e65d06}multa{ffffff} por excesso de velocidade foi registrada ao seu veículo, vá pagar na prefeitura.");
		SendClientMessage(playerid, COLOR_TITLE, "~~~~~~~~~~~~~~~~~~~~ Radar ~~~~~~~~~~~~~~~~~~~~");
		g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_FINES] += 200;
	}
	else if(GetVehicleCategory(GetPlayerVehicleID(playerid)) != VEHICLE_CATEGORY_POLICE && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		SendClientMessage(playerid, COLOR_TITLE, "~~~~~~~~~~~~~~~~~~~~ Radar ~~~~~~~~~~~~~~~~~~~~");
		SendClientMessage(playerid, -1, "* Você foi pego por um radar acima da velocidade! Uma {e65d06}multa{ffffff} foi registrada a este veículo.");
		SendClientMessage(playerid, COLOR_TITLE, "~~~~~~~~~~~~~~~~~~~~ Radar ~~~~~~~~~~~~~~~~~~~~");
	}
	return 1;
}
