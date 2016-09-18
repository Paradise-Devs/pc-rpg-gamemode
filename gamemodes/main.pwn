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
#include <sscanf2>
#include <streamer>
#include <nex-ac>

//------------------------------------------------------------------------------

// Script versioning
#define SCRIPT_VERSION_MAJOR							"0"
#define SCRIPT_VERSION_MINOR							"2"
#define SCRIPT_VERSION_PATCH							".31"
#define SCRIPT_VERSION_NAME								"PC:RPG"

//------------------------------------------------------------------------------

// Undefining samp's default values
#if defined MAX_PLAYERS
	#undef MAX_PLAYERS
#endif
#define MAX_PLAYERS	101

//------------------------------------------------------------------------------

#define MAX_PLAYER_PASSWORD								65
#define MAX_BUILDINGS									32
#define MAX_PICKUP_RANGE								40.0
#define MAX_TEXT3D_RANGE								20.0
#define MAX_MAPICON_RANGE								150.0

// Numbers of vehicles hardcoded
#define PRELOADED_VEHICLES								1

#define PICKUP_DELAY									2 // Seconds

#define INVALID_APARTMENT_ID							-1
#define INVALID_HOUSE_ID								-1
#define INVALID_BUSINESS_ID								-1

#define HOSPITAL_TIME									90	// Seconds

#define HOSPITAL_PRICE									500
#define FUEL_PRICE										1 // * 100 / 0.2%

#define MAX_FACTIONS									32

#define MAX_BUSINESS									32
#define MAX_BUSINESS_NAME								64

#define MAX_HOUSES										64
#define MAX_HOUSE_NAME									64
#define MAX_HOUSE_MAPICON_RANGE							25.0

#define INTERVAL_BETWEEN_SERVER_MESSAGES				900000 // ms

#define LAST_POSITION									0
#define HOUSE_POSITION									1

//------------------------------------------------------------------------------

#define COLOR_WARNING									0xf14545ff
#define COLOR_ERROR										0xf14545ff
#define COLOR_SUCCESS									0x88aa62FF
#define COLOR_INFO										0xA9C4E4FF
#define COLOR_ACTION									0xDA70D6FF
#define COLOR_WHITE										0xFFFFFFFF
#define COLOR_YELLOW									0xFFFF00FF
#define COLOR_TITLE										0xa5f413ff
#define COLOR_SPECIAL									0xa5f413ff
#define COLOR_ADMIN_ACTION								0x7dcfb6ff
#define COLOR_SUB_TITLE									0xe6e6e6ff
#define COLOR_SERVER									0xa5f413ff
#define COLOR_WALKIE_TALKIE								0x4FBBE0FF
#define COLOR_SERVER_ANN								0xf26363ff

#define COLOR_RANK_DEVELOPER							0x35a700ff
#define COLOR_RANK_ADMIN								0x00AEFFFF
#define COLOR_RANK_SUPERVISOR							0x009CE5FF
#define COLOR_RANK_MODERATOR							0x008BCCFF
#define COLOR_RANK_BETATESER							0x992A2AFF
#define COLOR_RANK_DESIGNER								0xe48200ff
#define COLOR_RANK_PARADISER							0xCE8500FF

//------------------------------------------------------------------------------

// Libraries
#include <a_mysql>
#include <YSI\y_hooks>
#include <YSI\y_timers>
#include <YSI\y_iterate>
#include <YSI\y_commands>
#include <YSI\y_va>
#include <progress2>
#include <fnumb>
#include <util>
#include <vcolor>
#include <zones>
#include <mSelection>
#include <radars>
#include <vending>
#include <cuffs>
#include <sscanffix>
#include <log>

//------------------------------------------------------------------------------

// ID of the model list for text draw of skins
new maleskinlist = mS_INVALID_LISTID;
new femaleskinlist = mS_INVALID_LISTID;
new g_RegisteredPlayers;

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

	// Textdraw Model
	printf("Loading textdraw model selection...");
	maleskinlist = LoadModelSelectionMenu("civillian_male_skins.txt");
	femaleskinlist = LoadModelSelectionMenu("civillian_female_skins.txt");

	// Objects
	printf("Creating objects...");
	CreateDynamicObject(3089, 2160.5, 1603.3000488281, 1000.299987793, 0, 0, 270, -1, 1, -1, 25); // Phone Network inside door
	CreateDynamicObject(1506, 365.80, 196.24, 1007.37,   0.00, 0.00, 0.00, 26);//CNN News inside door

	// Door at SF-PD for advertising business
	CreateDynamicObject(1535, 220.32, 115.85, 1002.22,   0.00, 0.00, 0.00);
	CreateDynamicObject(1535, 223.34, 115.88, 1002.22,   0.00, 0.00, 180.00);

	// Ground at The Welcome Pump
	CreateDynamicObject(8664, 682.94452, -467.08691, -26.69240, 0.00000, 0.00000, 0.00000, -1, 1);
	CreateDynamicObject(1501, 680.72339, -450.72391, -26.51500, 0.00000, 0.00000, 0.00000, -1, 1);
	new ground = CreateDynamicObject(19377, 681.45459, -450.60699, -26.61890, 0.00000, 0.00000, 90.00000, -1, 1);
	SetDynamicObjectMaterial(ground, 0, 14655, "ab_trukstpa", "bbar_wall1");
	return 1;
}

//------------------------------------------------------------------------------

// Iterators
new	Iterator:House<MAX_HOUSES>;
new	Iterator:Business<MAX_HOUSES>;

//------------------------------------------------------------------------------

// Modules

/* Defs */
#include "../modules/def/checkpoint.pwn"
#include "../modules/def/achievement.pwn"
#include "../modules/def/ranks.pwn"
#include "../modules/def/buttons.pwn"
#include "../modules/def/job.pwn"
#include "../modules/def/dialogs.pwn"
#include "../modules/def/ftime.pwn"
#include "../modules/def/messages.pwn"
#include "../modules/def/missions.pwn"
#include "../modules/def/statscol.pwn"
#include "../modules/def/licenses.pwn"

/* Data */
#include "../modules/data/connection.pwn"
#include "../modules/data/building.pwn"
#include "../modules/data/vehicle.pwn"
#include "../modules/data/faction.pwn"
#include "../modules/data/player.pwn"

/* Properties */
#include "../modules/properties/vehicle.pwn"
#include "../modules/properties/apartment.pwn"
#include "../modules/properties/house.pwn"
#include "../modules/properties/business.pwn"

/* Vehicle */
#include "../modules/vehicle/control.pwn"
#include "../modules/vehicle/reserve.pwn"
#include "../modules/vehicle/dschool.pwn"
#include "../modules/vehicle/status.pwn"
#include "../modules/vehicle/fueling.pwn"

/* Game */
#include "../modules/game/mapicons.pwn"
#include "../modules/game/automsg.pwn"
#include "../modules/game/pause.pwn"
#include "../modules/game/clock.pwn"
#include "../modules/game/preloadanim.pwn"
#include "../modules/game/vending.pwn"

/* Gameplay */
#include "../modules/gameplay/8track.pwn"
#include "../modules/gameplay/motocross.pwn"
#include "../modules/gameplay/handshake.pwn"
#include "../modules/gameplay/blowjob.pwn"
#include "../modules/gameplay/kiss.pwn"
#include "../modules/gameplay/hospital.pwn"
#include "../modules/gameplay/lottery.pwn"
#include "../modules/gameplay/tutorial.pwn"
#include "../modules/gameplay/paintball.pwn"
#include "../modules/gameplay/weather.pwn"
#include "../modules/gameplay/phone.pwn"
#include "../modules/gameplay/shtrange.pwn"
#include "../modules/gameplay/gps.pwn"
#include "../modules/gameplay/radars.pwn"
#include "../modules/gameplay/fighting.pwn"
#include "../modules/gameplay/bank.pwn"
#include "../modules/gameplay/boxing.pwn"
#include "../modules/gameplay/gym.pwn"
#include "../modules/gameplay/prision.pwn"
#include "../modules/gameplay/rentbike.pwn"
#include "../modules/gameplay/anims.pwn"

/* Player */
#include "../modules/player/achievement.pwn"
#include "../modules/player/chat.pwn"
#include "../modules/player/commands.pwn"
#include "../modules/player/deadbody.pwn"
#include "../modules/player/needs.pwn"
#include "../modules/player/pets.pwn"

/* Server */
#include "../modules/server/rcon.pwn"
#include "../modules/server/anticheat.pwn"

/* Admin */
#include "../modules/admin/funcs.pwn"
#include "../modules/admin/commands.pwn"

/* Factions */
#include "../modules/faction/general.pwn"
#include "../modules/faction/cnn.pwn"
#include "../modules/faction/lspd.pwn"

/* Visual */
#include "../modules/visual/speedo.pwn"
#include "../modules/visual/subtitles.pwn"
#include "../modules/visual/needs.pwn"
#include "../modules/visual/stats.pwn"
#include "../modules/visual/gps.pwn"
#include "../modules/visual/logo.pwn"
#include "../modules/visual/login.pwn"
#include "../modules/visual/businfo.pwn"
#include "../modules/visual/boxing.pwn"
#include "../modules/visual/licenses.pwn"
#include "../modules/visual/xpbar.pwn"

/* NPCs */
#include "../modules/npcs/actors.pwn"
#include "../modules/npcs/npcs.pwn"

/* Cutscenes */
#include "../modules/cutscenes/cityhall.pwn"

/* Jobs */
#include "../modules/job/pilot.pwn"
#include "../modules/job/trucker.pwn"
#include "../modules/job/lumberjack.pwn"
#include "../modules/job/navigator.pwn"
#include "../modules/job/paramedic.pwn"
#include "../modules/job/garbage.pwn"
#include "../modules/job/hotdog.pwn"
#include "../modules/job/icecream.pwn"
#include "../modules/job/fisher.pwn"
#include "../modules/job/taxi.pwn"
#include "../modules/job/technical.pwn"
#include "../modules/job/pizzaboy.pwn"
#include "../modules/job/busdriver.pwn"
#include "../modules/job/commands.pwn"

/* Missions */
#include "../modules/missions/gta.pwn"
#include "../modules/missions/colonel.pwn"

/* Objects */
#include "../modules/objects/hospital.pwn"
#include "../modules/objects/airport.pwn"
#include "../modules/objects/player.pwn" // a.k.a attachments
#include "../modules/objects/lspd.pwn"
#include "../modules/objects/bank.pwn"
#include "../modules/objects/petshop.pwn"

/* Core */
#include "../modules/core/timers.pwn"

//------------------------------------------------------------------------------

main()
{
	printf("\n\n%s %s.%s%s initialiazed.\n", SCRIPT_VERSION_NAME, SCRIPT_VERSION_MAJOR, SCRIPT_VERSION_MINOR, SCRIPT_VERSION_PATCH);
	printf("============================================================\n");
}
