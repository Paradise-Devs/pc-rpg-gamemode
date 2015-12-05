/*******************************************************************************
* FILENAME :        modules/visual/dealership.pwn
*
* DESCRIPTION :
*       Create/Destroy and Show dealership GUI functions.
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

new
	PlayerText:deal_background[MAX_PLAYERS],

	PlayerText:deal_modeltext[MAX_PLAYERS],
	PlayerText:deal_modelname[MAX_PLAYERS],
	PlayerText:deal_modelleft[MAX_PLAYERS],
	PlayerText:deal_modelright[MAX_PLAYERS],

	PlayerText:deal_colortext[MAX_PLAYERS],
	PlayerText:deal_colorname[MAX_PLAYERS],
	PlayerText:deal_colorleft[MAX_PLAYERS],
	PlayerText:deal_colorright[MAX_PLAYERS],

	PlayerText:deal_cameratext[MAX_PLAYERS],
	PlayerText:deal_cameraname[MAX_PLAYERS],
	PlayerText:deal_cameraleft[MAX_PLAYERS],
	PlayerText:deal_cameraright[MAX_PLAYERS],

	PlayerText:deal_categorytext[MAX_PLAYERS],
	PlayerText:deal_categoryname[MAX_PLAYERS],
	PlayerText:deal_categoryleft[MAX_PLAYERS],
	PlayerText:deal_categoryright[MAX_PLAYERS],

	PlayerText:deal_pricetext[MAX_PLAYERS],
	PlayerText:deal_pricename[MAX_PLAYERS],

	PlayerText:deal_confirm[MAX_PLAYERS],
	PlayerText:deal_caption[MAX_PLAYERS];

//------------------------------------------------------------------------------

stock ShowPlayerDealershipHud(playerid)
{
	if(GetPVarInt(playerid, "isDealershipHudVisible"))
		return false;

	SetPVarInt(playerid, "isDealershipHudVisible", true);

	deal_background[playerid] = CreatePlayerTextDraw(playerid, 30.666700, 90.000000, "usebox");
	PlayerTextDrawLetterSize(playerid, deal_background[playerid], 0.000000, 25.00000);
	PlayerTextDrawTextSize(playerid, deal_background[playerid], 168.999969, 0.000000);
	PlayerTextDrawAlignment(playerid, deal_background[playerid], 1);
	PlayerTextDrawColor(playerid, deal_background[playerid], 0);
	PlayerTextDrawUseBox(playerid, deal_background[playerid], true);
	PlayerTextDrawBoxColor(playerid, deal_background[playerid], 102);
	PlayerTextDrawSetShadow(playerid, deal_background[playerid], 0);
	PlayerTextDrawSetOutline(playerid, deal_background[playerid], 0);
	PlayerTextDrawFont(playerid, deal_background[playerid], 0);
	PlayerTextDrawShow(playerid, deal_background[playerid]);

	deal_modeltext[playerid] = CreatePlayerTextDraw(playerid, 32.333328, 102.459197, "Modelo:");
	PlayerTextDrawLetterSize(playerid, deal_modeltext[playerid], 0.171666, 1.143703);
	PlayerTextDrawAlignment(playerid, deal_modeltext[playerid], 1);
	PlayerTextDrawColor(playerid, deal_modeltext[playerid], 464641450);
	PlayerTextDrawSetShadow(playerid, deal_modeltext[playerid], 0);
	PlayerTextDrawSetOutline(playerid, deal_modeltext[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, deal_modeltext[playerid], 51);
	PlayerTextDrawFont(playerid, deal_modeltext[playerid], 2);
	PlayerTextDrawSetProportional(playerid, deal_modeltext[playerid], 1);
	PlayerTextDrawShow(playerid, deal_modeltext[playerid]);

	deal_modelname[playerid] = CreatePlayerTextDraw(playerid, 32.333328, 114.488876, "Landstalker");
	PlayerTextDrawLetterSize(playerid, deal_modelname[playerid], 0.171666, 1.143703);
	PlayerTextDrawAlignment(playerid, deal_modelname[playerid], 1);
	PlayerTextDrawColor(playerid, deal_modelname[playerid], -1);
	PlayerTextDrawSetShadow(playerid, deal_modelname[playerid], 0);
	PlayerTextDrawSetOutline(playerid, deal_modelname[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, deal_modelname[playerid], 51);
	PlayerTextDrawFont(playerid, deal_modelname[playerid], 2);
	PlayerTextDrawSetProportional(playerid, deal_modelname[playerid], 1);
	PlayerTextDrawShow(playerid, deal_modelname[playerid]);

	deal_colortext[playerid] = CreatePlayerTextDraw(playerid, 32.333328, 138.548263, "Cor:");
	PlayerTextDrawLetterSize(playerid, deal_colortext[playerid], 0.171666, 1.143703);
	PlayerTextDrawAlignment(playerid, deal_colortext[playerid], 1);
	PlayerTextDrawColor(playerid, deal_colortext[playerid], 464641994);
	PlayerTextDrawSetShadow(playerid, deal_colortext[playerid], 0);
	PlayerTextDrawSetOutline(playerid, deal_colortext[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, deal_colortext[playerid], 51);
	PlayerTextDrawFont(playerid, deal_colortext[playerid], 2);
	PlayerTextDrawSetProportional(playerid, deal_colortext[playerid], 1);
	PlayerTextDrawShow(playerid, deal_colortext[playerid]);

	deal_colorname[playerid] = CreatePlayerTextDraw(playerid, 32.333328, 150.577826, "0/126");
	PlayerTextDrawLetterSize(playerid, deal_colorname[playerid], 0.171666, 1.143703);
	PlayerTextDrawAlignment(playerid, deal_colorname[playerid], 1);
	PlayerTextDrawColor(playerid, deal_colorname[playerid], -1);
	PlayerTextDrawSetShadow(playerid, deal_colorname[playerid], 0);
	PlayerTextDrawSetOutline(playerid, deal_colorname[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, deal_colorname[playerid], 51);
	PlayerTextDrawFont(playerid, deal_colorname[playerid], 2);
	PlayerTextDrawSetProportional(playerid, deal_colorname[playerid], 1);
	PlayerTextDrawShow(playerid, deal_colorname[playerid]);

	deal_modelleft[playerid] = CreatePlayerTextDraw(playerid, 126.666618, 112.414810, "ld_beat:left");
	PlayerTextDrawLetterSize(playerid, deal_modelleft[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, deal_modelleft[playerid], 13.000000, 13.688888);
	PlayerTextDrawAlignment(playerid, deal_modelleft[playerid], 1);
	PlayerTextDrawColor(playerid, deal_modelleft[playerid], -1);
	PlayerTextDrawSetShadow(playerid, deal_modelleft[playerid], 0);
	PlayerTextDrawSetOutline(playerid, deal_modelleft[playerid], 0);
	PlayerTextDrawFont(playerid, deal_modelleft[playerid], 4);
	PlayerTextDrawSetSelectable(playerid, deal_modelleft[playerid], true);
	PlayerTextDrawShow(playerid, deal_modelleft[playerid]);

	deal_modelright[playerid] = CreatePlayerTextDraw(playerid, 152.666671, 112.414810, "ld_beat:right");
	PlayerTextDrawLetterSize(playerid, deal_modelright[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, deal_modelright[playerid], 13.000015, 14.103713);
	PlayerTextDrawAlignment(playerid, deal_modelright[playerid], 1);
	PlayerTextDrawColor(playerid, deal_modelright[playerid], -1);
	PlayerTextDrawSetShadow(playerid, deal_modelright[playerid], 0);
	PlayerTextDrawSetOutline(playerid, deal_modelright[playerid], 0);
	PlayerTextDrawFont(playerid, deal_modelright[playerid], 4);
	PlayerTextDrawSetSelectable(playerid, deal_modelright[playerid], true);
	PlayerTextDrawShow(playerid, deal_modelright[playerid]);

	deal_colorleft[playerid] = CreatePlayerTextDraw(playerid, 126.666618, 148.50376, "ld_beat:left");
	PlayerTextDrawLetterSize(playerid, deal_colorleft[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, deal_colorleft[playerid], 13.000000, 13.688888);
	PlayerTextDrawAlignment(playerid, deal_colorleft[playerid], 1);
	PlayerTextDrawColor(playerid, deal_colorleft[playerid], -1);
	PlayerTextDrawSetShadow(playerid, deal_colorleft[playerid], 0);
	PlayerTextDrawSetOutline(playerid, deal_colorleft[playerid], 0);
	PlayerTextDrawFont(playerid, deal_colorleft[playerid], 4);
	PlayerTextDrawSetSelectable(playerid, deal_colorleft[playerid], true);
	PlayerTextDrawShow(playerid, deal_colorleft[playerid]);

	deal_colorright[playerid] = CreatePlayerTextDraw(playerid, 152.666671, 148.50376, "ld_beat:right");
	PlayerTextDrawLetterSize(playerid, deal_colorright[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, deal_colorright[playerid], 13.000015, 14.103713);
	PlayerTextDrawAlignment(playerid, deal_colorright[playerid], 1);
	PlayerTextDrawColor(playerid, deal_colorright[playerid], -1);
	PlayerTextDrawSetShadow(playerid, deal_colorright[playerid], 0);
	PlayerTextDrawSetOutline(playerid, deal_colorright[playerid], 0);
	PlayerTextDrawFont(playerid, deal_colorright[playerid], 4);
	PlayerTextDrawSetSelectable(playerid, deal_colorright[playerid], true);
	PlayerTextDrawShow(playerid, deal_colorright[playerid]);

	deal_cameratext[playerid] = CreatePlayerTextDraw(playerid, 32.333328, 174.548263, "Camera:");
	PlayerTextDrawLetterSize(playerid, deal_cameratext[playerid], 0.171666, 1.143703);
	PlayerTextDrawAlignment(playerid, deal_cameratext[playerid], 1);
	PlayerTextDrawColor(playerid, deal_cameratext[playerid], 464641994);
	PlayerTextDrawSetShadow(playerid, deal_cameratext[playerid], 0);
	PlayerTextDrawSetOutline(playerid, deal_cameratext[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, deal_cameratext[playerid], 51);
	PlayerTextDrawFont(playerid, deal_cameratext[playerid], 2);
	PlayerTextDrawSetProportional(playerid, deal_cameratext[playerid], 1);
	PlayerTextDrawShow(playerid, deal_cameratext[playerid]);

	deal_cameraname[playerid] = CreatePlayerTextDraw(playerid, 32.333328, 186.577826, "1/6");
	PlayerTextDrawLetterSize(playerid, deal_cameraname[playerid], 0.171666, 1.143703);
	PlayerTextDrawAlignment(playerid, deal_cameraname[playerid], 1);
	PlayerTextDrawColor(playerid, deal_cameraname[playerid], -1);
	PlayerTextDrawSetShadow(playerid, deal_cameraname[playerid], 0);
	PlayerTextDrawSetOutline(playerid, deal_cameraname[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, deal_cameraname[playerid], 51);
	PlayerTextDrawFont(playerid, deal_cameraname[playerid], 2);
	PlayerTextDrawSetProportional(playerid, deal_cameraname[playerid], 1);
	PlayerTextDrawShow(playerid, deal_cameraname[playerid]);

	deal_cameraleft[playerid] = CreatePlayerTextDraw(playerid, 126.666618, 184.50376, "ld_beat:left");
	PlayerTextDrawLetterSize(playerid, deal_cameraleft[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, deal_cameraleft[playerid], 13.000000, 13.688888);
	PlayerTextDrawAlignment(playerid, deal_cameraleft[playerid], 1);
	PlayerTextDrawColor(playerid, deal_cameraleft[playerid], -1);
	PlayerTextDrawSetShadow(playerid, deal_cameraleft[playerid], 0);
	PlayerTextDrawSetOutline(playerid, deal_cameraleft[playerid], 0);
	PlayerTextDrawFont(playerid, deal_cameraleft[playerid], 4);
	PlayerTextDrawSetSelectable(playerid, deal_cameraleft[playerid], true);
	PlayerTextDrawShow(playerid, deal_cameraleft[playerid]);

	deal_cameraright[playerid] = CreatePlayerTextDraw(playerid, 152.666671, 184.50376, "ld_beat:right");
	PlayerTextDrawLetterSize(playerid, deal_cameraright[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, deal_cameraright[playerid], 13.000015, 14.103713);
	PlayerTextDrawAlignment(playerid, deal_cameraright[playerid], 1);
	PlayerTextDrawColor(playerid, deal_cameraright[playerid], -1);
	PlayerTextDrawSetShadow(playerid, deal_cameraright[playerid], 0);
	PlayerTextDrawSetOutline(playerid, deal_cameraright[playerid], 0);
	PlayerTextDrawFont(playerid, deal_cameraright[playerid], 4);
	PlayerTextDrawSetSelectable(playerid, deal_cameraright[playerid], true);
	PlayerTextDrawShow(playerid, deal_cameraright[playerid]);

	deal_categorytext[playerid] = CreatePlayerTextDraw(playerid, 32.333328, 210.548263, "Categoria:");
	PlayerTextDrawLetterSize(playerid, deal_categorytext[playerid], 0.171666, 1.143703);
	PlayerTextDrawAlignment(playerid, deal_categorytext[playerid], 1);
	PlayerTextDrawColor(playerid, deal_categorytext[playerid], 464641994);
	PlayerTextDrawSetShadow(playerid, deal_categorytext[playerid], 0);
	PlayerTextDrawSetOutline(playerid, deal_categorytext[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, deal_categorytext[playerid], 51);
	PlayerTextDrawFont(playerid, deal_categorytext[playerid], 2);
	PlayerTextDrawSetProportional(playerid, deal_categorytext[playerid], 1);
	PlayerTextDrawShow(playerid, deal_categorytext[playerid]);

	deal_categoryname[playerid] = CreatePlayerTextDraw(playerid, 32.333328, 222.577826, "Off-Road");
	PlayerTextDrawLetterSize(playerid, deal_categoryname[playerid], 0.171666, 1.143703);
	PlayerTextDrawAlignment(playerid, deal_categoryname[playerid], 1);
	PlayerTextDrawColor(playerid, deal_categoryname[playerid], -1);
	PlayerTextDrawSetShadow(playerid, deal_categoryname[playerid], 0);
	PlayerTextDrawSetOutline(playerid, deal_categoryname[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, deal_categoryname[playerid], 51);
	PlayerTextDrawFont(playerid, deal_categoryname[playerid], 2);
	PlayerTextDrawSetProportional(playerid, deal_categoryname[playerid], 1);
	PlayerTextDrawShow(playerid, deal_categoryname[playerid]);

	deal_categoryleft[playerid] = CreatePlayerTextDraw(playerid, 126.666618, 220.50376, "ld_beat:left");
	PlayerTextDrawLetterSize(playerid, deal_categoryleft[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, deal_categoryleft[playerid], 13.000000, 13.688888);
	PlayerTextDrawAlignment(playerid, deal_categoryleft[playerid], 1);
	PlayerTextDrawColor(playerid, deal_categoryleft[playerid], -1);
	PlayerTextDrawSetShadow(playerid, deal_categoryleft[playerid], 0);
	PlayerTextDrawSetOutline(playerid, deal_categoryleft[playerid], 0);
	PlayerTextDrawFont(playerid, deal_categoryleft[playerid], 4);
	PlayerTextDrawSetSelectable(playerid, deal_categoryleft[playerid], true);
	PlayerTextDrawShow(playerid, deal_categoryleft[playerid]);

	deal_categoryright[playerid] = CreatePlayerTextDraw(playerid, 152.666671, 220.50376, "ld_beat:right");
	PlayerTextDrawLetterSize(playerid, deal_categoryright[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, deal_categoryright[playerid], 13.000015, 14.103713);
	PlayerTextDrawAlignment(playerid, deal_categoryright[playerid], 1);
	PlayerTextDrawColor(playerid, deal_categoryright[playerid], -1);
	PlayerTextDrawSetShadow(playerid, deal_categoryright[playerid], 0);
	PlayerTextDrawSetOutline(playerid, deal_categoryright[playerid], 0);
	PlayerTextDrawFont(playerid, deal_categoryright[playerid], 4);
	PlayerTextDrawSetSelectable(playerid, deal_categoryright[playerid], true);
	PlayerTextDrawShow(playerid, deal_categoryright[playerid]);

	deal_pricetext[playerid] = CreatePlayerTextDraw(playerid, 32.333328, 246.548263, "Valor:");
	PlayerTextDrawLetterSize(playerid, deal_pricetext[playerid], 0.171666, 1.143703);
	PlayerTextDrawAlignment(playerid, deal_pricetext[playerid], 1);
	PlayerTextDrawColor(playerid, deal_pricetext[playerid], 464641994);
	PlayerTextDrawSetShadow(playerid, deal_pricetext[playerid], 0);
	PlayerTextDrawSetOutline(playerid, deal_pricetext[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, deal_pricetext[playerid], 51);
	PlayerTextDrawFont(playerid, deal_pricetext[playerid], 2);
	PlayerTextDrawSetProportional(playerid, deal_pricetext[playerid], 1);
	PlayerTextDrawShow(playerid, deal_pricetext[playerid]);

	deal_pricename[playerid] = CreatePlayerTextDraw(playerid, 32.333328, 258.577826, "Carregando...");
	PlayerTextDrawLetterSize(playerid, deal_pricename[playerid], 0.171666, 1.143703);
	PlayerTextDrawAlignment(playerid, deal_pricename[playerid], 1);
	PlayerTextDrawColor(playerid, deal_pricename[playerid], -1);
	PlayerTextDrawSetShadow(playerid, deal_pricename[playerid], 0);
	PlayerTextDrawSetOutline(playerid, deal_pricename[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, deal_pricename[playerid], 51);
	PlayerTextDrawFont(playerid, deal_pricename[playerid], 2);
	PlayerTextDrawSetProportional(playerid, deal_pricename[playerid], 1);
	PlayerTextDrawShow(playerid, deal_pricename[playerid]);

	deal_confirm[playerid] = CreatePlayerTextDraw(playerid, 52.333305, 300.940734, "Comprar");
	PlayerTextDrawLetterSize(playerid, deal_confirm[playerid], 0.453332, 1.682963);
	PlayerTextDrawTextSize(playerid, deal_confirm[playerid], 154.333374, 13.274072);
	PlayerTextDrawAlignment(playerid, deal_confirm[playerid], 1);
	PlayerTextDrawColor(playerid, deal_confirm[playerid], -1);
	PlayerTextDrawSetShadow(playerid, deal_confirm[playerid], 0);
	PlayerTextDrawSetOutline(playerid, deal_confirm[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, deal_confirm[playerid], 51);
	PlayerTextDrawFont(playerid, deal_confirm[playerid], 2);
	PlayerTextDrawSetProportional(playerid, deal_confirm[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, deal_confirm[playerid], true);
	PlayerTextDrawShow(playerid, deal_confirm[playerid]);

	deal_caption[playerid] = CreatePlayerTextDraw(playerid, 23.333337, 80.962936, "Concessionaria");
	PlayerTextDrawLetterSize(playerid, deal_caption[playerid], 0.449999, 1.600000);
	PlayerTextDrawAlignment(playerid, deal_caption[playerid], 1);
	PlayerTextDrawColor(playerid, deal_caption[playerid], -1);
	PlayerTextDrawSetShadow(playerid, deal_caption[playerid], 0);
	PlayerTextDrawSetOutline(playerid, deal_caption[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, deal_caption[playerid], 51);
	PlayerTextDrawFont(playerid, deal_caption[playerid], 0);
	PlayerTextDrawSetProportional(playerid, deal_caption[playerid], 1);
	PlayerTextDrawShow(playerid, deal_caption[playerid]);

	SelectTextDraw(playerid, 0xC7E9FFAA);
	return true;
}

stock HidePlayerDealershipHud(playerid)
{
	if(!GetPVarInt(playerid, "isDealershipHudVisible"))
		return false;

	DeletePVar(playerid, "isDealershipHudVisible");
	PlayerTextDrawDestroy(playerid, deal_background[playerid]);

	PlayerTextDrawDestroy(playerid, deal_modeltext[playerid]);
	PlayerTextDrawDestroy(playerid, deal_modelname[playerid]);
	PlayerTextDrawDestroy(playerid, deal_modelleft[playerid]);
	PlayerTextDrawDestroy(playerid, deal_modelright[playerid]);

	PlayerTextDrawDestroy(playerid, deal_colortext[playerid]);
	PlayerTextDrawDestroy(playerid, deal_colorname[playerid]);
	PlayerTextDrawDestroy(playerid, deal_colorleft[playerid]);
	PlayerTextDrawDestroy(playerid, deal_colorright[playerid]);

	PlayerTextDrawDestroy(playerid, deal_cameratext[playerid]);
	PlayerTextDrawDestroy(playerid, deal_cameraname[playerid]);
	PlayerTextDrawDestroy(playerid, deal_cameraleft[playerid]);
	PlayerTextDrawDestroy(playerid, deal_cameraright[playerid]);

	PlayerTextDrawDestroy(playerid, deal_categorytext[playerid]);
	PlayerTextDrawDestroy(playerid, deal_categoryname[playerid]);
	PlayerTextDrawDestroy(playerid, deal_categoryleft[playerid]);
	PlayerTextDrawDestroy(playerid, deal_categoryright[playerid]);

	PlayerTextDrawDestroy(playerid, deal_pricetext[playerid]);
	PlayerTextDrawDestroy(playerid, deal_pricename[playerid]);

	PlayerTextDrawDestroy(playerid, deal_confirm[playerid]);
	PlayerTextDrawDestroy(playerid, deal_caption[playerid]);

	CancelSelectTextDraw(playerid);
	return 1;
}
