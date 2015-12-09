/*******************************************************************************
* FILENAME :        modules/gameplay/bank.pwn
*
* DESCRIPTION :
*       Adds bank to the server.
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

// Checkpointid
static STREAMER_TAG_CP gCheckpointid[4];

//------------------------------------------------------------------------------

enum E_KEYPAD_TD
{
    Text:keypad_textdraw_num[10],
    Text:keypad_textdraw_box[12], // 10 numbers, RED_OFF, GREEN_OFF
    Text:keypad_textdraw_bg // The grey background box
}
static KEYPAD_gKeypadTextdraws[E_KEYPAD_TD];

// player
static bool:g_isVisible[MAX_PLAYERS];
static g_pSelectedField[MAX_PLAYERS];
static g_plInputValue[MAX_PLAYERS][10];
static g_plInputAccount[MAX_PLAYERS][10];
static PlayerText:g_ptBank[MAX_PLAYERS][23];

//------------------------------------------------------------------------------

#define KEYPAD_TD_GREEN_OFF     10
#define KEYPAD_TD_RED_OFF       11

//------------------------------------------------------------------------------

hook OnGameModeInit()
{
    for(new i; i < sizeof(gBankPositions); i++)
        gCheckpointid[i] = CreateDynamicCP(gBankPositions[i][0], gBankPositions[i][1], gBankPositions[i][2], 1.0, 0, 0);

    CreateKeypadTextdraws();
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerDisconnect(playerid, reason)
{
    g_isVisible[playerid] = false;
    g_pSelectedField[playerid] = 0;
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerEnterDynamicCP(playerid, STREAMER_TAG_CP checkpointid)
{
    for(new i = 0; i < sizeof(gBankPositions); i++)
    {
        if(checkpointid == gCheckpointid[i])
        {
            if(GetPlayerBankAccount(playerid) != 0) {
                g_pSelectedField[playerid] = 0;
                ShowPlayerBankTextDraw(playerid);
                PlayerPlaySound(playerid, 21000, 0.0, 0.0, 0.0);
            }
            else {
                SendClientMessage(playerid, COLOR_ERROR, "* Você não possui uma conta bancária.");
                PlayErrorSound(playerid);
            }
            return -2;
        }
    }
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerClickPlayerTD(playerid, PlayerText:playertextid)
{
    if(playertextid == g_ptBank[playerid][15])// Withdraw
    {
        new cash = strval(g_plInputValue[playerid]);
        if(GetPlayerBankCash(playerid) < cash)
        {
            SendClientMessage(playerid, COLOR_ERROR, "* Você não tem esta quantia em sua conta.");
            PlayerPlaySound(playerid, 21001, 0.0, 0.0, 0.0);
        }
        else
        {
            GivePlayerCash(playerid, cash);
            SetPlayerBankCash(playerid, GetPlayerBankCash(playerid) - cash);
            SendClientActionMessage(playerid, 15.0, "sacou uma quantidade em dinheiro.");
            PlayerPlaySound(playerid, 21000, 0.0, 0.0, 0.0);

            new balance[32];
            format(balance, sizeof(balance), "Saldo: $%s", formatnumber(GetPlayerBankCash(playerid)));
            PlayerTextDrawSetString(playerid, g_ptBank[playerid][21], balance);
        }
    }
    else if(playertextid == g_ptBank[playerid][8])// Deposit
    {
        new cash = strval(g_plInputValue[playerid]);
        if(GetPlayerCash(playerid) < cash)
        {
            SendClientMessage(playerid, COLOR_ERROR, "* Você não tem esta quantia com você.");
            PlayerPlaySound(playerid, 21001, 0.0, 0.0, 0.0);
        }
        else
        {
            GivePlayerCash(playerid, -cash);
            PlayerPlaySound(playerid, 21000, 0.0, 0.0, 0.0);
            SetPlayerBankCash(playerid, GetPlayerBankCash(playerid) + cash);
            SendClientActionMessage(playerid, 15.0, "deposita uma quantidade de dinheiro.");

            new balance[32];
            format(balance, sizeof(balance), "Saldo: $%s", formatnumber(GetPlayerBankCash(playerid)));
            PlayerTextDrawSetString(playerid, g_ptBank[playerid][21], balance);
        }
    }
    else if(playertextid == g_ptBank[playerid][9])// Transfer
    {
        new cash = strval(g_plInputValue[playerid]);
        new account = strval(g_plInputAccount[playerid]);
        if(GetPlayerBankCash(playerid) < cash)
        {
            SendClientMessage(playerid, COLOR_ERROR, "* Você não tem esta quantia em sua conta bancária.");
            PlayerPlaySound(playerid, 21001, 0.0, 0.0, 0.0);
        }
        else if(account < 1000 || account > 9999)
        {
            SendClientMessage(playerid, COLOR_ERROR, "* Conta inválida para transferência.");
            PlayerPlaySound(playerid, 21001, 0.0, 0.0, 0.0);
        }
        else
        {
            foreach(new i: Player)
            {
                if(GetPlayerBankAccount(i) == account)
                {
                    SetPlayerBankCash(i, GetPlayerBankCash(i) + cash);
                    SetPlayerBankCash(playerid, GetPlayerBankCash(i) - cash);

                    SendClientMessagef(playerid, 0xe48d37ff, "* Você transferiu $%s para %s.", formatnumber(cash), GetPlayerNamef(i));
                    SendClientMessagef(i, 0xe48d37ff, "* %s transferiu $%s para você.", GetPlayerNamef(playerid), formatnumber(cash));
                    return 1;
                }
            }
            SendClientMessage(playerid, COLOR_ERROR, "* Nenhum jogador online com essa conta bancária.");
        }
    }
    else if(playertextid == g_ptBank[playerid][7])// Deposit/Withdraw Value
        g_pSelectedField[playerid] = 0;
    else if(playertextid == g_ptBank[playerid][17])// Transfer account
        g_pSelectedField[playerid] = 1;
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	if(g_isVisible[playerid])
	{
	    if(clickedid == Text:INVALID_TEXT_DRAW)
		{
		    PlayerPlaySound(playerid, 21001, 0, 0, 0);
            HidePlayerBankTextDraw(playerid);
			HidePlayerKeypad(playerid);
            return 1;
		}

        else if(clickedid == KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_RED_OFF])
        {
            if(g_pSelectedField[playerid] == 0)
            {
                if(strlen(g_plInputValue[playerid]) < 1) PlayerPlaySound(playerid, 21001, 0.0, 0.0, 0.0);
                else PlayerPlaySound(playerid, 21000, 0.0, 0.0, 0.0);
                strdel(g_plInputValue[playerid], 0, strlen(g_plInputValue[playerid]));
                PlayerTextDrawSetString(playerid, g_ptBank[playerid][7], "$0");
            }
            else
            {
                if(strlen(g_plInputAccount[playerid]) < 1) PlayerPlaySound(playerid, 21001, 0.0, 0.0, 0.0);
                else PlayerPlaySound(playerid, 21000, 0.0, 0.0, 0.0);
                strdel(g_plInputAccount[playerid], 0, strlen(g_plInputAccount[playerid]));
                PlayerTextDrawSetString(playerid, g_ptBank[playerid][17], "0000000");
            }
        }

        for(new i=0; i<10; i++)
	    {
	        if(clickedid == KEYPAD_gKeypadTextdraws[keypad_textdraw_num][i])
	        {
                if(g_pSelectedField[playerid] == 0)
                {
                    if(strlen(g_plInputValue[playerid]) < (sizeof(g_plInputValue[]) - 1))
                    {
        	            new numstr[2];
        	            format(numstr, 2, "%i", i);
        	            strins(g_plInputValue[playerid], numstr, strlen(g_plInputValue[playerid]));

                        new input_formatted[14];
                        format(input_formatted, sizeof(input_formatted), "$%s", formatnumber(strval(g_plInputValue[playerid])));
                        PlayerTextDrawSetString(playerid, g_ptBank[playerid][7], input_formatted);
        	            PlayerPlaySound(playerid, 21000, 0.0, 0.0, 0.0);
                    } else {
        	            PlayerPlaySound(playerid, 21001, 0.0, 0.0, 0.0);
                    }
                }
                else
                {
                    if(strlen(g_plInputAccount[playerid]) < (sizeof(g_plInputAccount[]) - 1))
                    {
        	            new numstr[2];
        	            format(numstr, 2, "%i", i);
        	            strins(g_plInputAccount[playerid], numstr, strlen(g_plInputAccount[playerid]));

                        new input_formatted[14];
                        format(input_formatted, sizeof(input_formatted), "$%s", formatnumber(strval(g_plInputAccount[playerid])));
                        PlayerTextDrawSetString(playerid, g_ptBank[playerid][17], g_plInputAccount[playerid]);

                        new account = strval(g_plInputAccount[playerid]);
                        if(account > 1000 && account < 9999)
                        {
                            foreach(new j: Player)
                            {
                                if(GetPlayerBankAccount(j) == account)
                                {
                                    PlayerTextDrawSetString(playerid, g_ptBank[playerid][20], GetPlayerNamef(j));
                                    break;
                                }
                            }
                        }

                        PlayerPlaySound(playerid, 21000, 0.0, 0.0, 0.0);
                    } else {
        	            PlayerPlaySound(playerid, 21001, 0.0, 0.0, 0.0);
                    }
                }
	        }
	    }
    }
    return 1;
}

//------------------------------------------------------------------------------

stock ShowPlayerKeypad(playerid)
{
	if(!IsPlayerConnected(playerid))
        return 0;

    if(g_isVisible[playerid])
        return 1;

	for(new i=0; i<10; i++) // Show boxes
		TextDrawShowForPlayer(playerid, KEYPAD_gKeypadTextdraws[keypad_textdraw_box][i]);

	for(new i=0; i<10; i++) // Show numbers
		TextDrawShowForPlayer(playerid, KEYPAD_gKeypadTextdraws[keypad_textdraw_num][i]);

	TextDrawShowForPlayer(playerid, KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_RED_OFF]);
	TextDrawShowForPlayer(playerid, KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_GREEN_OFF]);
	TextDrawShowForPlayer(playerid, KEYPAD_gKeypadTextdraws[keypad_textdraw_bg]);
	SelectTextDraw(playerid, 0x00FF00FF);

	g_isVisible[playerid] = true;
    HidePlayerLogo(playerid);

	strdel(g_plInputValue[playerid], 0, strlen(g_plInputValue[playerid]));
	strdel(g_plInputAccount[playerid], 0, strlen(g_plInputAccount[playerid]));
	return 1;
}

//------------------------------------------------------------------------------

stock HidePlayerKeypad(playerid)
{
	if(!IsPlayerConnected(playerid))
        return 0;

    if(!g_isVisible[playerid])
        return 1;

	for(new i=0; i<10; i++) // Show boxes
		TextDrawHideForPlayer(playerid, KEYPAD_gKeypadTextdraws[keypad_textdraw_box][i]);

	for(new i=0; i<10; i++) // Show numbers
		TextDrawHideForPlayer(playerid, KEYPAD_gKeypadTextdraws[keypad_textdraw_num][i]);

	TextDrawHideForPlayer(playerid, KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_RED_OFF]);
	TextDrawHideForPlayer(playerid, KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_GREEN_OFF]);
	TextDrawHideForPlayer(playerid, KEYPAD_gKeypadTextdraws[keypad_textdraw_bg]);
    CancelSelectTextDraw(playerid);

	g_isVisible[playerid] = false;
    ShowPlayerLogo(playerid);
	return 1;
}

//------------------------------------------------------------------------------

stock CreateKeypadTextdraws()
{
	// Create the grey background box
	KEYPAD_gKeypadTextdraws[keypad_textdraw_bg] = TextDrawCreate(570.000000, 280.000000, "_");
	TextDrawAlignment(KEYPAD_gKeypadTextdraws[keypad_textdraw_bg], 2);
	TextDrawBackgroundColor(KEYPAD_gKeypadTextdraws[keypad_textdraw_bg], 255);
	TextDrawFont(KEYPAD_gKeypadTextdraws[keypad_textdraw_bg], 2);
	TextDrawLetterSize(KEYPAD_gKeypadTextdraws[keypad_textdraw_bg], 0.319999, 14.799995);
	TextDrawColor(KEYPAD_gKeypadTextdraws[keypad_textdraw_bg], -1);
	TextDrawSetOutline(KEYPAD_gKeypadTextdraws[keypad_textdraw_bg], 0);
	TextDrawSetProportional(KEYPAD_gKeypadTextdraws[keypad_textdraw_bg], 1);
	TextDrawSetShadow(KEYPAD_gKeypadTextdraws[keypad_textdraw_bg], 0);
	TextDrawUseBox(KEYPAD_gKeypadTextdraws[keypad_textdraw_bg], 1);
	TextDrawBoxColor(KEYPAD_gKeypadTextdraws[keypad_textdraw_bg], 0x00000047);
	TextDrawTextSize(KEYPAD_gKeypadTextdraws[keypad_textdraw_bg], 0.000000, 113.000000);

	// The coordinates for the boxes
	new keypad_box_coords[][] = {
	{540, 290},
	{570, 320},
	{570, 290},
	{600, 290},
	{540, 320},
	{600, 320},
	{600, 350},
	{570, 350},
	{540, 350},
	{570, 380}
	};

	for(new i=0; i<10; i++) // Create the black boxes for the numbers
	{
		KEYPAD_gKeypadTextdraws[keypad_textdraw_box][i] = TextDrawCreate(keypad_box_coords[i][0], keypad_box_coords[i][1], "~N~~N~~N~");
		TextDrawAlignment(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][i], 2);
		TextDrawBackgroundColor(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][i], 255);
		TextDrawFont(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][i], 2);
		TextDrawLetterSize(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][i], 0.319999, 0.899999);
		TextDrawColor(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][i], -1);
		TextDrawSetOutline(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][i], 0);
		TextDrawSetProportional(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][i], 1);
		TextDrawSetShadow(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][i], 0);
		TextDrawUseBox(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][i], 1);
		TextDrawBoxColor(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][i], 255);
		TextDrawTextSize(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][i], 100.000000, 23.000000);
	}

	// The coordinates for the numbers
	new keypad_num_coords[][] = {
	{570, 379},
	{540, 289},
	{570, 289},
	{600, 289},
	{540, 319},
	{570, 319},
	{600, 319},
	{540, 349},
	{570, 349},
	{600, 349}
	};

	for(new i=0; i<10; i++) // Create the number textdraws
	{
		new numstr[2];
		format(numstr, 2, "%i", i);
		KEYPAD_gKeypadTextdraws[keypad_textdraw_num][i] = TextDrawCreate(keypad_num_coords[i][0], keypad_num_coords[i][1], numstr);
		TextDrawAlignment(KEYPAD_gKeypadTextdraws[keypad_textdraw_num][i], 2);
		TextDrawBackgroundColor(KEYPAD_gKeypadTextdraws[keypad_textdraw_num][i], 255);
		TextDrawFont(KEYPAD_gKeypadTextdraws[keypad_textdraw_num][i], 2);
		TextDrawLetterSize(KEYPAD_gKeypadTextdraws[keypad_textdraw_num][i], 0.550000, 2.599998);
		TextDrawColor(KEYPAD_gKeypadTextdraws[keypad_textdraw_num][i], -1);
		TextDrawSetOutline(KEYPAD_gKeypadTextdraws[keypad_textdraw_num][i], 0);
		TextDrawSetProportional(KEYPAD_gKeypadTextdraws[keypad_textdraw_num][i], 1);
		TextDrawSetShadow(KEYPAD_gKeypadTextdraws[keypad_textdraw_num][i], 0);
		TextDrawTextSize(KEYPAD_gKeypadTextdraws[keypad_textdraw_num][i], 23.000000, 23.000000);
		TextDrawSetSelectable(KEYPAD_gKeypadTextdraws[keypad_textdraw_num][i], 1);
	}

	// Green Off
	KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_GREEN_OFF] = TextDrawCreate(600.000000, 380.000000, "~N~~N~~N~");
	TextDrawAlignment(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_GREEN_OFF], 2);
	TextDrawBackgroundColor(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_GREEN_OFF], 255);
	TextDrawFont(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_GREEN_OFF], 2);
	TextDrawLetterSize(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_GREEN_OFF], 0.319999, 0.899999);
	TextDrawColor(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_GREEN_OFF], -1);
	TextDrawSetOutline(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_GREEN_OFF], 0);
	TextDrawSetProportional(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_GREEN_OFF], 1);
	TextDrawSetShadow(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_GREEN_OFF], 0);
	TextDrawUseBox(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_GREEN_OFF], 1);
	TextDrawBoxColor(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_GREEN_OFF], 5374207);
	TextDrawTextSize(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_GREEN_OFF], 23.000000, 23.000000);

	// Red Off
	KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_RED_OFF] = TextDrawCreate(540.000000, 380.000000, "~N~~N~~N~");
	TextDrawAlignment(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_RED_OFF], 2);
	TextDrawBackgroundColor(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_RED_OFF], 255);
	TextDrawFont(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_RED_OFF], 2);
	TextDrawLetterSize(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_RED_OFF], 0.319999, 0.899999);
	TextDrawColor(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_RED_OFF], -1);
	TextDrawSetOutline(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_RED_OFF], 0);
	TextDrawSetProportional(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_RED_OFF], 1);
	TextDrawSetShadow(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_RED_OFF], 0);
	TextDrawUseBox(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_RED_OFF], 1);
	TextDrawBoxColor(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_RED_OFF], 1375731967);
	TextDrawTextSize(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_RED_OFF], 23.000000, 23.000000);
    TextDrawSetSelectable(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_RED_OFF], 1);
	return 1;
}

//------------------------------------------------------------------------------

ShowPlayerBankTextDraw(playerid)
{
    if(g_isVisible[playerid])
        return 1;

    g_ptBank[playerid][0] = CreatePlayerTextDraw(playerid, 480.000000, 115.000000, "_");
    PlayerTextDrawBackgroundColor(playerid, g_ptBank[playerid][0], 255);
    PlayerTextDrawFont(playerid, g_ptBank[playerid][0], 1);
    PlayerTextDrawLetterSize(playerid, g_ptBank[playerid][0], 1.580000, 21.600002);
    PlayerTextDrawColor(playerid, g_ptBank[playerid][0], -1);
    PlayerTextDrawSetOutline(playerid, g_ptBank[playerid][0], 0);
    PlayerTextDrawSetProportional(playerid, g_ptBank[playerid][0], 1);
    PlayerTextDrawSetShadow(playerid, g_ptBank[playerid][0], 1);
    PlayerTextDrawUseBox(playerid, g_ptBank[playerid][0], 1);
    PlayerTextDrawBoxColor(playerid, g_ptBank[playerid][0], 128);
    PlayerTextDrawTextSize(playerid, g_ptBank[playerid][0], 158.000000, 0.000000);
    PlayerTextDrawSetSelectable(playerid, g_ptBank[playerid][0], 0);

    g_ptBank[playerid][1] = CreatePlayerTextDraw(playerid, 250.000000, 160.000000, "_");
    PlayerTextDrawBackgroundColor(playerid, g_ptBank[playerid][1], 255);
    PlayerTextDrawFont(playerid, g_ptBank[playerid][1], 1);
    PlayerTextDrawLetterSize(playerid, g_ptBank[playerid][1], 0.500000, 4.099999);
    PlayerTextDrawColor(playerid, g_ptBank[playerid][1], -1);
    PlayerTextDrawSetOutline(playerid, g_ptBank[playerid][1], 0);
    PlayerTextDrawSetProportional(playerid, g_ptBank[playerid][1], 1);
    PlayerTextDrawSetShadow(playerid, g_ptBank[playerid][1], 1);
    PlayerTextDrawUseBox(playerid, g_ptBank[playerid][1], 1);
    PlayerTextDrawBoxColor(playerid, g_ptBank[playerid][1], 598455551);
    PlayerTextDrawTextSize(playerid, g_ptBank[playerid][1], 163.000000, 0.000000);

    g_ptBank[playerid][2] = CreatePlayerTextDraw(playerid, 250.000000, 210.000000, "_");
    PlayerTextDrawBackgroundColor(playerid, g_ptBank[playerid][2], 255);
    PlayerTextDrawFont(playerid, g_ptBank[playerid][2], 1);
    PlayerTextDrawLetterSize(playerid, g_ptBank[playerid][2], 0.500000, 4.099999);
    PlayerTextDrawColor(playerid, g_ptBank[playerid][2], -1);
    PlayerTextDrawSetOutline(playerid, g_ptBank[playerid][2], 0);
    PlayerTextDrawSetProportional(playerid, g_ptBank[playerid][2], 1);
    PlayerTextDrawSetShadow(playerid, g_ptBank[playerid][2], 1);
    PlayerTextDrawUseBox(playerid, g_ptBank[playerid][2], 1);
    PlayerTextDrawBoxColor(playerid, g_ptBank[playerid][2], 598455551);
    PlayerTextDrawTextSize(playerid, g_ptBank[playerid][2], 163.000000, 0.000000);

    g_ptBank[playerid][3] = CreatePlayerTextDraw(playerid, 250.000000, 260.000000, "_");
    PlayerTextDrawBackgroundColor(playerid, g_ptBank[playerid][3], 255);
    PlayerTextDrawFont(playerid, g_ptBank[playerid][3], 1);
    PlayerTextDrawLetterSize(playerid, g_ptBank[playerid][3], 0.500000, 4.099999);
    PlayerTextDrawColor(playerid, g_ptBank[playerid][3], -1);
    PlayerTextDrawSetOutline(playerid, g_ptBank[playerid][3], 0);
    PlayerTextDrawSetProportional(playerid, g_ptBank[playerid][3], 1);
    PlayerTextDrawSetShadow(playerid, g_ptBank[playerid][3], 1);
    PlayerTextDrawUseBox(playerid, g_ptBank[playerid][3], 1);
    PlayerTextDrawBoxColor(playerid, g_ptBank[playerid][3], 598455551);
    PlayerTextDrawTextSize(playerid, g_ptBank[playerid][3], 163.000000, 0.000000);

    g_ptBank[playerid][4] = CreatePlayerTextDraw(playerid, 250.000000, 260.000000, "_");
    PlayerTextDrawBackgroundColor(playerid, g_ptBank[playerid][4], 255);
    PlayerTextDrawFont(playerid, g_ptBank[playerid][4], 1);
    PlayerTextDrawLetterSize(playerid, g_ptBank[playerid][4], 0.500000, 1.900002);
    PlayerTextDrawColor(playerid, g_ptBank[playerid][4], -1);
    PlayerTextDrawSetOutline(playerid, g_ptBank[playerid][4], 0);
    PlayerTextDrawSetProportional(playerid, g_ptBank[playerid][4], 1);
    PlayerTextDrawSetShadow(playerid, g_ptBank[playerid][4], 1);
    PlayerTextDrawUseBox(playerid, g_ptBank[playerid][4], 1);
    PlayerTextDrawBoxColor(playerid, g_ptBank[playerid][4], 64);
    PlayerTextDrawTextSize(playerid, g_ptBank[playerid][4], 163.000000, 0.000000);
    PlayerTextDrawSetSelectable(playerid, g_ptBank[playerid][4], 0);

    g_ptBank[playerid][5] = CreatePlayerTextDraw(playerid, 250.000000, 210.000000, "_");
    PlayerTextDrawBackgroundColor(playerid, g_ptBank[playerid][5], 255);
    PlayerTextDrawFont(playerid, g_ptBank[playerid][5], 1);
    PlayerTextDrawLetterSize(playerid, g_ptBank[playerid][5], 0.500000, 1.900002);
    PlayerTextDrawColor(playerid, g_ptBank[playerid][5], -1);
    PlayerTextDrawSetOutline(playerid, g_ptBank[playerid][5], 0);
    PlayerTextDrawSetProportional(playerid, g_ptBank[playerid][5], 1);
    PlayerTextDrawSetShadow(playerid, g_ptBank[playerid][5], 1);
    PlayerTextDrawUseBox(playerid, g_ptBank[playerid][5], 1);
    PlayerTextDrawBoxColor(playerid, g_ptBank[playerid][5], 64);
    PlayerTextDrawTextSize(playerid, g_ptBank[playerid][5], 163.000000, 0.000000);
    PlayerTextDrawSetSelectable(playerid, g_ptBank[playerid][5], 0);

    g_ptBank[playerid][6] = CreatePlayerTextDraw(playerid, 398.000000, 176.000000, "_");
    PlayerTextDrawBackgroundColor(playerid, g_ptBank[playerid][6], 255);
    PlayerTextDrawFont(playerid, g_ptBank[playerid][6], 1);
    PlayerTextDrawLetterSize(playerid, g_ptBank[playerid][6], 0.500000, 1.000000);
    PlayerTextDrawColor(playerid, g_ptBank[playerid][6], -1);
    PlayerTextDrawSetOutline(playerid, g_ptBank[playerid][6], 0);
    PlayerTextDrawSetProportional(playerid, g_ptBank[playerid][6], 1);
    PlayerTextDrawSetShadow(playerid, g_ptBank[playerid][6], 5);
    PlayerTextDrawUseBox(playerid, g_ptBank[playerid][6], 1);
    PlayerTextDrawBoxColor(playerid, g_ptBank[playerid][6], -1);
    PlayerTextDrawTextSize(playerid, g_ptBank[playerid][6], 310.000000, 0.000000);

    g_ptBank[playerid][7] = CreatePlayerTextDraw(playerid, 354.000000, 173.000000, "$0");// Valor inserido
    PlayerTextDrawAlignment(playerid, g_ptBank[playerid][7], 2);
    PlayerTextDrawBackgroundColor(playerid, g_ptBank[playerid][7], 255);
    PlayerTextDrawFont(playerid, g_ptBank[playerid][7], 1);
    PlayerTextDrawLetterSize(playerid, g_ptBank[playerid][7], 0.290000, 1.500000);
    PlayerTextDrawColor(playerid, g_ptBank[playerid][7], 255);
    PlayerTextDrawSetOutline(playerid, g_ptBank[playerid][7], 0);
    PlayerTextDrawSetProportional(playerid, g_ptBank[playerid][7], 1);
    PlayerTextDrawSetShadow(playerid, g_ptBank[playerid][7], 0);
    PlayerTextDrawTextSize(playerid, g_ptBank[playerid][7], 25.0, 83.0);
    PlayerTextDrawSetSelectable(playerid, g_ptBank[playerid][7], 1);

    g_ptBank[playerid][8] = CreatePlayerTextDraw(playerid, 172.000000, 219.000000, "depositar");
    PlayerTextDrawBackgroundColor(playerid, g_ptBank[playerid][8], 255);
    PlayerTextDrawFont(playerid, g_ptBank[playerid][8], 2);
    PlayerTextDrawLetterSize(playerid, g_ptBank[playerid][8], 0.300000, 1.899999);
    PlayerTextDrawColor(playerid, g_ptBank[playerid][8], -1);
    PlayerTextDrawSetOutline(playerid, g_ptBank[playerid][8], 0);
    PlayerTextDrawSetProportional(playerid, g_ptBank[playerid][8], 1);
    PlayerTextDrawSetShadow(playerid, g_ptBank[playerid][8], 1);
    PlayerTextDrawTextSize(playerid, g_ptBank[playerid][8], 240.0, 25.0);
    PlayerTextDrawSetSelectable(playerid, g_ptBank[playerid][8], 1);

    g_ptBank[playerid][9] = CreatePlayerTextDraw(playerid, 169.000000, 269.000000, "Transferir");
    PlayerTextDrawBackgroundColor(playerid, g_ptBank[playerid][9], 255);
    PlayerTextDrawFont(playerid, g_ptBank[playerid][9], 2);
    PlayerTextDrawLetterSize(playerid, g_ptBank[playerid][9], 0.300000, 1.899999);
    PlayerTextDrawColor(playerid, g_ptBank[playerid][9], -1);
    PlayerTextDrawSetOutline(playerid, g_ptBank[playerid][9], 0);
    PlayerTextDrawSetProportional(playerid, g_ptBank[playerid][9], 1);
    PlayerTextDrawSetShadow(playerid, g_ptBank[playerid][9], 1);
    PlayerTextDrawTextSize(playerid, g_ptBank[playerid][9], 244.0, 25.0);
    PlayerTextDrawSetSelectable(playerid, g_ptBank[playerid][9], 1);

    g_ptBank[playerid][10] = CreatePlayerTextDraw(playerid, 166.000000, 122.000000, "_");
    PlayerTextDrawBackgroundColor(playerid, g_ptBank[playerid][10], 255);
    PlayerTextDrawFont(playerid, g_ptBank[playerid][10], 1);
    PlayerTextDrawLetterSize(playerid, g_ptBank[playerid][10], 0.539999, 2.700001);
    PlayerTextDrawColor(playerid, g_ptBank[playerid][10], -1);
    PlayerTextDrawSetOutline(playerid, g_ptBank[playerid][10], 0);
    PlayerTextDrawSetProportional(playerid, g_ptBank[playerid][10], 1);
    PlayerTextDrawSetShadow(playerid, g_ptBank[playerid][10], 1);
    PlayerTextDrawUseBox(playerid, g_ptBank[playerid][10], 1);
    PlayerTextDrawBoxColor(playerid, g_ptBank[playerid][10], 598455551);
    PlayerTextDrawTextSize(playerid, g_ptBank[playerid][10], 470.000000, 0.000000);
    PlayerTextDrawSetSelectable(playerid, g_ptBank[playerid][10], 0);

    g_ptBank[playerid][11] = CreatePlayerTextDraw(playerid, 475.000000, 122.000000, "_");
    PlayerTextDrawBackgroundColor(playerid, g_ptBank[playerid][11], 255);
    PlayerTextDrawFont(playerid, g_ptBank[playerid][11], 1);
    PlayerTextDrawLetterSize(playerid, g_ptBank[playerid][11], 0.500000, 1.200001);
    PlayerTextDrawColor(playerid, g_ptBank[playerid][11], -1);
    PlayerTextDrawSetOutline(playerid, g_ptBank[playerid][11], 0);
    PlayerTextDrawSetProportional(playerid, g_ptBank[playerid][11], 1);
    PlayerTextDrawSetShadow(playerid, g_ptBank[playerid][11], 1);
    PlayerTextDrawUseBox(playerid, g_ptBank[playerid][11], 1);
    PlayerTextDrawBoxColor(playerid, g_ptBank[playerid][11], 64);
    PlayerTextDrawTextSize(playerid, g_ptBank[playerid][11], 162.000000, -59.000000);
    PlayerTextDrawSetSelectable(playerid, g_ptBank[playerid][11], 0);

    g_ptBank[playerid][12] = CreatePlayerTextDraw(playerid, 280.000000, 126.000000, "BANCO");
    PlayerTextDrawBackgroundColor(playerid, g_ptBank[playerid][12], 255);
    PlayerTextDrawFont(playerid, g_ptBank[playerid][12], 2);
    PlayerTextDrawLetterSize(playerid, g_ptBank[playerid][12], 0.400000, 1.700000);
    PlayerTextDrawColor(playerid, g_ptBank[playerid][12], -1);
    PlayerTextDrawSetOutline(playerid, g_ptBank[playerid][12], 0);
    PlayerTextDrawSetProportional(playerid, g_ptBank[playerid][12], 1);
    PlayerTextDrawSetShadow(playerid, g_ptBank[playerid][12], 1);
    PlayerTextDrawSetSelectable(playerid, g_ptBank[playerid][12], 0);

    g_ptBank[playerid][13] = CreatePlayerTextDraw(playerid, 356.000000, 153.000000, "Informe a quantidade:");
    PlayerTextDrawAlignment(playerid, g_ptBank[playerid][13], 2);
    PlayerTextDrawBackgroundColor(playerid, g_ptBank[playerid][13], 255);
    PlayerTextDrawFont(playerid, g_ptBank[playerid][13], 2);
    PlayerTextDrawLetterSize(playerid, g_ptBank[playerid][13], 0.230000, 1.600000);
    PlayerTextDrawColor(playerid, g_ptBank[playerid][13], -1);
    PlayerTextDrawSetOutline(playerid, g_ptBank[playerid][13], 0);
    PlayerTextDrawSetProportional(playerid, g_ptBank[playerid][13], 1);
    PlayerTextDrawSetShadow(playerid, g_ptBank[playerid][13], 1);
    PlayerTextDrawSetSelectable(playerid, g_ptBank[playerid][13], 0);

    g_ptBank[playerid][14] = CreatePlayerTextDraw(playerid, 356.000000, 202.000000, "Informe a conta:");
    PlayerTextDrawAlignment(playerid, g_ptBank[playerid][14], 2);
    PlayerTextDrawBackgroundColor(playerid, g_ptBank[playerid][14], 255);
    PlayerTextDrawFont(playerid, g_ptBank[playerid][14], 2);
    PlayerTextDrawLetterSize(playerid, g_ptBank[playerid][14], 0.230000, 1.600000);
    PlayerTextDrawColor(playerid, g_ptBank[playerid][14], -1);
    PlayerTextDrawSetOutline(playerid, g_ptBank[playerid][14], 0);
    PlayerTextDrawSetProportional(playerid, g_ptBank[playerid][14], 1);
    PlayerTextDrawSetShadow(playerid, g_ptBank[playerid][14], 1);
    PlayerTextDrawSetSelectable(playerid, g_ptBank[playerid][14], 0);

    g_ptBank[playerid][15] = CreatePlayerTextDraw(playerid, 179.000000, 170.000000, "Sacar");
    PlayerTextDrawBackgroundColor(playerid, g_ptBank[playerid][15], 255);
    PlayerTextDrawFont(playerid, g_ptBank[playerid][15], 2);
    PlayerTextDrawLetterSize(playerid, g_ptBank[playerid][15], 0.400000, 1.700000);
    PlayerTextDrawColor(playerid, g_ptBank[playerid][15], -1);
    PlayerTextDrawSetOutline(playerid, g_ptBank[playerid][15], 0);
    PlayerTextDrawSetProportional(playerid, g_ptBank[playerid][15], 1);
    PlayerTextDrawSetShadow(playerid, g_ptBank[playerid][15], 1);
    PlayerTextDrawTextSize(playerid, g_ptBank[playerid][15], 235.000000, 25.000000);
    PlayerTextDrawSetSelectable(playerid, g_ptBank[playerid][15], 1);

    g_ptBank[playerid][16] = CreatePlayerTextDraw(playerid, 313.000000, 223.000000, "_");
    PlayerTextDrawBackgroundColor(playerid, g_ptBank[playerid][16], 255);
    PlayerTextDrawFont(playerid, g_ptBank[playerid][16], 1);
    PlayerTextDrawLetterSize(playerid, g_ptBank[playerid][16], 0.500000, 1.000000);
    PlayerTextDrawColor(playerid, g_ptBank[playerid][16], -1);
    PlayerTextDrawSetOutline(playerid, g_ptBank[playerid][16], 0);
    PlayerTextDrawSetProportional(playerid, g_ptBank[playerid][16], 1);
    PlayerTextDrawSetShadow(playerid, g_ptBank[playerid][16], 5);
    PlayerTextDrawUseBox(playerid, g_ptBank[playerid][16], 1);
    PlayerTextDrawBoxColor(playerid, g_ptBank[playerid][16], -1);
    PlayerTextDrawTextSize(playerid, g_ptBank[playerid][16], 399.000000, 0.000000);
    PlayerTextDrawSetSelectable(playerid, g_ptBank[playerid][16], 1);

    g_ptBank[playerid][17] = CreatePlayerTextDraw(playerid, 354.000000, 220.000000, "0000000");// Conta p/ transferencia
    PlayerTextDrawAlignment(playerid, g_ptBank[playerid][17], 2);
    PlayerTextDrawBackgroundColor(playerid, g_ptBank[playerid][17], 255);
    PlayerTextDrawFont(playerid, g_ptBank[playerid][17], 1);
    PlayerTextDrawLetterSize(playerid, g_ptBank[playerid][17], 0.290000, 1.500000);
    PlayerTextDrawColor(playerid, g_ptBank[playerid][17], 255);
    PlayerTextDrawSetOutline(playerid, g_ptBank[playerid][17], 0);
    PlayerTextDrawSetProportional(playerid, g_ptBank[playerid][17], 1);
    PlayerTextDrawSetShadow(playerid, g_ptBank[playerid][17], 0);
    PlayerTextDrawTextSize(playerid, g_ptBank[playerid][17], 25.0, 83.0);
    PlayerTextDrawSetSelectable(playerid, g_ptBank[playerid][17], 1);

    g_ptBank[playerid][18] = CreatePlayerTextDraw(playerid, 288.000000, 190.000000, ".");
    PlayerTextDrawBackgroundColor(playerid, g_ptBank[playerid][18], 255);
    PlayerTextDrawFont(playerid, g_ptBank[playerid][18], 1);
    PlayerTextDrawLetterSize(playerid, g_ptBank[playerid][18], 12.470011, 1.000000);
    PlayerTextDrawColor(playerid, g_ptBank[playerid][18], -1);
    PlayerTextDrawSetOutline(playerid, g_ptBank[playerid][18], 0);
    PlayerTextDrawSetProportional(playerid, g_ptBank[playerid][18], 1);
    PlayerTextDrawSetShadow(playerid, g_ptBank[playerid][18], 1);
    PlayerTextDrawSetSelectable(playerid, g_ptBank[playerid][18], 0);

    g_ptBank[playerid][19] = CreatePlayerTextDraw(playerid, 318.000000, 240.000000, "Favorecido:");
    PlayerTextDrawBackgroundColor(playerid, g_ptBank[playerid][19], 255);
    PlayerTextDrawFont(playerid, g_ptBank[playerid][19], 2);
    PlayerTextDrawLetterSize(playerid, g_ptBank[playerid][19], 0.290000, 1.600000);
    PlayerTextDrawColor(playerid, g_ptBank[playerid][19], -1);
    PlayerTextDrawSetOutline(playerid, g_ptBank[playerid][19], 0);
    PlayerTextDrawSetProportional(playerid, g_ptBank[playerid][19], 1);
    PlayerTextDrawSetShadow(playerid, g_ptBank[playerid][19], 1);
    PlayerTextDrawSetSelectable(playerid, g_ptBank[playerid][19], 0);

    g_ptBank[playerid][20] = CreatePlayerTextDraw(playerid, 356.000000, 255.000000, "_");// Favorecido nome
    PlayerTextDrawAlignment(playerid, g_ptBank[playerid][20], 2);
    PlayerTextDrawBackgroundColor(playerid, g_ptBank[playerid][20], 255);
    PlayerTextDrawFont(playerid, g_ptBank[playerid][20], 2);
    PlayerTextDrawLetterSize(playerid, g_ptBank[playerid][20], 0.210000, 1.399999);
    PlayerTextDrawColor(playerid, g_ptBank[playerid][20], -1);
    PlayerTextDrawSetOutline(playerid, g_ptBank[playerid][20], 0);
    PlayerTextDrawSetProportional(playerid, g_ptBank[playerid][20], 1);
    PlayerTextDrawSetShadow(playerid, g_ptBank[playerid][20], 1);
    PlayerTextDrawSetSelectable(playerid, g_ptBank[playerid][20], 0);

    new balance[32];
    format(balance, sizeof(balance), "Saldo: $%s", formatnumber(GetPlayerBankCash(playerid)));
    g_ptBank[playerid][21] = CreatePlayerTextDraw(playerid, 474.000000, 290.000000, balance);
    PlayerTextDrawAlignment(playerid, g_ptBank[playerid][21], 3);
    PlayerTextDrawBackgroundColor(playerid, g_ptBank[playerid][21], 255);
    PlayerTextDrawFont(playerid, g_ptBank[playerid][21], 2);
    PlayerTextDrawLetterSize(playerid, g_ptBank[playerid][21], 0.260000, 1.800000);
    PlayerTextDrawColor(playerid, g_ptBank[playerid][21], -1);
    PlayerTextDrawSetOutline(playerid, g_ptBank[playerid][21], 0);
    PlayerTextDrawSetProportional(playerid, g_ptBank[playerid][21], 1);
    PlayerTextDrawSetShadow(playerid, g_ptBank[playerid][21], 1);
    PlayerTextDrawSetSelectable(playerid, g_ptBank[playerid][21], 0);

    g_ptBank[playerid][22] = CreatePlayerTextDraw(playerid, 250.000000, 160.000000, "_");
    PlayerTextDrawBackgroundColor(playerid, g_ptBank[playerid][22], 255);
    PlayerTextDrawFont(playerid, g_ptBank[playerid][22], 1);
    PlayerTextDrawLetterSize(playerid, g_ptBank[playerid][22], 0.500000, 1.900002);
    PlayerTextDrawColor(playerid, g_ptBank[playerid][22], -129);
    PlayerTextDrawSetOutline(playerid, g_ptBank[playerid][22], 0);
    PlayerTextDrawSetProportional(playerid, g_ptBank[playerid][22], 1);
    PlayerTextDrawSetShadow(playerid, g_ptBank[playerid][22], 1);
    PlayerTextDrawUseBox(playerid, g_ptBank[playerid][22], 1);
    PlayerTextDrawBoxColor(playerid, g_ptBank[playerid][22], 64);
    PlayerTextDrawTextSize(playerid, g_ptBank[playerid][22], 163.000000, 0.000000);
    PlayerTextDrawSetSelectable(playerid, g_ptBank[playerid][22], 0);

    for(new i = 0; i < sizeof(g_ptBank[]); i++)
        PlayerTextDrawShow(playerid, g_ptBank[playerid][i]);

    ShowPlayerKeypad(playerid);
    return 1;
}

//------------------------------------------------------------------------------

HidePlayerBankTextDraw(playerid)
{
    if(!g_isVisible[playerid])
        return 1;

    for(new i = 0; i < sizeof(g_ptBank[]); i++)
        PlayerTextDrawDestroy(playerid, g_ptBank[playerid][i]);
    return 1;
}

//------------------------------------------------------------------------------
