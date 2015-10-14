/*******************************************************************************
* FILENAME :        modules/properties/business.pwn
*
* DESCRIPTION :
*       A script to make business available to players buy & sell.
*
* NOTES :
*       This file should only contain business data & funcs.
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

//------------------------------------------------------------------------------

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

#define ITEM_GPS_PRICE					450
#define ITEM_WALKIE_TALKIE_PRICE		300
#define ITEM_CIGARETTS_PRICE			25
#define ITEM_LIGHTER_PRICE				5
#define ITEM_SPRAY_PRICE				50
#define ITEM_AGENDA_PRICE				75

#define ITEM_HAMBURGER_ONE_PRICE		10
#define ITEM_HAMBURGER_TWO_PRICE		15
#define ITEM_HAMBURGER_THREE_PRICE		25
#define ITEM_HAMBURGER_FOUR_PRICE		50

#define ITEM_CLUCKIN_PRICE_1			10
#define ITEM_CLUCKIN_PRICE_2			15
#define ITEM_CLUCKIN_PRICE_3			25
#define ITEM_CLUCKIN_PRICE_4			50

#define ITEM_PIZZA_PRICE_1				10
#define ITEM_PIZZA_PRICE_2				15
#define ITEM_PIZZA_PRICE_3				25
#define ITEM_PIZZA_PRICE_4				50

#define ITEM_DONUT_PRICE_1				10
#define ITEM_DONUT_PRICE_2				15
#define ITEM_DONUT_PRICE_3				25
#define ITEM_DONUT_PRICE_4				50

#define ITEM_RESTAURANT_PRICE_1			10
#define ITEM_RESTAURANT_PRICE_2			15
#define ITEM_RESTAURANT_PRICE_3			25
#define ITEM_RESTAURANT_PRICE_4			50

#define WEAPON_COLT45_PRICE				4000
#define WEAPON_SILENCED_PRICE			4100
#define WEAPON_DEAGLE_PRICE				8000
#define WEAPON_SHOTGUN_PRICE			6500
#define WEAPON_SAWEDOFF_PRICE			23000
#define WEAPON_SPAS12_PRICE				29000
#define WEAPON_UZI_PRICE				26000
#define WEAPON_MP5_PRICE				17000
#define WEAPON_AK47_PRICE				33000
#define WEAPON_M4_PRICE					46000
#define WEAPON_TEC9_PRICE				24000
#define WEAPON_RIFLE_PRICE				21000
#define WEAPON_SNIPER_PRICE				55000
#define WEAPON_RPG_PRICE				100000
#define WEAPON_HSR_PRICE				125000
#define WEAPON_GRENADE_PRICE			10000

#define AMMO_COLT45_PRICE				400
#define AMMO_SILENCED_PRICE				410
#define AMMO_DEAGLE_PRICE				800
#define AMMO_SHOTGUN_PRICE				650
#define AMMO_SAWEDOFF_PRICE				2300
#define AMMO_SPAS12_PRICE				2900
#define AMMO_UZI_PRICE					2600
#define AMMO_MP5_PRICE					1700
#define AMMO_AK47_PRICE					3300
#define AMMO_M4_PRICE					4600
#define AMMO_TEC9_PRICE					2400
#define AMMO_RIFLE_PRICE				2100
#define AMMO_SNIPER_PRICE				5500
#define AMMO_RPG_PRICE					100000
#define AMMO_HSR_PRICE					125000
#define AMMO_GRENADE_PRICE				10000

#define ADVERTISE_PRICE_PER_LETTER		20

#define PHONE_PRICE						325

#define CHAMPAGNE_PRICE					35
#define VODKA_PRICE						40
#define WHISKY_PRICE					50
#define WATER_PRICE						5

#define CLOTHES_PRICE					100

//------------------------------------------------------------------------------

enum E_BUSINESS_DATA
{
	E_BUSINESS_DATABASEID,
	E_BUSINESS_NAME[MAX_BUSINESS_NAME],
	E_BUSINESS_OWNER[MAX_PLAYER_NAME],
	E_BUSINESS_LOCATION[MAX_ZONE_NAME],
	Float:E_BUSINESS_ENTERX,
	Float:E_BUSINESS_ENTERY,
	Float:E_BUSINESS_ENTERZ,
	Float:E_BUSINESS_ENTERA,
	E_BUSINESS_ENTERWORLD,
	E_BUSINESS_ENTERINT,
	Float:E_BUSINESS_EXITX,
	Float:E_BUSINESS_EXITY,
	Float:E_BUSINESS_EXITZ,
	Float:E_BUSINESS_EXITA,
	E_BUSINESS_EXITINT,
	E_BUSINESS_OWNED,
	E_BUSINESS_LOCKED,
	E_BUSINESS_PRICE,
	E_BUSINESS_TILL,
	E_BUSINESS_PRODUCTS,
	E_BUSINESS_TYPE,
	E_BUSINESS_PRODPRICE,
	E_BUSINESS_PICKUP,
	E_BUSINESS_PICKUP_EXIT,
	E_BUSINESS_MAPICON,
	Text3D:E_BUSINESS_TEXT3D
}

new gBusinessData[MAX_BUSINESS][E_BUSINESS_DATA];

//------------------------------------------------------------------------------

new PlayerText:gpt_Business[MAX_PLAYERS][31];
new PlayerText:gpt_House[MAX_PLAYERS][33];
new bool:gptIsVisible[MAX_PLAYERS];
new gptType[MAX_PLAYERS];
new gptPropID[MAX_PLAYERS];

new Float:gBusinessStoreCheckpoint[][] =
{
	// X        Y         Z          Int
	{-23.4622, -55.24870, 1003.5469, 6.0},
	{-22.1731, -138.3791, 1003.5469, 16.0},
	{-30.8421, -29.01190, 1003.5573, 4.0},
	{-28.1270, -89.95290, 1003.5469, 18.0},
	{2.095700, -29.01390, 1003.5494, 10.0},
	{-29.0314, -185.1313, 1003.5469, 17.0}
};

new Float:gBusinessClothesCheckpoint[][] =
{
	{207.6268, -100.6822, 1005.2578},// Binco
	{161.3749, -83.64490, 1001.8047},// ZIP
	{207.1463, -129.1789, 1003.5078},// Pro laps
	{206.3739, -8.030600, 1001.2109},// Victim
	{203.8309, -43.26150, 1001.8047}// Suburban
};

new Float:gBusinessBurgerCheckpoint[][] =
{
	{376.5044, -67.9463, 1001.5151}// Interior 10
};

new Float:gBusinessCluckinCheckpoint[][] =
{
	{370.9007, -6.1658, 1001.8589}
};

new Float:gBusinessPizzaCheckpoint[][] =
{
	{372.7676, -118.8123, 1001.4922}
};

new Float:gBusinessRestaurantCheckpoint[][] =
{
	{380.7119, -190.5340, 1000.6328},// DONUTs
	{449.4885, -83.65130, 999.55470}
};

new Float:gBusinessAdvertisesCheckpoint[][] =
{
	{222.7822, 107.8458, 1003.2188}
};

new Float:gBusinessPhoneCheckpoint[][] =
{
	{2164.6523, 1603.6162, 999.9770}
};

new Float:gBusinessClubCheckpoint[][] =
{
	{498.5389, -76.0395, 998.7578},// int 11
	{499.9697, -20.7007, 1000.6797},// int 17
	{681.4541, -453.8314, -25.6143}// int 1
};

new Float:gBusinessAmmuCheckpoint[][] =
{
	{308.1329, -141.4641, 999.6016}// int 7
};

new Float:gLotteryTicketPositions[][] =
{
	// X        Y       Z         Int
	{822.0086, 3.0426, 1004.1797, 3.0}
};

//------------------------------------------------------------------------------

new Float:gCommonBuildings[][] =
{
	// ALWAYS ADD NEW COORDINATES BELOW THE LAST!

	//In X,      In Y,      In Z,      In A,     Int,  Out X,      Out Y,      Out Z,  Out A,    Out Int
	{238.660800, 138.69100, 1003.0234, 359.1185, 3.00, 1555.08010, -1675.6510, 16.195, 95.63660, 0.00}, // LS Police dept.
	{389.684200, 173.67520, 1008.3828, 96.25030, 3.00, 1480.90160, -1771.2849, 18.795, 3.996110, 0.00}, // Planning dept.
	{772.140900, -4.391600, 1000.7287, 9.505600, 5.00, 2229.56810, -1721.5157, 13.563, 132.2660, 0.00}, // LS GYM
	{834.202600, 7.5220000, 1004.1870, 89.34000, 3.00, 1631.75340, -1172.0283, 24.078, 6.501700, 0.00}, // Inside Track
	{2215.22500, -1150.410, 1025.7969, 276.9435, 15.0, 2232.26680, -1159.8192, 25.890, 87.84510, 0.00}, // Jefferson Motel
	{1726.91500, -1639.190, 20.223000, 179.4721, 18.0, 1699.16750, -1668.0200, 20.194, 92.38800, 0.00}, // Atrium
	{-1603.3918, -695.3279, 14.144000, 0.145400, 0.00, -1603.4547, -696.97140, 1.9609, 178.9603, 0.00}, //SF Airport Ladder 1
	{-1361.1226, -695.3334, 14.148400, 3.457300, 0.00, -1361.0885, -697.02610, 1.9609, 180.6585, 0.00}, //SF Airport Ladder 2
	{-1155.1536, -476.1968, 14.148400, 55.29170, 0.00, -1154.1930, -476.65370, 1.9609, 238.3777, 0.00}, //SF Airport Ladder 3
	{-1083.2622, -208.5233, 14.144000, 118.9880, 0.00, -1081.6278, -207.84950, 1.9609, 300.0071, 0.00}, //SF Airport Ladder 4
	{-1183.5166, 59.589400, 14.148400, 135.0420, 0.00, -1182.5883, 60.3805000, 1.9609, 315.5698, 0.00}, //SF Airport Ladder 5
	{-1116.4567, 336.01430, 14.144200, 41.40620, 0.00, -1115.6724, 334.998600, 1.9609, 217.3125, 0.00}, //SF Airport Ladder 6
	{-1163.7491, 369.15510, 14.148400, 224.2598, 0.00, -1164.8135, 370.211700, 1.9609, 42.06860, 0.00}, //SF Airport Ladder 7
	{-1443.7192, 89.423000, 14.146600, 221.5611, 0.00, -1444.4375, 90.2533000, 1.9609, 41.86030, 0.00}, //SF Airport Ladder 8
	{-1617.8524, -84.89770, 14.148400, 223.4328, 0.00, -1618.7864, -84.056400, 1.9609, 42.35500, 0.00}, //SF Airport Ladder 9
	{-1734.9683, -445.9900, 14.148400, 272.8156, 0.00, -1736.8706, -445.91190, 1.9609, 87.08040, 0.00}, //SF Airport Ladder 10
	{1548.67540, -1364.199, 326.21830, 182.6092, 0.00, 1571.28750, -1336.7615, 16.484, 317.2341, 0.00}, // Predio gigante LS
	{1591.4139, -1034.9336, 23.920400, 273.4908, 1.00, 914.465500, -1004.2324, 37.987, 1.379100, 0.00}, // Bank
	{-100.39600, -25.03140, 1000.7188, 3.379800, 3.00, 953.813400, -1336.5585, 13.539, 1.774000, 0.00}, // Sex Shop pawn store
	{1204.66890, -13.54290, 1000.9219, 350.0204, 2.00, 2421.5386, -1219.5186, 25.5438, 185.9988, 0.00}, // Pig pen strip club
	{-204.44740, -27.17010, 1002.2734, 3.630500, 16.0, 2068.8950, -1779.8422, 13.5595, 273.7442, 0.00}, // Los Santos Tatto
	{418.749800, -84.03160, 1001.8047, 359.5200, 3.00, 2071.0020, -1793.8541, 13.5533, 270.4384, 0.00}, // Barber shop
	{-100.39600, -25.03140, 1000.7188, 3.379800, 3.00, 1940.1899, -2115.9810, 13.6953, 267.1093, 0.00}, // Sex shop aeroporto
	{-959.66800, 1956.2629, 9.0000000, 181.1449, 17.0, 2657.6985, -1588.8370, 13.9827, 186.0799, 0.00}, // Fabrica/Sherman Dam
	{-100.39600, -25.03140, 1000.7188, 3.379800, 3.00, 2353.0950, -1463.4922, 24.0000, 96.96150, 0.00}, // Sex shop Los Santos Vagos
	{-2026.8906, -104.1288, 1035.1719, 182.7639, 3.00, 1310.1067, -1367.2267, 13.5247, 184.6864, 0.00}, // Auto escola
	{366.698100, 197.22830, 1008.3828, 1.700100, 3.00, 1658.0964, -1343.3333, 17.4368, 86.28410, 0.00}, // CNN News
	{-2240.6172, 137.11900, 1035.4141, 273.6426, 6.00, 850.91890, -1587.4500, 13.5469, 228.3575, 0.00}, // Toys shop
	{412.006800, -54.44120, 1001.8984, 6.969900, 12.0, 823.96080, -1588.2449, 13.5434, 137.2084, 0.00} // Barber near burger shot
};

//------------------------------------------------------------------------------

new gAmmunationWeaponData[][] =
{
	{WEAPON_COLT45,				WEAPON_COLT45_PRICE,	500},
	{WEAPON_SILENCED,			WEAPON_SILENCED_PRICE,	500},
	{WEAPON_DEAGLE,				WEAPON_DEAGLE_PRICE,	500},
	{WEAPON_SHOTGUN,			WEAPON_SHOTGUN_PRICE,	500},
	{WEAPON_SAWEDOFF,			WEAPON_SAWEDOFF_PRICE,	500},
	{WEAPON_SHOTGSPA,			WEAPON_SPAS12_PRICE,	500},
	{WEAPON_UZI,				WEAPON_UZI_PRICE,		500},
	{WEAPON_MP5,				WEAPON_MP5_PRICE,		500},
	{WEAPON_AK47,				WEAPON_AK47_PRICE,		500},
	{WEAPON_M4,					WEAPON_M4_PRICE,		500},
	{WEAPON_TEC9,				WEAPON_TEC9_PRICE,		500},
	{WEAPON_RIFLE,				WEAPON_RIFLE_PRICE,		500},
	{WEAPON_SNIPER,				WEAPON_SNIPER_PRICE,	500},
	{WEAPON_ROCKETLAUNCHER,		WEAPON_RPG_PRICE,		500},
	{WEAPON_HEATSEEKER,			WEAPON_HSR_PRICE,		500},
	{WEAPON_GRENADE,			WEAPON_GRENADE_PRICE,	500}
};

new gAmmunationWeaponAmmo[][] =
{
	{WEAPON_COLT45,				WEAPON_COLT45_PRICE,	50},
	{WEAPON_SILENCED,			WEAPON_SILENCED_PRICE,	50},
	{WEAPON_DEAGLE,				WEAPON_DEAGLE_PRICE,	50},
	{WEAPON_SHOTGUN,			WEAPON_SHOTGUN_PRICE,	25},
	{WEAPON_SAWEDOFF,			WEAPON_SAWEDOFF_PRICE,	10},
	{WEAPON_SHOTGSPA,			WEAPON_SPAS12_PRICE,	10},
	{WEAPON_UZI,				WEAPON_UZI_PRICE,		100},
	{WEAPON_MP5,				WEAPON_MP5_PRICE,		100},
	{WEAPON_AK47,				WEAPON_AK47_PRICE,		125},
	{WEAPON_M4,					WEAPON_M4_PRICE,		125},
	{WEAPON_TEC9,				WEAPON_TEC9_PRICE,		100},
	{WEAPON_RIFLE,				WEAPON_RIFLE_PRICE,		10},
	{WEAPON_SNIPER,				WEAPON_SNIPER_PRICE,	10},
	{WEAPON_ROCKETLAUNCHER,		WEAPON_RPG_PRICE,		1},
	{WEAPON_HEATSEEKER,			WEAPON_HSR_PRICE,		1},
	{WEAPON_GRENADE,			WEAPON_GRENADE_PRICE,	1}
};

//------------------------------------------------------------------------------

forward LoadDynamicBusiness();
forward OnPlayerEnterBusiness(playerid, businessid);
forward OnPlayerExitBusiness(playerid, businessid);

//------------------------------------------------------------------------------

IsPlayerInBusiness(playerid, bizid, Float:range = 10.0) {
	return ((IsPlayerInRangeOfPoint(playerid, range, gBusinessData[bizid][E_BUSINESS_EXITX], gBusinessData[bizid][E_BUSINESS_EXITY], gBusinessData[bizid][E_BUSINESS_EXITZ]) && GetPlayerVirtualWorld(playerid) == bizid) ? true : false);
}

IsPlayerInRangeOfBusiness(playerid, bizid, Float:range = 3.0) {
	return (IsPlayerInRangeOfPoint(playerid, range, gBusinessData[bizid][E_BUSINESS_ENTERX], gBusinessData[bizid][E_BUSINESS_ENTERY], gBusinessData[bizid][E_BUSINESS_ENTERZ]) ? true : false);
}

//------------------------------------------------------------------------------

GetPlayerClosestBusinessID(playerid, Float:range = 3.0)
{
	new businessid = INVALID_BUSINESS_ID;
	foreach(new b: Business)
	{
		if(IsPlayerInRangeOfPoint(playerid, range, gBusinessData[b][E_BUSINESS_ENTERX], gBusinessData[b][E_BUSINESS_ENTERY], gBusinessData[b][E_BUSINESS_ENTERZ]))
		{
			businessid = b;
			break;
		}
	}
	return businessid;
}

GetClosestBusinessFromPlayer(playerid, typeid)
{
	new Float:distance = Float:0x7F800000;
	new businessid = 0;
	foreach(new b: Business)
	{
		if(GetPlayerDistanceFromPoint(playerid, gBusinessData[b][E_BUSINESS_ENTERX], gBusinessData[b][E_BUSINESS_ENTERY], gBusinessData[b][E_BUSINESS_ENTERZ]) < distance && GetBusinessType(b) == typeid)
		{
			distance = GetPlayerDistanceFromPoint(playerid, gBusinessData[b][E_BUSINESS_ENTERX], gBusinessData[b][E_BUSINESS_ENTERY], gBusinessData[b][E_BUSINESS_ENTERZ]);
			businessid = b;
		}
	}
	return businessid;
}

//------------------------------------------------------------------------------

SetBusinessTill(bizid, value)
{
	gBusinessData[bizid][E_BUSINESS_TILL] = value;

	new query[58];
	mysql_format(mysql, query, sizeof(query), "UPDATE `business` SET `Till`=%d WHERE `ID`=%d", \
	gBusinessData[bizid][E_BUSINESS_TILL], gBusinessData[bizid][E_BUSINESS_DATABASEID]);
	mysql_tquery(mysql, query);
	return 1;
}

GetBusinessTill(bizid)
	return gBusinessData[bizid][E_BUSINESS_TILL];

//------------------------------------------------------------------------------

GetBusinessName(bizid)
{
	new name[MAX_BUSINESS_NAME];
	format(name, sizeof(name), "%s", gBusinessData[bizid][E_BUSINESS_NAME]);
	return name;
}

//------------------------------------------------------------------------------

GetBusinessProducts(bizid) {
	return gBusinessData[bizid][E_BUSINESS_PRODUCTS];
}

GetBusinessProductsPrice(bizid) {
	return gBusinessData[bizid][E_BUSINESS_PRODPRICE];
}

//------------------------------------------------------------------------------

SetBusinessProducts(bizid, value)
{
	gBusinessData[bizid][E_BUSINESS_PRODUCTS] = value;

	new query[58];
	mysql_format(mysql, query, sizeof(query), "UPDATE `business` SET `Products`=%d WHERE `ID`=%d", gBusinessData[bizid][E_BUSINESS_PRODUCTS], gBusinessData[bizid][E_BUSINESS_DATABASEID]);
	mysql_tquery(mysql, query);
	return 1;
}

//------------------------------------------------------------------------------

GetBusinessType(bizid) {
	return gBusinessData[bizid][E_BUSINESS_TYPE];
}

stock GetBusinessTypeName(bizid)
{
	new
		businesstype[18];
	switch(gBusinessData[bizid][E_BUSINESS_TYPE])
	{
		case 1: businesstype = "24/7";
		case 2: businesstype = "Telefonia";
		case 3: businesstype = "Restaurante";
		case 4: businesstype = "Ammu-nation";
		case 5: businesstype = "Loja de Roupas";
		case 6: businesstype = "Posto de Gasolina";
		case 7: businesstype = "Publicidade";
		case 8: businesstype = "Bar/Boate";
		case 9: businesstype = "Locadora";
		case 10: businesstype = "Fast-food";
		case 11: businesstype = "Fast-food";
		case 12: businesstype = "Fast-food";
		case 13: businesstype = "Acessorios";
		default: businesstype = "Desconhecido";
	}

	return businesstype;
}

//------------------------------------------------------------------------------

GetBusinessLocation(bizid)
{
	new location[MAX_ZONE_NAME];
	strcat(location, gBusinessData[bizid][E_BUSINESS_LOCATION]);
	return location;
}

//------------------------------------------------------------------------------

SetBusinessName(bizid, name[])
{
	format(gBusinessData[bizid][E_BUSINESS_NAME], 24, "%s", name);

	new query[48 + MAX_BUSINESS_NAME];
	mysql_format(mysql, query, sizeof(query), "UPDATE `business` SET `Name`='%s' WHERE `ID`=%d", gBusinessData[bizid][E_BUSINESS_NAME], gBusinessData[bizid][E_BUSINESS_DATABASEID]);
	mysql_tquery(mysql, query);
	return 1;
}

//------------------------------------------------------------------------------

SetBusinessOwnerName(bizid, name[])
{
	format(gBusinessData[bizid][E_BUSINESS_OWNER], MAX_PLAYER_NAME, "%s", name);

	new query[48 + MAX_PLAYER_NAME];
	mysql_format(mysql, query, sizeof(query), "UPDATE `business` SET `Owner`='%s' WHERE `ID`=%d", gBusinessData[bizid][E_BUSINESS_OWNER], gBusinessData[bizid][E_BUSINESS_DATABASEID]);
	mysql_tquery(mysql, query);
	return 1;
}

//------------------------------------------------------------------------------

SetBusinessOwned(bizid, value)
{
	gBusinessData[bizid][E_BUSINESS_OWNED] = value;

	new query[58];
	mysql_format(mysql, query, sizeof(query), "UPDATE `business` SET `Owned`=%d WHERE `ID`=%d", gBusinessData[bizid][E_BUSINESS_OWNED], gBusinessData[bizid][E_BUSINESS_DATABASEID]);
	mysql_tquery(mysql, query);
	return 1;
}

//------------------------------------------------------------------------------

SetBusinessType(bizid, value)
{
	gBusinessData[bizid][E_BUSINESS_TYPE] = value;

	new query[58];
	mysql_format(mysql, query, sizeof(query), "UPDATE `business` SET `Type`=%d WHERE `ID`=%d", gBusinessData[bizid][E_BUSINESS_TYPE], gBusinessData[bizid][E_BUSINESS_DATABASEID]);
	mysql_tquery(mysql, query);
	return 1;
}

//------------------------------------------------------------------------------

SetBusinessProductPrice(bizid, value)
{
	gBusinessData[bizid][E_BUSINESS_PRODPRICE] = value;

	new query[58];
	mysql_format(mysql, query, sizeof(query), "UPDATE `business` SET `ProductPrice`=%d WHERE `ID`=%d", gBusinessData[bizid][E_BUSINESS_PRODPRICE], gBusinessData[bizid][E_BUSINESS_DATABASEID]);
	mysql_tquery(mysql, query);
	return 1;
}

//------------------------------------------------------------------------------

SetBusinessLocked(bizid, value)
{
	if(value != 0) value = 1;
	gBusinessData[bizid][E_BUSINESS_LOCKED] = value;

	new query[58];
	mysql_format(mysql, query, sizeof(query), "UPDATE `business` SET `Locked`=%d WHERE `ID`=%d", gBusinessData[bizid][E_BUSINESS_LOCKED], gBusinessData[bizid][E_BUSINESS_DATABASEID]);
	mysql_tquery(mysql, query);
	return 1;
}

GetBusinessLockState(bizid)
{
	return gBusinessData[bizid][E_BUSINESS_LOCKED];
}

//------------------------------------------------------------------------------

SetBusinessPrice(bizid, value)
{
	gBusinessData[bizid][E_BUSINESS_PRICE] = value;

	new query[58];
	mysql_format(mysql, query, sizeof(query), "UPDATE `business` SET `Price`=%d WHERE `ID`=%d", gBusinessData[bizid][E_BUSINESS_PRICE], gBusinessData[bizid][E_BUSINESS_DATABASEID]);
	mysql_tquery(mysql, query);
	return 1;
}

//------------------------------------------------------------------------------

SaveBusinessEntrancePos(bizid)
{
	Get2DZoneName(gBusinessData[bizid][E_BUSINESS_LOCATION], gBusinessData[bizid][E_BUSINESS_ENTERX], gBusinessData[bizid][E_BUSINESS_ENTERY]);

	new query[184];
	mysql_format(mysql, query, sizeof(query), "UPDATE `business` SET `EnterX`=%.2f, `EnterY`=%.2f, `EnterZ`=%.2f, `EnterA`=%.2f, `EnterWorld`=%d, `EnterInt`=%d, `Location`='%e' WHERE `ID`=%d", \
	gBusinessData[bizid][E_BUSINESS_ENTERX], gBusinessData[bizid][E_BUSINESS_ENTERY], gBusinessData[bizid][E_BUSINESS_ENTERZ], gBusinessData[bizid][E_BUSINESS_ENTERA], gBusinessData[bizid][E_BUSINESS_ENTERWORLD], gBusinessData[bizid][E_BUSINESS_ENTERINT], gBusinessData[bizid][E_BUSINESS_LOCATION], gBusinessData[bizid][E_BUSINESS_DATABASEID]);
	mysql_tquery(mysql, query);
	return 1;
}

GetBusinessEntrancePos(bizid, &Float:X, &Float:Y, &Float:Z)
{
	X = gBusinessData[bizid][E_BUSINESS_ENTERX];
	Y = gBusinessData[bizid][E_BUSINESS_ENTERY];
	Z = gBusinessData[bizid][E_BUSINESS_ENTERZ];
	return 1;
}

SaveBusinessExitPos(bizid)
{

	new query[164];
	mysql_format(mysql, query, sizeof(query), "UPDATE `business` SET `ExitX`=%.2f, `ExitY`=%.2f, `ExitZ`=%.2f, `ExitA`=%.2f, `ExitInt`=%d WHERE `ID`=%d", \
	gBusinessData[bizid][E_BUSINESS_EXITX], gBusinessData[bizid][E_BUSINESS_EXITY], gBusinessData[bizid][E_BUSINESS_EXITZ], gBusinessData[bizid][E_BUSINESS_EXITA], gBusinessData[bizid][E_BUSINESS_EXITINT], gBusinessData[bizid][E_BUSINESS_DATABASEID]);
	mysql_tquery(mysql, query);
	return 1;
}

//------------------------------------------------------------------------------

LoadDynamicBusiness()
{
	new rows, fields;
	cache_get_data(rows, fields, mysql);
	if(rows)
	{
		for(new bizid = 0; bizid < rows; bizid++)
		{
			cache_get_field_content(bizid, "Name", gBusinessData[bizid][E_BUSINESS_NAME], mysql, MAX_BUSINESS_NAME);
			cache_get_field_content(bizid, "Owner", gBusinessData[bizid][E_BUSINESS_OWNER], mysql, MAX_PLAYER_NAME);
			cache_get_field_content(bizid, "Location", gBusinessData[bizid][E_BUSINESS_LOCATION], mysql, MAX_ZONE_NAME);

			gBusinessData[bizid][E_BUSINESS_DATABASEID]	= cache_get_field_content_int(bizid, "ID");

			gBusinessData[bizid][E_BUSINESS_ENTERX]		= cache_get_field_content_float(bizid, "EnterX");
			gBusinessData[bizid][E_BUSINESS_ENTERY]		= cache_get_field_content_float(bizid, "EnterY");
			gBusinessData[bizid][E_BUSINESS_ENTERZ]		= cache_get_field_content_float(bizid, "EnterZ");
			gBusinessData[bizid][E_BUSINESS_ENTERA]		= cache_get_field_content_float(bizid, "EnterA");

			gBusinessData[bizid][E_BUSINESS_EXITX]		= cache_get_field_content_float(bizid, "ExitX");
			gBusinessData[bizid][E_BUSINESS_EXITY]		= cache_get_field_content_float(bizid, "ExitY");
			gBusinessData[bizid][E_BUSINESS_EXITZ]		= cache_get_field_content_float(bizid, "ExitZ");
			gBusinessData[bizid][E_BUSINESS_EXITA]		= cache_get_field_content_float(bizid, "ExitA");

			gBusinessData[bizid][E_BUSINESS_ENTERWORLD]	= cache_get_field_content_int(bizid, "EnterWorld");
			gBusinessData[bizid][E_BUSINESS_ENTERINT]	= cache_get_field_content_int(bizid, "EnterInt");
			gBusinessData[bizid][E_BUSINESS_EXITINT]	= cache_get_field_content_int(bizid, "ExitInt");
			gBusinessData[bizid][E_BUSINESS_OWNED]		= cache_get_field_content_int(bizid, "Owned");
			gBusinessData[bizid][E_BUSINESS_LOCKED]		= cache_get_field_content_int(bizid, "Locked");
			gBusinessData[bizid][E_BUSINESS_PRICE]		= cache_get_field_content_int(bizid, "Price");
			gBusinessData[bizid][E_BUSINESS_TILL]		= cache_get_field_content_int(bizid, "Till");
			gBusinessData[bizid][E_BUSINESS_PRODUCTS]	= cache_get_field_content_int(bizid, "Products");
			gBusinessData[bizid][E_BUSINESS_TYPE]		= cache_get_field_content_int(bizid, "Type");
			gBusinessData[bizid][E_BUSINESS_PRODPRICE]	= cache_get_field_content_int(bizid, "ProductPrice");

			if(gBusinessData[bizid][E_BUSINESS_ENTERX] != 0.0 && gBusinessData[bizid][E_BUSINESS_ENTERY] != 0.0)
			{
				UpdateBusinessPickup(bizid);
				UpdateBusinessText3D(bizid);
				Iter_Add(Business, bizid);
			}

			if((gBusinessData[bizid][E_BUSINESS_EXITX] == 0 && gBusinessData[bizid][E_BUSINESS_EXITY] == 0) || gBusinessData[bizid][E_BUSINESS_TYPE] == BUSINESS_TYPE_FUEL)
				gBusinessData[bizid][E_BUSINESS_LOCKED] = true;
		}
	}
	else
	{
		new query[360];
		mysql_format(mysql, query, sizeof(query), "INSERT INTO `business` (`ID`, `Name`, `Owner`, `EnterX`, `EnterY`, `EnterZ` ,`EnterA`, `ExitX`, `ExitY`, `ExitZ`, `ExitA`, `EnterWorld`, `EnterInt`, `ExitInt`, `Owned`, `Locked`, `Price`, `Till`, `Products`, `Type`, `ProductPrice`, `Location`) VALUES (%d, 'Nenhum', 'Ninguem', 0, 0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'San Andreas')", cache_insert_id());
		mysql_tquery(mysql, query);
		return 0;
	}
	return 1;
}

//------------------------------------------------------------------------------

UpdateBusinessText3D(bizid)
{
	if(!IsValidDynamic3DTextLabel(gBusinessData[bizid][E_BUSINESS_TEXT3D])) return 1;

	new sBusiness3DText[148];

	if(gBusinessData[bizid][E_BUSINESS_OWNED])
	{
		switch(gBusinessData[bizid][E_BUSINESS_LOCKED]) {
			case 0: format(sBusiness3DText, sizeof(sBusiness3DText), "{68616A}[%s]\n{868087}%s\n{01d4ab}Aberto", gBusinessData[bizid][E_BUSINESS_NAME]);
			case 1: format(sBusiness3DText, sizeof(sBusiness3DText), "{68616A}[%s]\n{868087}%s\n{fa8072}Fechado", gBusinessData[bizid][E_BUSINESS_NAME]);
		}

		UpdateDynamic3DTextLabelText(gBusinessData[bizid][E_BUSINESS_TEXT3D], 0xffffffff, sBusiness3DText);
	}
	else
	{
		case 1: format(sBusiness3DText, sizeof(sBusiness3DText), "{68616A}[%s]\n{868087}%s\n{afeeee}À venda!", gBusinessData[bizid][E_BUSINESS_NAME]);
		UpdateDynamic3DTextLabelText(gBusinessData[bizid][E_BUSINESS_TEXT3D], 0xffffffff, sBusiness3DText);
	}
	return 1;
}

UpdateBusinessPickup(bizid)
{
	if(IsValidDynamicPickup(gBusinessData[bizid][E_BUSINESS_PICKUP])) DestroyDynamicPickup(gBusinessData[bizid][E_BUSINESS_PICKUP]);
	if(IsValidDynamicPickup(gBusinessData[bizid][E_BUSINESS_PICKUP_EXIT])) DestroyDynamicPickup(gBusinessData[bizid][E_BUSINESS_PICKUP_EXIT]);
	if(IsValidDynamic3DTextLabel(gBusinessData[bizid][E_BUSINESS_TEXT3D])) DestroyDynamic3DTextLabel(gBusinessData[bizid][E_BUSINESS_TEXT3D]);
	if(IsValidDynamicMapIcon(gBusinessData[bizid][E_BUSINESS_MAPICON])) DestroyDynamicMapIcon(gBusinessData[bizid][E_BUSINESS_MAPICON]);

	switch(gBusinessData[bizid][E_BUSINESS_TYPE])
	{
		case 1: gBusinessData[bizid][E_BUSINESS_MAPICON] = CreateDynamicMapIcon(gBusinessData[bizid][E_BUSINESS_ENTERX], gBusinessData[bizid][E_BUSINESS_ENTERY], gBusinessData[bizid][E_BUSINESS_ENTERZ], 17, 0x0000FFFF, -1, -1, -1, MAX_MAPICON_RANGE);
		case 2: gBusinessData[bizid][E_BUSINESS_MAPICON] = CreateDynamicMapIcon(gBusinessData[bizid][E_BUSINESS_ENTERX], gBusinessData[bizid][E_BUSINESS_ENTERY], gBusinessData[bizid][E_BUSINESS_ENTERZ], 42, 0x0000FFFF, -1, -1, -1, MAX_MAPICON_RANGE);
		case 3: gBusinessData[bizid][E_BUSINESS_MAPICON] = CreateDynamicMapIcon(gBusinessData[bizid][E_BUSINESS_ENTERX], gBusinessData[bizid][E_BUSINESS_ENTERY], gBusinessData[bizid][E_BUSINESS_ENTERZ], 50, 0x0000FFFF, -1, -1, -1, MAX_MAPICON_RANGE);
		case 4: gBusinessData[bizid][E_BUSINESS_MAPICON] = CreateDynamicMapIcon(gBusinessData[bizid][E_BUSINESS_ENTERX], gBusinessData[bizid][E_BUSINESS_ENTERY], gBusinessData[bizid][E_BUSINESS_ENTERZ], 06, 0x0000FFFF, -1, -1, -1, MAX_MAPICON_RANGE);
		case 5: gBusinessData[bizid][E_BUSINESS_MAPICON] = CreateDynamicMapIcon(gBusinessData[bizid][E_BUSINESS_ENTERX], gBusinessData[bizid][E_BUSINESS_ENTERY], gBusinessData[bizid][E_BUSINESS_ENTERZ], 45, 0x0000FFFF, -1, -1, -1, MAX_MAPICON_RANGE);
		case 6: gBusinessData[bizid][E_BUSINESS_MAPICON] = CreateDynamicMapIcon(gBusinessData[bizid][E_BUSINESS_ENTERX], gBusinessData[bizid][E_BUSINESS_ENTERY], gBusinessData[bizid][E_BUSINESS_ENTERZ], 55, 0x0000FFFF, -1, -1, -1, MAX_MAPICON_RANGE);
		case 7: gBusinessData[bizid][E_BUSINESS_MAPICON] = CreateDynamicMapIcon(gBusinessData[bizid][E_BUSINESS_ENTERX], gBusinessData[bizid][E_BUSINESS_ENTERY], gBusinessData[bizid][E_BUSINESS_ENTERZ], 40, 0x0000FFFF, -1, -1, -1, MAX_MAPICON_RANGE);
		case 8: gBusinessData[bizid][E_BUSINESS_MAPICON] = CreateDynamicMapIcon(gBusinessData[bizid][E_BUSINESS_ENTERX], gBusinessData[bizid][E_BUSINESS_ENTERY], gBusinessData[bizid][E_BUSINESS_ENTERZ], 49, 0x0000FFFF, -1, -1, -1, MAX_MAPICON_RANGE);
		case 9: gBusinessData[bizid][E_BUSINESS_MAPICON] = CreateDynamicMapIcon(gBusinessData[bizid][E_BUSINESS_ENTERX], gBusinessData[bizid][E_BUSINESS_ENTERY], gBusinessData[bizid][E_BUSINESS_ENTERZ], 55, 0x0000FFFF, -1, -1, -1, MAX_MAPICON_RANGE);
		case 10: gBusinessData[bizid][E_BUSINESS_MAPICON] = CreateDynamicMapIcon(gBusinessData[bizid][E_BUSINESS_ENTERX], gBusinessData[bizid][E_BUSINESS_ENTERY], gBusinessData[bizid][E_BUSINESS_ENTERZ], 10, 0x0000FFFF, -1, -1, -1, MAX_MAPICON_RANGE);
		case 11: gBusinessData[bizid][E_BUSINESS_MAPICON] = CreateDynamicMapIcon(gBusinessData[bizid][E_BUSINESS_ENTERX], gBusinessData[bizid][E_BUSINESS_ENTERY], gBusinessData[bizid][E_BUSINESS_ENTERZ], 14, 0x0000FFFF, -1, -1, -1, MAX_MAPICON_RANGE);
		case 12: gBusinessData[bizid][E_BUSINESS_MAPICON] = CreateDynamicMapIcon(gBusinessData[bizid][E_BUSINESS_ENTERX], gBusinessData[bizid][E_BUSINESS_ENTERY], gBusinessData[bizid][E_BUSINESS_ENTERZ], 29, 0x0000FFFF, -1, -1, -1, MAX_MAPICON_RANGE);
		case BUSINESS_TYPE_ATTACHMENTS: gBusinessData[bizid][E_BUSINESS_MAPICON] = CreateDynamicMapIcon(gBusinessData[bizid][E_BUSINESS_ENTERX], gBusinessData[bizid][E_BUSINESS_ENTERY], gBusinessData[bizid][E_BUSINESS_ENTERZ], 39, 0x0000FFFF, -1, -1, -1, MAX_MAPICON_RANGE);
		default: gBusinessData[bizid][E_BUSINESS_MAPICON] = CreateDynamicMapIcon(gBusinessData[bizid][E_BUSINESS_ENTERX], gBusinessData[bizid][E_BUSINESS_ENTERY], gBusinessData[bizid][E_BUSINESS_ENTERZ], 4, 0x0000FFFF, -1, -1, -1, MAX_MAPICON_RANGE);
	}

	gBusinessData[bizid][E_BUSINESS_PICKUP_EXIT] = CreateDynamicPickup(1318, 1, gBusinessData[bizid][E_BUSINESS_EXITX], gBusinessData[bizid][E_BUSINESS_EXITY], gBusinessData[bizid][E_BUSINESS_EXITZ], bizid);

	new sBusiness3DText[148];

	if(gBusinessData[bizid][E_BUSINESS_OWNED])
	{
		gBusinessData[bizid][E_BUSINESS_PICKUP] = CreateDynamicPickup(19524, 1, gBusinessData[bizid][E_BUSINESS_ENTERX], gBusinessData[bizid][E_BUSINESS_ENTERY], gBusinessData[bizid][E_BUSINESS_ENTERZ], gBusinessData[bizid][E_BUSINESS_ENTERWORLD]);

		switch(gBusinessData[bizid][E_BUSINESS_LOCKED]) {
            case 0: format(sBusiness3DText, sizeof(sBusiness3DText), "{68616A}[%s]\n{868087}%s\n{01d4ab}Aberto", gBusinessData[bizid][E_BUSINESS_NAME]);
			case 1: format(sBusiness3DText, sizeof(sBusiness3DText), "{68616A}[%s]\n{868087}%s\n{fa8072}Fechado", gBusinessData[bizid][E_BUSINESS_NAME]);
		}

		gBusinessData[bizid][E_BUSINESS_TEXT3D] = CreateDynamic3DTextLabel(sBusiness3DText, 0xffffffff, gBusinessData[bizid][E_BUSINESS_ENTERX], gBusinessData[bizid][E_BUSINESS_ENTERY], gBusinessData[bizid][E_BUSINESS_ENTERZ], MAX_TEXT3D_RANGE, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
	} else {
		gBusinessData[bizid][E_BUSINESS_PICKUP] = CreateDynamicPickup(1272, 1, gBusinessData[bizid][E_BUSINESS_ENTERX], gBusinessData[bizid][E_BUSINESS_ENTERY], gBusinessData[bizid][E_BUSINESS_ENTERZ], gBusinessData[bizid][E_BUSINESS_ENTERWORLD]);

		case 1: format(sBusiness3DText, sizeof(sBusiness3DText), "{68616A}[%s]\n{868087}%s\n{afeeee}À venda!", gBusinessData[bizid][E_BUSINESS_NAME]);
		gBusinessData[bizid][E_BUSINESS_TEXT3D] = CreateDynamic3DTextLabel(sBusiness3DText, 0xffffffff, gBusinessData[bizid][E_BUSINESS_ENTERX], gBusinessData[bizid][E_BUSINESS_ENTERY], gBusinessData[bizid][E_BUSINESS_ENTERZ], MAX_TEXT3D_RANGE, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
	}
}
