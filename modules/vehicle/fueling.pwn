/*******************************************************************************
* FILENAME :        modules/vehicle/fueling.pwn
*
* DESCRIPTION :
*       Allow players to fill their vehicles at gas stations.
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

static bool:gplIsFilling[MAX_PLAYERS] = {false, ...};
static Timer:gplFillingT[MAX_PLAYERS] = {Timer:-1, ...};

static const Float:GAS_STATIONS_POSITIONS[][] =
{
    {1941.8073, -1773.5177, 13.2038},
    {1004.0186, -937.0354,  42.6213},
    {-91.0113,  -1169.1147, 2.21740}
};

//------------------------------------------------------------------------------

IsPlayerFuelingVehicle(playerid)
{
    return gplIsFilling[playerid];
}

//------------------------------------------------------------------------------

bool:IsPlayerAtGasStation(playerid)
{
    for(new i = 0; i < sizeof(GAS_STATIONS_POSITIONS); i++)
    {
        if(IsPlayerInRangeOfPoint(playerid, 10.0, GAS_STATIONS_POSITIONS[i][0], GAS_STATIONS_POSITIONS[i][1], GAS_STATIONS_POSITIONS[i][2]))
            return true;
    }
    return false;
}

//------------------------------------------------------------------------------

hook OnPlayerDisconnect(playerid, reason)
{
    if(gplIsFilling[playerid])
    {
        stop gplFillingT[playerid];
        gplFillingT[playerid] = Timer:-1;
        gplIsFilling[playerid] = false;
    }
    return 1;
}

//------------------------------------------------------------------------------

timer OnRefuelVehicle[100](playerid)
{
    if(GetPlayerCash(playerid) < FUEL_PRICE)
    {
        stop gplFillingT[playerid];
        gplFillingT[playerid] = Timer:-1;
        gplIsFilling[playerid] = false;
        SendClientMessage(playerid, COLOR_ERROR, "* Você não tem mais dinheiro.");
        return 1;
    }

    new vehicleid = GetPlayerVehicleID(playerid);
    SetVehicleFuel(vehicleid, GetVehicleFuel(vehicleid) + 0.2);
    GivePlayerCash(playerid, -FUEL_PRICE);

    if(GetVehicleFuel(vehicleid) >= 100.0)
    {
        stop gplFillingT[playerid];
        gplFillingT[playerid] = Timer:-1;
        gplIsFilling[playerid] = false;
    }
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
    switch(oldstate)
    {
        case PLAYER_STATE_DRIVER:
        {
            if(gplIsFilling[playerid])
            {
                stop gplFillingT[playerid];
                gplFillingT[playerid] = Timer:-1;
                gplIsFilling[playerid] = false;
            }
        }
    }
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(newkeys == KEY_YES)
    {
        if(IsPlayerAtGasStation(playerid))
        {
            if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
                SendClientMessage(playerid, COLOR_ERROR, "* Você precisa ser o motorista.");

            else if(GetVehicleFuel(GetPlayerVehicleID(playerid)) >= 100.0)
                SendClientMessage(playerid, COLOR_ERROR, "* O tanque deste veículo está cheio.");

            else
            {
                new engine, lights, alarm, doors, bonnet, boot, objective;
                GetVehicleParamsEx(GetPlayerVehicleID(playerid), engine, lights, alarm, doors, bonnet, boot, objective);
                if(GetPlayerCash(playerid) < FUEL_PRICE)
                    SendClientMessage(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiente.");
                else if(engine == VEHICLE_PARAMS_ON)
                    SendClientMessage(playerid, COLOR_ERROR, "* O motor do veículo precisa estar desligado.");
                else
                {
                    SendClientMessage(playerid, COLOR_TITLE, "* Abastecendo veículo...");
                    SendClientMessage(playerid, COLOR_SUB_TITLE, "* Para parar, solte Y.");

                    gplIsFilling[playerid] = true;
                    gplFillingT[playerid] = repeat OnRefuelVehicle(playerid);
                }
            }
        }
    }
    else if((((newkeys & (KEY_YES)) != (KEY_YES)) && ((oldkeys & (KEY_YES)) == (KEY_YES))))
    {
        if(gplIsFilling[playerid] == false)
            return 1;

        stop gplFillingT[playerid];
        gplFillingT[playerid] = Timer:-1;
        gplIsFilling[playerid] = false;
    }
    return 1;
}

//------------------------------------------------------------------------------

hook OnGameModeInit()
{
    for(new i = 0; i < sizeof(GAS_STATIONS_POSITIONS); i++)
    {
        CreateDynamic3DTextLabel("Abastecer\nSegure {1add69}Y", 0xFFFFFFFF, GAS_STATIONS_POSITIONS[i][0], GAS_STATIONS_POSITIONS[i][1], GAS_STATIONS_POSITIONS[i][2], MAX_TEXT3D_RANGE);
    }
    return 1;
}
