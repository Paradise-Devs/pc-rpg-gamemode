/*******************************************************************************
* FILENAME :        modules/def/achievement.pwn
*
* DESCRIPTION :
*       Global constants of achievements.
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*/

//------------------------------------------------------------------------------

// Maximum 32 values per variable
enum ACHIEVEMENT:(<<= 1)
{
	ACHIEVEMENT_BLOWJOB = 1,	// Given when a player gives a blowjob
	ACHIEVEMENT_LOTTERY,		// Given when a player wins a lottery jackpot
	ACHIEVEMENT_HOSPITAL,		// Given when a player goes to hospital
	ACHIEVEMENT_SECQUEST,		// Given when a player completes a secundary quest
	ACHIEVEMENT_SHOOTINGRANGE	// Given when a player completes ammunation without missing a single shot
}
