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

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

static STREAMER_TAG_CP gCheckpointid;

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

hook OnGameModeInit()
{
    gCheckpointid = CreateDynamicCP(-2033.4332, -117.4212, 1035.1719, 1.0, 0, 3);
}

//------------------------------------------------------------------------------


hook OnPlayerEnterDynamicCP(playerid, STREAMER_TAG_CP checkpointid)
{
    if(checkpointid == gCheckpointid)
    {
        SetPlayerCameraPos(playerid, -2033.0891, -117.6420, 1035.3528);
		SetPlayerCameraLookAt(playerid, -2034.0880, -117.6433, 1035.2723, CAMERA_MOVE);

        new info[160];
        inline Response(pid, dialogid, response, listitem, string:inputtext[])
        {
            #pragma unused pid, dialogid, inputtext
            if(!response)
			{
				SetCameraBehindPlayer(playerid);
                PlayCancelSound(playerid);
			}
            else
            {
                if(GetPlayerCash(playerid) < VEHICLE_LICENSE_PRICE[listitem])
                {
                    SendClientMessage(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiente.");
                    Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_TABLIST_HEADERS, "Auto-Escola", info, "Comprar", "Cancelar");
                }
                else
                {
                    SetCameraBehindPlayer(playerid);
                    PlayCancelSound(playerid);
                }
            }
        }
		format(info, sizeof(info), "Carteira\tPreço\tCategoria\nMotos\t$%s\tA\nCarros\t$%s\tB\nCaminhões\t$%s\tC\nBarcos\t$%s\tD\nHelicópteros\t$%s\tE\nAviões\t$%s\tF",
        formatnumber(VEHICLE_LICENSE_PRICE[VEHICLE_LICENSE_BIKE]), formatnumber(VEHICLE_LICENSE_PRICE[VEHICLE_LICENSE_CAR]), formatnumber(VEHICLE_LICENSE_PRICE[VEHICLE_LICENSE_TRUCK]),
        formatnumber(VEHICLE_LICENSE_PRICE[VEHICLE_LICENSE_BOAT]), formatnumber(VEHICLE_LICENSE_PRICE[VEHICLE_LICENSE_HELI]), formatnumber(VEHICLE_LICENSE_PRICE[VEHICLE_LICENSE_PLANE]));
        Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_TABLIST_HEADERS, "Auto-Escola", info, "Comprar", "Cancelar");
        PlaySelectSound(playerid);
        return -1;
    }
    return 1;
}

//------------------------------------------------------------------------------
