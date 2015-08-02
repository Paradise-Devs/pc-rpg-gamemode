/*******************************************************************************
* FILENAME :        modules/gameplays/lottery.pwn
*
* DESCRIPTION :
*       A script that allow players call others.
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

#include <YSI\y_hooks>

#define INVALID_PHONENETWORK_ID		-1

static g_PlayerPhoneCaller[MAX_PLAYERS] = {INVALID_PLAYER_ID, ... };

/***
 *    ######## ##     ## ##    ##  ######  ######## ####  #######  ##    ##  ######
 *    ##       ##     ## ###   ## ##    ##    ##     ##  ##     ## ###   ## ##    ##
 *    ##       ##     ## ####  ## ##          ##     ##  ##     ## ####  ## ##
 *    ######   ##     ## ## ## ## ##          ##     ##  ##     ## ## ## ##  ######
 *    ##       ##     ## ##  #### ##          ##     ##  ##     ## ##  ####       ##
 *    ##       ##     ## ##   ### ##    ##    ##     ##  ##     ## ##   ### ##    ##
 *    ##        #######  ##    ##  ######     ##    ####  #######  ##    ##  ######
 ***/

stock GeneratePhoneNumber()
	return (random(9000) + 1000);

//------------------------------------------------------------------------------

stock GetPlayerCallerID(playerid)
	return g_PlayerPhoneCaller[playerid];

//------------------------------------------------------------------------------

stock SetPlayerCallerID(playerid, callerid)
{
	g_PlayerPhoneCaller[playerid] = callerid;
}

//------------------------------------------------------------------------------

stock IsPlayerInCall(playerid)
{
	foreach(new i: Player)
	{
		if(GetPlayerCallerID(i) == playerid && GetPlayerCallerID(playerid) == i)
			return true;
	}
	return false;
}

//------------------------------------------------------------------------------

stock IsPlayerInAnyCall(playerid)
	return (GetPlayerCallerID(playerid) != INVALID_PLAYER_ID);

//------------------------------------------------------------------------------

stock IsPlayerBeingCalled(playerid)
{
	foreach(new i: Player)
	{
		if(GetPlayerCallerID(i) == playerid)
			return true;
	}
	return false;
}

//------------------------------------------------------------------------------

stock IsPlayerBeingCalledBy(playerid)
{
	foreach(new i: Player)
	{
		if(GetPlayerCallerID(i) == playerid)
			return i;
	}
	return INVALID_PLAYER_ID;
}

/***
 *     ######     ###    ##       ##       ########     ###     ######  ##    ##
 *    ##    ##   ## ##   ##       ##       ##     ##   ## ##   ##    ## ##   ##
 *    ##        ##   ##  ##       ##       ##     ##  ##   ##  ##       ##  ##
 *    ##       ##     ## ##       ##       ########  ##     ## ##       #####
 *    ##       ######### ##       ##       ##     ## ######### ##       ##  ##
 *    ##    ## ##     ## ##       ##       ##     ## ##     ## ##    ## ##   ##
 *     ######  ##     ## ######## ######## ########  ##     ##  ######  ##    ##
 ***/

hook OnPlayerDisconnect(playerid, reason)
{
	if(IsPlayerInAnyCall(playerid))
	{
		if(IsPlayerInCall(playerid))
		{
			new	targetid = GetPlayerCallerID(playerid);
			SendClientMessage(targetid, 0xB9C9BFFF, "*** A linha caiu...");
			SetPlayerCallerID(targetid, INVALID_PLAYER_ID);
		}
	}
	return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerDeath(playerid, killerid, reason)
{
	if(IsPlayerInAnyCall(playerid))
	{
		if(IsPlayerInCall(playerid))
		{
			new	targetid = GetPlayerCallerID(playerid);
			SendClientMessage(targetid, 0xB9C9BFFF, "*** A linha caiu...");
			SetPlayerCallerID(targetid, INVALID_PLAYER_ID);

			if(IsPlayerAttachedObjectSlotUsed(playerid, 0) || GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USECELLPHONE)
			{
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
				RemovePlayerAttachedObject(playerid, 0);
			}
		}
		SetPlayerCallerID(playerid, INVALID_PLAYER_ID);

		if(IsPlayerAttachedObjectSlotUsed(playerid, 0) || GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USECELLPHONE)
		{
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
			RemovePlayerAttachedObject(playerid, 0);
		}
	}
	else if(IsPlayerBeingCalled(playerid))
	{
		new	targetid = IsPlayerBeingCalledBy(playerid);

		SetPlayerCallerID(targetid, INVALID_PLAYER_ID);
		SendClientMessage(targetid, 0xB9C9BFFF, "*** A linha caiu...");
	}
	return 1;
}

/***
 *     ######   #######  ##     ## ##     ##    ###    ##    ## ########   ######
 *    ##    ## ##     ## ###   ### ###   ###   ## ##   ###   ## ##     ## ##    ##
 *    ##       ##     ## #### #### #### ####  ##   ##  ####  ## ##     ## ##
 *    ##       ##     ## ## ### ## ## ### ## ##     ## ## ## ## ##     ##  ######
 *    ##       ##     ## ##     ## ##     ## ######### ##  #### ##     ##       ##
 *    ##    ## ##     ## ##     ## ##     ## ##     ## ##   ### ##     ## ##    ##
 *     ######   #######  ##     ## ##     ## ##     ## ##    ## ########   ######
 ***/

//------------------------------------------------------------------------------

/*YCMD:comprarcelular(playerid, params[], help)
{
	foreach(new b: Business)
	{
		if(IsPlayerInBusiness(playerid, b, 25.0))
		{
			if(GetPlayerVirtualWorld(playerid) == b)
			{
				if(GetBusinessType(b) == 2)
				{
					if(GetBusinessProducts(b) > 0)
					{
						if(GetPlayerCash(playerid) < 320)
							return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiente. {C8C8C8}[$320]");

                        SetPlayerPhoneNumber(playerid, GeneratePhoneNumber());
						SetPlayerPhoneNetwork(playerid, b);

						SendClientMessagef(playerid, COLOR_SUCCESS, "* Você comprou um celular, seu novo número é {0087FA}%i", GetPlayerPhoneNumber(playerid));
                        SendClientMessage(playerid, COLOR_INFO, "* Para obter ajuda sobre os comandos use {C8C8C8}/ajudacelular{AFAFAF}.");
						SendClientActionMessage(playerid, 15.0, "pagou para a empresa e recebeu um item em troca.");

                        GivePlayerCash(playerid, -320);
                        SetPlayerPhoneCredit(playerid, 250);
                        SetBusinessTill(b, GetBusinessTill(b) + 320);
                        SetBusinessProducts(b, GetBusinessProducts(b) - 1);
                        SetPlayerPhoneState(playerid, true);
                        return 1;
                    }
                    else
                    {
                        SendClientMessage(playerid, COLOR_ERROR, "* Desculpe, mas estamos sem produtos.");
                        return 1;
                    }
                }
            }
        }
    }
    SendClientMessage(playerid, COLOR_ERROR, "* Você não está em uma operadora de celular.");
    return 1;
}*/

//------------------------------------------------------------------------------

/*YCMD:comprarcreditos(playerid, params[], help)
{
	foreach(new b: Business)
	{
		if(IsPlayerInBusiness(playerid, b, 25.0))
		{
			if(GetPlayerVirtualWorld(playerid) == b)
			{
				if(GetBusinessType(b) == 2)
				{
					new credits;
					if(sscanf(params, "i", credits))
						return SendClientMessage(playerid, COLOR_INFO, "* /comprarcreditos [quantidade]");

					if(credits < 0)
						return SendClientMessage(playerid, COLOR_ERROR, "* Use apenas valores positivos.");

                    if(GetPlayerCash(playerid) < credits)
                        return SendClientMessagef(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiente. {C8C8C8}[$i]", credits);

                    SendClientMessagef(playerid, COLOR_SUCCESS, "* Você comprou créditos para seu celular);
                    SendClientActionMessage(playerid, 15.0, "pagou para a empresa e recebeu um creditos em troca.");

					GivePlayerCash(playerid, -credits);
					SetPlayerPhoneCredit(playerid, credits);
					SetBusinessTill(b, GetBusinessTill(b) + credits);
					return 1;
				}
			}
		}
	}
    SendClientMessage(playerid, COLOR_ERROR, "* Você não está em uma operadora de celular.");
    return 1;
}*/

//------------------------------------------------------------------------------

YCMD:sms(playerid, params[], help)
{
	if(GetPlayerPhoneNumber(playerid) == 0)
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não possui um celular.");

    if(GetPlayerPhoneCredit(playerid) < 20)
    	return SendClientMessage(playerid, COLOR_ERROR, "* Você não possui créditos suficientes. {C8C8C8}[$20]");

    if(GetPlayerPhoneState(playerid) < 20)
    	return SendClientMessage(playerid, COLOR_ERROR, "* Seu celular está desligado");

    new
		phoneNumber,
		msgText[164];

	if(sscanf(params, "is", phoneNumber, msgText))
		return SendClientMessage(playerid, COLOR_INFO, "/sms [número] [mensagem]");

    foreach(new i: Player)
	{
		if(GetPlayerPhoneNumber(i) == phoneNumber && phoneNumber != 0)
		{
			if(i == playerid) goto end;

			if(!GetPlayerPhoneState(i))
				return SendClientMessage(playerid, COLOR_ERROR, "O número está fora de área de cobertura ou fora de serviço.");

            new output[65 + MAX_PLAYER_NAME + 128];
            format(output, sizeof(output), "*** SMS de {FFD700}%s{FFFF00}({FFD700}%i{FFFF00}): %s", GetPlayerNamef(playerid),GetPlayerPhoneNumber(playerid), msgText);
            SendMultiMessage(i, 0xFFFF00FF, output);

            format(output, sizeof(output), "*** Mensagem enviada a {FFD700}%s{FFFF00}({FFD700}%i{FFFF00}): %s", GetPlayerNamef(i), GetPlayerPhoneNumber(i), msgText);
            SendMultiMessage(playerid, 0xFFFF00FF, output);

            SetPlayerPhoneCredit(playerid, GetPlayerPhoneCredit(playerid) - 20);
            GameTextForPlayer(playerid, "~r~-$20", 5000, 1);
            return 1;
        }
    }
    end: return SendClientMessage(playerid, COLOR_ERROR, "* Não foi possível enviar a mensagem.");
}

//------------------------------------------------------------------------------

YCMD:jogarcelular(playerid, params[], help)
{
	if(GetPlayerPhoneNumber(playerid) == 0)
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não possui um celular.");

    SetPlayerPhoneNumber(playerid, 0);
	SetPlayerPhoneNetwork(playerid, INVALID_PHONENETWORK_ID);
	SendClientMessage(playerid, COLOR_SUCCESS, "* Você jogou o seu celular fora.");
    SendClientActionMessage(playerid, 15.0, "jogou o celular fora.");
    return 1;
}

//------------------------------------------------------------------------------

YCMD:acelular(playerid, params[], help)
{
	if(GetPlayerPhoneNumber(playerid) == 0)
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não possui um celular.");

    if(!IsPlayerDonator(playerid))
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não possui uma assinatura.");

    if(GetPlayerPhoneState(playerid))
	{
		SendClientActionMessage(playerid, 15.0, "desligou o celular.");
		SetPlayerPhoneState(playerid, false);
	}
	else
	{
		SendClientActionMessage(playerid, 15.0, "ligou o celular.");
		SetPlayerPhoneState(playerid, true);
	}
	return 1;
}

//------------------------------------------------------------------------------

YCMD:ajudacelular(playerid, params[], help)
{
	SendClientMessage(playerid, 0xFAD669FF, "~~~~~~~~~~~~~~~~~~~~ Comandos Celular ~~~~~~~~~~~~~~~~~~~~");
	SendClientMessage(playerid, -1, "* /comprarcelular - /ligar - /[des]ligar - /[at]ender - /[an]uncio - /sms - /acelular");
	SendClientMessage(playerid, -1, "* /infocelular - /comprarcreditos - /jogarcelular");
	SendClientMessage(playerid, -1, "* Use ''!'' antes da frase durante uma chamada para falar fora do celular.");
	SendClientMessage(playerid, 0xFAD669FF, "~~~~~~~~~~~~~~~~~~~~ Comandos Celular ~~~~~~~~~~~~~~~~~~~~");
	return 1;
}

//------------------------------------------------------------------------------

YCMD:ligar(playerid, params[], help)
{
	if(GetPlayerPhoneNumber(playerid) == 0)
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não possui um celular.");

    if(!GetPlayerPhoneState(playerid))
		return SendClientMessage(playerid, COLOR_ERROR, "* Seu celular está desligado.");

    if(GetPlayerPhoneCredit(playerid) < 5)
    	return SendClientMessage(playerid, COLOR_ERROR, "* Você não possui créditos suficientes. {C8C8C8}[$5]");

    new
		phoneNumber;

	if(sscanf(params, "i", phoneNumber))
		return SendClientMessage(playerid, COLOR_INFO, "/ligar [número]");

    foreach(new i: Player)
	{
		if(GetPlayerPhoneNumber(i) == phoneNumber && phoneNumber != 0)
		{
			if(i == playerid || IsPlayerInAnyCall(i) || IsPlayerBeingCalled(i))
				return SendClientMessage(playerid, COLOR_ERROR, "O número chamado está ocupado.");

            if(!GetPlayerPhoneState(i))
                return SendClientMessage(playerid, COLOR_ERROR, "O número está fora de área de cobertura ou fora de serviço.");

            if(!IsPlayerAttachedObjectSlotUsed(playerid, 0) || GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_USECELLPHONE)
			{
				SetPlayerAttachedObject(playerid, 0, 330, 6);
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
			}

			SendClientMessagef(i, 0xFFFF00FF, "*** Telefone tocando... - número: {FFD700}%i{FFFF00}.", GetPlayerPhoneNumber(playerid));
            SendClientMessagef(i, 0xFFFF00FF, "*** Chamando... - número: {FFD700}%i{FFFF00}.", phoneNumber);

            PlayerPlaySound(playerid, 3600, 0.0, 0.0, 0.0);

			SetPlayerCallerID(playerid, i);

			new	Float:fDist[3];
			GetPlayerPos(i, fDist[0], fDist[1], fDist[2]);
			foreach(new ii: Player){if(GetPlayerDistanceFromPoint(ii, fDist[0], fDist[1], fDist[2]) < 15.0){SendClientMessagef(ii, 0xDA70D6FF, "O telefone de %s está tocando.", GetPlayerNamef(i));}}
            return 1;
        }
    }
    return SendClientMessage(playerid, COLOR_ERROR, "O número está fora de área de cobertura ou fora de serviço.");
}

//------------------------------------------------------------------------------

YCMD:desligar(playerid, params[], help)
{
	if(GetPlayerPhoneNumber(playerid) == 0)
		return SendClientMessage(playerid, COLOR_ERROR, "Você não possui um celular.");

    if(!GetPlayerPhoneState(playerid))
    		return SendClientMessage(playerid, COLOR_ERROR, "Seu celular está desligado.");

	if(!IsPlayerInAnyCall(playerid) && !IsPlayerBeingCalled(playerid) && GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USECELLPHONE)
	{
		SendClientActionMessage(playerid, 15.0, "guardou o celular no bolso.");
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
		RemovePlayerAttachedObject(playerid, 0);
		return 1;
	}

	if(!IsPlayerInAnyCall(playerid))
		return SendClientMessage(playerid, COLOR_ERROR, "Você não está fazendo ou recebendo uma ligação.");

	if(IsPlayerInAnyCall(playerid))
	{
		if(IsPlayerInCall(playerid))
		{
			new
				targetid = GetPlayerCallerID(playerid);

			SendClientMessage(targetid, 0xB9C9BFFF, "*** Desligaram...");
			SetPlayerCallerID(targetid, INVALID_PLAYER_ID);

			if(IsPlayerAttachedObjectSlotUsed(playerid, 0) || GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USECELLPHONE)
			{
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
				RemovePlayerAttachedObject(playerid, 0);
			}
		}

		SetPlayerCallerID(playerid, INVALID_PLAYER_ID);
		SendClientMessage(playerid, 0xB9C9BFFF, "*** Você desligou...");
		SendClientActionMessage(playerid, 15.0, "guardou o celular no bolso.");

		if(IsPlayerAttachedObjectSlotUsed(playerid, 0) || GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USECELLPHONE)
		{
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
			RemovePlayerAttachedObject(playerid, 0);
		}
	}
	else if(IsPlayerBeingCalled(playerid))
	{
		new
			targetid = IsPlayerBeingCalledBy(playerid);

		SetPlayerCallerID(targetid, INVALID_PLAYER_ID);
		SendClientMessage(targetid, 0xB9C9BFFF, "*** Desligaram...");
		SendClientMessage(playerid, 0xB9C9BFFF, "*** Você desligou...");
	}
	return 1;
}

//------------------------------------------------------------------------------

YCMD:atender(playerid, params[], help)
{
	if(GetPlayerPhoneNumber(playerid) == 0)
		return SendClientMessage(playerid, COLOR_ERROR, "Você não possui um celular.");

	if(!GetPlayerPhoneState(playerid))
		return SendClientMessage(playerid, COLOR_ERROR, "Seu celular está desligado.");

	if(IsPlayerInAnyCall(playerid))
		return SendClientMessage(playerid, COLOR_ERROR, "Você já está em uma ligação.");

	if(IsPlayerBeingCalled(playerid))
	{
		new
			targetid = IsPlayerBeingCalledBy(playerid)
		;

		if(!IsPlayerAttachedObjectSlotUsed(playerid, 0) || GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_USECELLPHONE)
		{
			SetPlayerAttachedObject(playerid, 0, 330, 6);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
		}

		SendClientActionMessage(playerid, 15.0, "atendeu o celular.");
		SendClientMessage(targetid, 0xB9C9BFFF, "*** Atenderam...");

		SetPlayerCallerID(playerid, targetid);
	}
	else
	{
		SendClientMessage(playerid, COLOR_ERROR, "Você não está recebendo uma ligação.");
	}
	return 1;
}

//------------------------------------------------------------------------------

/*YCMD:infocelular(playerid, params[], help)
{
	if(!GetPlayerPhoneNumber(playerid))
		return SendClientMessage(playerid, COLOR_ERROR, "Você não tem um celular.");

	new stateMessage[4];
	stateMessage = (GetPlayerPhoneState(playerid)) ? "Sim" : "não";

	SendClientMessage(playerid, 0xFAD669FF, "~~~~~~~~~~~~~~~~~~~~ Informações Celular ~~~~~~~~~~~~~~~~~~~~");

	new infoMessage[100];
	format(infoMessage, sizeof(infoMessage), "* número: %i - Operadora: %s - Creditos: $%i", GetPlayerPhoneNumber(playerid), GetBusinessName(GetPlayerPhoneNetwork(playerid)), GetPlayerPhoneCredit(playerid));
	SendClientMessage(playerid, -1, infoMessage);
	SendClientMessagef(playerid, -1, "* Ligado: %s", stateMessage);

	SendClientMessage(playerid, 0xFAD669FF, "~~~~~~~~~~~~~~~~~~~~ Informações Celular ~~~~~~~~~~~~~~~~~~~~");
	return 1;
}*/

//------------------------------------------------------------------------------

YCMD:telefone(playerid, params[], help)
{
	/*if(gPlayerData[playerid][E_PLAYER_AGENDA] < 1)
		return SendClientMessage(playerid, COLOR_ERROR, "Você não tem uma agenda.");*/

	new targetid;
	if(sscanf(params, "u", targetid))
		return SendClientMessage(playerid, COLOR_INFO, "/telefone [jogador]");

	if(!IsPlayerLogged(targetid))
		return SendClientMessage(playerid, COLOR_ERROR, "O jogador não está logado.");

	if(GetPlayerPhoneNumber(targetid) == 0)
		return SendClientMessage(playerid, COLOR_ERROR, "O jogador não tem um celular.");

	new sMessage[52 + MAX_PLAYER_NAME];
	format(sMessage, sizeof(sMessage), "* {ba9100}%s{e0b418} - número: {ba9100}%d", GetPlayerNamef(targetid), GetPlayerPhoneNumber(targetid));
	SendClientMessage(playerid, 0xe0b418ff, sMessage);
	SendClientActionMessage(playerid, 15.0, "procura um número na lista telef�nica.");
	return 1;
}

//------------------------------------------------------------------------------

/*YCMD:anuncio(playerid, params[], help)
{
	if(GetPlayerPlayedTime(playerid)/3600 < 3)
		return SendClientMessage(playerid, COLOR_ERROR, "Você precisa ter pelo menos 3 horas de jogo.");

	foreach(new b: Business)
	{
		if(IsPlayerInBusiness(playerid, b, 25.0))
		{
			if(GetPlayerVirtualWorld(playerid) == b)
			{
				if(GetBusinessType(b) == 7)
				{
					if(GetBusinessProducts(b) > 0)
					{
						new	advertiseText[128];

						if(sscanf(params, "s", advertiseText))
							return SendClientMessage(playerid, COLOR_INFO, "/anuncio [mensagem]");

						if(GetPlayerCash(playerid) < strlen(advertiseText) * 20)
						{
							SendClientMessagef(playerid, 0xB9C9BFFF, "* Você não possui dinheiro suficiente. {C8C8C8}[$%i]", strlen(advertiseText) * 20);
							return 1;
						}

						new	advertiseMessage[32 + 8 + MAX_PLAYER_NAME + 128];
						format(advertiseMessage, sizeof advertiseMessage, "[Anúncio] %s: %s - Telefone: %i", GetPlayerNamef(playerid), advertiseText, GetPlayerPhoneNumber(playerid));
						SendClientMessageToAll(0x1fc91fFF, advertiseMessage);

						format(advertiseMessage, sizeof advertiseMessage, "Anúncio publicado pela empresa {C8C8C8}%s{AFAFAF}.", GetBusinessName(b));
						SendClientMessageToAll(0xAFAFAFAF, advertiseMessage);

						GivePlayerCash(playerid, -(strlen(advertiseText) * 20));
						SetBusinessTill(b, GetBusinessTill(b) + (strlen(advertiseText) * 20));
						SendClientActionMessage(playerid, 15.0, "paga para a empresa enviar um Anúncio.");

						new priceText[15];
						format(priceText, sizeof(priceText), "~r~-$%d", strlen(advertiseText) * 20);
						GameTextForPlayer(playerid, priceText, 5000, 1);
						return 1;
					}
				}
			}
		}
	}

	if(GetPlayerPhoneNumber(playerid) == 0)
		return SendClientMessage(playerid, COLOR_ERROR, "Você não possui um celular.");

	new advertiseText[128];

	if(sscanf(params, "s", advertiseText))
		return SendClientMessage(playerid, COLOR_INFO, "/anuncio [mensagem]");

	if(GetPlayerPhoneCredit(playerid) < strlen(advertiseText) * 40)
	{
		SendClientMessage(playerid, COLOR_ERROR, "Você não possui creditos suficientes. {C8C8C8}[$%i]", strlen(advertiseText) * 40);
		return 1;
	}

	new
		advertiseMessage[256];
	format(advertiseMessage, sizeof advertiseMessage, "[{FFB300}Anúncio{FFFFFF}] {%s}%s{FFFFFF}: {FFB300}%s{FFFFFF} - Telefone: {B9BABA}%i", GetPlayerRankColor(playerid), GetPlayerNamef(playerid), advertiseText, GetPlayerPhoneNumber(playerid));
	SendClientMessageToAll(-1, advertiseMessage);

	SetPlayerPhoneCredit(playerid, GetPlayerPhoneCredit(playerid) - (strlen(advertiseText) * 40));
	SetBusinessTill(GetPlayerPhoneNetwork(playerid), GetBusinessTill(GetPlayerPhoneNetwork(playerid)) + (strlen(advertiseText) * 40));
	SendClientActionMessage(playerid, 15.0, "envia um aúncio através do celular.");

	new priceText[15];
	format(priceText, sizeof(priceText), "~r~-$%d", strlen(advertiseText) * 40);
	GameTextForPlayer(playerid, priceText, 5000, 1);
	return 1;
}*/
