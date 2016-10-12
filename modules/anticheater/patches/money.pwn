/*******************************************************************************
* FILENAME :        modules/anticheater/patches/money.pwn
*
* DESCRIPTION :
*      Moneyhack protection module
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2016.  All rights reserved.
*
*/

hook GivePlayerMoney(playerid, money)
{

    return 1;
}

stock AC_GivePlayerMoney(playerid, money)
{
    PlayerCheatInfo[playerid][MoneyAmmount] += money;
    ResetPlayerMoney(playerid);
    return GivePlayerMoney(playerid, money);
}

#if defined _ALS_GivePlayerMoney
    #undef GivePlayerMoney
#else
    #define _ALS_GivePlayerMoney
#endif
#define GivePlayerMoney AC_GivePlayerMoney

hook OnPlayerUpdate(playerid)
{
    static pmoney = GetPlayerMoney(playerid);

    //OnPlayerMoneyChange
    if(pmoney != PlayerCheatInfo[playerid][MoneyAmmount])
    {

    }
    return 1;
}
