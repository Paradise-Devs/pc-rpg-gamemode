/* *************************************************************************** *
*  Description: Apartment visual module file.
*
*  Assignment: A script to handle gang textdraws.
*
*           Copyright Paradise Devs 2015.  All rights reserved.
* *************************************************************************** */
#define DIALOG_CHOOSE_GANGNAME 6052

new Text:GangMenuText[74];
new PlayerText:GangMenuPlayerText[MAX_PLAYERS][14];


#include <YSI\y_hooks>

hook OnGameModeInit()
{
    GangMenuText[0] = TextDrawCreate(145.000000, 108.000000, "_");
    TextDrawBackgroundColor(GangMenuText[0], 255);
    TextDrawFont(GangMenuText[0], 1);
    TextDrawLetterSize(GangMenuText[0], 0.500000, 32.299987);
    TextDrawColor(GangMenuText[0], -1);
    TextDrawSetOutline(GangMenuText[0], 0);
    TextDrawSetProportional(GangMenuText[0], 1);
    TextDrawSetShadow(GangMenuText[0], 1);
    TextDrawUseBox(GangMenuText[0], 1);
    TextDrawBoxColor(GangMenuText[0], 128);
    TextDrawTextSize(GangMenuText[0], 501.000000, 0.000000);
    TextDrawSetSelectable(GangMenuText[0], 0);

    GangMenuText[1] = TextDrawCreate(145.000000, 108.000000, "_");
    TextDrawBackgroundColor(GangMenuText[1], 255);
    TextDrawFont(GangMenuText[1], 1);
    TextDrawLetterSize(GangMenuText[1], 0.500000, 1.000000);
    TextDrawColor(GangMenuText[1], -1);
    TextDrawSetOutline(GangMenuText[1], 0);
    TextDrawSetProportional(GangMenuText[1], 1);
    TextDrawSetShadow(GangMenuText[1], 1);
    TextDrawUseBox(GangMenuText[1], 1);
    TextDrawBoxColor(GangMenuText[1], 1263225855);
    TextDrawTextSize(GangMenuText[1], 501.000000, 11.000000);
    TextDrawSetSelectable(GangMenuText[1], 0);

    GangMenuText[2] = TextDrawCreate(145.000000, 108.000000, "_");
    TextDrawBackgroundColor(GangMenuText[2], 255);
    TextDrawFont(GangMenuText[2], 1);
    TextDrawLetterSize(GangMenuText[2], 0.500000, 0.399998);
    TextDrawColor(GangMenuText[2], -1);
    TextDrawSetOutline(GangMenuText[2], 0);
    TextDrawSetProportional(GangMenuText[2], 1);
    TextDrawSetShadow(GangMenuText[2], 1);
    TextDrawUseBox(GangMenuText[2], 1);
    TextDrawBoxColor(GangMenuText[2], 1515870975);
    TextDrawTextSize(GangMenuText[2], 501.000000, -27.000000);
    TextDrawSetSelectable(GangMenuText[2], 0);

    GangMenuText[3] = TextDrawCreate(296.000000, 109.000000, "CRIAR GANGUE");
    TextDrawBackgroundColor(GangMenuText[3], 0);
    TextDrawFont(GangMenuText[3], 2);
    TextDrawLetterSize(GangMenuText[3], 0.170000, 0.799998);
    TextDrawColor(GangMenuText[3], -1);
    TextDrawSetOutline(GangMenuText[3], 1);
    TextDrawSetProportional(GangMenuText[3], 1);
    TextDrawSetSelectable(GangMenuText[3], 0);

    GangMenuText[4] = TextDrawCreate(317.000000, 120.000000, "Complete os campos abaixo para criar sua gangue.");
    TextDrawAlignment(GangMenuText[4], 2);
    TextDrawBackgroundColor(GangMenuText[4], 255);
    TextDrawFont(GangMenuText[4], 1);
    TextDrawLetterSize(GangMenuText[4], 0.209999, 1.000000);
    TextDrawColor(GangMenuText[4], -1);
    TextDrawSetOutline(GangMenuText[4], 0);
    TextDrawSetProportional(GangMenuText[4], 1);
    TextDrawSetShadow(GangMenuText[4], 1);
    TextDrawSetSelectable(GangMenuText[4], 0);

    GangMenuText[5] = TextDrawCreate(145.000000, 135.000000, "_");
    TextDrawBackgroundColor(GangMenuText[5], 0);
    TextDrawFont(GangMenuText[5], 2);
    TextDrawLetterSize(GangMenuText[5], 0.159998, -0.400000);
    TextDrawColor(GangMenuText[5], -1);
    TextDrawSetOutline(GangMenuText[5], 1);
    TextDrawSetProportional(GangMenuText[5], 1);
    TextDrawUseBox(GangMenuText[5], 1);
    TextDrawBoxColor(GangMenuText[5], 842150655);
    TextDrawTextSize(GangMenuText[5], 501.000000, 0.000000);
    TextDrawSetSelectable(GangMenuText[5], 0);

    GangMenuText[6] = TextDrawCreate(148.000000, 138.000000, "Nome da gangue:");
    TextDrawBackgroundColor(GangMenuText[6], 255);
    TextDrawFont(GangMenuText[6], 2);
    TextDrawLetterSize(GangMenuText[6], 0.170000, 0.699998);
    TextDrawColor(GangMenuText[6], -8388353);
    TextDrawSetOutline(GangMenuText[6], 0);
    TextDrawSetProportional(GangMenuText[6], 1);
    TextDrawSetShadow(GangMenuText[6], 1);
    TextDrawSetSelectable(GangMenuText[6], 0);

    GangMenuText[7] = TextDrawCreate(150.000000, 148.000000, "_");
    TextDrawBackgroundColor(GangMenuText[7], 255);
    TextDrawFont(GangMenuText[7], 1);
    TextDrawLetterSize(GangMenuText[7], 0.500000, 1.000000);
    TextDrawColor(GangMenuText[7], -1);
    TextDrawSetOutline(GangMenuText[7], 0);
    TextDrawSetProportional(GangMenuText[7], 1);
    TextDrawSetShadow(GangMenuText[7], 1);
    TextDrawUseBox(GangMenuText[7], 1);
    TextDrawBoxColor(GangMenuText[7], 255);
    TextDrawTextSize(GangMenuText[7], 304.000000, 3.000000);
    TextDrawSetSelectable(GangMenuText[7], 0);

    GangMenuText[8] = TextDrawCreate(417.000000, 140.000000, "Permitidos somente caracteres alfanumericos (letras e numeros), qualquer outro caractere inserido resultara em erro!");
    TextDrawAlignment(GangMenuText[8], 2);
    TextDrawBackgroundColor(GangMenuText[8], 0);
    TextDrawFont(GangMenuText[8], 1);
    TextDrawLetterSize(GangMenuText[8], 0.189999, 1.000000);
    TextDrawColor(GangMenuText[8], -1);
    TextDrawSetOutline(GangMenuText[8], 1);
    TextDrawSetProportional(GangMenuText[8], 1);
    TextDrawUseBox(GangMenuText[8], 1);
    TextDrawBoxColor(GangMenuText[8], 0);
    TextDrawTextSize(GangMenuText[8], 0.000000, 150.000000);
    TextDrawSetSelectable(GangMenuText[8], 0);

    GangMenuText[9] = TextDrawCreate(331.000000, 147.000000, "~<~   ");
    TextDrawAlignment(GangMenuText[9], 2);
    TextDrawBackgroundColor(GangMenuText[9], 0);
    TextDrawFont(GangMenuText[9], 1);
    TextDrawLetterSize(GangMenuText[9], 0.289999, 1.000000);
    TextDrawColor(GangMenuText[9], -1);
    TextDrawSetOutline(GangMenuText[9], 0);
    TextDrawSetProportional(GangMenuText[9], 1);
    TextDrawSetShadow(GangMenuText[9], 1);
    TextDrawUseBox(GangMenuText[9], 1);
    TextDrawBoxColor(GangMenuText[9], 0);
    TextDrawTextSize(GangMenuText[9], 344.000000, 7.000000);
    TextDrawSetSelectable(GangMenuText[9], 0);

    GangMenuText[10] = TextDrawCreate(145.000000, 174.000000, "_");
    TextDrawBackgroundColor(GangMenuText[10], 0);
    TextDrawFont(GangMenuText[10], 2);
    TextDrawLetterSize(GangMenuText[10], 0.159998, -0.400000);
    TextDrawColor(GangMenuText[10], -8388353);
    TextDrawSetOutline(GangMenuText[10], 1);
    TextDrawSetProportional(GangMenuText[10], 1);
    TextDrawUseBox(GangMenuText[10], 1);
    TextDrawBoxColor(GangMenuText[10], 842150655);
    TextDrawTextSize(GangMenuText[10], 501.000000, -1.000000);
    TextDrawSetSelectable(GangMenuText[10], 0);

    GangMenuText[11] = TextDrawCreate(148.000000, 176.000000, "Gangue Matriz");
    TextDrawBackgroundColor(GangMenuText[11], 255);
    TextDrawFont(GangMenuText[11], 2);
    TextDrawLetterSize(GangMenuText[11], 0.170000, 0.699998);
    TextDrawColor(GangMenuText[11], -8388353);
    TextDrawSetOutline(GangMenuText[11], 0);
    TextDrawSetProportional(GangMenuText[11], 1);
    TextDrawSetShadow(GangMenuText[11], 1);
    TextDrawSetSelectable(GangMenuText[11], 0);

    GangMenuText[12] = TextDrawCreate(183.000000, 191.000000, "_");
    TextDrawAlignment(GangMenuText[12], 2);
    TextDrawBackgroundColor(GangMenuText[12], 255);
    TextDrawFont(GangMenuText[12], 1);
    TextDrawLetterSize(GangMenuText[12], 0.500000, 5.899999);
    TextDrawColor(GangMenuText[12], -1);
    TextDrawSetOutline(GangMenuText[12], 0);
    TextDrawSetProportional(GangMenuText[12], 1);
    TextDrawSetShadow(GangMenuText[12], 1);
    TextDrawUseBox(GangMenuText[12], 1);
    TextDrawBoxColor(GangMenuText[12], 255);
    TextDrawTextSize(GangMenuText[12], 221.000000, 60.000000);
    TextDrawSetSelectable(GangMenuText[12], 0);

    GangMenuText[13] = TextDrawCreate(183.000000, 191.000000, "Grove Street");
    TextDrawAlignment(GangMenuText[13], 2);
    TextDrawBackgroundColor(GangMenuText[13], 0);
    TextDrawFont(GangMenuText[13], 2);
    TextDrawLetterSize(GangMenuText[13], 0.159999, 0.699998);
    TextDrawColor(GangMenuText[13], 8388863);
    TextDrawSetOutline(GangMenuText[13], 1);
    TextDrawSetProportional(GangMenuText[13], 1);
    TextDrawUseBox(GangMenuText[13], 1);
    TextDrawBoxColor(GangMenuText[13], 842150655);
    TextDrawTextSize(GangMenuText[13], 221.000000, 60.000000);
    TextDrawSetSelectable(GangMenuText[13], 0);

    GangMenuText[14] = TextDrawCreate(148.000000, 203.000000, "preview-grove-right");
    TextDrawBackgroundColor(GangMenuText[14], 0);
    TextDrawFont(GangMenuText[14], 5);
    TextDrawLetterSize(GangMenuText[14], 0.500000, 1.000000);
    TextDrawColor(GangMenuText[14], -1);
    TextDrawSetOutline(GangMenuText[14], 0);
    TextDrawSetProportional(GangMenuText[14], 1);
    TextDrawSetShadow(GangMenuText[14], 1);
    TextDrawUseBox(GangMenuText[14], 1);
    TextDrawBoxColor(GangMenuText[14], 0);
    TextDrawTextSize(GangMenuText[14], 37.000000, 37.000000);
    TextDrawSetPreviewModel(GangMenuText[14], 105);
    TextDrawSetPreviewRot(GangMenuText[14], 0.000000, 0.000000, -20.000000, 1.000000);
    TextDrawSetSelectable(GangMenuText[14], 0);

    GangMenuText[15] = TextDrawCreate(163.000000, 207.000000, "preview-gang-grove-center");
    TextDrawBackgroundColor(GangMenuText[15], 0);
    TextDrawFont(GangMenuText[15], 5);
    TextDrawLetterSize(GangMenuText[15], 0.500000, 1.000000);
    TextDrawColor(GangMenuText[15], -1);
    TextDrawSetOutline(GangMenuText[15], 0);
    TextDrawSetProportional(GangMenuText[15], 1);
    TextDrawSetShadow(GangMenuText[15], 1);
    TextDrawUseBox(GangMenuText[15], 1);
    TextDrawBoxColor(GangMenuText[15], 0);
    TextDrawTextSize(GangMenuText[15], 37.000000, 37.000000);
    TextDrawSetPreviewModel(GangMenuText[15], 106);
    TextDrawSetPreviewRot(GangMenuText[15], 0.000000, 0.000000, 0.000000, 1.000000);
    TextDrawSetSelectable(GangMenuText[15], 0);

    GangMenuText[16] = TextDrawCreate(178.000000, 203.000000, "preview-gang-grove-left");
    TextDrawBackgroundColor(GangMenuText[16], 0);
    TextDrawFont(GangMenuText[16], 5);
    TextDrawLetterSize(GangMenuText[16], 0.500000, 1.000000);
    TextDrawColor(GangMenuText[16], -1);
    TextDrawSetOutline(GangMenuText[16], 0);
    TextDrawSetProportional(GangMenuText[16], 1);
    TextDrawSetShadow(GangMenuText[16], 1);
    TextDrawUseBox(GangMenuText[16], 1);
    TextDrawBoxColor(GangMenuText[16], 0);
    TextDrawTextSize(GangMenuText[16], 37.000000, 37.000000);
    TextDrawSetPreviewModel(GangMenuText[16], 107);
    TextDrawSetPreviewRot(GangMenuText[16], 0.000000, 0.000000, 20.000000, 1.000000);
    TextDrawSetSelectable(GangMenuText[16], 0);

    GangMenuText[17] = TextDrawCreate(253.000000, 191.000000, "_");
    TextDrawAlignment(GangMenuText[17], 2);
    TextDrawBackgroundColor(GangMenuText[17], 255);
    TextDrawFont(GangMenuText[17], 1);
    TextDrawLetterSize(GangMenuText[17], 0.500000, 5.899999);
    TextDrawColor(GangMenuText[17], -1);
    TextDrawSetOutline(GangMenuText[17], 0);
    TextDrawSetProportional(GangMenuText[17], 1);
    TextDrawSetShadow(GangMenuText[17], 1);
    TextDrawUseBox(GangMenuText[17], 1);
    TextDrawBoxColor(GangMenuText[17], 255);
    TextDrawTextSize(GangMenuText[17], 221.000000, 60.000000);
    TextDrawSetSelectable(GangMenuText[17], 0);

    GangMenuText[18] = TextDrawCreate(253.000000, 191.000000, "The Ballas");
    TextDrawAlignment(GangMenuText[18], 2);
    TextDrawBackgroundColor(GangMenuText[18], 0);
    TextDrawFont(GangMenuText[18], 2);
    TextDrawLetterSize(GangMenuText[18], 0.159998, 0.699998);
    TextDrawColor(GangMenuText[18], -1727987713);
    TextDrawSetOutline(GangMenuText[18], 1);
    TextDrawSetProportional(GangMenuText[18], 1);
    TextDrawUseBox(GangMenuText[18], 1);
    TextDrawBoxColor(GangMenuText[18], 842150655);
    TextDrawTextSize(GangMenuText[18], 221.000000, 60.000000);
    TextDrawSetSelectable(GangMenuText[18], 0);

    GangMenuText[19] = TextDrawCreate(217.000000, 203.000000, "preview-gang-ballas-left");
    TextDrawBackgroundColor(GangMenuText[19], 0);
    TextDrawFont(GangMenuText[19], 5);
    TextDrawLetterSize(GangMenuText[19], 0.500000, 1.000000);
    TextDrawColor(GangMenuText[19], -1);
    TextDrawSetOutline(GangMenuText[19], 0);
    TextDrawSetProportional(GangMenuText[19], 1);
    TextDrawSetShadow(GangMenuText[19], 1);
    TextDrawUseBox(GangMenuText[19], 1);
    TextDrawBoxColor(GangMenuText[19], 0);
    TextDrawTextSize(GangMenuText[19], 37.000000, 37.000000);
    TextDrawSetPreviewModel(GangMenuText[19], 102);
    TextDrawSetPreviewRot(GangMenuText[19], 0.000000, 0.000000, -20.000000, 1.000000);
    TextDrawSetSelectable(GangMenuText[19], 0);

    GangMenuText[20] = TextDrawCreate(233.000000, 207.000000, "preview-gang-ballas-center");
    TextDrawBackgroundColor(GangMenuText[20], 0);
    TextDrawFont(GangMenuText[20], 5);
    TextDrawLetterSize(GangMenuText[20], 0.500000, 1.000000);
    TextDrawColor(GangMenuText[20], -1);
    TextDrawSetOutline(GangMenuText[20], 0);
    TextDrawSetProportional(GangMenuText[20], 1);
    TextDrawSetShadow(GangMenuText[20], 1);
    TextDrawUseBox(GangMenuText[20], 1);
    TextDrawBoxColor(GangMenuText[20], 0);
    TextDrawTextSize(GangMenuText[20], 37.000000, 37.000000);
    TextDrawSetPreviewModel(GangMenuText[20], 103);
    TextDrawSetPreviewRot(GangMenuText[20], 0.000000, 0.000000, 0.000000, 1.000000);
    TextDrawSetSelectable(GangMenuText[20], 0);

    GangMenuText[21] = TextDrawCreate(248.000000, 203.000000, "preview-gang-ballas-left");
    TextDrawBackgroundColor(GangMenuText[21], 0);
    TextDrawFont(GangMenuText[21], 5);
    TextDrawLetterSize(GangMenuText[21], 0.500000, 1.000000);
    TextDrawColor(GangMenuText[21], -1);
    TextDrawSetOutline(GangMenuText[21], 0);
    TextDrawSetProportional(GangMenuText[21], 1);
    TextDrawSetShadow(GangMenuText[21], 1);
    TextDrawUseBox(GangMenuText[21], 1);
    TextDrawBoxColor(GangMenuText[21], 0);
    TextDrawTextSize(GangMenuText[21], 37.000000, 37.000000);
    TextDrawSetPreviewModel(GangMenuText[21], 104);
    TextDrawSetPreviewRot(GangMenuText[21], 0.000000, 0.000000, 20.000000, 1.000000);
    TextDrawSetSelectable(GangMenuText[21], 0);

    GangMenuText[22] = TextDrawCreate(323.000000, 191.000000, "_");
    TextDrawAlignment(GangMenuText[22], 2);
    TextDrawBackgroundColor(GangMenuText[22], 255);
    TextDrawFont(GangMenuText[22], 1);
    TextDrawLetterSize(GangMenuText[22], 0.500000, 5.899999);
    TextDrawColor(GangMenuText[22], -1);
    TextDrawSetOutline(GangMenuText[22], 0);
    TextDrawSetProportional(GangMenuText[22], 1);
    TextDrawSetShadow(GangMenuText[22], 1);
    TextDrawUseBox(GangMenuText[22], 1);
    TextDrawBoxColor(GangMenuText[22], 255);
    TextDrawTextSize(GangMenuText[22], 221.000000, 60.000000);
    TextDrawSetSelectable(GangMenuText[22], 0);

    GangMenuText[23] = TextDrawCreate(394.000000, 191.000000, "_");
    TextDrawAlignment(GangMenuText[23], 2);
    TextDrawBackgroundColor(GangMenuText[23], 255);
    TextDrawFont(GangMenuText[23], 1);
    TextDrawLetterSize(GangMenuText[23], 0.500000, 5.899999);
    TextDrawColor(GangMenuText[23], -1);
    TextDrawSetOutline(GangMenuText[23], 0);
    TextDrawSetProportional(GangMenuText[23], 1);
    TextDrawSetShadow(GangMenuText[23], 1);
    TextDrawUseBox(GangMenuText[23], 1);
    TextDrawBoxColor(GangMenuText[23], 255);
    TextDrawTextSize(GangMenuText[23], 221.000000, 60.000000);
    TextDrawSetSelectable(GangMenuText[23], 0);

    GangMenuText[24] = TextDrawCreate(464.000000, 191.000000, "_");
    TextDrawAlignment(GangMenuText[24], 2);
    TextDrawBackgroundColor(GangMenuText[24], 255);
    TextDrawFont(GangMenuText[24], 1);
    TextDrawLetterSize(GangMenuText[24], 0.500000, 5.899999);
    TextDrawColor(GangMenuText[24], -1);
    TextDrawSetOutline(GangMenuText[24], 0);
    TextDrawSetProportional(GangMenuText[24], 1);
    TextDrawSetShadow(GangMenuText[24], 1);
    TextDrawUseBox(GangMenuText[24], 1);
    TextDrawBoxColor(GangMenuText[24], 255);
    TextDrawTextSize(GangMenuText[24], 221.000000, 60.000000);
    TextDrawSetSelectable(GangMenuText[24], 0);

    GangMenuText[25] = TextDrawCreate(183.000000, 254.000000, "_");
    TextDrawAlignment(GangMenuText[25], 2);
    TextDrawBackgroundColor(GangMenuText[25], 255);
    TextDrawFont(GangMenuText[25], 1);
    TextDrawLetterSize(GangMenuText[25], 0.500000, 5.899999);
    TextDrawColor(GangMenuText[25], -1);
    TextDrawSetOutline(GangMenuText[25], 0);
    TextDrawSetProportional(GangMenuText[25], 1);
    TextDrawSetShadow(GangMenuText[25], 1);
    TextDrawUseBox(GangMenuText[25], 1);
    TextDrawBoxColor(GangMenuText[25], 255);
    TextDrawTextSize(GangMenuText[25], 221.000000, 60.000000);
    TextDrawSetSelectable(GangMenuText[25], 0);

    GangMenuText[26] = TextDrawCreate(253.000000, 254.000000, "_");
    TextDrawAlignment(GangMenuText[26], 2);
    TextDrawBackgroundColor(GangMenuText[26], 255);
    TextDrawFont(GangMenuText[26], 1);
    TextDrawLetterSize(GangMenuText[26], 0.500000, 5.899999);
    TextDrawColor(GangMenuText[26], -1);
    TextDrawSetOutline(GangMenuText[26], 0);
    TextDrawSetProportional(GangMenuText[26], 1);
    TextDrawSetShadow(GangMenuText[26], 1);
    TextDrawUseBox(GangMenuText[26], 1);
    TextDrawBoxColor(GangMenuText[26], 255);
    TextDrawTextSize(GangMenuText[26], 221.000000, 60.000000);
    TextDrawSetSelectable(GangMenuText[26], 0);

    GangMenuText[27] = TextDrawCreate(323.000000, 254.000000, "_");
    TextDrawAlignment(GangMenuText[27], 2);
    TextDrawBackgroundColor(GangMenuText[27], 255);
    TextDrawFont(GangMenuText[27], 1);
    TextDrawLetterSize(GangMenuText[27], 0.500000, 5.899999);
    TextDrawColor(GangMenuText[27], -1);
    TextDrawSetOutline(GangMenuText[27], 0);
    TextDrawSetProportional(GangMenuText[27], 1);
    TextDrawSetShadow(GangMenuText[27], 1);
    TextDrawUseBox(GangMenuText[27], 1);
    TextDrawBoxColor(GangMenuText[27], 255);
    TextDrawTextSize(GangMenuText[27], 221.000000, 60.000000);
    TextDrawSetSelectable(GangMenuText[27], 0);

    GangMenuText[28] = TextDrawCreate(394.000000, 254.000000, "_");
    TextDrawAlignment(GangMenuText[28], 2);
    TextDrawBackgroundColor(GangMenuText[28], 255);
    TextDrawFont(GangMenuText[28], 1);
    TextDrawLetterSize(GangMenuText[28], 0.500000, 5.899999);
    TextDrawColor(GangMenuText[28], -1);
    TextDrawSetOutline(GangMenuText[28], 0);
    TextDrawSetProportional(GangMenuText[28], 1);
    TextDrawSetShadow(GangMenuText[28], 1);
    TextDrawUseBox(GangMenuText[28], 1);
    TextDrawBoxColor(GangMenuText[28], 255);
    TextDrawTextSize(GangMenuText[28], 221.000000, 60.000000);
    TextDrawSetSelectable(GangMenuText[28], 0);

    GangMenuText[29] = TextDrawCreate(464.000000, 254.000000, "_");
    TextDrawAlignment(GangMenuText[29], 2);
    TextDrawBackgroundColor(GangMenuText[29], 255);
    TextDrawFont(GangMenuText[29], 1);
    TextDrawLetterSize(GangMenuText[29], 0.500000, 5.899999);
    TextDrawColor(GangMenuText[29], -1);
    TextDrawSetOutline(GangMenuText[29], 0);
    TextDrawSetProportional(GangMenuText[29], 1);
    TextDrawSetShadow(GangMenuText[29], 1);
    TextDrawUseBox(GangMenuText[29], 1);
    TextDrawBoxColor(GangMenuText[29], 255);
    TextDrawTextSize(GangMenuText[29], 221.000000, 60.000000);
    TextDrawSetSelectable(GangMenuText[29], 0);

    GangMenuText[30] = TextDrawCreate(323.000000, 191.000000, "Los Aztecas");
    TextDrawAlignment(GangMenuText[30], 2);
    TextDrawBackgroundColor(GangMenuText[30], 0);
    TextDrawFont(GangMenuText[30], 2);
    TextDrawLetterSize(GangMenuText[30], 0.159997, 0.699998);
    TextDrawColor(GangMenuText[30], 16777215);
    TextDrawSetOutline(GangMenuText[30], 1);
    TextDrawSetProportional(GangMenuText[30], 1);
    TextDrawUseBox(GangMenuText[30], 1);
    TextDrawBoxColor(GangMenuText[30], 842150655);
    TextDrawTextSize(GangMenuText[30], 221.000000, 60.000000);
    TextDrawSetSelectable(GangMenuText[30], 0);

    GangMenuText[31] = TextDrawCreate(288.000000, 203.000000, "preview-aztecas-right");
    TextDrawBackgroundColor(GangMenuText[31], 0);
    TextDrawFont(GangMenuText[31], 5);
    TextDrawLetterSize(GangMenuText[31], 0.500000, 1.000000);
    TextDrawColor(GangMenuText[31], -1);
    TextDrawSetOutline(GangMenuText[31], 0);
    TextDrawSetProportional(GangMenuText[31], 1);
    TextDrawSetShadow(GangMenuText[31], 1);
    TextDrawUseBox(GangMenuText[31], 1);
    TextDrawBoxColor(GangMenuText[31], 0);
    TextDrawTextSize(GangMenuText[31], 37.000000, 37.000000);
    TextDrawSetPreviewModel(GangMenuText[31], 114);
    TextDrawSetPreviewRot(GangMenuText[31], 0.000000, 0.000000, -20.000000, 1.000000);
    TextDrawSetSelectable(GangMenuText[31], 0);

    GangMenuText[32] = TextDrawCreate(303.000000, 207.000000, "preview-aztecas-center");
    TextDrawBackgroundColor(GangMenuText[32], 0);
    TextDrawFont(GangMenuText[32], 5);
    TextDrawLetterSize(GangMenuText[32], 0.500000, 1.000000);
    TextDrawColor(GangMenuText[32], -1);
    TextDrawSetOutline(GangMenuText[32], 0);
    TextDrawSetProportional(GangMenuText[32], 1);
    TextDrawSetShadow(GangMenuText[32], 1);
    TextDrawUseBox(GangMenuText[32], 1);
    TextDrawBoxColor(GangMenuText[32], 0);
    TextDrawTextSize(GangMenuText[32], 37.000000, 37.000000);
    TextDrawSetPreviewModel(GangMenuText[32], 115);
    TextDrawSetPreviewRot(GangMenuText[32], 0.000000, 0.000000, 0.000000, 1.000000);
    TextDrawSetSelectable(GangMenuText[32], 0);

    GangMenuText[33] = TextDrawCreate(318.000000, 203.000000, "preview-aztecas-left");
    TextDrawBackgroundColor(GangMenuText[33], 0);
    TextDrawFont(GangMenuText[33], 5);
    TextDrawLetterSize(GangMenuText[33], 0.500000, 1.000000);
    TextDrawColor(GangMenuText[33], -1);
    TextDrawSetOutline(GangMenuText[33], 0);
    TextDrawSetProportional(GangMenuText[33], 1);
    TextDrawSetShadow(GangMenuText[33], 1);
    TextDrawUseBox(GangMenuText[33], 1);
    TextDrawBoxColor(GangMenuText[33], 0);
    TextDrawTextSize(GangMenuText[33], 37.000000, 37.000000);
    TextDrawSetPreviewModel(GangMenuText[33], 116);
    TextDrawSetPreviewRot(GangMenuText[33], 0.000000, 0.000000, 20.000000, 1.000000);
    TextDrawSetSelectable(GangMenuText[33], 0);

    GangMenuText[34] = TextDrawCreate(394.000000, 191.000000, "L. Santos Vagos");
    TextDrawAlignment(GangMenuText[34], 2);
    TextDrawBackgroundColor(GangMenuText[34], 0);
    TextDrawFont(GangMenuText[34], 2);
    TextDrawLetterSize(GangMenuText[34], 0.159997, 0.699998);
    TextDrawColor(GangMenuText[34], -2686721);
    TextDrawSetOutline(GangMenuText[34], 1);
    TextDrawSetProportional(GangMenuText[34], 1);
    TextDrawUseBox(GangMenuText[34], 1);
    TextDrawBoxColor(GangMenuText[34], 842150655);
    TextDrawTextSize(GangMenuText[34], 221.000000, 60.000000);
    TextDrawSetSelectable(GangMenuText[34], 0);

    GangMenuText[35] = TextDrawCreate(358.000000, 203.000000, "preview-vagos-right");
    TextDrawBackgroundColor(GangMenuText[35], 0);
    TextDrawFont(GangMenuText[35], 5);
    TextDrawLetterSize(GangMenuText[35], 0.500000, 1.000000);
    TextDrawColor(GangMenuText[35], -1);
    TextDrawSetOutline(GangMenuText[35], 0);
    TextDrawSetProportional(GangMenuText[35], 1);
    TextDrawSetShadow(GangMenuText[35], 1);
    TextDrawUseBox(GangMenuText[35], 1);
    TextDrawBoxColor(GangMenuText[35], 0);
    TextDrawTextSize(GangMenuText[35], 37.000000, 37.000000);
    TextDrawSetPreviewModel(GangMenuText[35], 108);
    TextDrawSetPreviewRot(GangMenuText[35], 0.000000, 0.000000, -20.000000, 1.000000);
    TextDrawSetSelectable(GangMenuText[35], 0);

    GangMenuText[36] = TextDrawCreate(374.000000, 207.000000, "preview-vagos-center");
    TextDrawBackgroundColor(GangMenuText[36], 0);
    TextDrawFont(GangMenuText[36], 5);
    TextDrawLetterSize(GangMenuText[36], 0.500000, 1.000000);
    TextDrawColor(GangMenuText[36], -1);
    TextDrawSetOutline(GangMenuText[36], 0);
    TextDrawSetProportional(GangMenuText[36], 1);
    TextDrawSetShadow(GangMenuText[36], 1);
    TextDrawUseBox(GangMenuText[36], 1);
    TextDrawBoxColor(GangMenuText[36], 0);
    TextDrawTextSize(GangMenuText[36], 37.000000, 37.000000);
    TextDrawSetPreviewModel(GangMenuText[36], 109);
    TextDrawSetPreviewRot(GangMenuText[36], 0.000000, 0.000000, 0.000000, 1.000000);
    TextDrawSetSelectable(GangMenuText[36], 0);

    GangMenuText[37] = TextDrawCreate(389.000000, 203.000000, "preview-vagos-left");
    TextDrawBackgroundColor(GangMenuText[37], 0);
    TextDrawFont(GangMenuText[37], 5);
    TextDrawLetterSize(GangMenuText[37], 0.500000, 1.000000);
    TextDrawColor(GangMenuText[37], -1);
    TextDrawSetOutline(GangMenuText[37], 0);
    TextDrawSetProportional(GangMenuText[37], 1);
    TextDrawSetShadow(GangMenuText[37], 1);
    TextDrawUseBox(GangMenuText[37], 1);
    TextDrawBoxColor(GangMenuText[37], 0);
    TextDrawTextSize(GangMenuText[37], 37.000000, 37.000000);
    TextDrawSetPreviewModel(GangMenuText[37], 110);
    TextDrawSetPreviewRot(GangMenuText[37], 0.000000, 0.000000, 20.000000, 1.000000);
    TextDrawSetSelectable(GangMenuText[37], 0);


    GangMenuText[38] = TextDrawCreate(464.000000, 191.000000, "S. Fierro Rifa");
    TextDrawAlignment(GangMenuText[38], 2);
    TextDrawBackgroundColor(GangMenuText[38], 0);
    TextDrawFont(GangMenuText[38], 2);
    TextDrawLetterSize(GangMenuText[38], 0.159997, 0.699998);
    TextDrawColor(GangMenuText[38], -1);
    TextDrawSetOutline(GangMenuText[38], 1);
    TextDrawSetProportional(GangMenuText[38], 1);
    TextDrawUseBox(GangMenuText[38], 1);
    TextDrawBoxColor(GangMenuText[38], 842150655);
    TextDrawTextSize(GangMenuText[38], 221.000000, 60.000000);
    TextDrawSetSelectable(GangMenuText[38], 0);

    GangMenuText[39] = TextDrawCreate(428.000000, 203.000000, "preview-rifa-right");
    TextDrawBackgroundColor(GangMenuText[39], 0);
    TextDrawFont(GangMenuText[39], 5);
    TextDrawLetterSize(GangMenuText[39], 0.500000, 1.000000);
    TextDrawColor(GangMenuText[39], -1);
    TextDrawSetOutline(GangMenuText[39], 0);
    TextDrawSetProportional(GangMenuText[39], 1);
    TextDrawSetShadow(GangMenuText[39], 1);
    TextDrawUseBox(GangMenuText[39], 1);
    TextDrawBoxColor(GangMenuText[39], 0);
    TextDrawTextSize(GangMenuText[39], 37.000000, 37.000000);
    TextDrawSetPreviewModel(GangMenuText[39], 173);
    TextDrawSetPreviewRot(GangMenuText[39], 0.000000, 0.000000, -20.000000, 1.000000);
    TextDrawSetSelectable(GangMenuText[39], 0);

    GangMenuText[40] = TextDrawCreate(444.000000, 207.000000, "preview-rifa-center");
    TextDrawBackgroundColor(GangMenuText[40], 0);
    TextDrawFont(GangMenuText[40], 5);
    TextDrawLetterSize(GangMenuText[40], 0.500000, 1.000000);
    TextDrawColor(GangMenuText[40], -1);
    TextDrawSetOutline(GangMenuText[40], 0);
    TextDrawSetProportional(GangMenuText[40], 1);
    TextDrawSetShadow(GangMenuText[40], 1);
    TextDrawUseBox(GangMenuText[40], 1);
    TextDrawBoxColor(GangMenuText[40], 0);
    TextDrawTextSize(GangMenuText[40], 37.000000, 37.000000);
    TextDrawSetPreviewModel(GangMenuText[40], 174);
    TextDrawSetPreviewRot(GangMenuText[40], 0.000000, 0.000000, 0.000000, 1.000000);
    TextDrawSetSelectable(GangMenuText[40], 0);

    GangMenuText[41] = TextDrawCreate(459.000000, 203.000000, "preview-rifa-left");
    TextDrawBackgroundColor(GangMenuText[41], 0);
    TextDrawFont(GangMenuText[41], 5);
    TextDrawLetterSize(GangMenuText[41], 0.500000, 1.000000);
    TextDrawColor(GangMenuText[41], -1);
    TextDrawSetOutline(GangMenuText[41], 0);
    TextDrawSetProportional(GangMenuText[41], 1);
    TextDrawSetShadow(GangMenuText[41], 1);
    TextDrawUseBox(GangMenuText[41], 1);
    TextDrawBoxColor(GangMenuText[41], 0);
    TextDrawTextSize(GangMenuText[41], 37.000000, 37.000000);
    TextDrawSetPreviewModel(GangMenuText[41], 175);
    TextDrawSetPreviewRot(GangMenuText[41], 0.000000, 0.000000, 20.000000, 1.000000);
    TextDrawSetSelectable(GangMenuText[41], 0);


    GangMenuText[42] = TextDrawCreate(183.000000, 254.000000, "Chinese Triads");
    TextDrawAlignment(GangMenuText[42], 2);
    TextDrawBackgroundColor(GangMenuText[42], 0);
    TextDrawFont(GangMenuText[42], 2);
    TextDrawLetterSize(GangMenuText[42], 0.159998, 0.699998);
    TextDrawColor(GangMenuText[42], -16776961);
    TextDrawSetOutline(GangMenuText[42], 1);
    TextDrawSetProportional(GangMenuText[42], 1);
    TextDrawUseBox(GangMenuText[42], 1);
    TextDrawBoxColor(GangMenuText[42], 842150655);
    TextDrawTextSize(GangMenuText[42], 221.000000, 60.000000);
    TextDrawSetSelectable(GangMenuText[42], 0);

    GangMenuText[43] = TextDrawCreate(148.000000, 266.000000, "preview-triads-right");
    TextDrawBackgroundColor(GangMenuText[43], 0);
    TextDrawFont(GangMenuText[43], 5);
    TextDrawLetterSize(GangMenuText[43], 0.500000, 1.000000);
    TextDrawColor(GangMenuText[43], -1);
    TextDrawSetOutline(GangMenuText[43], 0);
    TextDrawSetProportional(GangMenuText[43], 1);
    TextDrawSetShadow(GangMenuText[43], 1);
    TextDrawUseBox(GangMenuText[43], 1);
    TextDrawBoxColor(GangMenuText[43], 0);
    TextDrawTextSize(GangMenuText[43], 37.000000, 37.000000);
    TextDrawSetPreviewModel(GangMenuText[43], 117);
    TextDrawSetPreviewRot(GangMenuText[43], 0.000000, 0.000000, -20.000000, 1.000000);
    TextDrawSetSelectable(GangMenuText[43], 0);

    GangMenuText[44] = TextDrawCreate(164.000000, 269.000000, "preview-triads-center");
    TextDrawBackgroundColor(GangMenuText[44], 0);
    TextDrawFont(GangMenuText[44], 5);
    TextDrawLetterSize(GangMenuText[44], 0.500000, 1.000000);
    TextDrawColor(GangMenuText[44], -1);
    TextDrawSetOutline(GangMenuText[44], 0);
    TextDrawSetProportional(GangMenuText[44], 1);
    TextDrawSetShadow(GangMenuText[44], 1);
    TextDrawUseBox(GangMenuText[44], 1);
    TextDrawBoxColor(GangMenuText[44], 0);
    TextDrawTextSize(GangMenuText[44], 37.000000, 37.000000);
    TextDrawSetPreviewModel(GangMenuText[44], 120);
    TextDrawSetPreviewRot(GangMenuText[44], 0.000000, 0.000000, 0.000000, 1.000000);
    TextDrawSetSelectable(GangMenuText[44], 0);

    GangMenuText[45] = TextDrawCreate(176.000000, 266.000000, "preview-triads-left");
    TextDrawBackgroundColor(GangMenuText[45], 0);
    TextDrawFont(GangMenuText[45], 5);
    TextDrawLetterSize(GangMenuText[45], 0.500000, 1.000000);
    TextDrawColor(GangMenuText[45], -1);
    TextDrawSetOutline(GangMenuText[45], 0);
    TextDrawSetProportional(GangMenuText[45], 1);
    TextDrawSetShadow(GangMenuText[45], 1);
    TextDrawUseBox(GangMenuText[45], 1);
    TextDrawBoxColor(GangMenuText[45], 0);
    TextDrawTextSize(GangMenuText[45], 37.000000, 37.000000);
    TextDrawSetPreviewModel(GangMenuText[45], 118);
    TextDrawSetPreviewRot(GangMenuText[45], 0.000000, 0.000000, 20.000000, 1.000000);
    TextDrawSetSelectable(GangMenuText[45], 0);

    GangMenuText[46] = TextDrawCreate(253.000000, 254.000000, "Da Nang Boys");
    TextDrawAlignment(GangMenuText[46], 2);
    TextDrawBackgroundColor(GangMenuText[46], 0);
    TextDrawFont(GangMenuText[46], 2);
    TextDrawLetterSize(GangMenuText[46], 0.159998, 0.699998);
    TextDrawColor(GangMenuText[46], -1721368321);
    TextDrawSetOutline(GangMenuText[46], 1);
    TextDrawSetProportional(GangMenuText[46], 1);
    TextDrawUseBox(GangMenuText[46], 1);
    TextDrawBoxColor(GangMenuText[46], 842150655);
    TextDrawTextSize(GangMenuText[46], 221.000000, 60.000000);
    TextDrawSetSelectable(GangMenuText[46], 0);

    GangMenuText[47] = TextDrawCreate(217.000000, 266.000000, "preview-nang-right");
    TextDrawBackgroundColor(GangMenuText[47], 0);
    TextDrawFont(GangMenuText[47], 5);
    TextDrawLetterSize(GangMenuText[47], 0.500000, 1.000000);
    TextDrawColor(GangMenuText[47], -1);
    TextDrawSetOutline(GangMenuText[47], 0);
    TextDrawSetProportional(GangMenuText[47], 1);
    TextDrawSetShadow(GangMenuText[47], 1);
    TextDrawUseBox(GangMenuText[47], 1);
    TextDrawBoxColor(GangMenuText[47], 0);
    TextDrawTextSize(GangMenuText[47], 37.000000, 37.000000);
    TextDrawSetPreviewModel(GangMenuText[47], 121);
    TextDrawSetPreviewRot(GangMenuText[47], 0.000000, 0.000000, -20.000000, 1.000000);
    TextDrawSetSelectable(GangMenuText[47], 0);

    GangMenuText[48] = TextDrawCreate(233.000000, 269.000000, "preview-nang-center");
    TextDrawBackgroundColor(GangMenuText[48], 0);
    TextDrawFont(GangMenuText[48], 5);
    TextDrawLetterSize(GangMenuText[48], 0.500000, 1.000000);
    TextDrawColor(GangMenuText[48], -1);
    TextDrawSetOutline(GangMenuText[48], 0);
    TextDrawSetProportional(GangMenuText[48], 1);
    TextDrawSetShadow(GangMenuText[48], 1);
    TextDrawUseBox(GangMenuText[48], 1);
    TextDrawBoxColor(GangMenuText[48], 0);
    TextDrawTextSize(GangMenuText[48], 37.000000, 37.000000);
    TextDrawSetPreviewModel(GangMenuText[48], 122);
    TextDrawSetPreviewRot(GangMenuText[48], 0.000000, 0.000000, 0.000000, 1.000000);
    TextDrawSetSelectable(GangMenuText[48], 0);

    GangMenuText[49] = TextDrawCreate(247.000000, 266.000000, "preview-nang-left");
    TextDrawBackgroundColor(GangMenuText[49], 0);
    TextDrawFont(GangMenuText[49], 5);
    TextDrawLetterSize(GangMenuText[49], 0.500000, 1.000000);
    TextDrawColor(GangMenuText[49], -1);
    TextDrawSetOutline(GangMenuText[49], 0);
    TextDrawSetProportional(GangMenuText[49], 1);
    TextDrawSetShadow(GangMenuText[49], 1);
    TextDrawUseBox(GangMenuText[49], 1);
    TextDrawBoxColor(GangMenuText[49], 0);
    TextDrawTextSize(GangMenuText[49], 37.000000, 37.000000);
    TextDrawSetPreviewModel(GangMenuText[49], 123);
    TextDrawSetPreviewRot(GangMenuText[49], 0.000000, 0.000000, 20.000000, 1.000000);
    TextDrawSetSelectable(GangMenuText[49], 0);

    GangMenuText[50] = TextDrawCreate(323.000000, 254.000000, "Russian Mafia");
    TextDrawAlignment(GangMenuText[50], 2);
    TextDrawBackgroundColor(GangMenuText[50], 0);
    TextDrawFont(GangMenuText[50], 2);
    TextDrawLetterSize(GangMenuText[50], 0.159998, 0.699998);
    TextDrawColor(GangMenuText[50], 1718000127);
    TextDrawSetOutline(GangMenuText[50], 1);
    TextDrawSetProportional(GangMenuText[50], 1);
    TextDrawUseBox(GangMenuText[50], 1);
    TextDrawBoxColor(GangMenuText[50], 842150655);
    TextDrawTextSize(GangMenuText[50], 221.000000, 60.000000);
    TextDrawSetSelectable(GangMenuText[50], 0);

    GangMenuText[51] = TextDrawCreate(288.000000, 266.000000, "preview-russian-right");
    TextDrawBackgroundColor(GangMenuText[51], 0);
    TextDrawFont(GangMenuText[51], 5);
    TextDrawLetterSize(GangMenuText[51], 0.500000, 1.000000);
    TextDrawColor(GangMenuText[51], -1);
    TextDrawSetOutline(GangMenuText[51], 0);
    TextDrawSetProportional(GangMenuText[51], 1);
    TextDrawSetShadow(GangMenuText[51], 1);
    TextDrawUseBox(GangMenuText[51], 1);
    TextDrawBoxColor(GangMenuText[51], 0);
    TextDrawTextSize(GangMenuText[51], 37.000000, 37.000000);
    TextDrawSetPreviewModel(GangMenuText[51], 111);
    TextDrawSetPreviewRot(GangMenuText[51], 0.000000, 0.000000, -20.000000, 1.000000);
    TextDrawSetSelectable(GangMenuText[51], 0);

    GangMenuText[52] = TextDrawCreate(304.000000, 269.000000, "preview-russian-center");
    TextDrawBackgroundColor(GangMenuText[52], 0);
    TextDrawFont(GangMenuText[52], 5);
    TextDrawLetterSize(GangMenuText[52], 0.500000, 1.000000);
    TextDrawColor(GangMenuText[52], -1);
    TextDrawSetOutline(GangMenuText[52], 0);
    TextDrawSetProportional(GangMenuText[52], 1);
    TextDrawSetShadow(GangMenuText[52], 1);
    TextDrawUseBox(GangMenuText[52], 1);
    TextDrawBoxColor(GangMenuText[52], 0);
    TextDrawTextSize(GangMenuText[52], 37.000000, 37.000000);
    TextDrawSetPreviewModel(GangMenuText[52], 112);
    TextDrawSetPreviewRot(GangMenuText[52], 0.000000, 0.000000, 0.000000, 1.000000);
    TextDrawSetSelectable(GangMenuText[52], 0);

    GangMenuText[53] = TextDrawCreate(318.000000, 266.000000, "preview-russian-left");
    TextDrawBackgroundColor(GangMenuText[53], 0);
    TextDrawFont(GangMenuText[53], 5);
    TextDrawLetterSize(GangMenuText[53], 0.500000, 1.000000);
    TextDrawColor(GangMenuText[53], -1);
    TextDrawSetOutline(GangMenuText[53], 0);
    TextDrawSetProportional(GangMenuText[53], 1);
    TextDrawSetShadow(GangMenuText[53], 1);
    TextDrawUseBox(GangMenuText[53], 1);
    TextDrawBoxColor(GangMenuText[53], 0);
    TextDrawTextSize(GangMenuText[53], 37.000000, 37.000000);
    TextDrawSetPreviewModel(GangMenuText[53], 113);
    TextDrawSetPreviewRot(GangMenuText[53], 0.000000, 0.000000, 20.000000, 1.000000);
    TextDrawSetSelectable(GangMenuText[53], 0);


    GangMenuText[54] = TextDrawCreate(394.000000, 254.000000, "Italian Mafia");
    TextDrawAlignment(GangMenuText[54], 2);
    TextDrawBackgroundColor(GangMenuText[54], 0);
    TextDrawFont(GangMenuText[54], 2);
    TextDrawLetterSize(GangMenuText[54], 0.159998, 0.699998);
    TextDrawColor(GangMenuText[54], 16711935);
    TextDrawSetOutline(GangMenuText[54], 1);
    TextDrawSetProportional(GangMenuText[54], 1);
    TextDrawUseBox(GangMenuText[54], 1);
    TextDrawBoxColor(GangMenuText[54], 842150655);
    TextDrawTextSize(GangMenuText[54], 221.000000, 60.000000);
    TextDrawSetSelectable(GangMenuText[54], 0);

    GangMenuText[55] = TextDrawCreate(358.000000, 266.000000, "preview-italian-right");
    TextDrawBackgroundColor(GangMenuText[55], 0);
    TextDrawFont(GangMenuText[55], 5);
    TextDrawLetterSize(GangMenuText[55], 0.500000, 1.000000);
    TextDrawColor(GangMenuText[55], -1);
    TextDrawSetOutline(GangMenuText[55], 0);
    TextDrawSetProportional(GangMenuText[55], 1);
    TextDrawSetShadow(GangMenuText[55], 1);
    TextDrawUseBox(GangMenuText[55], 1);
    TextDrawBoxColor(GangMenuText[55], 0);
    TextDrawTextSize(GangMenuText[55], 37.000000, 37.000000);
    TextDrawSetPreviewModel(GangMenuText[55], 124);
    TextDrawSetPreviewRot(GangMenuText[55], 0.000000, 0.000000, -20.000000, 1.000000);
    TextDrawSetSelectable(GangMenuText[55], 0);

    GangMenuText[56] = TextDrawCreate(374.000000, 269.000000, "preview-italian-center");
    TextDrawBackgroundColor(GangMenuText[56], 0);
    TextDrawFont(GangMenuText[56], 5);
    TextDrawLetterSize(GangMenuText[56], 0.500000, 1.000000);
    TextDrawColor(GangMenuText[56], -1);
    TextDrawSetOutline(GangMenuText[56], 0);
    TextDrawSetProportional(GangMenuText[56], 1);
    TextDrawSetShadow(GangMenuText[56], 1);
    TextDrawUseBox(GangMenuText[56], 1);
    TextDrawBoxColor(GangMenuText[56], 0);
    TextDrawTextSize(GangMenuText[56], 37.000000, 37.000000);
    TextDrawSetPreviewModel(GangMenuText[56], 125);
    TextDrawSetPreviewRot(GangMenuText[56], 0.000000, 0.000000, 0.000000, 1.000000);
    TextDrawSetSelectable(GangMenuText[56], 0);

    GangMenuText[57] = TextDrawCreate(390.000000, 266.000000, "preview-italian-left");
    TextDrawBackgroundColor(GangMenuText[57], 0);
    TextDrawFont(GangMenuText[57], 5);
    TextDrawLetterSize(GangMenuText[57], 0.500000, 1.000000);
    TextDrawColor(GangMenuText[57], -1);
    TextDrawSetOutline(GangMenuText[57], 0);
    TextDrawSetProportional(GangMenuText[57], 1);
    TextDrawSetShadow(GangMenuText[57], 1);
    TextDrawUseBox(GangMenuText[57], 1);
    TextDrawBoxColor(GangMenuText[57], 0);
    TextDrawTextSize(GangMenuText[57], 37.000000, 37.000000);
    TextDrawSetPreviewModel(GangMenuText[57], 126);
    TextDrawSetPreviewRot(GangMenuText[57], 0.000000, 0.000000, 20.000000, 1.000000);
    TextDrawSetSelectable(GangMenuText[57], 0);


    GangMenuText[58] = TextDrawCreate(464.000000, 254.000000, "American Bikers");
    TextDrawAlignment(GangMenuText[58], 2);
    TextDrawBackgroundColor(GangMenuText[58], 0);
    TextDrawFont(GangMenuText[58], 2);
    TextDrawLetterSize(GangMenuText[58], 0.159998, 0.699998);
    TextDrawColor(GangMenuText[58], 65535);
    TextDrawSetOutline(GangMenuText[58], 1);
    TextDrawSetProportional(GangMenuText[58], 1);
    TextDrawUseBox(GangMenuText[58], 1);
    TextDrawBoxColor(GangMenuText[58], 842150655);
    TextDrawTextSize(GangMenuText[58], 221.000000, 60.000000);
    TextDrawSetSelectable(GangMenuText[58], 0);

    GangMenuText[59] = TextDrawCreate(428.000000, 266.000000, "preview-bikers-right");
    TextDrawBackgroundColor(GangMenuText[59], 0);
    TextDrawFont(GangMenuText[59], 5);
    TextDrawLetterSize(GangMenuText[59], 0.500000, 1.000000);
    TextDrawColor(GangMenuText[59], -1);
    TextDrawSetOutline(GangMenuText[59], 0);
    TextDrawSetProportional(GangMenuText[59], 1);
    TextDrawSetShadow(GangMenuText[59], 1);
    TextDrawUseBox(GangMenuText[59], 1);
    TextDrawBoxColor(GangMenuText[59], 0);
    TextDrawTextSize(GangMenuText[59], 37.000000, 37.000000);
    TextDrawSetPreviewModel(GangMenuText[59], 247);
    TextDrawSetPreviewRot(GangMenuText[59], 0.000000, 0.000000, -20.000000, 1.000000);
    TextDrawSetSelectable(GangMenuText[59], 0);

    GangMenuText[60] = TextDrawCreate(444.000000, 269.000000, "preview-bikers-center");
    TextDrawBackgroundColor(GangMenuText[60], 0);
    TextDrawFont(GangMenuText[60], 5);
    TextDrawLetterSize(GangMenuText[60], 0.500000, 1.000000);
    TextDrawColor(GangMenuText[60], -1);
    TextDrawSetOutline(GangMenuText[60], 0);
    TextDrawSetProportional(GangMenuText[60], 1);
    TextDrawSetShadow(GangMenuText[60], 1);
    TextDrawUseBox(GangMenuText[60], 1);
    TextDrawBoxColor(GangMenuText[60], 0);
    TextDrawTextSize(GangMenuText[60], 37.000000, 37.000000);
    TextDrawSetPreviewModel(GangMenuText[60], 248);
    TextDrawSetPreviewRot(GangMenuText[60], 0.000000, 0.000000, 0.000000, 1.000000);
    TextDrawSetSelectable(GangMenuText[60], 0);

    GangMenuText[61] = TextDrawCreate(459.000000, 266.000000, "preview-bikers-left");
    TextDrawBackgroundColor(GangMenuText[61], 0);
    TextDrawFont(GangMenuText[61], 5);
    TextDrawLetterSize(GangMenuText[61], 0.500000, 1.000000);
    TextDrawColor(GangMenuText[61], -1);
    TextDrawSetOutline(GangMenuText[61], 0);
    TextDrawSetProportional(GangMenuText[61], 1);
    TextDrawSetShadow(GangMenuText[61], 1);
    TextDrawUseBox(GangMenuText[61], 1);
    TextDrawBoxColor(GangMenuText[61], 0);
    TextDrawTextSize(GangMenuText[61], 37.000000, 37.000000);
    TextDrawSetPreviewModel(GangMenuText[61], 254);
    TextDrawSetPreviewRot(GangMenuText[61], 0.000000, 0.000000, 20.000000, 1.000000);
    TextDrawSetSelectable(GangMenuText[61], 0);

    GangMenuText[62] = TextDrawCreate(145.000000, 316.000000, "_");
    TextDrawBackgroundColor(GangMenuText[62], 0);
    TextDrawFont(GangMenuText[62], 2);
    TextDrawLetterSize(GangMenuText[62], 0.159997, -0.400000);
    TextDrawColor(GangMenuText[62], -8388353);
    TextDrawSetOutline(GangMenuText[62], 1);
    TextDrawSetProportional(GangMenuText[62], 1);
    TextDrawUseBox(GangMenuText[62], 1);
    TextDrawBoxColor(GangMenuText[62], 842150655);
    TextDrawTextSize(GangMenuText[62], 501.000000, -1.000000);
    TextDrawSetSelectable(GangMenuText[62], 0);

    GangMenuText[63] = TextDrawCreate(226.000000, 328.000000, "Selecione tres amigos para participar da sua gangue:");
    TextDrawAlignment(GangMenuText[63], 2);
    TextDrawBackgroundColor(GangMenuText[63], 0);
    TextDrawFont(GangMenuText[63], 1);
    TextDrawLetterSize(GangMenuText[63], 0.179997, 1.000000);
    TextDrawColor(GangMenuText[63], -1);
    TextDrawSetOutline(GangMenuText[63], 1);
    TextDrawSetProportional(GangMenuText[63], 1);
    TextDrawUseBox(GangMenuText[63], 1);
    TextDrawBoxColor(GangMenuText[63], 0);
    TextDrawTextSize(GangMenuText[63], 0.000000, 150.000000);
    TextDrawSetSelectable(GangMenuText[63], 0);

    GangMenuText[64] = TextDrawCreate(148.000000, 316.000000, "Convide Amigos:");
    TextDrawBackgroundColor(GangMenuText[64], 255);
    TextDrawFont(GangMenuText[64], 2);
    TextDrawLetterSize(GangMenuText[64], 0.170000, 0.699998);
    TextDrawColor(GangMenuText[64], -8388353);
    TextDrawSetOutline(GangMenuText[64], 0);
    TextDrawSetProportional(GangMenuText[64], 1);
    TextDrawSetShadow(GangMenuText[64], 1);
    TextDrawSetSelectable(GangMenuText[64], 0);

    GangMenuText[65] = TextDrawCreate(312.000000, 317.000000, "_");
    TextDrawBackgroundColor(GangMenuText[65], 0);
    TextDrawFont(GangMenuText[65], 2);
    TextDrawLetterSize(GangMenuText[65], 0.159997, 9.100002);
    TextDrawColor(GangMenuText[65], -1);
    TextDrawSetOutline(GangMenuText[65], 1);
    TextDrawSetProportional(GangMenuText[65], 1);
    TextDrawUseBox(GangMenuText[65], 1);
    TextDrawBoxColor(GangMenuText[65], 842150655);
    TextDrawTextSize(GangMenuText[65], 309.000000, 0.000000);
    TextDrawSetSelectable(GangMenuText[65], 0);

    GangMenuText[66] = TextDrawCreate(319.000000, 316.000000, "Finalizando");
    TextDrawBackgroundColor(GangMenuText[66], 255);
    TextDrawFont(GangMenuText[66], 2);
    TextDrawLetterSize(GangMenuText[66], 0.170000, 0.699998);
    TextDrawColor(GangMenuText[66], -8388353);
    TextDrawSetOutline(GangMenuText[66], 0);
    TextDrawSetProportional(GangMenuText[66], 1);
    TextDrawSetShadow(GangMenuText[66], 1);
    TextDrawSetSelectable(GangMenuText[66], 0);

    GangMenuText[67] = TextDrawCreate(408.000000, 328.000000, "Ao clicar no botao 'CRIAR GANGUE' voce automaticamente sera descontado em $200.000, sera expulso de sua gangue atual e recebera:");
    TextDrawAlignment(GangMenuText[67], 2);
    TextDrawBackgroundColor(GangMenuText[67], 0);
    TextDrawFont(GangMenuText[67], 1);
    TextDrawLetterSize(GangMenuText[67], 0.179997, 1.000000);
    TextDrawColor(GangMenuText[67], -1);
    TextDrawSetOutline(GangMenuText[67], 1);
    TextDrawSetProportional(GangMenuText[67], 1);
    TextDrawUseBox(GangMenuText[67], 1);
    TextDrawBoxColor(GangMenuText[67], 0);
    TextDrawTextSize(GangMenuText[67], 1.000000, 179.000000);
    TextDrawSetSelectable(GangMenuText[67], 0);

    GangMenuText[68] = TextDrawCreate(455.000000, 361.000000, "1x Armazem da Gangue");
    TextDrawAlignment(GangMenuText[68], 2);
    TextDrawBackgroundColor(GangMenuText[68], 0);
    TextDrawFont(GangMenuText[68], 1);
    TextDrawLetterSize(GangMenuText[68], 0.180000, 0.799998);
    TextDrawColor(GangMenuText[68], -8388353);
    TextDrawSetOutline(GangMenuText[68], 1);
    TextDrawSetProportional(GangMenuText[68], 1);
    TextDrawUseBox(GangMenuText[68], 1);
    TextDrawBoxColor(GangMenuText[68], 50);
    TextDrawTextSize(GangMenuText[68], 497.000000, 86.000000);
    TextDrawSetSelectable(GangMenuText[68], 0);

    GangMenuText[69] = TextDrawCreate(361.000000, 361.000000, "1x Escritorio da Gangue");
    TextDrawAlignment(GangMenuText[69], 2);
    TextDrawBackgroundColor(GangMenuText[69], 0);
    TextDrawFont(GangMenuText[69], 1);
    TextDrawLetterSize(GangMenuText[69], 0.180000, 0.799998);
    TextDrawColor(GangMenuText[69], -8388353);
    TextDrawSetOutline(GangMenuText[69], 1);
    TextDrawSetProportional(GangMenuText[69], 1);
    TextDrawUseBox(GangMenuText[69], 1);
    TextDrawBoxColor(GangMenuText[69], 50);
    TextDrawTextSize(GangMenuText[69], 497.000000, 86.000000);
    TextDrawSetSelectable(GangMenuText[69], 0);

    GangMenuText[70] = TextDrawCreate(423.000000, 366.000000, "preview-armazem");
    TextDrawBackgroundColor(GangMenuText[70], 0);
    TextDrawFont(GangMenuText[70], 5);
    TextDrawLetterSize(GangMenuText[70], 0.500000, 1.000000);
    TextDrawColor(GangMenuText[70], -1);
    TextDrawSetOutline(GangMenuText[70], 0);
    TextDrawSetProportional(GangMenuText[70], 1);
    TextDrawSetShadow(GangMenuText[70], 1);
    TextDrawUseBox(GangMenuText[70], 1);
    TextDrawBoxColor(GangMenuText[70], 255);
    TextDrawTextSize(GangMenuText[70], 62.000000, 36.000000);
    TextDrawSetPreviewModel(GangMenuText[70], 939);
    TextDrawSetPreviewRot(GangMenuText[70], 0.000000, 0.000000, 0.000000, 1.000000);
    TextDrawSetSelectable(GangMenuText[70], 0);

    GangMenuText[71] = TextDrawCreate(310.000000, 360.000000, "preview-escritorio");
    TextDrawBackgroundColor(GangMenuText[71], 0);
    TextDrawFont(GangMenuText[71], 5);
    TextDrawLetterSize(GangMenuText[71], 0.500000, 1.000000);
    TextDrawColor(GangMenuText[71], -1);
    TextDrawSetOutline(GangMenuText[71], 0);
    TextDrawSetProportional(GangMenuText[71], 1);
    TextDrawSetShadow(GangMenuText[71], 1);
    TextDrawUseBox(GangMenuText[71], 1);
    TextDrawBoxColor(GangMenuText[71], 255);
    TextDrawTextSize(GangMenuText[71], 67.000000, 47.000000);
    TextDrawSetPreviewModel(GangMenuText[71], 2165);
    TextDrawSetPreviewRot(GangMenuText[71], 0.000000, 0.000000, 180.000000, 1.000000);
    TextDrawSetSelectable(GangMenuText[71], 0);

    GangMenuText[72] = TextDrawCreate(323.000000, 403.000000, "CRIAR GANGUE");
    TextDrawAlignment(GangMenuText[72], 2);
    TextDrawBackgroundColor(GangMenuText[72], 255);
    TextDrawFont(GangMenuText[72], 1);
    TextDrawLetterSize(GangMenuText[72], 0.190000, 0.799999);
    TextDrawColor(GangMenuText[72], -1768515841);
    TextDrawSetOutline(GangMenuText[72], 0);
    TextDrawSetProportional(GangMenuText[72], 1);
    TextDrawSetShadow(GangMenuText[72], 1);
    TextDrawUseBox(GangMenuText[72], 1);
    TextDrawBoxColor(GangMenuText[72], 150);
    TextDrawTextSize(GangMenuText[72], 369.000000, 356.000000);
    TextDrawSetSelectable(GangMenuText[72], 1);

    GangMenuText[73] = TextDrawCreate(496.000000, 110.000000, "X");
    TextDrawAlignment(GangMenuText[73], 2);
    TextDrawBackgroundColor(GangMenuText[73], 0);
    TextDrawFont(GangMenuText[73], 1);
    TextDrawLetterSize(GangMenuText[73], 0.300000, 0.699999);
    TextDrawColor(GangMenuText[73], -16776961);
    TextDrawSetOutline(GangMenuText[73], 1);
    TextDrawSetProportional(GangMenuText[73], 1);
    TextDrawUseBox(GangMenuText[73], 1);
    TextDrawBoxColor(GangMenuText[73], 50);
    TextDrawTextSize(GangMenuText[73], 13.000000, 7.000000);
    TextDrawSetSelectable(GangMenuText[73], 1);
    return 1;
}

hook OnPlayerConnect(playerid)
{
    GangMenuPlayerText[playerid][0] = CreatePlayerTextDraw(playerid,151.000000, 149.000000, "Insira um nome...");
    PlayerTextDrawBackgroundColor(playerid,GangMenuPlayerText[playerid][0], 0);
    PlayerTextDrawFont(playerid,GangMenuPlayerText[playerid][0], 2);
    PlayerTextDrawLetterSize(playerid,GangMenuPlayerText[playerid][0], 0.209999, 0.699998);
    PlayerTextDrawColor(playerid,GangMenuPlayerText[playerid][0], -1);
    PlayerTextDrawSetOutline(playerid,GangMenuPlayerText[playerid][0], 1);
    PlayerTextDrawSetProportional(playerid,GangMenuPlayerText[playerid][0], 1);
    PlayerTextDrawUseBox(playerid,GangMenuPlayerText[playerid][0], 1);
    PlayerTextDrawBoxColor(playerid,GangMenuPlayerText[playerid][0], -1768515841);
    PlayerTextDrawTextSize(playerid,GangMenuPlayerText[playerid][0], 303.000000, 13.000000);
    PlayerTextDrawSetSelectable(playerid,GangMenuPlayerText[playerid][0], 1);

    GangMenuPlayerText[playerid][1] = CreatePlayerTextDraw(playerid,210.000000, 240.000000, "_");
    PlayerTextDrawAlignment(playerid,GangMenuPlayerText[playerid][1], 2);
    PlayerTextDrawBackgroundColor(playerid,GangMenuPlayerText[playerid][1], 255);
    PlayerTextDrawFont(playerid,GangMenuPlayerText[playerid][1], 1);
    PlayerTextDrawLetterSize(playerid,GangMenuPlayerText[playerid][1], 0.250000, 0.499998);
    PlayerTextDrawColor(playerid,GangMenuPlayerText[playerid][1], 16711935);
    PlayerTextDrawSetOutline(playerid,GangMenuPlayerText[playerid][1], 0);
    PlayerTextDrawSetProportional(playerid,GangMenuPlayerText[playerid][1], 1);
    PlayerTextDrawSetShadow(playerid,GangMenuPlayerText[playerid][1], 1);
    PlayerTextDrawUseBox(playerid,GangMenuPlayerText[playerid][1], 1);
    PlayerTextDrawBoxColor(playerid,GangMenuPlayerText[playerid][1], 842150655);
    PlayerTextDrawTextSize(playerid,GangMenuPlayerText[playerid][1], 221.000000, 7.000000);
    PlayerTextDrawSetSelectable(playerid,GangMenuPlayerText[playerid][1], 1);

    GangMenuPlayerText[playerid][2] = CreatePlayerTextDraw(playerid,280.000000, 240.000000, "_");
    PlayerTextDrawAlignment(playerid,GangMenuPlayerText[playerid][2], 2);
    PlayerTextDrawBackgroundColor(playerid,GangMenuPlayerText[playerid][2], 255);
    PlayerTextDrawFont(playerid,GangMenuPlayerText[playerid][2], 1);
    PlayerTextDrawLetterSize(playerid,GangMenuPlayerText[playerid][2], 0.250000, 0.499998);
    PlayerTextDrawColor(playerid,GangMenuPlayerText[playerid][2], -1727987713);
    PlayerTextDrawSetOutline(playerid,GangMenuPlayerText[playerid][2], 0);
    PlayerTextDrawSetProportional(playerid,GangMenuPlayerText[playerid][2], 1);
    PlayerTextDrawSetShadow(playerid,GangMenuPlayerText[playerid][2], 1);
    PlayerTextDrawUseBox(playerid,GangMenuPlayerText[playerid][2], 1);
    PlayerTextDrawBoxColor(playerid,GangMenuPlayerText[playerid][2], 842150655);
    PlayerTextDrawTextSize(playerid,GangMenuPlayerText[playerid][2], 221.000000, 7.000000);
    PlayerTextDrawSetSelectable(playerid,GangMenuPlayerText[playerid][2], 1);

    GangMenuPlayerText[playerid][3] = CreatePlayerTextDraw(playerid,350.000000, 240.000000, "_");
    PlayerTextDrawAlignment(playerid,GangMenuPlayerText[playerid][3], 2);
    PlayerTextDrawBackgroundColor(playerid,GangMenuPlayerText[playerid][3], 255);
    PlayerTextDrawFont(playerid,GangMenuPlayerText[playerid][3], 1);
    PlayerTextDrawLetterSize(playerid,GangMenuPlayerText[playerid][3], 0.250000, 0.499998);
    PlayerTextDrawColor(playerid,GangMenuPlayerText[playerid][3], 16777215);
    PlayerTextDrawSetOutline(playerid,GangMenuPlayerText[playerid][3], 0);
    PlayerTextDrawSetProportional(playerid,GangMenuPlayerText[playerid][3], 1);
    PlayerTextDrawSetShadow(playerid,GangMenuPlayerText[playerid][3], 1);
    PlayerTextDrawUseBox(playerid,GangMenuPlayerText[playerid][3], 1);
    PlayerTextDrawBoxColor(playerid,GangMenuPlayerText[playerid][3], 842150655);
    PlayerTextDrawTextSize(playerid,GangMenuPlayerText[playerid][3], 221.000000, 7.000000);
    PlayerTextDrawSetSelectable(playerid,GangMenuPlayerText[playerid][3], 1);

    GangMenuPlayerText[playerid][4] = CreatePlayerTextDraw(playerid,421.000000, 240.000000, "_");
    PlayerTextDrawAlignment(playerid,GangMenuPlayerText[playerid][4], 2);
    PlayerTextDrawBackgroundColor(playerid,GangMenuPlayerText[playerid][4], 255);
    PlayerTextDrawFont(playerid,GangMenuPlayerText[playerid][4], 1);
    PlayerTextDrawLetterSize(playerid,GangMenuPlayerText[playerid][4], 0.250000, 0.499998);
    PlayerTextDrawColor(playerid,GangMenuPlayerText[playerid][4], -2686721);
    PlayerTextDrawSetOutline(playerid,GangMenuPlayerText[playerid][4], 0);
    PlayerTextDrawSetProportional(playerid,GangMenuPlayerText[playerid][4], 1);
    PlayerTextDrawSetShadow(playerid,GangMenuPlayerText[playerid][4], 1);
    PlayerTextDrawUseBox(playerid,GangMenuPlayerText[playerid][4], 1);
    PlayerTextDrawBoxColor(playerid,GangMenuPlayerText[playerid][4], 842150655);
    PlayerTextDrawTextSize(playerid,GangMenuPlayerText[playerid][4], 221.000000, 7.000000);
    PlayerTextDrawSetSelectable(playerid,GangMenuPlayerText[playerid][4], 1);

    GangMenuPlayerText[playerid][5] = CreatePlayerTextDraw(playerid,491.000000, 240.000000, "_");
    PlayerTextDrawAlignment(playerid,GangMenuPlayerText[playerid][5], 2);
    PlayerTextDrawBackgroundColor(playerid,GangMenuPlayerText[playerid][5], 255);
    PlayerTextDrawFont(playerid,GangMenuPlayerText[playerid][5], 1);
    PlayerTextDrawLetterSize(playerid,GangMenuPlayerText[playerid][5], 0.250000, 0.499998);
    PlayerTextDrawColor(playerid,GangMenuPlayerText[playerid][5], -1);
    PlayerTextDrawSetOutline(playerid,GangMenuPlayerText[playerid][5], 0);
    PlayerTextDrawSetProportional(playerid,GangMenuPlayerText[playerid][5], 1);
    PlayerTextDrawSetShadow(playerid,GangMenuPlayerText[playerid][5], 1);
    PlayerTextDrawUseBox(playerid,GangMenuPlayerText[playerid][5], 1);
    PlayerTextDrawBoxColor(playerid,GangMenuPlayerText[playerid][5], 842150655);
    PlayerTextDrawTextSize(playerid,GangMenuPlayerText[playerid][5], 221.000000, 7.000000);
    PlayerTextDrawSetSelectable(playerid,GangMenuPlayerText[playerid][5], 1);

    GangMenuPlayerText[playerid][6] = CreatePlayerTextDraw(playerid,210.000000, 303.000000, "_");
    PlayerTextDrawAlignment(playerid,GangMenuPlayerText[playerid][6], 2);
    PlayerTextDrawBackgroundColor(playerid,GangMenuPlayerText[playerid][6], 255);
    PlayerTextDrawFont(playerid,GangMenuPlayerText[playerid][6], 1);
    PlayerTextDrawLetterSize(playerid,GangMenuPlayerText[playerid][6], 0.250000, 0.499998);
    PlayerTextDrawColor(playerid,GangMenuPlayerText[playerid][6], -16776961);
    PlayerTextDrawSetOutline(playerid,GangMenuPlayerText[playerid][6], 0);
    PlayerTextDrawSetProportional(playerid,GangMenuPlayerText[playerid][6], 1);
    PlayerTextDrawSetShadow(playerid,GangMenuPlayerText[playerid][6], 1);
    PlayerTextDrawUseBox(playerid,GangMenuPlayerText[playerid][6], 1);
    PlayerTextDrawBoxColor(playerid,GangMenuPlayerText[playerid][6], 842150655);
    PlayerTextDrawTextSize(playerid,GangMenuPlayerText[playerid][6], 221.000000, 7.000000);
    PlayerTextDrawSetSelectable(playerid,GangMenuPlayerText[playerid][6], 1);

    GangMenuPlayerText[playerid][7] = CreatePlayerTextDraw(playerid,280.000000, 303.000000, "_");
    PlayerTextDrawAlignment(playerid,GangMenuPlayerText[playerid][7], 2);
    PlayerTextDrawBackgroundColor(playerid,GangMenuPlayerText[playerid][7], 255);
    PlayerTextDrawFont(playerid,GangMenuPlayerText[playerid][7], 1);
    PlayerTextDrawLetterSize(playerid,GangMenuPlayerText[playerid][7], 0.250000, 0.499998);
    PlayerTextDrawColor(playerid,GangMenuPlayerText[playerid][7], -1721368321);
    PlayerTextDrawSetOutline(playerid,GangMenuPlayerText[playerid][7], 0);
    PlayerTextDrawSetProportional(playerid,GangMenuPlayerText[playerid][7], 1);
    PlayerTextDrawSetShadow(playerid,GangMenuPlayerText[playerid][7], 1);
    PlayerTextDrawUseBox(playerid,GangMenuPlayerText[playerid][7], 1);
    PlayerTextDrawBoxColor(playerid,GangMenuPlayerText[playerid][7], 842150655);
    PlayerTextDrawTextSize(playerid,GangMenuPlayerText[playerid][7], 221.000000, 7.000000);
    PlayerTextDrawSetSelectable(playerid,GangMenuPlayerText[playerid][7], 1);

    GangMenuPlayerText[playerid][8] = CreatePlayerTextDraw(playerid,350.000000, 303.000000, "_");
    PlayerTextDrawAlignment(playerid,GangMenuPlayerText[playerid][8], 2);
    PlayerTextDrawBackgroundColor(playerid,GangMenuPlayerText[playerid][8], 255);
    PlayerTextDrawFont(playerid,GangMenuPlayerText[playerid][8], 1);
    PlayerTextDrawLetterSize(playerid,GangMenuPlayerText[playerid][8], 0.250000, 0.499998);
    PlayerTextDrawColor(playerid,GangMenuPlayerText[playerid][8], 1718000127);
    PlayerTextDrawSetOutline(playerid,GangMenuPlayerText[playerid][8], 0);
    PlayerTextDrawSetProportional(playerid,GangMenuPlayerText[playerid][8], 1);
    PlayerTextDrawSetShadow(playerid,GangMenuPlayerText[playerid][8], 1);
    PlayerTextDrawUseBox(playerid,GangMenuPlayerText[playerid][8], 1);
    PlayerTextDrawBoxColor(playerid,GangMenuPlayerText[playerid][8], 842150655);
    PlayerTextDrawTextSize(playerid,GangMenuPlayerText[playerid][8], 221.000000, 7.000000);
    PlayerTextDrawSetSelectable(playerid,GangMenuPlayerText[playerid][8], 1);

    GangMenuPlayerText[playerid][9] = CreatePlayerTextDraw(playerid,421.000000, 303.000000, "_");
    PlayerTextDrawAlignment(playerid,GangMenuPlayerText[playerid][9], 2);
    PlayerTextDrawBackgroundColor(playerid,GangMenuPlayerText[playerid][9], 255);
    PlayerTextDrawFont(playerid,GangMenuPlayerText[playerid][9], 1);
    PlayerTextDrawLetterSize(playerid,GangMenuPlayerText[playerid][9], 0.250000, 0.499998);
    PlayerTextDrawColor(playerid,GangMenuPlayerText[playerid][9], 16711935);
    PlayerTextDrawSetOutline(playerid,GangMenuPlayerText[playerid][9], 0);
    PlayerTextDrawSetProportional(playerid,GangMenuPlayerText[playerid][9], 1);
    PlayerTextDrawSetShadow(playerid,GangMenuPlayerText[playerid][9], 1);
    PlayerTextDrawUseBox(playerid,GangMenuPlayerText[playerid][9], 1);
    PlayerTextDrawBoxColor(playerid,GangMenuPlayerText[playerid][9], 842150655);
    PlayerTextDrawTextSize(playerid,GangMenuPlayerText[playerid][9], 221.000000, 7.000000);
    PlayerTextDrawSetSelectable(playerid,GangMenuPlayerText[playerid][9], 1);

    GangMenuPlayerText[playerid][10] = CreatePlayerTextDraw(playerid,491.000000, 303.000000, "_");
    PlayerTextDrawAlignment(playerid,GangMenuPlayerText[playerid][10], 2);
    PlayerTextDrawBackgroundColor(playerid,GangMenuPlayerText[playerid][10], 255);
    PlayerTextDrawFont(playerid,GangMenuPlayerText[playerid][10], 1);
    PlayerTextDrawLetterSize(playerid,GangMenuPlayerText[playerid][10], 0.250000, 0.499998);
    PlayerTextDrawColor(playerid,GangMenuPlayerText[playerid][10], 65535);
    PlayerTextDrawSetOutline(playerid,GangMenuPlayerText[playerid][10], 0);
    PlayerTextDrawSetProportional(playerid,GangMenuPlayerText[playerid][10], 1);
    PlayerTextDrawSetShadow(playerid,GangMenuPlayerText[playerid][10], 1);
    PlayerTextDrawUseBox(playerid,GangMenuPlayerText[playerid][10], 1);
    PlayerTextDrawBoxColor(playerid,GangMenuPlayerText[playerid][10], 842150655);
    PlayerTextDrawTextSize(playerid,GangMenuPlayerText[playerid][10], 221.000000, 7.000000);
    PlayerTextDrawSetSelectable(playerid,GangMenuPlayerText[playerid][10], 1);

    GangMenuPlayerText[playerid][11] = CreatePlayerTextDraw(playerid,226.000000, 353.000000, "Nenhum Player Selecionado (ID: -1)");
    PlayerTextDrawAlignment(playerid,GangMenuPlayerText[playerid][11], 2);
    PlayerTextDrawBackgroundColor(playerid,GangMenuPlayerText[playerid][11], 0);
    PlayerTextDrawFont(playerid,GangMenuPlayerText[playerid][11], 1);
    PlayerTextDrawLetterSize(playerid,GangMenuPlayerText[playerid][11], 0.179998, 1.000000);
    PlayerTextDrawColor(playerid,GangMenuPlayerText[playerid][11], -1);
    PlayerTextDrawSetOutline(playerid,GangMenuPlayerText[playerid][11], 1);
    PlayerTextDrawSetProportional(playerid,GangMenuPlayerText[playerid][11], 1);
    PlayerTextDrawUseBox(playerid,GangMenuPlayerText[playerid][11], 1);
    PlayerTextDrawBoxColor(playerid,GangMenuPlayerText[playerid][11], 50);
    PlayerTextDrawTextSize(playerid,GangMenuPlayerText[playerid][11], 13.000000, 150.000000);
    PlayerTextDrawSetSelectable(playerid,GangMenuPlayerText[playerid][11], 1);

    GangMenuPlayerText[playerid][12] = CreatePlayerTextDraw(playerid,226.000000, 370.000000, "Nenhum Player Selecionado (ID: -1)");
    PlayerTextDrawAlignment(playerid,GangMenuPlayerText[playerid][12], 2);
    PlayerTextDrawBackgroundColor(playerid,GangMenuPlayerText[playerid][12], 0);
    PlayerTextDrawFont(playerid,GangMenuPlayerText[playerid][12], 1);
    PlayerTextDrawLetterSize(playerid,GangMenuPlayerText[playerid][12], 0.179997, 1.000000);
    PlayerTextDrawColor(playerid,GangMenuPlayerText[playerid][12], -1);
    PlayerTextDrawSetOutline(playerid,GangMenuPlayerText[playerid][12], 1);
    PlayerTextDrawSetProportional(playerid,GangMenuPlayerText[playerid][12], 1);
    PlayerTextDrawUseBox(playerid,GangMenuPlayerText[playerid][12], 1);
    PlayerTextDrawBoxColor(playerid,GangMenuPlayerText[playerid][12], 50);
    PlayerTextDrawTextSize(playerid,GangMenuPlayerText[playerid][12], 13.000000, 150.000000);
    PlayerTextDrawSetSelectable(playerid,GangMenuPlayerText[playerid][12], 1);

    GangMenuPlayerText[playerid][13] = CreatePlayerTextDraw(playerid,226.000000, 386.000000, "Nenhum Player Selecionado (ID: -1)");
    PlayerTextDrawAlignment(playerid,GangMenuPlayerText[playerid][13], 2);
    PlayerTextDrawBackgroundColor(playerid,GangMenuPlayerText[playerid][13], 0);
    PlayerTextDrawFont(playerid,GangMenuPlayerText[playerid][13], 1);
    PlayerTextDrawLetterSize(playerid,GangMenuPlayerText[playerid][13], 0.179997, 1.000000);
    PlayerTextDrawColor(playerid,GangMenuPlayerText[playerid][13], -1);
    PlayerTextDrawSetOutline(playerid,GangMenuPlayerText[playerid][13], 1);
    PlayerTextDrawSetProportional(playerid,GangMenuPlayerText[playerid][13], 1);
    PlayerTextDrawUseBox(playerid,GangMenuPlayerText[playerid][13], 1);
    PlayerTextDrawBoxColor(playerid,GangMenuPlayerText[playerid][13], 50);
    PlayerTextDrawTextSize(playerid,GangMenuPlayerText[playerid][13], 13.000000, 150.000000);
    PlayerTextDrawSetSelectable(playerid,GangMenuPlayerText[playerid][13], 1);
    return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
    for(new i; i < 14; i++)
        PlayerTextDrawDestroy(playerid, GangMenuPlayerText[playerid][i]);
    return 1;
}

stock ShowPlayerGangMenu(playerid)
{
    for(new i; i < sizeof(GangMenuText); i++)
        TextDrawShowForPlayer(playerid, GangMenuText[i]);

    for(new j; j < 14; j++)
        PlayerTextDrawShow(playerid, GangMenuPlayerText[playerid][j]);

    SelectTextDraw(playerid, 0xFFA500FF);
    SetPlayerGangMenuState(playerid, true);
    return 1;
}

stock HidePlayerGangMenu(playerid)
{
    for(new i; i < sizeof(GangMenuText); i++)
        TextDrawHideForPlayer(playerid, GangMenuText[i]);

    for(new j; j < 14; j++)
        PlayerTextDrawHide(playerid, GangMenuPlayerText[playerid][j]);

    CancelSelectTextDraw(playerid);
    SetPlayerGangMenuState(playerid, false);
    return 1;
}

hook OnPlayerClickPlayerTD(playerid, PlayerText:playertextid)
{
    if(playertextid == GangMenuPlayerText[playerid][0]) return ShowPlayerDialog(playerid, DIALOG_CHOOSE_GANGNAME, DIALOG_STYLE_INPUT, "{FFCC00}Qual será o nome de sua gangue?", "Insira um nome válido para sua gangue.\nCaracteres Permitidos:\n *Alfanumericos: A-Z, a-z e 0-9\n *Minimo de 6 caracteres\n  *Máximo de 24 caracteres\n *No máximo 2 underlines", "Pronto", "Voltar");

    for(new i = 1; i <= 10; i++)
    {
        if(playertextid == GangMenuPlayerText[playerid][i])
        {
            PlayerTextDrawSetString(playerid, GangMenuPlayerText[playerid][i], "V");
            PlayerTextDrawShow(playerid, GangMenuPlayerText[playerid][i]);

            for(new j = 1; j <= 10; j++)
            {
                if(j != i)
                {
                    PlayerTextDrawSetString(playerid, GangMenuPlayerText[playerid][j], "_");
                    PlayerTextDrawShow(playerid, GangMenuPlayerText[playerid][j]);
                }
            }
            break;
        }
    }
    return 1;
}


hook OnPlayerClickTextDraw(playerid, Text:clickedid)
{

    if(clickedid == GangMenuText[73]) return OnGangMenuResponse(playerid, "", -1, "", false);
    return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == DIALOG_CHOOSE_GANGNAME)
    {
        if(response)
        {
            if(!OnlyAlphaNumericCharacters(inputtext)) return ShowPlayerDialog(playerid, DIALOG_CHOOSE_GANGNAME, DIALOG_STYLE_INPUT, "{FFCC00}Qual será o nome de sua gangue?", "Insira um nome válido para sua gangue.\nCaracteres Permitidos:\n {FF0000}*Alfanumericos: A-Z, a-z e 0-9\n *Minimo de 6 caracteres\n  *Máximo de 24 caracteres\n *No máximo 2 underlines", "Pronto", "Voltar");
            PlayerTextDrawSetString(playerid, GangMenuPlayerText[playerid][0], inputtext);
            SetPlayerGangMenuName(playerid, inputtext);
        }
    }
    return 1;
}

stock OnlyAlphaNumericCharacters(const string[])
{
	new z = 0;
    new c = 0;
	for(new x, y = strlen(string); x != y; x++)
	{
	    if((string[x] >= 48 && string[x] <= 57) || (string[x] >= 65 && string[x] <= 90) || (string[x] >= 97 && string[x] <= 122) || (string[x] == 95))
	    {
			z++;
            if(string[x] == 95) c++;

		}
	}
	if(z == strlen(string) && c <= 2) return true;
	else return false;
}
