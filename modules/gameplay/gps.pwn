/* *************************************************************************** *
*  Description: GPS module file.
*
*  Assignment: A script that adds GPS for players.
*
*           Copyright Paradise Devs 2015.  All rights reserved.
* *************************************************************************** */

//variáveis GPS

enum GPSData
{
	bool:isActive,
	target_location[64],
	Float:target_x,
	Float:target_y,
	Float:target_z,
	gps_arrow,
	PlayerText3D:target_label,
	Float:label_height
}
static PlayerGPSInfo[MAX_PLAYERS][GPSData];

#include <YSI\y_hooks>

Float:GetPointAngle(playerid, Float:xa, Float:ya, Float:xb, Float:yb)
{
	new Float:carangle;
	new Float:xc, Float:yc;
	new Float:angle;
	xc = floatabs(floatsub(xa, xb));
	yc = floatabs(floatsub(ya, yb));
	if(yc == 0.0 || xc == 0.0)
	{
		if(yc == 0 && xc > 0) angle = 0.0;
		else if(yc == 0 && xc < 0) angle = 180.0;
		else if(yc > 0 && xc == 0) angle = 90.0;
		else if(yc < 0 && xc == 0) angle = 270.0;
		else if(yc == 0 && xc == 0) angle = 0.0;
	}
	else
	{
		angle = atan(xc/yc);
		if(xb > xa && yb <= ya) angle += 90.0;
		else if(xb <= xa && yb < ya) angle = floatsub(90.0, angle);
		else if(xb < xa && yb >= ya) angle -= 90.0;
		else if(xb >= xa && yb > ya) angle = floatsub(270.0, angle);
	}
	GetVehicleZAngle(GetPlayerVehicleID(playerid), carangle);
	return floatadd(angle, -carangle);
}

Float:GetVehicleZSize(vehicleid)
{
	new Float:tmp, Float:size;
	GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_SIZE, tmp, tmp, size);
	return size;
}

YCMD:gps(playerid, params[], help)
{
	if(PlayerGPSInfo[playerid][isActive])
		return SendClientMessage(playerid, COLOR_ERROR, "* Você já possui uma rota no GPS, utilize /cancelargps para selecionar um novo destino.");

	if(!GetPlayerGPS(playerid))
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não possui um GPS.");

    else if(GetPlayerGPS(playerid) < gettime())
		return SendClientMessage(playerid, COLOR_ERROR, "* Seu GPS está quebrado.");

	PlaySelectSound(playerid);
	ShowPlayerDialog(playerid, DIALOG_GPS, DIALOG_STYLE_LIST, "GPS", "1.\tPontos de Interesse\n2.\tEmpresas\n3.\tCasas\n4.\tEmpregos", "Confirmar", "Sair");
	return true;
}

YCMD:cancelargps(playerid, params[], help)
{
	if(!PlayerGPSInfo[playerid][isActive])
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não selecionou nenhum destino no GPS até o momento.");

	PlaySelectSound(playerid);
	UnsetPlayerGPS(playerid, false);
	DisablePlayerRaceCheckpoint(playerid);
    SetPlayerCPID(playerid, CHECKPOINT_NONE);
	return 1;
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
					ShowPlayerDialog(playerid, DIALOG_GPS_INTEREST, DIALOG_STYLE_LIST, "GPS -> Pontos de Interesse", "1.\tPrefeitura\n2.\tAuto Escola\n3.\tCaixa eletrônico\n4.\tLotérica\n5.\tBanco\n6.\tPetshop", "Marcar", "Voltar");
				case 1:
					ShowPlayerDialog(playerid, DIALOG_GPS_BUSINESS, DIALOG_STYLE_LIST, "GPS -> Empresa", "1.\t24-7\n2.\tTelefone\n3.\tRestaurante\n4.\tAmmunation\n5.\tRoupas\n6.\tPosto de Gasolina\n7.\tAnuncios\n8.\tBar/Club\n9.\tBurger Shot\n10.\tCluckin' Bell\n11.\tPizzaria", "Marcar", "Voltar");
				case 2:
					ShowPlayerDialog(playerid, DIALOG_GPS_HOUSES, DIALOG_STYLE_LIST, "GPS -> Casa", "1.\tA venda\n2.\tQualquer", "Marcar", "Voltar");
				case 3:
					ShowPlayerDialog(playerid, DIALOG_GPS_JOBS, DIALOG_STYLE_TABLIST_HEADERS, "GPS -> Empregos", "\tNº\tEmprego\tNível\n1.\tPizzaboy\t1\n2.\tMotorista\t1\n3.\tNavegador\t2\n4.\tPiloto\t2\n5.\tLimpador de rua\t1\n6.\tLixeiro\t1\n7.\tCaminhoneiro\t2\n8.\tParamedico\t3\n9.\tLenhador\t1\n10.\tPescador\t2", "Marcar", "Voltar");
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
					SetPlayerRaceCheckpoint(playerid, 2, 2101.5376, -1811.8586, 13.5547, 0.0, 0.0, 0.0, 1.0);
                    SetPlayerCPID(playerid, CHECKPOINT_GPS);
					ShowPlayerLocationFromGPS(playerid, 2101.5376, -1811.8586, 13.5547);
                }
				case 1:
                {
					SetPlayerRaceCheckpoint(playerid, 2, 1193.7578, -1768.7865, 13.5822, 0.0, 0.0, 0.0, 1.0);
                    SetPlayerCPID(playerid, CHECKPOINT_GPS);
					ShowPlayerLocationFromGPS(playerid, 1193.7578, -1768.7865, 13.5822);
                }
				case 2:
                {
					SetPlayerRaceCheckpoint(playerid, 2, 2280.0159, -2417.9700, 3.0000, 0.0, 0.0, 0.0, 1.0);
                    SetPlayerCPID(playerid, CHECKPOINT_GPS);
					ShowPlayerLocationFromGPS(playerid, 2280.0159, -2417.9700, 3.0000);
                }
				case 3:
                {
					SetPlayerRaceCheckpoint(playerid, 2, 1954.4822, -2177.7603, 13.5469, 0.0, 0.0, 0.0, 1.0);
                    SetPlayerCPID(playerid, CHECKPOINT_GPS);
					ShowPlayerLocationFromGPS(playerid, 1954.4822, -2177.7603, 13.5469);
                }
				case 4:
                {
					SetPlayerRaceCheckpoint(playerid, 2, 1628.6396, -1885.5317, 13.5535, 0.0, 0.0, 0.0, 1.0);
                    SetPlayerCPID(playerid, CHECKPOINT_GPS);
					ShowPlayerLocationFromGPS(playerid, 1628.6396, -1885.5317, 13.5535);
                }
				case 5:
                {
					SetPlayerRaceCheckpoint(playerid, 2, 2195.4722, -1973.8459, 13.5590, 0.0, 0.0, 0.0, 1.0);
                    SetPlayerCPID(playerid, CHECKPOINT_GPS);
					ShowPlayerLocationFromGPS(playerid, 2195.4722, -1973.8459, 13.5590);
                }
				case 6:
                {
					SetPlayerRaceCheckpoint(playerid, 2, 2442.5039, -2110.0667, 13.5530, 0.0, 0.0, 0.0, 1.0);
                    SetPlayerCPID(playerid, CHECKPOINT_GPS);
					ShowPlayerLocationFromGPS(playerid, 2442.5039, -2110.0667, 13.5530);
                }
				case 7:
                {
					SetPlayerRaceCheckpoint(playerid, 2, 1183.1554, -1313.3402, 13.5681, 0.0, 0.0, 0.0, 1.0);
                    SetPlayerCPID(playerid, CHECKPOINT_GPS);
					ShowPlayerLocationFromGPS(playerid, 1183.1554, -1313.3402, 13.5681);
                }
				case 8:
                {
					SetPlayerRaceCheckpoint(playerid, 2, -77.3012, -1136.5502, 1.0781, 0.0, 0.0, 0.0, 1.0);
                    SetPlayerCPID(playerid, CHECKPOINT_GPS);
					ShowPlayerLocationFromGPS(playerid, -77.3012, -1136.5502, 1.0781);
                }
				case 9:
                {
					SetPlayerRaceCheckpoint(playerid, 2, 391.8892, -2050.9883, 7.8359, 0.0, 0.0, 0.0, 1.0);
                    SetPlayerCPID(playerid, CHECKPOINT_GPS);
					ShowPlayerLocationFromGPS(playerid, 391.8892, -2050.9883, 7.8359);
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
					SetPlayerRaceCheckpoint(playerid, 2, 1481.1730, -1765.8840, 18.7958, 0.0, 0.0, 0.0, 1.0);
                    SetPlayerCPID(playerid, CHECKPOINT_GPS);
					ShowPlayerLocationFromGPS(playerid, 1481.1730, -1765.8840, 18.7958);
                }
				case 1:
                {
					SetPlayerRaceCheckpoint(playerid, 2, 1310.2917, -1374.7423, 13.6325, 0.0, 0.0, 0.0, 1.0);
                    SetPlayerCPID(playerid, CHECKPOINT_GPS);
					ShowPlayerLocationFromGPS(playerid, 1310.2917, -1374.7423, 13.6325);
                }
				case 2:
				{
					new Float:distance = Float:0x7F800000;
					new closestID = 0;
					for(new i = 0; i < sizeof(gBankPositions); i++)
					{
						if(GetPlayerDistanceFromPoint(playerid, gBankPositions[i][0], gBankPositions[i][1], gBankPositions[i][2]) < distance)
						{
							distance = GetPlayerDistanceFromPoint(playerid, gBankPositions[i][0], gBankPositions[i][1], gBankPositions[i][2]);
							closestID = i;
						}
					}
					SetPlayerRaceCheckpoint(playerid, 2, gBankPositions[closestID][0], gBankPositions[closestID][1], gBankPositions[closestID][2], 0.0, 0.0, 0.0, 1.0);
                    SetPlayerCPID(playerid, CHECKPOINT_GPS);
					ShowPlayerLocationFromGPS(playerid, gBankPositions[closestID][0], gBankPositions[closestID][1], gBankPositions[closestID][2]);
				}
				case 3:
                {
					SetPlayerRaceCheckpoint(playerid, 2, 1631.6721, -1170.2147, 24.0781, 0.0, 0.0, 0.0, 1.0);
                    SetPlayerCPID(playerid, CHECKPOINT_GPS);
					ShowPlayerLocationFromGPS(playerid, 1631.6721, -1170.2147, 24.0781);
                }
				case 4:
				{
					SetPlayerRaceCheckpoint(playerid, 2, 914.4920, -999.6552, 38.0790, 0.0, 0.0, 0.0, 1.0);
                    SetPlayerCPID(playerid, CHECKPOINT_GPS);
					ShowPlayerLocationFromGPS(playerid, 914.4920, -999.6552, 38.0790);
				}
				case 5:
				{
					SetPlayerRaceCheckpoint(playerid, 2, 1378.0410, -1745.4410, 13.5469, 0.0, 0.0, 0.0, 1.0);
                    SetPlayerCPID(playerid, CHECKPOINT_GPS);
					ShowPlayerLocationFromGPS(playerid, 1378.0410, -1745.4410, 13.5469);
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
			SetPlayerRaceCheckpoint(playerid, 2, X, Y, Z, 0.0, 0.0, 0.0, 1.0);
            SetPlayerCPID(playerid, CHECKPOINT_GPS);
			ShowPlayerLocationFromGPS(playerid, X, Y, Z);
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
			SetPlayerRaceCheckpoint(playerid, 2, X, Y, Z, 0.0, 0.0, 0.0, 1.0);
            SetPlayerCPID(playerid, CHECKPOINT_GPS);
			ShowPlayerLocationFromGPS(playerid, X, Y, Z);
		}
    }
    return 1;
}

hook OnPlayerEnterRaceCPT(playerid)
{
    if(GetPlayerCPID(playerid) != CHECKPOINT_GPS)
        return 1;

	PlaySelectSound(playerid);
	UnsetPlayerGPS(playerid, true);
	DisablePlayerRaceCheckpoint(playerid);
    SetPlayerCPID(playerid, CHECKPOINT_NONE);
    return 1;
}

hook OnPlayerUpdate(playerid)
{
	if(IsPlayerInAnyVehicle(playerid) && PlayerGPSInfo[playerid][isActive])
	{
		new Float:VPos[3], Float:rot, strgps[200];
	    GetVehiclePos(GetPlayerVehicleID(playerid), VPos[0], VPos[1], VPos[2]);
	    rot = GetPointAngle(playerid, VPos[0], VPos[1], PlayerGPSInfo[playerid][target_x], PlayerGPSInfo[playerid][target_y]);
	    AttachDynamicObjectToVehicle(PlayerGPSInfo[playerid][gps_arrow], GetPlayerVehicleID(playerid), 0.0, 0.0, PlayerGPSInfo[playerid][label_height] - 0.6, 0.0, 90.0, rot + 180);
		format(strgps, sizeof(strgps), "{697afc}GPS\n{FFFFFF}Destino: {00FF00}%s{FFFFFF}\nDistância restante: {00FF00}%.2fm{FFFFFF}", PlayerGPSInfo[playerid][target_location], GetPlayerDistanceFromPoint(playerid, PlayerGPSInfo[playerid][target_x], PlayerGPSInfo[playerid][target_y], PlayerGPSInfo[playerid][target_z]));
		UpdatePlayer3DTextLabelText(playerid, PlayerGPSInfo[playerid][target_label], 0xFFFFFFFF, strgps);
	}
	return 1;
}

ShowPlayerLocationFromGPS(playerid, Float:PosX, Float:PosY, Float:PosZ)
{
	if(!IsPlayerInAnyVehicle(playerid)) return 0;

	new strgps[200];

	Get2DZoneName(PlayerGPSInfo[playerid][target_location], PosX, PosY);
	PlayerGPSInfo[playerid][isActive] = true;
	PlayerGPSInfo[playerid][target_x] = PosX;
	PlayerGPSInfo[playerid][target_y] = PosY;
	PlayerGPSInfo[playerid][target_z] = PosZ;
	PlayerGPSInfo[playerid][label_height] = GetVehicleZSize(GetPlayerVehicleID(playerid)) + 0.4;
	PlayerGPSInfo[playerid][gps_arrow] = CreateDynamicObject(19134, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1, -1, playerid, 50.0);
	format(strgps, sizeof(strgps), "{697afc}GPS\n{FFFFFF}Destino: {00FF00}%s{FFFFFF}\nDistância restante: {00FF00}%.2fm{FFFFFF}", PlayerGPSInfo[playerid][target_location], GetPlayerDistanceFromPoint(playerid, PlayerGPSInfo[playerid][target_x], PlayerGPSInfo[playerid][target_y], PlayerGPSInfo[playerid][target_z]));
	PlayerGPSInfo[playerid][target_label] = CreatePlayer3DTextLabel(playerid, strgps, 0xFFFFFFFF, 0.0, 0.0, PlayerGPSInfo[playerid][label_height] + 0.2, 5.0, INVALID_PLAYER_ID, GetPlayerVehicleID(playerid), 0);
	format(strgps, sizeof(strgps), "{FFFFFF}* Localização do destino no GPS: {00FF00}%s{FFFFFF}.", PlayerGPSInfo[playerid][target_location]);
	SendClientMessage(playerid, -1, strgps);
	return 1;
}

UnsetPlayerGPS(playerid, bool:target_reached)
{
	format(PlayerGPSInfo[playerid][target_location], 64, "");
	PlayerGPSInfo[playerid][isActive] = false;
	PlayerGPSInfo[playerid][target_x] = 0.0;
	PlayerGPSInfo[playerid][target_y] = 0.0;
	PlayerGPSInfo[playerid][target_z] = 0.0;
	DestroyDynamicObject(PlayerGPSInfo[playerid][gps_arrow]);
	DeletePlayer3DTextLabel(playerid, PlayerGPSInfo[playerid][target_label]);
	if(!target_reached) SendClientMessage(playerid, -1, "{FFFFFF}* Localização do destino no GPS: {FF0000}Cancelada{FFFFFF}.");
	else SendClientMessage(playerid, -1, "{FFFFFF}* Localização do destino no GPS: {00FF00}Você chegou ao seu destino{FFFFFF}!");
	return 1;
}


hook OnPlayerDeath(playerid, killerid, reason)
{
	if(IsPlayerInAnyVehicle(playerid) && PlayerGPSInfo[playerid][isActive])
	{
		PlayCancelSound(playerid);
		UnsetPlayerGPS(playerid, false);
		DisablePlayerRaceCheckpoint(playerid);
		SetPlayerCPID(playerid, CHECKPOINT_NONE);
	}
	return 1;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(oldstate == PLAYER_STATE_DRIVER && newstate != PLAYER_STATE_DRIVER && PlayerGPSInfo[playerid][isActive])
	{
	    PlayCancelSound(playerid);
		UnsetPlayerGPS(playerid, false);
    	DisablePlayerRaceCheckpoint(playerid);
        SetPlayerCPID(playerid, CHECKPOINT_NONE);
	}
	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
    DisablePlayerRaceCheckpoint(playerid);
    SetPlayerCPID(playerid, CHECKPOINT_NONE);
	format(PlayerGPSInfo[playerid][target_location], 64, "");
	PlayerGPSInfo[playerid][isActive] = false;
	PlayerGPSInfo[playerid][target_x] = 0.0;
	PlayerGPSInfo[playerid][target_y] = 0.0;
	PlayerGPSInfo[playerid][target_z] = 0.0;
	DestroyDynamicObject(PlayerGPSInfo[playerid][gps_arrow]);
	DeletePlayer3DTextLabel(playerid, PlayerGPSInfo[playerid][target_label]);
	return 1;
}
