/*******************************************************************************
* FILENAME :        modules/job/hotdog.pwn
*
* DESCRIPTION :
*       Adds icecream seller job to the server.
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

// Vehicle model
static const g_nVehicleModel = 423;

//------------------------------------------------------------------------------

static gplSellerID[MAX_PLAYERS] = {INVALID_PLAYER_ID, ...};
static gplSellerPrice[MAX_PLAYERS];

//------------------------------------------------------------------------------

hook OnGameModeInit()
{
    print("Loading icecream seller job.");
}

//------------------------------------------------------------------------------

hook OnPlayerDisconnect(playerid, reason)
{
    gplSellerID[playerid]    = INVALID_PLAYER_ID;
    gplSellerPrice[playerid] = 0;
    return 1;
}

//------------------------------------------------------------------------------

YCMD:vendersorvete(playerid, params[], help)
{
    new targetid, price;
    if(sscanf(params, "ud", targetid, price))
        return SendClientMessage(playerid, COLOR_INFO, "* /vendersorvete [playerid] [valor]");

    else if(GetVehicleModel(GetPlayerVehicleID(playerid)) != g_nVehicleModel)
        return SendClientMessage(playerid, COLOR_ERROR, "* Você deve estar em um veículo apropriado para vender sorvete.");

    else if(playerid == targetid)
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não pode vender sorvete para si mesmo.");

    else if(gplSellerID[targetid] == playerid)
        return SendClientMessagef(playerid, COLOR_INFO, "* Você já ofereceu um sorvete para %s.", GetPlayerNamef(targetid));

    else if(!IsPlayerLogged(targetid))
        return SendClientMessage(playerid, COLOR_ERROR, "* O jogador não está conectado.");

    else if(price < 1 || price > 100)
        return SendClientMessage(playerid, COLOR_INFO, "* O valor deve ser de $1 a $100.");

    new Float:targetPos[3];
    GetPlayerPos(targetid, targetPos[0], targetPos[1], targetPos[2]);

    if(!IsPlayerInRangeOfPoint(playerid, 3.5, targetPos[0], targetPos[1], targetPos[2]))
        return SendClientMessage(playerid, COLOR_ERROR, "* Você deve estar perto do jogador para poder vender.");

    else if(gplSellerID[targetid] != INVALID_PLAYER_ID)
        return SendClientMessagef(playerid, COLOR_INFO, "* Outro jogador já está vendendo um sorvete para %s.", GetPlayerNamef(targetid));

    gplSellerID[targetid] = playerid;
    gplSellerPrice[targetid] = price;

    SendClientMessagef(playerid, COLOR_SPECIAL, "* Você ofereceu um sorvete para %s por $%d.", GetPlayerNamef(targetid), price);
    SendClientMessagef(targetid, COLOR_SPECIAL, "* %s está lhe oferencendo um sorvete por $%d.", GetPlayerNamef(playerid), price);
    SendClientMessage(targetid, COLOR_SUB_TITLE, "* Use /aceitarsorvete para aceitar ou /recusarsorvete para recusar.");

    defer CancelIcecream(targetid);
	return 1;
}

//------------------------------------------------------------------------------

YCMD:aceitarsorvete(playerid, params[], help)
{
    if(gplSellerID[playerid] == INVALID_PLAYER_ID)
        return SendClientMessage(playerid, COLOR_ERROR, "* Nenhum jogador lhe ofereceu um sorvete.");

    else if(GetVehicleModel(GetPlayerVehicleID(gplSellerID[playerid])) != g_nVehicleModel)
        return SendClientMessage(playerid, COLOR_ERROR, "* O jogador não está mais no veículo para vender sorvete.");

    else if(GetPlayerCash(playerid) < gplSellerPrice[playerid])
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não possuí dinheiro suficiente.");

    new Float:targetPos[3];
    GetPlayerPos(gplSellerID[playerid], targetPos[0], targetPos[1], targetPos[2]);

    if(!IsPlayerInRangeOfPoint(playerid, 3.5, targetPos[0], targetPos[1], targetPos[2]))
        return SendClientMessage(playerid, COLOR_ERROR, "* Você deve estar perto do jogador para poder aceitar.");

    GivePlayerCash(playerid, -gplSellerPrice[playerid]);
    GivePlayerCash(gplSellerID[playerid], gplSellerPrice[playerid]);

    new Float:health;

    GetPlayerHealth(playerid, health);
    SetPlayerHealth(playerid, health + 10.0);

    SetPlayerThirst(playerid, GetPlayerThirst(playerid) + 10.0);

    SendClientMessagef(playerid, COLOR_SPECIAL, "* Você comprou um sorvete de %s por $%d.", GetPlayerNamef(gplSellerID[playerid]), gplSellerPrice[playerid]);
    SendClientMessagef(gplSellerID[playerid], COLOR_SPECIAL, "* Você vendeu um sorvete para %s por $%d.", GetPlayerNamef(playerid), gplSellerPrice[playerid]);

    SendClientActionMessage(playerid, 15.0, "tomou um sorvete.");

    gplSellerID[playerid]    = INVALID_PLAYER_ID;
    gplSellerPrice[playerid] = 0;

    return 1;
}

//------------------------------------------------------------------------------

YCMD:recusarsorvete(playerid, params[], help)
{
    if(gplSellerID[playerid] == INVALID_PLAYER_ID)
        return SendClientMessage(playerid, COLOR_ERROR, "* Nenhum jogador lhe ofereceu um sorvete.");

    SendClientMessagef(playerid, COLOR_SPECIAL, "* Você recusou um sorvete de %s.", GetPlayerNamef(gplSellerID[playerid]));
    SendClientMessagef(gplSellerID[playerid], COLOR_SPECIAL, "* %s recusou seu sorvete.", GetPlayerNamef(playerid));

    gplSellerID[playerid]    = INVALID_PLAYER_ID;
    gplSellerPrice[playerid] = 0;

    return 1;
}

//------------------------------------------------------------------------------

timer CancelIcecream[60000](playerid)
{
    gplSellerID[playerid]    = INVALID_PLAYER_ID;
    gplSellerPrice[playerid] = 0;
}
