/* *************************************************************************** *
*  Description: Pursuit module file.
*
*  Assignment: A script to handle the pursuit of police vs criminal like nfs.
*
*           Copyright Paradise Devs 2015.  All rights reserved.
* *************************************************************************** */

//------------------------------------------------------------------------------

/***
 *    ##     ## ########    ###    ########  ######## ########  
 *    ##     ## ##         ## ##   ##     ## ##       ##     ## 
 *    ##     ## ##        ##   ##  ##     ## ##       ##     ## 
 *    ######### ######   ##     ## ##     ## ######   ########  
 *    ##     ## ##       ######### ##     ## ##       ##   ##   
 *    ##     ## ##       ##     ## ##     ## ##       ##    ##  
 *    ##     ## ######## ##     ## ########  ######## ##     ## 
 ***/

//------------------------------------------------------------------------------

#if defined _MODULE_pursuit
	#endinput
#endif
#define _MODULE_pursuit

#include <YSI\y_hooks>

enum e_WORLD_ZONE
{
	e_WORLD_ZONE_PURSUIT
}
static g_WorldZoneId[e_WORLD_ZONE];

static Timer:g_pPursuitTimer[MAX_PLAYERS] = {Timer:-1, ...};

//------------------------------------------------------------------------------

/***
 *    ######## ##     ## ##    ##  ######  ######## ####  #######  ##    ##  ######  
 *    ##       ##     ## ###   ## ##    ##    ##     ##  ##     ## ###   ## ##    ## 
 *    ##       ##     ## ####  ## ##          ##     ##  ##     ## ####  ## ##       
 *    ######   ##     ## ## ## ## ##          ##     ##  ##     ## ## ## ##  ######  
 *    ##       ##     ## ##  #### ##          ##     ##  ##     ## ##  ####       ## 
 *    ##       ##     ## ##   ### ##    ##    ##     ##  ##     ## ##   ### ##    ## 
 *    ##        #######  ##    ##  ######     ##    ####  #######  ##    ##  ######  
 ***/

//------------------------------------------------------------------------------

/*
	Checks if a player is in a pursuit
		return true if yes
		return false if not
*/

stock IsPlayerInPursuit(playerid)
	return (!GetPVarInt(playerid, "IsPInP")) ? false : true;

//------------------------------------------------------------------------------

/*
	Gets the time the player is in a pursuit as text
*/

stock GetPlayerPursuitTimef(playerid)
{
	new sPursuitTime[32];
	new time = GetPVarInt(playerid, "PursuitTime") / 10;
	format(sPursuitTime, 32, "%02d:%02d", time / 60, time % 60);
	return sPursuitTime;
}

//------------------------------------------------------------------------------

/*
	Sets the player pursuit time in miliseconds
*/

stock SetPlayerPursuitTime(playerid, value)
	return SetPVarInt(playerid, "PursuitTime", value);

//------------------------------------------------------------------------------

/*
	Gets the player pursuit time in miliseconds
*/

stock GetPlayerPursuitTime(playerid)
	return GetPVarInt(playerid, "PursuitTime");

//------------------------------------------------------------------------------

/*
	Gets player's pursuit targetid
*/

stock GetPlayerPursuitTarget(playerid)
	return GetPVarInt(playerid, "PursuitTarget") - 1;

//------------------------------------------------------------------------------

/*
	Sets player's pursuit targetid
*/

stock SetPlayerPursuitTarget(playerid, targetid)
	return SetPVarInt(playerid, "PursuitTarget", targetid + 1);

//------------------------------------------------------------------------------

stock GetPlayerPursuitChaser(playerid)
	return GetPVarInt(playerid, "IsChased") - 1;

//------------------------------------------------------------------------------

/*
	Sets player's pursuit chaserid
*/

stock SetPlayerPursuitChaser(playerid, targetid)
	return SetPVarInt(playerid, "IsChased", targetid + 1);

//------------------------------------------------------------------------------

/*
	Checks if the player is being chased
*/

stock IsPlayerPursuitChased(playerid)
	return (GetPVarInt(playerid, "IsChased"));

//------------------------------------------------------------------------------

/*
	Checks if the player is chasing
*/

stock IsPlayerPursuitChasing(playerid)
	return (GetPVarInt(playerid, "PursuitTarget"));

//------------------------------------------------------------------------------

/*
	Sets progress bar value
*/

stock SetPlayerPursuitValue(playerid, Float:value)
{
	if(value > 100.0) value = 100.0;
	else if(value < 0.0) value = 0.0;
	return SetPVarFloat(playerid, "PursuitValue", value);
}

//------------------------------------------------------------------------------

/*
	Gets progress bar value
*/

stock Float:GetPlayerPursuitValue(playerid)
	return GetPVarFloat(playerid, "PursuitValue");

//------------------------------------------------------------------------------

/***
 *     ######     ###    ##       ##       ########     ###     ######  ##    ## 
 *    ##    ##   ## ##   ##       ##       ##     ##   ## ##   ##    ## ##   ##  
 *    ##        ##   ##  ##       ##       ##     ##  ##   ##  ##       ##  ##   
 *    ##       ##     ## ##       ##       ########  ##     ## ##       #####    
 *    ##       ######### ##       ##       ##     ## ######### ##       ##  ##   
 *    ##    ## ##     ## ##       ##       ##     ## ##     ## ##    ## ##   ##  
 *     ######  ##     ## ######## ######## ########  ##     ##  ######  ##    ## 
 ***/

//------------------------------------------------------------------------------

timer OnPlayerPursuitUpdate[100](playerid)
{
	// If player is not in a pursuit, do nothing
	if(!IsPlayerInPursuit(playerid))
		return 0;

	// Increase player pursuit time
	SetPlayerPursuitTime(playerid, GetPlayerPursuitTime(playerid) + 1);

	// Update pursuit textdraw
	if(IsPlayerPursuitChased(playerid))
	{
		if(GetPlayerDistanceFromPlayer(playerid, GetPlayerPursuitChaser(playerid)) < 11.0 && GetPlayerPursuitValue(playerid) > 50)
			SetPlayerPursuitValue(playerid, 50.0);
		else if(GetPlayerDistanceFromPlayer(playerid, GetPlayerPursuitChaser(playerid)) < 15.0 && GetPlayerPursuitValue(playerid) <= 50)
			SetPlayerPursuitValue(playerid, floatsub(GetPlayerPursuitValue(playerid), 0.9));
		else if(GetPlayerDistanceFromPlayer(playerid, GetPlayerPursuitChaser(playerid)) < 20.0 && GetPlayerPursuitValue(playerid) <= 50)
			SetPlayerPursuitValue(playerid, floatsub(GetPlayerPursuitValue(playerid), 0.6));
		else if(GetPlayerDistanceFromPlayer(playerid, GetPlayerPursuitChaser(playerid)) <= 25.0 && GetPlayerPursuitValue(playerid) <= 50)
			SetPlayerPursuitValue(playerid, floatsub(GetPlayerPursuitValue(playerid), 0.3));
		else if(GetPlayerDistanceFromPlayer(playerid, GetPlayerPursuitChaser(playerid)) <= 25.0 && GetPlayerPursuitValue(playerid) >= 50)
		{
			if(floatsub(GetPlayerPursuitValue(playerid), 1.0) < 50.0)
				SetPlayerPursuitValue(playerid, 50.0);
			else
				SetPlayerPursuitValue(playerid, floatsub(GetPlayerPursuitValue(playerid), 1.0));
		}
		else if(GetPlayerDistanceFromPlayer(playerid, GetPlayerPursuitChaser(playerid)) > 25.0 && GetPlayerDistanceFromPlayer(playerid, GetPlayerPursuitChaser(playerid)) < 35.0)
		{
			if(GetPlayerPursuitValue(playerid) > 50)
				SetPlayerPursuitValue(playerid, floatsub(GetPlayerPursuitValue(playerid), 1.0));
			else if(GetPlayerPursuitValue(playerid) < 50)
				SetPlayerPursuitValue(playerid, floatadd(GetPlayerPursuitValue(playerid), 0.3));
			else if(GetPlayerPursuitValue(playerid) == 50)
				SetPlayerPursuitValue(playerid, floatadd(GetPlayerPursuitValue(playerid), 0.1));
		}
		else if(GetPlayerDistanceFromPlayer(playerid, GetPlayerPursuitChaser(playerid)) > 250.0 && GetPlayerPursuitValue(playerid) < 100)
			SetPlayerPursuitValue(playerid, floatadd(GetPlayerPursuitValue(playerid), 1.0));
		else if(GetPlayerDistanceFromPlayer(playerid, GetPlayerPursuitChaser(playerid)) >= 35.0 && GetPlayerDistanceFromPlayer(playerid, GetPlayerPursuitChaser(playerid)) < 45.0 && GetPlayerPursuitValue(playerid) >= 50)
			SetPlayerPursuitValue(playerid, floatadd(GetPlayerPursuitValue(playerid), 0.1));
		else if(GetPlayerDistanceFromPlayer(playerid, GetPlayerPursuitChaser(playerid)) >= 45.0 && GetPlayerDistanceFromPlayer(playerid, GetPlayerPursuitChaser(playerid)) < 55.0 && GetPlayerPursuitValue(playerid) >= 50)
			SetPlayerPursuitValue(playerid, floatadd(GetPlayerPursuitValue(playerid), 0.2));
		else if(GetPlayerDistanceFromPlayer(playerid, GetPlayerPursuitChaser(playerid)) >= 55.0 && GetPlayerPursuitValue(playerid) >= 50)
			SetPlayerPursuitValue(playerid, floatadd(GetPlayerPursuitValue(playerid), 0.3));
		else if(GetPlayerDistanceFromPlayer(playerid, GetPlayerPursuitChaser(playerid)) >= 35.0 && GetPlayerPursuitValue(playerid) < 50)
		{
			if(floatadd(GetPlayerPursuitValue(playerid), 0.8) > 50.0)
				SetPlayerPursuitValue(playerid, 50.0);
			else
				SetPlayerPursuitValue(playerid, floatadd(GetPlayerPursuitValue(playerid), 0.8));
		}
		SetPlayerPursuitBar(playerid, GetPlayerPursuitValue(playerid));
		SetPlayerPursuitTimeHUD(playerid, GetPlayerPursuitTimef(playerid));

		if(GetPlayerPursuitValue(playerid) >= 100.0)
			OnPlayerEscapePursuit(playerid);
		else if(GetPlayerPursuitValue(playerid) <= 0.0)
			OnPlayerArrestedPursuit(playerid);
	}
	else if(IsPlayerPursuitChasing(playerid))
	{
		SetPlayerPursuitBar(playerid, GetPlayerPursuitValue(GetPlayerPursuitTarget(playerid)));
		SetPlayerPursuitTimeHUD(playerid, GetPlayerPursuitTimef(GetPlayerPursuitTarget(playerid)));
	}
	return 1;
}

//------------------------------------------------------------------------------

timer PutPlayerInPoliceVehicle[5000](playerid, targetid)
{
	new Float:pos[3];
	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	SetPlayerPos(playerid, pos[0], pos[1], pos[2]+3);

	SetPlayerCuffed(playerid, true);
	defer PutPlayerInPoliceVehicle_2(playerid, targetid);
}

//------------------------------------------------------------------------------

timer PutPlayerInPoliceVehicle_2[500](playerid, targetid)
{
	PutPlayerInVehicle(playerid, GetPlayerVehicleID(targetid), 3);
}

//------------------------------------------------------------------------------

/*
	Called when a player escapes the pursuit
*/

forward OnPlayerEscapePursuit(playerid);
public OnPlayerEscapePursuit(playerid)
{
	foreach(new i: Player)
	{
		if(GetPlayerPursuitTarget(i) == playerid)
		{
			stop g_pPursuitTimer[i];
			g_pPursuitTimer[i] = Timer:-1;
			SendClientMessage(i, 0x14cfbbff, "* O fugitivo escapou da perseguição!");
			HidePlayerPursuitHUD(i);
			StopAudioStreamForPlayer(i);
			GangZoneHideForPlayer(i, g_WorldZoneId[e_WORLD_ZONE_PURSUIT]);
			DeletePVar(i, "PursuitValue");
			DeletePVar(i, "PursuitTarget");
			DeletePVar(i, "PursuitTime");
			DeletePVar(i, "IsChased");
			DeletePVar(i, "IsPInP");
		}
	}

	stop g_pPursuitTimer[playerid];
	g_pPursuitTimer[playerid] = Timer:-1;

	SendClientMessage(playerid, 0x14cfbbff, "* Você escapou da perseguição!");
	HidePlayerPursuitHUD(playerid);
	GangZoneHideForPlayer(playerid, g_WorldZoneId[e_WORLD_ZONE_PURSUIT]);
	StopAudioStreamForPlayer(playerid);

	DeletePVar(playerid, "PursuitValue");
	DeletePVar(playerid, "PursuitTarget");
	DeletePVar(playerid, "PursuitTime");
	DeletePVar(playerid, "IsChased");
	DeletePVar(playerid, "IsPInP");
	return 1;
}

//------------------------------------------------------------------------------

/*
	Called when a player is caught
*/

forward OnPlayerArrestedPursuit(playerid);
public OnPlayerArrestedPursuit(playerid)
{
	new nearest = INVALID_PLAYER_ID;
	new Float:dist = 100.0;

	FadeOut(playerid, 0);
	defer FadeInTimer(playerid);

	foreach(new i: Player)
	{
		if(GetPlayerPursuitTarget(i) == playerid)
		{
			SendClientMessage(i, 0x14cfbbff, "* O fugitivo foi capturado!");

			if(GetPlayerDistanceFromPlayer(playerid, i) < dist && GetPlayerState(i) == PLAYER_STATE_DRIVER) 
				nearest = i;

			stop g_pPursuitTimer[i];
			g_pPursuitTimer[i] = Timer:-1;
			HidePlayerPursuitHUD(i);
			GangZoneHideForPlayer(i, g_WorldZoneId[e_WORLD_ZONE_PURSUIT]);
			StopAudioStreamForPlayer(i);
			DeletePVar(i, "PursuitValue");
			DeletePVar(i, "PursuitTarget");
			DeletePVar(i, "PursuitTime");
			DeletePVar(i, "IsChased");
			DeletePVar(i, "IsPInP");
		}
	}

	stop g_pPursuitTimer[playerid];
	g_pPursuitTimer[playerid] = Timer:-1;

	SendClientMessage(playerid, 0x14cfbbff, "* Você foi capturado pela policia!");

	HidePlayerPursuitHUD(playerid);
	StopAudioStreamForPlayer(playerid);
	GangZoneHideForPlayer(playerid, g_WorldZoneId[e_WORLD_ZONE_PURSUIT]);

	// TogglePlayerControllable(playerid, 0);

	defer PutPlayerInPoliceVehicle(playerid, nearest);

	DeletePVar(playerid, "PursuitValue");
	DeletePVar(playerid, "PursuitTarget");
	DeletePVar(playerid, "PursuitTime");
	DeletePVar(playerid, "IsChased");
	DeletePVar(playerid, "IsPInP");
	return 1;
}

//------------------------------------------------------------------------------

hook OnGameModeInit()
{
	g_WorldZoneId[e_WORLD_ZONE_PURSUIT] = GangZoneCreate(-3000.0, -3000.0, 3000.0, 3000.0);
}

//------------------------------------------------------------------------------

hook OnPlayerDisconnect(playerid, reason)
{
	if(g_pPursuitTimer[playerid] != Timer:-1)
	{
		stop g_pPursuitTimer[playerid];
		g_pPursuitTimer[playerid] = Timer:-1;

		foreach(new i: Player)
		{
			if(GetPlayerPursuitTarget(i) == playerid)
			{
				stop g_pPursuitTimer[i];
				g_pPursuitTimer[i] = Timer:-1;
				
				SendClientMessage(i, 0x14cfbbff, "* O fugitivo escapou da perseguição!");
				HidePlayerPursuitHUD(i);
				StopAudioStreamForPlayer(i);
				GangZoneHideForPlayer(i, g_WorldZoneId[e_WORLD_ZONE_PURSUIT]);
				DeletePVar(i, "PursuitValue");
				DeletePVar(i, "PursuitTarget");
				DeletePVar(i, "PursuitTime");
				DeletePVar(i, "IsChased");
				DeletePVar(i, "IsPInP");
			}
		}
	}
}

//------------------------------------------------------------------------------

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

/*
	Starts a chase
*/

YCMD:perseguir(playerid, params[], help)
{
	if(GetFactionType(GetPlayerFactionID(playerid)) != FACTION_TYPE_POLICE)
	 	return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

	else if(!IsPlayerOnDuty(playerid))
	 	return SendClientMessage(playerid, COLOR_ERROR, "* Você não está em serviço.");
	
	new targetid;
	if(sscanf(params, "u", targetid))
		return SendClientMessage(playerid, COLOR_INFO, "/perseguir [playerid]");
	
	else if(playerid == targetid)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não pode perseguir você mesmo.");
	
	else if(IsPlayerInVehicle(targetid, GetPlayerVehicleID(playerid)) && IsPlayerInAnyVehicle(playerid))
		return SendClientMessage(playerid, COLOR_ERROR, "* O jogador já está em seu veículo.");
	
	else if(GetPlayerDistanceFromPlayer(playerid, targetid) > 350.0)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você está muito longe do jogador.");		

	DeletePVar(targetid, "PursuitTarget");
	DeletePVar(playerid, "IsChased");
	
	SetPlayerPursuitTime(playerid, 0);
	SetPlayerPursuitValue(playerid, 50);
	SetPlayerPursuitTarget(playerid, targetid);
	ShowPlayerPursuitHUD(playerid);

	SetPlayerPursuitValue(targetid, 50);
	SetPlayerPursuitTime(targetid, 0);
	SetPlayerPursuitChaser(targetid, playerid);
	ShowPlayerPursuitHUD(targetid);

	SetPVarInt(playerid, "IsPInP", true);
	SetPVarInt(targetid, "IsPInP", true);

	GangZoneShowForPlayer(playerid, g_WorldZoneId[e_WORLD_ZONE_PURSUIT], 0xFF0000CC);
	GangZoneShowForPlayer(targetid, g_WorldZoneId[e_WORLD_ZONE_PURSUIT], 0xFF0000CC);

	GangZoneFlashForPlayer(playerid, g_WorldZoneId[e_WORLD_ZONE_PURSUIT], 0x0000FFCC);
	GangZoneFlashForPlayer(targetid, g_WorldZoneId[e_WORLD_ZONE_PURSUIT], 0x0000FFCC);

	new rand = random(4);

	switch(rand)
	{
		case 0: {
			PlayAudioStreamForPlayer(playerid, "https://dl.dropboxusercontent.com/u/70544925/pc/chase/chase.mp3");
			PlayAudioStreamForPlayer(targetid, "https://dl.dropboxusercontent.com/u/70544925/pc/chase/chase.mp3");
		}
		case 1: {
			PlayAudioStreamForPlayer(playerid, "https://dl.dropboxusercontent.com/u/70544925/pc/chase/chase2.mp3");
			PlayAudioStreamForPlayer(targetid, "https://dl.dropboxusercontent.com/u/70544925/pc/chase/chase2.mp3");
		}
		case 2: {
			PlayAudioStreamForPlayer(playerid, "https://dl.dropboxusercontent.com/u/70544925/pc/chase/chase3.mp3");
			PlayAudioStreamForPlayer(targetid, "https://dl.dropboxusercontent.com/u/70544925/pc/chase/chase3.mp3");
		}
		case 3: {
			PlayAudioStreamForPlayer(playerid, "https://dl.dropboxusercontent.com/u/70544925/pc/chase/chase4.mp3");
			PlayAudioStreamForPlayer(targetid, "https://dl.dropboxusercontent.com/u/70544925/pc/chase/chase4.mp3");
		}
	}

	SendClientMessagef(playerid, COLOR_YELLOW, "* Você iniciou uma perseguição contra %s.", GetPlayerNamef(targetid));
	SendClientMessagef(targetid, COLOR_YELLOW, "* O policial %s começou a perseguir você.", GetPlayerNamef(playerid));

	g_pPursuitTimer[playerid] = repeat OnPlayerPursuitUpdate(playerid);
	g_pPursuitTimer[targetid] = repeat OnPlayerPursuitUpdate(targetid);
	return 1;
}