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
*/

// Required to be at the top
#include <a_samp>

//------------------------------------------------------------------------------

// Script versioning
#define SCRIPT_VERSION_MAJOR	"0"
#define SCRIPT_VERSION_MINOR	"1"
#define SCRIPT_VERSION_PATCH	".9"
#define SCRIPT_VERSION_NAME		"PC:RPG"

//------------------------------------------------------------------------------

#define MAX_PLAYER_PASSWORD		32
#define MAX_BUILDINGS			32
#define MAX_PICKUP_RANGE		40.0
#define MAX_TEXT3D_RANGE		20.0
#define MAX_MAPICON_RANGE		150.0

#define HOSPITAL_TIME			180	// Seconds
#define HOSPITAL_PRICE			500

#define MAX_FACTIONS			32

#define INTERVAL_BETWEEN_SERVER_MESSAGES	900000 // ms

//------------------------------------------------------------------------------

#define COLOR_ERROR				0xf14545ff
#define COLOR_SUCCESS			0x88aa62FF
#define COLOR_INFO				0xA9C4E4FF
#define COLOR_ACTION			0xDA70D6FF
#define COLOR_WHITE				0xFFFFFFFF
#define COLOR_YELLOW			0xFFFF00FF
#define COLOR_SPECIAL			0xa5f413ff

#define COLOR_RANK_DEVELOPER	0x35a700ff
#define COLOR_RANK_ADMIN		0x00AEFFFF
#define COLOR_RANK_SUPERVISOR	0x009CE5FF
#define COLOR_RANK_MODERATOR	0x008BCCFF
#define COLOR_RANK_MODERATOR	0x008BCCFF
#define COLOR_RANK_BETATESER	0x992A2AFF
#define COLOR_RANK_DESIGNER		0xe48200ff
#define COLOR_RANK_BACKUP		0xCE8500FF

//------------------------------------------------------------------------------

// Libraries
#include <streamer>
#include <sscanf2>
#include <a_mysql>
#include <YSI\y_iterate>
#include <YSI\y_hooks>
#include <YSI\y_timers>
#include <YSI\y_commands>
#include <YSI\y_dialog>
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

/* Defs */
#include "../modules/def/checkpoint.pwn"
#include "../modules/def/achievement.pwn"
#include "../modules/def/ranks.pwn"
#include "../modules/def/buttons.pwn"

/* Data */
#include "../modules/data/connection.pwn"
#include "../modules/data/building.pwn"
#include "../modules/data/vehicle.pwn"
#include "../modules/data/faction.pwn"
#include "../modules/data/player.pwn"

/* Vehicle */
#include "../modules/vehicle/control.pwn"
#include "../modules/vehicle/reserve.pwn"

/* Game */
#include "../modules/game/mapicons.pwn"
#include "../modules/game/automsg.pwn"
#include "../modules/game/pause.pwn"

/* Gameplay */
#include "../modules/gameplay/8track.pwn"
#include "../modules/gameplay/motocross.pwn"
#include "../modules/gameplay/handshake.pwn"
#include "../modules/gameplay/blowjob.pwn"
#include "../modules/gameplay/hospital.pwn"
#include "../modules/gameplay/lottery.pwn"
#include "../modules/gameplay/tutorial.pwn"

/* Player */
#include "../modules/player/achievement.pwn"
#include "../modules/player/message.pwn"
#include "../modules/player/chat.pwn"
#include "../modules/player/commands.pwn"
#include "../modules/player/deadbody.pwn"

/* Admin */
#include "../modules/admin/commands.pwn"
#include "../modules/admin/funcs.pwn"

/* Objects */
#include "../modules/objects/hospital.pwn"

//------------------------------------------------------------------------------

main()
{
	printf("\n\n%s %s.%s%s initialiazed.\n", SCRIPT_VERSION_NAME, SCRIPT_VERSION_MAJOR, SCRIPT_VERSION_MINOR, SCRIPT_VERSION_PATCH);
	printf("============================================================\n");
}
