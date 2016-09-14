/*******************************************************************************
* FILENAME :        modules/def/checkpoint.pwn
*
* DESCRIPTION :
*       Global constants of checkpoints.
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*/

//------------------------------------------------------------------------------

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

enum CHECKPOINT
{
	CHECKPOINT_NONE,
	CHECKPOINT_PILOT,
	CHECKPOINT_TRUCKER,
	CHECKPOINT_LUMBER,
	CHECKPOINT_NAVIGATOR,
	CHECKPOINT_PARAMEDIC,
	CHECKPOINT_GARBAGE,
	CHECKPOINT_FISHER,
	CHECKPOINT_TECHNICAL,
	CHECKPOINT_PIZZA,

	CHECKPOINT_DRIVING_SCHOOL,
	CHECKPOINT_BIKE_SCHOOL,

	CHECKPOINT_GTA,
	CHECKPOINT_COLONEL,

	CHECKPOINT_GPS,
	CHECKPOINT_CITYHALL
}
static CHECKPOINT:gPlayerCurrentCP[MAX_PLAYERS];

//------------------------------------------------------------------------------

hook OnPlayerDisconnect(playerid, reason)
{
	gPlayerCurrentCP[playerid] = CHECKPOINT_NONE;
	return 1;
}

//------------------------------------------------------------------------------

CHECKPOINT:GetPlayerCPID(playerid)
	return gPlayerCurrentCP[playerid];

//------------------------------------------------------------------------------

SetPlayerCPID(playerid, CHECKPOINT:id)
	gPlayerCurrentCP[playerid] = id;

//------------------------------------------------------------------------------
