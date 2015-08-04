/*******************************************************************************
* FILENAME :        modules/player/dialogs.pwn
*
* DESCRIPTION :
*       Handle with the dialogs showed to players
*
* NOTES :
*       This file should only contain player general commands.
*       Faction, job, admin, etc, commands should be in their respective modules
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch(dialogid)
    {
        case DIALOG_HELP:
        {
            if(!response)
                return PlayCancelSound(playerid);

            CallRemoteFunction("OnPlayerCommandText", "is", playerid, "/ajudaemprego");
            return 1;
        }
    }
    return 1;
}
