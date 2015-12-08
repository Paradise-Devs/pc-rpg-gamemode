/*******************************************************************************
* FILENAME :        modules/job/taxi.pwn
*
* DESCRIPTION :
*       Adds taxi job to the server.
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

// Settings
static const TAXIMETER_INTERVAL = 15000; // Interval between taximeter increases

// Taxi driver vars
static g_playerFarePrice[MAX_PLAYERS];
static bool:g_isPlayerOnDuty[MAX_PLAYERS];

// Taxi passenger vars
static g_playerDistTraveled[MAX_PLAYERS];

// Common vars
static bool:g_isVisible[MAX_PLAYERS];
static PlayerText:g_txdTaximeter[MAX_PLAYERS];

//------------------------------------------------------------------------------

hook OnGameModeInit()
{
    print("Loading taxi job.");
}

//------------------------------------------------------------------------------

hook OnPlayerDisconnect(playerid, reason)
{
    g_isVisible[playerid] = false;
    g_isPlayerOnDuty[playerid] = false;
    g_playerDistTraveled[playerid] = 0;
    return 1;
}

//------------------------------------------------------------------------------

ptask OnPlayerTaxiUpdate[TAXIMETER_INTERVAL](playerid)
{
    if(!g_isPlayerOnDuty[playerid])
        return 1;

    new passengerid[3] = {INVALID_PLAYER_ID, ...};
    foreach(new i: Player)
    {
        if(!IsPlayerInVehicle(i, GetPlayerVehicleID(playerid)) || i == playerid)
            continue;

        g_playerDistTraveled[i]++;
        if((g_playerDistTraveled[i] * g_playerFarePrice[playerid]) > GetPlayerCash(i))
            SendClientMessagef(playerid, 0xFFFF00FF, "* O passageiro %s não tem mais dinheiro para pagar a viagem.");

        if(!g_isVisible[i])
            ShowPassengerTaximeter(i);

        new string[32];
        format(string, sizeof(string), "$%07d", (g_playerDistTraveled[i] * g_playerFarePrice[playerid]));
        PlayerTextDrawSetString(i, g_txdTaximeter[i], string);

        passengerid[GetPlayerVehicleSeat(i)] = i;
    }

    new cash[3];
    if(passengerid[0] != INVALID_PLAYER_ID)
        cash[0] = (g_playerDistTraveled[passengerid[0]] * g_playerFarePrice[playerid]);
    if(passengerid[1] != INVALID_PLAYER_ID)
        cash[1] = (g_playerDistTraveled[passengerid[1]] * g_playerFarePrice[playerid]);
    if(passengerid[2] != INVALID_PLAYER_ID)
        cash[2] = (g_playerDistTraveled[passengerid[2]] * g_playerFarePrice[playerid]);

    new string[94];
    format(string, sizeof(string), "Passageiro 1: $%07d~n~Passageiro 2: $%07d~n~Passageiro 3: $%07d", cash[0], cash[1], cash[2]);
    PlayerTextDrawSetString(playerid, g_txdTaximeter[playerid], string);
    return 1;
}

//------------------------------------------------------------------------------

ShowPassengerTaximeter(playerid)
{
    if(g_isVisible[playerid])
        return 1;

    g_isVisible[playerid] = true;
    g_txdTaximeter[playerid] = CreatePlayerTextDraw(playerid, 556.000000, 127.000000, "$0000000");
    PlayerTextDrawBackgroundColor(playerid, g_txdTaximeter[playerid], 255);
    PlayerTextDrawFont(playerid, g_txdTaximeter[playerid], 2);
    PlayerTextDrawLetterSize(playerid, g_txdTaximeter[playerid], 0.270000, 1.799999);
    PlayerTextDrawColor(playerid, g_txdTaximeter[playerid], -1);
    PlayerTextDrawSetOutline(playerid, g_txdTaximeter[playerid], 1);
    PlayerTextDrawSetProportional(playerid, g_txdTaximeter[playerid], 1);
    PlayerTextDrawUseBox(playerid, g_txdTaximeter[playerid], 1);
    PlayerTextDrawBoxColor(playerid, g_txdTaximeter[playerid], 77);
    PlayerTextDrawTextSize(playerid, g_txdTaximeter[playerid], 607.000000, 0.000000);
    PlayerTextDrawSetSelectable(playerid, g_txdTaximeter[playerid], 0);

    PlayerTextDrawShow(playerid, g_txdTaximeter[playerid]);
    return 1;
}

HidePassengerTaximeter(playerid)
{
    if(!g_isVisible[playerid])
        return 1;

    g_isVisible[playerid] = false;
    PlayerTextDrawDestroy(playerid, g_txdTaximeter[playerid]);
    return 1;
}

ShowDriverTaximeter(playerid)
{
    if(g_isVisible[playerid])
        return 1;

    g_isVisible[playerid] = true;
    g_txdTaximeter[playerid] = CreatePlayerTextDraw(playerid, 501.000000, 127.000000, "Passageiro 1: $0000000~n~Passageiro 2: $0000000~n~Passageiro 3: $0000000");
    PlayerTextDrawBackgroundColor(playerid, g_txdTaximeter[playerid], 255);
    PlayerTextDrawFont(playerid, g_txdTaximeter[playerid], 2);
    PlayerTextDrawLetterSize(playerid, g_txdTaximeter[playerid], 0.180000, 1.499999);
    PlayerTextDrawColor(playerid, g_txdTaximeter[playerid], -1);
    PlayerTextDrawSetOutline(playerid, g_txdTaximeter[playerid], 1);
    PlayerTextDrawSetProportional(playerid, g_txdTaximeter[playerid], 1);
    PlayerTextDrawUseBox(playerid, g_txdTaximeter[playerid], 1);
    PlayerTextDrawBoxColor(playerid, g_txdTaximeter[playerid], 77);
    PlayerTextDrawTextSize(playerid, g_txdTaximeter[playerid], 607.000000, 0.000000);
    PlayerTextDrawSetSelectable(playerid, g_txdTaximeter[playerid], 0);

    PlayerTextDrawShow(playerid, g_txdTaximeter[playerid]);
    return 1;
}

HideDriverTaximeter(playerid)
{
    if(!g_isVisible[playerid])
        return 1;

    g_isVisible[playerid] = false;
    PlayerTextDrawDestroy(playerid, g_txdTaximeter[playerid]);
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerExitVehicle(playerid, vehicleid)
{
    if(g_playerDistTraveled[playerid] > 0)
    {
        foreach(new i: Player)
		{
			if(GetPlayerVehicleID(i) == vehicleid && GetPlayerState(i) == PLAYER_STATE_DRIVER)
			{
                new cash = g_playerDistTraveled[playerid] * g_playerFarePrice[i];
                HidePassengerTaximeter(playerid);
                g_playerDistTraveled[playerid] = 0;
				if(GetPlayerCash(playerid) >= cash)
				{
					SendClientMessagef(playerid, 0xFFFF00FF, "* Você pagou a corrida. {FFD700}($%i)", cash);
					SendClientMessagef(i, 0xFFFF00FF, "* O passageiro {FFD700}%s{FFFF00} pagou a corrida. {FFD700}($%i)", GetPlayerNamef(playerid), cash);
					GivePlayerCash(playerid, cash);
					GivePlayerCash(i, -cash);
				}
				else
				{
					SendClientMessagef(playerid, 0xFFFF00FF, "* Você pagou {FFD700}$%i{FFFF00}, faltam {FFD700}$%i{FFFF00} negocie com o motorista.", GetPlayerCash(playerid), cash - GetPlayerCash(playerid));
					SendClientMessagef(i, 0xFFFF00FF, "* O passageiro {FFD700}%s{FFFF00} pagou {FFD700}$%i{FFFF00}, faltam {FFD700}$%i{FFFF00} negocie com ele.", GetPlayerNamef(playerid), GetPlayerCash(playerid), cash - GetPlayerCash(playerid));

					GivePlayerCash(i, GetPlayerCash(playerid));
					GivePlayerCash(playerid, -GetPlayerCash(playerid));
				}
			}
        }
    }
    else if(g_isPlayerOnDuty[playerid])
    {
        foreach(new i: Player)
		{
            if(IsPlayerInVehicle(i, GetPlayerVehicleID(playerid)) && i != playerid && g_playerDistTraveled[i] > 0)
            {
                new cash = g_playerDistTraveled[i] * g_playerFarePrice[playerid];
                g_playerDistTraveled[i] = 0;
                if(GetPlayerCash(i) >= cash)
                {
                    SendClientMessagef(i, 0xFFFF00FF, "* Você pagou a corrida. {FFD700}($%i)", cash);
                    SendClientMessagef(playerid, 0xFFFF00FF, "* O passageiro {FFD700}%s{FFFF00} pagou a corrida. {FFD700}($%i)", GetPlayerNamef(i), cash);
                    GivePlayerCash(playerid, cash);
                    GivePlayerCash(i, -cash);
                }
                else
                {
                    SendClientMessagef(i, 0xFFFF00FF, "* Você pagou {FFD700}$%i{FFFF00}, faltam {FFD700}$%i{FFFF00} negocie com o motorista.", GetPlayerCash(i), cash - GetPlayerCash(i));
                    SendClientMessagef(playerid, 0xFFFF00FF, "* O passageiro {FFD700}%s{FFFF00} pagou {FFD700}$%i{FFFF00}, faltam {FFD700}$%i{FFFF00} negocie com ele.", GetPlayerNamef(i), GetPlayerCash(i), cash - GetPlayerCash(i));

                    GivePlayerCash(playerid, GetPlayerCash(i));
                    GivePlayerCash(i, -GetPlayerCash(i));
                }
            }
        }
        HideDriverTaximeter(playerid);
        g_playerFarePrice[playerid] = 0;
        g_isPlayerOnDuty[playerid] = false;
		SendClientMessage(playerid, 0xAFAFAFAF, "* Você não está mais em serviço.");
    }
    return 1;
}

//------------------------------------------------------------------------------

YCMD:corrida(playerid, params[], help)
{
	if(GetVehicleCategory(GetPlayerVehicleID(playerid)) != VEHICLE_CATEGORY_TAXI)
		SendClientMessage(playerid, COLOR_ERROR, "* Você não está em um taxi.");

	else if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		SendClientMessage(playerid, COLOR_ERROR, "* Você não é o motorista.");

	else if(g_isPlayerOnDuty[playerid])
	{
		SendClientActionMessage(playerid, 15.0, "desligou o taximetro.");
        foreach(new i: Player)
		{
			if(IsPlayerInVehicle(i, GetPlayerVehicleID(playerid)) && i != playerid && g_playerDistTraveled[i] > 0)
			{
                new cash = g_playerDistTraveled[i] * g_playerFarePrice[playerid];
                HidePassengerTaximeter(i);
                g_playerDistTraveled[i] = 0;
				if(GetPlayerCash(i) >= cash)
				{
					SendClientMessagef(i, 0xFFFF00FF, "* Você pagou a corrida. {FFD700}($%i)", cash);
					SendClientMessagef(playerid, 0xFFFF00FF, "* O passageiro {FFD700}%s{FFFF00} pagou a corrida. {FFD700}($%i)", GetPlayerNamef(i), cash);
					GivePlayerCash(playerid, cash);
					GivePlayerCash(i, -cash);
				}
				else
				{
					SendClientMessagef(i, 0xFFFF00FF, "* Você pagou {FFD700}$%i{FFFF00}, faltam {FFD700}$%i{FFFF00} negocie com o motorista.", GetPlayerCash(i), cash - GetPlayerCash(i));
					SendClientMessagef(playerid, 0xFFFF00FF, "* O passageiro {FFD700}%s{FFFF00} pagou {FFD700}$%i{FFFF00}, faltam {FFD700}$%i{FFFF00} negocie com ele.", GetPlayerNamef(i), GetPlayerCash(i), cash - GetPlayerCash(i));

					GivePlayerCash(playerid, GetPlayerCash(i));
					GivePlayerCash(i, -GetPlayerCash(i));
				}
			}
		}
        HideDriverTaximeter(playerid);
        g_playerFarePrice[playerid] = 0;
        g_isPlayerOnDuty[playerid] = false;
		SendClientMessage(playerid, 0xAFAFAFAF, "* Você não está mais em serviço.");
	}

	else
	{
		if(isnull(params))
			return SendClientMessage(playerid, COLOR_INFO, "/corrida [preço]");

		else if(!IsNumeric(params))
			SendClientMessage(playerid, COLOR_ERROR, "* Utilize apenas números.");

		else if(strval(params) < 1)
			SendClientMessage(playerid, COLOR_ERROR, "* Utilize apenas valores positivos.");

		else
		{
			if(strval(params) < 1 || strval(params) > 25)
				SendClientMessage(playerid, COLOR_ERROR, "* Use apenas valores entre 1 e 25.");

			else
			{
                ShowDriverTaximeter(playerid);
                g_isPlayerOnDuty[playerid] = true;
				g_playerFarePrice[playerid] = strval(params);
				SendClientMessageToAllf(0x00D900C8, "Anúncio: O Taxista %s está trabalhando, Corrida: $%i, Contato: %i.", GetPlayerNamef(playerid), g_playerFarePrice[playerid], GetPlayerPhoneNumber(playerid));
			}
		}
	}
	return 1;
}
