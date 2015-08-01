/*******************************************************************************
* FILENAME :        modules/data/building.pwn
*
* DESCRIPTION :
*       Saves and Loads building data.
*
* NOTES :
*       This file should only contain information about building's data.
*       This is not intended to handle player entrances, extis and such.
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

forward OnBuildingLoad();
forward OnPlayerEnterBuilding(playerid, building);
forward OnPlayerExitBuilding(playerid, building);

//------------------------------------------------------------------------------

#define INTERVAL_BETWEEN_PICKUP_UPDATES 1500

//------------------------------------------------------------------------------

// enumaration of building's data
enum e_building_data
{
    // outside position
    Float:e_building_out_x,
    Float:e_building_out_y,
    Float:e_building_out_z,
    Float:e_building_out_a,
    e_building_out_i,
    e_building_out_v,

    // inside positions
    Float:e_building_in_x,
    Float:e_building_in_y,
    Float:e_building_in_z,
    Float:e_building_in_a,
    e_building_in_i,
    e_building_in_v,

    // states
    e_building_locked,

    // ids
    e_building_out_pkp_id,
    e_building_in_pkp_id
}
static gBuildingData[MAX_BUILDINGS][e_building_data];
static gCreatedBuildings;
static gPLEtickcount[MAX_PLAYERS];

//------------------------------------------------------------------------------

public OnBuildingLoad()
{
    for(new i, j = cache_get_row_count(mysql); i < j; i++)
	{
		gBuildingData[i][e_building_out_x]    = cache_get_row_float(i, 1, mysql);
		gBuildingData[i][e_building_out_y]    = cache_get_row_float(i, 2, mysql);
		gBuildingData[i][e_building_out_z]    = cache_get_row_float(i, 3, mysql);
		gBuildingData[i][e_building_out_a]    = cache_get_row_float(i, 4, mysql);
		gBuildingData[i][e_building_out_i]    = cache_get_row_int(i, 5, mysql);
		gBuildingData[i][e_building_out_v]    = cache_get_row_int(i, 6, mysql);

		gBuildingData[i][e_building_in_x]     = cache_get_row_float(i, 7, mysql);
		gBuildingData[i][e_building_in_y]     = cache_get_row_float(i, 8, mysql);
		gBuildingData[i][e_building_in_z]     = cache_get_row_float(i, 9, mysql);
		gBuildingData[i][e_building_in_a]     = cache_get_row_float(i, 10, mysql);
		gBuildingData[i][e_building_in_i]     = cache_get_row_int(i, 11, mysql);
		gBuildingData[i][e_building_in_v]     = cache_get_row_int(i, 12, mysql);

        gBuildingData[i][e_building_locked]   = cache_get_row_int(i, 13, mysql);

        gBuildingData[i][e_building_out_pkp_id] = CreateDynamicPickup(19902, 1, gBuildingData[i][e_building_out_x], gBuildingData[i][e_building_out_y], gBuildingData[i][e_building_out_z], gBuildingData[i][e_building_out_v], gBuildingData[i][e_building_out_i]);
        gBuildingData[i][e_building_in_pkp_id] = CreateDynamicPickup(19902, 1, gBuildingData[i][e_building_in_x], gBuildingData[i][e_building_in_y], gBuildingData[i][e_building_in_z], gBuildingData[i][e_building_in_v], gBuildingData[i][e_building_in_i]);
        gCreatedBuildings++;
	}
    printf("Number of buildings loaded: %d", gCreatedBuildings);
}

//------------------------------------------------------------------------------

hook OnPlayerPickUpDynPickup(playerid, pickupid)
{
    if(gPLEtickcount[playerid] > tickcount())
        return 1;

    for (new i = 0; i < gCreatedBuildings; i++)
    {
        if(pickupid == gBuildingData[i][e_building_out_pkp_id])
        {
            if(OnPlayerEnterBuilding(playerid, i) != 0)
            {
                SetPlayerInterior(playerid, gBuildingData[i][e_building_in_i]);
                SetPlayerVirtualWorld(playerid, gBuildingData[i][e_building_in_v]);
                SetPlayerPos(playerid, gBuildingData[i][e_building_in_x], gBuildingData[i][e_building_in_y], gBuildingData[i][e_building_in_z]);
                SetPlayerFacingAngle(playerid, gBuildingData[i][e_building_in_a]);
                SetCameraBehindPlayer(playerid);
                gPLEtickcount[playerid] = tickcount() + INTERVAL_BETWEEN_PICKUP_UPDATES;
            }
        }
        else if(pickupid == gBuildingData[i][e_building_in_pkp_id])
        {
            if(OnPlayerExitBuilding(playerid, i) != 0)
            {
                SetPlayerInterior(playerid, gBuildingData[i][e_building_out_i]);
                SetPlayerVirtualWorld(playerid, gBuildingData[i][e_building_out_v]);
                SetPlayerPos(playerid, gBuildingData[i][e_building_out_x], gBuildingData[i][e_building_out_y], gBuildingData[i][e_building_out_z]);
                SetPlayerFacingAngle(playerid, gBuildingData[i][e_building_out_a]);
                SetCameraBehindPlayer(playerid);
                gPLEtickcount[playerid] = tickcount() + INTERVAL_BETWEEN_PICKUP_UPDATES;
            }
        }
    }
    return 1;
}

//------------------------------------------------------------------------------

public OnPlayerEnterBuilding(playerid, building)
{
    if(gBuildingData[building][e_building_locked])
    {
        SendClientMessage(playerid, COLOR_ERROR, "* Porta trancada.");
        return 0;
    }
    else if(building == 1)
    {
        if(GetPlayerFirstTime(playerid, FIRST_TIME_CITY_HALL) == false)
        {
            StartCityHallSchoolCutscene(playerid);
            return 0;
        }
    }
    else if(building == 25)
        return OnPlayerEnterDrivingSchool(playerid);
    return 1;
}

//------------------------------------------------------------------------------

public OnPlayerExitBuilding(playerid, building)
{
    return 1;
}

//------------------------------------------------------------------------------

hook OnGameModeInit()
{
    mysql_pquery(mysql, "SELECT * FROM `buildings`", "OnBuildingLoad");
    return 1;
}
