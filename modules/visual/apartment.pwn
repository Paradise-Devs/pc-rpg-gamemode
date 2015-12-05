/* *************************************************************************** *
*  Description: Apartment visual module file.
*
*  Assignment: A script to handle apartment textdraws.
*
*           Copyright Paradise Devs 2015.  All rights reserved.
* *************************************************************************** */

#if defined _MODULE_vsapartment
	#endinput
#endif
#define _MODULE_vsapartment

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

static const Float:SELECTION_BASE_X = 57.8;
static const Float:SELECTION_BASE_Y = 70.7;

//------------------------------------------------------------------------------

// Category IDs
enum
{
    CATEGORY_TABLES,
    CATEGORY_ELETRO,
    CATEGORY_COUCH,
    CATEGORY_KITCHEN,
    CATEGORY_BATH,
    CATEGORY_DECO,
    CATEGORY_BEDS,
    CATEGORY_CHAIR,
    CATEGORY_PLANTS
}

// Category names
new gCategoryName[][] =
{
    {"Mesas - Armarios"},
	{"Eletrodomesticos"},
	{"Sofas"},
	{"Cozinha"},
    {"Banheiro"},
	{"Decorativo"},
	{"Camas"},
	{"Cadeiras"},
    {"Plantas"}
};

// Description
new gCategoryDesc[][] =
{
	{"Mesas são estruturas, geralmente de madeiras, e possue superfície circular ou com quatros cantos. São utilizadas para armazenar objetos em sua superfície ou até mesmo para decoração."},
	{"Eletrodomésticos são produtos da linha branca e eletroeletrônicos que possuem utilidades no dia-a-dia, como TVs, rádio, ar-condicionado e etc..."},
	{"Sofas são estruturas acolchoadas de 2 à 3 lugares que são utilizados para sentar. (algumas crianças gostam de pular em cima dele)."},
	{"Dizem que a cozinha é o melhor lugar da casa, pois, só vem coisa boa de lá. Geralmente se encontra o fogão, geladeira, freezer, bancadas e etc..."},
	{"Banheiro é o lugar do qual você faz suas necessidades. Mas isto não quer dizer que ele tem que ser feio. Por isto, aqui nesta categoria você vai encontrar privadas, pias, espelhos e etc..."},
	{"Decorativos é uma categoria que abrange quadros, fotos e estruturas que podem fazer seu apartamento um lugar mais atrativo."},
	{"Camas é onde você faz sesgo! Então compre muitas camas!"},
	{"Cadeiras geralmente são compostas de 4 'pernas' e são utilizadas para você sentar. Apenas tenha a certeza de comprar uma de boa qualidade para não acabar parando no chão."},
	{"Plantas são criaturas que estão na Terra desde quando a Terra não era Terra. Plantas são ótimas para decorações de cantos ou até mesmo em cima de uma mesa. Você deveria tentar!"}
};

// Category preview
new gCategoryPreview[] =
{
    2021, 2596, 1704, 2156, 2528, 2627, 2299, 2356, 646
};

// Balcões / Mesas / Armários
new g_obj_tables[][] =
{
	{933, 800},		{937, 800},		{1416, 1000},	{2087, 1000},
	{2020, 1200},	{2021, 900},	{941, 800},		{1813, 1000},
	{1815, 600},	{1814, 800},	{1817, 1000},	{1818, 700},
	{1822, 500},	{1823, 400},	{1417, 800},	{2025, 1000},
	{2204, 2500},	{2329, 1000},	{2330, 1200},	{2307, 8000},
	{2200, 2500},	{2164, 1000},	{2162, 700},	{2161, 700},
	{1963, 700},	{1999, 1000},	{2008, 1600},	{2009, 1000},
	{1996, 1500},	{2165, 1800},	{2166, 1400},	{2173, 1000},
	{2203, 1200},	{2562, 1000},	{2370, 1200},	{2373, 3000},
	{2576, 2500},	{1742, 2500},	{1743, 2000},	{2313, 1500},
	{2297, 3000},	{2296, 4000}
};

// Eletrodomesticos
new g_obj_eletro[][] =
{
	{1518, 700},	{1714, 400},	{1748, 200},	{1749, 400},
	{1731, 800},	{1786, 1200},	{2312, 1800},	{2596, 500},
	{1718, 250},	{1718, 250},	{1809, 800},	{2099, 2500},
	{2099, 2500},	{2104, 4000},	{2232, 300},	{2229, 400},
	{2230, 400}
};

// Sofás / Poltronas
new g_obj_couch[][] =
{
	{1704, 400},	{1703, 400},	{1708, 500},	{1711, 200},
	{1723, 1000},	{1724, 600},	{1726, 2000},	{1727, 1000},
	{1728, 400},	{1729, 200},	{1762, 500},	{1767, 700}
};

// kitchen
new g_obj_kitchen[][] =
{
	{2014, 800},	{2015, 800},	{2016, 800},	{2019, 800},
	{2022, 800},	{2128, 1000},	{2129, 1000},	{2304, 1000},
	{2156, 1200},	{2157, 1200},	{2159, 1200},	{2160, 1200},
	{2139, 1000},	{2137, 1000},	{2138, 1000},	{2140, 1000},
	{2127, 1600},	{2294, 1400},	{2130, 1200},	{2136, 1000},
	{2417, 1500},	{2336, 1000}
};

// bath
new g_obj_bath[][] =
{
	{2521, 600},	{2524, 600},	{2527, 1000},	{2517, 1000},
	{2514, 600},	{2739, 600},	{2742, 100},	{2525, 700},
	{2523, 400},	{2528, 500},	{2520, 1000},	{2515, 200}
};

// decoration
new g_obj_deco[][] =
{
	{1808, 300},	{1661, 500},	{1736, 300},	{2630, 900},
	{2627, 1000},	{2628, 1200},	{2202, 600},	{2002, 300},
	{1896, 400},	{11745, 100},	{11705, 100},	{19893, 1200},
	{11718, 100},	{19609, 2000},	{19317, 1000},	{19318, 1400}
};

// beds
new g_obj_beds[][] =
{
	{1700, 5000},	{1701, 4500},	{1725, 3000},	{1745, 2750},
	{1794, 2000},	{1797, 2000},	{1795, 1500},	{1796, 1000},
	{1798, 1500},	{1799, 1500},	{1800, 700},	{1801, 1000},
	{1802, 1100},	{1803, 1300},	{1812, 500},	{2005, 1200},
	{2299, 1200},	{2298, 1700},	{2302, 900},	{2301, 1500},
	{2300, 2500},	{2563, 4000},	{2566, 4000},	{2565, 6000},
	{2564, 6000},	{2575, 3000}
};

// chairs
new g_obj_chair[][] =
{
	{1663, 1000},	{1671, 1000},	{1714, 1200},	{1715, 900},
	{1720, 350},	{1721, 200},	{1739, 500},	{1805, 100},
	{1806, 700},	{1810, 100},	{1811, 150},	{2079, 650},
	{2096, 800},	{2120, 200},	{2121, 100},	{2122, 450},
	{2123, 400},	{2124, 800},	{2125, 100},	{2309, 300},
	{2356, 400},	{2336, 350},	{2350, 100},	{2724, 250},
	{2776, 150},	{2788, 150},	{1996, 99},	{19999, 1350},
	{11734, 500}
};

// plants
new g_obj_plants[][] =
{
	{625, 225},		{626, 235},		{627, 250},		{628, 250},		{630, 180},
	{631, 190},		{632, 250},		{633, 200},		{638, 350},		{644, 280},
	{646, 350},		{948, 100},		{2194, 100},	{2195, 250},	{2253, 300},
	{2241, 100},	{2811, 120},	{2810, 350},	{2811, 500}
};

// Pages
enum
{
	NEXT_PAGE,
	PREVIOUS_PAGE
}

// Player info
static gPCurrentCategory[MAX_PLAYERS];
static gPCurrentPage[MAX_PLAYERS];
static PlayerText:gPSelectedObjTD[MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ... };
static gPCurrentObjModel[MAX_PLAYERS];
static gPCurrentObjPrice[MAX_PLAYERS];
static gPSelectedObjModel[MAX_PLAYERS][18];
static gPSelectedObjPrice[MAX_PLAYERS][18];
static gPMaxPages[MAX_PLAYERS];
static bool:gPIsCTDVisible[MAX_PLAYERS];
static bool:gPIsSTDVisible[MAX_PLAYERS];

// Textdraw Ids
new PlayerText:gptCategory[MAX_PLAYERS][13];
new PlayerText:gptSelection[MAX_PLAYERS][17];
new PlayerText:gptObjSelect[MAX_PLAYERS][18];

forward OnPlayerSelectCategory(playerid, category);
forward OnPlayerBuyFurnitureObject(playerid, modelid, price);

//------------------------------------------------------------------------------

VSA_ShowPlayerCategory(playerid, category)
{
    if(category < 0 || category > (sizeof(gCategoryPreview)-1)) {
        PlayErrorSound(playerid);
        return 0;
    }

    gPCurrentCategory[playerid] = category;
    if(gPIsCTDVisible[playerid])
    {
		PlaySelectSound(playerid);
        PlayerTextDrawSetString(playerid, gptCategory[playerid][7], gCategoryName[category]);
        PlayerTextDrawSetString(playerid, gptCategory[playerid][8], ConvertToGameText(gCategoryDesc[category]));
        PlayerTextDrawSetPreviewModel(playerid, gptCategory[playerid][6], gCategoryPreview[category]);
        PlayerTextDrawShow(playerid, gptCategory[playerid][6]);
        return 1;
    }

    gPIsCTDVisible[playerid] = true;
	PlaySelectSound(playerid);

    gptCategory[playerid][0] = CreatePlayerTextDraw(playerid, 256.000000, 134.000000, "bg principal");
    PlayerTextDrawLetterSize(playerid, gptCategory[playerid][0], 0.000000, 24.371004);
    PlayerTextDrawTextSize(playerid, gptCategory[playerid][0], 394.909881, 0.000000);
    PlayerTextDrawAlignment(playerid, gptCategory[playerid][0], 1);
    PlayerTextDrawColor(playerid, gptCategory[playerid][0], -1);
    PlayerTextDrawUseBox(playerid, gptCategory[playerid][0], 1);
    PlayerTextDrawBoxColor(playerid, gptCategory[playerid][0], 40);
    PlayerTextDrawSetShadow(playerid, gptCategory[playerid][0], 0);
    PlayerTextDrawSetOutline(playerid, gptCategory[playerid][0], 0);
    PlayerTextDrawBackgroundColor(playerid, gptCategory[playerid][0], 255);
    PlayerTextDrawFont(playerid, gptCategory[playerid][0], 2);
    PlayerTextDrawSetProportional(playerid, gptCategory[playerid][0], 1);
    PlayerTextDrawSetShadow(playerid, gptCategory[playerid][0], 0);

    gptCategory[playerid][1] = CreatePlayerTextDraw(playerid, 256.799987, 135.400024, "bg do titulo");
    PlayerTextDrawLetterSize(playerid, gptCategory[playerid][1], 0.000000, 0.955000);
    PlayerTextDrawTextSize(playerid, gptCategory[playerid][1], 393.739105, 0.000000);
    PlayerTextDrawAlignment(playerid, gptCategory[playerid][1], 1);
    PlayerTextDrawColor(playerid, gptCategory[playerid][1], -1);
    PlayerTextDrawUseBox(playerid, gptCategory[playerid][1], 1);
    PlayerTextDrawBoxColor(playerid, gptCategory[playerid][1], 30);
    PlayerTextDrawSetShadow(playerid, gptCategory[playerid][1], 0);
    PlayerTextDrawSetOutline(playerid, gptCategory[playerid][1], 0);
    PlayerTextDrawBackgroundColor(playerid, gptCategory[playerid][1], 255);
    PlayerTextDrawFont(playerid, gptCategory[playerid][1], 1);
    PlayerTextDrawSetProportional(playerid, gptCategory[playerid][1], 1);
    PlayerTextDrawSetShadow(playerid, gptCategory[playerid][1], 0);

    gptCategory[playerid][2] = CreatePlayerTextDraw(playerid, 254.500030, 133.800048, "");
    PlayerTextDrawLetterSize(playerid, gptCategory[playerid][2], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, gptCategory[playerid][2], 11.666663, 11.599974);
    PlayerTextDrawAlignment(playerid, gptCategory[playerid][2], 1);
    PlayerTextDrawColor(playerid, gptCategory[playerid][2], -1);
    PlayerTextDrawSetShadow(playerid, gptCategory[playerid][2], 0);
    PlayerTextDrawSetOutline(playerid, gptCategory[playerid][2], 0);
    PlayerTextDrawBackgroundColor(playerid, gptCategory[playerid][2], 0);
    PlayerTextDrawFont(playerid, gptCategory[playerid][2], 5);
    PlayerTextDrawSetProportional(playerid, gptCategory[playerid][2], 0);
    PlayerTextDrawSetShadow(playerid, gptCategory[playerid][2], 0);
    PlayerTextDrawSetPreviewModel(playerid, gptCategory[playerid][2], 1208);
    PlayerTextDrawSetPreviewRot(playerid, gptCategory[playerid][2], 0.000000, 0.000000, 0.000000, 1.000000);

    gptCategory[playerid][3] = CreatePlayerTextDraw(playerid, 265.900054, 135.500030, "MOBILIA - CATEGORIAS");
    PlayerTextDrawLetterSize(playerid, gptCategory[playerid][3], 0.164998, 0.857481);
    PlayerTextDrawAlignment(playerid, gptCategory[playerid][3], 1);
    PlayerTextDrawColor(playerid, gptCategory[playerid][3], -1);
    PlayerTextDrawSetShadow(playerid, gptCategory[playerid][3], 1);
    PlayerTextDrawSetOutline(playerid, gptCategory[playerid][3], 0);
    PlayerTextDrawBackgroundColor(playerid, gptCategory[playerid][3], 255);
    PlayerTextDrawFont(playerid, gptCategory[playerid][3], 3);
    PlayerTextDrawSetProportional(playerid, gptCategory[playerid][3], 1);
    PlayerTextDrawSetShadow(playerid, gptCategory[playerid][3], 1);

    gptCategory[playerid][4] = CreatePlayerTextDraw(playerid, 388.399963, 134.000000, "box");
    PlayerTextDrawLetterSize(playerid, gptCategory[playerid][4], 0.000000, -1.274970);
    PlayerTextDrawTextSize(playerid, gptCategory[playerid][4], 394.958435, 0.000000);
    PlayerTextDrawAlignment(playerid, gptCategory[playerid][4], 1);
    PlayerTextDrawColor(playerid, gptCategory[playerid][4], -1);
    PlayerTextDrawUseBox(playerid, gptCategory[playerid][4], 1);
    PlayerTextDrawBoxColor(playerid, gptCategory[playerid][4], 40);
    PlayerTextDrawSetShadow(playerid, gptCategory[playerid][4], 0);
    PlayerTextDrawSetOutline(playerid, gptCategory[playerid][4], 0);
    PlayerTextDrawBackgroundColor(playerid, gptCategory[playerid][4], 255);
    PlayerTextDrawFont(playerid, gptCategory[playerid][4], 1);
    PlayerTextDrawSetProportional(playerid, gptCategory[playerid][4], 1);
    PlayerTextDrawSetShadow(playerid, gptCategory[playerid][4], 0);

    gptCategory[playerid][5] = CreatePlayerTextDraw(playerid, 389.000000, 122.599990, "X");
    PlayerTextDrawLetterSize(playerid, gptCategory[playerid][5], 0.202000, 1.178073);
    PlayerTextDrawTextSize(playerid, gptCategory[playerid][5], 399.000000, 10.00000);
    PlayerTextDrawAlignment(playerid, gptCategory[playerid][5], 1);
    PlayerTextDrawColor(playerid, gptCategory[playerid][5], -16776961);
    PlayerTextDrawSetShadow(playerid, gptCategory[playerid][5], 0);
    PlayerTextDrawSetOutline(playerid, gptCategory[playerid][5], 0);
    PlayerTextDrawBackgroundColor(playerid, gptCategory[playerid][5], 255);
    PlayerTextDrawFont(playerid, gptCategory[playerid][5], 2);
    PlayerTextDrawSetProportional(playerid, gptCategory[playerid][5], 1);
    PlayerTextDrawSetShadow(playerid, gptCategory[playerid][5], 0);
    PlayerTextDrawSetSelectable(playerid, gptCategory[playerid][5], true);

    gptCategory[playerid][6] = CreatePlayerTextDraw(playerid, 255.599914, 146.699920, "");
    PlayerTextDrawLetterSize(playerid, gptCategory[playerid][6], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, gptCategory[playerid][6], 139.450271, 167.550430);
    PlayerTextDrawAlignment(playerid, gptCategory[playerid][6], 1);
    PlayerTextDrawColor(playerid, gptCategory[playerid][6], -1);
    PlayerTextDrawSetShadow(playerid, gptCategory[playerid][6], 0);
    PlayerTextDrawSetOutline(playerid, gptCategory[playerid][6], 0);
    PlayerTextDrawBackgroundColor(playerid, gptCategory[playerid][6], 72);
    PlayerTextDrawFont(playerid, gptCategory[playerid][6], 5);
    PlayerTextDrawSetProportional(playerid, gptCategory[playerid][6], 0);
    PlayerTextDrawSetShadow(playerid, gptCategory[playerid][6], 0);
    PlayerTextDrawSetPreviewModel(playerid, gptCategory[playerid][6], gCategoryPreview[category]);
    PlayerTextDrawSetPreviewRot(playerid, gptCategory[playerid][6], 0.000000, 0.000000, 180.000000, 1.000000);
    PlayerTextDrawSetSelectable(playerid, gptCategory[playerid][6], true);

    gptCategory[playerid][7] = CreatePlayerTextDraw(playerid, 256.200073, 313.300018, gCategoryName[category]);
    PlayerTextDrawLetterSize(playerid, gptCategory[playerid][7], 0.272332, 1.405037);
    PlayerTextDrawAlignment(playerid, gptCategory[playerid][7], 1);
    PlayerTextDrawColor(playerid, gptCategory[playerid][7], -1);
    PlayerTextDrawSetShadow(playerid, gptCategory[playerid][7], 0);
    PlayerTextDrawSetOutline(playerid, gptCategory[playerid][7], 0);
    PlayerTextDrawBackgroundColor(playerid, gptCategory[playerid][7], 255);
    PlayerTextDrawFont(playerid, gptCategory[playerid][7], 2);
    PlayerTextDrawSetProportional(playerid, gptCategory[playerid][7], 1);
    PlayerTextDrawSetShadow(playerid, gptCategory[playerid][7], 0);

    gptCategory[playerid][8] = CreatePlayerTextDraw(playerid, 256.666656, 330.00000, ConvertToGameText(gCategoryDesc[category]));
    PlayerTextDrawLetterSize(playerid, gptCategory[playerid][8], 0.153332, 0.716444);
    PlayerTextDrawTextSize(playerid, gptCategory[playerid][8], 398.8479, 0.00000);
    PlayerTextDrawAlignment(playerid, gptCategory[playerid][8], 1);
    PlayerTextDrawColor(playerid, gptCategory[playerid][8], -2139062017);
    PlayerTextDrawSetShadow(playerid, gptCategory[playerid][8], 0);
    PlayerTextDrawSetOutline(playerid, gptCategory[playerid][8], 0);
    PlayerTextDrawBackgroundColor(playerid, gptCategory[playerid][8], 255);
    PlayerTextDrawFont(playerid, gptCategory[playerid][8], 1);
    PlayerTextDrawSetProportional(playerid, gptCategory[playerid][8], 1);
    PlayerTextDrawSetShadow(playerid, gptCategory[playerid][8], 0);

    gptCategory[playerid][9] = CreatePlayerTextDraw(playerid, 255.700042, 220.000732, "box");
    PlayerTextDrawLetterSize(playerid, gptCategory[playerid][9], 0.000000, 2.912667);
    PlayerTextDrawTextSize(playerid, gptCategory[playerid][9], 222.639709, 0.000000);
    PlayerTextDrawAlignment(playerid, gptCategory[playerid][9], 1);
    PlayerTextDrawColor(playerid, gptCategory[playerid][9], -1);
    PlayerTextDrawUseBox(playerid, gptCategory[playerid][9], 1);
    PlayerTextDrawBoxColor(playerid, gptCategory[playerid][9], 41);
    PlayerTextDrawSetShadow(playerid, gptCategory[playerid][9], 0);
    PlayerTextDrawSetOutline(playerid, gptCategory[playerid][9], 0);
    PlayerTextDrawBackgroundColor(playerid, gptCategory[playerid][9], 255);
    PlayerTextDrawFont(playerid, gptCategory[playerid][9], 1);
    PlayerTextDrawSetProportional(playerid, gptCategory[playerid][9], 1);
    PlayerTextDrawSetShadow(playerid, gptCategory[playerid][9], 0);

    gptCategory[playerid][10] = CreatePlayerTextDraw(playerid, 428.400390, 220.000122, "box");
    PlayerTextDrawLetterSize(playerid, gptCategory[playerid][10], 0.000000, 2.912667);
    PlayerTextDrawTextSize(playerid, gptCategory[playerid][10], 394.973968, 0.000000);
    PlayerTextDrawAlignment(playerid, gptCategory[playerid][10], 1);
    PlayerTextDrawColor(playerid, gptCategory[playerid][10], -1);
    PlayerTextDrawUseBox(playerid, gptCategory[playerid][10], 1);
    PlayerTextDrawBoxColor(playerid, gptCategory[playerid][10], 41);
    PlayerTextDrawSetShadow(playerid, gptCategory[playerid][10], 0);
    PlayerTextDrawSetOutline(playerid, gptCategory[playerid][10], 0);
    PlayerTextDrawBackgroundColor(playerid, gptCategory[playerid][10], 255);
    PlayerTextDrawFont(playerid, gptCategory[playerid][10], 1);
    PlayerTextDrawSetProportional(playerid, gptCategory[playerid][10], 1);
    PlayerTextDrawSetShadow(playerid, gptCategory[playerid][10], 0);

    gptCategory[playerid][11] = CreatePlayerTextDraw(playerid, 231.499969, 223.599853, "ld_beat:left");
    PlayerTextDrawLetterSize(playerid, gptCategory[playerid][11], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, gptCategory[playerid][11], 14.333332, 20.725915);
    PlayerTextDrawAlignment(playerid, gptCategory[playerid][11], 1);
    PlayerTextDrawColor(playerid, gptCategory[playerid][11], -1);
    PlayerTextDrawSetShadow(playerid, gptCategory[playerid][11], 0);
    PlayerTextDrawSetOutline(playerid, gptCategory[playerid][11], 0);
    PlayerTextDrawBackgroundColor(playerid, gptCategory[playerid][11], 255);
    PlayerTextDrawFont(playerid, gptCategory[playerid][11], 4);
    PlayerTextDrawSetProportional(playerid, gptCategory[playerid][11], 0);
    PlayerTextDrawSetShadow(playerid, gptCategory[playerid][11], 0);
    PlayerTextDrawSetSelectable(playerid, gptCategory[playerid][11], true);

    gptCategory[playerid][12] = CreatePlayerTextDraw(playerid, 405.199829, 223.600097, "ld_beat:right");
    PlayerTextDrawLetterSize(playerid, gptCategory[playerid][12], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, gptCategory[playerid][12], 14.333332, 20.725915);
    PlayerTextDrawAlignment(playerid, gptCategory[playerid][12], 1);
    PlayerTextDrawColor(playerid, gptCategory[playerid][12], -1);
    PlayerTextDrawSetShadow(playerid, gptCategory[playerid][12], 0);
    PlayerTextDrawSetOutline(playerid, gptCategory[playerid][12], 0);
    PlayerTextDrawBackgroundColor(playerid, gptCategory[playerid][12], 255);
    PlayerTextDrawFont(playerid, gptCategory[playerid][12], 4);
    PlayerTextDrawSetProportional(playerid, gptCategory[playerid][12], 0);
    PlayerTextDrawSetShadow(playerid, gptCategory[playerid][12], 0);
    PlayerTextDrawSetSelectable(playerid, gptCategory[playerid][12], true);

    for (new i = 0; i < sizeof(gptCategory[]); i++)
        PlayerTextDrawShow(playerid, gptCategory[playerid][i]);

    SelectTextDraw(playerid, 0x97d53fff);
    return 1;
}

//------------------------------------------------------------------------------

VSA_HidePlayerCategory(playerid)
{
    if(!gPIsCTDVisible[playerid])
        return 0;

    for (new i = 0; i < sizeof(gptCategory[]); i++)
        PlayerTextDrawDestroy(playerid, gptCategory[playerid][i]);

    gPIsCTDVisible[playerid] = false;
    return 1;
}

//------------------------------------------------------------------------------

PlayerText:CreateSelectionObject(playerid, column, modelid)
{
	if(column < 0 || column > 17)
		return PlayerText:0;

	new row = 0;
	if(column >= 0 && column <= 5)
		row = 0;
	else if(column >= 6 && column <= 11) {
		row = 1;
		column -= 6;
	}
	else if(column >= 12 && column <= 17) {
		row = 2;
		column -= 12;
	}

	new PlayerText:playertextid;
	playertextid = CreatePlayerTextDraw(playerid, 156.599853 + (SELECTION_BASE_X * column), 115.884925 + (SELECTION_BASE_Y * row), "");
	PlayerTextDrawLetterSize(playerid, playertextid, 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, playertextid, 56.666645, 69.259269);
	PlayerTextDrawAlignment(playerid, playertextid, 1);
	PlayerTextDrawColor(playerid, playertextid, -1);
	PlayerTextDrawSetShadow(playerid, playertextid, 0);
	PlayerTextDrawSetOutline(playerid, playertextid, 0);
	PlayerTextDrawBackgroundColor(playerid, playertextid, 65);
	PlayerTextDrawFont(playerid, playertextid, 5);
	PlayerTextDrawSetProportional(playerid, playertextid, 0);
	PlayerTextDrawSetShadow(playerid, playertextid, 0);
	PlayerTextDrawSetSelectable(playerid, playertextid, true);
	PlayerTextDrawSetPreviewModel(playerid, playertextid, modelid);
	PlayerTextDrawSetPreviewRot(playerid, playertextid, 0.000000, 0.000000, 140.000000, 1.000000);
	PlayerTextDrawShow(playerid, playertextid);
	return playertextid;
}

//------------------------------------------------------------------------------

VSA_ShowPlayerSelection(playerid, category)
{
    if(category < 0 || category > (sizeof(gCategoryPreview)-1)) {
        PlayErrorSound(playerid);
        return 0;
    }

    gPIsSTDVisible[playerid] = true;
    gPCurrentCategory[playerid] = category;
    gPCurrentPage[playerid] = 1;
    gPMaxPages[playerid] = 0;

	PlaySelectSound(playerid);

    gptSelection[playerid][0] = CreatePlayerTextDraw(playerid, 157.000000, 100.000000, "box");
    PlayerTextDrawLetterSize(playerid, gptSelection[playerid][0], 0.000000, 26.933334);
    PlayerTextDrawTextSize(playerid, gptSelection[playerid][0], 500.893981, 0.000000);
    PlayerTextDrawAlignment(playerid, gptSelection[playerid][0], 1);
    PlayerTextDrawColor(playerid, gptSelection[playerid][0], -1);
    PlayerTextDrawUseBox(playerid, gptSelection[playerid][0], 1);
    PlayerTextDrawBoxColor(playerid, gptSelection[playerid][0], 41);
    PlayerTextDrawSetShadow(playerid, gptSelection[playerid][0], 39);
    PlayerTextDrawSetOutline(playerid, gptSelection[playerid][0], 0);
    PlayerTextDrawBackgroundColor(playerid, gptSelection[playerid][0], 255);
    PlayerTextDrawFont(playerid, gptSelection[playerid][0], 1);
    PlayerTextDrawSetProportional(playerid, gptSelection[playerid][0], 1);
    PlayerTextDrawSetShadow(playerid, gptSelection[playerid][0], 39);

    gptSelection[playerid][1] = CreatePlayerTextDraw(playerid, 157.999923, 101.444442, "box");
    PlayerTextDrawLetterSize(playerid, gptSelection[playerid][1], 0.000000, 1.296332);
    PlayerTextDrawTextSize(playerid, gptSelection[playerid][1], 499.818695, 0.000000);
    PlayerTextDrawAlignment(playerid, gptSelection[playerid][1], 1);
    PlayerTextDrawColor(playerid, gptSelection[playerid][1], -1);
    PlayerTextDrawUseBox(playerid, gptSelection[playerid][1], 1);
    PlayerTextDrawBoxColor(playerid, gptSelection[playerid][1], 32);
    PlayerTextDrawSetShadow(playerid, gptSelection[playerid][1], 0);
    PlayerTextDrawSetOutline(playerid, gptSelection[playerid][1], 0);
    PlayerTextDrawBackgroundColor(playerid, gptSelection[playerid][1], 255);
    PlayerTextDrawFont(playerid, gptSelection[playerid][1], 1);
    PlayerTextDrawSetProportional(playerid, gptSelection[playerid][1], 1);
    PlayerTextDrawSetShadow(playerid, gptSelection[playerid][1], 0);

    gptSelection[playerid][2] = CreatePlayerTextDraw(playerid, 153.333358, 97.755546, "");
    PlayerTextDrawLetterSize(playerid, gptSelection[playerid][2], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, gptSelection[playerid][2], 17.666643, 21.140768);
    PlayerTextDrawAlignment(playerid, gptSelection[playerid][2], 1);
    PlayerTextDrawColor(playerid, gptSelection[playerid][2], -1);
    PlayerTextDrawSetShadow(playerid, gptSelection[playerid][2], 0);
    PlayerTextDrawSetOutline(playerid, gptSelection[playerid][2], 0);
    PlayerTextDrawBackgroundColor(playerid, gptSelection[playerid][2], 0);
    PlayerTextDrawFont(playerid, gptSelection[playerid][2], 5);
    PlayerTextDrawSetProportional(playerid, gptSelection[playerid][2], 0);
    PlayerTextDrawSetShadow(playerid, gptSelection[playerid][2], 0);
    PlayerTextDrawSetPreviewModel(playerid, gptSelection[playerid][2], 2596);
    PlayerTextDrawSetPreviewRot(playerid, gptSelection[playerid][2], 0.000000, 0.000000, 180.000000, 1.000000);

	new sCategory[32];
	format(sCategory, sizeof(sCategory), "Categoria: %s", gCategoryName[category]);
    gptSelection[playerid][3] = CreatePlayerTextDraw(playerid, 170.299896, 102.103713, sCategory);
    PlayerTextDrawLetterSize(playerid, gptSelection[playerid][3], 0.172666, 1.006814);
    PlayerTextDrawAlignment(playerid, gptSelection[playerid][3], 1);
    PlayerTextDrawColor(playerid, gptSelection[playerid][3], -1);
    PlayerTextDrawSetShadow(playerid, gptSelection[playerid][3], 1);
    PlayerTextDrawSetOutline(playerid, gptSelection[playerid][3], 0);
    PlayerTextDrawBackgroundColor(playerid, gptSelection[playerid][3], 255);
    PlayerTextDrawFont(playerid, gptSelection[playerid][3], 3);
    PlayerTextDrawSetProportional(playerid, gptSelection[playerid][3], 1);
    PlayerTextDrawSetShadow(playerid, gptSelection[playerid][3], 1);

    gptSelection[playerid][4] = CreatePlayerTextDraw(playerid, 329.499511, 330.592590, "1/?");
    PlayerTextDrawLetterSize(playerid, gptSelection[playerid][4], 0.174999, 0.928000);
    PlayerTextDrawAlignment(playerid, gptSelection[playerid][4], 2);
    PlayerTextDrawColor(playerid, gptSelection[playerid][4], -2139062017);
    PlayerTextDrawSetShadow(playerid, gptSelection[playerid][4], 0);
    PlayerTextDrawSetOutline(playerid, gptSelection[playerid][4], 0);
    PlayerTextDrawBackgroundColor(playerid, gptSelection[playerid][4], 255);
    PlayerTextDrawFont(playerid, gptSelection[playerid][4], 2);
    PlayerTextDrawSetProportional(playerid, gptSelection[playerid][4], 1);
    PlayerTextDrawSetShadow(playerid, gptSelection[playerid][4], 0);

    gptSelection[playerid][5] = CreatePlayerTextDraw(playerid, 344.666564, 329.900024, "ld_beat:right");
    PlayerTextDrawLetterSize(playerid, gptSelection[playerid][5], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, gptSelection[playerid][5], 7.946673, 10.727520);
    PlayerTextDrawAlignment(playerid, gptSelection[playerid][5], 1);
    PlayerTextDrawColor(playerid, gptSelection[playerid][5], -1);
    PlayerTextDrawSetShadow(playerid, gptSelection[playerid][5], 0);
    PlayerTextDrawSetOutline(playerid, gptSelection[playerid][5], 0);
    PlayerTextDrawBackgroundColor(playerid, gptSelection[playerid][5], 255);
    PlayerTextDrawFont(playerid, gptSelection[playerid][5], 4);
    PlayerTextDrawSetProportional(playerid, gptSelection[playerid][5], 0);
    PlayerTextDrawSetShadow(playerid, gptSelection[playerid][5], 0);
    PlayerTextDrawSetSelectable(playerid, gptSelection[playerid][5], true);

    gptSelection[playerid][6] = CreatePlayerTextDraw(playerid, 306.597595, 329.985229, "ld_beat:left");
    PlayerTextDrawLetterSize(playerid, gptSelection[playerid][6], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, gptSelection[playerid][6], 7.946673, 10.727520);
    PlayerTextDrawAlignment(playerid, gptSelection[playerid][6], 1);
    PlayerTextDrawColor(playerid, gptSelection[playerid][6], -1);
    PlayerTextDrawSetShadow(playerid, gptSelection[playerid][6], 0);
    PlayerTextDrawSetOutline(playerid, gptSelection[playerid][6], 0);
    PlayerTextDrawBackgroundColor(playerid, gptSelection[playerid][6], 255);
    PlayerTextDrawFont(playerid, gptSelection[playerid][6], 4);
    PlayerTextDrawSetProportional(playerid, gptSelection[playerid][6], 0);
    PlayerTextDrawSetShadow(playerid, gptSelection[playerid][6], 0);
    PlayerTextDrawSetSelectable(playerid, gptSelection[playerid][6], true);

    gptSelection[playerid][7] = CreatePlayerTextDraw(playerid, 446.300170, 329.392669, "botao comprar");
    PlayerTextDrawLetterSize(playerid, gptSelection[playerid][7], 0.000000, 1.275001);
    PlayerTextDrawTextSize(playerid, gptSelection[playerid][7], 499.416412, 16.000000);
    PlayerTextDrawAlignment(playerid, gptSelection[playerid][7], 1);
    PlayerTextDrawColor(playerid, gptSelection[playerid][7], -1);
    PlayerTextDrawUseBox(playerid, gptSelection[playerid][7], 1);
    PlayerTextDrawBoxColor(playerid, gptSelection[playerid][7], 8388863);
    PlayerTextDrawSetShadow(playerid, gptSelection[playerid][7], 0);
    PlayerTextDrawSetOutline(playerid, gptSelection[playerid][7], 0);
    PlayerTextDrawBackgroundColor(playerid, gptSelection[playerid][7], 16777215);
    PlayerTextDrawFont(playerid, gptSelection[playerid][7], 2);
    PlayerTextDrawSetProportional(playerid, gptSelection[playerid][7], 1);
    PlayerTextDrawSetShadow(playerid, gptSelection[playerid][7], 0);
    PlayerTextDrawSetSelectable(playerid, gptSelection[playerid][7], true);

    gptSelection[playerid][8] = CreatePlayerTextDraw(playerid, 446.300170, 329.392669, "efeito botao comprar");
    PlayerTextDrawLetterSize(playerid, gptSelection[playerid][8], 0.000000, 0.508334);
    PlayerTextDrawTextSize(playerid, gptSelection[playerid][8], 499.123077, 0.000000);
    PlayerTextDrawAlignment(playerid, gptSelection[playerid][8], 1);
    PlayerTextDrawColor(playerid, gptSelection[playerid][8], -1);
    PlayerTextDrawUseBox(playerid, gptSelection[playerid][8], 1);
    PlayerTextDrawBoxColor(playerid, gptSelection[playerid][8], -226);
    PlayerTextDrawSetShadow(playerid, gptSelection[playerid][8], 0);
    PlayerTextDrawSetOutline(playerid, gptSelection[playerid][8], 0);
    PlayerTextDrawBackgroundColor(playerid, gptSelection[playerid][8], 16777215);
    PlayerTextDrawFont(playerid, gptSelection[playerid][8], 2);
    PlayerTextDrawSetProportional(playerid, gptSelection[playerid][8], 1);
    PlayerTextDrawSetShadow(playerid, gptSelection[playerid][8], 0);

    gptSelection[playerid][9] = CreatePlayerTextDraw(playerid, 157.833419, 329.963085, "botao voltar categorias");
    PlayerTextDrawLetterSize(playerid, gptSelection[playerid][9], 0.000000, 1.300002);
    PlayerTextDrawTextSize(playerid, gptSelection[playerid][9], 240.810424, 16.000000);
    PlayerTextDrawAlignment(playerid, gptSelection[playerid][9], 1);
    PlayerTextDrawColor(playerid, gptSelection[playerid][9], -1);
    PlayerTextDrawUseBox(playerid, gptSelection[playerid][9], 1);
    PlayerTextDrawBoxColor(playerid, gptSelection[playerid][9], 16777030);
    PlayerTextDrawSetShadow(playerid, gptSelection[playerid][9], 0);
    PlayerTextDrawSetOutline(playerid, gptSelection[playerid][9], 0);
    PlayerTextDrawBackgroundColor(playerid, gptSelection[playerid][9], 16777215);
    PlayerTextDrawFont(playerid, gptSelection[playerid][9], 2);
    PlayerTextDrawSetProportional(playerid, gptSelection[playerid][9], 1);
    PlayerTextDrawSetShadow(playerid, gptSelection[playerid][9], 0);
    PlayerTextDrawSetSelectable(playerid, gptSelection[playerid][9], true);

    gptSelection[playerid][10] = CreatePlayerTextDraw(playerid, 157.833419, 329.663085, "efeito botao ver");
    PlayerTextDrawLetterSize(playerid, gptSelection[playerid][10], 0.000000, 0.503002);
    PlayerTextDrawTextSize(playerid, gptSelection[playerid][10], 211.880401, 0.000000);
    PlayerTextDrawAlignment(playerid, gptSelection[playerid][10], 1);
    PlayerTextDrawColor(playerid, gptSelection[playerid][10], -1);
    PlayerTextDrawUseBox(playerid, gptSelection[playerid][10], 1);
    PlayerTextDrawBoxColor(playerid, gptSelection[playerid][10], -225);
    PlayerTextDrawSetShadow(playerid, gptSelection[playerid][10], 0);
    PlayerTextDrawSetOutline(playerid, gptSelection[playerid][10], 0);
    PlayerTextDrawBackgroundColor(playerid, gptSelection[playerid][10], 16777215);
    PlayerTextDrawFont(playerid, gptSelection[playerid][10], 2);
    PlayerTextDrawSetProportional(playerid, gptSelection[playerid][10], 1);
    PlayerTextDrawSetShadow(playerid, gptSelection[playerid][10], 0);

    gptSelection[playerid][11] = CreatePlayerTextDraw(playerid, 166.100097, 330.081506, "Ver categorias");
    PlayerTextDrawLetterSize(playerid, gptSelection[playerid][11], 0.106666, 0.704963);
    PlayerTextDrawTextSize(playerid, gptSelection[playerid][11], 176.106666, 10.704963);
    PlayerTextDrawAlignment(playerid, gptSelection[playerid][11], 1);
    PlayerTextDrawColor(playerid, gptSelection[playerid][11], -1);
    PlayerTextDrawSetShadow(playerid, gptSelection[playerid][11], 0);
    PlayerTextDrawSetOutline(playerid, gptSelection[playerid][11], 0);
    PlayerTextDrawBackgroundColor(playerid, gptSelection[playerid][11], 255);
    PlayerTextDrawFont(playerid, gptSelection[playerid][11], 2);
    PlayerTextDrawSetProportional(playerid, gptSelection[playerid][11], 1);
    PlayerTextDrawSetShadow(playerid, gptSelection[playerid][11], 0);

    gptSelection[playerid][12] = CreatePlayerTextDraw(playerid, 458.633178, 335.348571, "$0");
    PlayerTextDrawLetterSize(playerid, gptSelection[playerid][12], 0.132666, 0.728889);
    PlayerTextDrawAlignment(playerid, gptSelection[playerid][12], 1);
    PlayerTextDrawColor(playerid, gptSelection[playerid][12], -1061109505);
    PlayerTextDrawSetShadow(playerid, gptSelection[playerid][12], 0);
    PlayerTextDrawSetOutline(playerid, gptSelection[playerid][12], 0);
    PlayerTextDrawBackgroundColor(playerid, gptSelection[playerid][12], 255);
    PlayerTextDrawFont(playerid, gptSelection[playerid][12], 2);
    PlayerTextDrawSetProportional(playerid, gptSelection[playerid][12], 1);
    PlayerTextDrawSetShadow(playerid, gptSelection[playerid][12], 0);

    gptSelection[playerid][13] = CreatePlayerTextDraw(playerid, 494.066680, 87.455574, "box");
    PlayerTextDrawLetterSize(playerid, gptSelection[playerid][13], 0.000000, 1.033334);
    PlayerTextDrawTextSize(playerid, gptSelection[playerid][13], 500.733306, 0.000000);
    PlayerTextDrawAlignment(playerid, gptSelection[playerid][13], 1);
    PlayerTextDrawColor(playerid, gptSelection[playerid][13], -1);
    PlayerTextDrawUseBox(playerid, gptSelection[playerid][13], 1);
    PlayerTextDrawBoxColor(playerid, gptSelection[playerid][13], 44);
    PlayerTextDrawSetShadow(playerid, gptSelection[playerid][13], 0);
    PlayerTextDrawSetOutline(playerid, gptSelection[playerid][13], 0);
    PlayerTextDrawBackgroundColor(playerid, gptSelection[playerid][13], 255);
    PlayerTextDrawFont(playerid, gptSelection[playerid][13], 1);
    PlayerTextDrawSetProportional(playerid, gptSelection[playerid][13], 1);
    PlayerTextDrawSetShadow(playerid, gptSelection[playerid][13], 0);

    gptSelection[playerid][14] = CreatePlayerTextDraw(playerid, 458.833190, 328.948181, "Comprar");
    PlayerTextDrawLetterSize(playerid, gptSelection[playerid][14], 0.132666, 0.728889);
    PlayerTextDrawAlignment(playerid, gptSelection[playerid][14], 1);
    PlayerTextDrawColor(playerid, gptSelection[playerid][14], -1);
    PlayerTextDrawSetShadow(playerid, gptSelection[playerid][14], 0);
    PlayerTextDrawSetOutline(playerid, gptSelection[playerid][14], 0);
    PlayerTextDrawBackgroundColor(playerid, gptSelection[playerid][14], 255);
    PlayerTextDrawFont(playerid, gptSelection[playerid][14], 2);
    PlayerTextDrawSetProportional(playerid, gptSelection[playerid][14], 1);
    PlayerTextDrawSetShadow(playerid, gptSelection[playerid][14], 0);

    gptSelection[playerid][15] = CreatePlayerTextDraw(playerid, 443.466613, 328.333343, "");
    PlayerTextDrawLetterSize(playerid, gptSelection[playerid][15], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, gptSelection[playerid][15], 16.000003, 13.674081);
    PlayerTextDrawAlignment(playerid, gptSelection[playerid][15], 1);
    PlayerTextDrawColor(playerid, gptSelection[playerid][15], -1);
    PlayerTextDrawSetShadow(playerid, gptSelection[playerid][15], 0);
    PlayerTextDrawSetOutline(playerid, gptSelection[playerid][15], 0);
    PlayerTextDrawBackgroundColor(playerid, gptSelection[playerid][15], 0);
    PlayerTextDrawFont(playerid, gptSelection[playerid][15], 5);
    PlayerTextDrawSetProportional(playerid, gptSelection[playerid][15], 0);
    PlayerTextDrawSetShadow(playerid, gptSelection[playerid][15], 0);
    PlayerTextDrawSetPreviewModel(playerid, gptSelection[playerid][15], 1274);
    PlayerTextDrawSetPreviewRot(playerid, gptSelection[playerid][15], 0.000000, 0.000000, 180.000000, 1.000000);

    gptSelection[playerid][16] = CreatePlayerTextDraw(playerid, 494.666656, 87.540718, "X");
    PlayerTextDrawLetterSize(playerid, gptSelection[playerid][16], 0.249666, 0.911407);
    PlayerTextDrawTextSize(playerid, gptSelection[playerid][16], 504.666656, 10.000000);
    PlayerTextDrawAlignment(playerid, gptSelection[playerid][16], 1);
    PlayerTextDrawColor(playerid, gptSelection[playerid][16], -16776961);
    PlayerTextDrawSetShadow(playerid, gptSelection[playerid][16], 0);
    PlayerTextDrawSetOutline(playerid, gptSelection[playerid][16], 0);
    PlayerTextDrawBackgroundColor(playerid, gptSelection[playerid][16], 255);
    PlayerTextDrawFont(playerid, gptSelection[playerid][16], 1);
    PlayerTextDrawSetProportional(playerid, gptSelection[playerid][16], 1);
    PlayerTextDrawSetShadow(playerid, gptSelection[playerid][16], 0);
    PlayerTextDrawSetSelectable(playerid, gptSelection[playerid][16], true);

	for (new i = 0; i < sizeof(gptSelection[]); i++)
		PlayerTextDrawShow(playerid, gptSelection[playerid][i]);

	for (new i = 0; i < sizeof(gptObjSelect[]); i++)
		gptObjSelect[playerid][i] = PlayerText:INVALID_TEXT_DRAW;

	switch(category)
	{
		case CATEGORY_TABLES:
		{
			for(new i = 0; i < sizeof(g_obj_tables); i++)
			{
				if(i < 18)
				{
					gptObjSelect[playerid][i] = CreateSelectionObject(playerid, i, g_obj_tables[i][0]);
					gPSelectedObjModel[playerid][i] = g_obj_tables[i][0];
					gPSelectedObjPrice[playerid][i] = g_obj_tables[i][1];
				}
			}
			gPMaxPages[playerid] = floatround(float(sizeof(g_obj_tables)) / 18.0, floatround_ceil);
		}
		case CATEGORY_ELETRO:
		{
			for(new i = 0; i < sizeof(g_obj_eletro); i++)
			{
				if(i < 18)
				{
					gptObjSelect[playerid][i] = CreateSelectionObject(playerid, i, g_obj_eletro[i][0]);
					gPSelectedObjModel[playerid][i] = g_obj_eletro[i][0];
					gPSelectedObjPrice[playerid][i] = g_obj_eletro[i][1];
				}
			}
			gPMaxPages[playerid] = floatround(float(sizeof(g_obj_eletro)) / 18.0, floatround_ceil);
		}
		case CATEGORY_COUCH:
		{
			for(new i = 0; i < sizeof(g_obj_couch); i++)
			{
				if(i < 18)
				{
					gptObjSelect[playerid][i] = CreateSelectionObject(playerid, i, g_obj_couch[i][0]);
					gPSelectedObjModel[playerid][i] = g_obj_couch[i][0];
					gPSelectedObjPrice[playerid][i] = g_obj_couch[i][1];
				}
			}
			gPMaxPages[playerid] = floatround(float(sizeof(g_obj_couch)) / 18.0, floatround_ceil);
		}
		case CATEGORY_KITCHEN:
		{
			for(new i = 0; i < sizeof(g_obj_kitchen); i++)
			{
				if(i < 18)
				{
					gptObjSelect[playerid][i] = CreateSelectionObject(playerid, i, g_obj_kitchen[i][0]);
					gPSelectedObjModel[playerid][i] = g_obj_kitchen[i][0];
					gPSelectedObjPrice[playerid][i] = g_obj_kitchen[i][1];
				}
			}
			gPMaxPages[playerid] = floatround(float(sizeof(g_obj_kitchen)) / 18.0, floatround_ceil);
		}
		case CATEGORY_BATH:
		{
			for(new i = 0; i < sizeof(g_obj_bath); i++)
			{
				if(i < 18)
				{
					gptObjSelect[playerid][i] = CreateSelectionObject(playerid, i, g_obj_bath[i][0]);
					gPSelectedObjModel[playerid][i] = g_obj_bath[i][0];
					gPSelectedObjPrice[playerid][i] = g_obj_bath[i][1];
				}
			}
			gPMaxPages[playerid] = floatround(float(sizeof(g_obj_bath)) / 18.0, floatround_ceil);
		}
		case CATEGORY_DECO:
		{
			for(new i = 0; i < sizeof(g_obj_deco); i++)
			{
				if(i < 18)
				{
					gptObjSelect[playerid][i] = CreateSelectionObject(playerid, i, g_obj_deco[i][0]);
					gPSelectedObjModel[playerid][i] = g_obj_deco[i][0];
					gPSelectedObjPrice[playerid][i] = g_obj_deco[i][1];
				}
			}
			gPMaxPages[playerid] = floatround(float(sizeof(g_obj_deco)) / 18.0, floatround_ceil);
		}
		case CATEGORY_BEDS:
		{
			for(new i = 0; i < sizeof(g_obj_beds); i++)
			{
				if(i < 18)
				{
					gptObjSelect[playerid][i] = CreateSelectionObject(playerid, i, g_obj_beds[i][0]);
					gPSelectedObjModel[playerid][i] = g_obj_beds[i][0];
					gPSelectedObjPrice[playerid][i] = g_obj_beds[i][1];
				}
			}
			gPMaxPages[playerid] = floatround(float(sizeof(g_obj_beds)) / 18.0, floatround_ceil);
		}
		case CATEGORY_CHAIR:
		{
			for(new i = 0; i < sizeof(g_obj_chair); i++)
			{
				if(i < 18)
				{
					gptObjSelect[playerid][i] = CreateSelectionObject(playerid, i, g_obj_chair[i][0]);
					gPSelectedObjModel[playerid][i] = g_obj_chair[i][0];
					gPSelectedObjPrice[playerid][i] = g_obj_chair[i][1];
				}
			}
			gPMaxPages[playerid] = floatround(float(sizeof(g_obj_chair)) / 18.0, floatround_ceil);
		}
		case CATEGORY_PLANTS:
		{
			for(new i = 0; i < sizeof(g_obj_plants); i++)
			{
				if(i < 18)
				{
					gptObjSelect[playerid][i] = CreateSelectionObject(playerid, i, g_obj_plants[i][0]);
					gPSelectedObjModel[playerid][i] = g_obj_plants[i][0];
					gPSelectedObjPrice[playerid][i] = g_obj_plants[i][1];
				}
			}
			gPMaxPages[playerid] = floatround(float(sizeof(g_obj_plants)) / 18.0, floatround_ceil);
		}
	}

	new sPageStr[18];
	format(sPageStr, sizeof(sPageStr), "%i / %i",gPCurrentPage[playerid], gPMaxPages[playerid]);
	PlayerTextDrawSetString(playerid, gptSelection[playerid][4], sPageStr);

	SelectTextDraw(playerid, 0x97d53fff);
    return 1;
}

//------------------------------------------------------------------------------

VSA_HidePlayerSelection(playerid)
{
    if(!gPIsSTDVisible[playerid])
        return 0;

    for (new i = 0; i < sizeof(gptSelection[]); i++)
        PlayerTextDrawDestroy(playerid, gptSelection[playerid][i]);

	for (new i = 0; i < sizeof(gptObjSelect[]); i++)
		if(gptObjSelect[playerid][i] != PlayerText:INVALID_TEXT_DRAW)
			PlayerTextDrawDestroy(playerid, gptObjSelect[playerid][i]);

    gPIsSTDVisible[playerid] = false;
	gPSelectedObjTD[playerid] = PlayerText:INVALID_TEXT_DRAW;
    return 1;
}

//------------------------------------------------------------------------------

DrawSelectionPage(playerid, page)
{
	if(page == NEXT_PAGE)
		gPCurrentPage[playerid]++;
	else
		gPCurrentPage[playerid]--;

	new sPageStr[18];
	format(sPageStr, sizeof(sPageStr), "%i / %i",gPCurrentPage[playerid], gPMaxPages[playerid]);
	PlayerTextDrawSetString(playerid, gptSelection[playerid][4], sPageStr);
	switch(gPCurrentCategory[playerid])
	{
		case CATEGORY_TABLES:
		{
			new j = 0;
			for(new i = ((gPCurrentPage[playerid]-1) * 18); i < sizeof(g_obj_tables); i++)
			{
				if(j < 18)
				{
					gptObjSelect[playerid][j] = CreateSelectionObject(playerid, j, g_obj_tables[i][0]);
					gPSelectedObjModel[playerid][j] = g_obj_tables[i][0];
					gPSelectedObjPrice[playerid][j] = g_obj_tables[i][1];
				}
				else
					break;
				j++;
			}
		}
		case CATEGORY_ELETRO:
		{
			new j = 0;
			for(new i = ((gPCurrentPage[playerid]-1) * 18); i < sizeof(g_obj_eletro); i++)
			{
				if(j < 18)
					gptObjSelect[playerid][j] = CreateSelectionObject(playerid, j, g_obj_eletro[i][0]);
				else
					break;
				j++;
			}
		}
		case CATEGORY_COUCH:
		{
			new j = 0;
			for(new i = ((gPCurrentPage[playerid]-1) * 18); i < sizeof(g_obj_couch); i++)
			{
				if(j < 18)
				{
					gptObjSelect[playerid][j] = CreateSelectionObject(playerid, j, g_obj_couch[i][0]);
					gPSelectedObjModel[playerid][j] = g_obj_couch[i][0];
					gPSelectedObjPrice[playerid][j] = g_obj_couch[i][1];
				}
				else
					break;
				j++;
			}
		}
		case CATEGORY_KITCHEN:
		{
			new j = 0;
			for(new i = ((gPCurrentPage[playerid]-1) * 18); i < sizeof(g_obj_kitchen); i++)
			{
				if(j < 18)
				{
					gptObjSelect[playerid][j] = CreateSelectionObject(playerid, j, g_obj_kitchen[i][0]);
					gPSelectedObjModel[playerid][j] = g_obj_kitchen[i][0];
					gPSelectedObjPrice[playerid][j] = g_obj_kitchen[i][1];
				}
				else
					break;
				j++;
			}
		}
		case CATEGORY_BATH:
		{
			new j = 0;
			for(new i = ((gPCurrentPage[playerid]-1) * 18); i < sizeof(g_obj_bath); i++)
			{
				if(j < 18)
				{
					gptObjSelect[playerid][j] = CreateSelectionObject(playerid, j, g_obj_bath[i][0]);
					gPSelectedObjModel[playerid][j] = g_obj_bath[i][0];
					gPSelectedObjPrice[playerid][j] = g_obj_bath[i][1];
				}
				else
					break;
				j++;
			}
		}
		case CATEGORY_DECO:
		{
			new j = 0;
			for(new i = ((gPCurrentPage[playerid]-1) * 18); i < sizeof(g_obj_deco); i++)
			{
				if(j < 18)
				{
					gptObjSelect[playerid][j] = CreateSelectionObject(playerid, j, g_obj_deco[i][0]);
					gPSelectedObjModel[playerid][j] = g_obj_deco[i][0];
					gPSelectedObjPrice[playerid][j] = g_obj_deco[i][1];
				}
				else
					break;
				j++;
			}
		}
		case CATEGORY_BEDS:
		{
			new j = 0;
			for(new i = ((gPCurrentPage[playerid]-1) * 18); i < sizeof(g_obj_beds); i++)
			{
				if(j < 18)
				{
					gptObjSelect[playerid][j] = CreateSelectionObject(playerid, j, g_obj_beds[i][0]);
					gPSelectedObjModel[playerid][j] = g_obj_beds[i][0];
					gPSelectedObjPrice[playerid][j] = g_obj_beds[i][1];
				}
				else
					break;
				j++;
			}
		}
		case CATEGORY_CHAIR:
		{
			new j = 0;
			for(new i = ((gPCurrentPage[playerid]-1) * 18); i < sizeof(g_obj_chair); i++)
			{
				if(j < 18)
				{
					gptObjSelect[playerid][j] = CreateSelectionObject(playerid, j, g_obj_chair[i][0]);
					gPSelectedObjModel[playerid][i] = g_obj_chair[i][0];
					gPSelectedObjPrice[playerid][i] = g_obj_chair[i][1];
				}
				else
					break;
				j++;
			}
		}
		case CATEGORY_PLANTS:
		{
			new j = 0;
			for(new i = ((gPCurrentPage[playerid]-1) * 18); i < sizeof(g_obj_plants); i++)
			{
				if(j < 18)
				{
					gptObjSelect[playerid][j] = CreateSelectionObject(playerid, j, g_obj_plants[i][0]);
					gPSelectedObjModel[playerid][j] = g_obj_plants[i][0];
					gPSelectedObjPrice[playerid][j] = g_obj_plants[i][1];
				}
				else
					break;
				j++;
			}
		}
	}
	return 1;
}

//------------------------------------------------------------------------------

public OnPlayerSelectCategory(playerid, category)
{
    VSA_HidePlayerCategory(playerid);
    VSA_ShowPlayerSelection(playerid, category);
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerDisconnect(playerid, reason)
{
    gPIsCTDVisible[playerid] = false;
    gPIsSTDVisible[playerid] = false;
	gPSelectedObjTD[playerid] = PlayerText:INVALID_TEXT_DRAW;
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	if(_:clickedid == INVALID_TEXT_DRAW && gPIsCTDVisible[playerid]) {
	   VSA_HidePlayerCategory(playerid);
	   CancelSelectTextDraw(playerid);
	}
	else if(_:clickedid == INVALID_TEXT_DRAW && gPIsSTDVisible[playerid]) {
	   VSA_HidePlayerSelection(playerid);
	   CancelSelectTextDraw(playerid);
	}
	return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerClickPlayerTD(playerid, PlayerText:playertextid)
{
    if(gPIsCTDVisible[playerid])
    {
        if(playertextid == gptCategory[playerid][5]) {
            VSA_HidePlayerCategory(playerid);
			CancelSelectTextDraw(playerid);
			PlayCancelSound(playerid);
		}
        else if(playertextid == gptCategory[playerid][11]) {
            VSA_ShowPlayerCategory(playerid, gPCurrentCategory[playerid] - 1);
		}
        else if(playertextid == gptCategory[playerid][12]) {
            VSA_ShowPlayerCategory(playerid, gPCurrentCategory[playerid] + 1);
		}
        else if(playertextid == gptCategory[playerid][6]) {
            OnPlayerSelectCategory(playerid, gPCurrentCategory[playerid]);
		}
    }
	else if(gPIsSTDVisible[playerid])
	{
		if(playertextid == gptSelection[playerid][16]) {
			VSA_HidePlayerSelection(playerid);
			CancelSelectTextDraw(playerid);
			PlayCancelSound(playerid);
			for (new i = 0; i < sizeof(gptObjSelect[]); i++)
				if(gptObjSelect[playerid][i] != PlayerText:INVALID_TEXT_DRAW)
					PlayerTextDrawDestroy(playerid, gptObjSelect[playerid][i]);
		}
		else if(playertextid == gptSelection[playerid][9]) {
			VSA_HidePlayerSelection(playerid);
			VSA_ShowPlayerCategory(playerid, gPCurrentCategory[playerid]);
		}
		else if(playertextid == gptSelection[playerid][5])// right
		{
			if(gPCurrentPage[playerid] == gPMaxPages[playerid])
				return PlayErrorSound(playerid);

			for (new i = 0; i < sizeof(gptObjSelect[]); i++)
				if(gptObjSelect[playerid][i] != PlayerText:INVALID_TEXT_DRAW)
					PlayerTextDrawDestroy(playerid, gptObjSelect[playerid][i]);

			DrawSelectionPage(playerid, NEXT_PAGE);
			gPSelectedObjTD[playerid] = PlayerText:INVALID_TEXT_DRAW;
			PlayerTextDrawSetString(playerid, gptSelection[playerid][12], "$0");
			PlayerTextDrawBoxColor(playerid, gptSelection[playerid][7], 8388863);
			PlayerTextDrawShow(playerid, gptSelection[playerid][7]);
			PlaySelectSound(playerid);
		}
		else if(playertextid == gptSelection[playerid][6])// left
		{
			if(gPCurrentPage[playerid] == 1)
				return PlayErrorSound(playerid);

			for (new i = 0; i < sizeof(gptObjSelect[]); i++)
				if(gptObjSelect[playerid][i] != PlayerText:INVALID_TEXT_DRAW)
					PlayerTextDrawDestroy(playerid, gptObjSelect[playerid][i]);

			DrawSelectionPage(playerid, PREVIOUS_PAGE);
			gPSelectedObjTD[playerid] = PlayerText:INVALID_TEXT_DRAW;
			PlayerTextDrawSetString(playerid, gptSelection[playerid][12], "$0");
			PlayerTextDrawBoxColor(playerid, gptSelection[playerid][7], 8388863);
			PlayerTextDrawShow(playerid, gptSelection[playerid][7]);
			PlaySelectSound(playerid);
		}
		else if(playertextid == gptSelection[playerid][7])
		{
			if(gPSelectedObjTD[playerid] == PlayerText:INVALID_TEXT_DRAW || gPCurrentObjPrice[playerid] > GetPlayerCash(playerid))
			{
				PlayErrorSound(playerid);
			}
			else
			{
				OnPlayerBuyFurnitureObject(playerid, gPCurrentObjModel[playerid], gPCurrentObjPrice[playerid]);
				PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			}
		}
		else
		{
			for (new i = 0; i < sizeof(gptObjSelect[]); i++) {
				if(gptObjSelect[playerid][i] == playertextid) {
					if(gPSelectedObjTD[playerid] != PlayerText:INVALID_TEXT_DRAW) {
						PlayerTextDrawColor(playerid, gPSelectedObjTD[playerid], -1);
						PlayerTextDrawShow(playerid, gPSelectedObjTD[playerid]);
					}
					gPSelectedObjTD[playerid] = gptObjSelect[playerid][i];
					PlayerTextDrawColor(playerid, gptObjSelect[playerid][i], 0x97d53fff);
					PlayerTextDrawShow(playerid, gptObjSelect[playerid][i]);
					PlaySelectSound(playerid);

					new sPriceText[24];
					format(sPriceText, sizeof(sPriceText), "$%i", gPSelectedObjPrice[playerid][i]);
					PlayerTextDrawSetString(playerid, gptSelection[playerid][12], sPriceText);

					gPCurrentObjPrice[playerid] = gPSelectedObjPrice[playerid][i];
					gPCurrentObjModel[playerid] = gPSelectedObjModel[playerid][i];

					if(gPSelectedObjPrice[playerid][i] > GetPlayerCash(playerid))
					{
						PlayerTextDrawBoxColor(playerid, gptSelection[playerid][7], 0xaa251dff);
						PlayerTextDrawShow(playerid, gptSelection[playerid][7]);
					}
					else
					{
						PlayerTextDrawBoxColor(playerid, gptSelection[playerid][7], 8388863);
						PlayerTextDrawShow(playerid, gptSelection[playerid][7]);
					}
				}
			}
		}
	}
    return 1;
}
