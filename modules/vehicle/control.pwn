/*******************************************************************************
* FILENAME :        modules/vehicle/control.pwn
*
* DESCRIPTION :
*       Handles all vehicle control functions and commands
*
* NOTES :
*       This file should only contain information about vehicle control.
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
* AUTHOR :    Larceny           START DATE :    25 Jul 15
*
*/

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

static bool:gIsPlayerStartingEngine[MAX_PLAYERS];

//------------------------------------------------------------------------------

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
    switch(newstate)
    {
        case PLAYER_STATE_DRIVER:
        {
            new engine, lights, alarm, doors, bonnet, boot, objective, vehicleid;
            vehicleid = GetPlayerVehicleID(playerid);
            GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

            if(engine == VEHICLE_PARAMS_OFF || engine == VEHICLE_PARAMS_UNSET)
                SendClientMessage(playerid, COLOR_INFO, "* O motor deste veículo está desligado. Pressione {B9C9BF}~k~~VEHICLE_FIREWEAPON_ALT~{A9C4E4} ou digite {B9C9BF}/motor{A9C4E4}.");
        }
    }
    return 1;
}

//------------------------------------------------------------------------------

timer OnVehicleStartEngine[2000](vehicleid, playerid)
{
    gIsPlayerStartingEngine[playerid] = false;
    if(!IsPlayerInVehicle(playerid, vehicleid))
        return 1;

    new Float:health;
    GetVehicleHealth(vehicleid, health);
    if(health < 350.0)
        SendActionMessage(playerid, 15.0, "Motor danificado.");
    else if(GetVehicleFuel(vehicleid) <= 0.0)
        SendActionMessage(playerid, 15.0, "Sem combustível.");
    else
    {
        new rand = random(7);
        if((health - (rand*100)) < 100)
            SendActionMessage(playerid, 15.0, "Motor falhou.");
        else
        {
            new engine, lights, alarm, doors, bonnet, boot, objective;
            GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
            SetVehicleParamsEx(vehicleid, VEHICLE_PARAMS_ON, lights, alarm, doors, bonnet, boot, objective);
            SendClientActionMessage(playerid, 15.0, "liga o motor do veículo.");
        }
    }
    return 1;
}

//------------------------------------------------------------------------------

YCMD:motor(playerid, params[], help)
{
    if(!IsPlayerInAnyVehicle(playerid))
        SendClientMessage(playerid, COLOR_ERROR, "* Você não está em um veículo.");
    else if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
        SendClientMessage(playerid, COLOR_ERROR, "* Você não é o motorista.");
    else if(gIsPlayerStartingEngine[playerid])
        SendClientMessage(playerid, COLOR_ERROR, "* Você já está dando partida no veículo.");
    else
    {
        new engine, lights, alarm, doors, bonnet, boot, objective, vehicleid;
        vehicleid = GetPlayerVehicleID(playerid);
        GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

        if(engine == VEHICLE_PARAMS_OFF || engine == VEHICLE_PARAMS_UNSET)
        {
            SendClientActionMessage(playerid, 15.0, "tenta ligar o motor do veículo.");
            gIsPlayerStartingEngine[playerid] = true;
            defer OnVehicleStartEngine(vehicleid, playerid);
        }
        else
        {
            SendClientActionMessage(playerid, 15.0, "desliga o motor do veículo.");
            SetVehicleParamsEx(vehicleid, VEHICLE_PARAMS_OFF, lights, alarm, doors, bonnet, boot, objective);
        }
    }
    return 1;
}
