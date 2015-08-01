/*******************************************************************************
* FILENAME :        modules/server/rcon.pwn
*
* DESCRIPTION :
*       Handle rcon commands.
*
* NOTES :
*       This file should only contain rcon commands.
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

hook OnRconCommand(cmd[])
{
    if(!strcmp(cmd, "shutdown", true))
    {
        GameTextForAll("~b~~h~~h~~h~Desligando servidor...", 10000, 3);
        printf("\n\n============================================================\n");
    	printf("Shutting down %s %s.%s%s...\n", SCRIPT_VERSION_NAME, SCRIPT_VERSION_MAJOR, SCRIPT_VERSION_MINOR, SCRIPT_VERSION_PATCH);
        printf("Saving vehicles...");
        SaveVehicles();
        printf("Saving player accounts...");
        foreach(new i: Player)
        {
            if(IsPlayerLogged(i))
            {
                SavePlayerAccount(i);
                SetPlayerLogged(i, false);
            }
        }
        defer ShutdownServer();
        return 1;
    }
    else if(!strcmp(cmd, "restart", true))
    {
        GameTextForAll("~b~~h~~h~~h~Reiniciando servidor...", 10000, 3);
        printf("\n\n============================================================\n");
    	printf("Restartnig %s %s.%s%s...\n", SCRIPT_VERSION_NAME, SCRIPT_VERSION_MAJOR, SCRIPT_VERSION_MINOR, SCRIPT_VERSION_PATCH);
        printf("Saving vehicles...");
        SaveVehicles();
        printf("Saving player accounts...");
        foreach(new i: Player)
        {
            if(IsPlayerLogged(i))
            {
                SavePlayerAccount(i);
                SetPlayerLogged(i, false);
            }
        }
        defer RestartServer();
        return 1;
    }
    return 0;
}

//------------------------------------------------------------------------------

timer ShutdownServer[10000]()
{
    printf("\n\n%s %s.%s%s exited successfuly.\n", SCRIPT_VERSION_NAME, SCRIPT_VERSION_MAJOR, SCRIPT_VERSION_MINOR, SCRIPT_VERSION_PATCH);
    printf("============================================================\n");
    SendRconCommand("exit");
}
//------------------------------------------------------------------------------

timer RestartServer[10000]()
{
    printf("\n\n%s %s.%s%s restarted successfuly.\n", SCRIPT_VERSION_NAME, SCRIPT_VERSION_MAJOR, SCRIPT_VERSION_MINOR, SCRIPT_VERSION_PATCH);
    printf("============================================================\n");
    SendRconCommand("gmx");
}
