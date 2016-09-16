/* *************************************************************************** *
*  Description: Bike rentable file.
*
*  Assignment: A script that adds bikes to be rentable.
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
* *************************************************************************** */

//------------------------------------------------------------------------------

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

static const BIKE_PRICE = 10;
static g_PlayerBikeID[MAX_PLAYERS] = {INVALID_VEHICLE_ID, ...};
static const Float:g_HospitalBikeSpawns[][] =
{
    { 1184.6436, -1339.9574, 13.0959, 270.0 },
    { 1184.6436, -1338.3022, 13.0959, 270.0 },
    { 1184.6436, -1336.9435, 13.0959, 270.0 },
    { 1184.6436, -1335.2635, 13.0959, 270.0 }
};

//------------------------------------------------------------------------------

hook OnGameModeInit()
{
    new string[54];
    format(string, sizeof(string), "Aluguel de Bikes - $%s\nDigite {1add69}/alugarbike", formatnumber(BIKE_PRICE));
    CreateDynamicPickup(1239, 1, 1506.6146, -1747.4388, 13.5469, 0, 0, -1, MAX_PICKUP_RANGE);
	CreateDynamic3DTextLabel(string, 0xFFFFFFFF, 1506.6146, -1747.4388, 13.5469, MAX_TEXT3D_RANGE, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerDisconnect(playerid, reason)
{
    if(g_PlayerBikeID[playerid] != INVALID_VEHICLE_ID)
    {
        DestroyVehicle(g_PlayerBikeID[playerid]);
        g_PlayerBikeID[playerid] = INVALID_VEHICLE_ID;
    }
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerDeath(playerid, killerid, reason)
{
    if(g_PlayerBikeID[playerid] != INVALID_VEHICLE_ID)
    {
        new rand = random(sizeof(g_HospitalBikeSpawns));
        SetVehiclePos(g_PlayerBikeID[playerid], g_HospitalBikeSpawns[rand][0], g_HospitalBikeSpawns[rand][1], g_HospitalBikeSpawns[rand][2]);
        SetVehicleZAngle(g_PlayerBikeID[playerid], g_HospitalBikeSpawns[rand][3]);
        SendClientMessage(playerid, COLOR_WARNING, "* Sua bicicleta alugada foi levada para o hospital para sua comodidade.");
    }
    return 1;
}

//------------------------------------------------------------------------------

hook OnVehicleStreamIn(vehicleid, forplayerid)
{
    foreach(new i: Player)
    {
        if(vehicleid == g_PlayerBikeID[i] && forplayerid != i)
        {
            SetVehicleParamsForPlayer(vehicleid, forplayerid, 0, 1);
        }
    }
    return 1;
}

//------------------------------------------------------------------------------

YCMD:alugarbike(playerid, params[], help)
{
    if(IsPlayerInRangeOfPoint(playerid, 15.0, 1506.6146, -1747.4388, 13.5469))
    {
        if(GetPlayerCash(playerid) < BIKE_PRICE)
        {
            SendClientMessage(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiente.");
            if(GetPlayerFirstTime(playerid, FIRST_TIME_CITY_HALL) == false)
            {
                SendClientMessage(playerid, COLOR_INFO, "* Vá até a prefeitura ao lado para começar.");
            }
            return 1;
        }

        if(g_PlayerBikeID[playerid] != INVALID_VEHICLE_ID)
        {
            DestroyVehicle(g_PlayerBikeID[playerid]);
        }
        g_PlayerBikeID[playerid] = CreateVehicle(510, 1509.7189, -1748.4604, 13.0584, 358.6010, -1, -1, -1);
        SetVehicleFuel(g_PlayerBikeID[playerid], 100.0);
        foreach(new i: Player)
        {
            if(playerid != i)
            {
                SetVehicleParamsForPlayer(g_PlayerBikeID[i], playerid, 0, 1);
            }
        }
        GivePlayerCash(playerid, -BIKE_PRICE);
        SendClientMessage(playerid, COLOR_SUCCESS, "* Você alugou uma bicicleta!");
    }
    else
    {
        SendClientMessage(playerid, COLOR_ERROR, "* Você não está no local de aluguel de bicicletas.");
    }
    return 1;
}
