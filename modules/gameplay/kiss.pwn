/*******************************************************************************
* FILENAME :        modules/gameplay/kiss.pwn
*
* DESCRIPTION :
*       Adds commands to offer kiss to other players.
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

//------------------------------------------------------------------------------

#include <YSI\y_hooks>

// ID of the players who is giving/getting kiss
new g_p_kiss[MAX_PLAYERS] = { INVALID_PLAYER_ID, ... };

// The style of kiss
new g_p_kissstyle[MAX_PLAYERS] = 0;

/***
 *    ######## ##     ## ##    ##  ######  ######## ####  #######  ##    ##  ######
 *    ##       ##     ## ###   ## ##    ##    ##     ##  ##     ## ###   ## ##    ##
 *    ##       ##     ## ####  ## ##          ##     ##  ##     ## ####  ## ##
 *    ######   ##     ## ## ## ## ##          ##     ##  ##     ## ## ## ##  ######
 *    ##       ##     ## ##  #### ##          ##     ##  ##     ## ##  ####       ##
 *    ##       ##     ## ##   ### ##    ##    ##     ##  ##     ## ##   ### ##    ##
 *    ##        #######  ##    ##  ######     ##    ####  #######  ##    ##  ######
 ***/

/*
	IsPlayerOfferingKiss
		Checks if a player offering kiss to another player
	playerid
		The ID of the player
	return
		true or false
*/
IsPlayerOfferingKiss(playerid)
{
	foreach(new i: Player)
		if(g_p_kiss[playerid] != INVALID_PLAYER_ID)
			return true;
	return false;
}


/*
	GetPlayerKissOfferer
		Gets the ID of the player who is offering kiss to a player
	playerid
		The ID of the player who is getting the offer
	return
		The ID of the player who is offering the kiss INVALID_PLAYER_ID
		if nobody is offering a kiss
*/
GetPlayerKissOfferer(playerid)
{
	foreach(new i: Player)
		if(g_p_kiss[i] == playerid)
			return i;
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

/*
	Called when a player clicks on a dialog
		playerid - ID of the player
		dialogid - ID of the dialog
		response - If clicked button 0 or button 1
		listitem - If used DIALOG_STYLE_INPUT_LIST
		inputtext - If used DIALOG_STYLE_INPUT_TEXT
*/

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		case DIALOG_KISS_OFFER:
		{
			// ID of the player who was receiving the proposal of kiss
			new targetid = g_p_kiss[playerid];

			SendClientMessage(playerid, 0xBFBEBEFF, "* Você cancelou a oferta de beijo.");
			SendClientMessage(targetid, 0xBFBEBEFF, "* O jogador cancelou a oferta de beijo.");

			// Closes the player dialog
			ShowPlayerDialog(targetid, -1, 0, " ", " ", " ", " ");
			g_p_kiss[playerid] = INVALID_PLAYER_ID;
			return -2;
		}
		case DIALOG_KISS_ACCEPT:
		{
			// ID of the player who was giving the proposal of kiss
			new targetid = GetPlayerKissOfferer(playerid);

			// Closes the player dialog
			ShowPlayerDialog(targetid, -1, 0, " ", " ", " ", " ");
			if(!response)
			{
				SendClientMessage(playerid, 0xBFBEBEFF, "* Você cancelou a oferta de beijo.");
				SendClientMessage(targetid, 0xBFBEBEFF, "* O jogador cancelou a oferta de beijo.");

				new message[31 + MAX_PLAYER_NAME];
				format(message, sizeof(message), "recusou o beijo de %s.", GetPlayerNamef(targetid));
				SendClientActionMessage(playerid, 15.0, message);

				g_p_kiss[targetid] = INVALID_PLAYER_ID;
			}
			else
			{
				if(GetPlayerDistanceFromPlayer(playerid, targetid) > 1.0)
				{
					SendClientMessage(playerid, COLOR_ERROR, "* Você não está próximo ao jogador.");
					SendClientMessage(targetid, COLOR_ERROR, "* Você não está próximo ao jogador.");
					g_p_kiss[targetid] = INVALID_PLAYER_ID;
					return -2;
				}

				new Float:a;
				GetPlayerFacingAngle(playerid, a);

				a += 180.0;
				if(a > 359.0)
					a -= 359.0;

				SetPlayerFacingAngle(targetid, a);

				new message[20 + MAX_PLAYER_NAME];
				format(message, sizeof(message), "beija %s.", GetPlayerNamef(targetid));
				SendClientActionMessage(playerid, 15.0, message);

				switch(g_p_kissstyle[targetid])
				{
					case 1:
					{
						ApplyAnimation(playerid, "KISSING", "Playa_Kiss_01", 4.1, 0, 1, 1, 0, 0, 1);
						ApplyAnimation(targetid, "KISSING", "Grlfrd_Kiss_01", 4.1, 0, 1, 1, 0, 0, 1);
					}
					case 2:
					{
						ApplyAnimation(playerid, "KISSING", "Playa_Kiss_02", 4.1, 0, 1, 1, 0, 0, 1);
						ApplyAnimation(targetid, "KISSING", "Grlfrd_Kiss_02", 4.1, 0, 1, 1, 0, 0, 1);
					}
					case 3:
					{
						ApplyAnimation(playerid, "KISSING", "Playa_Kiss_03", 4.1, 0, 1, 1, 0, 0, 1);
						ApplyAnimation(targetid, "KISSING", "Grlfrd_Kiss_03", 4.1, 0, 1, 1, 0, 0, 1);
					}
				}
				g_p_kiss[targetid] = INVALID_PLAYER_ID;
			}
			return -2;
		}
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

/*
	offers a kiss to a player
*/

YCMD:beijar(playerid, params[], help)
{
	new
		targetid,
		style
	;
	if(IsPlayerOfferingKiss(playerid))
		SendClientMessage(playerid, COLOR_ERROR, "* Você já ofereceu um beijo.");
	else if(GetPlayerKissOfferer(playerid) != INVALID_PLAYER_ID)
		SendClientMessage(playerid, COLOR_ERROR, "* Você precisa responder a oferta de beijo pendente primeiro.");
	else if(IsPlayerInAnyVehicle(playerid))
		SendClientMessage(playerid, COLOR_ERROR, "* Você não pode estar em um veículo.");
	else if(sscanf(params, "ui", targetid, style))
		SendClientMessage(playerid, COLOR_INFO, "* /beijar [playerid] [estilo <1-3>]");
	else if(style < 1 || style > 8)
		SendClientMessage(playerid, COLOR_ERROR, "* Apenas estilos entre 1 e 3.");
	else if(playerid == targetid)
		SendClientMessage(playerid, COLOR_ERROR, "* Você não pode beijar você mesmo.");
	else if(GetPlayerDistanceFromPlayer(playerid, targetid) > 1.0)
		SendClientMessage(playerid, COLOR_ERROR, "* Você não está próximo ao jogador.");
	else if(IsPlayerInAnyVehicle(targetid))
		SendClientMessage(playerid, COLOR_ERROR, "* O jogador não pode estar em um veículo.");
	else if(IsPlayerOfferingKiss(targetid))
		SendClientMessage(playerid, COLOR_ERROR, "* O jogador está aguardando uma oferta de beijo.");
	else if(GetPlayerKissOfferer(targetid) != INVALID_PLAYER_ID)
		SendClientMessage(playerid, COLOR_ERROR, "* O jogador está decidindo um beijo pendente.");
	else
	{
		new info[93 + MAX_PLAYER_NAME];
		format(info, sizeof(info), "{ffffff}Você ofereceu um beijo à {CEE6ED}%s{ffffff}, aguarde ele aceitar ou recusar.", GetPlayerNamef(targetid));
		ShowPlayerDialog(playerid, DIALOG_KISS_OFFER, DIALOG_STYLE_MSGBOX, "Beijo", info, "Cancelar", "");

		format(info, sizeof(info), "{CEE6ED}%s{ffffff} está te oferecendo um beijo.", GetPlayerNamef(playerid));
		ShowPlayerDialog(targetid, DIALOG_KISS_ACCEPT, DIALOG_STYLE_MSGBOX, "Beijo", info, "Aceitar", "Recusar");

		g_p_kiss[playerid] = targetid;
		g_p_kissstyle[playerid] = style;

		new message[20 + MAX_PLAYER_NAME];
		format(message, sizeof(message), "tenta beijar %s.", GetPlayerNamef(targetid));
		SendClientActionMessage(playerid, 15.0, message);
	}
	return 1;
}
