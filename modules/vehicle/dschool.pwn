/*******************************************************************************
* FILENAME :        modules/vehicle/school.pwn
*
* DESCRIPTION :
*       Handles all school vehicle tests.
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

#include "../modules/objects/dschool.pwn"
#include "../modules/visual/dschool.pwn"
#include "../modules/cutscenes/dschool.pwn"

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

static STREAMER_TAG_CP gCheckpointid;
static gPlayerVehicleID[MAX_PLAYERS] = {INVALID_VEHICLE_ID, ...};
static gPlayerCPPart[MAX_PLAYERS];
static gPlayerCTest[MAX_PLAYERS];

//------------------------------------------------------------------------------

static const Float:VEHICLE_SPAWN[][] =
{
    {
        -2048.2168, -109.7459, 34.9718, 178.3551
    }
};

static const Float:CHECKPOINT_SPAWN[][][] =
{
    {
        {-2048.3589,	-121.5204,	34.9747},
        {-2071.8198,	-126.4279,	35.0448},
        {-2072.9617,	-176.9404,	35.0365},
        {-2056.1702,	-137.0267,	35.0403},
        {-2033.7625,	-139.8533,	35.0300},
        {-2035.7468,	-246.3138,	35.0368},
        {-2057.6587,	-242.6942,	35.0404},
        {-2079.6760,	-207.6987,	35.0362}
    }
};

//------------------------------------------------------------------------------

hook OnGameModeInit()
{
    gCheckpointid = CreateDynamicCP(-2026.8457, -114.5543, 1035.1719, 1.0, 0, 3);
}

//------------------------------------------------------------------------------

OnPlayerEnterDrivingSchool(playerid)
{
    if(GetPlayerFirstTime(playerid, FIRST_TIME_DRIVING_SCHOOL) == false)
        StartDrivingSchoolCutscene(playerid);
    else
        return 1;
    return 0;
}

//------------------------------------------------------------------------------

hook OnPlayerDisconnect(playerid, reason)
{
    if(gPlayerVehicleID[playerid] != INVALID_VEHICLE_ID)
    {
        DestroyVehicle(gPlayerVehicleID[playerid]);
        gPlayerVehicleID[playerid] = INVALID_VEHICLE_ID;
    }
    gPlayerCPPart[playerid] = 0;
    return 1;
}

//------------------------------------------------------------------------------

OnPlayerSelectSchoolTest(playerid, test)
{
    gPlayerCTest[playerid] = test;
    switch(test)
    {
        case 0:
        {
            HidePlayerSchoolTV(playerid);
            SetCameraBehindPlayer(playerid);
            PlayConfirmSound(playerid);

            gPlayerVehicleID[playerid] = CreateVehicle(496, VEHICLE_SPAWN[test][0], VEHICLE_SPAWN[test][1], VEHICLE_SPAWN[test][2], VEHICLE_SPAWN[test][3], 3, 3, -1);

            SetPlayerRaceCheckpoint(playerid, 0, CHECKPOINT_SPAWN[test][0][0], CHECKPOINT_SPAWN[test][0][1], CHECKPOINT_SPAWN[test][0][2], CHECKPOINT_SPAWN[test][1][0], CHECKPOINT_SPAWN[test][1][1], CHECKPOINT_SPAWN[test][1][2], 2.0);
            SetPlayerCPID(playerid, CHECKPOINT_DRIVING_SCHOOL);

            SetPlayerInterior(playerid, 0);
            SetPlayerVirtualWorld(playerid, playerid + 1);
            SetVehicleVirtualWorld(gPlayerVehicleID[playerid], playerid + 1);
            PutPlayerInVehicle(playerid, gPlayerVehicleID[playerid], 0);
            SetVehicleFuel(gPlayerVehicleID[playerid], 100.0);
        }
    }
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(gPlayerCPPart[playerid] != sizeof(CHECKPOINT_SPAWN[]))
        return 1;

    if(newkeys & KEY_HANDBRAKE)
    {
        PlayerPlaySound(playerid, 1184, 0.0, 0.0, 0.0);
        HidePlayerCertification(playerid);
        ShowPlayerSchoolTV(playerid);
        DestroyVehicle(gPlayerVehicleID[playerid]);
        gPlayerVehicleID[playerid] = INVALID_VEHICLE_ID;
        gPlayerCPPart[playerid] = 0;
    }
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
    if(gPlayerVehicleID[playerid] == INVALID_VEHICLE_ID)
        return 1;

    switch(oldstate)
    {
        case PLAYER_STATE_DRIVER:
        {
            SendClientMessage(playerid, COLOR_ERROR, "* Você falhou no teste por abandonar o veículo.");

            SetPlayerPos(playerid, -2029.8218, -119.1891, 1035.1719);
            SetPlayerFacingAngle(playerid, 0.0);
            SetPlayerInterior(playerid, 3);
            SetPlayerVirtualWorld(playerid, 0);
            SetCameraBehindPlayer(playerid);
            DisablePlayerRaceCheckpoint(playerid);

            DestroyAutoSchoolObject(playerid);
            DestroyVehicle(gPlayerVehicleID[playerid]);
            gPlayerVehicleID[playerid] = INVALID_VEHICLE_ID;
            gPlayerCPPart[playerid] = 0;
        }
    }
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerEnterRaceCPT(playerid)
{
    if(GetPlayerCPID(playerid) == CHECKPOINT_DRIVING_SCHOOL)
    {
        new test = gPlayerCTest[playerid];
        new i = ++gPlayerCPPart[playerid];
        if(i == sizeof(CHECKPOINT_SPAWN[]))
        {
            new vehicleid = GetPlayerVehicleID(playerid);
            SetVehicleParamsEx(vehicleid, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF);
            SetVehicleVelocity(vehicleid, 0.0, 0.0, 0.0);
            ShowPlayerCertification(playerid);
            DisablePlayerRaceCheckpoint(playerid);
            PlayerPlaySound(playerid, 1183, 0.0, 0.0, 0.0);
            return -2;
        }
        else if(i == sizeof(CHECKPOINT_SPAWN[])-1)
            SetPlayerRaceCheckpoint(playerid, 1, CHECKPOINT_SPAWN[test][i][0], CHECKPOINT_SPAWN[test][i][1], CHECKPOINT_SPAWN[test][i][2], 0.0, 0.0, 0.0, 2.0);
        else
            SetPlayerRaceCheckpoint(playerid, 0, CHECKPOINT_SPAWN[test][i][0], CHECKPOINT_SPAWN[test][i][1], CHECKPOINT_SPAWN[test][i][2], CHECKPOINT_SPAWN[test][i+1][0], CHECKPOINT_SPAWN[test][i+1][1], CHECKPOINT_SPAWN[test][i+1][2], 2.0);
        PlaySelectSound(playerid);
        return -2;
    }
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerEnterDynamicCP(playerid, STREAMER_TAG_CP checkpointid)
{
    if(checkpointid == gCheckpointid)
        ShowPlayerSchoolTV(playerid);
    return 1;
}

//------------------------------------------------------------------------------
