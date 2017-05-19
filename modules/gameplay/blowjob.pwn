/*******************************************************************************
* FILENAME :        modules/gameplay/blowjob.pwn
*
* DESCRIPTION :
*       Adds commands to offer blowjob to other players.
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

//------------------------------------------------------------------------------

#include <YSI\y_hooks>

#if !defined PRESSED
#define PRESSED(%0) \
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
#endif

//------------------------------------------------------------------------------

// ID of the players who is giving/getting blowjob
new g_p_bjob[MAX_PLAYERS] = { INVALID_PLAYER_ID, ... };

// Stores if the player is giving or receiving a blowjob
new g_p_bjobtype[MAX_PLAYERS];

// How much times the giver sucked
new g_p_blowjob_counter[MAX_PLAYERS];

// Blow job player states
enum
{
	BLOW_JOB_NONE,
	BLOW_JOB_GIVER,
	BLOW_JOB_RECEIVER,
	BLOW_JOB_OFFERER
}

//------------------------------------------------------------------------------

/*
	Checks if a player is giving a blowjob
		return true if yes
		return false if not
*/

bool:IsPlayerGivingBlowJob(playerid)
{
	foreach(new i: Player)
		if(g_p_bjob[playerid] == g_p_bjob[i] && g_p_bjobtype[playerid] == BLOW_JOB_GIVER)
			return true;
	return false;
}

//------------------------------------------------------------------------------

/*
	Sets the playerid of who the player wants to give a blowjob
*/

SetPlayerBlowJobReceiver(playerid, targetid)
{
	g_p_bjob[playerid] = targetid;
	g_p_bjobtype[playerid] = BLOW_JOB_OFFERER;
	return 0;
}
//------------------------------------------------------------------------------

/*
	Sets the playerid of who wants to give a blowjob
*/

SetPlayerBlowJobGiver(playerid, targetid)
{
	g_p_bjob[playerid] = targetid;
	g_p_bjobtype[targetid] = BLOW_JOB_GIVER;
	g_p_bjobtype[playerid] = BLOW_JOB_RECEIVER;
	return 0;
}

//------------------------------------------------------------------------------

/*
	Resets player blowjob data
*/

ResetPlayerBlowJobData(playerid)
{
	g_p_bjob[playerid] = INVALID_PLAYER_ID;
	g_p_bjobtype[playerid] = BLOW_JOB_NONE;
	return 0;
}

//------------------------------------------------------------------------------

/*
	Checks if a player is offering a blowjob
		return true if yes
		return false if not
*/

bool:IsPlayerOfferingBlowJob(playerid)
	return (g_p_bjobtype[playerid] == BLOW_JOB_OFFERER) ? true : false;

//------------------------------------------------------------------------------

/*
	Checks if a player is receiving a blowjob
		return true if yes
		return false if not
*/

bool:IsPlayerGettingBlowJob(playerid)
{
	foreach(new i: Player)
		if(g_p_bjob[playerid] == g_p_bjob[i] && g_p_bjobtype[playerid] == BLOW_JOB_RECEIVER)
			return true;
	return false;
}

//------------------------------------------------------------------------------

/*
	Checks if a player is receiving a blowjob proposal
		return true if yes
		return false if not
*/

bool:IsPlayerGettingBlowJobOffer(playerid)
{
	foreach(new i: Player)
		if(g_p_bjob[i] == playerid && g_p_bjob[playerid] == INVALID_PLAYER_ID)
			return true;
	return false;
}

//------------------------------------------------------------------------------

/*
	Gets the ID of the player who is offering a blowjob
		return the ID of the player
*/

GetPlayerBlowJobOffererID(playerid)
{
	foreach(new i: Player)
		if(g_p_bjob[i] == playerid)
			return i;
	return INVALID_PLAYER_ID;
}

//------------------------------------------------------------------------------

/*
	Gets the ID of the player who the player wants to give a blowjob
		return the ID of the player
*/

GetPlayerBlowJobReceiverID(playerid)
	return g_p_bjob[playerid];

//------------------------------------------------------------------------------

/*
	Called when a player press a key
		playerid - ID of the player
		newkeys - new key pressed
		oldkeys - old key pressed
*/

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(PRESSED(KEY_SPRINT) && IsPlayerGivingBlowJob(playerid))
	{
		new targetid = GetPlayerBlowJobReceiverID(playerid);
		ApplyAnimation(playerid, "BLOWJOBZ", "BJ_STAND_LOOP_W", 4.1, 0, 0, 0, 1, 0, 1);
		ApplyAnimation(targetid, "BLOWJOBZ", "BJ_STAND_LOOP_P", 4.1, 0, 0, 0, 1, 0, 1);

		g_p_blowjob_counter[playerid]++;
		if(g_p_blowjob_counter[playerid] == 10)
		{
			PlayerPlaySound(playerid, 31400, 0.0, 0.0, 0.0);
			PlayerPlaySound(targetid, 31400, 0.0, 0.0, 0.0);
		}
	}
	else if(PRESSED(KEY_SECONDARY_ATTACK) && IsPlayerGivingBlowJob(playerid))
	{
		new targetid = GetPlayerBlowJobReceiverID(playerid);

		ApplyAnimation(playerid, "BLOWJOBZ", "BJ_STAND_END_W", 4.1, 0, 1, 1, 0, 0, 1);
		ApplyAnimation(targetid, "BLOWJOBZ", "BJ_STAND_END_P", 4.1, 0, 1, 1, 0, 0, 1);

		ResetPlayerBlowJobData(playerid);
		ResetPlayerBlowJobData(targetid);

		if(!GetPlayerAchievement(playerid, ACHIEVEMENT_BLOWJOB))
			SetPlayerAchievement(playerid, ACHIEVEMENT_BLOWJOB, true);

		if(g_p_blowjob_counter[playerid] > 9)
		{
			PlayerPlaySound(playerid, 31401, 0.0, 0.0, 0.0);
			PlayerPlaySound(targetid, 31401, 0.0, 0.0, 0.0);
		}
		g_p_blowjob_counter[playerid] = 0;
	}
	else if(PRESSED(KEY_SECONDARY_ATTACK) && IsPlayerGettingBlowJob(playerid))
	{
		new targetid = GetPlayerBlowJobOffererID(playerid);

		ApplyAnimation(playerid, "BLOWJOBZ", "BJ_STAND_END_P", 4.1, 0, 1, 1, 0, 0, 1);
		ApplyAnimation(targetid, "BLOWJOBZ", "BJ_STAND_END_W", 4.1, 0, 1, 1, 0, 0, 1);

		if(!GetPlayerAchievement(targetid, ACHIEVEMENT_BLOWJOB))
			SetPlayerAchievement(targetid, ACHIEVEMENT_BLOWJOB, true);

		ResetPlayerBlowJobData(playerid);
		ResetPlayerBlowJobData(targetid);

		if(g_p_blowjob_counter[targetid] > 9)
		{
			PlayerPlaySound(playerid, 31401, 0.0, 0.0, 0.0);
			PlayerPlaySound(targetid, 31401, 0.0, 0.0, 0.0);
		}
		g_p_blowjob_counter[targetid] = 0;
	}
}

//------------------------------------------------------------------------------

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
		case DIALOG_BLOWJOB_OFFER:
		{
			// ID of the player who was receiving the proposal of blowjob
			new targetid = GetPlayerBlowJobReceiverID(playerid);

			SendClientMessage(playerid, 0xBFBEBEFF, "* Você cancelou a oferta de boquete.");
			SendClientMessage(targetid, 0xBFBEBEFF, "* O jogador cancelou a oferta de boquete.");

			// Closes the player dialog
			ShowPlayerDialog(targetid,-1, 0, " ", " ", " ", " ");
			ResetPlayerBlowJobData(playerid);
		}
		case DIALOG_BLOWJOB_ACCEPT:
		{
			// ID of the player who was giving the proposal of blowjob
			new targetid = GetPlayerBlowJobOffererID(playerid);

			// Closes the player dialog
			ShowPlayerDialog(targetid,-1, 0, " ", " ", " ", " ");
			if(!response)
			{
				SendClientMessage(playerid, 0xBFBEBEFF, "* Você cancelou a oferta de boquete.");
				SendClientMessage(targetid, 0xBFBEBEFF, "* O jogador cancelou a oferta de boquete.");
				ResetPlayerBlowJobData(targetid);
			}
			else
			{
				if(GetPlayerDistanceFromPlayer(playerid, targetid) > 1.0)
				{
					SendClientMessage(playerid, COLOR_ERROR, "* Você não está próximo ao jogador.");
					SendClientMessage(targetid, COLOR_ERROR, "* Você não está próximo ao jogador.");
					ResetPlayerBlowJobData(targetid);
					return -2;
				}

				new Float:a;
				GetPlayerFacingAngle(playerid, a);

				a += 180.0;
				if(a > 359.0)
					a -= 359.0;

				SetPlayerFacingAngle(targetid, a);

				SendClientMessage(playerid, 0xFFFFFFFF, "* Você aceitou a oferta de boquete, pressione {A171B8}F{ffffff} para sair.");
				SendClientMessage(targetid, 0xFFFFFFFF, "* O jogador aceitou a oferta de boquete, pressione {A171B8}F{ffffff} para sair.");

				SetPlayerBlowJobGiver(playerid, targetid);
				ApplyAnimation(playerid, "BLOWJOBZ", "BJ_STAND_START_P", 4.1, 0, 0, 0, 1, 0, 1);
				ApplyAnimation(targetid, "BLOWJOBZ", "BJ_STAND_START_W", 4.1, 0, 0, 0, 1, 0, 1);
				defer OnBlowJobStart(targetid);
			}
			return -2;
		}
	}
	return 1;
}

//------------------------------------------------------------------------------

/*
	Called when a player connects to the server
		playerid - ID of the player
*/

hook OnPlayerConnect(playerid)
{
	if(IsPlayerNPC(playerid))
        return 1;
	
	ResetPlayerBlowJobData(playerid);
	return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerDeath(playerid, killerid, reason)
{
	if(IsPlayerGivingBlowJob(playerid))
	{
		new targetid = GetPlayerBlowJobReceiverID(playerid);

		// ApplyAnimation(playerid, "BLOWJOBZ", "BJ_STAND_END_W", 4.1, 0, 1, 1, 0, 0, 1);
		ApplyAnimation(targetid, "BLOWJOBZ", "BJ_STAND_END_P", 4.1, 0, 1, 1, 0, 0, 1);

		ResetPlayerBlowJobData(playerid);
		ResetPlayerBlowJobData(targetid);

		if(!GetPlayerAchievement(playerid, ACHIEVEMENT_BLOWJOB))
			SetPlayerAchievement(playerid, ACHIEVEMENT_BLOWJOB, true);

		if(g_p_blowjob_counter[playerid] > 9)
		{
			PlayerPlaySound(playerid, 31401, 0.0, 0.0, 0.0);
			PlayerPlaySound(targetid, 31401, 0.0, 0.0, 0.0);
		}
		g_p_blowjob_counter[playerid] = 0;
	}
	else if(IsPlayerGettingBlowJob(playerid))
	{
		new targetid = GetPlayerBlowJobOffererID(playerid);

		// ApplyAnimation(playerid, "BLOWJOBZ", "BJ_STAND_END_P", 4.1, 0, 1, 1, 0, 0, 1);
		ApplyAnimation(targetid, "BLOWJOBZ", "BJ_STAND_END_W", 4.1, 0, 1, 1, 0, 0, 1);

		if(!GetPlayerAchievement(targetid, ACHIEVEMENT_BLOWJOB))
			SetPlayerAchievement(targetid, ACHIEVEMENT_BLOWJOB, true);

		ResetPlayerBlowJobData(playerid);
		ResetPlayerBlowJobData(targetid);

		if(g_p_blowjob_counter[targetid] > 9)
		{
			PlayerPlaySound(playerid, 31401, 0.0, 0.0, 0.0);
			PlayerPlaySound(targetid, 31401, 0.0, 0.0, 0.0);
		}
		g_p_blowjob_counter[targetid] = 0;
	}
	return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerDisconnect(playerid, reason)
{
	if(IsPlayerGivingBlowJob(playerid))
	{
		new targetid = GetPlayerBlowJobReceiverID(playerid);

		ApplyAnimation(playerid, "BLOWJOBZ", "BJ_STAND_END_W", 4.1, 0, 1, 1, 0, 0, 1);
		ApplyAnimation(targetid, "BLOWJOBZ", "BJ_STAND_END_P", 4.1, 0, 1, 1, 0, 0, 1);

		ResetPlayerBlowJobData(playerid);
		ResetPlayerBlowJobData(targetid);

		if(g_p_blowjob_counter[playerid] > 9)
		{
			PlayerPlaySound(playerid, 31401, 0.0, 0.0, 0.0);
			PlayerPlaySound(targetid, 31401, 0.0, 0.0, 0.0);
		}
		g_p_blowjob_counter[playerid] = 0;
	}
	else if(IsPlayerGettingBlowJob(playerid))
	{
		new targetid = GetPlayerBlowJobOffererID(playerid);

		ApplyAnimation(playerid, "BLOWJOBZ", "BJ_STAND_END_P", 4.1, 0, 1, 1, 0, 0, 1);
		ApplyAnimation(targetid, "BLOWJOBZ", "BJ_STAND_END_W", 4.1, 0, 1, 1, 0, 0, 1);

		if(!GetPlayerAchievement(targetid, ACHIEVEMENT_BLOWJOB))
			SetPlayerAchievement(targetid, ACHIEVEMENT_BLOWJOB, true);

		ResetPlayerBlowJobData(playerid);
		ResetPlayerBlowJobData(targetid);

		if(g_p_blowjob_counter[targetid] > 9)
		{
			PlayerPlaySound(playerid, 31401, 0.0, 0.0, 0.0);
			PlayerPlaySound(targetid, 31401, 0.0, 0.0, 0.0);
		}
		g_p_blowjob_counter[targetid] = 0;
	}
	return 1;
}

//------------------------------------------------------------------------------

/*
	Called when a the blowjob starts
		playerid - ID of the player
*/

timer OnBlowJobStart[1250](playerid)
{
	GameTextForPlayer(playerid, "~n~~n~~n~~w~Aperte ~y~ ~k~~PED_SPRINT~ ~w~para chupar", 6000, 5);
}

//------------------------------------------------------------------------------

/*
	offers a blowjob to a player
*/

YCMD:oferecerboquete(playerid, params[], help)
{
	new targetid;
	if(IsPlayerGivingBlowJob(playerid))
		SendClientMessage(playerid, COLOR_ERROR, "* Você já está fazendo um boquete.");
	else if(IsPlayerGettingBlowJob(playerid))
		SendClientMessage(playerid, COLOR_ERROR, "* Você já está recebendo um boquete.");
	else if(IsPlayerOfferingBlowJob(playerid))
		SendClientMessage(playerid, COLOR_ERROR, "* Você já ofereceu um boquete.");
	else if(IsPlayerInAnyVehicle(playerid))
		SendClientMessage(playerid, COLOR_ERROR, "* Você não pode estar em um veículo.");
	else if(sscanf(params, "k<u>", targetid))
		SendClientMessage(playerid, COLOR_INFO, "* /oferecerboquete [playerid]");
	else if(playerid == targetid)
		SendClientMessage(playerid, COLOR_ERROR, "* Você não pode fazer um boquete em você.");
	else if(GetPlayerDistanceFromPlayer(playerid, targetid) > 1.0)
		SendClientMessage(playerid, COLOR_ERROR, "* Você não está próximo ao jogador.");
	else if(IsPlayerInAnyVehicle(targetid))
		SendClientMessage(playerid, COLOR_ERROR, "* O jogador não pode estar em um veículo.");
	else if(IsPlayerGivingBlowJob(targetid))
		SendClientMessage(playerid, COLOR_ERROR, "* O jogador já está dando um boquete.");
	else if(IsPlayerGettingBlowJob(targetid))
		SendClientMessage(playerid, COLOR_ERROR, "* O jogador já está recebendo um boquete.");
	else if(IsPlayerOfferingBlowJob(targetid))
		SendClientMessage(playerid, COLOR_ERROR, "* O jogador está aguardando uma oferta de boquete pendente.");
	else if(IsPlayerGettingBlowJobOffer(targetid))
		SendClientMessage(playerid, COLOR_ERROR, "* O jogador está decidindo uma oferta de boquete pendente.");
	else
	{
		SetPlayerBlowJobReceiver(playerid, targetid);

		new info[84 + MAX_PLAYER_NAME];
		format(info, sizeof(info), "{ffffff}Você ofereceu um boquete à {CEE6ED}%s{ffffff}, aguarde ele aceitar ou recusar.", GetPlayerNamef(targetid));
		ShowPlayerDialog(playerid, DIALOG_BLOWJOB_OFFER, DIALOG_STYLE_MSGBOX, "Boquete", info, "Cancelar", "");

		format(info, sizeof(info), "{CEE6ED}%s{ffffff} está te oferecendo um boquete.", GetPlayerNamef(playerid));
		ShowPlayerDialog(targetid, DIALOG_BLOWJOB_ACCEPT, DIALOG_STYLE_MSGBOX, "Boquete", info, "Aceitar", "Recusar");
	}
	return 1;
}
