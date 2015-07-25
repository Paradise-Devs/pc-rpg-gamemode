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

// Libraries
#include <YSI\y_iterate>
#include <YSI\y_hooks>
#include <YSI\y_timers>
#include <YSI\y_commands>
#include <streamer>
#include <sscanf2>
#include <a_mysql>

//------------------------------------------------------------------------------

hook OnGameModeInit()
{
	// Gamemode start message
	printf("\n\n============================================================\n");
	printf("Initializing %s %s.%s%s...\n", SCRIPT_VERSION_MAJOR, SCRIPT_VERSION_MINOR, SCRIPT_VERSION_PATCH);
}

//------------------------------------------------------------------------------

// Modules

//------------------------------------------------------------------------------

main()
{
	printf("\n\n%s %s.%s%s initialiazed.\n");
	printf("============================================================\n");
}
