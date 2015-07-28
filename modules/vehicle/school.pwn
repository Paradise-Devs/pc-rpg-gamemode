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

#include "../modules/objects/school.pwn"

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

static STREAMER_TAG_CP gCheckpointid;
static gPlayerVehicleID[MAX_PLAYERS] = {INVALID_VEHICLE_ID, ...};

//------------------------------------------------------------------------------

enum
{
    VEHICLE_LICENSE_BIKE,
    VEHICLE_LICENSE_CAR,
    VEHICLE_LICENSE_TRUCK,
    VEHICLE_LICENSE_BOAT,
    VEHICLE_LICENSE_HELI,
    VEHICLE_LICENSE_PLANE
}

//------------------------------------------------------------------------------

static const VEHICLE_LICENSE_PRICE[] =
{
    700,
    900,
    2300,
    6000,
    35000,
    100000
};

//------------------------------------------------------------------------------

static const Float:VEHICLE_SPAWN[][] =
{
    {496.0, -2028.1863, -126.6870, 34.8335, 180.0000}
};

//------------------------------------------------------------------------------

hook OnGameModeInit()
{
    gCheckpointid = CreateDynamicCP(-2033.4332, -117.4212, 1035.1719, 1.0, 0, 3);
}

//------------------------------------------------------------------------------

hook OnPlayerDisconnect(playerid, reason)
{
    if(gPlayerVehicleID[playerid] != INVALID_VEHICLE_ID)
    {
        DestroyVehicle(gPlayerVehicleID[playerid]);
        gPlayerVehicleID[playerid] = INVALID_VEHICLE_ID;
    }
    return 1;
}

//------------------------------------------------------------------------------

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch(dialogid)
    {
        case DIALOG_SCHOOL:
        {
            if(!response)
			{
				SetCameraBehindPlayer(playerid);
                PlayCancelSound(playerid);
			}
            else
            {
                if(GetPlayerCash(playerid) < VEHICLE_LICENSE_PRICE[listitem])
                {
                    PlayErrorSound(playerid);
                    SetCameraBehindPlayer(playerid);
                    SendClientMessage(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiente.");
                }
                else
                {
                    SetCameraBehindPlayer(playerid);
                    PlayConfirmSound(playerid);

                    gPlayerVehicleID[playerid] = CreateVehicle(floatround(VEHICLE_SPAWN[listitem][0]), VEHICLE_SPAWN[listitem][1], VEHICLE_SPAWN[listitem][2], VEHICLE_SPAWN[listitem][3], VEHICLE_SPAWN[listitem][4], 3, 3, -1);
                    SetPlayerInterior(playerid, 0);
                    SetPlayerVirtualWorld(playerid, playerid + 1);
                    SetVehicleVirtualWorld(gPlayerVehicleID[playerid], playerid + 1);
                    PutPlayerInVehicle(playerid, gPlayerVehicleID[playerid], 0);
                    SetVehicleFuel(gPlayerVehicleID[playerid], 100.0);
                    CreateAutoSchoolObject(playerid);
                }
            }
            return -2;
        }
    }
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerEnterDynamicCP(playerid, STREAMER_TAG_CP checkpointid)
{
    if(checkpointid == gCheckpointid)
    {
        SetPlayerCameraPos(playerid, -2033.0891, -117.6420, 1035.3528);
		SetPlayerCameraLookAt(playerid, -2034.0880, -117.6433, 1035.2723, CAMERA_MOVE);

        new info[160];
		format(info, sizeof(info), "Carteira\tPreço\tCategoria\nMotos\t$%s\tA\nCarros\t$%s\tB\nCaminhões\t$%s\tC\nBarcos\t$%s\tD\nHelicópteros\t$%s\tE\nAviões\t$%s\tF",
        formatnumber(VEHICLE_LICENSE_PRICE[VEHICLE_LICENSE_BIKE]), formatnumber(VEHICLE_LICENSE_PRICE[VEHICLE_LICENSE_CAR]), formatnumber(VEHICLE_LICENSE_PRICE[VEHICLE_LICENSE_TRUCK]),
        formatnumber(VEHICLE_LICENSE_PRICE[VEHICLE_LICENSE_BOAT]), formatnumber(VEHICLE_LICENSE_PRICE[VEHICLE_LICENSE_HELI]), formatnumber(VEHICLE_LICENSE_PRICE[VEHICLE_LICENSE_PLANE]));
        ShowPlayerDialog(playerid, DIALOG_SCHOOL, DIALOG_STYLE_TABLIST_HEADERS, "Auto-Escola", info, "Comprar", "Cancelar");
        PlaySelectSound(playerid);
        return -1;
    }
    return 1;
}

//------------------------------------------------------------------------------
