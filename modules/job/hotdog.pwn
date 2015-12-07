/*******************************************************************************
* FILENAME :        modules/job/hotdog.pwn
*
* DESCRIPTION :
*       Adds hotdog seller job to the server.
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
static const g_nVehicleModel = 588;

//------------------------------------------------------------------------------

static gplSellerID[MAX_PLAYERS] = {INVALID_PLAYER_ID, ...};
static gplSellerPrice[MAX_PLAYERS];

//------------------------------------------------------------------------------

hook OnPlayerDisconnect(playerid, reason)
{
    gplSellerID[playerid]    = INVALID_PLAYER_ID;
    gplSellerPrice[playerid] = 0;
    return 1;
}

//------------------------------------------------------------------------------

YCMD:venderhotdog(playerid, params[], help)
{
    new targetid, price;
    if(sscanf(params, "ud", targetid, price))
        return SendClientMessage(playerid, COLOR_INFO, "* /venderhotdog [playerid] [valor]");

    else if(GetVehicleModel(GetPlayerVehicleID(playerid)) != g_nVehicleModel)
        return SendClientMessage(playerid, COLOR_ERROR, "* Você deve estar em um veículo apropriado para vender hotdog.");

    else if(!IsPlayerLogged(targetid))
        return SendClientMessage(playerid, COLOR_ERROR, "* O jogador não está conectado.");

    else if(price < 1 || price > 100)
        return SendClientMessage(playerid, COLOR_INFO, "* O valor deve ser de $1 a $100.");

    new Float:targetPos[3];
    GetPlayerPos(targetid, targetPos[0], targetPos[1], targetPos[2]);

    if(!IsPlayerInRangeOfPoint(playerid, 5.0, targetPos[0], targetPos[1], targetPos[2]))
        return SendClientMessage(playerid, COLOR_ERROR, "* Você deve estar perto do jogador para poder vender.");

    else if(gplSellerID[targetid] != INVALID_PLAYER_ID && gplSellerID[targetid] != playerid)
        return SendClientMessagef(playerid, COLOR_INFO, "* Outro jogador já está vendendo um hotdog para %s.", GetPlayerNamef(targetid));

    gplSellerID[targetid] = playerid;
    gplSellerPrice[targetid] = price;

    SendClientMessage(playerid, COLOR_SPECIAL, "* Aguarde o jogador aceitar seu hotdog.");
    SendClientMessagef(targetid, COLOR_SPECIAL, "* %s está lhe oferencendo um hotdog por $%d.", GetPlayerNamef(playerid), price);
    SendClientMessage(targetid, COLOR_SUB_TITLE, "* Use /aceitarhotdog para aceitar ou /recusarhotdog para recusar.");

    defer CancelHotdog(targetid);
	return 1;
}

//------------------------------------------------------------------------------

YCMD:aceitarhotdog(playerid, params[], help)
{
    if(gplSellerID[playerid] == INVALID_PLAYER_ID)
        return SendClientMessage(playerid, COLOR_ERROR, "* Nenhum jogador lhe ofereceu um hotdog.");

    else if(GetVehicleModel(GetPlayerVehicleID(gplSellerID[playerid])) != g_nVehicleModel)
        return SendClientMessage(playerid, COLOR_ERROR, "* O jogador não está mais no veículo para vender hotdog.");

    else if(GetPlayerCash(playerid) < gplSellerPrice[playerid])
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não possuí dinheiro suficiente.");

    GivePlayerCash(playerid, -gplSellerPrice[playerid]);
    GivePlayerCash(gplSellerID[playerid], gplSellerPrice[playerid]);

    new Float:health;

    GetPlayerHealth(playerid, health);
    SetPlayerHealth(playerid, health+50);

    SendClientMessagef(playerid, COLOR_SPECIAL, "* Você comprou um hotdog de %s por $%d.", GetPlayerNamef(gplSellerID[playerid]), gplSellerPrice[playerid]);
    SendClientMessagef(gplSellerID[playerid], COLOR_SPECIAL, "* Você vendeu um hotdog para %s por $%d.", GetPlayerNamef(playerid), gplSellerPrice[playerid]);

    SendClientActionMessage(playerid, 15.0, "comeu um cachorro quente.");

    gplSellerID[playerid]    = INVALID_PLAYER_ID;
    gplSellerPrice[playerid] = 0;

    return 1;
}

//------------------------------------------------------------------------------

YCMD:recusarhotdog(playerid, params[], help)
{
    if(gplSellerID[playerid] == INVALID_PLAYER_ID)
        return SendClientMessage(playerid, COLOR_ERROR, "* Nenhum jogador lhe ofereceu um hotdog.");

    SendClientMessagef(playerid, COLOR_SPECIAL, "* Você recusou um hotdog de %s.", GetPlayerNamef(gplSellerID[playerid]));
    SendClientMessagef(gplSellerID[playerid], COLOR_SPECIAL, "* %s recusou seu h0otdog.", GetPlayerNamef(playerid));

    gplSellerID[playerid]    = INVALID_PLAYER_ID;
    gplSellerPrice[playerid] = 0;

    return 1;
}

//------------------------------------------------------------------------------

timer CancelHotdog[60000](playerid)
{
    gplSellerID[playerid]    = INVALID_PLAYER_ID;
    gplSellerPrice[playerid] = 0;
}
