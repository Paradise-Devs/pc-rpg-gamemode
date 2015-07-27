/*******************************************************************************
* FILENAME :        modules/admin/funcs.pwn
*
* DESCRIPTION :
*       Adds admins functions.
*
* NOTES :
*       This file should only contain admin funcs.
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

SendAdminMessage(PLAYER_RANK:rank, color, const message[])
{
    foreach(new i: Player)
    {
        if(GetPlayerHighestRank(i) < rank)
            continue;

        SendClientMessage(i, color, message);
    }
    return 1;
}
