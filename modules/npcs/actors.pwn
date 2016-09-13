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
	ACTOR_BOXER,
	// Business actors
	ACTOR_RESTAURANT,
	ACTOR_AMMU,
	ACTOR_PIZZA,
	ACTOR_DONUTS,
	ACTOR_ALHAMBRA_1,
	ACTOR_ALHAMBRA_2,
	ACTOR_ALHAMBRA_3,
	ACTOR_BURGER_1,
	ACTOR_BURGER_2,
	ACTOR_BURGER_3,
	ACTOR_PROLAPS_1,
	ACTOR_PROLAPS_2,
	ACTOR_VICTIM,
	ACTOR_ZIP,
	ACTOR_BINCO,
	ACTOR_SUBURBAN,
	ACTOR_CLUCKIN_1,
	ACTOR_CLUCKIN_2,
	ACTOR_GREENBOTTLE,
	ACTOR_WELCOME_PUMP,
	ACTOR_247_1,
	ACTOR_247_2,
	ACTOR_247_3,
	ACTOR_247_4,
	ACTOR_247_5
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
	// Business actors
	else if(gActorData[ACTOR_RESTAURANT][E_ID] == actorid)
		ApplyActorAnimation(actorid, "BAR", "BARSERVE_LOOP", 4.0, 1, 0, 0, 0, 0);
	else if(gActorData[ACTOR_AMMU][E_ID] == actorid)
		ApplyActorAnimation(actorid, "DEALER", "DEALER_IDLE_03", 4.0, 1, 0, 0, 0, 0);
	else if(gActorData[ACTOR_PIZZA][E_ID] == actorid)
		ApplyActorAnimation(actorid, "PLAYIDLES", "STRLEG", 4.0, 1, 0, 0, 0, 0);
	else if(gActorData[ACTOR_DONUTS][E_ID] == actorid)
		ApplyActorAnimation(actorid, "PLAYIDLES", "STRLEG", 4.0, 1, 0, 0, 0, 0);
	else if(gActorData[ACTOR_ALHAMBRA_1][E_ID] == actorid)
		ApplyActorAnimation(actorid, "BAR", "BARMAN_IDLE", 4.0, 1, 0, 0, 0, 0);
	else if(gActorData[ACTOR_ALHAMBRA_2][E_ID] == actorid)
		ApplyActorAnimation(actorid, "COP_AMBIENT", "COPLOOK_LOOP", 4.1, 1, 0, 0, 1, 0);
	else if(gActorData[ACTOR_ALHAMBRA_3][E_ID] == actorid)
		ApplyActorAnimation(actorid, "COP_AMBIENT", "COPLOOK_LOOP", 4.1, 1, 0, 0, 1, 0);
	else if(gActorData[ACTOR_BURGER_1][E_ID] == actorid)
		ApplyActorAnimation(actorid, "FOOD", "SHP_TRAY_POSE", 4.0, 1, 0, 0, 0, 0);
	else if(gActorData[ACTOR_BURGER_2][E_ID] == actorid)
		ApplyActorAnimation(actorid, "FOOD", "SHP_TRAY_POSE", 4.0, 1, 0, 0, 0, 0);
	else if(gActorData[ACTOR_BURGER_3][E_ID] == actorid)
		ApplyActorAnimation(actorid, "PAULNMAC", "PISS_LOOP", 4.0, 1, 0, 0, 0, 0);
	else if(gActorData[ACTOR_PROLAPS_1][E_ID] == actorid)
		ApplyActorAnimation(actorid, "FOOD", "SHP_TRAY_POSE", 4.0, 1, 0, 0, 0, 0);
	else if(gActorData[ACTOR_PROLAPS_2][E_ID] == actorid)
		ApplyActorAnimation(actorid, "INT_SHOP", "SHOP_LOOKA", 4.0, 1, 0, 0, 0, 0);
	else if(gActorData[ACTOR_VICTIM][E_ID] == actorid)
		ApplyActorAnimation(actorid, "FOOD", "SHP_TRAY_POSE", 4.0, 1, 0, 0, 0, 0);
	else if(gActorData[ACTOR_ZIP][E_ID] == actorid)
		ApplyActorAnimation(actorid, "FOOD", "SHP_TRAY_POSE", 4.0, 1, 0, 0, 0, 0);
	else if(gActorData[ACTOR_BINCO][E_ID] == actorid)
		ApplyActorAnimation(actorid, "FOOD", "SHP_TRAY_POSE", 4.0, 1, 0, 0, 0, 0);
	else if(gActorData[ACTOR_SUBURBAN][E_ID] == actorid)
		ApplyActorAnimation(actorid, "FOOD", "SHP_TRAY_POSE", 4.0, 1, 0, 0, 0, 0);
	else if(gActorData[ACTOR_CLUCKIN_1][E_ID] == actorid)
		ApplyActorAnimation(actorid, "FOOD", "SHP_TRAY_POSE", 4.0, 1, 0, 0, 0, 0);
	else if(gActorData[ACTOR_CLUCKIN_2][E_ID] == actorid)
		ApplyActorAnimation(actorid, "FOOD", "SHP_TRAY_POSE", 4.0, 1, 0, 0, 0, 0);
	else if(gActorData[ACTOR_GREENBOTTLE][E_ID] == actorid)
		ApplyActorAnimation(actorid, "BAR", "BARMAN_IDLE", 4.0, 1, 0, 0, 0, 0);
	else if(gActorData[ACTOR_247_1][E_ID] == actorid)
		ApplyActorAnimation(actorid, "SHOP", "SHP_SERVE_IDLE", 4.0, 1, 0, 0, 0, 0);
	else if(gActorData[ACTOR_247_2][E_ID] == actorid)
		ApplyActorAnimation(actorid, "SHOP", "SHP_SERVE_IDLE", 4.0, 1, 0, 0, 0, 0);
	else if(gActorData[ACTOR_247_3][E_ID] == actorid)
		ApplyActorAnimation(actorid, "SHOP", "SHP_SERVE_IDLE", 4.0, 1, 0, 0, 0, 0);
	else if(gActorData[ACTOR_247_4][E_ID] == actorid)
		ApplyActorAnimation(actorid, "SHOP", "SHP_SERVE_IDLE", 4.0, 1, 0, 0, 0, 0);
	else if(gActorData[ACTOR_247_5][E_ID] == actorid)
		ApplyActorAnimation(actorid, "SHOP", "SHP_SERVE_IDLE", 4.0, 1, 0, 0, 0, 0);

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
	SetActorVirtualWorld(gActorData[ACTOR_HOSPITAL][E_ID], 1);

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

	/* Business actor */

	// Restaurant
	gActorData[ACTOR_RESTAURANT][E_ID] = CreateActor(11, 449.93, -82.02, 999.55, 178.76);// Attendant
	ApplyActorAnimation(gActorData[ACTOR_RESTAURANT][E_ID], "BAR", "BARSERVE_LOOP", 4.0, 1, 0, 0, 0, 0);
	SetActorVirtualWorld(gActorData[ACTOR_RESTAURANT][E_ID], 3);
	SetActorInvulnerable(gActorData[ACTOR_RESTAURANT][E_ID], false);

	// Ammunation
	gActorData[ACTOR_AMMU][E_ID] = CreateActor(179, 308.11, -143.23, 999.60, 359.15);// Attendant
	ApplyActorAnimation(gActorData[ACTOR_AMMU][E_ID], "DEALER", "DEALER_IDLE_03", 4.0, 1, 0, 0, 0, 0);
	SetActorVirtualWorld(gActorData[ACTOR_AMMU][E_ID], 2);
	SetActorInvulnerable(gActorData[ACTOR_AMMU][E_ID], false);

	// Pizza stack
	gActorData[ACTOR_PIZZA][E_ID] = CreateActor(155, 372.62, -117.27, 1001.49, 180.67);// Attendant
	ApplyActorAnimation(gActorData[ACTOR_PIZZA][E_ID], "PLAYIDLES", "STRLEG", 4.0, 1, 0, 0, 0, 0);
	SetActorVirtualWorld(gActorData[ACTOR_PIZZA][E_ID], 10);
	SetActorInvulnerable(gActorData[ACTOR_PIZZA][E_ID], false);

	// Donuts
	gActorData[ACTOR_DONUTS][E_ID] = CreateActor(209, 380.77, -189.11, 1000.63, 178.37);// Attendant
	ApplyActorAnimation(gActorData[ACTOR_DONUTS][E_ID], "PLAYIDLES", "STRLEG", 4.0, 1, 0, 0, 0, 0);
	SetActorVirtualWorld(gActorData[ACTOR_DONUTS][E_ID], 14);
	SetActorInvulnerable(gActorData[ACTOR_DONUTS][E_ID], false);

	// Alhambra Actor
	gActorData[ACTOR_ALHAMBRA_1][E_ID] = CreateActor(194, 501.75, -20.56, 1000.67, 86.25);// Attendant
	ApplyActorAnimation(gActorData[ACTOR_ALHAMBRA_1][E_ID], "BAR", "BARMAN_IDLE", 4.0, 1, 0, 0, 0, 0);
	SetActorVirtualWorld(gActorData[ACTOR_ALHAMBRA_1][E_ID], 9);
	SetActorInvulnerable(gActorData[ACTOR_ALHAMBRA_1][E_ID], false);

	/*gActorData[ACTOR_ALHAMBRA_2][E_ID] = CreateActor(164, 1833.1362, -1675.5209, 13.4859, 89.1208);// Body guard (White)
	ApplyActorAnimation(gActorData[ACTOR_ALHAMBRA_2][E_ID], "COP_AMBIENT", "COPLOOK_LOOP", 4.1, 1, 0, 0, 1, 0);

	gActorData[ACTOR_ALHAMBRA_3][E_ID] = CreateActor(163, 1833.3876, -1688.9264, 13.4754, 87.8048);// Body guard (Black)
	ApplyActorAnimation(gActorData[ACTOR_ALHAMBRA_3][E_ID], "COP_AMBIENT", "COPLOOK_LOOP", 4.1, 1, 0, 0, 1, 0);*/

	// Burger
	gActorData[ACTOR_BURGER_1][E_ID] = CreateActor(205, 376.5526, -65.7010, 1001.5078, 176.8552);// Burger woman
	ApplyActorAnimation(gActorData[ACTOR_BURGER_1][E_ID], "FOOD", "SHP_TRAY_POSE", 4.0, 1, 0, 0, 0, 0);
	SetActorVirtualWorld(gActorData[ACTOR_BURGER_1][E_ID], 16);
	SetActorInvulnerable(gActorData[ACTOR_BURGER_1][E_ID], false);

	gActorData[ACTOR_BURGER_2][E_ID] = CreateActor(205, 376.5526, -65.7010, 1001.5078, 176.8552);// Burger woman
	ApplyActorAnimation(gActorData[ACTOR_BURGER_2][E_ID], "FOOD", "SHP_TRAY_POSE", 4.0, 1, 0, 0, 0, 0);
	SetActorVirtualWorld(gActorData[ACTOR_BURGER_2][E_ID], 7);
	SetActorInvulnerable(gActorData[ACTOR_BURGER_2][E_ID], false);

	gActorData[ACTOR_BURGER_3][E_ID] = CreateActor((random(4) + 159), 371.0302, -57.9299, 1001.5209, 4.4001);// Pissing in w.C
	ApplyActorAnimation(gActorData[ACTOR_BURGER_3][E_ID], "PAULNMAC", "PISS_LOOP", 4.0, 1, 0, 0, 0, 0);
	SetActorVirtualWorld(gActorData[ACTOR_BURGER_3][E_ID], 6);
	SetActorInvulnerable(gActorData[ACTOR_BURGER_3][E_ID], false);

	// Pro laps
	gActorData[ACTOR_PROLAPS_1][E_ID] = CreateActor(217, 207.0583, -127.7238, 1003.5078, 180.5150);// Seller
	ApplyActorAnimation(gActorData[ACTOR_PROLAPS_1][E_ID], "FOOD", "SHP_TRAY_POSE", 4.0, 1, 0, 0, 0, 0);
	SetActorVirtualWorld(gActorData[ACTOR_PROLAPS_1][E_ID], 17);
	SetActorInvulnerable(gActorData[ACTOR_PROLAPS_1][E_ID], false);

	gActorData[ACTOR_PROLAPS_2][E_ID] = CreateActor(22, 204.1797, -134.7139, 1002.8672, 15.0735);// Client
	ApplyActorAnimation(gActorData[ACTOR_PROLAPS_2][E_ID], "INT_SHOP", "SHOP_LOOKA", 4.0, 1, 0, 0, 0, 0);
	SetActorVirtualWorld(gActorData[ACTOR_PROLAPS_2][E_ID], 17);
	SetActorInvulnerable(gActorData[ACTOR_PROLAPS_2][E_ID], false);

	// Victim
	gActorData[ACTOR_VICTIM][E_ID] = CreateActor(211, 204.8538, -8.0557, 1001.2109, 271.5751);// Seller
	ApplyActorAnimation(gActorData[ACTOR_VICTIM][E_ID], "FOOD", "SHP_TRAY_POSE", 4.0, 1, 0, 0, 0, 0);
	SetActorVirtualWorld(gActorData[ACTOR_VICTIM][E_ID], 21);
	SetActorInvulnerable(gActorData[ACTOR_VICTIM][E_ID], false);

	// Zip
	gActorData[ACTOR_ZIP][E_ID] = CreateActor(223, 161.3302, -81.1898, 1001.8047, 182.0250);// Seller
	ApplyActorAnimation(gActorData[ACTOR_ZIP][E_ID], "FOOD", "SHP_TRAY_POSE", 4.0, 1, 0, 0, 0, 0);
	SetActorVirtualWorld(gActorData[ACTOR_ZIP][E_ID], 20);
	SetActorInvulnerable(gActorData[ACTOR_ZIP][E_ID], false);

	// Binco
	gActorData[ACTOR_BINCO][E_ID] = CreateActor(72, 207.6847, -98.7046, 1005.2578, 178.5483);// Seller
	ApplyActorAnimation(gActorData[ACTOR_BINCO][E_ID], "FOOD", "SHP_TRAY_POSE", 4.0, 1, 0, 0, 0, 0);
	SetActorVirtualWorld(gActorData[ACTOR_BINCO][E_ID], 6);
	SetActorInvulnerable(gActorData[ACTOR_BINCO][E_ID], false);

	// SubUrban
	gActorData[ACTOR_SUBURBAN][E_ID] = CreateActor(183, 203.7608, -41.6708, 1001.8047, 178.6716);// Seller
	ApplyActorAnimation(gActorData[ACTOR_SUBURBAN][E_ID], "FOOD", "SHP_TRAY_POSE", 4.0, 1, 0, 0, 0, 0);
	SetActorVirtualWorld(gActorData[ACTOR_SUBURBAN][E_ID], 22);
	SetActorInvulnerable(gActorData[ACTOR_SUBURBAN][E_ID], false);

	// Cluckin Bell
	gActorData[ACTOR_CLUCKIN_1][E_ID] = CreateActor(167, 370.8767, -4.4925, 1001.8589, 176.5984);// Seller
	ApplyActorAnimation(gActorData[ACTOR_CLUCKIN_1][E_ID], "FOOD", "SHP_TRAY_POSE", 4.0, 1, 0, 0, 0, 0);
	SetActorVirtualWorld(gActorData[ACTOR_CLUCKIN_1][E_ID], 15);
	SetActorInvulnerable(gActorData[ACTOR_CLUCKIN_1][E_ID], false);

	gActorData[ACTOR_CLUCKIN_2][E_ID] = CreateActor(167, 370.8767, -4.4925, 1001.8589, 176.5984);// Seller
	ApplyActorAnimation(gActorData[ACTOR_CLUCKIN_2][E_ID], "FOOD", "SHP_TRAY_POSE", 4.0, 1, 0, 0, 0, 0);
	SetActorVirtualWorld(gActorData[ACTOR_CLUCKIN_2][E_ID], 12);
	SetActorInvulnerable(gActorData[ACTOR_CLUCKIN_2][E_ID], false);

	// 10 Green Bottles
	gActorData[ACTOR_GREENBOTTLE][E_ID] = CreateActor(65, 498.4849, -77.5766, 998.7651, 356.6049);// Seller
	ApplyActorAnimation(gActorData[ACTOR_GREENBOTTLE][E_ID], "BAR", "BARMAN_IDLE", 4.0, 1, 0, 0, 0, 0);
	SetActorVirtualWorld(gActorData[ACTOR_GREENBOTTLE][E_ID], 11);
	SetActorInvulnerable(gActorData[ACTOR_GREENBOTTLE][E_ID], false);

	// The Welcome Pump Actor
	gActorData[ACTOR_WELCOME_PUMP][E_ID] = CreateActor(128, 681.4562, -455.4612, -25.6099, 0.3538);// Bartender
	ApplyActorAnimation(gActorData[ACTOR_WELCOME_PUMP][E_ID], "BAR", "BARMAN_IDLE", 4.0, 1, 0, 0, 0, 0);
	SetActorVirtualWorld(gActorData[ACTOR_WELCOME_PUMP][E_ID], 30);
	SetActorInvulnerable(gActorData[ACTOR_WELCOME_PUMP][E_ID], false);

	// 24-7
	gActorData[ACTOR_247_1][E_ID] = CreateActor(60, -23.5164, -57.2337, 1003.5469, 357.9266);// Seller
	ApplyActorAnimation(gActorData[ACTOR_247_1][E_ID], "SHOP", "SHP_SERVE_IDLE", 4.0, 1, 0, 0, 0, 0);
	SetActorVirtualWorld(gActorData[ACTOR_247_1][E_ID], 0);
	SetActorInvulnerable(gActorData[ACTOR_247_1][E_ID], false);

	gActorData[ACTOR_247_2][E_ID] = CreateActor(58, -22.3399, -140.3120, 1003.5469, 359.0399);// Seller
	ApplyActorAnimation(gActorData[ACTOR_247_2][E_ID], "SHOP", "SHP_SERVE_IDLE", 4.0, 1, 0, 0, 0, 0);
	SetActorVirtualWorld(gActorData[ACTOR_247_2][E_ID], 8);
	SetActorInvulnerable(gActorData[ACTOR_247_2][E_ID], false);

	gActorData[ACTOR_247_3][E_ID] = CreateActor(53, -28.3135, -91.6430, 1003.5469, 358.2400);// Seller
	ApplyActorAnimation(gActorData[ACTOR_247_3][E_ID], "SHOP", "SHP_SERVE_IDLE", 4.0, 1, 0, 0, 0, 0);
	SetActorVirtualWorld(gActorData[ACTOR_247_3][E_ID], 24);
	SetActorInvulnerable(gActorData[ACTOR_247_3][E_ID], false);

	gActorData[ACTOR_247_4][E_ID] = CreateActor(38, -30.8284, -30.7034, 1003.5573, 8.1167);// Seller
	ApplyActorAnimation(gActorData[ACTOR_247_4][E_ID], "SHOP", "SHP_SERVE_IDLE", 4.0, 1, 0, 0, 0, 0);
	SetActorVirtualWorld(gActorData[ACTOR_247_4][E_ID], 18);
	SetActorInvulnerable(gActorData[ACTOR_247_4][E_ID], false);

	gActorData[ACTOR_247_5][E_ID] = CreateActor(39, -29.1237, -186.8168, 1003.5469, 358.2968);// Seller
	ApplyActorAnimation(gActorData[ACTOR_247_5][E_ID], "SHOP", "SHP_SERVE_IDLE", 4.0, 1, 0, 0, 0, 0);
	SetActorVirtualWorld(gActorData[ACTOR_247_5][E_ID], 25);
	SetActorInvulnerable(gActorData[ACTOR_247_5][E_ID], false);
	return 1;
}

//------------------------------------------------------------------------------
