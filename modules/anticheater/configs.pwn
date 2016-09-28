/*******************************************************************************
* FILENAME :        modules/anticheater/configs.pwn
*
* DESCRIPTION :
*       Anti-cheater configurations file
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2016.  All rights reserved.
*
*/
//functions
forward OnPlayerCheat(playerid, cheatid, const format[], {Float,_}:...);

//colors
#define AC_TITLE_COLOR 0x0f84d9

//limits
#define             MAX_AUTOBULLET_INFRACTIONS          3
#define             AUTOBULLET_RESET_DELAY              30

//tags
enum
{
    CHEAT_NONE = 0,
    CHEAT_NPCSPOOF = 1,
    CHEAT_PLAYERSPOOF = 2,
    CHEAT_AUTOBULLET = 3
};

enum PCheatData
{
    bool:PlayerSpoof_IsConnected,
    PlayerSpoof_PlayerName[24],
    AutoBullet_Infractions,
    AutoBullet_LastInfractionTime
};
new PlayerCheatInfo[MAX_PLAYERS][PCheatData];
