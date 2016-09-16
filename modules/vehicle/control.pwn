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
            {
                if(GetVehicleCategory(vehicleid) == VEHICLE_CATEGORY_BICYCLE)
                {
                    SetVehicleParamsEx(vehicleid, VEHICLE_PARAMS_ON, lights, alarm, doors, bonnet, boot, objective);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_INFO, "* O motor deste veículo está desligado. Pressione {B9C9BF}~k~~VEHICLE_FIREWEAPON_ALT~{A9C4E4} ou digite {B9C9BF}/motor{A9C4E4}.");
                }
            }
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
    if(health <= 250.0)
        SendActionMessage(playerid, 15.0, "Motor danificado.");
    else if(GetVehicleFuel(vehicleid) <= 0.0)
        SendActionMessage(playerid, 15.0, "Sem combustível.");
    else if(IsPlayerFuelingVehicle(playerid))
        SendClientMessage(playerid, COLOR_ERROR, "* Você não pode ligar o motor agora.");
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

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys & KEY_ACTION)
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && !gIsPlayerStartingEngine[playerid] && !IsPlayerFuelingVehicle(playerid))
		{
            new engine, lights, alarm, doors, bonnet, boot, objective, vehicleid;
            vehicleid = GetPlayerVehicleID(playerid);
            GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
			if(engine == VEHICLE_PARAMS_OFF || engine == VEHICLE_PARAMS_UNSET)
			{
				SendClientActionMessage(playerid, 15.0, "gira a chave e tenta ligar o motor do veículo.");
				gIsPlayerStartingEngine[playerid] = true;
				defer OnVehicleStartEngine(vehicleid, playerid);
			}
		}
	}
	return 1;
}

//------------------------------------------------------------------------------

SetVehicleEngineState(vehicleid, set)
{
	new	engine, lights, alarm, doors, bonnet, boot, objective;
	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	SetVehicleParamsEx(vehicleid, set, lights, alarm, doors, bonnet, boot, objective);
}

//------------------------------------------------------------------------------

YCMD:janela(playerid, params[], help)
{
    if(!IsPlayerInAnyVehicle(playerid))
        SendClientMessage(playerid, COLOR_ERROR, "* Você não está em um veículo.");
    else if(GetVehicleCategory(GetPlayerVehicleID(playerid)) == VEHICLE_CATEGORY_BICYCLE)
        SendClientMessage(playerid, COLOR_ERROR, "* Este veículo não possui janela.");
    else
    {
        new driver, passenger, backleft, backright;
        new vehicleid = GetPlayerVehicleID(playerid);
        GetVehicleParamsCarWindows(vehicleid, driver, passenger, backleft, backright);

        switch(GetPlayerVehicleSeat(playerid))
        {
            case 0:
            {
                if(driver == -1 || driver == 1)
                {
                    SendClientActionMessage(playerid, 15.0, "abre a janela do motorista.");
                    SetVehicleParamsCarWindows(vehicleid, 0, passenger, backleft, backright);
                }
                else
                {
                    SendClientActionMessage(playerid, 15.0, "fecha a janela do motorista.");
                    SetVehicleParamsCarWindows(vehicleid, 1, passenger, backleft, backright);
                }
            }
            case 1:
            {
                if(passenger == -1 || passenger == 1)
                {
                    SendClientActionMessage(playerid, 15.0, "abre a janela do passageiro.");
                    SetVehicleParamsCarWindows(vehicleid, driver, 0, backleft, backright);
                }
                else
                {
                    SendClientActionMessage(playerid, 15.0, "fecha a janela do passageiro.");
                    SetVehicleParamsCarWindows(vehicleid, driver, 1, backleft, backright);
                }
            }
            case 2:
            {
                if(backleft == -1 || backleft == 1)
                {
                    SendClientActionMessage(playerid, 15.0, "abre a janela do passageiro.");
                    SetVehicleParamsCarWindows(vehicleid, driver, passenger, 0, backright);
                }
                else
                {
                    SendClientActionMessage(playerid, 15.0, "fecha a janela do passageiro.");
                    SetVehicleParamsCarWindows(vehicleid, driver, passenger, 1, backright);
                }
            }
            case 3:
            {
                if(backright == -1 || backright == 1)
                {
                    SendClientActionMessage(playerid, 15.0, "abre a janela do passageiro.");
                    SetVehicleParamsCarWindows(vehicleid, driver, passenger, backleft, 0);
                }
                else
                {
                    SendClientActionMessage(playerid, 15.0, "fecha a janela do passageiro.");
                    SetVehicleParamsCarWindows(vehicleid, driver, passenger, backleft, 1);
                }
            }
            default:
            {
                SendClientMessage(playerid, COLOR_ERROR, "* Você não pode abrir essa janela.");
            }
        }
    }
    return 1;
}

//------------------------------------------------------------------------------

YCMD:farol(playerid, params[], help)
{
    if(!IsPlayerInAnyVehicle(playerid))
        SendClientMessage(playerid, COLOR_ERROR, "* Você não está em um veículo.");
    else if(GetVehicleCategory(GetPlayerVehicleID(playerid)) == VEHICLE_CATEGORY_BICYCLE)
        SendClientMessage(playerid, COLOR_ERROR, "* Este veículo não possui farol.");
    else if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
        SendClientMessage(playerid, COLOR_ERROR, "* Você não é o motorista.");
    else
    {
        new engine, lights, alarm, doors, bonnet, boot, objective, vehicleid;
        vehicleid = GetPlayerVehicleID(playerid);
        GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

        if(lights == VEHICLE_PARAMS_OFF || lights == VEHICLE_PARAMS_UNSET)
        {
            SendClientActionMessage(playerid, 15.0, "liga o farol do veículo.");
            SetVehicleParamsEx(vehicleid, engine, VEHICLE_PARAMS_ON, alarm, doors, bonnet, boot, objective);
        }
        else
        {
            SendClientActionMessage(playerid, 15.0, "desliga o farol do veículo.");
            SetVehicleParamsEx(vehicleid, engine, VEHICLE_PARAMS_OFF, alarm, doors, bonnet, boot, objective);
        }
    }
    return 1;
}

//------------------------------------------------------------------------------

YCMD:motor(playerid, params[], help)
{
    if(!IsPlayerInAnyVehicle(playerid))
        SendClientMessage(playerid, COLOR_ERROR, "* Você não está em um veículo.");
    else if(GetVehicleCategory(GetPlayerVehicleID(playerid)) == VEHICLE_CATEGORY_BICYCLE)
        SendClientMessage(playerid, COLOR_ERROR, "* Este veículo não possui motor.");
    else if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
        SendClientMessage(playerid, COLOR_ERROR, "* Você não é o motorista.");
    else if(IsPlayerFuelingVehicle(playerid))
        SendClientMessage(playerid, COLOR_ERROR, "* Você não pode ligar o motor agora.");
    else if(gIsPlayerStartingEngine[playerid])
        SendClientMessage(playerid, COLOR_ERROR, "* Você já está dando partida no veículo.");
    else
    {
        new engine, lights, alarm, doors, bonnet, boot, objective, vehicleid;
        vehicleid = GetPlayerVehicleID(playerid);
        GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

        if(engine == VEHICLE_PARAMS_OFF || engine == VEHICLE_PARAMS_UNSET)
        {
            SendClientActionMessage(playerid, 15.0, "gira a chave e tenta ligar o motor do veículo.");
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
