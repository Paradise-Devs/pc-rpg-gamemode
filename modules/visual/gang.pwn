/* *************************************************************************** *
*  Description: Apartment visual module file.
*
*  Assignment: A script to handle gang textdraws.
*
*           Copyright Paradise Devs 2015.  All rights reserved.
* *************************************************************************** */

static Text:GangMenuText[32];


hook OnGameModeInit()
{
    GangMenuText[0] = TextDrawCreate(102.000000, 110.000000, "_");
    TextDrawBackgroundColor(GangMenuText[0], 255);
    TextDrawFont(GangMenuText[0], 1);
    TextDrawLetterSize(GangMenuText[0], 0.500000, 30.500009);
    TextDrawColor(GangMenuText[0], -1);
    TextDrawSetOutline(GangMenuText[0], 0);
    TextDrawSetProportional(GangMenuText[0], 1);
    TextDrawSetShadow(GangMenuText[0], 1);
    TextDrawUseBox(GangMenuText[0], 1);
    TextDrawBoxColor(GangMenuText[0], 100);
    TextDrawTextSize(GangMenuText[0], 542.000000, 0.000000);
    TextDrawSetSelectable(GangMenuText[0], 0);

    GangMenuText[1] = TextDrawCreate(322.000000, 110.000000, "_");
    TextDrawAlignment(GangMenuText[1], 2);
    TextDrawBackgroundColor(GangMenuText[1], 255);
    TextDrawFont(GangMenuText[1], 1);
    TextDrawLetterSize(GangMenuText[1], 0.500000, 1.000000);
    TextDrawColor(GangMenuText[1], -1);
    TextDrawSetOutline(GangMenuText[1], 0);
    TextDrawSetProportional(GangMenuText[1], 1);
    TextDrawSetShadow(GangMenuText[1], 1);
    TextDrawUseBox(GangMenuText[1], 1);
    TextDrawBoxColor(GangMenuText[1], -5635841);
    TextDrawTextSize(GangMenuText[1], 0.000000, 440.000000);
    TextDrawSetSelectable(GangMenuText[1], 0);

    GangMenuText[2] = TextDrawCreate(322.000000, 117.000000, "_");
    TextDrawAlignment(GangMenuText[2], 2);
    TextDrawBackgroundColor(GangMenuText[2], 255);
    TextDrawFont(GangMenuText[2], 1);
    TextDrawLetterSize(GangMenuText[2], 0.500000, 0.499998);
    TextDrawColor(GangMenuText[2], -1);
    TextDrawSetOutline(GangMenuText[2], 0);
    TextDrawSetProportional(GangMenuText[2], 1);
    TextDrawSetShadow(GangMenuText[2], 1);
    TextDrawUseBox(GangMenuText[2], 1);
    TextDrawBoxColor(GangMenuText[2], -7601921);
    TextDrawTextSize(GangMenuText[2], 0.000000, 440.000000);
    TextDrawSetSelectable(GangMenuText[2], 0);

    GangMenuText[3] = TextDrawCreate(278.000000, 111.000000, "CRIAR GANGUE");
    TextDrawBackgroundColor(GangMenuText[3], 0);
    TextDrawFont(GangMenuText[3], 1);
    TextDrawLetterSize(GangMenuText[3], 0.289999, 0.899999);
    TextDrawColor(GangMenuText[3], 255);
    TextDrawSetOutline(GangMenuText[3], 0);
    TextDrawSetProportional(GangMenuText[3], 1);
    TextDrawSetShadow(GangMenuText[3], 1);
    TextDrawSetSelectable(GangMenuText[3], 0);

    GangMenuText[4] = TextDrawCreate(103.000000, 127.000000, "_");
    TextDrawBackgroundColor(GangMenuText[4], 255);
    TextDrawFont(GangMenuText[4], 1);
    TextDrawLetterSize(GangMenuText[4], 0.500000, 8.499998);
    TextDrawColor(GangMenuText[4], -1);
    TextDrawSetOutline(GangMenuText[4], 0);
    TextDrawSetProportional(GangMenuText[4], 1);
    TextDrawSetShadow(GangMenuText[4], 1);
    TextDrawUseBox(GangMenuText[4], 1);
    TextDrawBoxColor(GangMenuText[4], 50);
    TextDrawTextSize(GangMenuText[4], 541.000000, 0.000000);
    TextDrawSetSelectable(GangMenuText[4], 0);

    GangMenuText[5] = TextDrawCreate(103.000000, 209.000000, "_");
    TextDrawBackgroundColor(GangMenuText[5], 255);
    TextDrawFont(GangMenuText[5], 1);
    TextDrawLetterSize(GangMenuText[5], 0.500000, 8.499998);
    TextDrawColor(GangMenuText[5], -1);
    TextDrawSetOutline(GangMenuText[5], 0);
    TextDrawSetProportional(GangMenuText[5], 1);
    TextDrawSetShadow(GangMenuText[5], 1);
    TextDrawUseBox(GangMenuText[5], 1);
    TextDrawBoxColor(GangMenuText[5], 50);
    TextDrawTextSize(GangMenuText[5], 541.000000, 0.000000);
    TextDrawSetSelectable(GangMenuText[5], 0);

    GangMenuText[6] = TextDrawCreate(103.000000, 291.000000, "_");
    TextDrawBackgroundColor(GangMenuText[6], 255);
    TextDrawFont(GangMenuText[6], 1);
    TextDrawLetterSize(GangMenuText[6], 0.500000, 10.300004);
    TextDrawColor(GangMenuText[6], -1);
    TextDrawSetOutline(GangMenuText[6], 0);
    TextDrawSetProportional(GangMenuText[6], 1);
    TextDrawSetShadow(GangMenuText[6], 1);
    TextDrawUseBox(GangMenuText[6], 1);
    TextDrawBoxColor(GangMenuText[6], 50);
    TextDrawTextSize(GangMenuText[6], 541.000000, 0.000000);
    TextDrawSetSelectable(GangMenuText[6], 0);

    GangMenuText[7] = TextDrawCreate(478.000000, 373.000000, "__Prosseguir >>");
    TextDrawBackgroundColor(GangMenuText[7], 255);
    TextDrawFont(GangMenuText[7], 2);
    TextDrawLetterSize(GangMenuText[7], 0.170000, 1.099997);
    TextDrawColor(GangMenuText[7], -5963521);
    TextDrawSetOutline(GangMenuText[7], 0);
    TextDrawSetProportional(GangMenuText[7], 1);
    TextDrawSetShadow(GangMenuText[7], 1);
    TextDrawUseBox(GangMenuText[7], 1);
    TextDrawBoxColor(GangMenuText[7], 100);
    TextDrawTextSize(GangMenuText[7], 540.000000, 13.000000);
    TextDrawSetSelectable(GangMenuText[7], 1);

    GangMenuText[8] = TextDrawCreate(106.000000, 128.000000, "O que sera necessario?");
    TextDrawBackgroundColor(GangMenuText[8], 255);
    TextDrawFont(GangMenuText[8], 2);
    TextDrawLetterSize(GangMenuText[8], 0.159998, 0.899999);
    TextDrawColor(GangMenuText[8], -5963521);
    TextDrawSetOutline(GangMenuText[8], 0);
    TextDrawSetProportional(GangMenuText[8], 1);
    TextDrawSetShadow(GangMenuText[8], 1);
    TextDrawSetSelectable(GangMenuText[8], 0);

    GangMenuText[9] = TextDrawCreate(540.000000, 209.000000, "Como funcionam as gangues?");
    TextDrawAlignment(GangMenuText[9], 3);
    TextDrawBackgroundColor(GangMenuText[9], 255);
    TextDrawFont(GangMenuText[9], 2);
    TextDrawLetterSize(GangMenuText[9], 0.159998, 0.899999);
    TextDrawColor(GangMenuText[9], -5963521);
    TextDrawSetOutline(GangMenuText[9], 0);
    TextDrawSetProportional(GangMenuText[9], 1);
    TextDrawSetShadow(GangMenuText[9], 1);
    TextDrawSetSelectable(GangMenuText[9], 0);

    GangMenuText[10] = TextDrawCreate(106.000000, 291.000000, "O que recebo ao criar minha gangue?");
    TextDrawBackgroundColor(GangMenuText[10], 255);
    TextDrawFont(GangMenuText[10], 2);
    TextDrawLetterSize(GangMenuText[10], 0.159998, 0.899999);
    TextDrawColor(GangMenuText[10], -5963521);
    TextDrawSetOutline(GangMenuText[10], 0);
    TextDrawSetProportional(GangMenuText[10], 1);
    TextDrawSetShadow(GangMenuText[10], 1);
    TextDrawSetSelectable(GangMenuText[10], 0);

    GangMenuText[11] = TextDrawCreate(124.000000, 139.000000, "A fim de que gangues nao sejam criadas randomicamente, a Equipe Paradise estabeleceu alguns criterios a serem seguidos...");
    TextDrawBackgroundColor(GangMenuText[11], 0);
    TextDrawFont(GangMenuText[11], 1);
    TextDrawLetterSize(GangMenuText[11], 0.179998, 1.099998);
    TextDrawColor(GangMenuText[11], -1);
    TextDrawSetOutline(GangMenuText[11], 0);
    TextDrawSetProportional(GangMenuText[11], 1);
    TextDrawSetShadow(GangMenuText[11], 1);
    TextDrawUseBox(GangMenuText[11], 1);
    TextDrawBoxColor(GangMenuText[11], 0);
    TextDrawTextSize(GangMenuText[11], 361.000000, 239.000000);
    TextDrawSetSelectable(GangMenuText[11], 0);

    GangMenuText[12] = TextDrawCreate(124.000000, 163.000000, "Antes de iniciar o processo de criacao de sua gangue, verifique se voce preenche todos os requisitos aqui citados:");
    TextDrawBackgroundColor(GangMenuText[12], 0);
    TextDrawFont(GangMenuText[12], 1);
    TextDrawLetterSize(GangMenuText[12], 0.179998, 1.099998);
    TextDrawColor(GangMenuText[12], -1);
    TextDrawSetOutline(GangMenuText[12], 0);
    TextDrawSetProportional(GangMenuText[12], 1);
    TextDrawSetShadow(GangMenuText[12], 1);
    TextDrawUseBox(GangMenuText[12], 1);
    TextDrawBoxColor(GangMenuText[12], 0);
    TextDrawTextSize(GangMenuText[12], 361.000000, 239.000000);
    TextDrawSetSelectable(GangMenuText[12], 0);

    GangMenuText[13] = TextDrawCreate(273.000000, 219.000000, "Atraves de sua gangue voce pode juntar seus amigos para gerar lucro dominando territorios de venda de drogas.");
    TextDrawBackgroundColor(GangMenuText[13], 0);
    TextDrawFont(GangMenuText[13], 1);
    TextDrawLetterSize(GangMenuText[13], 0.179998, 1.099998);
    TextDrawColor(GangMenuText[13], -1);
    TextDrawSetOutline(GangMenuText[13], 0);
    TextDrawSetProportional(GangMenuText[13], 1);
    TextDrawSetShadow(GangMenuText[13], 1);
    TextDrawUseBox(GangMenuText[13], 1);
    TextDrawBoxColor(GangMenuText[13], 0);
    TextDrawTextSize(GangMenuText[13], 521.000000, 239.000000);
    TextDrawSetSelectable(GangMenuText[13], 0);

    GangMenuText[14] = TextDrawCreate(273.000000, 239.000000, "Na disputa por territorios voce entrara em combate com a policia e outras gangues locais, e recebe experiencia por isso.");
    TextDrawBackgroundColor(GangMenuText[14], 0);
    TextDrawFont(GangMenuText[14], 1);
    TextDrawLetterSize(GangMenuText[14], 0.179998, 1.099998);
    TextDrawColor(GangMenuText[14], -1);
    TextDrawSetOutline(GangMenuText[14], 0);
    TextDrawSetProportional(GangMenuText[14], 1);
    TextDrawSetShadow(GangMenuText[14], 1);
    TextDrawUseBox(GangMenuText[14], 1);
    TextDrawBoxColor(GangMenuText[14], 0);
    TextDrawTextSize(GangMenuText[14], 521.000000, 239.000000);
    TextDrawSetSelectable(GangMenuText[14], 0);

    GangMenuText[15] = TextDrawCreate(273.000000, 260.000000, "Os territorios geram um lucro por hora, assim e possivel adquirir novos itens nos armazens ou ate mesmo aprimorar sua gangue!");
    TextDrawBackgroundColor(GangMenuText[15], 0);
    TextDrawFont(GangMenuText[15], 1);
    TextDrawLetterSize(GangMenuText[15], 0.179998, 1.099998);
    TextDrawColor(GangMenuText[15], -1);
    TextDrawSetOutline(GangMenuText[15], 0);
    TextDrawSetProportional(GangMenuText[15], 1);
    TextDrawSetShadow(GangMenuText[15], 1);
    TextDrawUseBox(GangMenuText[15], 1);
    TextDrawBoxColor(GangMenuText[15], 0);
    TextDrawTextSize(GangMenuText[15], 521.000000, 239.000000);
    TextDrawSetSelectable(GangMenuText[15], 0);

    GangMenuText[16] = TextDrawCreate(124.000000, 301.000000, "Ao criar sua gangue voce recebera os seguintes beneficios:");
    TextDrawBackgroundColor(GangMenuText[16], 0);
    TextDrawFont(GangMenuText[16], 1);
    TextDrawLetterSize(GangMenuText[16], 0.179998, 1.099998);
    TextDrawColor(GangMenuText[16], -1);
    TextDrawSetOutline(GangMenuText[16], 0);
    TextDrawSetProportional(GangMenuText[16], 1);
    TextDrawSetShadow(GangMenuText[16], 1);
    TextDrawUseBox(GangMenuText[16], 1);
    TextDrawBoxColor(GangMenuText[16], 0);
    TextDrawTextSize(GangMenuText[16], 361.000000, 239.000000);
    TextDrawSetSelectable(GangMenuText[16], 0);

    GangMenuText[17] = TextDrawCreate(450.000000, 138.000000, "$150.000");
    TextDrawBackgroundColor(GangMenuText[17], 255);
    TextDrawFont(GangMenuText[17], 1);
    TextDrawLetterSize(GangMenuText[17], 0.289999, 1.000000);
    TextDrawColor(GangMenuText[17], -2686721);
    TextDrawSetOutline(GangMenuText[17], 0);
    TextDrawSetProportional(GangMenuText[17], 1);
    TextDrawSetShadow(GangMenuText[17], 1);
    TextDrawSetSelectable(GangMenuText[17], 0);

    GangMenuText[18] = TextDrawCreate(450.000000, 151.000000, "Nivel 3 (ou maior)");
    TextDrawBackgroundColor(GangMenuText[18], 0);
    TextDrawFont(GangMenuText[18], 1);
    TextDrawLetterSize(GangMenuText[18], 0.230000, 1.000000);
    TextDrawColor(GangMenuText[18], -2686721);
    TextDrawSetOutline(GangMenuText[18], 0);
    TextDrawSetProportional(GangMenuText[18], 1);
    TextDrawSetShadow(GangMenuText[18], 1);
    TextDrawSetSelectable(GangMenuText[18], 0);

    GangMenuText[19] = TextDrawCreate(450.000000, 165.000000, "Dois amigos");
    TextDrawBackgroundColor(GangMenuText[19], 0);
    TextDrawFont(GangMenuText[19], 1);
    TextDrawLetterSize(GangMenuText[19], 0.230000, 1.000000);
    TextDrawColor(GangMenuText[19], -2686721);
    TextDrawSetOutline(GangMenuText[19], 0);
    TextDrawSetProportional(GangMenuText[19], 1);
    TextDrawSetShadow(GangMenuText[19], 1);
    TextDrawSetSelectable(GangMenuText[19], 0);

    GangMenuText[20] = TextDrawCreate(439.000000, 140.000000, "LD_POOL:ball");
    TextDrawBackgroundColor(GangMenuText[20], 255);
    TextDrawFont(GangMenuText[20], 4);
    TextDrawLetterSize(GangMenuText[20], 0.500000, 1.000000);
    TextDrawColor(GangMenuText[20], -1);
    TextDrawSetOutline(GangMenuText[20], 0);
    TextDrawSetProportional(GangMenuText[20], 1);
    TextDrawSetShadow(GangMenuText[20], 1);
    TextDrawUseBox(GangMenuText[20], 1);
    TextDrawBoxColor(GangMenuText[20], 255);
    TextDrawTextSize(GangMenuText[20], 5.000000, 6.000000);
    TextDrawSetSelectable(GangMenuText[20], 0);

    GangMenuText[21] = TextDrawCreate(439.000000, 153.000000, "LD_POOL:ball");
    TextDrawBackgroundColor(GangMenuText[21], 255);
    TextDrawFont(GangMenuText[21], 4);
    TextDrawLetterSize(GangMenuText[21], 0.500000, 1.000000);
    TextDrawColor(GangMenuText[21], -1);
    TextDrawSetOutline(GangMenuText[21], 0);
    TextDrawSetProportional(GangMenuText[21], 1);
    TextDrawSetShadow(GangMenuText[21], 1);
    TextDrawUseBox(GangMenuText[21], 1);
    TextDrawBoxColor(GangMenuText[21], 255);
    TextDrawTextSize(GangMenuText[21], 5.000000, 6.000000);
    TextDrawSetSelectable(GangMenuText[21], 0);

    GangMenuText[22] = TextDrawCreate(439.000000, 167.000000, "LD_POOL:ball");
    TextDrawBackgroundColor(GangMenuText[22], 255);
    TextDrawFont(GangMenuText[22], 4);
    TextDrawLetterSize(GangMenuText[22], 0.500000, 1.000000);
    TextDrawColor(GangMenuText[22], -1);
    TextDrawSetOutline(GangMenuText[22], 0);
    TextDrawSetProportional(GangMenuText[22], 1);
    TextDrawSetShadow(GangMenuText[22], 1);
    TextDrawUseBox(GangMenuText[22], 1);
    TextDrawBoxColor(GangMenuText[22], 255);
    TextDrawTextSize(GangMenuText[22], 5.000000, 6.000000);
    TextDrawSetSelectable(GangMenuText[22], 0);

    GangMenuText[23] = TextDrawCreate(126.000000, 223.000000, "LD_POKE:cd11c");
    TextDrawBackgroundColor(GangMenuText[23], 255);
    TextDrawFont(GangMenuText[23], 4);
    TextDrawLetterSize(GangMenuText[23], 0.500000, 1.000000);
    TextDrawColor(GangMenuText[23], -1);
    TextDrawSetOutline(GangMenuText[23], 0);
    TextDrawSetProportional(GangMenuText[23], 1);
    TextDrawSetShadow(GangMenuText[23], 1);
    TextDrawUseBox(GangMenuText[23], 1);
    TextDrawBoxColor(GangMenuText[23], 255);
    TextDrawTextSize(GangMenuText[23], 41.000000, 47.000000);
    TextDrawSetSelectable(GangMenuText[23], 0);

    GangMenuText[24] = TextDrawCreate(119.000000, 321.000000, "1x Escritorio da gangue");
    TextDrawBackgroundColor(GangMenuText[24], 255);
    TextDrawFont(GangMenuText[24], 1);
    TextDrawLetterSize(GangMenuText[24], 0.239999, 1.000000);
    TextDrawColor(GangMenuText[24], -2686721);
    TextDrawSetOutline(GangMenuText[24], 0);
    TextDrawSetProportional(GangMenuText[24], 1);
    TextDrawSetShadow(GangMenuText[24], 1);
    TextDrawSetSelectable(GangMenuText[24], 0);

    GangMenuText[25] = TextDrawCreate(127.000000, 325.000000, "preview-gang-office");
    TextDrawBackgroundColor(GangMenuText[25], 0);
    TextDrawFont(GangMenuText[25], 5);
    TextDrawLetterSize(GangMenuText[25], 0.500000, 1.000000);
    TextDrawColor(GangMenuText[25], -1);
    TextDrawSetOutline(GangMenuText[25], 0);
    TextDrawSetProportional(GangMenuText[25], 1);
    TextDrawSetShadow(GangMenuText[25], 1);
    TextDrawUseBox(GangMenuText[25], 1);
    TextDrawBoxColor(GangMenuText[25], 0);
    TextDrawTextSize(GangMenuText[25], 51.000000, 45.000000);
    TextDrawSetPreviewModel(GangMenuText[25], 2165);
    TextDrawSetPreviewRot(GangMenuText[25], 0.000000, 0.000000, 180.000000, 1.000000);
    TextDrawSetSelectable(GangMenuText[25], 0);

    GangMenuText[26] = TextDrawCreate(232.000000, 321.000000, "1x Armazem da gangue");
    TextDrawBackgroundColor(GangMenuText[26], 255);
    TextDrawFont(GangMenuText[26], 1);
    TextDrawLetterSize(GangMenuText[26], 0.239999, 1.000000);
    TextDrawColor(GangMenuText[26], -2686721);
    TextDrawSetOutline(GangMenuText[26], 0);
    TextDrawSetProportional(GangMenuText[26], 1);
    TextDrawSetShadow(GangMenuText[26], 1);
    TextDrawSetSelectable(GangMenuText[26], 0);

    GangMenuText[27] = TextDrawCreate(252.000000, 325.000000, "preview-gang-depot");
    TextDrawBackgroundColor(GangMenuText[27], 0);
    TextDrawFont(GangMenuText[27], 5);
    TextDrawLetterSize(GangMenuText[27], 0.500000, 1.000000);
    TextDrawColor(GangMenuText[27], -1);
    TextDrawSetOutline(GangMenuText[27], 0);
    TextDrawSetProportional(GangMenuText[27], 1);
    TextDrawSetShadow(GangMenuText[27], 1);
    TextDrawUseBox(GangMenuText[27], 1);
    TextDrawBoxColor(GangMenuText[27], 0);
    TextDrawTextSize(GangMenuText[27], 46.000000, 40.000000);
    TextDrawSetPreviewModel(GangMenuText[27], 939);
    TextDrawSetPreviewRot(GangMenuText[27], 0.000000, 0.000000, 180.000000, 1.000000);
    TextDrawSetSelectable(GangMenuText[27], 0);

    GangMenuText[28] = TextDrawCreate(342.000000, 321.000000, "3x Skins exclusivas da gangue");
    TextDrawBackgroundColor(GangMenuText[28], 255);
    TextDrawFont(GangMenuText[28], 1);
    TextDrawLetterSize(GangMenuText[28], 0.239999, 1.000000);
    TextDrawColor(GangMenuText[28], -2686721);
    TextDrawSetOutline(GangMenuText[28], 0);
    TextDrawSetProportional(GangMenuText[28], 1);
    TextDrawSetShadow(GangMenuText[28], 1);
    TextDrawSetSelectable(GangMenuText[28], 0);

    GangMenuText[29] = TextDrawCreate(372.000000, 332.000000, "New Textdraw");
    TextDrawBackgroundColor(GangMenuText[29], 0);
    TextDrawFont(GangMenuText[29], 5);
    TextDrawLetterSize(GangMenuText[29], 0.500000, 1.000000);
    TextDrawColor(GangMenuText[29], -1);
    TextDrawSetOutline(GangMenuText[29], 0);
    TextDrawSetProportional(GangMenuText[29], 1);
    TextDrawSetShadow(GangMenuText[29], 1);
    TextDrawUseBox(GangMenuText[29], 1);
    TextDrawBoxColor(GangMenuText[29], 255);
    TextDrawTextSize(GangMenuText[29], 30.000000, 29.000000);
    TextDrawSetPreviewModel(GangMenuText[29], 106);
    TextDrawSetPreviewRot(GangMenuText[29], -16.000000, 0.000000, -55.000000, 1.000000);
    TextDrawSetSelectable(GangMenuText[29], 0);

    GangMenuText[30] = TextDrawCreate(384.000000, 336.000000, "New Textdraw");
    TextDrawBackgroundColor(GangMenuText[30], 0);
    TextDrawFont(GangMenuText[30], 5);
    TextDrawLetterSize(GangMenuText[30], 0.500000, 1.000000);
    TextDrawColor(GangMenuText[30], -1);
    TextDrawSetOutline(GangMenuText[30], 0);
    TextDrawSetProportional(GangMenuText[30], 1);
    TextDrawSetShadow(GangMenuText[30], 1);
    TextDrawUseBox(GangMenuText[30], 1);
    TextDrawBoxColor(GangMenuText[30], 255);
    TextDrawTextSize(GangMenuText[30], 30.000000, 29.000000);
    TextDrawSetPreviewModel(GangMenuText[30], 105);
    TextDrawSetPreviewRot(GangMenuText[30], -16.000000, 0.000000, 0.000000, 1.000000);
    TextDrawSetSelectable(GangMenuText[30], 0);

    GangMenuText[31] = TextDrawCreate(397.000000, 332.000000, "New Textdraw");
    TextDrawBackgroundColor(GangMenuText[31], 0);
    TextDrawFont(GangMenuText[31], 5);
    TextDrawLetterSize(GangMenuText[31], 0.500000, 1.000000);
    TextDrawColor(GangMenuText[31], -1);
    TextDrawSetOutline(GangMenuText[31], 0);
    TextDrawSetProportional(GangMenuText[31], 1);
    TextDrawSetShadow(GangMenuText[31], 1);
    TextDrawUseBox(GangMenuText[31], 1);
    TextDrawBoxColor(GangMenuText[31], 255);
    TextDrawTextSize(GangMenuText[31], 30.000000, 29.000000);
    TextDrawSetPreviewModel(GangMenuText[31], 107);
    TextDrawSetPreviewRot(GangMenuText[31], -16.000000, 0.000000, 45.000000, 1.000000);
    TextDrawSetSelectable(GangMenuText[31], 0);
    return 1;
}

ShowPlayerGangMenu(playerid)
{
    for(new i; i < sizeof(GangMenuText); i++)
        TextDrawShowForPlayer(playerid, Text:GangMenuText[i]);
    SelectTextDraw(playerid, 0xFFFFFFFF);
    return 1;
}

HidePlayerGangMenu(playerid)
{
    for(new i; i < sizeof(GangMenuText); i++)
        TextDrawHideForPlayer(playerid, Text:GangMenuText[i]);
    CancelSelectTextDraw(playerid);
    return 1;
}
