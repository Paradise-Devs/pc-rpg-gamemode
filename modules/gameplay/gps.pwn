/* *************************************************************************** *
*  Description: GPS module file.
*
*  Assignment: A script that adds GPS for players.
*
*           Copyright Paradise Devs 2015.  All rights reserved.
* *************************************************************************** */

#include <YSI\y_hooks>

YCMD:gps(playerid, params[], help)
{
	if(!GetPlayerGPS(playerid))
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não possui um GPS.");

    else if(GetPlayerGPS(playerid) < gettime())
		return SendClientMessage(playerid, COLOR_ERROR, "* Seu GPS está quebrado.");

	PlaySelectSound(playerid);
	ShowPlayerDialog(playerid, DIALOG_GPS, DIALOG_STYLE_LIST, "GPS", "1.\tPontos de Interesse\n2.\tEmpresas\n3.\tCasas\n4.\tEmpregos", "Confirmar", "Sair");
	return true;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch(dialogid)
    {
        case DIALOG_GPS:
		{
			if(!response)
			{
				PlayCancelSound(playerid);
				return 1;
			}

			PlaySelectSound(playerid);
			switch(listitem)
			{
				case 0:
					ShowPlayerDialog(playerid, DIALOG_GPS_INTEREST, DIALOG_STYLE_LIST, "GPS -> Pontos de Interesse", "1.\tPrefeitura\n2.\tAuto Escola\n3.\tCaixa eletrônico\n4.\tLotérica", "Marcar", "Voltar");
				case 1:
					ShowPlayerDialog(playerid, DIALOG_GPS_BUSINESS, DIALOG_STYLE_LIST, "GPS -> Empresa", "1.\t24-7\n2.\tTelefone\n3.\tRestaurante\n4.\tAmmunation\n5.\tRoupas\n6.\tPosto de Gasolina\n7.\tAnuncios\n8.\tBar/Club\n9.\tBurger Shot\n10.\tCluckin' Bell\n11.\tPizzaria", "Marcar", "Voltar");
				case 2:
					ShowPlayerDialog(playerid, DIALOG_GPS_HOUSES, DIALOG_STYLE_LIST, "GPS -> Casa", "1.\tA venda\n2.\tQualquer", "Marcar", "Voltar");
				case 3:
					ShowPlayerDialog(playerid, DIALOG_GPS_JOBS, DIALOG_STYLE_TABLIST_HEADERS, "GPS -> Empregos", "\tNº\tEmprego\tNível\n1.\tPizzaboy\t1\n2.\tMotorista\t1\n3.\tNavegador\t7\n4.\tPiloto\t10\n5.\tLimpador de rua\t2\n6.\tTaxista\t3\n7.\tLixeiro\t4\n8.\tCaminhoneiro\t5\n\t9.\tLadrão de Carros\t2", "Marcar", "Voltar");
			}
		}
		case DIALOG_GPS_JOBS:
		{
			if(!response)
			{
				PlayCancelSound(playerid);
				ShowPlayerDialog(playerid, DIALOG_GPS, DIALOG_STYLE_LIST, "GPS", "1.\tPontos de Interesse\n2.\tEmpresas\n3.\tCasas\n4.\tEmpregos", "Confirmar", "Sair");
				return 1;
			}
			PlaySelectSound(playerid);
			switch(listitem)
			{
				case 0:
                {
					SetPlayerRaceCheckpoint(playerid, 1, 2101.5376, -1811.8586, 13.5547, 0.0, 0.0, 0.0, 1.0);
                    SetPlayerCPID(playerid, CHECKPOINT_GPS);
                }
				case 1:
                {
					SetPlayerRaceCheckpoint(playerid, 1, 1193.7578, -1768.7865, 13.5822, 0.0, 0.0, 0.0, 1.0);
                    SetPlayerCPID(playerid, CHECKPOINT_GPS);
                }
				case 2:
                {
					SetPlayerRaceCheckpoint(playerid, 1, 2591.8357, -2459.0618, 3.00000, 0.0, 0.0, 0.0, 1.0);
                    SetPlayerCPID(playerid, CHECKPOINT_GPS);
                }
				case 3:
                {
					SetPlayerRaceCheckpoint(playerid, 1, 1920.8574, -2633.5422, 13.5469, 0.0, 0.0, 0.0, 1.0);
                    SetPlayerCPID(playerid, CHECKPOINT_GPS);
                }
				case 4:
                {
					SetPlayerRaceCheckpoint(playerid, 1, 1628.6396, -1885.5317, 13.5535, 0.0, 0.0, 0.0, 1.0);
                    SetPlayerCPID(playerid, CHECKPOINT_GPS);
                }
				case 5:
                {
					SetPlayerRaceCheckpoint(playerid, 1, 1742.9674, -1862.4082, 13.5763, 0.0, 0.0, 0.0, 1.0);
                    SetPlayerCPID(playerid, CHECKPOINT_GPS);
                }
				case 6:
                {
					SetPlayerRaceCheckpoint(playerid, 1, 2192.1270, -1973.7391, 13.5598, 0.0, 0.0, 0.0, 1.0);
                    SetPlayerCPID(playerid, CHECKPOINT_GPS);
                }
				case 7:
                {
					SetPlayerRaceCheckpoint(playerid, 1, 2442.5039, -2110.0667, 13.5530, 0.0, 0.0, 0.0, 1.0);
                    SetPlayerCPID(playerid, CHECKPOINT_GPS);
                }
				case 8:
                {
					SetPlayerRaceCheckpoint(playerid, 1, 2183.8906, -2252.0417, 14.7710, 0.0, 0.0, 0.0, 1.0);
                    SetPlayerCPID(playerid, CHECKPOINT_GPS);
                }
			}
		}
		case DIALOG_GPS_INTEREST:
		{
			if(!response)
			{
				PlayCancelSound(playerid);
				ShowPlayerDialog(playerid, DIALOG_GPS, DIALOG_STYLE_LIST, "GPS", "1.\tPontos de Interesse\n2.\tEmpresas\n3.\tCasas\n4.\tEmpregos", "Confirmar", "Sair");
				return 1;
			}
			PlaySelectSound(playerid);
			switch(listitem)
			{
				case 0:
                {
					SetPlayerRaceCheckpoint(playerid, 1, 1481.1730, -1765.8840, 18.7958, 0.0, 0.0, 0.0, 1.0);
                    SetPlayerCPID(playerid, CHECKPOINT_GPS);
                }
				case 1:
                {
					SetPlayerRaceCheckpoint(playerid, 1, 1310.2917, -1374.7423, 13.6325, 0.0, 0.0, 0.0, 1.0);
                    SetPlayerCPID(playerid, CHECKPOINT_GPS);
                }
				case 2:
				{
					/*new Float:distance = Float:0x7F800000;
					new closestID = 0;
					for(new i = 0; i < sizeof(gBankPositions); i++)
					{
						if(GetPlayerDistanceFromPoint(playerid, gBankPositions[i][0], gBankPositions[i][1], gBankPositions[i][2]) < distance)
						{
							distance = GetPlayerDistanceFromPoint(playerid, gBankPositions[i][0], gBankPositions[i][1], gBankPositions[i][2]);
							closestID = i;
						}
					}
					SetPlayerCheckpoint(playerid, gBankPositions[closestID][0], gBankPositions[closestID][1], gBankPositions[closestID][2], 1.0);
                    SetPlayerCPID(playerid, CHECKPOINT_GPS);
                    */
				}
				case 3:
                {
					SetPlayerRaceCheckpoint(playerid, 1, 1631.6721, -1170.2147, 24.0781, 0.0, 0.0, 0.0, 1.0);
                    SetPlayerCPID(playerid, CHECKPOINT_GPS);
                }
			}
		}
		case DIALOG_GPS_BUSINESS:
		{
			if(!response)
			{
				PlayCancelSound(playerid);
				ShowPlayerDialog(playerid, DIALOG_GPS, DIALOG_STYLE_LIST, "GPS", "1.\tPontos de Interesse\n2.\tEmpresas\n3.\tCasas\n4.\tEmpregos", "Confirmar", "Sair");
				return 1;
			}
			new b;
			switch(listitem)
			{
				case 0:
					b = GetClosestBusinessFromPlayer(playerid, BUSINESS_TYPE_STORE);
				case 1:
					b = GetClosestBusinessFromPlayer(playerid, BUSINESS_TYPE_PHONE);
				case 2:
					b = GetClosestBusinessFromPlayer(playerid, BUSINESS_TYPE_RESTAURANT);
				case 3:
					b = GetClosestBusinessFromPlayer(playerid, BUSINESS_TYPE_AMMUNATION);
				case 4:
					b = GetClosestBusinessFromPlayer(playerid, BUSINESS_TYPE_CLOTHES);
				case 5:
					b = GetClosestBusinessFromPlayer(playerid, BUSINESS_TYPE_FUEL);
				case 6:
					b = GetClosestBusinessFromPlayer(playerid, BUSINESS_TYPE_ADVERTISE);
				case 7:
					b = GetClosestBusinessFromPlayer(playerid, BUSINESS_TYPE_CLUB);
				case 8:
					b = GetClosestBusinessFromPlayer(playerid, BUSINESS_TYPE_BURGER);
				case 9:
					b = GetClosestBusinessFromPlayer(playerid, BUSINESS_TYPE_CLUCKIN);
				case 10:
					b = GetClosestBusinessFromPlayer(playerid, BUSINESS_TYPE_PIZZA);
			}
			PlaySelectSound(playerid);
			new Float:X, Float:Y, Float:Z;
			GetBusinessEntrancePos(b, X, Y, Z);
			SetPlayerRaceCheckpoint(playerid, 1, X, Y, Z, 0.0, 0.0, 0.0, 1.0);
            SetPlayerCPID(playerid, CHECKPOINT_GPS);
		}
		case DIALOG_GPS_HOUSES:
		{
			if(!response)
			{
				PlayCancelSound(playerid);
				ShowPlayerDialog(playerid, DIALOG_GPS, DIALOG_STYLE_LIST, "GPS", "1.\tPontos de Interesse\n2.\tEmpresas\n3.\tCasas\n4.\tEmpregos", "Confirmar", "Sair");
				return 1;
			}

			new h;
			switch(listitem)
			{
				case 0:
					h = GetClosestHouseFromPlayer(playerid, true);
				case 1:
					h = GetClosestHouseFromPlayer(playerid, false);
			}
			PlaySelectSound(playerid);
			new Float:X, Float:Y, Float:Z;
			GetHouseEntrance(h, X, Y, Z);
			SetPlayerRaceCheckpoint(playerid, 1, X, Y, Z, 0.0, 0.0, 0.0, 1.0);
            SetPlayerCPID(playerid, CHECKPOINT_GPS);
		}
    }
    return 1;
}

hook OnPlayerEnterRaceCPT(playerid)
{
    if(GetPlayerCPID(playerid) != CHECKPOINT_GPS)
        return 1;

	PlaySelectSound(playerid);
	DisablePlayerRaceCheckpoint(playerid);
    SetPlayerCPID(playerid, CHECKPOINT_NONE);
    return 1;
}
