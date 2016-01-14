/*******************************************************************************
* FILENAME :        modules/faction/lspd.pwn
*
* DESCRIPTION :
*       Adds LSPD faction to the server.
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

static const Float:gfArrestPosition[] =
{
	201.5512, 168.2697, 1003.0234
};

static const Float:gfDutyPosition[] =
{
	232.2859, 165.1491, 1003.0234
};

//------------------------------------------------------------------------------

hook OnGameModeInit()
{
	CreateDynamicPickup(1247, 1, gfArrestPosition[0], gfArrestPosition[1], gfArrestPosition[2], 0, 3, -1, MAX_PICKUP_RANGE);
	CreateDynamic3DTextLabel("Prisão", 0xFFFFFFFF, gfArrestPosition[0], gfArrestPosition[1], gfArrestPosition[2], MAX_TEXT3D_RANGE, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);

	CreateDynamicPickup(1242, 1, gfDutyPosition[0], gfDutyPosition[1], gfDutyPosition[2], 0, 3, -1, MAX_PICKUP_RANGE);
	CreateDynamic3DTextLabel("Serviço", 0xFFFFFFFF, gfDutyPosition[0], gfDutyPosition[1], gfDutyPosition[2], MAX_TEXT3D_RANGE, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
}

//------------------------------------------------------------------------------

YCMD:servico(playerid, params[], help)
{
	if(GetFactionType(GetPlayerFactionID(playerid)) != FACTION_TYPE_POLICE)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

	else if(!IsPlayerInRangeOfPoint(playerid, 5.0, gfDutyPosition[0], gfDutyPosition[1], gfDutyPosition[2]))
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não está no local de serviço da LSPD.");

	if(!IsPlayerOnDuty(playerid))
	{
		SetPlayerFactionSkin(playerid);
		SendClientActionMessage(playerid, 20.0, "entrou em serviço.");
	}
	else
	{
		SetPlayerSkin(playerid, GetPlayerSavedSkin(playerid));
		SendClientActionMessage(playerid, 20.0, "saiu de serviço.");
	}
	return 1;
}

//------------------------------------------------------------------------------

YCMD:megafone(playerid, params[], help)
{
	if(GetFactionType(GetPlayerFactionID(playerid)) != FACTION_TYPE_POLICE)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

	else if(!IsPlayerInAnyVehicle(playerid) || GetVehicleFactionID(GetPlayerVehicleID(playerid)) != GetPlayerFactionID(playerid))
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não está em um veículo da LSPD.");

	else if(isnull(params))
		return SendClientMessage(playerid, COLOR_INFO, "* /megafone [mensagem]");

	new message[208];
	foreach(new i: Player)
	{
		if(GetPlayerDistanceFromPlayer(playerid, i) < 40.0)
		{
			format(message, sizeof(message), "* {D9E15A}Megafone{ffff00} %s %s: %s", GetFactionRankName(GetPlayerFactionID(playerid), GetPlayerFactionRankID(playerid)), GetPlayerNamef(playerid), params);
			SendMultiMessage(i, 0xffff00ff, message);
		}
	}
	return 1;
}

//------------------------------------------------------------------------------

YCMD:prender(playerid, params[], help)
{
	if(GetFactionType(GetPlayerFactionID(playerid)) != FACTION_TYPE_POLICE)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

	else if(!IsPlayerInRangeOfPoint(playerid, 5.0, gfArrestPosition[0], gfArrestPosition[1], gfArrestPosition[2]))
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não está no local de prisão dentro da LSPD.");

	else if(!IsPlayerOnDuty(playerid))
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não está em serviço.");

	new targetid, time;
	if(sscanf(params, "ui", targetid, time))
		return SendClientMessage(playerid, COLOR_INFO, "* /prender [playerid] [tempo(minutos)]");

	else if(!IsPlayerLogged(targetid))
		return SendClientMessage(playerid, COLOR_ERROR, "* O jogador não está conectado.");

	else if(playerid == targetid)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não pode prender você mesmo.");

	else if(IsPlayerNPC(targetid))
		return SendClientMessage(playerid, COLOR_ERROR, "* Jogador inválido.");

	else if(GetPlayerDistanceFromPlayer(playerid, targetid) > 5.0)
		return SendClientMessage(playerid, COLOR_ERROR, "* O jogador precisa estar próximo a você.");

	else if(time < 5)
		return SendClientMessage(playerid, COLOR_ERROR, "* Tempo de prisão não pode ser inferior a 5 minutos.");

	new output[17 + (MAX_PLAYER_NAME * 2)];
	format(output, sizeof(output), "prendeu %s.", GetPlayerNamef(targetid));
	SendClientActionMessage(playerid, 20.0, output);

	PutPlayerInPrision(targetid, time * 60);
	return 1;
}

//------------------------------------------------------------------------------

YCMD:ajustarpena(playerid, params[], help)
{
	if(GetFactionType(GetPlayerFactionID(playerid)) != FACTION_TYPE_POLICE)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

	else if(!IsPlayerOnDuty(playerid))
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não está em serviço.");

	new targetid, time;
	if(sscanf(params, "ui", targetid, time))
		return SendClientMessage(playerid, COLOR_INFO, "* /ajustarpena [playerid] [tempo(minutos)]");

	else if(!IsPlayerLogged(targetid))
		return SendClientMessage(playerid, COLOR_ERROR, "* O jogador não está conectado.");

	else if(playerid == targetid)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não pode ajustar você mesmo.");

	else if(IsPlayerNPC(targetid))
		return SendClientMessage(playerid, COLOR_ERROR, "* Jogador inválido.");

	else if(GetPlayerDistanceFromPlayer(playerid, targetid) > 5.0)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não está próximo do jogador.");

	else if(!IsPlayerInPrision(targetid))
		return SendClientMessage(playerid, COLOR_ERROR, "* O jogador não está preso.");

	else if(time < 5)
		return SendClientMessage(playerid, COLOR_ERROR, "* Tempo de prisão não pode ser inferior a 5 minutos.");

	new output[27 + (MAX_PLAYER_NAME * 2)];
	format(output, sizeof(output), "ajustou a pena de %s.", GetPlayerNamef(targetid));
	SendClientActionMessage(playerid, 20.0, output);

	SetPlayerPrisionTime(targetid, time * 60);
	return 1;
}

//------------------------------------------------------------------------------

YCMD:libertar(playerid, params[], help)
{
	if(GetFactionType(GetPlayerFactionID(playerid)) != FACTION_TYPE_POLICE)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

	else if(!IsPlayerOnDuty(playerid))
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não está em serviço.");

	new targetid;
	if(sscanf(params, "u", targetid))
		return SendClientMessage(playerid, COLOR_INFO, "* /ajustarpena [playerid]");

	else if(!IsPlayerLogged(targetid))
		return SendClientMessage(playerid, COLOR_ERROR, "* O jogador não está conectado.");

	else if(playerid == targetid)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não pode libertar você mesmo.");

	else if(IsPlayerNPC(targetid))
		return SendClientMessage(playerid, COLOR_ERROR, "* Jogador inválido.");

	else if(GetPlayerDistanceFromPlayer(playerid, targetid) > 5.0)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não está próximo do jogador.");

	else if(!IsPlayerInPrision(targetid))
		return SendClientMessage(playerid, COLOR_ERROR, "* O jogador não está preso.");

	new output[27 + (MAX_PLAYER_NAME * 2)];
	format(output, sizeof(output), "libertou %s da prisão.", GetPlayerNamef(targetid));
	SendClientActionMessage(playerid, 20.0, output);

	SetPlayerPrisionTime(targetid, 1);
	return 1;
}

//------------------------------------------------------------------------------

YCMD:algemar(playerid, params[], help)
{
	if(GetFactionType(GetPlayerFactionID(playerid)) != FACTION_TYPE_POLICE)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

	else if(!IsPlayerOnDuty(playerid))
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não está em serviço.");

	new targetid;
	if(sscanf(params, "u", targetid))
		return SendClientMessage(playerid, COLOR_INFO, "* /algemar [playerid]");

	else if(!IsPlayerLogged(targetid))
		return SendClientMessage(playerid, COLOR_ERROR, "* O jogador não está conectado.");

	else if(IsPlayerNPC(targetid))
		return SendClientMessage(playerid, COLOR_ERROR, "* Jogador inválido.");

	else if(GetPlayerDistanceFromPlayer(playerid, targetid) > 5.0)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não está próximo do jogador.");

	else if(GetPlayerState(targetid) == PLAYER_STATE_DRIVER)
		return SendClientMessage(playerid, COLOR_ERROR, "* O jogador não pode ser um motorista.");

	else if(IsPlayerCuffed(targetid))
		return SendClientMessage(playerid, COLOR_ERROR, "* O jogador já está algemado.");

	if(playerid == targetid)
	{
		SendClientActionMessage(playerid, 20.0, "algemou si mesmo.");
		SetPlayerCuffed(targetid, true);
	}
	else
	{
		new output[14 + MAX_PLAYER_NAME];
		format(output, sizeof(output), "tenta algemar %s.", GetPlayerNamef(targetid));
		SendClientActionMessage(playerid, 20.0, output);

		GameTextForPlayer(playerid, "~w~algemando...", 1250, 3);
		GameTextForPlayer(targetid, "~w~algemando...", 1250, 3);

		new Float:playerPos[3], Float:targetPos[3];
		GetPlayerPos(playerid, playerPos[0], playerPos[1], playerPos[2]);
		GetPlayerPos(targetid, targetPos[0], targetPos[1], targetPos[2]);
		defer OnPlayerHandCuffPlayer(playerid, targetid, playerPos[0], playerPos[1], playerPos[2], targetPos[0], targetPos[1], targetPos[2]);
	}
	return 1;
}

//------------------------------------------------------------------------------

YCMD:desalgemar(playerid, params[], help)
{
	if(GetFactionType(GetPlayerFactionID(playerid)) != FACTION_TYPE_POLICE)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

	else if(!IsPlayerOnDuty(playerid))
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não está em serviço.");

	new targetid;
	if(sscanf(params, "u", targetid))
		return SendClientMessage(playerid, COLOR_INFO, "* /desalgemar [playerid]");

	else if(!IsPlayerLogged(targetid))
		return SendClientMessage(playerid, COLOR_ERROR, "* O jogador não está conectado.");

	else if(playerid == targetid)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não pode desalgemar você mesmo.");

	else if(IsPlayerNPC(targetid))
		return SendClientMessage(playerid, COLOR_ERROR, "* Jogador inválido.");

	else if(GetPlayerDistanceFromPlayer(playerid, targetid) > 5.0)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não está próximo do jogador.");

	else if(!IsPlayerCuffed(targetid))
		return SendClientMessage(playerid, COLOR_ERROR, "* O jogador não está algemado.");

	new output[27 + (MAX_PLAYER_NAME * 2)];
	format(output, sizeof(output), "desalgemou %s.", GetPlayerNamef(targetid));
	SendClientActionMessage(playerid, 20.0, output);

	SetPlayerCuffed(targetid, false);
	return 1;
}

//------------------------------------------------------------------------------

timer OnPlayerHandCuffPlayer[1250](playerid, targetid, Float:pPosX, Float:pPosY, Float:pPosZ, Float:tPosX, Float:tPosY, Float:tPosZ)
{
	new Float:playerPos[3], Float:targetPos[3];
	GetPlayerPos(playerid, playerPos[0], playerPos[1], playerPos[2]);
	GetPlayerPos(targetid, targetPos[0], targetPos[1], targetPos[2]);

	if(pPosX == playerPos[0] && pPosY == playerPos[1] && pPosZ == playerPos[2] &&
		tPosX == targetPos[0] && tPosY == targetPos[1] && tPosZ == targetPos[2])
	{
		GameTextForPlayer(playerid, "~g~algemado...", 1250, 3);
		GameTextForPlayer(targetid, "~r~algemado...", 1250, 3);

		new output[14 + MAX_PLAYER_NAME];
		format(output, sizeof(output), "algemou %s.", GetPlayerNamef(targetid));
		SendClientActionMessage(playerid, 20.0, output);

		SetPlayerCuffed(targetid, true);
	}
	else
	{
		GameTextForPlayer(playerid, "~r~falhou...", 1250, 3);
		GameTextForPlayer(targetid, "~g~falhou...", 1250, 3);

		new output[29 + MAX_PLAYER_NAME];
		format(output, sizeof(output), "falhou ao tentar algemar %s.", GetPlayerNamef(targetid));
		SendClientActionMessage(playerid, 20.0, output);
	}
}
