/*******************************************************************************
* FILENAME :        modules/job/fisher.pwn
*
* DESCRIPTION :
*       Adds fisher job to the server.
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

static
	gPizzaTime[MAX_PLAYERS],
	gPizzaOnfootTime[MAX_PLAYERS]
;

static const gJobPayment = 100;

static const Float:g_fBikePositions[][] =
{
    {2097.4712,  -1792.9985,  12.9877,  92.4504},
    {2097.4712,  -1795.8358,  12.9877,  92.4504},
    {2097.4712,  -1798.9197,  12.9877,  92.4504},
    {2097.4712,  -1801.7388,  12.9877,  92.4504},
    {2097.4712,  -1812.4991,  12.9877,  92.4504},
    {2097.4712,  -1815.0825,  12.9877,  92.4504},
    {2097.4712,  -1818.2753,  12.9877,  92.4504},
    {2097.4712,  -1821.4078,  12.9877,  92.4504}
};
static gplBike[MAX_PLAYERS] = {INVALID_VEHICLE_ID, ...};

/* *************************************************************************** *
*  Assignment: Gets the player pizza time
*
*  Params:
*			playerid: ID of the player.
*
*  Returns:
*			The player pizza time
* *************************************************************************** */
stock GetPlayerPizzaTime(playerid)
{
	return gPizzaTime[playerid];
}

/* *************************************************************************** *
*  Assignment: Sets the player pizza time
*
*  Params:
*			playerid: ID of the player.
* 			time:	The time
*
*  Returns:
*			The player pizza time
* *************************************************************************** */

stock SetPlayerPizzaTime(playerid, value)
{
	gPizzaTime[playerid] = value;
}

/* *************************************************************************** *
*  Assignment: Gets the player onfoot time
*
*  Params:
*			playerid: ID of the player.
*
*  Returns:
*			The player onfoot time
* *************************************************************************** */
stock GetPlayerPizzaOnfootTime(playerid)
{
	return gPizzaOnfootTime[playerid];
}

/* *************************************************************************** *
*  Assignment: Sets the player onfoot time
*
*  Params:
*			playerid: ID of the player.
* 			time:	The time
*
*  Returns:
*			The player onfoot time
* *************************************************************************** */
stock SetPlayerPizzaOnfootTime(playerid, value)
{
	gPizzaOnfootTime[playerid] = value;
}

//------------------------------------------------------------------------------

hook OnGameModeInit()
{
	CreateDynamicPickup(1210, 1, 2101.5376, -1811.8586, 13.5547, 0, 0, -1, MAX_PICKUP_RANGE); // Icone emprego
	CreateDynamicPickup(1239, 1, 2093.7966, -1792.2350, 13.3889, 0, 0, -1, MAX_PICKUP_RANGE); // Icone pegar pizza

	CreateDynamic3DTextLabel("Entregador de Pizza\nPressione ENTER", 0xFFFFFFFF, 2101.5376, -1811.8586, 13.5547, MAX_TEXT3D_RANGE, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
	CreateDynamic3DTextLabel("Entregador de Pizza\n/entregarpizza", 0xFFFFFFFF, 2093.7966, -1792.2350, 13.3889, MAX_TEXT3D_RANGE, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
	return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerDisconnect(playerid, reason)
{
    if(gplBike[playerid] != INVALID_VEHICLE_ID)
    {
        DestroyServiceVehicle(playerid);
    }
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerDeath(playerid, killerid, reason)
{
    if(gplBike[playerid] != INVALID_VEHICLE_ID)
    {
        DestroyServiceVehicle(playerid);
        DisablePlayerRaceCheckpoint(playerid);
        SendClientMessage(playerid, COLOR_ERROR, "* Você não conseguiu completar o serviço.");
    }
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(oldstate == PLAYER_STATE_ONFOOT)
	{
		if(newstate == PLAYER_STATE_DRIVER && GetPlayerPizzaOnfootTime(playerid) > 1)
		{
			SetPlayerPizzaOnfootTime(playerid, 0);
		}
	}

	else if(oldstate == PLAYER_STATE_DRIVER)
	{
		if(gplBike[playerid] != INVALID_VEHICLE_ID && GetPlayerPizzaTime(playerid) > 0)
		{
			SetPlayerPizzaOnfootTime(playerid, 15);
			SendClientMessage(playerid, 0xFFFF00FF, "* Você tem {FFD700}15{FFFF00} segundos para voltar para a moto ou {FFD700}sua entrega irá falhar{FFFF00}.");
		}
        else if(gplBike[playerid] != INVALID_VEHICLE_ID && GetPlayerPizzaTime(playerid) == 0)
        {
            DestroyServiceVehicle(playerid);
            SendClientMessage(playerid, COLOR_INFO, "* Seu veículo foi levado de volta para a pizzaria.");
        }
	}
	return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerEnterRaceCPT(playerid)
{
	if(GetPlayerCPID(playerid) == CHECKPOINT_PIZZA)
	{
        PlaySelectSound(playerid);
		DisablePlayerRaceCheckpoint(playerid);
		SetPlayerCPID(playerid, CHECKPOINT_NONE);

		SendClientMessagef(playerid, 0xFFFF00FF, "* Você {FFD700}entregou{FFFF00} a pizza e recebeu {FFD700}$%i{FFFF00}.", GetPlayerPizzaTime(playerid) + gJobPayment);
		GivePlayerCash(playerid, GetPlayerPizzaTime(playerid) + gJobPayment);

		SetPlayerJobXP(playerid, GetPlayerJobXP(playerid) + 1);
		SetPlayerPizzaTime(playerid, 0);
	}
	return 1;
}

//------------------------------------------------------------------------------

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_PIZZA_JOB)
	{
		if(!response)
		{
            PlayCancelSound(playerid);
            return 1;
        }

		else if(GetPlayerBikeLicense(playerid) < gettime())
			return SendClientMessage(playerid, COLOR_ERROR, "* Para ser entregador de pizza, você precisa ter uma licença para pilotar motos válida.");

		SendClientMessage(playerid, COLOR_SUCCESS, "* Você agora é um entregador de pizza!");
		SendClientMessage(playerid, COLOR_INFO, "* Use /entregarpizza para trabalhar e /cancelarentrega para cancelar.");
		SetPlayerJobID(playerid, PIZZA_JOB_ID);
        PlaySelectSound(playerid);

		if(GetPlayerSkin(playerid) != 155)
		{
			SetPlayerSkin(playerid, 155);
			SendClientMessage(playerid, 0xAFAFAFAF, "* Você recebeu o uniforme da {FFD700}The Well Stacked Pizza Co.");
		}
		return 1;
	}
	return 0;
}

//------------------------------------------------------------------------------

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if((newkeys == KEY_SECONDARY_ATTACK) && IsPlayerInRangeOfPoint(playerid, 3.0, 2101.5376, -1811.8586, 13.5547))
	{
		if(GetPlayerJobID(playerid) != INVALID_JOB_ID)
		{
            PlayErrorSound(playerid);
			SendClientMessage(playerid, COLOR_ERROR, "* Você já possui um emprego.");
			return 1;
		}

        PlaySelectSound(playerid);
		new sDialogText[2048];
		strcat(sDialogText, "{FFEE00}Informação:\n");
		strcat(sDialogText, "{ADBEE6}Este emprego é usado para vender pizza na casa dos jogadores.\n");
		strcat(sDialogText, "{ADBEE6}Este emprego é legal e Você não será preso por trabalhar nele.\n\n");

		strcat(sDialogText, "{FFEE00}Requisitos:\n");
		strcat(sDialogText, "{FF0000}- {B9BABA}Level: {009CE5}Não requerido\n{FF0000}- {B9BABA}Licença: {009CE5}A\n\n");

		strcat(sDialogText, "{FFEE00}Pagamento:\n");
		new payment[256];
		format(payment, sizeof(payment), "{FF0000}- {ADBEE6}Entrega: {009CE5}Variável\n\n");
		strcat(sDialogText, payment);

		strcat(sDialogText, "{FFEE00}Comandos:\n");
		strcat(sDialogText, "{ADBEE6}/entregarpizza, /cancelarentrega.\n\n");

		strcat(sDialogText, "{FFEE00}Localização do emprego:\n");
		strcat(sDialogText, "{ADBEE6}Este emprego pode ser obtido do lado de fora da The Well Stacked Pizza Co. em Los Santos, no ícone de maleta.\n\n");

		strcat(sDialogText, "{FF1A1A}Anotações Importante(s):\n");
		strcat(sDialogText, "{ADBEE6}não existem níveis para este trabalho, em outras palavras, Você não precisa subir de nível para ganhar o dinheiro máximo que puder.\n");
		strcat(sDialogText, "{ADBEE6}Para trabalhar neste emprego Você precisa possuir habilitação para motos.\n");
		strcat(sDialogText, "{ADBEE6}Caso Você não entregar a pizza antes dela esfriar Você perderá a entrega.\n");
		strcat(sDialogText, "{ADBEE6}O uso do uniforme é obrigatório para trabalhar.\n\n");

		strcat(sDialogText, "{FF1A1A}Contrato:\n");

		if(IsPlayerDonator(playerid))
			strcat(sDialogText, "{ADBEE6}Você terá de cumprir um contrato de 2 horas antes de poder sair do emprego.");
		else
			strcat(sDialogText, "{ADBEE6}Você terá de cumprir um contrato de 5 horas antes de poder sair do emprego.");

		ShowPlayerDialog(playerid, DIALOG_PIZZA_JOB, DIALOG_STYLE_MSGBOX, "Emprego: Entregador de Pizza", sDialogText, "Aceitar", "Recusar");
		return 1;
	}
	return 1;
}

//------------------------------------------------------------------------------

DestroyServiceVehicle(playerid)
{
    DestroyVehicle(gplBike[playerid]);
    gplBike[playerid] = INVALID_VEHICLE_ID;
}

//------------------------------------------------------------------------------

YCMD:entregarpizza(playerid, params[], help)
{
	if(GetPlayerJobID(playerid) != PIZZA_JOB_ID)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não é um entregador de pizza.");

	else if(!IsPlayerInRangeOfPoint(playerid, 3.0, 2093.7966, -1792.2350, 13.3889))
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não está no pickup da {FFD700}The Well Stacked Pizza Co.");

	else if(GetPlayerSkin(playerid) != 155)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não está vestindo o uniforme. (/uniforme)");

	else if(GetPlayerPizzaTime(playerid) > 0)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você já está entregando uma pizza.");

	else if(IsPlayerInAnyVehicle(playerid) && GetPlayerVehicleID(playerid) != gplBike[playerid])
		return SendClientMessage(playerid, COLOR_ERROR, "* Saia desde veículo para iniciar o serviço.");

	research:
	new houseid = Iter_Random(House);
	new Float:hPos[3];
	GetHouseEntrance(houseid, hPos[0], hPos[1], hPos[2]);

	new	Float:fDist = GetPlayerDistanceFromPoint(playerid, hPos[0], hPos[1], hPos[2]);
	new rval = minrand(0, 5);

	if(fDist > 1000.0) goto research;

	SetPlayerPizzaTime(playerid, floatround(fDist)/10);

	if(GetPlayerPizzaTime(playerid) < 10) SetPlayerPizzaTime(playerid, rval + 10);

    SetPlayerCPID(playerid, CHECKPOINT_PIZZA);
    SetPlayerRaceCheckpoint(playerid, 1, hPos[0], hPos[1], hPos[2], 0.0, 0.0, 0.0, 1.0);

    if(gplBike[playerid] != INVALID_VEHICLE_ID && !IsPlayerInVehicle(playerid, gplBike[playerid]))
	{
		DestroyServiceVehicle(playerid);
	}

    if(!IsPlayerInAnyVehicle(playerid))
    {
        new rand = random(sizeof(g_fBikePositions));
        gplBike[playerid] = CreateVehicle(448, g_fBikePositions[rand][0], g_fBikePositions[rand][1], g_fBikePositions[rand][2], g_fBikePositions[rand][3], 3, 6, -1);
        PutPlayerInVehicle(playerid, gplBike[playerid], 0);
        SetVehicleFuel(gplBike[playerid], 100.0);
    }

    PlaySelectSound(playerid);
    GameTextForPlayer(playerid, "~y~entregue a pizza no local indicado", 5000, 3);

	if(IsHouseOwned(houseid))
	{
		SendClientMessagef(playerid, 0xFFFF00FF, "* Você pegou uma pizza para {FFD700}%s{FFFF00}. Você tem {FFD700}%d{FFFF00} segundos para entrega-la!", GetHouseOwner(houseid), GetPlayerPizzaTime(playerid));
	}
	else
	{
		SendClientMessagef(playerid, 0xFFFF00FF, "* Você pegou uma pizza para um {FFD700}morador{FFFF00}. Você tem {FFD700}%d{FFFF00} segundos para entrega-la!", GetPlayerPizzaTime(playerid));
	}
	return 1;
}

//------------------------------------------------------------------------------

YCMD:cancelarentrega(playerid, params[], help)
{
	if(GetPlayerJobID(playerid) != PIZZA_JOB_ID)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não é um entregador de pizza.");

	else if(GetPlayerPizzaTime(playerid) == 0)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não está entregando uma pizza.");

	SetPlayerPizzaTime(playerid, 0);
	SetPlayerCPID(playerid, CHECKPOINT_NONE);
	SetPlayerPizzaOnfootTime(playerid, 0);
	DisablePlayerRaceCheckpoint(playerid);

	if(!IsPlayerInVehicle(playerid, gplBike[playerid]))
	{
		DestroyServiceVehicle(playerid);
	}

	SendClientMessage(playerid, 0xFFFF00FF, "* Você {FFD700}cancelou{FFFF00} a {FFD700}entrega{FFFF00}.");
	return 1;
}

//------------------------------------------------------------------------------

YCMD:uniforme(playerid, params[], help)
{
    if(GetPlayerJobID(playerid) == INVALID_JOB_ID)
    {
        SendClientMessage(playerid, COLOR_ERROR, "* Você não possui um emprego.");
        return 1;
    }

    switch (GetPlayerJobID(playerid))
    {
        case PIZZA_JOB_ID:
        {
			if(GetPlayerSavedSkin(playerid) == 155 && GetPlayerSkin(playerid) == 155)
			{
				SendClientMessage(playerid, COLOR_ERROR, "* Você não tem uma roupa salva.");
			}
            else if(GetPlayerSkin(playerid) == 155)
            {
                SendClientActionMessage(playerid, 15.0, "tirou o uniforme.");
				SetPlayerSkin(playerid, GetPlayerSavedSkin(playerid));
            }
            else
            {
                SendClientActionMessage(playerid, 15.0, "vestiu o uniforme.");
				SetPlayerSkin(playerid, 155);
            }
        }
    }
    return 1;
}
