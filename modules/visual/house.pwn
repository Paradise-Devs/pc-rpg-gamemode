/* *************************************************************************** *
*  Description: Apartment visual module file.
*
*  Assignment: A script to handle house textdraws.
*
*           Copyright Paradise Devs 2015.  All rights reserved.
* *************************************************************************** */

#include <YSI\y_hooks>
new PlayerText:gpt_House[MAX_PLAYERS][33];

/* Shows house dialog for a player */
ShowPlayerHouseTD(playerid, houseid)
{
	if(GetPVarInt(playerid, "gptIsVisible"))
		return 1;

	SetPVarInt(playerid, "gptType", 2);
	SetPVarInt(playerid, "gptIsVisible", 1);
	SetPVarInt(playerid, "gptPropID", houseid);

	new bool:islocked = false;
	new bool:isowned = false;
	new bool:isowner = false;
	new bool:isrentable = false;
	if(gHouseData[houseid][E_HOUSE_LOCKED]) islocked = true;
	if(gHouseData[houseid][E_HOUSE_OWNED]) isowned = true;
	if(gHouseData[houseid][E_HOUSE_RENTABLE]) isrentable = true;
	if(GetPlayerHouseID(playerid) == houseid) isowner = true;
	new sInfo[64];

	for (new i = 0; i < sizeof(gpt_House[]); i++) {
		gpt_House[playerid][i] = PlayerText:INVALID_TEXT_DRAW;
	}

	if(!isowned) {
		gpt_House[playerid][0] = CreatePlayerTextDraw(playerid, 499.333526, 119.510978, "_");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][0], 0.680666, 13.388413);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][0], 632.453674, 0.000000);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][0], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][0], -1);
		PlayerTextDrawUseBox(playerid, gpt_House[playerid][0], 1);
		PlayerTextDrawBoxColor(playerid, gpt_House[playerid][0], 61);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][0], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][0], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][0], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][0], 2);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][0], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][0], 0);

		gpt_House[playerid][1] = CreatePlayerTextDraw(playerid, 500.250061, 121.120323, "box");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][1], 0.000000, 1.845671);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][1], 631.486328, 0.000000);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][1], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][1], -1);
		PlayerTextDrawUseBox(playerid, gpt_House[playerid][1], 1);
		PlayerTextDrawBoxColor(playerid, gpt_House[playerid][1], 69);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][1], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][1], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][1], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][1], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][1], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][1], 0);

		gpt_House[playerid][2] = CreatePlayerTextDraw(playerid, 500.250061, 141.821578, "box");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][2], 0.000000, 7.578680);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][2], 631.426086, 0.000000);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][2], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][2], -1);
		PlayerTextDrawUseBox(playerid, gpt_House[playerid][2], 1);
		PlayerTextDrawBoxColor(playerid, gpt_House[playerid][2], 69);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][2], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][2], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][2], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][2], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][2], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][2], 0);

		gpt_House[playerid][3] = CreatePlayerTextDraw(playerid, 496.399902, 118.640647, "");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][3], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][3], 21.666633, 21.970375);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][3], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][3], -1258291202);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][3], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][3], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][3], 0);
		PlayerTextDrawFont(playerid, gpt_House[playerid][3], 5);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][3], 0);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][3], 0);
		PlayerTextDrawSetPreviewModel(playerid, gpt_House[playerid][3], 1273);
		PlayerTextDrawSetPreviewRot(playerid, gpt_House[playerid][3], 0.000000, 0.000000, 0.000000, 1.000000);

		gpt_House[playerid][4] = CreatePlayerTextDraw(playerid, 500.933563, 182.984573, "- Status:");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][4], 0.211998, 1.147850);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][4], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][4], -1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][4], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][4], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][4], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][4], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][4], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][4], 0);

		gpt_House[playerid][5] = CreatePlayerTextDraw(playerid, 518.150207, 124.568435, "Casa a venda");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][5], 0.238333, 1.002665);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][5], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][5], 8388863);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][5], 1);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][5], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][5], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][5], 3);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][5], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][5], 1);

		gpt_House[playerid][6] = CreatePlayerTextDraw(playerid, 500.784240, 143.646331, "- Comodos:");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][6], 0.211998, 1.147850);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][6], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][6], -1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][6], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][6], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][6], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][6], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][6], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][6], 0);

		format(sInfo, sizeof(sInfo), "%i", houseid);
		gpt_House[playerid][7] = CreatePlayerTextDraw(playerid, 619.986267, 124.203620, sInfo);
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][7], 0.238333, 1.002665);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][7], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][7], -173);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][7], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][7], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][7], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][7], 3);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][7], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][7], 0);

		gpt_House[playerid][8] = CreatePlayerTextDraw(playerid, 500.600219, 156.532958, "- Camas:");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][8], 0.211998, 1.147850);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][8], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][8], -1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][8], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][8], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][8], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][8], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][8], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][8], 0);

		gpt_House[playerid][9] = CreatePlayerTextDraw(playerid, 500.933563, 169.833770, "- Local:");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][9], 0.211998, 1.147850);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][9], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][9], -1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][9], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][9], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][9], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][9], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][9], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][9], 0);

		gpt_House[playerid][10] = CreatePlayerTextDraw(playerid, 500.933563, 196.485397, "- Garagem:");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][10], 0.211998, 1.147850);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][10], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][10], -1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][10], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][10], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][10], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][10], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][10], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][10], 0);

		format(sInfo, sizeof(sInfo), "%i", gHouseData[houseid][E_HOUSE_ROOMS]);
		gpt_House[playerid][11] = CreatePlayerTextDraw(playerid, 630.755920, 143.231521, sInfo);
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][11], 0.211998, 1.147850);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][11], 3);
		PlayerTextDrawColor(playerid, gpt_House[playerid][11], -134);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][11], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][11], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][11], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][11], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][11], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][11], 0);

		gpt_House[playerid][12] = CreatePlayerTextDraw(playerid, 500.099945, 214.299957, "box");// botão comprar
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][12], 0.000000, 2.712661);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][12], 563.745605, 25.000000);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][12], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][12], -1);
		PlayerTextDrawUseBox(playerid, gpt_House[playerid][12], 1);
		PlayerTextDrawBoxColor(playerid, gpt_House[playerid][12], 8388682);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][12], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][12], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][12], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][12], 2);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][12], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][12], 0);
		PlayerTextDrawSetSelectable(playerid, gpt_House[playerid][12], true);

		format(sInfo, sizeof(sInfo), "%i", gHouseData[houseid][E_HOUSE_BEDS]);
		gpt_House[playerid][13] = CreatePlayerTextDraw(playerid, 630.789306, 156.491531, sInfo);
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][13], 0.211998, 1.147850);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][13], 3);
		PlayerTextDrawColor(playerid, gpt_House[playerid][13], -134);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][13], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][13], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][13], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][13], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][13], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][13], 0);

		gpt_House[playerid][14] = CreatePlayerTextDraw(playerid, 630.956115, 169.733139, gHouseData[houseid][E_HOUSE_LOCATION]);
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][14], 0.211998, 1.147850);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][14], 3);
		PlayerTextDrawColor(playerid, gpt_House[playerid][14], -134);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][14], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][14], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][14], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][14], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][14], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][14], 0);

		if(islocked) format(sInfo, sizeof(sInfo), "Trancada");
		else format(sInfo, sizeof(sInfo), "Aberta");
		gpt_House[playerid][15] = CreatePlayerTextDraw(playerid, 630.956115, 183.033950, sInfo);
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][15], 0.211998, 1.147850);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][15], 3);
		PlayerTextDrawColor(playerid, gpt_House[playerid][15], -1523766279);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][15], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][15], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][15], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][15], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][15], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][15], 0);

		format(sInfo, sizeof(sInfo), "%i", gHouseData[houseid][E_HOUSE_GARAGE]);
		gpt_House[playerid][16] = CreatePlayerTextDraw(playerid, 630.956115, 196.834793, sInfo);
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][16], 0.211998, 1.147850);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][16], 3);
		PlayerTextDrawColor(playerid, gpt_House[playerid][16], -1061109505);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][16], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][16], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][16], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][16], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][16], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][16], 0);

		gpt_House[playerid][17] = CreatePlayerTextDraw(playerid, 567.499877, 214.199890, "box");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][17], 0.000000, 2.712661);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][17], 631.561645, 25.000000);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][17], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][17], -1);
		PlayerTextDrawUseBox(playerid, gpt_House[playerid][17], 1);
		PlayerTextDrawBoxColor(playerid, gpt_House[playerid][17], (islocked) ? 2139062272 : -293376257);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][17], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][17], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][17], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][17], 2);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][17], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][17], 0);
		PlayerTextDrawSetSelectable(playerid, gpt_House[playerid][17], true);

		gpt_House[playerid][18] = CreatePlayerTextDraw(playerid, 500.200012, 214.200012, "box");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][18], 0.000000, 1.254999);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][18], 563.718200, 0.000000);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][18], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][18], -1);
		PlayerTextDrawUseBox(playerid, gpt_House[playerid][18], 1);
		PlayerTextDrawBoxColor(playerid, gpt_House[playerid][18], -230);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][18], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][18], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][18], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][18], 2);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][18], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][18], 0);

		gpt_House[playerid][19] = CreatePlayerTextDraw(playerid, 493.000122, 215.562957, "");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][19], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][19], 28.666673, 21.140745);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][19], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][19], -3);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][19], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][19], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][19], 0);
		PlayerTextDrawFont(playerid, gpt_House[playerid][19], 5);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][19], 0);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][19], 0);
		PlayerTextDrawSetPreviewModel(playerid, gpt_House[playerid][19], 1274);
		PlayerTextDrawSetPreviewRot(playerid, gpt_House[playerid][19], 0.000000, 0.000000, 180.000000, 1.000000);

		gpt_House[playerid][20] = CreatePlayerTextDraw(playerid, 516.999938, 215.303680, "Comprar");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][20], 0.219330, 1.309628);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][20], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][20], -1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][20], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][20], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][20], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][20], 2);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][20], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][20], 0);

		format(sInfo, sizeof(sInfo), "$%i", gHouseData[houseid][E_HOUSE_PRICE]);
		gpt_House[playerid][21] = CreatePlayerTextDraw(playerid, 516.999755, 227.200012, sInfo);
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][21], 0.170000, 0.766222);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][21], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][21], -146);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][21], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][21], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][21], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][21], 2);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][21], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][21], 0);

		gpt_House[playerid][22] = CreatePlayerTextDraw(playerid, 567.399902, 214.200012, "box");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][22], 0.000000, 1.267994);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][22], 631.023376, 0.000000);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][22], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][22], -1);
		PlayerTextDrawUseBox(playerid, gpt_House[playerid][22], 1);
		PlayerTextDrawBoxColor(playerid, gpt_House[playerid][22], -226);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][22], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][22], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][22], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][22], 2);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][22], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][22], 0);

		gpt_House[playerid][23] = CreatePlayerTextDraw(playerid, 586.000000, 218.499969, "Entrar");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][23], 0.240333, 1.525333);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][23], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][23], -156);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][23], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][23], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][23], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][23], 2);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][23], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][23], 0);

		gpt_House[playerid][24] = CreatePlayerTextDraw(playerid, 563.000000, 234.000000, "");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][24], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][24], 25.450029, -18.016265);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][24], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][24], -180);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][24], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][24], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][24], 0);
		PlayerTextDrawFont(playerid, gpt_House[playerid][24], 5);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][24], 0);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][24], 0);
		PlayerTextDrawSetPreviewModel(playerid, gpt_House[playerid][24], 1318);
		PlayerTextDrawSetPreviewRot(playerid, gpt_House[playerid][24], 0.000000, 0.000000, 90.000000, 1.000000);

		gpt_House[playerid][25] = CreatePlayerTextDraw(playerid, 628.000000, 111.400009, "box");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][25], 0.000000, 0.566663);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][25], 632.666625, 0.000000);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][25], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][25], -1);
		PlayerTextDrawUseBox(playerid, gpt_House[playerid][25], 1);
		PlayerTextDrawBoxColor(playerid, gpt_House[playerid][25], 58);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][25], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][25], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][25], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][25], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][25], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][25], 0);

		gpt_House[playerid][26] = CreatePlayerTextDraw(playerid, 627.199951, 109.399993, "X");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][26], 0.257999, 0.948740);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][26], 637.599951, 10.000);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][26], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][26], -16776961);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][26], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][26], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][26], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][26], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][26], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][26], 0);
		PlayerTextDrawSetSelectable(playerid, gpt_House[playerid][26], true);

		gpt_House[playerid][27] = CreatePlayerTextDraw(playerid, 567.299926, 243.400024, "box");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][27], 0.000000, 0.966665);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][27], 632.632934, 0.000000);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][27], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][27], -1);
		PlayerTextDrawUseBox(playerid, gpt_House[playerid][27], 1);
		PlayerTextDrawBoxColor(playerid, gpt_House[playerid][27], 56);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][27], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][27], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][27], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][27], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][27], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][27], 0);

		gpt_House[playerid][28] = CreatePlayerTextDraw(playerid, 568.200195, 243.200012, "box");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][28], 0.000000, 0.841333);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][28], 631.479064, 7.5);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][28], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][28], -5963521);
		PlayerTextDrawUseBox(playerid, gpt_House[playerid][28], 1);
		PlayerTextDrawBoxColor(playerid, gpt_House[playerid][28], -1378294188);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][28], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][28], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][28], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][28], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][28], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][28], 0);
		PlayerTextDrawSetSelectable(playerid, gpt_House[playerid][28], true);

		gpt_House[playerid][29] = CreatePlayerTextDraw(playerid, 568.200195, 243.200012, "box");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][29], 0.000000, 0.141333);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][29], 631.479064, 7.5);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][29], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][29], -5963521);
		PlayerTextDrawUseBox(playerid, gpt_House[playerid][29], 1);
		PlayerTextDrawBoxColor(playerid, gpt_House[playerid][29], -226);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][29], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][29], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][29], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][29], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][29], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][29], 0);

		gpt_House[playerid][30] = CreatePlayerTextDraw(playerid, 573.598632, 243.000000, "Administrar casa");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][30], 0.134664, 0.741333);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][30], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][30], -1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][30], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][30], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][30], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][30], 2);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][30], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][30], 0);

		gpt_House[playerid][31] = CreatePlayerTextDraw(playerid, 567.499877, 214.199890, "box");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][31], 0.000000, 2.712661);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][31], 631.561645, 0.000000);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][31], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][31], -1);
		PlayerTextDrawUseBox(playerid, gpt_House[playerid][31], 1);
		PlayerTextDrawBoxColor(playerid, gpt_House[playerid][31], -2139062272);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][31], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][31], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][31], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][31], 2);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][31], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][31], 0);
	}
	else if(!isowner && !isrentable && isowned) {
		gpt_House[playerid][0] = CreatePlayerTextDraw(playerid, 499.300018, 119.799972, "_");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][0], 0.708665, 14.914935);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][0], 632.474609, 0.029999);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][0], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][0], -1);
		PlayerTextDrawUseBox(playerid, gpt_House[playerid][0], 1);
		PlayerTextDrawBoxColor(playerid, gpt_House[playerid][0], 61);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][0], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][0], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][0], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][0], 2);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][0], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][0], 0);

		gpt_House[playerid][1] = CreatePlayerTextDraw(playerid, 500.250061, 121.120323, "box");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][1], -0.001333, 1.853966);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][1], 631.486328, 0.000000);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][1], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][1], -1);
		PlayerTextDrawUseBox(playerid, gpt_House[playerid][1], 1);
		PlayerTextDrawBoxColor(playerid, gpt_House[playerid][1], 69);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][1], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][1], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][1], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][1], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][1], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][1], 0);

		gpt_House[playerid][2] = CreatePlayerTextDraw(playerid, 500.250061, 141.821578, "box");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][2], -0.003665, 9.062238);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][2], 631.552246, 0.000000);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][2], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][2], -1);
		PlayerTextDrawUseBox(playerid, gpt_House[playerid][2], 1);
		PlayerTextDrawBoxColor(playerid, gpt_House[playerid][2], 69);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][2], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][2], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][2], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][2], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][2], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][2], 0);

		gpt_House[playerid][3] = CreatePlayerTextDraw(playerid, 496.399902, 118.640647, "");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][3], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][3], 21.666633, 21.970375);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][3], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][3], -1258291202);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][3], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][3], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][3], 0);
		PlayerTextDrawFont(playerid, gpt_House[playerid][3], 5);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][3], 0);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][3], 0);
		PlayerTextDrawSetPreviewModel(playerid, gpt_House[playerid][3], 1273);
		PlayerTextDrawSetPreviewRot(playerid, gpt_House[playerid][3], 0.000000, 0.000000, 0.000000, 1.000000);

		gpt_House[playerid][4] = CreatePlayerTextDraw(playerid, 500.933563, 182.984573, "- Status:");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][4], 0.211998, 1.147850);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][4], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][4], -1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][4], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][4], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][4], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][4], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][4], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][4], 0);

		format(sInfo, sizeof(sInfo), "Casa de %s", GetFirstName(gHouseData[houseid][E_HOUSE_OWNER]));
		gpt_House[playerid][5] = CreatePlayerTextDraw(playerid, 518.150207, 124.568435, sInfo);
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][5], 0.238333, 1.002665);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][5], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][5], -1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][5], 1);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][5], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][5], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][5], 3);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][5], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][5], 1);

		gpt_House[playerid][6] = CreatePlayerTextDraw(playerid, 500.784240, 143.646331, "- Comodos:");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][6], 0.211998, 1.147850);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][6], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][6], -1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][6], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][6], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][6], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][6], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][6], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][6], 0);

		format(sInfo, sizeof(sInfo), "%i", houseid);
		gpt_House[playerid][7] = CreatePlayerTextDraw(playerid, 619.986267, 124.203620, sInfo);
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][7], 0.238333, 1.002665);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][7], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][7], -173);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][7], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][7], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][7], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][7], 3);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][7], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][7], 0);

		gpt_House[playerid][8] = CreatePlayerTextDraw(playerid, 500.600219, 156.532958, "- Camas:");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][8], 0.211998, 1.147850);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][8], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][8], -1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][8], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][8], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][8], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][8], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][8], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][8], 0);

		gpt_House[playerid][9] = CreatePlayerTextDraw(playerid, 500.933563, 169.833770, "- Local:");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][9], 0.211998, 1.147850);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][9], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][9], -1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][9], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][9], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][9], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][9], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][9], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][9], 0);

		gpt_House[playerid][10] = CreatePlayerTextDraw(playerid, 500.933563, 196.485397, "- Garagem:");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][10], 0.211998, 1.147850);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][10], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][10], -1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][10], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][10], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][10], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][10], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][10], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][10], 0);

		format(sInfo, sizeof(sInfo), "%i", gHouseData[houseid][E_HOUSE_ROOMS]);
		gpt_House[playerid][11] = CreatePlayerTextDraw(playerid, 630.755920, 143.231521, sInfo);
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][11], 0.211998, 1.147850);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][11], 3);
		PlayerTextDrawColor(playerid, gpt_House[playerid][11], -134);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][11], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][11], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][11], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][11], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][11], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][11], 0);

		gpt_House[playerid][12] = CreatePlayerTextDraw(playerid, 500.599975, 228.000000, "box");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][12], 0.000000, 2.712661);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][12], 563.745605, 25.000000);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][12], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][12], 16777215);
		PlayerTextDrawUseBox(playerid, gpt_House[playerid][12], 1);
		PlayerTextDrawBoxColor(playerid, gpt_House[playerid][12], -2139062193);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][12], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][12], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][12], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][12], 2);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][12], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][12], 0);
		PlayerTextDrawSetSelectable(playerid, gpt_House[playerid][12], true);

		format(sInfo, sizeof(sInfo), "%i", gHouseData[houseid][E_HOUSE_BEDS]);
		gpt_House[playerid][13] = CreatePlayerTextDraw(playerid, 630.789306, 156.491531, sInfo);
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][13], 0.211998, 1.147850);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][13], 3);
		PlayerTextDrawColor(playerid, gpt_House[playerid][13], -134);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][13], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][13], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][13], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][13], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][13], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][13], 0);

		gpt_House[playerid][14] = CreatePlayerTextDraw(playerid, 630.956115, 169.733139, gHouseData[houseid][E_HOUSE_LOCATION]);
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][14], 0.211998, 1.147850);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][14], 3);
		PlayerTextDrawColor(playerid, gpt_House[playerid][14], -134);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][14], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][14], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][14], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][14], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][14], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][14], 0);

		if(islocked) format(sInfo, sizeof(sInfo), "Trancada");
		else format(sInfo, sizeof(sInfo), "Aberta");
		gpt_House[playerid][15] = CreatePlayerTextDraw(playerid, 630.956115, 183.033950, sInfo);
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][15], 0.211998, 1.147850);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][15], 3);
		PlayerTextDrawColor(playerid, gpt_House[playerid][15], -1523766279);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][15], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][15], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][15], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][15], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][15], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][15], 0);

		format(sInfo, sizeof(sInfo), "%i", gHouseData[houseid][E_HOUSE_GARAGE]);
		gpt_House[playerid][16] = CreatePlayerTextDraw(playerid, 630.956115, 196.834793, sInfo);
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][16], 0.211998, 1.147850);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][16], 3);
		PlayerTextDrawColor(playerid, gpt_House[playerid][16], -1061109505);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][16], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][16], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][16], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][16], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][16], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][16], 0);

		gpt_House[playerid][17] = CreatePlayerTextDraw(playerid, 568.000000, 228.000000, "box");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][17], 0.000000, 2.701623);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][17], 631.561645, 25.000000);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][17], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][17], -1);
		PlayerTextDrawUseBox(playerid, gpt_House[playerid][17], 1);
		PlayerTextDrawBoxColor(playerid, gpt_House[playerid][17], (islocked) ? 2139062272 : -293376257);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][17], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][17], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][17], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][17], 2);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][17], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][17], 0);
		PlayerTextDrawSetSelectable(playerid, gpt_House[playerid][17], true);

		gpt_House[playerid][18] = CreatePlayerTextDraw(playerid, 500.500152, 228.100006, "box");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][18], 0.000000, 1.254999);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][18], 563.552917, 0.000000);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][18], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][18], -1);
		PlayerTextDrawUseBox(playerid, gpt_House[playerid][18], 1);
		PlayerTextDrawBoxColor(playerid, gpt_House[playerid][18], -230);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][18], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][18], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][18], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][18], 2);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][18], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][18], 0);

		gpt_House[playerid][19] = CreatePlayerTextDraw(playerid, 500.000000, 226.000000, "");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][19], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][19], 16.000007, 26.118515);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][19], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][19], -3);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][19], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][19], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][19], 0);
		PlayerTextDrawFont(playerid, gpt_House[playerid][19], 5);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][19], 0);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][19], 0);
		PlayerTextDrawSetPreviewModel(playerid, gpt_House[playerid][19], 14866);
		PlayerTextDrawSetPreviewRot(playerid, gpt_House[playerid][19], 180.000000, 180.000000, -90.000000, 1.000000);

		gpt_House[playerid][20] = CreatePlayerTextDraw(playerid, 517.799804, 229.800048, "alugar");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][20], 0.219328, 1.309628);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][20], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][20], -144);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][20], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][20], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][20], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][20], 2);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][20], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][20], 0);

		gpt_House[playerid][21] = CreatePlayerTextDraw(playerid, 518.000000, 241.000000, "N/A");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][21], 0.170000, 0.766222);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][21], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][21], -146);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][21], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][21], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][21], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][21], 2);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][21], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][21], 0);

		gpt_House[playerid][22] = CreatePlayerTextDraw(playerid, 567.899536, 228.000061, "box");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][22], 0.000000, 1.267994);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][22], 631.571533, 0.000000);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][22], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][22], -1);
		PlayerTextDrawUseBox(playerid, gpt_House[playerid][22], 1);
		PlayerTextDrawBoxColor(playerid, gpt_House[playerid][22], -226);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][22], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][22], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][22], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][22], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][22], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][22], 0);

		gpt_House[playerid][23] = CreatePlayerTextDraw(playerid, 584.701049, 231.699981, "Entrar");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][23], 0.240333, 1.525333);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][23], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][23], -156);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][23], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][23], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][23], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][23], 2);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][23], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][23], 0);

		gpt_House[playerid][24] = CreatePlayerTextDraw(playerid, 562.600097, 248.199951, "");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][24], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][24], 25.450029, -18.016265);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][24], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][24], -180);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][24], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][24], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][24], 0);
		PlayerTextDrawFont(playerid, gpt_House[playerid][24], 5);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][24], 0);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][24], 0);
		PlayerTextDrawSetPreviewModel(playerid, gpt_House[playerid][24], 1318);
		PlayerTextDrawSetPreviewRot(playerid, gpt_House[playerid][24], 0.000000, 0.000000, 90.000000, 1.000000);

		gpt_House[playerid][25] = CreatePlayerTextDraw(playerid, 627.799072, 111.299995, "box");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][25], 0.000000, 0.566663);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][25], 632.465698, 0.000000);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][25], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][25], -1);
		PlayerTextDrawUseBox(playerid, gpt_House[playerid][25], 1);
		PlayerTextDrawBoxColor(playerid, gpt_House[playerid][25], 58);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][25], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][25], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][25], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][25], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][25], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][25], 0);

		gpt_House[playerid][26] = CreatePlayerTextDraw(playerid, 627.199951, 109.399993, "X");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][26], 0.257999, 0.948740);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][26], 637.599951, 10.000);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][26], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][26], -16776961);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][26], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][26], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][26], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][26], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][26], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][26], 0);
		PlayerTextDrawSetSelectable(playerid, gpt_House[playerid][26], true);

		gpt_House[playerid][27] = CreatePlayerTextDraw(playerid, 567.000488, 257.500030, "box");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][27], 0.000000, 0.966665);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][27], 632.448242, 0.000000);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][27], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][27], -1);
		PlayerTextDrawUseBox(playerid, gpt_House[playerid][27], 1);
		PlayerTextDrawBoxColor(playerid, gpt_House[playerid][27], 56);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][27], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][27], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][27], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][27], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][27], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][27], 0);

		gpt_House[playerid][28] = CreatePlayerTextDraw(playerid, 568.300170, 257.199951, "box");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][28], 0.000000, 0.820331);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][28], 631.479064, 7.5);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][28], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][28], -5963521);
		PlayerTextDrawUseBox(playerid, gpt_House[playerid][28], 1);
		PlayerTextDrawBoxColor(playerid, gpt_House[playerid][28], -1378294188);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][28], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][28], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][28], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][28], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][28], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][28], 0);
		PlayerTextDrawSetSelectable(playerid, gpt_House[playerid][28], true);

		gpt_House[playerid][29] = CreatePlayerTextDraw(playerid, 568.299926, 258.000000, "box");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][29], 0.000000, 0.141332);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][29], 631.545654, 0.000000);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][29], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][29], -5963521);
		PlayerTextDrawUseBox(playerid, gpt_House[playerid][29], 1);
		PlayerTextDrawBoxColor(playerid, gpt_House[playerid][29], -226);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][29], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][29], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][29], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][29], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][29], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][29], 0);

		gpt_House[playerid][30] = CreatePlayerTextDraw(playerid, 573.399902, 257.000000, "Administrar casa");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][30], 0.134663, 0.741333);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][30], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][30], -1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][30], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][30], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][30], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][30], 2);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][30], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][30], 0);

		gpt_House[playerid][31] = CreatePlayerTextDraw(playerid, 500.933563, 209.986221, "- Aluguel:");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][31], 0.211998, 1.147850);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][31], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][31], -1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][31], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][31], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][31], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][31], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][31], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][31], 0);

		gpt_House[playerid][32] = CreatePlayerTextDraw(playerid, 631.256042, 210.135604, "Desabilitado");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][32], 0.211998, 1.147850);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][32], 3);
		PlayerTextDrawColor(playerid, gpt_House[playerid][32], -1523963138);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][32], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][32], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][32], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][32], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][32], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][32], 0);
	}
	else if(!isowner && isrentable && isowned) {
		gpt_House[playerid][0] = CreatePlayerTextDraw(playerid, 499.300018, 119.799972, "_");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][0], 0.708665, 14.914935);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][0], 632.474609, 0.030000);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][0], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][0], -1);
		PlayerTextDrawUseBox(playerid, gpt_House[playerid][0], 1);
		PlayerTextDrawBoxColor(playerid, gpt_House[playerid][0], 61);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][0], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][0], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][0], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][0], 2);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][0], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][0], 0);

		gpt_House[playerid][1] = CreatePlayerTextDraw(playerid, 500.250061, 121.120323, "box");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][1], -0.001333, 1.853967);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][1], 631.486328, 0.000000);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][1], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][1], -1);
		PlayerTextDrawUseBox(playerid, gpt_House[playerid][1], 1);
		PlayerTextDrawBoxColor(playerid, gpt_House[playerid][1], 69);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][1], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][1], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][1], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][1], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][1], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][1], 0);

		gpt_House[playerid][2] = CreatePlayerTextDraw(playerid, 500.250061, 141.821578, "box");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][2], -0.003666, 9.062239);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][2], 631.552246, 0.000000);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][2], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][2], -1);
		PlayerTextDrawUseBox(playerid, gpt_House[playerid][2], 1);
		PlayerTextDrawBoxColor(playerid, gpt_House[playerid][2], 69);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][2], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][2], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][2], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][2], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][2], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][2], 0);

		gpt_House[playerid][3] = CreatePlayerTextDraw(playerid, 496.399902, 118.640647, "");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][3], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][3], 21.666633, 21.970375);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][3], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][3], -1258291202);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][3], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][3], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][3], 0);
		PlayerTextDrawFont(playerid, gpt_House[playerid][3], 5);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][3], 0);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][3], 0);
		PlayerTextDrawSetPreviewModel(playerid, gpt_House[playerid][3], 1273);
		PlayerTextDrawSetPreviewRot(playerid, gpt_House[playerid][3], 0.000000, 0.000000, 0.000000, 1.000000);

		gpt_House[playerid][4] = CreatePlayerTextDraw(playerid, 500.933563, 182.984573, "- Status:");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][4], 0.211998, 1.147850);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][4], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][4], -1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][4], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][4], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][4], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][4], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][4], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][4], 0);

		format(sInfo, sizeof(sInfo), "Casa de %s", GetFirstName(gHouseData[houseid][E_HOUSE_OWNER]));
		gpt_House[playerid][5] = CreatePlayerTextDraw(playerid, 518.150207, 124.568435, sInfo);
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][5], 0.238333, 1.002665);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][5], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][5], -1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][5], 1);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][5], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][5], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][5], 3);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][5], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][5], 1);

		gpt_House[playerid][6] = CreatePlayerTextDraw(playerid, 500.784240, 143.646331, "- Comodos:");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][6], 0.211998, 1.147850);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][6], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][6], -1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][6], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][6], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][6], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][6], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][6], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][6], 0);

		format(sInfo, sizeof(sInfo), "%i", houseid);
		gpt_House[playerid][7] = CreatePlayerTextDraw(playerid, 619.986267, 124.203620, sInfo);
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][7], 0.238333, 1.002665);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][7], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][7], -173);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][7], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][7], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][7], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][7], 3);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][7], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][7], 0);

		gpt_House[playerid][8] = CreatePlayerTextDraw(playerid, 500.600219, 156.532958, "- Camas:");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][8], 0.211998, 1.147850);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][8], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][8], -1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][8], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][8], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][8], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][8], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][8], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][8], 0);

		gpt_House[playerid][9] = CreatePlayerTextDraw(playerid, 500.933563, 169.833770, "- Local:");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][9], 0.211998, 1.147850);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][9], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][9], -1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][9], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][9], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][9], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][9], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][9], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][9], 0);

		gpt_House[playerid][10] = CreatePlayerTextDraw(playerid, 500.933563, 196.485397, "- Garagem:");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][10], 0.211998, 1.147850);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][10], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][10], -1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][10], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][10], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][10], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][10], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][10], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][10], 0);

		format(sInfo, sizeof(sInfo), "%i", gHouseData[houseid][E_HOUSE_ROOMS]);
		gpt_House[playerid][11] = CreatePlayerTextDraw(playerid, 630.755920, 143.231521, sInfo);
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][11], 0.211998, 1.147850);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][11], 3);
		PlayerTextDrawColor(playerid, gpt_House[playerid][11], -134);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][11], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][11], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][11], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][11], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][11], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][11], 0);

		gpt_House[playerid][12] = CreatePlayerTextDraw(playerid, 500.599975, 228.000000, "box");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][12], 0.000000, 2.712661);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][12], 563.745605, 25.000000);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][12], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][12], 16777215);
		PlayerTextDrawUseBox(playerid, gpt_House[playerid][12], 1);
		PlayerTextDrawBoxColor(playerid, gpt_House[playerid][12], 8060923);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][12], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][12], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][12], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][12], 2);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][12], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][12], 0);
		PlayerTextDrawSetSelectable(playerid, gpt_House[playerid][12], true);

		format(sInfo, sizeof(sInfo), "%i", gHouseData[houseid][E_HOUSE_BEDS]);
		gpt_House[playerid][13] = CreatePlayerTextDraw(playerid, 630.789306, 156.491531, sInfo);
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][13], 0.211998, 1.147850);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][13], 3);
		PlayerTextDrawColor(playerid, gpt_House[playerid][13], -134);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][13], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][13], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][13], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][13], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][13], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][13], 0);

		gpt_House[playerid][14] = CreatePlayerTextDraw(playerid, 630.956115, 169.733139, gHouseData[houseid][E_HOUSE_LOCATION]);
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][14], 0.211998, 1.147850);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][14], 3);
		PlayerTextDrawColor(playerid, gpt_House[playerid][14], -134);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][14], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][14], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][14], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][14], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][14], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][14], 0);

		if(islocked) format(sInfo, sizeof(sInfo), "Trancada");
		else format(sInfo, sizeof(sInfo), "Aberta");
		gpt_House[playerid][15] = CreatePlayerTextDraw(playerid, 630.956115, 183.033950, sInfo);
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][15], 0.211998, 1.147850);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][15], 3);
		PlayerTextDrawColor(playerid, gpt_House[playerid][15], -1523766279);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][15], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][15], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][15], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][15], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][15], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][15], 0);

		format(sInfo, sizeof(sInfo), "%i", gHouseData[houseid][E_HOUSE_GARAGE]);
		gpt_House[playerid][16] = CreatePlayerTextDraw(playerid, 630.956115, 196.834793, sInfo);
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][16], 0.211998, 1.147850);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][16], 3);
		PlayerTextDrawColor(playerid, gpt_House[playerid][16], -1061109505);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][16], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][16], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][16], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][16], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][16], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][16], 0);

		gpt_House[playerid][17] = CreatePlayerTextDraw(playerid, 568.000000, 228.000000, "box");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][17], 0.000000, 2.701624);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][17], 631.561645, 25.000000);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][17], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][17], -1);
		PlayerTextDrawUseBox(playerid, gpt_House[playerid][17], 1);
		PlayerTextDrawBoxColor(playerid, gpt_House[playerid][17], (islocked) ? 2139062272 : -293376257);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][17], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][17], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][17], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][17], 2);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][17], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][17], 0);
		PlayerTextDrawSetSelectable(playerid, gpt_House[playerid][17], true);

		gpt_House[playerid][18] = CreatePlayerTextDraw(playerid, 500.500152, 228.100006, "box");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][18], 0.000000, 1.254999);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][18], 563.552917, 0.000000);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][18], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][18], -1);
		PlayerTextDrawUseBox(playerid, gpt_House[playerid][18], 1);
		PlayerTextDrawBoxColor(playerid, gpt_House[playerid][18], -230);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][18], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][18], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][18], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][18], 2);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][18], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][18], 0);

		gpt_House[playerid][19] = CreatePlayerTextDraw(playerid, 500.000000, 226.000000, "");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][19], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][19], 16.000007, 26.118515);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][19], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][19], -3);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][19], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][19], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][19], 0);
		PlayerTextDrawFont(playerid, gpt_House[playerid][19], 5);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][19], 0);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][19], 0);
		PlayerTextDrawSetPreviewModel(playerid, gpt_House[playerid][19], 14866);
		PlayerTextDrawSetPreviewRot(playerid, gpt_House[playerid][19], 180.000000, 180.000000, -90.000000, 1.000000);

		gpt_House[playerid][20] = CreatePlayerTextDraw(playerid, 517.799804, 229.800048, "alugar");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][20], 0.219328, 1.309628);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][20], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][20], -1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][20], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][20], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][20], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][20], 2);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][20], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][20], 0);

		new sRent[12];
		format(sRent, sizeof(sRent), "$%d/hora", gHouseData[houseid][E_HOUSE_RENTCOST]);
		gpt_House[playerid][21] = CreatePlayerTextDraw(playerid, 518.000000, 241.000000, sRent);
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][21], 0.170000, 0.766222);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][21], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][21], -146);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][21], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][21], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][21], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][21], 2);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][21], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][21], 0);

		gpt_House[playerid][22] = CreatePlayerTextDraw(playerid, 567.899536, 228.000061, "box");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][22], 0.000000, 1.267994);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][22], 631.571533, 0.000000);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][22], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][22], -1);
		PlayerTextDrawUseBox(playerid, gpt_House[playerid][22], 1);
		PlayerTextDrawBoxColor(playerid, gpt_House[playerid][22], -226);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][22], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][22], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][22], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][22], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][22], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][22], 0);

		gpt_House[playerid][23] = CreatePlayerTextDraw(playerid, 584.701049, 231.699981, "Entrar");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][23], 0.240333, 1.525333);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][23], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][23], -156);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][23], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][23], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][23], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][23], 2);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][23], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][23], 0);

		gpt_House[playerid][24] = CreatePlayerTextDraw(playerid, 562.600097, 248.199951, "");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][24], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][24], 25.450029, -18.016265);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][24], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][24], -180);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][24], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][24], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][24], 0);
		PlayerTextDrawFont(playerid, gpt_House[playerid][24], 5);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][24], 0);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][24], 0);
		PlayerTextDrawSetPreviewModel(playerid, gpt_House[playerid][24], 1318);
		PlayerTextDrawSetPreviewRot(playerid, gpt_House[playerid][24], 0.000000, 0.000000, 90.000000, 1.000000);

		gpt_House[playerid][25] = CreatePlayerTextDraw(playerid, 627.799072, 111.299995, "box");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][25], 0.000000, 0.566663);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][25], 632.465698, 0.000000);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][25], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][25], -1);
		PlayerTextDrawUseBox(playerid, gpt_House[playerid][25], 1);
		PlayerTextDrawBoxColor(playerid, gpt_House[playerid][25], 58);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][25], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][25], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][25], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][25], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][25], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][25], 0);

		gpt_House[playerid][26] = CreatePlayerTextDraw(playerid, 627.199951, 109.399993, "X");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][26], 0.257999, 0.948740);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][26], 637.599951, 10.000);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][26], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][26], -16776961);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][26], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][26], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][26], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][26], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][26], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][26], 0);
		PlayerTextDrawSetSelectable(playerid, gpt_House[playerid][26], true);

		gpt_House[playerid][27] = CreatePlayerTextDraw(playerid, 567.000488, 257.500030, "box");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][27], 0.000000, 0.966665);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][27], 632.448242, 0.000000);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][27], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][27], -1);
		PlayerTextDrawUseBox(playerid, gpt_House[playerid][27], 1);
		PlayerTextDrawBoxColor(playerid, gpt_House[playerid][27], 56);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][27], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][27], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][27], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][27], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][27], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][27], 0);

		gpt_House[playerid][28] = CreatePlayerTextDraw(playerid, 568.300170, 257.199951, "box");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][28], 0.000000, 0.820332);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][28], 631.479064, 7.5);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][28], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][28], -5963521);
		PlayerTextDrawUseBox(playerid, gpt_House[playerid][28], 1);
		PlayerTextDrawBoxColor(playerid, gpt_House[playerid][28], -1378294188);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][28], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][28], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][28], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][28], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][28], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][28], 0);
		PlayerTextDrawSetSelectable(playerid, gpt_House[playerid][28], true);

		gpt_House[playerid][29] = CreatePlayerTextDraw(playerid, 568.299926, 258.000000, "box");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][29], 0.000000, 0.141332);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][29], 631.545654, 0.000000);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][29], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][29], -5963521);
		PlayerTextDrawUseBox(playerid, gpt_House[playerid][29], 1);
		PlayerTextDrawBoxColor(playerid, gpt_House[playerid][29], -226);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][29], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][29], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][29], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][29], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][29], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][29], 0);

		gpt_House[playerid][30] = CreatePlayerTextDraw(playerid, 573.399902, 257.000000, "Administrar casa");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][30], 0.134663, 0.741333);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][30], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][30], -1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][30], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][30], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][30], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][30], 2);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][30], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][30], 0);

		gpt_House[playerid][31] = CreatePlayerTextDraw(playerid, 500.933563, 209.986221, "- Aluguel:");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][31], 0.211998, 1.147850);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][31], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][31], -1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][31], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][31], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][31], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][31], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][31], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][31], 0);

		gpt_House[playerid][32] = CreatePlayerTextDraw(playerid, 631.256042, 210.135604, "Habilitado");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][32], 0.211998, 1.147850);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][32], 3);
		PlayerTextDrawColor(playerid, gpt_House[playerid][32], 8388863);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][32], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][32], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][32], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][32], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][32], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][32], 0);
	}
	else if(isowner && isowned) {
		gpt_House[playerid][0] = CreatePlayerTextDraw(playerid, 499.300018, 119.799972, "_");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][0], 0.708665, 14.914935);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][0], 632.474609, 0.029999);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][0], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][0], -1);
		PlayerTextDrawUseBox(playerid, gpt_House[playerid][0], 1);
		PlayerTextDrawBoxColor(playerid, gpt_House[playerid][0], 61);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][0], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][0], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][0], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][0], 2);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][0], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][0], 0);

		gpt_House[playerid][1] = CreatePlayerTextDraw(playerid, 500.250061, 121.120323, "box");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][1], -0.001333, 1.853966);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][1], 631.486328, 0.000000);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][1], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][1], -1);
		PlayerTextDrawUseBox(playerid, gpt_House[playerid][1], 1);
		PlayerTextDrawBoxColor(playerid, gpt_House[playerid][1], 69);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][1], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][1], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][1], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][1], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][1], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][1], 0);

		gpt_House[playerid][2] = CreatePlayerTextDraw(playerid, 500.250061, 141.821578, "box");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][2], -0.003665, 9.062238);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][2], 631.552246, 0.000000);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][2], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][2], -1);
		PlayerTextDrawUseBox(playerid, gpt_House[playerid][2], 1);
		PlayerTextDrawBoxColor(playerid, gpt_House[playerid][2], 69);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][2], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][2], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][2], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][2], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][2], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][2], 0);

		gpt_House[playerid][3] = CreatePlayerTextDraw(playerid, 496.399902, 118.640647, "");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][3], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][3], 21.666633, 21.970375);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][3], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][3], -1258291202);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][3], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][3], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][3], 0);
		PlayerTextDrawFont(playerid, gpt_House[playerid][3], 5);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][3], 0);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][3], 0);
		PlayerTextDrawSetPreviewModel(playerid, gpt_House[playerid][3], 1273);
		PlayerTextDrawSetPreviewRot(playerid, gpt_House[playerid][3], 0.000000, 0.000000, 0.000000, 1.000000);

		gpt_House[playerid][4] = CreatePlayerTextDraw(playerid, 500.933563, 182.984573, "- Status:");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][4], 0.211998, 1.147850);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][4], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][4], -1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][4], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][4], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][4], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][4], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][4], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][4], 0);

		format(sInfo, sizeof(sInfo), "Casa de %s", GetFirstName(gHouseData[houseid][E_HOUSE_OWNER]));
		gpt_House[playerid][5] = CreatePlayerTextDraw(playerid, 518.150207, 124.568435, sInfo);
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][5], 0.238333, 1.002665);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][5], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][5], -1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][5], 1);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][5], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][5], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][5], 3);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][5], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][5], 1);

		gpt_House[playerid][6] = CreatePlayerTextDraw(playerid, 500.784240, 143.646331, "- Comodos:");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][6], 0.211998, 1.147850);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][6], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][6], -1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][6], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][6], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][6], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][6], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][6], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][6], 0);

		format(sInfo, sizeof(sInfo), "%i", houseid);
		gpt_House[playerid][7] = CreatePlayerTextDraw(playerid, 619.986267, 124.203620, sInfo);
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][7], 0.238333, 1.002665);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][7], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][7], -173);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][7], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][7], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][7], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][7], 3);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][7], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][7], 0);

		gpt_House[playerid][8] = CreatePlayerTextDraw(playerid, 500.600219, 156.532958, "- Camas:");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][8], 0.211998, 1.147850);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][8], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][8], -1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][8], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][8], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][8], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][8], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][8], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][8], 0);

		gpt_House[playerid][9] = CreatePlayerTextDraw(playerid, 500.933563, 169.833770, "- Local:");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][9], 0.211998, 1.147850);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][9], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][9], -1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][9], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][9], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][9], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][9], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][9], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][9], 0);

		gpt_House[playerid][10] = CreatePlayerTextDraw(playerid, 500.933563, 196.485397, "- Garagem:");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][10], 0.211998, 1.147850);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][10], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][10], -1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][10], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][10], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][10], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][10], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][10], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][10], 0);

		format(sInfo, sizeof(sInfo), "%i", gHouseData[houseid][E_HOUSE_ROOMS]);
		gpt_House[playerid][11] = CreatePlayerTextDraw(playerid, 630.755920, 143.231521, sInfo);
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][11], 0.211998, 1.147850);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][11], 3);
		PlayerTextDrawColor(playerid, gpt_House[playerid][11], -134);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][11], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][11], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][11], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][11], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][11], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][11], 0);

		gpt_House[playerid][12] = CreatePlayerTextDraw(playerid, 500.599975, 228.000000, "box");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][12], 0.000000, 2.712661);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][12], 563.745605, 25.000000);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][12], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][12], 16777215);
		PlayerTextDrawUseBox(playerid, gpt_House[playerid][12], 1);
		PlayerTextDrawBoxColor(playerid, gpt_House[playerid][12], 16777039);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][12], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][12], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][12], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][12], 2);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][12], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][12], 0);
		PlayerTextDrawSetSelectable(playerid, gpt_House[playerid][12], true);

		format(sInfo, sizeof(sInfo), "%i", gHouseData[houseid][E_HOUSE_BEDS]);
		gpt_House[playerid][13] = CreatePlayerTextDraw(playerid, 630.789306, 156.491531, sInfo);
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][13], 0.211998, 1.147850);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][13], 3);
		PlayerTextDrawColor(playerid, gpt_House[playerid][13], -134);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][13], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][13], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][13], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][13], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][13], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][13], 0);

		gpt_House[playerid][14] = CreatePlayerTextDraw(playerid, 630.956115, 169.733139, gHouseData[houseid][E_HOUSE_LOCATION]);
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][14], 0.211998, 1.147850);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][14], 3);
		PlayerTextDrawColor(playerid, gpt_House[playerid][14], -134);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][14], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][14], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][14], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][14], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][14], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][14], 0);

		if(islocked) format(sInfo, sizeof(sInfo), "Trancada");
		else format(sInfo, sizeof(sInfo), "Aberta");
		gpt_House[playerid][15] = CreatePlayerTextDraw(playerid, 630.956115, 183.033950, sInfo);
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][15], 0.211998, 1.147850);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][15], 3);
		PlayerTextDrawColor(playerid, gpt_House[playerid][15], -1523766279);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][15], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][15], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][15], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][15], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][15], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][15], 0);

		format(sInfo, sizeof(sInfo), "%i", gHouseData[houseid][E_HOUSE_GARAGE]);
		gpt_House[playerid][16] = CreatePlayerTextDraw(playerid, 630.956115, 196.834793, sInfo);
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][16], 0.211998, 1.147850);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][16], 3);
		PlayerTextDrawColor(playerid, gpt_House[playerid][16], -1061109505);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][16], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][16], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][16], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][16], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][16], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][16], 0);

		gpt_House[playerid][17] = CreatePlayerTextDraw(playerid, 568.000000, 228.000000, "box");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][17], 0.000000, 2.701623);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][17], 631.561645, 25.000000);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][17], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][17], -1);
		PlayerTextDrawUseBox(playerid, gpt_House[playerid][17], 1);
		PlayerTextDrawBoxColor(playerid, gpt_House[playerid][17], (islocked) ? 2139062272 : -293376257);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][17], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][17], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][17], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][17], 2);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][17], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][17], 0);
		PlayerTextDrawSetSelectable(playerid, gpt_House[playerid][17], true);

		gpt_House[playerid][18] = CreatePlayerTextDraw(playerid, 500.500152, 228.100006, "box");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][18], 0.000000, 1.254999);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][18], 563.552917, 0.000000);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][18], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][18], -1);
		PlayerTextDrawUseBox(playerid, gpt_House[playerid][18], 1);
		PlayerTextDrawBoxColor(playerid, gpt_House[playerid][18], -230);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][18], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][18], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][18], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][18], 2);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][18], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][18], 0);

		gpt_House[playerid][19] = CreatePlayerTextDraw(playerid, 500.000000, 225.000000, "");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][19], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][19], 14.720023, 24.874065);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][19], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][19], -65281);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][19], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][19], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][19], 0);
		PlayerTextDrawFont(playerid, gpt_House[playerid][19], 5);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][19], 0);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][19], 0);
		PlayerTextDrawSetPreviewModel(playerid, gpt_House[playerid][19], 1239);
		PlayerTextDrawSetPreviewRot(playerid, gpt_House[playerid][19], 0.000000, 180.000000, 90.000000, 1.000000);

		gpt_House[playerid][20] = CreatePlayerTextDraw(playerid, 517.000000, 231.000000, "Administrar");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][20], 0.166996, 1.077333);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][20], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][20], -1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][20], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][20], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][20], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][20], 2);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][20], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][20], 0);

		gpt_House[playerid][21] = CreatePlayerTextDraw(playerid, 517.000000, 241.000000, "casa");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][21], 0.170000, 0.766222);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][21], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][21], -146);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][21], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][21], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][21], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][21], 2);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][21], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][21], 0);

		gpt_House[playerid][22] = CreatePlayerTextDraw(playerid, 567.899536, 228.000061, "box");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][22], 0.000000, 1.267994);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][22], 631.571533, 0.000000);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][22], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][22], -1);
		PlayerTextDrawUseBox(playerid, gpt_House[playerid][22], 1);
		PlayerTextDrawBoxColor(playerid, gpt_House[playerid][22], -226);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][22], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][22], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][22], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][22], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][22], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][22], 0);

		gpt_House[playerid][23] = CreatePlayerTextDraw(playerid, 584.701049, 231.699981, "Entrar");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][23], 0.240333, 1.525333);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][23], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][23], -156);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][23], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][23], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][23], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][23], 2);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][23], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][23], 0);

		gpt_House[playerid][24] = CreatePlayerTextDraw(playerid, 563.000000, 248.000000, "");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][24], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][24], 25.450029, -18.016265);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][24], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][24], -180);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][24], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][24], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][24], 0);
		PlayerTextDrawFont(playerid, gpt_House[playerid][24], 5);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][24], 0);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][24], 0);
		PlayerTextDrawSetPreviewModel(playerid, gpt_House[playerid][24], 1318);
		PlayerTextDrawSetPreviewRot(playerid, gpt_House[playerid][24], 0.000000, 0.000000, 90.000000, 1.000000);

		gpt_House[playerid][25] = CreatePlayerTextDraw(playerid, 627.799072, 111.299995, "box");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][25], 0.000000, 0.566663);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][25], 632.465698, 0.000000);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][25], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][25], -1);
		PlayerTextDrawUseBox(playerid, gpt_House[playerid][25], 1);
		PlayerTextDrawBoxColor(playerid, gpt_House[playerid][25], 58);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][25], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][25], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][25], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][25], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][25], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][25], 0);

		gpt_House[playerid][26] = CreatePlayerTextDraw(playerid, 627.199951, 109.399993, "X");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][26], 0.257999, 0.948740);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][26], 637.599951, 10.000);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][26], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][26], -16776961);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][26], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][26], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][26], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][26], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][26], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][26], 0);
		PlayerTextDrawSetSelectable(playerid, gpt_House[playerid][26], true);

		gpt_House[playerid][27] = CreatePlayerTextDraw(playerid, 567.000488, 257.500030, "box");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][27], 0.000000, 0.966665);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][27], 632.448242, 0.000000);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][27], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][27], -1);
		PlayerTextDrawUseBox(playerid, gpt_House[playerid][27], 1);
		PlayerTextDrawBoxColor(playerid, gpt_House[playerid][27], 56);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][27], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][27], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][27], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][27], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][27], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][27], 0);

		gpt_House[playerid][28] = CreatePlayerTextDraw(playerid, 568.300170, 257.199951, "box");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][28], 0.000000, 0.820331);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][28], 631.479064, 7.5);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][28], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][28], -5963521);
		PlayerTextDrawUseBox(playerid, gpt_House[playerid][28], 1);
		PlayerTextDrawBoxColor(playerid, gpt_House[playerid][28], -1378294188);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][28], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][28], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][28], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][28], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][28], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][28], 0);
		PlayerTextDrawSetSelectable(playerid, gpt_House[playerid][28], true);

		gpt_House[playerid][29] = CreatePlayerTextDraw(playerid, 568.299926, 258.000000, "box");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][29], 0.000000, 0.141332);
		PlayerTextDrawTextSize(playerid, gpt_House[playerid][29], 631.545654, 0.000000);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][29], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][29], -5963521);
		PlayerTextDrawUseBox(playerid, gpt_House[playerid][29], 1);
		PlayerTextDrawBoxColor(playerid, gpt_House[playerid][29], -226);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][29], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][29], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][29], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][29], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][29], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][29], 0);

		gpt_House[playerid][30] = CreatePlayerTextDraw(playerid, 573.399902, 257.000000, "Administrar casa");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][30], 0.134663, 0.741333);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][30], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][30], -1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][30], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][30], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][30], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][30], 2);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][30], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][30], 0);

		gpt_House[playerid][31] = CreatePlayerTextDraw(playerid, 500.933563, 209.986221, "- Aluguel:");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][31], 0.211998, 1.147850);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][31], 1);
		PlayerTextDrawColor(playerid, gpt_House[playerid][31], -1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][31], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][31], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][31], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][31], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][31], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][31], 0);

		gpt_House[playerid][32] = CreatePlayerTextDraw(playerid, 631.256042, 210.135604, "Desabilitado");
		PlayerTextDrawLetterSize(playerid, gpt_House[playerid][32], 0.211998, 1.147850);
		PlayerTextDrawAlignment(playerid, gpt_House[playerid][32], 3);
		PlayerTextDrawColor(playerid, gpt_House[playerid][32], -1523963138);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][32], 0);
		PlayerTextDrawSetOutline(playerid, gpt_House[playerid][32], 0);
		PlayerTextDrawBackgroundColor(playerid, gpt_House[playerid][32], 255);
		PlayerTextDrawFont(playerid, gpt_House[playerid][32], 1);
		PlayerTextDrawSetProportional(playerid, gpt_House[playerid][32], 1);
		PlayerTextDrawSetShadow(playerid, gpt_House[playerid][32], 0);
	}

	for (new i = 0; i < sizeof(gpt_House[]); i++) {
		if(gpt_House[playerid][i] != PlayerText:INVALID_TEXT_DRAW)
			PlayerTextDrawShow(playerid, gpt_House[playerid][i]);
	}
	SelectTextDraw(playerid, 0x2aa6b3ff);
	return 1;
}

/* Hides house dialog for a player */
HidePlayerHouseTD(playerid) {
	if(!GetPVarInt(playerid, "gptIsVisible"))
		return 1;

	DeletePVar(playerid, "gptType");
	defer gptVisibleDelayed(playerid);
	CancelSelectTextDraw(playerid);
	for (new i = 0; i < sizeof(gpt_House[]); i++) {
		if(gpt_House[playerid][i] != PlayerText:INVALID_TEXT_DRAW) {
			PlayerTextDrawDestroy(playerid, gpt_House[playerid][i]);
			gpt_House[playerid][i] = PlayerText:INVALID_TEXT_DRAW;
		}
	}
	return 1;
}

hook OnPlayerClickTextDraw(playerid, Text:clickedid) {
	if(clickedid == Text:INVALID_TEXT_DRAW && GetPVarInt(playerid, "gptIsVisible") && GetPVarInt(playerid, "gptType") == 2) {
		HidePlayerHouseTD(playerid);
	}
	return 1;
}

hook OnPlayerClickPlayerTD(playerid, PlayerText:playertextid) {
	if(!GetPVarInt(playerid, "gptIsVisible") || GetPVarInt(playerid, "gptType") != 2)
		return 1;

	if(playertextid == gpt_House[playerid][26]) {
		HidePlayerHouseTD(playerid);
		PlayCancelSound(playerid);
	}
	else if(playertextid == gpt_House[playerid][28]) {
		PlayErrorSound(playerid);
	}
	else if(playertextid == gpt_House[playerid][17]) {
		new h = GetPVarInt(playerid, "gptPropID");
		if(gHouseData[h][E_HOUSE_LOCKED]) {
			PlayErrorSound(playerid);
			SendClientMessage(playerid, COLOR_ERROR, "* Casa trancada!");
			return 1;
		}
		HidePlayerHouseTD(playerid);
		SetPlayerPos(playerid, gHouseData[h][E_HOUSE_EXITX], gHouseData[h][E_HOUSE_EXITY], gHouseData[h][E_HOUSE_EXITZ]);
		SetPlayerFacingAngle(playerid, gHouseData[h][E_HOUSE_EXITA]);
		SetPlayerInterior(playerid, gHouseData[h][E_HOUSE_EXITINT]);
		SetPlayerVirtualWorld(playerid, h);
		SetPVarInt(playerid, "PickupDelay", PICKUP_DELAY);
		SetCameraBehindPlayer(playerid);
		PlaySelectSound(playerid);
	}
	else if(playertextid == gpt_House[playerid][12]) {
		new h = GetPVarInt(playerid, "gptPropID");
		if(!gHouseData[h][E_HOUSE_OWNED]) {
			if(GetPlayerCash(playerid) < gHouseData[h][E_HOUSE_PRICE]) {
				PlayErrorSound(playerid);
				SendClientMessage(playerid, COLOR_ERROR, "* Dinheiro insuficiente!");
				return 1;
			}
			else if(GetPlayerHouseID(playerid) != INVALID_HOUSE_ID) {
				PlayErrorSound(playerid);
				SendClientMessage(playerid, COLOR_ERROR, "* Você já possui uma casa!");
				return 1;
			}
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_SUCCESS, "* Você comprou a casa.");
			SendClientActionMessage(playerid, 15.0, "assina os papeis e recebe a chave da casa.");
			GivePlayerCash(playerid, -gHouseData[h][E_HOUSE_PRICE]);
			HidePlayerHouseTD(playerid);

			new playerName[MAX_PLAYER_NAME];
			GetPlayerName(playerid, playerName, MAX_PLAYER_NAME);

			SetPlayerHouseID(playerid, h);

			SetHouseOwned(h,	1);
			SetHouseLocked(h,	0);
			SetHouseRentable(h, 0);
			SetHouseRentCost(h, 0);
			SetHouseOwnerName(h, playerName);

			UpdateHousePickup(h);
		} else {
			PlayErrorSound(playerid);
		}
	}
	return 1;
}

/* This wasn't exacly supposed to be here, but.. w/e */
timer gptVisibleDelayed[3000](playerid) {
	DeletePVar(playerid, "gptIsVisible");
}
