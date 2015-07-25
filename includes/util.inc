/*******************************************************************************
* FILENAME :        util.inc
*
* DESCRIPTION :
*       Useful functions and macros for SA-MP.
*
* NOTES :
*       -
*
*       Copyright Larceny 2015.  All rights reserved.
*
* AUTHOR :    Larceny           START DATE :    25 Jul 15
*
*/

/*
    Checks if a string is null
*/
#define isnull(%1) ((!(%1[0])) || (((%1[0]) == '\1') && (!(%1[1]))))

//------------------------------------------------------------------------------

/*
    Sounds macro
*/
#define PlayConfirmSound(%0)    PlayerPlaySound(%0,1058,0.0,0.0,0.0)
#define PlaySelectSound(%0)     PlayerPlaySound(%0,1083,0.0,0.0,0.0)
#define PlayCancelSound(%0)     PlayerPlaySound(%0,1084,0.0,0.0,0.0)
#define PlayErrorSound(%0)      PlayerPlaySound(%0,1085,0.0,0.0,0.0)

//------------------------------------------------------------------------------

/*
    Clear player's chat
*/
stock ClearPlayerScreen(playerid, lines = 100)
{
    for (new i = 0; i < lines; i++)
        SendClientMessage(playerid, -1, " ");
}

//------------------------------------------------------------------------------

/*
    Gets the player first name(before the _)
*/
stock GetPlayerFirstName(playerid)
{
    new playerName[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playerName, sizeof(playerName));
    for(new i = 0; i < MAX_PLAYER_NAME; i++)
        if(playerName[i] == '_')
            playerName[i] = '\0';
    if(isnull(playerName))
        playerName = "Desconhecido";
    return playerName;
}

//------------------------------------------------------------------------------
