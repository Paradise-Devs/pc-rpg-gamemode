/*******************************************************************************
* FILENAME :        main.pwn
*
* DESCRIPTION :
*       Linkage of all modules and includes, definiton of values.
*
* NOTES :
*       This file is not intended to handle player's functions or anything.
*       This file must only have links and constants.
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
* AUTHOR :    Larceny           START DATE :    25 Jul 15
*
*/

// Required to be at the top
#include <a_samp>

//------------------------------------------------------------------------------

// Script versioning
#define SCRIPT_VERSION_MAJOR	"2"
#define SCRIPT_VERSION_MINOR	"0"
#define SCRIPT_VERSION_PATCH	""
#define SCRIPT_VERSION_NAME		"PC:RPG"

//------------------------------------------------------------------------------

#define MAX_PLAYER_PASSWORD		32
#define MAX_BUILDINGS			32
#define MAX_PICKUP_RANGE		40.0
#define MAX_TEXT3D_RANGE		20.0

//------------------------------------------------------------------------------

#define COLOR_ERROR				0xf14545ff
#define COLOR_SUCCESS			0x88aa62FF
#define COLOR_INFO				0xA9C4E4FF
#define COLOR_ACTION			0xDA70D6FF
#define COLOR_WHITE				0xFFFFFFFF
#define COLOR_YELLOW			0xFFFF00FF

//------------------------------------------------------------------------------

// Libraries
#include <YSI\y_iterate>
#include <YSI\y_hooks>
#include <YSI\y_timers>
#include <YSI\y_commands>
#include <YSI\y_dialog>
#include <streamer>
#include <sscanf2>
#include <a_mysql>
#include <util>

//------------------------------------------------------------------------------

hook OnGameModeInit()
{
	// Gamemode start message
	printf("\n\n============================================================\n");
	printf("Initializing %s %s.%s%s...\n", SCRIPT_VERSION_NAME, SCRIPT_VERSION_MAJOR, SCRIPT_VERSION_MINOR, SCRIPT_VERSION_PATCH);

	// Set the gamemode name to the current version
	new rcon_command[32];
	format(rcon_command, sizeof(rcon_command), "gamemodetext %s %s.%s%s", SCRIPT_VERSION_NAME, SCRIPT_VERSION_MAJOR, SCRIPT_VERSION_MINOR, SCRIPT_VERSION_PATCH);
	SendRconCommand(rcon_command);

	// Gamemode settings
	ShowNameTags(1);
	UsePlayerPedAnims();
	DisableInteriorEnterExits();
	SetNameTagDrawDistance(40.0);
	EnableStuntBonusForAll(false);
	ManualVehicleEngineAndLights();
	ShowPlayerMarkers(PLAYER_MARKERS_MODE_OFF);
	return 1;
}

//------------------------------------------------------------------------------

// Modules

/* Data */
#include "../modules/data/connection.pwn"
#include "../modules/data/building.pwn"
#include "../modules/data/vehicle.pwn"
#include "../modules/data/player.pwn"

/* Vehicle */
#include "../modules/vehicle/control.pwn"

/* Gameplay */
#include "../modules/gameplay/8track.pwn"
#include "../modules/gameplay/motocross.pwn"

/* Player */
#include "../modules/player/message.pwn"
#include "../modules/player/admin.pwn"
#include "../modules/player/chat.pwn"
#include "../modules/player/commands.pwn"
#include "../modules/player/deadbody.pwn"

//------------------------------------------------------------------------------

main()
{
	printf("\n\n%s %s.%s%s initialiazed.\n", SCRIPT_VERSION_NAME, SCRIPT_VERSION_MAJOR, SCRIPT_VERSION_MINOR, SCRIPT_VERSION_PATCH);
	printf("============================================================\n");
}
