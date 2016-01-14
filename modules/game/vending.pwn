/*******************************************************************************
* FILENAME :        modules/game/vending.pwn
*
* DESCRIPTION :
*       Changes the vending machies to server-sided.
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

// #include <YSI\y_hooks>

//------------------------------------------------------------------------------

public OnPlayerUseVendingMachine(playerid, machineid)
{
    if(GetPlayerCash(playerid) < 1)
    {
        PlayErrorSound(playerid);
        SendClientMessage(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiente.");
        return 0;
    }

    new Float:health;
    GetPlayerHealth(playerid, health);

    if((health + 10.0) > 100.0) health = 100.0;
    else health += 10.0;

    SetPlayerHealth(playerid, health);
    GivePlayerCash(playerid, -1);
    return 1;
}

public OnPlayerDrinkSprunk(playerid)
{
    new Float:health;
    GetPlayerHealth(playerid, health);

    if((health + 10.0) > 100.0) health = 100.0;
    else health += 10.0;

    SetPlayerHealth(playerid, health);
    SetPlayerThirst(playerid, GetPlayerThirst(playerid) + 10.0);
    return 1;
}
