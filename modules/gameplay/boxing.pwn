/*******************************************************************************
* FILENAME :        modules/gameplay/boxing.pwn
*
* DESCRIPTION :
*       Make players able to challenge others for a boxing fight.
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

//------------------------------------------------------------------------------

#include <YSI\y_hooks>

// global
static bool:g_isChallengeActive = false;

// player
static g_pOldSkin[MAX_PLAYERS];
static Float:g_fpOldArmour[MAX_PLAYERS];
static Float:g_fpOldHealth[MAX_PLAYERS];
static bool:g_isPlayerBoxing[MAX_PLAYERS] = {false, ...};
static g_p_challenge[MAX_PLAYERS] = { INVALID_PLAYER_ID, ... };

//------------------------------------------------------------------------------

IsPlayerOfferingChallenge(playerid)
{
	foreach(new i: Player)
		if(g_p_challenge[playerid] != INVALID_PLAYER_ID)
			return true;
	return false;
}

GetPlayerChallengeOfferer(playerid)
{
	foreach(new i: Player)
		if(g_p_challenge[i] == playerid)
			return i;
	return INVALID_PLAYER_ID;
}

//------------------------------------------------------------------------------

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		case DIALOG_BOXING_OFFER:
		{
			// ID of the player who was receiving the proposal of Challenge
			new targetid = g_p_challenge[playerid];
			SendClientMessage(playerid, 0xBFBEBEFF, "* Você cancelou o desafio.");
			SendClientMessage(targetid, 0xBFBEBEFF, "* O jogador cancelou o desafio.");

			// Closes the player dialog
			ShowPlayerDialog(targetid, -1, 0, " ", " ", " ", " ");
			g_p_challenge[playerid] = INVALID_PLAYER_ID;
			return -2;
		}
		case DIALOG_BOXING_ACCEPT:
		{
			// ID of the player who was giving the proposal of Challenge
			new targetid = GetPlayerChallengeOfferer(playerid);

			// Closes the player dialog
			ShowPlayerDialog(targetid, -1, 0, " ", " ", " ", " ");
			if(!response)
			{
				SendClientMessage(playerid, 0xBFBEBEFF, "* Você recusou o desafio.");
				SendClientMessage(targetid, 0xBFBEBEFF, "* O jogador recusou o desafio.");

				new message[31 + MAX_PLAYER_NAME];
				format(message, sizeof(message), "recusou o desafio de %s.", GetPlayerNamef(targetid));
				SendClientActionMessage(playerid, 15.0, message);

				g_p_challenge[targetid] = INVALID_PLAYER_ID;
			}
			else
			{
				g_p_challenge[targetid] = INVALID_PLAYER_ID;
                if(g_isChallengeActive)
                    return SendClientMessage(playerid, COLOR_ERROR, "* Já existe uma partida de boxe em andamento.");

				if(GetPlayerDistanceFromPlayer(playerid, targetid) > 5.0)
				{
					SendClientMessage(playerid, COLOR_ERROR, "* Você não está próximo ao jogador.");
					SendClientMessage(targetid, COLOR_ERROR, "* Você não está próximo ao jogador.");
					return -2;
				}

                g_isChallengeActive = true;

                g_isPlayerBoxing[playerid] = true;
                g_isPlayerBoxing[targetid] = true;

                g_pOldSkin[playerid] = GetPlayerSkin(playerid);
                g_pOldSkin[targetid] = GetPlayerSkin(targetid);

                SetPlayerArmedWeapon(playerid, 0);
                SetPlayerArmedWeapon(targetid, 0);

                GetPlayerHealth(playerid, g_fpOldHealth[playerid]);
                GetPlayerHealth(targetid, g_fpOldHealth[targetid]);

                GetPlayerArmour(playerid, g_fpOldArmour[playerid]);
                GetPlayerArmour(targetid, g_fpOldArmour[targetid]);

                SetPlayerArmour(playerid, 0.0);
                SetPlayerArmour(targetid, 0.0);

                SetPlayerHealth(playerid, 100.0);
                SetPlayerHealth(targetid, 100.0);

                SetPlayerSkin(playerid, 81);
                SetPlayerSkin(targetid, 80);

                SetPlayerPos(playerid, 758.4869, 2.4239, 1001.5942);
                SetPlayerFacingAngle(playerid, 217.1676);

                SetPlayerPos(targetid, 763.0175, -1.7609, 1001.5942);
                SetPlayerFacingAngle(targetid, 51.0994);

                GameTextForPlayer(playerid, "~r~Lutem!", 3000, 3);
                GameTextForPlayer(targetid, "~r~Lutem!", 3000, 3);

                foreach(new i: Player)
                {
                    if(IsPlayerInCube(i, 755.4205, -5.0985, 1000.0000, 774.6574, 16.0326, 1004.0000))
                        PlayerPlaySound(i, 17802, 763.8630, 3.7559, 1000.7145);
                }
			}
			return -2;
		}
	}
	return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerDisconnect(playerid, reason)
{
    if(g_isPlayerBoxing[playerid])
    {
        g_isChallengeActive = false;
        g_isPlayerBoxing[playerid] = false;

        new winnerid;
        foreach(new i: Player)
        {
            if(g_isPlayerBoxing[i])
            {
                winnerid = i;
                g_isPlayerBoxing[i] = false;

                SetPlayerSkin(i, g_pOldSkin[i]);
                SetPlayerHealth(i, g_fpOldHealth[i]);
                SetPlayerArmour(i, g_fpOldArmour[i]);
                SetPlayerPos(i, 764.8925, -1.1472, 1000.7144);
                SetPlayerFacingAngle(i, 263.7900);
            }

            if(IsPlayerInCube(i, 755.4205, -5.0985, 1000.0000, 774.6574, 16.0326, 1004.0000))
            {
                PlayerPlaySound(i, 17802, 763.8630, 3.7559, 1000.7145);
                SendClientMessagef(i, 0x21afdbff, "* %s venceu %s em uma partida de boxe por W.O.", GetPlayerNamef(winnerid), GetPlayerNamef(playerid));
            }
        }
    }
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerUpdate(playerid)
{
    if(g_isPlayerBoxing[playerid])
    {
        new Float:health;
        GetPlayerHealth(playerid, health);

        if(health < 10.0 || GetPlayerWeapon(playerid) != 0)
        {
            g_isChallengeActive = false;
            g_isPlayerBoxing[playerid] = false;

            SetPlayerSkin(playerid, g_pOldSkin[playerid]);
            SetPlayerHealth(playerid, g_fpOldHealth[playerid]);
            SetPlayerArmour(playerid, g_fpOldArmour[playerid]);
            SetPlayerPos(playerid, 764.7237, 1.4060, 1000.7152);
            SetPlayerFacingAngle(playerid, 263.7900);

            new winnerid;
            foreach(new i: Player)
            {
                if(g_isPlayerBoxing[i])
                {
                    winnerid = i;
                    g_isPlayerBoxing[i] = false;

                    SetPlayerSkin(i, g_pOldSkin[i]);
                    SetPlayerHealth(i, g_fpOldHealth[i]);
                    SetPlayerArmour(i, g_fpOldArmour[i]);
                    SetPlayerPos(i, 764.8925, -1.1472, 1000.7144);
                    SetPlayerFacingAngle(i, 263.7900);
                }
            }

			foreach(new i: Player)
            {
				if(IsPlayerInCube(i, 755.4205, -5.0985, 1000.0000, 774.6574, 16.0326, 1004.0000))
				{
					PlayerPlaySound(i, 17802, 763.8630, 3.7559, 1000.7145);
					if(GetPlayerWeapon(playerid) == 0)
						SendClientMessagef(i, 0x21afdbff, "* %s venceu %s em uma partida de boxe.", GetPlayerNamef(winnerid), GetPlayerNamef(playerid));
					else
						SendClientMessagef(i, 0x21afdbff, "* %s foi desclassificado por tentar utilizar uma arma na disputa.", GetPlayerNamef(playerid));
				}
			}
        }
    }
    return 1;
}

//------------------------------------------------------------------------------

YCMD:desafiar(playerid, params[], help)
{
    if(IsPlayerOfferingChallenge(playerid))
		return SendClientMessage(playerid, COLOR_ERROR, "* Você já desafiou alguém.");

    else if(GetPlayerChallengeOfferer(playerid) != INVALID_PLAYER_ID)
		SendClientMessage(playerid, COLOR_ERROR, "* Você precisa responder o desafio pendente primeiro.");

	if(IsPlayerInCube(playerid, 755.4205, -5.0985, 1000.0000, 774.6574, 16.0326, 1004.0000) && GetPlayerInterior(playerid) == 5)
	{
        if(g_isChallengeActive)
            return SendClientMessage(playerid, COLOR_ERROR, "* Já existe uma partida de boxe em andamento.");

        else if(GetPlayerFightingStyle(playerid) != FIGHT_STYLE_BOXING)
            return SendClientMessage(playerid, COLOR_ERROR, "* Você precisa saber lutar boxe.");

        new targetid;
        if(sscanf(params, "u", targetid))
            return SendClientMessage(playerid, COLOR_INFO, "* /desafiar [playerid]");

        else if(!IsPlayerLogged(targetid))
    		return SendClientMessage(playerid, COLOR_ERROR, "* Jogador não conectado.");

    	else if(GetPlayerDistanceFromPlayer(playerid, targetid) > 5.0)
    		return SendClientMessage(playerid, COLOR_ERROR, "* Você não está próximo do jogador.");

        else if(IsPlayerOfferingChallenge(targetid))
        	SendClientMessage(playerid, COLOR_ERROR, "* O jogador está aguardando alguém aceitar seu desafio.");

        else if(GetPlayerChallengeOfferer(targetid) != INVALID_PLAYER_ID)
        	SendClientMessage(playerid, COLOR_ERROR, "* O jogador está decidindo um desafio pendente.");

        else if(GetPlayerFightingStyle(targetid) != FIGHT_STYLE_BOXING)
    		return SendClientMessage(playerid, COLOR_ERROR, "* O jogador precisa saber lutar boxe.");

        g_p_challenge[playerid] = targetid;

        new info[97 + MAX_PLAYER_NAME];
		format(info, sizeof(info), "{ffffff}Você desafiou {CEE6ED}%s{ffffff} à uma partida de boxe, aguarde ele aceitar ou recusar.", GetPlayerNamef(targetid));
		ShowPlayerDialog(playerid, DIALOG_BOXING_OFFER, DIALOG_STYLE_MSGBOX, "Partida de Boxe", info, "Cancelar", "");

		format(info, sizeof(info), "{CEE6ED}%s{ffffff} está te desafiando a uma partida de boxe.", GetPlayerNamef(playerid));
		ShowPlayerDialog(targetid, DIALOG_BOXING_ACCEPT, DIALOG_STYLE_MSGBOX, "Partida de Boxe", info, "Aceitar", "Recusar");

        new message[50 + MAX_PLAYER_NAME];
		format(message, sizeof(message), "desafia %s à uma partida de boxe.", GetPlayerNamef(targetid));
		SendClientActionMessage(playerid, 15.0, message);
	}
	else
		SendClientMessage(playerid, COLOR_ERROR, "* Você não está na GYM.");
	return 1;
}
