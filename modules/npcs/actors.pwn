/* *************************************************************************** *
*  Description: Actors module file.
*
*  Assignment: A script to add actors on server.
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

#if defined _MODULE_actors
	#endinput
#endif
#define _MODULE_actors

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

// Actors IDs
enum
{
	ACTOR_LSPD_1,
	ACTOR_LSPD_2,
	ACTOR_LSPD_4,
	ACTOR_LSPD_5,
	ACTOR_LSPD_6,
	ACTOR_LSPD_7,
	ACTOR_LSPD_8,
	ACTOR_LSPD_9,
	ACTOR_SCHOOL,
	ACTOR_CITYHALL,
	ACTOR_LOTTERY,
	ACTOR_HAIRCUT_1,
	ACTOR_HAIRCUT_2,
	ACTOR_HAIRCUT_3,
	ACTOR_STRIPCLUB_1,
	ACTOR_STRIPCLUB_2,
	ACTOR_STRIPCLUB_3,
	ACTOR_STRIPCLUB_4,
	ACTOR_STRIPCLUB_5,
	ACTOR_PRISION,
	ACTOR_HOSPITAL,
	ACTOR_AIRPORT,
	ACTOR_NEWS_1,
	ACTOR_NEWS_2,
	ACTOR_FISHING,
	ACTOR_BOXER
}

// Actors data
enum E_ACTOR_DATA
{
	E_ID,
	bool:E_IS_HANDSUP,
	bool:E_WAS_HIT
}
new gActorData[54][E_ACTOR_DATA]; // Actor limit: 1000 (0.3.7)

//------------------------------------------------------------------------------

/*
	Checks if an actor is in a range of point
		return true if yes
		return false if not
*/

stock bool:IsActorInRangeOfPoint(actorid, Float:range, Float:x, Float:y, Float:z)
{
    if(!IsValidActor(actorid))
    	return false;

	new Float:oldposx, Float:oldposy, Float:oldposz;
	new Float:tempposx, Float:tempposy, Float:tempposz;
	GetActorPos(actorid, oldposx, oldposy, oldposz);
	tempposx = (oldposx -x);
	tempposy = (oldposy -y);
	tempposz = (oldposz -z);
	if(((tempposx < range) && (tempposx > -range)) && ((tempposy < range) && (tempposy > -range)) && ((tempposz < range) && (tempposz > -range)))
		return true;
	return false;
}

//------------------------------------------------------------------------------

/*
	Called 15 seconds after an actor has been hit or threatened
		actorid - ID of the actor
*/

timer ResetActorAnimation[15000](actorid)
{
	if(!IsValidActor(actorid))
		return false;

	if(gActorData[ACTOR_LSPD_1][E_ID] == actorid)
		ApplyActorAnimation(actorid, "COP_AMBIENT", "COPLOOK_LOOP", 4.1, 1, 0, 0, 1, 0);
	else if(gActorData[ACTOR_LSPD_2][E_ID] == actorid)
		ApplyActorAnimation(actorid, "COP_AMBIENT", "COPBROWSE_LOOP", 4.1, 1, 0, 0, 1, 0);
	else if(gActorData[ACTOR_LSPD_4][E_ID] == actorid)
		ApplyActorAnimation(actorid, "COP_AMBIENT", "COPBROWSE_NOD", 4.0, 1, 0, 0, 0, 0);
	else if(gActorData[ACTOR_LSPD_5][E_ID] == actorid)
		ApplyActorAnimation(actorid, "INT_OFFICE", "OFF_SIT_TYPE_LOOP", 4.0, 1, 0, 0, 0, 0);
	else if(gActorData[ACTOR_LSPD_6][E_ID] == actorid)
		ApplyActorAnimation(actorid, "COP_AMBIENT", "COPLOOK_LOOP", 4.1, 1, 0, 0, 1, 0);
	else if(gActorData[ACTOR_LSPD_7][E_ID] == actorid)
		ApplyActorAnimation(actorid, "INT_OFFICE", "OFF_SIT_BORED_LOOP", 4.0, 1, 0, 0, 0, 0);
	else if(gActorData[ACTOR_LSPD_8][E_ID] == actorid)
		ApplyActorAnimation(actorid, "INT_SHOP", "SHOP_LOOP", 4.0, 1, 0, 0, 0, 0);
	else if(gActorData[ACTOR_LSPD_9][E_ID] == actorid)
		ApplyActorAnimation(actorid, "COP_AMBIENT", "COPLOOK_NOD", 4.0, 1, 0, 0, 0, 0);
	else if(gActorData[ACTOR_SCHOOL][E_ID] == actorid)
		ApplyActorAnimation(actorid, "PED", "SEAT_IDLE", 4.0, 1, 0, 0, 0, 0);
	else if(gActorData[ACTOR_CITYHALL][E_ID] == actorid)
		ApplyActorAnimation(actorid, "PED", "SEAT_IDLE", 4.0, 1, 0, 0, 0, 0);
	else if(gActorData[ACTOR_LOTTERY][E_ID] == actorid)
		ApplyActorAnimation(actorid, "BAR", "BARMAN_IDLE", 4.0, 1, 0, 0, 0, 0);
	else if(gActorData[ACTOR_HAIRCUT_1][E_ID] == actorid)
		ApplyActorAnimation(actorid, "HAIRCUTS", "BRB_SIT_LOOP", 4.0, 1, 0, 0, 0, 0);
	else if(gActorData[ACTOR_HAIRCUT_2][E_ID] == actorid)
		ApplyActorAnimation(actorid, "HAIRCUTS", "BRB_CUT", 4.0, 1, 0, 0, 0, 0);
	else if(gActorData[ACTOR_HAIRCUT_3][E_ID] == actorid)
		ApplyActorAnimation(actorid, "PED", "SEAT_IDLE", 4.0, 1, 0, 0, 0, 0);
	else if(gActorData[ACTOR_STRIPCLUB_1][E_ID] == actorid)
		ApplyActorAnimation(actorid, "STRIP", "STRIP_G", 4.0, 1, 0, 0, 0, 0);
	else if(gActorData[ACTOR_STRIPCLUB_2][E_ID] == actorid)
		ApplyActorAnimation(actorid, "STRIP", "STR_LOOP_A", 4.0, 1, 0, 0, 0, 0);
	else if(gActorData[ACTOR_STRIPCLUB_3][E_ID] == actorid)
		ApplyActorAnimation(actorid," STRIP", "STR_LOOP_B", 4.0, 1, 0, 0, 0, 0);
	else if(gActorData[ACTOR_STRIPCLUB_4][E_ID] == actorid)
		ApplyActorAnimation(actorid, "STRIP", "STR_LOOP_B", 4.0, 1, 0, 0, 0, 0);
	else if(gActorData[ACTOR_STRIPCLUB_5][E_ID] == actorid)
		ApplyActorAnimation(actorid, "BAR", "BARMAN_IDLE", 4.0, 1, 0, 0, 0, 0);
	else if(gActorData[ACTOR_PRISION][E_ID] == actorid)
		ApplyActorAnimation(actorid, "CRACK", "CRCKIDLE1", 4.0, 1, 1, 1, 1, 0);
	else if(gActorData[ACTOR_HOSPITAL][E_ID] == actorid)
		ApplyActorAnimation(actorid, "BAR", "BARSERVE_LOOP", 4.0, 1, 0, 0, 0, 0);
	else if(gActorData[ACTOR_AIRPORT][E_ID] == actorid)
		ApplyActorAnimation(actorid, "COP_AMBIENT", "COPLOOK_LOOP", 4.1, 1, 0, 0, 1, 0);
	else if(gActorData[ACTOR_NEWS_1][E_ID] == actorid)
		ApplyActorAnimation(actorid, "INT_OFFICE", "OFF_SIT_CRASH", 4.0, 1, 0, 0, 0, 0);
	else if(gActorData[ACTOR_NEWS_2][E_ID] == actorid)
		ApplyActorAnimation(actorid, "INT_OFFICE", "OFF_SIT_BORED_LOOP", 4.0, 1, 0, 0, 0, 0);
	else if(gActorData[ACTOR_FISHING][E_ID] == actorid)
		ApplyActorAnimation(actorid, "SAMP", "FishingIdle", 4.0, 1, 0, 0, 0, 0);
	else if(gActorData[ACTOR_BOXER][E_ID] == actorid)
		ApplyActorAnimation(actorid, "FIGHT_B", "FIGHTB_IDLE", 4.0, 1, 0, 0, 0, 0);

	if(gActorData[actorid][E_IS_HANDSUP] == true)
		gActorData[actorid][E_IS_HANDSUP] = false;

	if(gActorData[actorid][E_WAS_HIT] == true)
		gActorData[actorid][E_WAS_HIT] = false;
	return true;
}

//------------------------------------------------------------------------------

 /*
	Called every player update (A LOT)
		playerid - ID of the player
*/

hook OnPlayerUpdate(playerid)
{// Actor Artificial Inteligence
	// Only call this every 1500ms to not stress the server
	if(GetPVarInt(playerid, "actor_check_update") < GetTickCount())
	{
		SetPVarInt(playerid, "actor_check_update", GetTickCount() + 1500);
		new actorid = GetPlayerTargetActor(playerid);

		// Check if the player is using a GUN to aim
		if(actorid != INVALID_ACTOR_ID && (GetPlayerWeapon(playerid) >= 22 && GetPlayerWeapon(playerid) <= 38) && !IsActorADeadbody(actorid))
		{
			// Check if the actor is already with hands up
			if(!gActorData[actorid][E_IS_HANDSUP] && !gActorData[actorid][E_WAS_HIT])
			{
				ApplyActorAnimation(actorid, "PED", "HANDSUP", 4.0, 0, 0, 0, 1, 0);
				gActorData[actorid][E_IS_HANDSUP] = true;

				defer ResetActorAnimation(actorid);
			}
		}
	}
	return 1;
}

//------------------------------------------------------------------------------

 /*
	Called when a player hits an actor
		playerid - ID of the player
		damaged_actor - ID of the actor
		amount - amount of damage given
		weaponid - weapon used
		bodypart - part of body hit
*/

hook OnPlayerGiveDamageActor(playerid, damaged_actorid, Float:amount, weaponid, bodypart)
{
	for(new i = 0; i < sizeof(gActorData); i++)
	{
		if(gActorData[i][E_ID] != damaged_actorid)
			continue;

		if(!gActorData[i][E_WAS_HIT])
		{
			ApplyActorAnimation(damaged_actorid, "PED", "COWER", 4.0, 0, 0, 0, 1, 0);
			gActorData[i][E_WAS_HIT] = true;
			if(!gActorData[i][E_IS_HANDSUP])
				defer ResetActorAnimation(damaged_actorid);
			else
				gActorData[i][E_IS_HANDSUP] = false;
		}
	}
	return 1;
}

//------------------------------------------------------------------------------

 /*
	Called when the server starts
*/

hook OnGameModeInit()
{
	// LSPD Actors
	gActorData[ACTOR_LSPD_1][E_ID] = CreateActor(281, 230.56, 165.16, 1003.02, 272.90);// Officer inside LSPD downstairs.
	ApplyActorAnimation(gActorData[ACTOR_LSPD_1][E_ID], "COP_AMBIENT", "COPLOOK_LOOP", 4.1, 1, 0, 0, 1, 0);

	gActorData[ACTOR_LSPD_2][E_ID] = CreateActor(280, 300.86, 187.63, 1007.17, 357.52);// Officer inside LSPD upstairs.
	ApplyActorAnimation(gActorData[ACTOR_LSPD_2][E_ID], "COP_AMBIENT", "COPBROWSE_LOOP", 4.1, 1, 0, 0, 1, 0);

	gActorData[ACTOR_LSPD_4][E_ID] = CreateActor(307, 221.75, 183.26, 1003.03, 357.54);// Officer inside LSPD searching files.
	ApplyActorAnimation(gActorData[ACTOR_LSPD_4][E_ID], "COP_AMBIENT", "COPBROWSE_NOD", 4.0, 1, 0, 0, 0, 0);

	gActorData[ACTOR_LSPD_5][E_ID] = CreateActor(309, 257.5406, 192.2776, 1008.1719, 11.5794);// Officer inside LSPD using computer upstairs.
	ApplyActorAnimation(gActorData[ACTOR_LSPD_5][E_ID], "INT_OFFICE", "OFF_SIT_TYPE_LOOP", 4.0, 1, 0, 0, 0, 0);

	gActorData[ACTOR_LSPD_6][E_ID] = CreateActor(283, 247.43, 184.08, 1008.17, 170.72);// Officer inside LSPD watching upstairs.
	ApplyActorAnimation(gActorData[ACTOR_LSPD_6][E_ID], "COP_AMBIENT", "COPLOOK_LOOP", 4.1, 1, 0, 0, 1, 0);

	gActorData[ACTOR_LSPD_7][E_ID] = CreateActor(282, 199.2144, 168.9372, 1003.0234, 252.8483);// Officer inside LSPD near cells.
	ApplyActorAnimation(gActorData[ACTOR_LSPD_7][E_ID], "INT_OFFICE", "OFF_SIT_BORED_LOOP", 4.0, 1, 0, 0, 0, 0);

	gActorData[ACTOR_LSPD_8][E_ID] = CreateActor(300, 209.81, 187.15, 1003.03, 87.45);// Officer inside LSPD looking books
	ApplyActorAnimation(gActorData[ACTOR_LSPD_8][E_ID], "INT_SHOP", "SHOP_LOOP", 4.0, 1, 0, 0, 0, 0);

	gActorData[ACTOR_LSPD_9][E_ID] = CreateActor(301, 1580.4302, -1634.1248, 13.5624, 356.1498);// Officer outside LSPD garage gate
	ApplyActorAnimation(gActorData[ACTOR_LSPD_9][E_ID], "COP_AMBIENT", "COPLOOK_NOD", 4.0, 1, 0, 0, 0, 0);

	// School Actors
	gActorData[ACTOR_SCHOOL][E_ID] = CreateActor(259, -2034.35, -117.42, 1034.39, 271.53);// AutoSchool inside building actor
	ApplyActorAnimation(gActorData[ACTOR_SCHOOL][E_ID], "PED", "SEAT_IDLE", 4.0, 1, 0, 0, 0, 0);

	// City Hall Actors
	gActorData[ACTOR_CITYHALL][E_ID] = CreateActor(240, 359.61, 173.62, 1008.38, 271.98);// Inside City Hall actor skin: 150
	ApplyActorAnimation(gActorData[ACTOR_CITYHALL][E_ID], "PED", "SEAT_IDLE", 4.0, 1, 0, 0, 0, 0);

	// Lottery Actors
	gActorData[ACTOR_LOTTERY][E_ID] = CreateActor(233, 820.08, 2.74, 1004.17, 267.29);// Inside Lottery actor
	ApplyActorAnimation(gActorData[ACTOR_LOTTERY][E_ID], "BAR", "BARMAN_IDLE", 4.0, 1, 0, 0, 0, 0);

	// Haircut Actors
	gActorData[ACTOR_HAIRCUT_1][E_ID] = CreateActor(236, 421.39, -78.96, 1001.80, 95.06);// Actor on chair
	ApplyActorAnimation(gActorData[ACTOR_HAIRCUT_1][E_ID], "HAIRCUTS", "BRB_SIT_LOOP", 4.0, 1, 0, 0, 0, 0);

	gActorData[ACTOR_HAIRCUT_2][E_ID] = CreateActor(156, 419.23, -77.20, 1001.80, 275.54);// Actor barber
	ApplyActorAnimation(gActorData[ACTOR_HAIRCUT_2][E_ID], "HAIRCUTS", "BRB_CUT", 4.0, 1, 0, 0, 0, 0);

	gActorData[ACTOR_HAIRCUT_3][E_ID] = CreateActor(221, 417.21, -79.73, 1001.81, 266.26);// Actor next to cut
	ApplyActorAnimation(gActorData[ACTOR_HAIRCUT_3][E_ID], "PED", "SEAT_IDLE", 4.0, 1, 0, 0, 0, 0);

	// Stripclub Actor
	gActorData[ACTOR_STRIPCLUB_1][E_ID] = CreateActor(246, 1213.37, -4.45, 1001.32, 359.08);// Striper Poli dance
	ApplyActorAnimation(gActorData[ACTOR_STRIPCLUB_1][E_ID], "STRIP", "STRIP_G", 4.0, 1, 0, 0, 0, 0);

	gActorData[ACTOR_STRIPCLUB_2][E_ID] = CreateActor(237, 1208.31, -6.38, 1001.32, 174.21);// Striper near exit door
	ApplyActorAnimation(gActorData[ACTOR_STRIPCLUB_2][E_ID], "STRIP", "STR_LOOP_A", 4.0, 1, 0, 0, 0, 0);

	gActorData[ACTOR_STRIPCLUB_3][E_ID] = CreateActor(244, 1221.09, 8.68, 1001.33, 138.78);// Striper on corner
	ApplyActorAnimation(gActorData[ACTOR_STRIPCLUB_3][E_ID], "STRIP", "STR_LOOP_B", 4.0, 1, 0, 0, 0, 0);

	gActorData[ACTOR_STRIPCLUB_4][E_ID] = CreateActor(87, 1221.95, -5.81, 1001.32, 130.12);// Striper in the middle
	ApplyActorAnimation(gActorData[ACTOR_STRIPCLUB_4][E_ID], "STRIP", "STR_LOOP_B", 4.0, 1, 0, 0, 0, 0);

	gActorData[ACTOR_STRIPCLUB_5][E_ID] = CreateActor(257, 1216.33, -15.38, 1000.92, 359.08);// Bartender
	ApplyActorAnimation(gActorData[ACTOR_STRIPCLUB_5][E_ID], "BAR", "BARMAN_IDLE", 4.0, 1, 0, 0, 0, 0);

	// Prision Actor (Easter Egg)
	gActorData[ACTOR_PRISION][E_ID] = CreateActor(0, 199.30, 163.58, 1003.03, 173.16);// CJ in Prision
	ApplyActorAnimation(gActorData[ACTOR_PRISION][E_ID], "CRACK", "CRCKIDLE1", 4.0, 1, 1, 1, 1, 0);

	// Hospital Actor
	gActorData[ACTOR_HOSPITAL][E_ID] = CreateActor(70, 346.53, 160.59, 1014.18, 118.44);// Doctor
	ApplyActorAnimation(gActorData[ACTOR_HOSPITAL][E_ID], "BAR", "BARSERVE_LOOP", 4.0, 1, 0, 0, 0, 0);

	// Airport Actor
	gActorData[ACTOR_AIRPORT][E_ID] = CreateActor(71, 1955.82, -2181.60, 13.58, 271.18);// Airport Guard Boxes
	ApplyActorAnimation(gActorData[ACTOR_AIRPORT][E_ID], "COP_AMBIENT", "COPLOOK_LOOP", 4.1, 1, 0, 0, 1, 0);

	// News Actor
	gActorData[ACTOR_NEWS_1][E_ID] = CreateActor(227, 355.2786, 201.1419, 1008.3828, 353.8667);// Angry reporter
	ApplyActorAnimation(gActorData[ACTOR_NEWS_1][E_ID], "INT_OFFICE", "OFF_SIT_CRASH", 4.0, 1, 0, 0, 0, 0);

	gActorData[ACTOR_NEWS_2][E_ID] = CreateActor(17, 362.7113, 204.1183, 1008.3828, 180.5132);// Bored reporter
	ApplyActorAnimation(gActorData[ACTOR_NEWS_2][E_ID], "INT_OFFICE", "OFF_SIT_BORED_LOOP", 4.0, 1, 0, 0, 0, 0);

	// Fishing Actor
	gActorData[ACTOR_FISHING][E_ID] = CreateActor(random(2) + 14, 391.0717, -2088.5645, 7.8359, 179.8365);// Pier
	ApplyActorAnimation(gActorData[ACTOR_FISHING][E_ID], "SAMP", "FishingIdle", 4.0, 1, 0, 0, 0, 0);

	// Boxer Actor
	gActorData[ACTOR_BOXER][E_ID] = CreateActor(random(2) + 80, 767.7533, 13.9446, 1000.7003, 295.5587);// Training
	ApplyActorAnimation(gActorData[ACTOR_BOXER][E_ID], "FIGHT_B", "FIGHTB_IDLE", 4.0, 1, 0, 0, 0, 0);
	return 1;
}

//------------------------------------------------------------------------------
