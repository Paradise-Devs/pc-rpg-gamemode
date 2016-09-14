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

// Bike license data
static const Float:BIKE_SPAWN[][] =
{
    { 1282.5000, -1378.8220, 12.8692, 181.1488 },
    { 1280.0000, -1378.8220, 12.8692, 181.1488 },
    { 1278.5000, -1378.8220, 12.8692, 181.1488 },
    { 1276.0000, -1378.8220, 12.8692, 181.1488 }
};

static const Float:BIKE_CHECKPOINT[][] =
{
    { 1280.2186, -1393.1964, 12.7251, 93.26620 },
    { 1039.9838, -1393.6539, 12.8596, 89.79560 },
    { 783.07450, -1393.1760, 12.9214, 90.02770 },
    { 607.52620, -1393.4883, 12.9207, 93.99650 },
    { 416.47170, -1466.0488, 29.9933, 126.5129 },
    { 309.30110, -1582.1245, 32.5492, 84.19640 },
    { 251.62520, -1547.9036, 32.1125, 335.4957 },
    { 281.13920, -1480.8333, 31.0827, 56.56430 },
    { 154.69040, -1542.9722, 10.1368, 144.3262 },
    { 166.72340, -1601.7939, 13.1993, 217.7671 },
    { 500.90870, -1729.0808, 11.0213, 261.7975 },
    { 1037.1071, -1787.9296, 13.1274, 347.9097 },
    { 1056.3453, -1714.4523, 12.9045, 268.3728 },
    { 1203.2094, -1714.8153, 12.9050, 269.6456 },
    { 1336.9497, -1734.9178, 12.9070, 271.0052 },
    { 1387.0905, -1755.5820, 12.9051, 180.6171 },
    { 1386.9320, -1857.2711, 12.9027, 178.4356 },
    { 1410.8630, -1874.2399, 12.9024, 271.9253 },
    { 1516.2467, -1874.8440, 12.9041, 270.1579 },
    { 1571.8693, -1857.4355, 12.9025, 359.9785 },
    { 1571.9131, -1747.3274, 12.9040, 359.9776 },
    { 1544.5651, -1729.7639, 12.9024, 91.94490 },
    { 1445.5293, -1730.1528, 12.9029, 90.95790 },
    { 1431.8685, -1711.9792, 12.9049, 359.2755 },
    { 1432.1967, -1604.7590, 12.9029, 0.908000 },
    { 1416.2166, -1590.0154, 12.8867, 89.02680 },
    { 1325.5807, -1569.9348, 12.8879, 82.40720 },
    { 1316.0173, -1553.5378, 12.9127, 353.9121 },
    { 1360.2015, -1421.5933, 12.9031, 357.1411 },
    { 1329.1617, -1393.2106, 12.8981, 90.78060 },
    { 1279.7545, -1379.7042, 12.8075, 2.091300 }
};

static gPlayerSchoolVehicle[MAX_PLAYERS] = {INVALID_VEHICLE_ID, ...};
static gPlayerSchoolCheckpoint[MAX_PLAYERS];

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
    if(gPlayerSchoolVehicle[playerid] != INVALID_VEHICLE_ID)
    {
        DestroyVehicle(gPlayerSchoolVehicle[playerid]);
        gPlayerSchoolVehicle[playerid] = INVALID_VEHICLE_ID;
        gPlayerSchoolCheckpoint[playerid] = 0;
    }
    gPlayerCPPart[playerid] = 0;
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerDeath(playerid, killerid, reason)
{
    if(gPlayerVehicleID[playerid] != INVALID_VEHICLE_ID)
    {
        DestroyVehicle(gPlayerVehicleID[playerid]);
        gPlayerVehicleID[playerid] = INVALID_VEHICLE_ID;
        gPlayerCPPart[playerid] = 0;

        SendClientMessage(playerid, COLOR_ERROR, "* Você falhou no teste.");
    }
    if(gPlayerSchoolVehicle[playerid] != INVALID_VEHICLE_ID)
    {
        DestroyVehicle(gPlayerSchoolVehicle[playerid]);
        gPlayerSchoolVehicle[playerid] = INVALID_VEHICLE_ID;
        gPlayerSchoolCheckpoint[playerid] = 0;

        SendClientMessage(playerid, COLOR_ERROR, "* Você falhou no teste.");
    }
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
            GivePlayerCash(playerid, -500);
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
        HidePlayerCertification(playerid);
        PlayerPlaySound(playerid, 1184, 0.0, 0.0, 0.0);
        SendClientMessage(playerid, COLOR_SUCCESS, "* Você concluiu o teste com sucesso e recebeu sua carta de habilitação.");

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
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
    switch(oldstate)
    {
        case PLAYER_STATE_DRIVER:
        {
            if(gPlayerVehicleID[playerid] != INVALID_VEHICLE_ID)
            {
                HidePlayerCertification(playerid);
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
            else if(gPlayerSchoolVehicle[playerid] != INVALID_VEHICLE_ID)
            {
                PlayErrorSound(playerid);
                SendClientMessage(playerid, COLOR_ERROR, "* Você falhou no teste por abandonar o veículo.");

                DisablePlayerRaceCheckpoint(playerid);
                DestroyVehicle(gPlayerSchoolVehicle[playerid]);
                gPlayerSchoolVehicle[playerid] = INVALID_VEHICLE_ID;
                gPlayerSchoolCheckpoint[playerid] = 0;

                SetPlayerInterior(playerid, 3);
                SetPlayerVirtualWorld(playerid, 0);
                SetPlayerPos(playerid, -2029.8218, -119.1891, 1035.1719);
                SetPlayerFacingAngle(playerid, 0.0);
                SetCameraBehindPlayer(playerid);
            }
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
            SetPlayerCarLicense(playerid, gettime() + (86400 * 60));
            return -2;
        }
        else if(i == sizeof(CHECKPOINT_SPAWN[])-1)
            SetPlayerRaceCheckpoint(playerid, 1, CHECKPOINT_SPAWN[test][i][0], CHECKPOINT_SPAWN[test][i][1], CHECKPOINT_SPAWN[test][i][2], 0.0, 0.0, 0.0, 2.0);
        else
            SetPlayerRaceCheckpoint(playerid, 0, CHECKPOINT_SPAWN[test][i][0], CHECKPOINT_SPAWN[test][i][1], CHECKPOINT_SPAWN[test][i][2], CHECKPOINT_SPAWN[test][i+1][0], CHECKPOINT_SPAWN[test][i+1][1], CHECKPOINT_SPAWN[test][i+1][2], 2.0);
        PlaySelectSound(playerid);
        return -2;
    }
    else if(GetPlayerCPID(playerid) == CHECKPOINT_BIKE_SCHOOL)
    {
        new i = ++gPlayerSchoolCheckpoint[playerid];
        if(i == sizeof(BIKE_CHECKPOINT))
        {
            PlayConfirmSound(playerid);
            DisablePlayerRaceCheckpoint(playerid);
            DestroyVehicle(gPlayerSchoolVehicle[playerid]);
            gPlayerSchoolVehicle[playerid] = INVALID_VEHICLE_ID;
            gPlayerSchoolCheckpoint[playerid] = 0;
            SetPlayerBikeLicense(playerid, gettime() + (86400 * 60));

            SetPlayerInterior(playerid, 3);
            SetPlayerVirtualWorld(playerid, 0);
            SetPlayerPos(playerid, -2029.8218, -119.1891, 1035.1719);
            SetPlayerFacingAngle(playerid, 0.0);
            SetCameraBehindPlayer(playerid);

            SendClientMessage(playerid, COLOR_SUCCESS, "* Você concluiu o teste de habilitação e recebeu sua carta.");
            SendClientActionMessage(playerid, 15.0, "recebe a carta de habilitação do instrutor.");
            return -2;
        }
        else if(i == sizeof(BIKE_CHECKPOINT)-1)
            SetPlayerRaceCheckpoint(playerid, 1, BIKE_CHECKPOINT[i][0], BIKE_CHECKPOINT[i][1], BIKE_CHECKPOINT[i][2], 0.0, 0.0, 0.0, 3.5);
        else
            SetPlayerRaceCheckpoint(playerid, 0, BIKE_CHECKPOINT[i][0], BIKE_CHECKPOINT[i][1], BIKE_CHECKPOINT[i][2], BIKE_CHECKPOINT[i+1][0], BIKE_CHECKPOINT[i+1][1], BIKE_CHECKPOINT[i+1][2], 3.5);
        PlaySelectSound(playerid);
        return -2;
    }
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerEnterDynamicCP(playerid, STREAMER_TAG_CP checkpointid)
{
    if(checkpointid == gCheckpointid)
    {
        PlaySelectSound(playerid);
        ShowPlayerDialog(playerid, DIALOG_DRIVING_SCHOOL, DIALOG_STYLE_TABLIST_HEADERS, "Teste de Habilitação", "Licença\tTipo\tPreço\nMotos\tA\t$100\nCarros\tB\t$500", "Confirmar", "Sair");
    }
    return 1;
}

//------------------------------------------------------------------------------

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch (dialogid)
    {
        case DIALOG_DRIVING_SCHOOL:
        {
            switch (listitem)
            {
                case 0:
                {
                    if(response)
                    {
                        if(GetPlayerCash(playerid) >= 100)
                        {
                            if(GetPlayerBikeLicense(playerid) < gettime())
                            {
                                new rand = random(sizeof(BIKE_SPAWN));
                                gPlayerSchoolCheckpoint[playerid] = 0;
                                gPlayerSchoolVehicle[playerid] = CreateVehicle(586, BIKE_SPAWN[rand][0], BIKE_SPAWN[rand][1], BIKE_SPAWN[rand][2], BIKE_SPAWN[rand][3], 3, 3, -1, true);
                                SetPlayerInterior(playerid, 0);
                                SetPlayerVirtualWorld(playerid, 0);
                                PutPlayerInVehicle(playerid, gPlayerSchoolVehicle[playerid], 0);
                                SetVehicleParamsEx(gPlayerSchoolVehicle[playerid], VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_ON, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_ON, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF);
                                SetVehicleFuel(gPlayerSchoolVehicle[playerid], 100.0);
                                SetPlayerRaceCheckpoint(playerid, 0, BIKE_CHECKPOINT[0][0], BIKE_CHECKPOINT[0][1], BIKE_CHECKPOINT[0][2], BIKE_CHECKPOINT[1][0], BIKE_CHECKPOINT[1][1], BIKE_CHECKPOINT[1][2], 3.5);
                                SetPlayerCPID(playerid, CHECKPOINT_BIKE_SCHOOL);
                                GivePlayerCash(playerid, -100);
                                PlaySelectSound(playerid);
                            }
                            else
                            {
                                PlayErrorSound(playerid);
                                SendClientMessage(playerid, COLOR_ERROR, "* Sua carta de habilitação não está vencida.");
                            }
                        }
                        else
                        {
                            PlayErrorSound(playerid);
                            SendClientMessage(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiente.");
                        }
                    }
                    else
                    {
                        PlayCancelSound(playerid);
                    }
                }
                case 1:
                {
                    if(response)
                    {
                        if(GetPlayerCash(playerid) >= 500)
                        {
                            if(GetPlayerCarLicense(playerid) < gettime())
                            {
                                ShowPlayerSchoolTV(playerid);
                            }
                            else
                            {
                                PlayErrorSound(playerid);
                                SendClientMessage(playerid, COLOR_ERROR, "* Sua carta de habilitação não está vencida.");
                            }
                        }
                        else
                        {
                            PlayErrorSound(playerid);
                            SendClientMessage(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiente.");
                        }
                    }
                    else
                    {
                        PlayCancelSound(playerid);
                    }
                }
            }
        }
    }
    return 1;
}
