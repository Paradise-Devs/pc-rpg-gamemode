/*******************************************************************************
* FILENAME :        modules/data/vehicle.pwn
*
* DESCRIPTION :
*       Saves and Loads vehicles data.
*
* NOTES :
*       This file should only contain information about vehicles's data.
*       This is not intended to handle player vehicles, factions and such.
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

forward OnVehicleLoad();
forward OnInsertVehicle(vehicleid);

//------------------------------------------------------------------------------

// enumaration of vehicle's data
enum e_vehicle_data
{
    //db
    e_vehicle_db,

    // info
    e_vehicle_model,
    e_vehicle_color_1,
    e_vehicle_color_2,
    e_vehicle_siren,

    // position
    Float:e_vehicle_x,
    Float:e_vehicle_y,
    Float:e_vehicle_z,
    Float:e_vehicle_a,

    // values
    Float:e_vehicle_fuel,
    Float:e_vehicle_health,

    // ids
    e_vehicle_factionid,
    e_vehicle_jobid,
    e_vehicle_locked,
    e_vehicle_id
}
static gVehicleData[MAX_VEHICLES][e_vehicle_data];
static gCreatedVehicles;

//------------------------------------------------------------------------------

Float:GetVehicleFuel(vehicleid)
    return gVehicleData[vehicleid][e_vehicle_fuel];

SetVehicleFuel(vehicleid, Float:value)
    gVehicleData[vehicleid][e_vehicle_fuel] = value;

//------------------------------------------------------------------------------

GetVehicleFactionID(vehicleid)
    return gVehicleData[vehicleid][e_vehicle_factionid];

//------------------------------------------------------------------------------

public OnVehicleLoad()
{
    for(new i, j = cache_get_row_count(mysql); i < j; i++)
	{
		gVehicleData[i][e_vehicle_db]        = cache_get_row_int(i, 0, mysql);

        gVehicleData[i][e_vehicle_model]     = cache_get_row_int(i, 1, mysql);
		gVehicleData[i][e_vehicle_color_1]   = cache_get_row_int(i, 2, mysql);
		gVehicleData[i][e_vehicle_color_2]   = cache_get_row_int(i, 3, mysql);
		gVehicleData[i][e_vehicle_siren]     = cache_get_row_int(i, 4, mysql);

        gVehicleData[i][e_vehicle_x]         = cache_get_row_float(i, 5, mysql);
		gVehicleData[i][e_vehicle_y]         = cache_get_row_float(i, 6, mysql);
		gVehicleData[i][e_vehicle_z]         = cache_get_row_float(i, 7, mysql);
		gVehicleData[i][e_vehicle_a]         = cache_get_row_float(i, 8, mysql);

        gVehicleData[i][e_vehicle_fuel]      = cache_get_row_float(i, 9, mysql);
		gVehicleData[i][e_vehicle_health]    = cache_get_row_float(i, 10, mysql);

        gVehicleData[i][e_vehicle_factionid]   = cache_get_row_int(i, 11, mysql);
        gVehicleData[i][e_vehicle_jobid]       = cache_get_row_int(i, 12, mysql);
        gVehicleData[i][e_vehicle_locked]      = cache_get_row_int(i, 13, mysql);

        gVehicleData[i][e_vehicle_id]        = CreateVehicle(gVehicleData[i][e_vehicle_model], gVehicleData[i][e_vehicle_x], gVehicleData[i][e_vehicle_y], gVehicleData[i][e_vehicle_z], gVehicleData[i][e_vehicle_a], gVehicleData[i][e_vehicle_color_1], gVehicleData[i][e_vehicle_color_2], -1, gVehicleData[i][e_vehicle_siren]);
        if(gVehicleData[i][e_vehicle_locked]) SetVehicleParamsEx(gVehicleData[i][e_vehicle_id], VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_ON, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF);
        gCreatedVehicles++;
	}
    printf("Number of vehicles loaded: %d", gCreatedVehicles);
}

//------------------------------------------------------------------------------

hook OnGameModeInit()
{
    mysql_pquery(mysql, "SELECT * FROM `vehicles`", "OnVehicleLoad");
    return 1;
}

//------------------------------------------------------------------------------

public OnInsertVehicle(vehicleid)
{
    new index = cache_insert_id();

    new col1, col2, modelid;
    new Float:x, Float:y, Float:z, Float:a;
    modelid = GetVehicleModel(vehicleid);
    GetVehicleZAngle(vehicleid, a);
    GetVehiclePos(vehicleid, x, y, z);
    GetVehicleColor(vehicleid, col1, col2);

    gVehicleData[vehicleid][e_vehicle_db] = index;

    gVehicleData[vehicleid][e_vehicle_model]        = modelid;
    gVehicleData[vehicleid][e_vehicle_color_1]      = col1;
    gVehicleData[vehicleid][e_vehicle_color_2]      = col2;
    gVehicleData[vehicleid][e_vehicle_siren]        = 0;

    gVehicleData[vehicleid][e_vehicle_x]            = x;
    gVehicleData[vehicleid][e_vehicle_y]            = y;
    gVehicleData[vehicleid][e_vehicle_z]            = z;
    gVehicleData[vehicleid][e_vehicle_a]            = a;

    gVehicleData[vehicleid][e_vehicle_fuel]         = 100.0;
    gVehicleData[vehicleid][e_vehicle_health]       = 1000.0;

    gVehicleData[vehicleid][e_vehicle_factionid]    = 0;
    gVehicleData[vehicleid][e_vehicle_jobid]        = 0;
    gVehicleData[vehicleid][e_vehicle_locked]       = 1;

    printf("[mysql] inserted vehicle %d on database.", index);
}

//------------------------------------------------------------------------------

YCMD:avehcmds(playerid, params[], help)
{
    if(!IsPlayerAdmin(playerid))
 		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

	SendClientMessage(playerid, COLOR_TITLE, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Comandos Veículos - Banco de Dados ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");

    SendClientMessage(playerid, COLOR_SUB_TITLE, "* /insertveh - /updateveh - /deleteveh");

	SendClientMessage(playerid, COLOR_TITLE, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Comandos Veículos - Banco de Dados ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	return 1;
}

//------------------------------------------------------------------------------

YCMD:insertveh(playerid, params[], help)
{
    if(!IsPlayerAdmin(playerid))
        return SendClientMessage(playerid, COLOR_ERROR, "* Você precisa estar logado na RCON para isto.");

    else if(!IsPlayerInAnyVehicle(playerid))
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não está em um veículo.");

    new vehicleid = GetPlayerVehicleID(playerid);
    if(gVehicleData[vehicleid][e_vehicle_db] != 0)
        return SendClientMessage(playerid, COLOR_ERROR, "* Este veículo já está no banco de dados, use /updateveh.");

    else
    {
        new col1, col2, modelid;
        new Float:x, Float:y, Float:z, Float:a;
        modelid = GetVehicleModel(vehicleid);
        GetVehicleZAngle(vehicleid, a);
        GetVehiclePos(vehicleid, x, y, z);
        GetVehicleColor(vehicleid, col1, col2);

        SendClientMessagef(playerid, COLOR_ADMIN_ACTION, "* Você inseriu um %s no banco de dados.", GetVehicleName(vehicleid));

        DestroyVehicle(vehicleid);
        vehicleid = CreateVehicle(modelid, x, y, z, a, col1, col2, -1);
        PutPlayerInVehicle(playerid, vehicleid, 0);

        new query[400];
        mysql_format(mysql, query, sizeof(query), "INSERT INTO `vehicles` (`vehicle_model`, `vehicle_col1`, `vehicle_col2`, `vehicle_x`, `vehicle_y`, `vehicle_z`, `vehicle_a`, `vehicle_fuel`, `vehicle_health`) VALUES (%d, %d, %d, %f, %f, %f, %f, %f, %f)", modelid, col1, col2, x, y, z, a, 100.0, 1000.0);
        mysql_pquery(mysql, query, "OnInsertVehicle", "i", vehicleid);
    }
    return 1;
}

//------------------------------------------------------------------------------

YCMD:updateveh(playerid, params[], help)
{
    if(!IsPlayerAdmin(playerid))
        return SendClientMessage(playerid, COLOR_ERROR, "* Você precisa estar logado na RCON para isto.");

    else if(!IsPlayerInAnyVehicle(playerid))
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não está em um veículo.");

    new vehicleid = GetPlayerVehicleID(playerid);
    if(gVehicleData[vehicleid][e_vehicle_db] == 0)
        return SendClientMessage(playerid, COLOR_ERROR, "* Este veículo não está no banco de dados, use /insertveh.");

    else
    {
        new col1, col2, modelid;
        new Float:x, Float:y, Float:z, Float:a;
        modelid = GetVehicleModel(vehicleid);
        GetVehicleZAngle(vehicleid, a);
        GetVehiclePos(vehicleid, x, y, z);
        GetVehicleColor(vehicleid, col1, col2);

        new option[32];
     	if(sscanf(params, "s", option))
     	{
            SendClientMessage(playerid, COLOR_INFO, "* /updateveh [opção]");
            SendClientMessage(playerid, COLOR_SUB_TITLE, "* Opções: model, color, siren, pos, lock, faction, job.");
        }
        else if(!strcmp(option, "model"))
        {
            new c_modelid;
            if(sscanf(params, "si", option, c_modelid))
                return SendClientMessage(playerid, COLOR_INFO, "* /updateveh model [400 - 611]");
            else if(modelid < 400 || modelid > 611)
                return SendClientMessage(playerid, COLOR_ERROR, "* Modelo inválido.");
            else
            {
                DestroyVehicle(vehicleid);
                vehicleid = CreateVehicle(c_modelid, x, y, z, a, col1, col2, -1, gVehicleData[vehicleid][e_vehicle_siren]);
                PutPlayerInVehicle(playerid, vehicleid, 0);

                SendClientMessagef(playerid, COLOR_ADMIN_ACTION, "* Você alterou o modelo do veículo %d de %s para %s.", vehicleid, GetVehicleNameFromModel(modelid), GetVehicleNameFromModel(c_modelid));

                new query[80];
                mysql_format(mysql, query, sizeof(query), "UPDATE `vehicles` SET `vehicle_model`=%d WHERE `ID`=%d", c_modelid, gVehicleData[vehicleid][e_vehicle_db]);
                mysql_pquery(mysql, query);
            }
        }
        else if(!strcmp(option, "color"))
        {
            new c_col1, c_col2;
            if(sscanf(params, "sii", option, c_col1, c_col2))
                return SendClientMessage(playerid, COLOR_INFO, "* /updateveh color [cor1] [cor2]");
            else if(c_col1 < -1 || c_col2 < -1)
                return SendClientMessage(playerid, COLOR_ERROR, "* Cor inválida.");
            else
            {
                ChangeVehicleColor(vehicleid, c_col1, c_col2);
                SendClientMessagef(playerid, COLOR_ADMIN_ACTION, "* Você alterou a cor do veículo %d de {%d, %d} para {%d, %d}.", vehicleid, col1, col2, c_col1, c_col2);

                new query[100];
                mysql_format(mysql, query, sizeof(query), "UPDATE `vehicles` SET `vehicle_col1`=%d, `vehicle_col2`=%d WHERE `ID`=%d", c_col1, c_col2, gVehicleData[vehicleid][e_vehicle_db]);
                mysql_pquery(mysql, query);
            }
        }
        else if(!strcmp(option, "siren"))
        {
            new c_siren;
            if(sscanf(params, "si", option, c_siren))
                return SendClientMessage(playerid, COLOR_INFO, "* /updateveh siren [1-sim | 0-não]");
            else if(c_siren < 0 || c_siren > 1)
                return SendClientMessage(playerid, COLOR_ERROR, "* Sirene inválida.");
            else if(c_siren == 1 && c_siren == gVehicleData[vehicleid][e_vehicle_siren])
                return SendClientMessage(playerid, COLOR_ERROR, "* Este veículo já possui sirene.");
            else if(c_siren == 0 && c_siren == gVehicleData[vehicleid][e_vehicle_siren])
                return SendClientMessage(playerid, COLOR_ERROR, "* Este veículo já está sem sirene.");
            else
            {
                DestroyVehicle(vehicleid);
                vehicleid = CreateVehicle(modelid, x, y, z, a, col1, col2, -1, c_siren);
                PutPlayerInVehicle(playerid, vehicleid, 0);

                SendClientMessagef(playerid, COLOR_ADMIN_ACTION, "* Você alterou a sirene do veículo %d de %d para %d.", vehicleid, gVehicleData[vehicleid][e_vehicle_siren], c_siren);
                gVehicleData[vehicleid][e_vehicle_siren] = c_siren;

                new query[80];
                mysql_format(mysql, query, sizeof(query), "UPDATE `vehicles` SET `vehicle_siren`=%d WHERE `ID`=%d", c_siren, gVehicleData[vehicleid][e_vehicle_db]);
                mysql_pquery(mysql, query);
            }
        }
        else if(!strcmp(option, "pos"))
        {
            DestroyVehicle(vehicleid);
            vehicleid = CreateVehicle(modelid, x, y, z, a, col1, col2, -1, gVehicleData[vehicleid][e_vehicle_siren]);
            PutPlayerInVehicle(playerid, vehicleid, 0);

            SendClientMessagef(playerid, COLOR_ADMIN_ACTION, "* Você alterou a posição do veículo %d para a atual.", vehicleid);

            gVehicleData[vehicleid][e_vehicle_x]            = x;
            gVehicleData[vehicleid][e_vehicle_y]            = y;
            gVehicleData[vehicleid][e_vehicle_z]            = z;
            gVehicleData[vehicleid][e_vehicle_a]            = a;

            new query[160];
            mysql_format(mysql, query, sizeof(query), "UPDATE `vehicles` SET `vehicle_x`=%f, `vehicle_y`=%f, `vehicle_z`=%f, `vehicle_a`=%f WHERE `ID`=%d", x, y, z, a, gVehicleData[vehicleid][e_vehicle_db]);
            mysql_pquery(mysql, query);
        }
        else if(!strcmp(option, "lock"))
        {
            new c_lock;
            if(sscanf(params, "si", option, c_lock))
                return SendClientMessage(playerid, COLOR_INFO, "* /updateveh lock [1-trancado | 0-destrancado]");
            else if(c_lock < 0 || c_lock > 1)
                return SendClientMessage(playerid, COLOR_ERROR, "* Tranca inválida.");
            else if(c_lock == 1 && c_lock == gVehicleData[vehicleid][e_vehicle_locked])
                return SendClientMessage(playerid, COLOR_ERROR, "* Este veículo já está trancado.");
            else if(c_lock == 0 && c_lock == gVehicleData[vehicleid][e_vehicle_locked])
                return SendClientMessage(playerid, COLOR_ERROR, "* Este veículo já está destrancado.");
            else
            {
                SendClientMessagef(playerid, COLOR_ADMIN_ACTION, "* Você alterou a tranca do veículo %d de %d para %d.", vehicleid, gVehicleData[vehicleid][e_vehicle_locked], c_lock);
                gVehicleData[vehicleid][e_vehicle_locked] = c_lock;

                new engine, lights, alarm, doors, bonnet, boot, objective;
                GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
                SetVehicleParamsEx(vehicleid, engine, lights, alarm, c_lock, bonnet, boot, objective);

                new query[80];
                mysql_format(mysql, query, sizeof(query), "UPDATE `vehicles` SET `vehicle_locked`=%d WHERE `ID`=%d", c_lock, gVehicleData[vehicleid][e_vehicle_db]);
                mysql_pquery(mysql, query);
            }
        }
        else if(!strcmp(option, "faction"))
        {
            new c_faction;
            if(sscanf(params, "si", option, c_faction))
                return SendClientMessage(playerid, COLOR_INFO, "* /updateveh faction [id da facção]");
            else if(c_faction < 0)
                return SendClientMessage(playerid, COLOR_ERROR, "* Facção inválida.");
            else if(c_faction == gVehicleData[vehicleid][e_vehicle_factionid])
                return SendClientMessage(playerid, COLOR_ERROR, "* Este veículo já é desta facção.");
            else
            {
                SendClientMessagef(playerid, COLOR_ADMIN_ACTION, "* Você alterou a facção do veículo %d de %d para %d.", vehicleid, gVehicleData[vehicleid][e_vehicle_factionid], c_faction);
                gVehicleData[vehicleid][e_vehicle_factionid] = c_faction;

                new query[80];
                mysql_format(mysql, query, sizeof(query), "UPDATE `vehicles` SET `vehicle_faction`=%d WHERE `ID`=%d", c_faction, gVehicleData[vehicleid][e_vehicle_db]);
                mysql_pquery(mysql, query);
            }
        }
        else if(!strcmp(option, "job"))
        {
            new c_job;
            if(sscanf(params, "si", option, c_job))
                return SendClientMessage(playerid, COLOR_INFO, "* /updateveh job [id do emprego]");
            else if(c_job < 0)
                return SendClientMessage(playerid, COLOR_ERROR, "* Emprego inválido.");
            else if(c_job == gVehicleData[vehicleid][e_vehicle_jobid])
                return SendClientMessage(playerid, COLOR_ERROR, "* Este veículo já é deste emprego.");
            else
            {
                SendClientMessagef(playerid, COLOR_ADMIN_ACTION, "* Você alterou a facção do veículo %d de %d para %d.", vehicleid, gVehicleData[vehicleid][e_vehicle_jobid], c_job);
                gVehicleData[vehicleid][e_vehicle_jobid] = c_job;

                new query[80];
                mysql_format(mysql, query, sizeof(query), "UPDATE `vehicles` SET `vehicle_job`=%d WHERE `ID`=%d", c_job, gVehicleData[vehicleid][e_vehicle_db]);
                mysql_pquery(mysql, query);
            }
        }
        else
        {
            SendClientMessage(playerid, COLOR_ERROR, "* Opção inválida.");
        }
    }
    return 1;
}

//------------------------------------------------------------------------------

YCMD:deleteveh(playerid, params[], help)
{
    if(!IsPlayerAdmin(playerid))
        return SendClientMessage(playerid, COLOR_ERROR, "* Você precisa estar logado na RCON para isto.");

    else if(!IsPlayerInAnyVehicle(playerid))
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não está em um veículo.");

    new vehicleid = GetPlayerVehicleID(playerid);
    if(gVehicleData[vehicleid][e_vehicle_db] == 0)
        return SendClientMessage(playerid, COLOR_ERROR, "* Este veículo não está no banco de dados.");

    else
    {
        DestroyVehicle(vehicleid);
        SendClientMessagef(playerid, COLOR_ADMIN_ACTION, "* Você deletou o veículo %d do banco de dados.", vehicleid);

        new query[60];
        mysql_format(mysql, query, sizeof(query), "DELETE FROM `vehicles` WHERE `ID`=%d", gVehicleData[vehicleid][e_vehicle_db]);
        mysql_pquery(mysql, query);
    }
    return 1;
}
