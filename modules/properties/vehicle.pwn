/*******************************************************************************
* FILENAME :        modules/properties/vehicle.pwn
*
* DESCRIPTION :
*       Makes available for players to buy vehicles.
*
* NOTES :
*       This file should only contain player's vehicle data & funcs.
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

//------------------------------------------------------------------------------

#include "../modules/visual/dealership.pwn"
#include <YSI\y_hooks>

#if !defined MAX_VEHICLES_PER_PLAYER
	#define MAX_VEHICLES_PER_PLAYER	10
#endif

#define CARMODTYPE_FRONT_BULLBAR 	14
#define CARMODTYPE_REAR_BULLBAR 	15
#define CARMODTYPE_SIDESKIRT_RIGHT 	3
#define CARMODTYPE_SIDESKIRT_LEFT 	16

//------------------------------------------------------------------------------

// Checkpointid
static STREAMER_TAG_CP gCheckpointid;

//------------------------------------------------------------------------------

static spoiler[20][0] =
{
	{1000},    {1001},     {1002},    {1003},    {1014},    {1015},    {1016},
    {1023},    {1058},     {1060},    {1049},    {1050},	{1138},    {1139},
    {1146},    {1147},     {1158},    {1162},    {1163},    {1164}
};

static nitro[3][0] =
{
    {1008},    {1009},    {1010}
};

static fbumper[23][0] =
{
    {1117},    {1152},    {1153},    {1155},    {1157},    {1160},    {1165},
    {1167},    {1169},    {1170},    {1171},    {1172},    {1173},    {1174},
    {1175},    {1179},    {1181},    {1182},    {1185},    {1188},    {1189},
    {1192},    {1193}
};

static rbumper[22][0] =
{
    {1140},    {1141},    {1148},    {1149},    {1150},    {1151},    {1154},
    {1156},    {1159},    {1161},    {1166},    {1168},    {1176},    {1177},
    {1178},    {1180},    {1183},    {1184},    {1186},    {1187},    {1190},
    {1191}
};

static exhaust[28][0] =
{
    {1018},    {1019},    {1020},    {1021},    {1022},    {1028},    {1029},
    {1037},    {1043},    {1044},    {1045},    {1046},    {1059},    {1064},
    {1065},    {1066},    {1089},    {1092},    {1104},    {1105},    {1113},
    {1114},    {1126},    {1127},    {1129},    {1132},    {1135},    {1136}
};

static bventr[2][0] =
{
    {1142},    {1144}
};

static bventl[2][0] =
{
    {1143},    {1145}
};

static bscoop[4][0] =
{
	{1004},    {1005},     {1011},	{1012}
};

static rscoop[17][0] =
{
    {1006},    {1032},    {1033},    {1035},    {1038},    {1053},    {1054},
    {1055},    {1061},    {1067},    {1068},    {1088},    {1091},    {1103},
    {1128},    {1130},    {1131}
};

static lskirt[21][0] =
{
    {1007},    {1026},    {1031},    {1036},    {1039},    {1042},    {1047},
    {1048},    {1056},    {1057},    {1069},    {1070},    {1090},    {1093},
    {1106},    {1108},    {1118},    {1119},    {1133},    {1122},    {1134}
};

static rskirt[21][0] =
{
    {1017},    {1027},    {1030},    {1040},    {1041},    {1051},    {1052},
    {1062},    {1063},    {1071},    {1072},    {1094},    {1095},    {1099},
    {1101},    {1102},    {1107},    {1120},    {1121},    {1124},    {1137}
};

static hydraulics[1][0] =
{
    {1087}
};

static base[1][0] =
{
    {1086}
};

static rbbars[4][0] =
{
    {1109},    {1110},    {1123},    {1125}
};

static fbbars[2][0] =
{
    {1115},    {1116}
};

static wheels[17][0] =
{
    {1025},    {1073},    {1074},    {1075},    {1076},    {1077},    {1078},
    {1079},    {1080},    {1081},    {1082},    {1083},    {1084},    {1085},
    {1096},    {1097},    {1098}
};

static mlights[2][0] =
{
	{1013},	{1024}
};

//------------------------------------------------------------------------------

forward OnPlayerBuyOnDealership(playerid, i);
forward OnInsertVehicleOnDatabase(playerid, i);
forward OnLoadPlayerVehicle(playerid);

//------------------------------------------------------------------------------

enum E_DEALERSHIP_VEHICLE
{
	E_DEALERSHIP_VEHICLE_DBID,
	E_DEALERSHIP_VEHICLE_ID,
	E_DEALERSHIP_VEHICLE_OWNER[MAX_PLAYER_NAME],
	E_DEALERSHIP_VEHICLE_MODEL,
	Float:E_DEALERSHIP_VEHICLE_X,
	Float:E_DEALERSHIP_VEHICLE_Y,
	Float:E_DEALERSHIP_VEHICLE_Z,
	Float:E_DEALERSHIP_VEHICLE_A,
	E_DEALERSHIP_VEHICLE_WORLD,
	E_DEALERSHIP_VEHICLE_INTERIOR,
	E_DEALERSHIP_VEHICLE_COLOR1,
	E_DEALERSHIP_VEHICLE_COLOR2,
	E_DEALERSHIP_VEHICLE_PAINTJOB,
	Float:E_DEALERSHIP_VEHICLE_HEALTH,
	Float:E_DEALERSHIP_VEHICLE_FUEL,
	E_DEALERSHIP_VEHICLE_FINES,
	E_DEALERSHIP_VEHICLE_MOD[17]
}
new g_pDealershipData[MAX_PLAYERS][MAX_VEHICLES_PER_PLAYER][E_DEALERSHIP_VEHICLE];

//------------------------------------------------------------------------------

enum E_VEH_BROWSING
{
	E_VEH_BROWSING_ID,
	E_VEH_BROWSING_MODEL,
	E_VEH_BROWSING_COLOR,
	E_VEH_BROWSING_CAMERA,
	E_VEH_BROWSING_CATEGORY,
	Float:E_VEH_BROWSING_ANGLE
}
new g_pDealershipVehicle[MAX_PLAYERS][E_VEH_BROWSING];

//------------------------------------------------------------------------------

new Float:gDealershipCameraPositions[][] =
{
	// Pos                           Lookat
	{-1653.3234, 1216.7306, 20.6485, -1654.0436, 1216.0315, 20.7035},
	{-1665.6194, 1219.1180, 21.7113, -1665.1174, 1218.2495, 21.6362},
	{-1673.4553, 1202.9818, 21.6726, -1672.5941, 1203.4952, 21.6176},
	{-1654.3129, 1208.0957, 21.4308, -1655.2878, 1208.3304, 21.4407},
	{-1664.0032, 1211.3092, 31.3520, -1663.0002, 1211.2820, 28.3969},
	{-1650.3627, 1211.8293, 26.1431, -1651.3571, 1211.7007, 25.6380}
};

//------------------------------------------------------------------------------

new g_dealership_vehicles[][] =
{
	{400, 30000, 0},		{401, 22000, 1},		{402, 225000, 2},		{404, 55000, 3},
	{405, 47000, 1},		{409, 100000, 4},		{410, 19000, 1},		{411, 1000000, 2},
	{412, 85000, 10},		{413, 93000, 6},		{414, 110000, 6},		{415, 350000, 2},
	{418, 60000, 3},		{419, 48000, 1},		{420, 60000, 5},		{421, 14000, 1},
	{422, 29000, 6},		{423, 27000, 4},		{424, 125000, 0},		{426, 95000, 1},
	{429, 450000, 2},		{434, 750000, 4},		{436, 85000, 1},		{438, 43000, 5},
	{439, 136000, 8},		{440, 98000, 6},		{442, 136000, 4},		{445, 110000, 1},
	{451, 950000, 2},		{457, 10000, 4},		{458, 173000, 3},		{459, 74000, 6},
	{461, 10000, 7},		{462, 2500, 7},			{463, 110000, 7},		{466, 74000, 1},
	{467, 65000, 1},		{468, 46000, 7},		{471, 7500, 7},			{474, 29000, 1},
	{475, 97400, 2},		{477, 690000, 2},		{478, 12000, 6},		{479, 74000, 3},
	{480, 237000, 8},		{481, 100, 7},			{482, 90000, 6},		{483, 125000, 4},
	{489, 130000, 0},		{491, 45000, 1},		{492, 36000, 1},		{494, 1250000, 2},
	{495, 325000, 0},		{496, 17000, 9},		{498, 100000, 6},		{499, 175000, 6},
	{500, 69000, 0},		{502, 1250000, 2},		{503, 1250000, 2},		{504, 250000, 1},
	{505, 69000, 0},		{506, 600000, 2},		{507, 130000, 1},		{508, 300000, 3},
	{509, 90, 7},			{510, 250, 7},			{516, 98000, 1},		{517, 45000, 1},
	{518, 125000, 1},		{521, 140000, 7},		{522, 1500000, 7},		{526, 32000, 1},
	{527, 46000, 1},		{529, 14000, 1},		{533, 145000, 8},		{534, 185000, 10},
	{535, 280000, 10},		{536, 110000, 10},		{540, 165000, 1},		{541, 850000, 2},
	{542, 22000, 1},		{543, 47000, 6},		{545, 234000, 4},		{546, 96000, 1},
	{547, 109000, 1},		{549, 165000, 1},		{550, 205000, 1},		{551, 149000, 1},
	{552, 285000, 6},		{554, 195000, 6},		{555, 105000, 8},		{558, 495000, 2},
	{559, 510000, 2},		{560, 650000, 2},		{561, 245000, 1},		{562, 680000, 2},
	{565, 325000, 2},		{566, 130000, 10},		{567, 200000, 10},		{575, 123000, 10},
	{576, 105000, 10},		{579, 160000, 0},		{580, 98000, 1},		{581, 29000, 7},
	{585, 29000, 1},		{586, 45000, 7},		{587, 485000, 2},		{589, 96000, 9},
	{600, 58000, 6},		{602, 345000, 2},		{603, 475000, 2},		{604, 2500, 1},
	{605, 2000, 6},			{609, 103000, 6}
};

//------------------------------------------------------------------------------

new g_dealership_categories[][] =
{
	{"Off-Road"},	{"Sedan"},		{"Esportivo"},	{"Mini Van"},		{"Unico"},
	{"Publico"},	{"Industrial"},	{"Motos"},		{"Conversiveis"},	{"Compacto"},
	{"Lowrider"}
};

//------------------------------------------------------------------------------

new Timer:g_t_PlayerBrowsingDealership[MAX_PLAYERS];
new g_p_EnabledDealershipVehicleID[MAX_PLAYERS] = { INVALID_VEHICLE_ID, ... };
new g_p_EnabledDealershipVehicleKey[MAX_PLAYERS];

/***
 *    ######## ##     ## ##    ##  ######  ######## ####  #######  ##    ##  ######
 *    ##       ##     ## ###   ## ##    ##    ##     ##  ##     ## ###   ## ##    ##
 *    ##       ##     ## ####  ## ##          ##     ##  ##     ## ####  ## ##
 *    ######   ##     ## ## ## ## ##          ##     ##  ##     ## ## ## ##  ######
 *    ##       ##     ## ##  #### ##          ##     ##  ##     ## ##  ####       ##
 *    ##       ##     ## ##   ### ##    ##    ##     ##  ##     ## ##   ### ##    ##
 *    ##        #######  ##    ##  ######     ##    ####  #######  ##    ##  ######
 ***/

//--------------------------------------------------------------------

ResetPlayerVehicleData(playerid)
{
    for (new i = 0; i < MAX_VEHICLES_PER_PLAYER; i++)
	{
		g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_DBID]		= 0;
		g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_ID]			= 0;
		g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MODEL]		= 0;
		g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_WORLD]		= 0;
		g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_INTERIOR]	= 0;
		g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_COLOR1]		= 0;
		g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_COLOR2]		= 0;
		g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_PAINTJOB]	= -1;
		g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_HEALTH]		= 0.0;
		g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_FUEL]		= 0.0;
		g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_FINES]		= 0;

		g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][0]		= 0;
		g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][1]		= 0;
		g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][2]		= 0;
		g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][3]		= 0;
		g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][4]		= 0;
		g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][5]		= 0;
		g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][6]		= 0;
		g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][7]		= 0;
		g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][8]		= 0;
		g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][9]		= 0;
		g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][10]	= 0;
		g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][11]	= 0;
		g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][12]	= 0;
		g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][13]	= 0;
		g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][14]	= 0;
		g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][15]	= 0;
		g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][16]	= 0;

		g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_X] = 0.0;
		g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_Y] = 0.0;
		g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_Z] = 0.0;
		g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_A] = 0.0;
	}
}

//--------------------------------------------------------------------

/*
	Gets the vehicle 2D position
*/

GetDealershipVehicle2DPos(playerid, i, &Float:x, &Float:y)
{
	x = g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_X];
	y = g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_Y];
}

GetDealershipVehicleFines(playerid, i)
{
	return g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_FINES];
}

GetDealershipVehicleModel(playerid, i)
{
	return g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MODEL];
}

Float:GetDealershipVehicleFuel(playerid, i)
{
	return g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_FUEL];
}

GetDealershipVehicleHealth(playerid, i)
{
	return floatround(g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_HEALTH]);
}

GetDealershipVehicleColor(playerid, i, &col1, &col2)
{
	col1 = g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_COLOR1];
	col2 = g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_COLOR2];
}


//--------------------------------------------------------------------

/*
	Checks if a player has a vehicle bought in dealership
		return true if player has a vehicle
		return false if hasn't
*/

PlayerHasVehicle(playerid)
{
	for(new i = 0; i < MAX_VEHICLES_PER_PLAYER; i++)
		if(g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_DBID] != 0)
			return true;
	return false;
}

//--------------------------------------------------------------------

/*
	Gets player vehicle free slot
		return the ID of the slot if any
		return -1 if there's no free slot
*/

GetPlayerFreeVehicleSlot(playerid)
{
	for(new i = 0; i < MAX_VEHICLES_PER_PLAYER; i++)
		if(g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_DBID] == 0)
			return i;
	return -1;
}

//--------------------------------------------------------------------

/*
	Send a query to load all player vehicles
		playerid - ID of the player
*/
IsPlayerBrowsingDealership(playerid)
{
	return (g_pDealershipVehicle[playerid][E_VEH_BROWSING_ID]);
}

//--------------------------------------------------------------------

/*
	Send a query to load all player vehicles
		playerid - ID of the player
*/

LoadPlayerVehicles(playerid)
{
	new query[64];
	mysql_format(mysql, query, sizeof(query), "SELECT * FROM `dealership` WHERE `OwnerID` = %i", GetPlayerDatabaseID(playerid));
	mysql_pquery(mysql, query, "OnLoadPlayerVehicle", "i", playerid);
}

//--------------------------------------------------------------------

/*
	Called when a player clicks a player textdraw
		playerid - ID of the player
		playertextid - ID of the clicked textdraw
*/

hook OnPlayerClickPlayerTD(playerid, PlayerText:playertextid)
{
	if(!GetPVarInt(playerid, "isDealershipHudVisible"))
		return 1;

	new vehicleid = g_pDealershipVehicle[playerid][E_VEH_BROWSING_ID];
	if(playertextid == deal_modelright[playerid])
	{
		PlaySelectSound(playerid);

		new category_id = g_pDealershipVehicle[playerid][E_VEH_BROWSING_CATEGORY];
		new bool:found = false;

		for(new i = 0; i < sizeof(g_dealership_vehicles); i++)
		{
			if(i <= g_pDealershipVehicle[playerid][E_VEH_BROWSING_MODEL])
				continue;

			if(category_id == g_dealership_vehicles[i][2])
			{
				g_pDealershipVehicle[playerid][E_VEH_BROWSING_MODEL] = i;
				found = true;
				break;
			}
		}

		if(!found)
		{
			for(new i = 0; i < sizeof(g_dealership_vehicles); i++)
			{
				if(category_id == g_dealership_vehicles[i][2])
				{
					g_pDealershipVehicle[playerid][E_VEH_BROWSING_MODEL] = i;
					break;
				}
			}
		}

		stop g_t_PlayerBrowsingDealership[playerid];

		new modelid = g_pDealershipVehicle[playerid][E_VEH_BROWSING_MODEL];
		DestroyVehicle(vehicleid);

		g_pDealershipVehicle[playerid][E_VEH_BROWSING_ID] = CreateVehicle(g_dealership_vehicles[modelid][0], -1660.6149, 1210.5865, 21.3845, g_pDealershipVehicle[playerid][E_VEH_BROWSING_ANGLE], g_pDealershipVehicle[playerid][E_VEH_BROWSING_COLOR], g_pDealershipVehicle[playerid][E_VEH_BROWSING_COLOR], -1);
		vehicleid = g_pDealershipVehicle[playerid][E_VEH_BROWSING_ID];
		SetVehicleVirtualWorld(vehicleid, GetPlayerVirtualWorld(playerid));

		PlayerTextDrawSetString(playerid, deal_modelname[playerid], GetVehicleName(vehicleid));
		PlayerTextDrawSetString(playerid, deal_categoryname[playerid], g_dealership_categories[g_dealership_vehicles[modelid][2]]);

		g_pDealershipVehicle[playerid][E_VEH_BROWSING_CATEGORY] = g_dealership_vehicles[modelid][2];

		new price[18];
		format(price, sizeof(price), "$%s", formatnumber(g_dealership_vehicles[modelid][1]));
		PlayerTextDrawSetString(playerid, deal_pricename[playerid], price);

		g_t_PlayerBrowsingDealership[playerid] = repeat OnDealershipBrowsingUpdate(playerid);
	}
	else if(playertextid == deal_modelleft[playerid])
	{
		PlayCancelSound(playerid);

		new category_id = g_pDealershipVehicle[playerid][E_VEH_BROWSING_CATEGORY];
		new bool:found = false;

		for(new i = sizeof(g_dealership_vehicles); i > -1; i--)
		{
			if(i >= g_pDealershipVehicle[playerid][E_VEH_BROWSING_MODEL])
				continue;

			if(category_id == g_dealership_vehicles[i][2])
			{
				g_pDealershipVehicle[playerid][E_VEH_BROWSING_MODEL] = i;
				found = true;
				break;
			}
		}

		if(!found)
		{
			for(new i = sizeof(g_dealership_vehicles)-1; i > -1; i--)
			{
				if(category_id == g_dealership_vehicles[i][2])
				{
					g_pDealershipVehicle[playerid][E_VEH_BROWSING_MODEL] = i;
					break;
				}
			}
		}

		stop g_t_PlayerBrowsingDealership[playerid];

		new modelid = g_pDealershipVehicle[playerid][E_VEH_BROWSING_MODEL];
		DestroyVehicle(vehicleid);

		g_pDealershipVehicle[playerid][E_VEH_BROWSING_ID] = CreateVehicle(g_dealership_vehicles[modelid][0], -1660.6149, 1210.5865, 21.3845, g_pDealershipVehicle[playerid][E_VEH_BROWSING_ANGLE], g_pDealershipVehicle[playerid][E_VEH_BROWSING_COLOR], g_pDealershipVehicle[playerid][E_VEH_BROWSING_COLOR], -1);
		vehicleid = g_pDealershipVehicle[playerid][E_VEH_BROWSING_ID];
		SetVehicleVirtualWorld(vehicleid, GetPlayerVirtualWorld(playerid));

		PlayerTextDrawSetString(playerid, deal_modelname[playerid], GetVehicleName(vehicleid));
		PlayerTextDrawSetString(playerid, deal_categoryname[playerid], g_dealership_categories[g_dealership_vehicles[modelid][2]]);

		g_pDealershipVehicle[playerid][E_VEH_BROWSING_CATEGORY] = g_dealership_vehicles[modelid][2];

		new price[18];
		format(price, sizeof(price), "$%s", formatnumber(g_dealership_vehicles[modelid][1]));
		PlayerTextDrawSetString(playerid, deal_pricename[playerid], price);

		g_t_PlayerBrowsingDealership[playerid] = repeat OnDealershipBrowsingUpdate(playerid);
	}
	else if(playertextid == deal_colorright[playerid])
	{
		PlaySelectSound(playerid);
		g_pDealershipVehicle[playerid][E_VEH_BROWSING_COLOR]++;
		if(g_pDealershipVehicle[playerid][E_VEH_BROWSING_COLOR] > 126)
			g_pDealershipVehicle[playerid][E_VEH_BROWSING_COLOR] = 0;
		new color[12];
		format(color, sizeof(color), "%d/126", g_pDealershipVehicle[playerid][E_VEH_BROWSING_COLOR]);
		PlayerTextDrawSetString(playerid, deal_colorname[playerid], color);
		ChangeVehicleColor(vehicleid, g_pDealershipVehicle[playerid][E_VEH_BROWSING_COLOR], g_pDealershipVehicle[playerid][E_VEH_BROWSING_COLOR]);
	}
	else if(playertextid == deal_colorleft[playerid])
	{
		PlayCancelSound(playerid);
		g_pDealershipVehicle[playerid][E_VEH_BROWSING_COLOR]--;
		if(g_pDealershipVehicle[playerid][E_VEH_BROWSING_COLOR] < 0)
			g_pDealershipVehicle[playerid][E_VEH_BROWSING_COLOR] = 126;
		new color[12];
		format(color, sizeof(color), "%d/126", g_pDealershipVehicle[playerid][E_VEH_BROWSING_COLOR]);
		PlayerTextDrawSetString(playerid, deal_colorname[playerid], color);
		ChangeVehicleColor(vehicleid, g_pDealershipVehicle[playerid][E_VEH_BROWSING_COLOR], g_pDealershipVehicle[playerid][E_VEH_BROWSING_COLOR]);
	}
	else if(playertextid == deal_cameraright[playerid])
	{
		PlaySelectSound(playerid);
		g_pDealershipVehicle[playerid][E_VEH_BROWSING_CAMERA]++;
		if(g_pDealershipVehicle[playerid][E_VEH_BROWSING_CAMERA] > sizeof(gDealershipCameraPositions)-1)
			g_pDealershipVehicle[playerid][E_VEH_BROWSING_CAMERA] = 0;
		new camera[12];
		format(camera, sizeof(camera), "%d/%d", g_pDealershipVehicle[playerid][E_VEH_BROWSING_CAMERA] + 1, sizeof(gDealershipCameraPositions));
		PlayerTextDrawSetString(playerid, deal_cameraname[playerid], camera);

		new camid = g_pDealershipVehicle[playerid][E_VEH_BROWSING_CAMERA];
		SetPlayerCameraPos(playerid, gDealershipCameraPositions[camid][0], gDealershipCameraPositions[camid][1], gDealershipCameraPositions[camid][2]);
		SetPlayerCameraLookAt(playerid, gDealershipCameraPositions[camid][3], gDealershipCameraPositions[camid][4], gDealershipCameraPositions[camid][5], CAMERA_MOVE);
	}
	else if(playertextid == deal_cameraleft[playerid])
	{
		PlayCancelSound(playerid);
		g_pDealershipVehicle[playerid][E_VEH_BROWSING_CAMERA]--;
		if(g_pDealershipVehicle[playerid][E_VEH_BROWSING_CAMERA] < 0)
			g_pDealershipVehicle[playerid][E_VEH_BROWSING_CAMERA] = sizeof(gDealershipCameraPositions)-1;
		new camera[12];
		format(camera, sizeof(camera), "%d/%d", g_pDealershipVehicle[playerid][E_VEH_BROWSING_CAMERA] + 1, sizeof(gDealershipCameraPositions));
		PlayerTextDrawSetString(playerid, deal_cameraname[playerid], camera);

		new camid = g_pDealershipVehicle[playerid][E_VEH_BROWSING_CAMERA];
		SetPlayerCameraPos(playerid, gDealershipCameraPositions[camid][0], gDealershipCameraPositions[camid][1], gDealershipCameraPositions[camid][2]);
		SetPlayerCameraLookAt(playerid, gDealershipCameraPositions[camid][3], gDealershipCameraPositions[camid][4], gDealershipCameraPositions[camid][5], CAMERA_MOVE);
	}
	else if(playertextid == deal_categoryright[playerid])
	{
		PlaySelectSound(playerid);
		g_pDealershipVehicle[playerid][E_VEH_BROWSING_CATEGORY]++;
		if(g_pDealershipVehicle[playerid][E_VEH_BROWSING_CATEGORY] > sizeof(g_dealership_categories) - 1)
			g_pDealershipVehicle[playerid][E_VEH_BROWSING_CATEGORY] = 0;

		new category_id = g_pDealershipVehicle[playerid][E_VEH_BROWSING_CATEGORY];
		PlayerTextDrawSetString(playerid, deal_categoryname[playerid], g_dealership_categories[category_id]);

		for(new i = 0; i < sizeof(g_dealership_vehicles); i++)
		{
			if(category_id == g_dealership_vehicles[i][2])
			{
				stop g_t_PlayerBrowsingDealership[playerid];

				g_pDealershipVehicle[playerid][E_VEH_BROWSING_MODEL] = i;
				new modelid = g_pDealershipVehicle[playerid][E_VEH_BROWSING_MODEL];
				DestroyVehicle(vehicleid);

				g_pDealershipVehicle[playerid][E_VEH_BROWSING_ID] = CreateVehicle(g_dealership_vehicles[modelid][0], -1660.6149, 1210.5865, 21.3845, g_pDealershipVehicle[playerid][E_VEH_BROWSING_ANGLE], g_pDealershipVehicle[playerid][E_VEH_BROWSING_COLOR], g_pDealershipVehicle[playerid][E_VEH_BROWSING_COLOR], -1);
				vehicleid = g_pDealershipVehicle[playerid][E_VEH_BROWSING_ID];
				SetVehicleVirtualWorld(vehicleid, GetPlayerVirtualWorld(playerid));
				PlayerTextDrawSetString(playerid, deal_modelname[playerid], GetVehicleName(vehicleid));

				new price[12];
				format(price, sizeof(price), "$%i", g_dealership_vehicles[modelid][1]);
				PlayerTextDrawSetString(playerid, deal_pricename[playerid], price);

				g_t_PlayerBrowsingDealership[playerid] = repeat OnDealershipBrowsingUpdate(playerid);
				break;
			}
		}
	}
	else if(playertextid == deal_categoryleft[playerid])
	{
		PlayCancelSound(playerid);
		g_pDealershipVehicle[playerid][E_VEH_BROWSING_CATEGORY]--;
		if(g_pDealershipVehicle[playerid][E_VEH_BROWSING_CATEGORY] < 0)
			g_pDealershipVehicle[playerid][E_VEH_BROWSING_CATEGORY] = sizeof(g_dealership_categories) - 1;

		new category_id = g_pDealershipVehicle[playerid][E_VEH_BROWSING_CATEGORY];
		PlayerTextDrawSetString(playerid, deal_categoryname[playerid], g_dealership_categories[category_id]);

		for(new i = 0; i < sizeof(g_dealership_vehicles); i++)
		{
			if(category_id == g_dealership_vehicles[i][2])
			{
				stop g_t_PlayerBrowsingDealership[playerid];

				g_pDealershipVehicle[playerid][E_VEH_BROWSING_MODEL] = i;
				new modelid = g_pDealershipVehicle[playerid][E_VEH_BROWSING_MODEL];
				DestroyVehicle(vehicleid);

				g_pDealershipVehicle[playerid][E_VEH_BROWSING_ID] = CreateVehicle(g_dealership_vehicles[modelid][0], -1660.6149, 1210.5865, 21.3845, g_pDealershipVehicle[playerid][E_VEH_BROWSING_ANGLE], g_pDealershipVehicle[playerid][E_VEH_BROWSING_COLOR], g_pDealershipVehicle[playerid][E_VEH_BROWSING_COLOR], -1);
				vehicleid = g_pDealershipVehicle[playerid][E_VEH_BROWSING_ID];
				SetVehicleVirtualWorld(vehicleid, GetPlayerVirtualWorld(playerid));
				PlayerTextDrawSetString(playerid, deal_modelname[playerid], GetVehicleName(vehicleid));

				new price[12];
				format(price, sizeof(price), "$%i", g_dealership_vehicles[modelid][1]);
				PlayerTextDrawSetString(playerid, deal_pricename[playerid], price);

				g_t_PlayerBrowsingDealership[playerid] = repeat OnDealershipBrowsingUpdate(playerid);
				break;
			}
		}
	}
	else if(playertextid == deal_confirm[playerid])
	{
		new modelid = g_pDealershipVehicle[playerid][E_VEH_BROWSING_MODEL];
		if(GetPlayerCash(playerid) < g_dealership_vehicles[modelid][1])
		{
			PlayErrorSound(playerid);
			SendClientMessage(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiente.");
		}
		else if(GetPlayerFreeVehicleSlot(playerid) == -1)
		{
			PlayErrorSound(playerid);
			SendClientMessage(playerid, COLOR_ERROR, "* Você já possui o limite máximo de veículos por jogador.");
		}
		else
		{
			for(new i = 0; i < MAX_VEHICLES_PER_PLAYER; i++)
			{
				if(GetPlayerFreeVehicleSlot(playerid) == i)
				{
					// Checking if the player has any personal vehicle spawned
					if(g_p_EnabledDealershipVehicleID[playerid] != INVALID_VEHICLE_ID)
						DestroyVehicle(g_p_EnabledDealershipVehicleID[playerid]);

					// Playing sound
					PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);

					// Assigning variables
					new playerName[MAX_PLAYER_NAME];
					GetPlayerName(playerid, playerName, MAX_PLAYER_NAME);
					g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MODEL]		= g_dealership_vehicles[g_pDealershipVehicle[playerid][E_VEH_BROWSING_MODEL]][0];
					g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_X]			= 540.2969;
					g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_Y]			= -1273.1838;
					g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_Z]			= 16.9693;
					g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_A]			= 222.6622;
					g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_WORLD]		= 0;
					g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_INTERIOR]	= 0;
					g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_COLOR1]		= g_pDealershipVehicle[playerid][E_VEH_BROWSING_COLOR];
					g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_COLOR2]		= g_pDealershipVehicle[playerid][E_VEH_BROWSING_COLOR];
					g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_PAINTJOB]	= -1;
					g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_HEALTH]		= 1000.0;
					g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_FUEL]		= 50.0;
					g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_FINES]		= 0;
					strcat(g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_OWNER], playerName);
					for(new j = 0; j < 17; j++)
						g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][j] = 0;

					// Deleting dealership stuff
					DestroyVehicle(g_pDealershipVehicle[playerid][E_VEH_BROWSING_ID]);
					stop g_t_PlayerBrowsingDealership[playerid];
					g_pDealershipVehicle[playerid][E_VEH_BROWSING_ID]		= 0;
					g_pDealershipVehicle[playerid][E_VEH_BROWSING_COLOR]	= 0;
					g_pDealershipVehicle[playerid][E_VEH_BROWSING_MODEL]	= 0;
					g_pDealershipVehicle[playerid][E_VEH_BROWSING_CAMERA]	= 0;
					g_pDealershipVehicle[playerid][E_VEH_BROWSING_CATEGORY]	= 0;
					g_pDealershipVehicle[playerid][E_VEH_BROWSING_ANGLE]	= 0.0;
					HidePlayerDealershipHud(playerid);


					// Creating vehicle
					new model = g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MODEL];
					new Float:x = g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_X];
					new Float:y = g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_Y];
					new Float:z = g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_Z];
					new Float:a = g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_A];
					new color = g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_COLOR1];
					g_p_EnabledDealershipVehicleID[playerid] = CreateVehicle(model, x, y, z, a, color, color, -1);
					g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_ID] = g_p_EnabledDealershipVehicleID[playerid];
					g_p_EnabledDealershipVehicleKey[playerid] = i;

					// Sending player back to los santos
					SetCameraBehindPlayer(playerid);
					SetPlayerVirtualWorld(playerid, 0);
					TogglePlayerControllable(playerid, true);
					PutPlayerInVehicle(playerid, g_p_EnabledDealershipVehicleID[playerid], 0);
					SetVehicleFuel(g_p_EnabledDealershipVehicleID[playerid], 50);

					// Sending message of success
					new message[128];
					format(message, sizeof(message), "* Você comprou um {8CB3B8}%s{87FFC5} por {8CB3B8}$%i{87FFC5}.", GetVehicleName(g_p_EnabledDealershipVehicleID[playerid]), g_dealership_vehicles[modelid][1]);
					SendClientMessage(playerid, 0x87FFC5FF, message);
					SendClientMessage(playerid, 0xFFFFFFFF, "* Digite /ajudaveiculo para ver os comandos.");

					// Taking player's money
					GivePlayerCash(playerid, -g_dealership_vehicles[modelid][1]);

					// Inseting player vehicle into database
					mysql_pquery(mysql, "SELECT * FROM `dealership`", "OnPlayerBuyOnDealership", "ii", playerid, i);

					// And finally, stoping de loop
					break;
				}
			}
		}
	}
	return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerEnterDynamicCP(playerid, STREAMER_TAG_CP checkpointid)
{
    if(checkpointid == gCheckpointid)
    {
        ShowPlayerDialog(playerid, DIALOG_DEALERSHIP, DIALOG_STYLE_MSGBOX, "Concessionária", "Você deseja visualizar nossos veículos?", "Sim", "Não");
        PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
        return -2;
    }
    return 1;
}

//------------------------------------------------------------------------------

hook OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	new i = g_p_EnabledDealershipVehicleKey[playerid];
	if(g_p_EnabledDealershipVehicleID[playerid] == vehicleid && vehicleid != 0)
		g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_PAINTJOB] = paintjobid;
    return 1;
}

//------------------------------------------------------------------------------

hook OnVehicleMod(playerid, vehicleid, componentid)
{
	SaveComponent(playerid, vehicleid, componentid);
	return 1;
}

//------------------------------------------------------------------------------

hook OnVehicleSpawn(vehicleid)
{
	ModVehicle(vehicleid);
	return 1;
}

//------------------------------------------------------------------------------

ModVehicle(vehicleid)
{
	foreach(new playerid: Player)
	{
		if(g_p_EnabledDealershipVehicleID[playerid] == vehicleid && vehicleid != 0)
		{
			new i = g_p_EnabledDealershipVehicleKey[playerid];
			for(new j = 0; j < 17; ++j)
			{
				if(g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][j] != 0)
				{
					AddVehicleComponent(vehicleid, g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][j]);
				}
			}
			if(g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_PAINTJOB] != -1) ChangeVehiclePaintjob(vehicleid, g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_PAINTJOB]);
		}
		return 1;
	}
	return 1;
}

//------------------------------------------------------------------------------

SaveComponent(playerid, vehicleid, componentid)
{
    if(g_p_EnabledDealershipVehicleID[playerid] != vehicleid)
    	return 1;

    new i = g_p_EnabledDealershipVehicleKey[playerid];
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) {
		for(new s=0; s<20; s++) {
				if(componentid == spoiler[s][0]) {
					g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][0] = componentid;
			}
		}
		for(new s=0; s<4; s++) {
				if(componentid == bscoop[s][0]) {
					g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][1] = componentid;
			}
		}
		for(new s=0; s<17; s++) {
				if(componentid == rscoop[s][0]) {
					g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][2] = componentid;
			}
		}
		for(new s=0; s<21; s++) {
				if(componentid == rskirt[s][0]) {
					g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][3] = componentid;
			}
		}
		for(new s=0; s<21; s++) {
				if(componentid == lskirt[s][0]) {
					g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][16] = componentid;
			}
		}
		for(new s=0; s<2; s++) {
				if(componentid == mlights[s][0]) {
					g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][4] = componentid;
			}
		}
		for(new s=0; s<3; s++) {
				if(componentid == nitro[s][0]) {
					g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][5] = componentid;
			}
		}
		for(new s=0; s<28; s++) {
				if(componentid == exhaust[s][0]) {
					g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][6] = componentid;
			}
		}
		for(new s=0; s<17; s++) {
				if(componentid == wheels[s][0]) {
					g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][7] = componentid;
			}
		}
		for(new s=0; s<1; s++) {
				if(componentid == base[s][0]) {
					g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][8] = componentid;
			}
		}
		for(new s=0; s<1; s++) {
				if(componentid == hydraulics[s][0]) {
					g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][9] = componentid;
			}
		}
		for(new s=0; s<23; s++) {
				if(componentid == fbumper[s][0]) {
					g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][10] = componentid;
			}
		}
		for(new s=0; s<22; s++) {
				if(componentid == rbumper[s][0]) {
					g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][11] = componentid;
			}
		}
		for(new s=0; s<2; s++) {
				if(componentid == bventr[s][0]) {
					g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][12] = componentid;
			}
		}
		for(new s=0; s<2; s++) {
				if(componentid == bventl[s][0]) {
					g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][13] = componentid;
			}
		}
		for(new s=0; s<2; s++) {
				if(componentid == fbbars[s][0]) {
					g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][15] = componentid;
			}
		}
		for(new s=0; s<4; s++) {
				if(componentid == rbbars[s][0]) {
					g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][14] = componentid;
			}
		}
		new query[320];
		mysql_format(mysql, query, sizeof(query), "UPDATE `dealership` SET `Mod1`=%d, `Mod2`=%d, `Mod3`=%d, `Mod4`=%d, `Mod5`=%d, `Mod6`=%d, `Mod7`=%d\
		, `Mod8`=%d, `Mod9`=%d, `Mod10`=%d, `Mod11`=%d, `Mod12`=%d, `Mod13`=%d, `Mod14`=%d, `Mod15`=%d, `Mod16`=%d, `Mod17`=%d WHERE `ID`=%d",
		g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][0], g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][1], g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][2],
		g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][3], g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][4], g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][5],
		g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][6], g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][7], g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][8],
		g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][9], g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][10], g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][11],
		g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][12], g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][13], g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][14],
		g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][15], g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][16], g_pDealershipData[playerid][g_p_EnabledDealershipVehicleKey[playerid]][E_DEALERSHIP_VEHICLE_DBID]);
		mysql_pquery(mysql, query);
		return 1;
	}
	return 0;
}

/***
 *     ######     ###    ##       ##       ########     ###     ######  ##    ##
 *    ##    ##   ## ##   ##       ##       ##     ##   ## ##   ##    ## ##   ##
 *    ##        ##   ##  ##       ##       ##     ##  ##   ##  ##       ##  ##
 *    ##       ##     ## ##       ##       ########  ##     ## ##       #####
 *    ##       ######### ##       ##       ##     ## ######### ##       ##  ##
 *    ##    ## ##     ## ##       ##       ##     ## ##     ## ##    ## ##   ##
 *     ######  ##     ## ######## ######## ########  ##     ##  ######  ##    ##
 ***/

//--------------------------------------------------------------------

/*
	Called when a player buys a vehicle on dealership
		playerid - ID of the player
		i - vehicle key ID
*/

public OnPlayerBuyOnDealership(playerid, i)
{
	new playerName[MAX_PLAYER_NAME];
	GetPlayerName(playerid, playerName, MAX_PLAYER_NAME);

	new query[580 + MAX_PLAYER_NAME];
	mysql_format(mysql, query, sizeof(query),
	"INSERT INTO `dealership` (`ID`, `Owner`, `OwnerID`, `Model`, `X`, `Y`, `Z`, `A`, `World`, `Interior`, `Color1`, `Color2`, `Paintjob`, `Health`, `Fuel`, `Fines`, `Mod1`, `Mod2`, `Mod3`, `Mod4`, `Mod5`, `Mod6`, `Mod7`, `Mod8`, `Mod9`, `Mod10`, `Mod11`, `Mod12`, `Mod13`, `Mod14`, `Mod15`, `Mod16`, `Mod17`) \
	VALUES (%d, '%e', %d, %d, %.2f, %.2f, %.2f, %.2f, %d, %d, %d, %d, %d, %.3f, %.3f, %d, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)",
	g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_DBID], playerName, GetPlayerDatabaseID(playerid), g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MODEL], g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_X],
	g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_Y], g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_Z], g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_A],
	g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_WORLD], g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_INTERIOR], g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_COLOR1],
	g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_COLOR1], g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_PAINTJOB], g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_HEALTH],
	g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_FUEL], g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_FINES]);
	mysql_pquery(mysql, query, "OnInsertVehicleOnDatabase", "ii", playerid, i);
}

//--------------------------------------------------------------------

/*
	Tries to load player's vehicles
		playerid - ID of the player
		i - key id
*/

public OnLoadPlayerVehicle(playerid)
{
	new rows, fields;
	cache_get_data(rows, fields, mysql);
	if(rows)
	{
		for (new i = 0; i < rows; i++)
		{
			if(i > (sizeof(g_pDealershipData[])-1))
				break;

			g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_DBID]		= cache_get_field_content_int(i, "ID");
			g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_ID]			= 0;
			g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MODEL]		= cache_get_field_content_int(i, "Model");
			g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_WORLD]		= cache_get_field_content_int(i, "World");
			g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_INTERIOR]	= cache_get_field_content_int(i, "Interior");
			g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_COLOR1]		= cache_get_field_content_int(i, "Color1");
			g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_COLOR2]		= cache_get_field_content_int(i, "Color2");
			g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_PAINTJOB]	= cache_get_field_content_int(i, "Paintjob");
			g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_HEALTH]		= cache_get_field_content_float(i, "Health");
			g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_FUEL]		= cache_get_field_content_float(i, "Fuel");
			g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_FINES]		= cache_get_field_content_int(i, "Fines");

			g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][0]		= cache_get_field_content_int(i, "Mod1");
			g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][1]		= cache_get_field_content_int(i, "Mod2");
			g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][2]		= cache_get_field_content_int(i, "Mod3");
			g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][3]		= cache_get_field_content_int(i, "Mod4");
			g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][4]		= cache_get_field_content_int(i, "Mod5");
			g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][5]		= cache_get_field_content_int(i, "Mod6");
			g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][6]		= cache_get_field_content_int(i, "Mod7");
			g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][7]		= cache_get_field_content_int(i, "Mod8");
			g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][8]		= cache_get_field_content_int(i, "Mod9");
			g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][9]		= cache_get_field_content_int(i, "Mod10");
			g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][10]	= cache_get_field_content_int(i, "Mod11");
			g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][11]	= cache_get_field_content_int(i, "Mod12");
			g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][12]	= cache_get_field_content_int(i, "Mod13");
			g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][13]	= cache_get_field_content_int(i, "Mod14");
			g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][14]	= cache_get_field_content_int(i, "Mod15");
			g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][15]	= cache_get_field_content_int(i, "Mod16");
			g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MOD][16]	= cache_get_field_content_int(i, "Mod17");

			g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_X] = cache_get_field_content_float(i, "X");
			g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_Y] = cache_get_field_content_float(i, "Y");
			g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_Z] = cache_get_field_content_float(i, "Z");
			g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_A] = cache_get_field_content_float(i, "A");

			cache_get_field_content(i, "Owner", g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_OWNER], mysql, MAX_PLAYER_NAME);
		}
	}
	VSL_ShowPlayerTextdraw(playerid);
}

//--------------------------------------------------------------------

/*
	Called when a vehicle is inserted on database
		playerid - ID of the player
		i - keyid
*/

public OnInsertVehicleOnDatabase(playerid, i)
{
	g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_DBID] = cache_insert_id();
}

//--------------------------------------------------------------------

/*
	Called when the gamemode inits
*/

hook OnGameModeInit()
{
    gCheckpointid = CreateDynamicCP(559.1527, -1292.2704, 17.2482, 1.0, 0, 0);

	CreateDynamicPickup(1239, 1, 569.9089, -1299.6195, 17.2484, -1, 0);
	CreateDynamic3DTextLabel("CONCESSIONARIA\n/venderveiculo", 0xFFFFFFFF, 569.9089, -1299.6195, 17.2484, MAX_TEXT3D_RANGE, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
}

//------------------------------------------------------------------------------

/*
	Called when a player clicks on a dialog
		playerid - ID of the player
		dialogid - ID of the dialog
		response - If clicked button 0 or button 1
		listitem - If used DIALOG_STYLE_INPUT_LIST
		inputtext - If used DIALOG_STYLE_INPUT_TEXT
*/

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		case DIALOG_DEALERSHIP:
		{
			if(!response)
			{
				PlayCancelSound(playerid);
				return -2;
			}

			PlaySelectSound(playerid);
			SetPlayerPos(playerid, -1647.4100, 1203.6558, 13.6781);
			TogglePlayerControllable(playerid, false);
			SetPlayerCameraPos(playerid, gDealershipCameraPositions[0][0], gDealershipCameraPositions[0][1], gDealershipCameraPositions[0][2]);
			SetPlayerCameraLookAt(playerid, gDealershipCameraPositions[0][3], gDealershipCameraPositions[0][4], gDealershipCameraPositions[0][5]);

			SetPlayerVirtualWorld(playerid, playerid + 1);
			g_pDealershipVehicle[playerid][E_VEH_BROWSING_ID] = CreateVehicle(g_dealership_vehicles[0][0], -1660.6149, 1210.5865, 21.3845, 314.5899, 0, 0, -1);
			g_pDealershipVehicle[playerid][E_VEH_BROWSING_COLOR] = 0;
			g_pDealershipVehicle[playerid][E_VEH_BROWSING_MODEL] = 0;
			g_pDealershipVehicle[playerid][E_VEH_BROWSING_CAMERA] = 0;
			g_pDealershipVehicle[playerid][E_VEH_BROWSING_CATEGORY] = 0;
			g_pDealershipVehicle[playerid][E_VEH_BROWSING_ANGLE] = 314.5899;
			SetVehicleVirtualWorld(g_pDealershipVehicle[playerid][E_VEH_BROWSING_ID], GetPlayerVirtualWorld(playerid));

			g_t_PlayerBrowsingDealership[playerid] = repeat OnDealershipBrowsingUpdate(playerid);
			ShowPlayerDealershipHud(playerid);

			new price[12];
			format(price, sizeof(price), "$%i", g_dealership_vehicles[0][1]);
			PlayerTextDrawSetString(playerid, deal_pricename[playerid], price);
		}
		case DIALOG_VEHICLE:
		{
			if(!response)
			{
				PlayCancelSound(playerid);
				return -2;
			}

			new i = listitem;
			if(g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_ID] == g_p_EnabledDealershipVehicleID[playerid])
			{
				PlaySelectSound(playerid);

				new message[64];
				format(message, sizeof(message), "* Você recolheu seu {8CB3B8}%s{87FFC5}.", GetVehicleName(g_p_EnabledDealershipVehicleID[playerid]));
				SendClientMessage(playerid, 0x87FFC5FF, message);
				GetVehicleHealth(g_p_EnabledDealershipVehicleID[playerid], g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_HEALTH]);
				g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_FUEL] = GetVehicleFuel(g_p_EnabledDealershipVehicleID[playerid]);

				DestroyVehicle(g_p_EnabledDealershipVehicleID[playerid]);
				g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_ID] = 0;
				g_p_EnabledDealershipVehicleID[playerid] = INVALID_VEHICLE_ID;
			}
			else if(g_p_EnabledDealershipVehicleID[playerid] != INVALID_VEHICLE_ID)
			{
				SendClientMessage(playerid, COLOR_ERROR, "* Recolha seu outro veículo primeiro.");
				PlayErrorSound(playerid);
			}
			else if(g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MODEL] < 400 || g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MODEL] > 611)
			{
				PlayErrorSound(playerid);
			}
			else
			{
				PlaySelectSound(playerid);

				// Creating vehicle
				new model = g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MODEL];
				new Float:x = g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_X];
				new Float:y = g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_Y];
				new Float:z = g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_Z];
				new Float:a = g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_A];
				new c1 = g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_COLOR1];
				new c2 = g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_COLOR2];
				new Float:h = g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_HEALTH];
				new Float:fuel = g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_FUEL];

				g_p_EnabledDealershipVehicleID[playerid] = CreateVehicle(model, x, y, z, a, c1, c2, -1);
				g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_ID] = g_p_EnabledDealershipVehicleID[playerid];
				g_p_EnabledDealershipVehicleKey[playerid] = i;
				SetVehicleFuel(g_p_EnabledDealershipVehicleID[playerid], fuel);
				SetVehicleHealth(g_p_EnabledDealershipVehicleID[playerid], h);
				ModVehicle(g_p_EnabledDealershipVehicleID[playerid]);

				new message[64];
				format(message, sizeof(message), "* Seu {8CB3B8}%s{87FFC5} está onde você o estacionou.", GetVehicleName(g_p_EnabledDealershipVehicleID[playerid]));
				SendClientMessage(playerid, 0x87FFC5FF, message);
			}
			return -2;
		}
	}
	return 1;
}

//------------------------------------------------------------------------------

/*
	Called every 25s when a player is in dealership
		This is used to make the vechile rotate
*/

timer OnDealershipBrowsingUpdate[25](playerid)
{
	g_pDealershipVehicle[playerid][E_VEH_BROWSING_ANGLE] += 0.25;
	if(g_pDealershipVehicle[playerid][E_VEH_BROWSING_ANGLE] > 359.0)
		g_pDealershipVehicle[playerid][E_VEH_BROWSING_ANGLE] = 0.0;
	SetVehicleZAngle(g_pDealershipVehicle[playerid][E_VEH_BROWSING_ID], g_pDealershipVehicle[playerid][E_VEH_BROWSING_ANGLE]);
}

//------------------------------------------------------------------------------

/*
	Called when a player clicks a player textdraw
		playerid - ID of the player
		playertextid - ID of the clicked textdraw
*/

hook OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	if(_:clickedid == INVALID_TEXT_DRAW && g_pDealershipVehicle[playerid][E_VEH_BROWSING_ID] > 0)
	{
		PlayErrorSound(playerid);

		DestroyVehicle(g_pDealershipVehicle[playerid][E_VEH_BROWSING_ID]);
		SetPlayerPos(playerid, 559.9263, -1289.6732, 17.2482);
		SetPlayerFacingAngle(playerid, 7.5971);
		SetPlayerVirtualWorld(playerid, 0);
		TogglePlayerControllable(playerid, true);

		stop g_t_PlayerBrowsingDealership[playerid];
		g_pDealershipVehicle[playerid][E_VEH_BROWSING_ID]		= 0;
		g_pDealershipVehicle[playerid][E_VEH_BROWSING_COLOR]	= 0;
		g_pDealershipVehicle[playerid][E_VEH_BROWSING_MODEL]	= 0;
		g_pDealershipVehicle[playerid][E_VEH_BROWSING_CAMERA]	= 0;
		g_pDealershipVehicle[playerid][E_VEH_BROWSING_CATEGORY]	= 0;
		g_pDealershipVehicle[playerid][E_VEH_BROWSING_ANGLE]	= 0.0;

		HidePlayerDealershipHud(playerid);
		SetCameraBehindPlayer(playerid);
	}
}

//------------------------------------------------------------------------------

hook OnPlayerDeath(playerid, killerid, reason)
{
	if(g_pDealershipVehicle[playerid][E_VEH_BROWSING_ID] > 0)
	{
		DestroyVehicle(g_pDealershipVehicle[playerid][E_VEH_BROWSING_ID]);

		stop g_t_PlayerBrowsingDealership[playerid];
		g_pDealershipVehicle[playerid][E_VEH_BROWSING_ID]		= 0;
		g_pDealershipVehicle[playerid][E_VEH_BROWSING_COLOR]	= 0;
		g_pDealershipVehicle[playerid][E_VEH_BROWSING_MODEL]	= 0;
		g_pDealershipVehicle[playerid][E_VEH_BROWSING_CAMERA]	= 0;
		g_pDealershipVehicle[playerid][E_VEH_BROWSING_CATEGORY]	= 0;
		g_pDealershipVehicle[playerid][E_VEH_BROWSING_ANGLE]	= 0.0;

		HidePlayerDealershipHud(playerid);
	}
}

/*
	Called when a player disconnects from the server
		playerid - ID of the player
		reason - Reason why the player left
*/

hook OnPlayerDisconnect(playerid, reason)
{
    new query[128];
	if(g_pDealershipVehicle[playerid][E_VEH_BROWSING_ID] > 0)
	{
		DestroyVehicle(g_pDealershipVehicle[playerid][E_VEH_BROWSING_ID]);
		stop g_t_PlayerBrowsingDealership[playerid];
		g_pDealershipVehicle[playerid][E_VEH_BROWSING_ID]		= 0;
		g_pDealershipVehicle[playerid][E_VEH_BROWSING_COLOR]	= 0;
		g_pDealershipVehicle[playerid][E_VEH_BROWSING_MODEL]	= 0;
		g_pDealershipVehicle[playerid][E_VEH_BROWSING_CAMERA]	= 0;
		g_pDealershipVehicle[playerid][E_VEH_BROWSING_CATEGORY]	= 0;
		g_pDealershipVehicle[playerid][E_VEH_BROWSING_ANGLE]	= 0.0;
	}

    for(new i = 0; i < MAX_VEHICLES_PER_PLAYER; i++)
    {
        if(g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_DBID] == 0)
            continue;

		mysql_format(mysql, query, sizeof(query), "UPDATE `dealership` SET `Health`=%f, `Fuel`=%f, `Fines`=%d WHERE `ID`=%d",
		g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_HEALTH], g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_FUEL], g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_FINES],
        g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_DBID]);
		mysql_pquery(mysql, query);
    }

	if(g_p_EnabledDealershipVehicleID[playerid] != INVALID_VEHICLE_ID)
		DestroyVehicle(g_p_EnabledDealershipVehicleID[playerid]);

	g_p_EnabledDealershipVehicleID[playerid] = INVALID_VEHICLE_ID;
	g_p_EnabledDealershipVehicleKey[playerid] = 0;
    ResetPlayerVehicleData(playerid);
}

/***
 *     ######   #######  ##     ## ##     ##    ###    ##    ## ########   ######
 *    ##    ## ##     ## ###   ### ###   ###   ## ##   ###   ## ##     ## ##    ##
 *    ##       ##     ## #### #### #### ####  ##   ##  ####  ## ##     ## ##
 *    ##       ##     ## ## ### ## ## ### ## ##     ## ## ## ## ##     ##  ######
 *    ##       ##     ## ##     ## ##     ## ######### ##  #### ##     ##       ##
 *    ##    ## ##     ## ##     ## ##     ## ##     ## ##   ### ##     ## ##    ##
 *     ######   #######  ##     ## ##     ## ##     ## ##    ## ########   ######
 ***/

//------------------------------------------------------------------------------

/*
	Shows player vehicle commands
*/

YCMD:ajudaveiculo(playerid, params[], help)
{
	SendClientMessage(playerid, COLOR_TITLE, "~~~~~~~~~~~~~~~~~~~~ Comandos Veículo ~~~~~~~~~~~~~~~~~~~~");
	SendClientMessage(playerid, COLOR_SUB_TITLE, "* /veiculos - /estacionar - /venderveiculo - /trancarveiculo");
	SendClientMessage(playerid, COLOR_SUB_TITLE, "* /veiculos chama/recolhe seus veículos pessoais.");
	SendClientMessage(playerid, COLOR_SUB_TITLE, "* (Você só pode ter 1 veículo em uso por vez).");
	SendClientMessage(playerid, COLOR_TITLE, "~~~~~~~~~~~~~~~~~~~~ Comandos Veículo ~~~~~~~~~~~~~~~~~~~~");
	return 1;
}

//------------------------------------------------------------------------------

/*
	Shows player owned vehicles and spawns them
*/

YCMD:veiculos(playerid, params[], help)
{
	if(!PlayerHasVehicle(playerid))
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem um veículo.");

	new info[380];
	new vehicle_name[38];
    new location[MAX_ZONE_NAME];
    strcat(info, "Nome\tLocalização\tEm uso\n");
	for(new i = 0; i < MAX_VEHICLES_PER_PLAYER; i++)
	{
        Get2DZoneName(location, g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_X], g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_Y]);

        if(g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_X] == 0.0 && g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_Y] == 0.0 && g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_Z] == 0.0)
            location = "Indisponível\0";

		format(vehicle_name, sizeof(vehicle_name), "%s\t%s\t%s\n", GetVehicleNameFromModel(g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MODEL]), location, (g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_ID] == g_p_EnabledDealershipVehicleID[playerid]) ? "{FF0000}Sim" : "Não");
		strcat(info, vehicle_name);
	}
	ShowPlayerDialog(playerid, DIALOG_VEHICLE, DIALOG_STYLE_TABLIST_HEADERS, "Meus Veículos", info, "Chamar", "Sair");
	return 1;
}

//------------------------------------------------------------------------------

/*
	Parks player's vehicle
*/

YCMD:estacionar(playerid, params[], help)
{
	if(!PlayerHasVehicle(playerid))
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem um veículo.");

	if(g_p_EnabledDealershipVehicleID[playerid] == INVALID_VEHICLE_ID)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem nenhum veículo ativo. (/veiculos)");

	if(GetPlayerVehicleID(playerid) != g_p_EnabledDealershipVehicleID[playerid])
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não está em seu veículo.");

	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você precisa ser o motorista.");

	new Float:x, Float:y, Float:z, Float:a, Float:h;
	GetVehiclePos(g_p_EnabledDealershipVehicleID[playerid], x, y, z);
	GetVehicleZAngle(g_p_EnabledDealershipVehicleID[playerid], a);
	GetVehicleHealth(g_p_EnabledDealershipVehicleID[playerid], h);

	new i = g_p_EnabledDealershipVehicleKey[playerid];
	g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_X]			= x;
	g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_Y]			= y;
	g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_Z]			= z;
	g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_A]			= a;
	g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_WORLD]		= GetPlayerVirtualWorld(playerid);
	g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_INTERIOR]	= GetPlayerInterior(playerid);
	g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_HEALTH]		= h;

	DestroyVehicle(g_p_EnabledDealershipVehicleID[playerid]);
	g_p_EnabledDealershipVehicleID[playerid] = CreateVehicle(g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MODEL], x, y, z, a, g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_COLOR1], g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_COLOR2], -1);
	if(GetPlayerVirtualWorld(playerid) != 0) SetVehicleVirtualWorld(g_p_EnabledDealershipVehicleID[playerid], GetPlayerVirtualWorld(playerid));
	if(GetPlayerInterior(playerid) != 0) LinkVehicleToInterior(g_p_EnabledDealershipVehicleID[playerid], GetPlayerInterior(playerid));
	SetVehicleHealth(g_p_EnabledDealershipVehicleID[playerid], h);
	PutPlayerInVehicle(playerid, g_p_EnabledDealershipVehicleID[playerid], 0);

	// Updating database
	new query[138];
	mysql_format(mysql, query, sizeof(query), "UPDATE `dealership` SET `X`=%f, `Y`=%f, `Z`=%f, `A`=%f,`World`=%d, `Interior`=%d, `Health`=%f WHERE `ID`=%d", x, y, z, a, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), h, g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_DBID]);
	mysql_pquery(mysql, query);
	return 1;
}

//------------------------------------------------------------------------------

/*
	Locks player's vehicle
*/

YCMD:trancarveiculo(playerid, params[], help)
{
	if(!PlayerHasVehicle(playerid))
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem um veículo.");

	if(g_p_EnabledDealershipVehicleID[playerid] == INVALID_VEHICLE_ID)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem nenhum veículo ativo. (/veiculos)");

	new Float:x, Float:y, Float:z;
	GetVehiclePos(g_p_EnabledDealershipVehicleID[playerid], x, y, z);
	if(!IsPlayerInRangeOfPoint(playerid, 5.0, x, y, z))
		return SendClientMessage(playerid, COLOR_ERROR, "* Você precisa estar próximo de seu veículo.");


	new engine, lights, alarm, doors, bonnet, boot, objective;
	GetVehicleParamsEx(g_p_EnabledDealershipVehicleID[playerid], engine, lights, alarm, doors, bonnet, boot, objective);

	if(doors == VEHICLE_PARAMS_OFF || doors == VEHICLE_PARAMS_UNSET)
		SendClientActionMessage(playerid, 15.0, "trancou as portas de seu veículo.");
	else
		SendClientActionMessage(playerid, 15.0, "destrancou as portas de seu veículo.");

	SetVehicleParamsEx(g_p_EnabledDealershipVehicleID[playerid], engine, lights, alarm, (doors == VEHICLE_PARAMS_OFF || doors == VEHICLE_PARAMS_UNSET) ? VEHICLE_PARAMS_ON : VEHICLE_PARAMS_OFF, bonnet, boot, objective);
	return 1;
}

//------------------------------------------------------------------------------

/*
	Sell player's vehicle
*/

YCMD:venderveiculo(playerid, params[], help)
{
	if(!PlayerHasVehicle(playerid))
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem um veículo.");

	if(g_p_EnabledDealershipVehicleID[playerid] == INVALID_VEHICLE_ID)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem nenhum veículo ativo. (/veiculos)");

	if(!IsPlayerInVehicle(playerid, g_p_EnabledDealershipVehicleID[playerid]))
		return SendClientMessage(playerid, COLOR_ERROR, "* Você precisa estar em seu veículo.");

	if(!IsPlayerInRangeOfPoint(playerid, 10.0, 569.9089, -1299.6195, 17.2484))
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não está no pickup de venda da concessionária.");

	new vehPrice;
	for(new i = 0; i < sizeof(g_dealership_vehicles); i++)
		if(GetVehicleModel(g_p_EnabledDealershipVehicleID[playerid]) == g_dealership_vehicles[i][0])
			vehPrice = g_dealership_vehicles[i][1];

	new i = g_p_EnabledDealershipVehicleKey[playerid];

	// Updating database
	new query[62];
	mysql_format(mysql, query, sizeof(query), "DELETE FROM `dealership` WHERE `ID`=%d LIMIT 1", g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_DBID]);
	mysql_pquery(mysql, query);

	vehPrice /= 3;

	new message[78];
	format(message, sizeof(message), "* Você vendeu seu {8CB3B8}%s{87FFC5} por {8CB3B8}$%s{87FFC5}.", GetVehicleName(g_p_EnabledDealershipVehicleID[playerid]), formatnumber(vehPrice));
	SendClientMessage(playerid, 0x87FFC5FF, message);

	if(g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_FINES] > 0) {
		format(message, sizeof(message), "* Seu veículo possuia multas e foi descontado do valor {8CB3B8}-$%s{87FFC5}.", formatnumber(g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_FINES]));
		SendClientMessage(playerid, 0x87FFC5FF, message);
	}

	DestroyVehicle(g_p_EnabledDealershipVehicleID[playerid]);

	g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_MODEL] = 0;
	g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_ID] = 0;
	g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_DBID] = 0;

	g_p_EnabledDealershipVehicleID[playerid] = INVALID_VEHICLE_ID;
	g_p_EnabledDealershipVehicleKey[playerid] = 0;

	SendClientActionMessage(playerid, 15.0, "entrega as chaves do veiculo e recebe uma quantia em troca.");
	GivePlayerCash(playerid, vehPrice - g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_FINES]);
	g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_FINES] = 0;
	return 1;
}
