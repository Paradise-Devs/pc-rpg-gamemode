/*******************************************************************************
* FILENAME :        modules/job/trucker.pwn
*
* DESCRIPTION :
*       Adds trucker job to the server.
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

// Amount of XP multipled by job level to level up.
static const REQUIRED_XP = 90;

// Amount of XP multipled by job level the player will recieve for deliver.
static const XP_SCALE = 10;

// Job position
static const Float:JOB_POSITION[] = {2442.5039, -2110.0667, 13.5530};

// Load position
static const Float:LOAD_POSITION[] = {2434.1604, -2094.9910, 13.5469};

// Player Current CP
static gPlayerCurrentCP[MAX_PLAYERS];

// Player Selected Service
static gPSelectedService[MAX_PLAYERS];
//------------------------------------------------------------------------------

static gTruckerServices[][][] =
{
    // Service        Payment Level isLegal
    {"Roupas",          1000,   1,  1},
    {"Drogas",          1250,   1,  0},
    {"Comida",          2500,   2,  1},
    {"Armas",           3000,   2,  0},
    {"Materiais",       5000,   3,  1},
    {"Animais",         6000,   3,  0},
    {"Combutível",      10000,  4,  1},
    {"Pessoas",         12000,  4,  0}
};

//------------------------------------------------------------------------------

static const Float:gTruckLocations[][][] =
{
    {
        {452.7070,  -1501.0168,     31.4884},
        {510.0989,   -1364.2018,    16.5673},
        {1458.8278,  -1157.4393,    24.2775},
        {2113.9033,  -1217.5211,    24.4115}
    },
    {
        {2345.9380,		-1497.9634,		24.4404},
        {483.49620,		-1532.0349,		20.1346},
        {2512.0964,		-1253.1033,		35.4902},
        {2646.6526,		-1593.3977,		13.8756}
    },
    {
        {1037.1023,		-1330.9777,		13.9965},
        {275.22420,		-1426.6449,		14.2896},
        {1499.5875,		-1588.8528,		13.9893},
        {787.69740,		-1620.6924,		13.9897}
    },
    {
        {2075.4602,		-1159.0679,		24.2988},
        {2306.4221,		-1194.6791,		25.4348},
        {2719.2214,		-1113.9396,		70.0175},
        {2837.2656,		-1181.8094,		25.1662}
    },
    {
        {1276.7897,		-1277.6726,		13.9429},
        {939.2288,		-1217.5900,		17.3564},
        {287.4856,		-1634.0905,		33.7625},
        {1901.8885,		-1337.3693,		13.9930}
    },
    {
        {2485.6892,		-1500.8756,		24.4328},
        {2499.8435,		-1500.6957,		24.4263},
        {2160.0593,		-1017.8882,		63.2560},
        {920.7543,		-1353.4326,		13.8093}
    },
    {
        {1958.4943,		-1768.1792,		13.9893},
        {1009.9824,		-955.4226,		42.4059},
        {-110.6846,		-1167.4324,		3.21790},
        {645.20210,		-562.6168,		16.7984}
    },
    {
        {2485.6892,		-1500.8756,		24.4328},
        {2499.8435,		-1500.6957,		24.4263},
        {2160.0593,		-1017.8882,		63.2560},
        {920.7543,		-1353.4326,		13.8093}
    }
};

//------------------------------------------------------------------------------

enum TRAILER_CARGO (+=1)
{
    TRAILER_CARGO_NONE,
    TRAILER_CARGO_CLOTHES = 1,
    TRAILER_CARGO_DRUGS,
    TRAILER_CARGO_FOOD,
    TRAILER_CARGO_GUNS,
    TRAILER_CARGO_MATERIALS,
    TRAILER_CARGO_ANIMALS,
    TRAILER_CARGO_FUEL,
    TRAILER_CARGO_PEOPLE
}
static TRAILER_CARGO:gTrailerCargo[MAX_PLAYERS];

//------------------------------------------------------------------------------

static gPlayerTruckID[MAX_PLAYERS] = {INVALID_VEHICLE_ID, ...};
static gPlayerTrailerID[MAX_PLAYERS] = {INVALID_VEHICLE_ID, ...};

//------------------------------------------------------------------------------

hook OnGameModeInit()
{
    CreateDynamicPickup(1210, 1, JOB_POSITION[0], JOB_POSITION[1], JOB_POSITION[2], 0, 0, -1, MAX_PICKUP_RANGE);
    CreateDynamic3DTextLabel("Caminhoneiro\nPressione Y", 0xFFFFFFFF, JOB_POSITION[0], JOB_POSITION[1], JOB_POSITION[2], MAX_TEXT3D_RANGE, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);

    CreateDynamicPickup(1239, 1, LOAD_POSITION[0], LOAD_POSITION[1], LOAD_POSITION[2], 0, 0, -1, MAX_PICKUP_RANGE);
    CreateDynamic3DTextLabel("Serviços\nPressione Y", 0xFFFFFFFF, LOAD_POSITION[0], LOAD_POSITION[1], LOAD_POSITION[2], MAX_TEXT3D_RANGE, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerDisconnect(playerid, reason)
{
    if(gPlayerTruckID[playerid] != INVALID_VEHICLE_ID)
    {
        DestroyVehicle(gPlayerTruckID[playerid]);
        DestroyVehicle(gPlayerTrailerID[playerid]);

        gPlayerTruckID[playerid] = INVALID_VEHICLE_ID;
        gPlayerTrailerID[playerid] = INVALID_VEHICLE_ID;

        gPlayerCurrentCP[playerid] = 0;
    }
    return 1;
}

//------------------------------------------------------------------------------

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch(dialogid)
    {
        case DIALOG_TRUCK_JOB:
        {
            if(!response)
                PlayCancelSound(playerid);
            else
            {
                if(GetPlayerJobID(playerid) != INVALID_JOB_ID)
                {
                    PlayErrorSound(playerid);
                    SendClientMessage(playerid, COLOR_ERROR, "* Você já possui um emprego.");
                }
                else
                {
                    SetPlayerJobID(playerid, TRUCKER_JOB_ID);
                    SendClientMessage(playerid, COLOR_SPECIAL, "* Agora você é um caminhoneiro!");
                    SendClientMessage(playerid, COLOR_SUB_TITLE, "* Vá até o ícone na entrada para escolher um serviço.");
                    PlayConfirmSound(playerid);
                }
            }
        }
        case DIALOG_TRUCKER_SERVICES:
        {
            if(!response)
                PlayCancelSound(playerid);
            else
            {
                if(!response)
                    PlayCancelSound(playerid);
                else if(GetPlayerJobLV(playerid) < gTruckerServices[listitem][2][0])
                {
                    SendClientMessage(playerid, COLOR_ERROR, "* Você não tem nível de emprego suficiente para este serviço.");
                    PlayErrorSound(playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_SPECIAL, "* Vá entregar a mercadoria no local indicado.");

                    if(!gTruckerServices[listitem][3][0])
                        SendClientMessage(playerid, COLOR_SUB_TITLE, "* Você está carregando uma carga ilegal, cuidado com a polícia.");
                    else
                        SendClientMessage(playerid, COLOR_SUB_TITLE, "* Cuidado com a mercadoria.");

                    gPSelectedService[playerid] = listitem;
                    gTrailerCargo[playerid] = TRAILER_CARGO:(listitem+1);
                    gPlayerTruckID[playerid] = CreateVehicle(515, 2444.2415, -2091.3992, 14.5237, 89.4204, -1, -1, -1);
                    gPlayerTrailerID[playerid] = CreateVehicle(591, 2453.3735, -2091.9829, 14.2064, 84.7415, -1, -1, -1);
                    AttachTrailerToVehicle(gPlayerTrailerID[playerid], gPlayerTruckID[playerid]);
                    PutPlayerInVehicle(playerid, gPlayerTruckID[playerid], 0);
                    SetVehicleFuel(gPlayerTruckID[playerid], 100.0);

                    new rand = random(sizeof(gTruckLocations[]));
                    SetPlayerRaceCheckpoint(playerid, 0, gTruckLocations[listitem][rand][0], gTruckLocations[listitem][rand][1], gTruckLocations[listitem][rand][2], 2509.3311, -2089.5120, 14.1535, 10.0);
                    SetPlayerCPID(playerid, CHECKPOINT_TRUCKER);
                }
            }
        }
    }
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerEnterRaceCPT(playerid)
{
    if(GetPlayerCPID(playerid) != CHECKPOINT_TRUCKER)
        return 1;

    if(!IsPlayerInVehicle(playerid, gPlayerTruckID[playerid]))
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não está no caminhão do serviço.");
    else if(GetVehicleTrailer(gPlayerTruckID[playerid]) != gPlayerTrailerID[playerid])
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não está com o trailer que você carregou.");

    switch(gPlayerCurrentCP[playerid])
    {
        case 0:
        {
            PlaySelectSound(playerid);
            gTrailerCargo[playerid] = TRAILER_CARGO_NONE;
            SendClientMessage(playerid, COLOR_SPECIAL, "* Entrega completa!");
            SendClientMessage(playerid, COLOR_SUB_TITLE, "* Volte com o caminhão para a empresa para receber o pagamento.");

            SetPlayerRaceCheckpoint(playerid, 1, 2509.3311, -2089.5120, 14.1535, 0.0, 0.0, 0.0, 10.0);
        }
        case 1:
        {
            PlayConfirmSound(playerid);
            SendClientMessage(playerid, COLOR_SPECIAL, "* Serviço completo!");
            SendClientMessagef(playerid, COLOR_SUB_TITLE, "* Você recebeu $%s de pagamento.", formatnumber(gTruckerServices[gPSelectedService[playerid]][1][0]));
            GivePlayerCash(playerid, gTruckerServices[gPSelectedService[playerid]][1][0]);

            DestroyVehicle(gPlayerTruckID[playerid]);
            DestroyVehicle(gPlayerTrailerID[playerid]);

            gPlayerTruckID[playerid] = INVALID_VEHICLE_ID;
            gPlayerTrailerID[playerid] = INVALID_VEHICLE_ID;

            gPlayerCurrentCP[playerid] = 0;

            DisablePlayerRaceCheckpoint(playerid);
            SetPlayerCPID(playerid, CHECKPOINT_NONE);

            SetPlayerJobXP(playerid, GetPlayerJobXP(playerid) + (GetPlayerJobLV(playerid) * XP_SCALE));
            if(GetPlayerJobXP(playerid) > (GetPlayerJobLV(playerid) * REQUIRED_XP))
            {
                SetPlayerJobXP(playerid, 0);
                SetPlayerJobLV(playerid, GetPlayerJobLV(playerid) + 1);
            }
        }
    }
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if((newkeys == KEY_YES) && IsPlayerInRangeOfPoint(playerid, 1.5, JOB_POSITION[0], JOB_POSITION[1], JOB_POSITION[2]))
    {
        PlaySelectSound(playerid);
        ShowPlayerDialog(playerid, DIALOG_TRUCK_JOB, DIALOG_STYLE_MSGBOX, "Emprego: Caminhoneiro", "Você deseja se tornar um caminhoneiro?", "Sim", "Não");
        return 1;
    }
    else if((newkeys == KEY_YES) && IsPlayerInRangeOfPoint(playerid, 1.5, LOAD_POSITION[0], LOAD_POSITION[1], LOAD_POSITION[2]))
    {
        if(GetPlayerJobID(playerid) != TRUCKER_JOB_ID)
            return SendClientMessage(playerid, COLOR_ERROR, "* Você não é um caminhoneiro.");
        else if(gPlayerTruckID[playerid] != INVALID_VEHICLE_ID)
            return SendClientMessage(playerid, COLOR_ERROR, "* Você já está em um serviço.");

        PlaySelectSound(playerid);
        new info[300], buffer[60], sIsLegal[4];
        strcat(info, "Serviço\tPagamento\tNível\tLegal");
        for(new i = 0; i < sizeof(gTruckerServices); i++)
        {
            if(gTruckerServices[i][3][0]) format(sIsLegal, sizeof(sIsLegal), "Sim");
            else format(sIsLegal, sizeof(sIsLegal), "Não");
            format(buffer, sizeof(buffer), "\n%s\t$%s\t%i\t%s", gTruckerServices[i][0], formatnumber(gTruckerServices[i][1][0]), gTruckerServices[i][2][0], sIsLegal);
            strcat(info, buffer);
        }
        ShowPlayerDialog(playerid, DIALOG_TRUCKER_SERVICES,  DIALOG_STYLE_TABLIST_HEADERS, "Caminhoneiro -> Serviços", info, "Aceitar", "Recusar");
    }
    return 1;
}

//------------------------------------------------------------------------------
