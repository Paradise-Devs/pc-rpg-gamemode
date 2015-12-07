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
    	printf("Restarting %s %s.%s%s...\n", SCRIPT_VERSION_NAME, SCRIPT_VERSION_MAJOR, SCRIPT_VERSION_MINOR, SCRIPT_VERSION_PATCH);
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
    else
    {
        new command[16];
     	if(sscanf(cmd, "s[16] ", command))
     		return 1;

        if(!strcmp(command, "pban", true))
        {
            new playerName[MAX_PLAYER_NAME], adminName[MAX_PLAYER_NAME], reason[128];
         	if(sscanf(cmd, "s[16]s["#MAX_PLAYER_NAME"]s["#MAX_PLAYER_NAME"]s[128]", command, playerName, adminName, reason))
                return 1;

            new playerNameIG[MAX_PLAYER_NAME];
            foreach(new i: Player)
            {
                GetPlayerName(i, playerNameIG, MAX_PLAYER_NAME);
                if(!strcmp(playerNameIG, playerName, true))
                {
                    new output[144];
                    format(output, sizeof(output), "* %s foi banido por %s. Motivo: %s", playerName, adminName, reason);
                    SendClientMessageToAll(0xf26363ff, output);
                    Ban(i);
                    return 1;
                }
            }
            return 1;
        }
        else if(!strcmp(command, "pkick", true))
        {
            new playerName[MAX_PLAYER_NAME], adminName[MAX_PLAYER_NAME], reason[128];
         	if(sscanf(cmd, "s[16]s["#MAX_PLAYER_NAME"]s["#MAX_PLAYER_NAME"]s[128]", command, playerName, adminName, reason))
                return 1;

            new playerNameIG[MAX_PLAYER_NAME];
            foreach(new i: Player)
            {
                GetPlayerName(i, playerNameIG, MAX_PLAYER_NAME);
                if(!strcmp(playerNameIG, playerName, true))
                {
                    new output[144];
                    format(output, sizeof(output), "* %s foi kickado por %s. Motivo: %s", playerName, adminName, reason);
                    SendClientMessageToAll(0xf26363ff, output);
                    Kick(i);
                    return 1;
                }
            }
            return 1;
        }
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
