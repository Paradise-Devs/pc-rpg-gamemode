/*******************************************************************************
* FILENAME :        modules/gameplay/handshake.pwn
*
* DESCRIPTION :
*       Adds commands to offer handshake to other players.
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
* AUTHOR :    Larceny           START DATE :    07 Jul 15
*
*/

//------------------------------------------------------------------------------

#include <YSI\y_hooks>

// ID of the players who is giving/getting handshake
new g_p_hshake[MAX_PLAYERS] = { INVALID_PLAYER_ID, ... };

// The style of handshake
new g_p_hshakestyle[MAX_PLAYERS] = 0;

/*
	IsPlayerOfferingHandshake
		Checks if a player offering handshake to another player
	playerid
		The ID of the player
	return
		true or false
*/
IsPlayerOfferingHandshake(playerid)
{
	foreach(new i: Player)
		if(g_p_hshake[playerid] != INVALID_PLAYER_ID)
			return true;
	return false;
}

/*
	GetPlayerHandshakeOfferer
		Gets the ID of the player who is offering handshake to a player
	playerid
		The ID of the player who is getting the offer
	return
		The ID of the player who is offering the handshake INVALID_PLAYER_ID
		if nobody is offering a handshake
*/
GetPlayerHandshakeOfferer(playerid)
{
	foreach(new i: Player)
		if(g_p_hshake[i] == playerid)
			return i;
	return INVALID_PLAYER_ID;
}

/*
	offers a handshake to a player
*/

YCMD:apertarmao(playerid, params[], help)
{
	new
		targetid,
		style
	;
	if(IsPlayerOfferingHandshake(playerid))
		SendClientMessage(playerid, COLOR_ERROR, "* Você já ofereceu um aperto de mão.");
	else if(GetPlayerHandshakeOfferer(playerid) != INVALID_PLAYER_ID)
		SendClientMessage(playerid, COLOR_ERROR, "* Você precisa responder o aperto de mão pendente primeiro.");
	else if(IsPlayerInAnyVehicle(playerid))
		SendClientMessage(playerid, COLOR_ERROR, "* Você não pode estar em um veículo.");
	else if(sscanf(params, "ui", targetid, style))
		SendClientMessage(playerid, COLOR_INFO, "* /apertarmao [playerid] [estilo <1-8>]");
	else if(style < 1 || style > 8)
		SendClientMessage(playerid, COLOR_ERROR, "* Apenas estilos entre 1 e 8.");
	else if(playerid == targetid)
		SendClientMessage(playerid, COLOR_ERROR, "* Você não pode apertar sua mão.");
	else if(GetPlayerDistanceFromPlayer(playerid, targetid) > 1.0)
		SendClientMessage(playerid, COLOR_ERROR, "* Você não está próximo ao jogador.");
	else if(IsPlayerInAnyVehicle(targetid))
		SendClientMessage(playerid, COLOR_ERROR, "* O jogador não pode estar em um veículo.");
	else if(IsPlayerOfferingHandshake(targetid))
		SendClientMessage(playerid, COLOR_ERROR, "* O jogador está aguardando uma oferta de aperto de mão.");
	else if(GetPlayerHandshakeOfferer(targetid) != INVALID_PLAYER_ID)
		SendClientMessage(playerid, COLOR_ERROR, "* O jogador está decidindo um aperto de mão pendente.");
	else
	{
        inline Response(pid, dialogid, response, listitem, string:inputtext[])
        {
            #pragma unused pid, dialogid, listitem, response, inputtext
			SendClientMessage(playerid, 0xBFBEBEFF, "* Você cancelou a oferta de aperto de mão.");
			SendClientMessage(targetid, 0xBFBEBEFF, "* O jogador cancelou a oferta de aperto de mão.");
			SendClientActionMessage(playerid, 15.0, "abaixou a mão.");

			Dialog_Hide(targetid);
			g_p_hshake[playerid] = INVALID_PLAYER_ID;
            PlayCancelSound(playerid);
            return 1;
        }
        new info[93 + MAX_PLAYER_NAME];
		format(info, sizeof(info), "{ffffff}Você ofereceu um aperto de mão à {CEE6ED}%s{ffffff}, aguarde ele aceitar ou recusar.", GetPlayerNamef(targetid));
        Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_MSGBOX, "Aperto de mão", info, "Cancelar", "");
        PlaySelectSound(playerid);

        inline Response2(pid, dialogid, response, listitem, string:inputtext[])
        {
            #pragma unused pid, dialogid, listitem, inputtext

			// Closes the player dialog
			Dialog_Hide(playerid);
			if(!response)
			{
				SendClientMessage(targetid, 0xBFBEBEFF, "* Você cancelou a oferta de aperto de mão.");
				SendClientMessage(playerid, 0xBFBEBEFF, "* O jogador cancelou a oferta de aperto de mão.");

				new message[31 + MAX_PLAYER_NAME];
				format(message, sizeof(message), "recusou o aperto de mão de %s.", GetPlayerNamef(playerid));
				SendClientActionMessage(targetid, 15.0, message);
				g_p_hshake[playerid] = INVALID_PLAYER_ID;
			}
			else
			{
				if(GetPlayerDistanceFromPlayer(playerid, targetid) > 1.0)
				{
					SendClientMessage(playerid, COLOR_ERROR, "* Você não está próximo ao jogador.");
					SendClientMessage(targetid, COLOR_ERROR, "* Você não está próximo ao jogador.");
					g_p_hshake[playerid] = INVALID_PLAYER_ID;
					return 1;
				}

				new Float:a;
				GetPlayerFacingAngle(playerid, a);

				a += 180.0;
				if(a > 359.0)
					a -= 359.0;

				SetPlayerFacingAngle(targetid, a);

				new message[20 + MAX_PLAYER_NAME];
				format(message, sizeof(message), "aperta a mão de %s.", GetPlayerNamef(playerid));
				SendClientActionMessage(targetid, 15.0, message);

				switch(g_p_hshakestyle[playerid])
				{
					case 1:
					{
						ApplyAnimation(playerid, "GANGS", "hndshkaa", 4.1, 0, 1, 1, 0, 0, 1);
						ApplyAnimation(targetid, "GANGS", "hndshkaa", 4.1, 0, 1, 1, 0, 0, 1);
					}
					case 2:
					{
						ApplyAnimation(playerid, "GANGS", "hndshkba", 4.1, 0, 1, 1, 0, 0, 1);
						ApplyAnimation(targetid, "GANGS", "hndshkba", 4.1, 0, 1, 1, 0, 0, 1);
					}
					case 3:
					{
						ApplyAnimation(playerid, "GANGS", "hndshkca", 4.1, 0, 1, 1, 0, 0, 1);
						ApplyAnimation(targetid, "GANGS", "hndshkca", 4.1, 0, 1, 1, 0, 0, 1);
					}
					case 4:
					{
						ApplyAnimation(playerid, "GANGS", "hndshkcb", 4.1, 0, 1, 1, 0, 0, 1);
						ApplyAnimation(targetid, "GANGS", "hndshkcb", 4.1, 0, 1, 1, 0, 0, 1);
					}
					case 5:
					{
						ApplyAnimation(playerid, "GANGS", "hndshkda", 4.1, 0, 1, 1, 0, 0, 1);
						ApplyAnimation(targetid, "GANGS", "hndshkda", 4.1, 0, 1, 1, 0, 0, 1);
					}
					case 6:
					{
						ApplyAnimation(playerid, "GANGS", "hndshkea", 4.1, 0, 1, 1, 0, 0, 1);
						ApplyAnimation(targetid, "GANGS", "hndshkea", 4.1, 0, 1, 1, 0, 0, 1);
					}
					case 7:
					{
						ApplyAnimation(playerid, "GANGS", "hndshkfa", 4.1, 0, 1, 1, 0, 0, 1);
						ApplyAnimation(targetid, "GANGS", "hndshkfa", 4.1, 0, 1, 1, 0, 0, 1);
					}
					case 8:
					{
						ApplyAnimation(playerid, "GANGS", "hndshkfa_swt", 4.1, 0, 1, 1, 0, 0, 1);
						ApplyAnimation(targetid, "GANGS", "hndshkfa_swt", 4.1, 0, 1, 1, 0, 0, 1);
					}
				}
				g_p_hshake[playerid] = INVALID_PLAYER_ID;
			}
            return 1;
        }
		format(info, sizeof(info), "{CEE6ED}%s{ffffff} está te oferecendo um aperto de mão.", GetPlayerNamef(playerid));
        Dialog_ShowCallback(targetid, using inline Response2, DIALOG_STYLE_MSGBOX, "Aperto de mão", info, "Cancelar", "");
        PlaySelectSound(playerid);

		g_p_hshake[playerid] = targetid;
		g_p_hshakestyle[playerid] = style;

		new message[50 + MAX_PLAYER_NAME];
		format(message, sizeof(message), "estende a mão para %s e oferece um aperto de mão.", GetPlayerNamef(targetid));
		SendClientActionMessage(playerid, 15.0, message);
	}
	return 1;
}
