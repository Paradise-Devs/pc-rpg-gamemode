/* *************************************************************************** *
*  Description: Business module file.
*
*  Assignment: A script to make business available to players buy & sell.
*
*           Copyright Paradise Devs 2015.  All rights reserved.
* *************************************************************************** */

//------------------------------------------------------------------------------
/***
 *    ##     ## ########    ###    ########  ######## ########
 *    ##     ## ##         ## ##   ##     ## ##       ##     ##
 *    ##     ## ##        ##   ##  ##     ## ##       ##     ##
 *    ######### ######   ##     ## ##     ## ######   ########
 *    ##     ## ##       ######### ##     ## ##       ##   ##
 *    ##     ## ##       ##     ## ##     ## ##       ##    ##
 *    ##     ## ######## ##     ## ########  ######## ##     ##
 ***/
//------------------------------------------------------------------------------

#if defined _MODULE_business
	#endinput
#endif
#define _MODULE_business

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

// Business type
enum
{
	BUSINESS_TYPE_NONE,
	BUSINESS_TYPE_STORE,
	BUSINESS_TYPE_PHONE,
	BUSINESS_TYPE_RESTAURANT,
	BUSINESS_TYPE_AMMUNATION,
	BUSINESS_TYPE_CLOTHES,
	BUSINESS_TYPE_FUEL,
	BUSINESS_TYPE_ADVERTISE,
	BUSINESS_TYPE_CLUB,
	BUSINESS_TYPE_RENTCAR,
	BUSINESS_TYPE_BURGER,
	BUSINESS_TYPE_CLUCKIN,
	BUSINESS_TYPE_PIZZA,
	BUSINESS_TYPE_ATTACHMENTS
}

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

static gPlayerKey[MAX_PLAYERS];

//------------------------------------------------------------------------------

new PlayerText:gpt_Business[MAX_PLAYERS][31];

new STREAMER_TAG_CP gBusinessStoreCheckpointID[6];
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

new STREAMER_TAG_CP gBusinessClothesCheckpointID[5];
new Float:gBusinessClothesCheckpoint[][] =
{
	{207.6268, -100.6822, 1005.2578},// Binco
	{161.3749, -83.64490, 1001.8047},// ZIP
	{207.1463, -129.1789, 1003.5078},// Pro laps
	{206.3739, -8.030600, 1001.2109},// Victim
	{203.8309, -43.26150, 1001.8047}// Suburban
};

new STREAMER_TAG_CP gBusinessBurgerCheckpointID;
new Float:gBusinessBurgerCheckpoint[][] =
{
	{376.5044, -67.9463, 1001.5151}// Interior 10
};

new STREAMER_TAG_CP gBusinessCluckinCheckpointID;
new Float:gBusinessCluckinCheckpoint[][] =
{
	{370.9007, -6.1658, 1001.8589}
};

new STREAMER_TAG_CP gBusinessPizzaCheckpointID;
new Float:gBusinessPizzaCheckpoint[][] =
{
	{372.7676, -118.8123, 1001.4922}
};

new STREAMER_TAG_CP gBusinessRestaurantCheckpointID[2];
new Float:gBusinessRestaurantCheckpoint[][] =
{
	{380.7119, -190.5340, 1000.6328},// DONUTs
	{449.4885, -83.65130, 999.55470}
};

new STREAMER_TAG_CP gBusinessAdvertisesCheckpointID;
new Float:gBusinessAdvertisesCheckpoint[][] =
{
	{222.7822, 107.8458, 1003.2188}
};

new STREAMER_TAG_CP gBusinessPhoneCheckpointID;
new Float:gBusinessPhoneCheckpoint[][] =
{
	{2164.6523, 1603.6162, 999.9770}
};

new STREAMER_TAG_CP gBusinessClubCheckpointID[3];
new Float:gBusinessClubCheckpoint[][] =
{
	{498.5389, -76.0395, 998.7578},// int 11
	{499.9697, -20.7007, 1000.6797},// int 17
	{681.4541, -453.8314, -25.6143}// int 1
};

new STREAMER_TAG_CP gBusinessAmmuCheckpointID[1];
new Float:gBusinessAmmuCheckpoint[][] =
{
	{308.1329, -141.4641, 999.6016}// int 7
};

//------------------------------------------------------------------------------

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
/***
 *    ######## ##     ## ##    ##  ######  ######## ####  #######  ##    ##  ######
 *    ##       ##     ## ###   ## ##    ##    ##     ##  ##     ## ###   ## ##    ##
 *    ##       ##     ## ####  ## ##          ##     ##  ##     ## ####  ## ##
 *    ######   ##     ## ## ## ## ##          ##     ##  ##     ## ## ## ##  ######
 *    ##       ##     ## ##  #### ##          ##     ##  ##     ## ##  ####       ##
 *    ##       ##     ## ##   ### ##    ##    ##     ##  ##     ## ##   ### ##    ##
 *    ##        #######  ##    ##  ######     ##    ####  #######  ##    ##  ######
 ***/
//------------------------------------------------------------------------------

SetPlayerBusinessID(playerid, key)
{
	gPlayerKey[playerid] = key;
}

GetPlayerBusinessID(playerid)
{
	return gPlayerKey[playerid];
}

/*
	Checks if the player is inside a business
		playerid - ID of the player
		bizid    - ID of the business.
		range    - Distance to search
	returns
		True if yes
		False if not
*/

stock IsPlayerInBusiness(playerid, bizid, Float:range = 10.0)
	return ((IsPlayerInRangeOfPoint(playerid, range, gBusinessData[bizid][E_BUSINESS_EXITX], gBusinessData[bizid][E_BUSINESS_EXITY], gBusinessData[bizid][E_BUSINESS_EXITZ]) && GetPlayerVirtualWorld(playerid) == bizid) ? true : false);

/*
	Checks if the player is near a specific business
		playerid - ID of the player
		bizid    - ID of the business.
		range    - Distance to search
	returns
		True if yes
		False if not
*/

stock IsPlayerInRangeOfBusiness(playerid, bizid, Float:range = 3.0)
	return (IsPlayerInRangeOfPoint(playerid, range, gBusinessData[bizid][E_BUSINESS_ENTERX], gBusinessData[bizid][E_BUSINESS_ENTERY], gBusinessData[bizid][E_BUSINESS_ENTERZ]) ? true : false);

/*
	Gets the closest business from the player
		playerid: ID of the player.
		range: Distance to search
	returns
		The business ID
*/

stock GetPlayerClosestBusinessID(playerid, Float:range = 3.0)
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

/*
	Gets the closest business from the player
		playerid: ID of the player.
		typeid: Type os business
	returns
		The business ID
*/

stock GetClosestBusinessFromPlayer(playerid, typeid)
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

/*
	Sets and saves the bussines till.
		bizid: ID of the business.
		value: Till value.
	returns
		This function doesn't return specific values
*/

stock SetBusinessTill(bizid, value)
{
	gBusinessData[bizid][E_BUSINESS_TILL] = value;

	new query[58];
	mysql_format(mysql, query, sizeof(query), "UPDATE `business` SET `Till`=%d WHERE `ID`=%d", \
	gBusinessData[bizid][E_BUSINESS_TILL], gBusinessData[bizid][E_BUSINESS_DATABASEID]);
	mysql_tquery(mysql, query);
	return 1;
}

/*
	Gets the bussines till.
		bizid: ID of the business.
	returns
		Amount of value in till
*/

stock GetBusinessTill(bizid)
	return gBusinessData[bizid][E_BUSINESS_TILL];

/*
	Gets the bussines name
		bizid: ID of the business.
	returns
		The business name as string
*/

stock GetBusinessName(bizid)
{
	new name[MAX_BUSINESS_NAME];
	format(name, sizeof(name), "%s", gBusinessData[bizid][E_BUSINESS_NAME]);
	return name;
}

/*
	Get the bussines prods.
		bizid: ID of the business.
	returns
		The business prods
*/

stock GetBusinessProducts(bizid)
{
	return gBusinessData[bizid][E_BUSINESS_PRODUCTS];
}

stock GetBusinessProductsPrice(bizid)
{
	return gBusinessData[bizid][E_BUSINESS_PRODPRICE];
}

/*
	Get the bussines prods.
		bizid - ID of the business.
		value - Amount of products
	returns
		This function doesn't return specific values
*/

stock SetBusinessProducts(bizid, value)
{
	gBusinessData[bizid][E_BUSINESS_PRODUCTS] = value;

	new query[58];
	mysql_format(mysql, query, sizeof(query), "UPDATE `business` SET `Products`=%d WHERE `ID`=%d", gBusinessData[bizid][E_BUSINESS_PRODUCTS], gBusinessData[bizid][E_BUSINESS_DATABASEID]);
	mysql_tquery(mysql, query);
	return 1;
}

/*
	Get the bussines type.
		bizid - ID of the business.
	returns
		BUSINESS_TYPE_NONE,
		BUSINESS_TYPE_STORE,
		BUSINESS_TYPE_PHONE,
		BUSINESS_TYPE_RESTAURANT,
		BUSINESS_TYPE_AMMUNATION,
		BUSINESS_TYPE_CLOTHES,
		BUSINESS_TYPE_FUEL,
		BUSINESS_TYPE_ADVERTISE,
		BUSINESS_TYPE_CLUB,
		BUSINESS_TYPE_RENTCAR,
		BUSINESS_TYPE_BURGER,
		BUSINESS_TYPE_CLUCKIN,
		BUSINESS_TYPE_PIZZA
*/

stock GetBusinessType(bizid)
	return gBusinessData[bizid][E_BUSINESS_TYPE];

/*
	Get the bussines type as string.
		bizid - ID of the business.
	returns
		The business type as text.
*/

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

stock GetBusinessLocation(bizid)
{
	new location[MAX_ZONE_NAME];
	strcat(location, gBusinessData[bizid][E_BUSINESS_LOCATION]);
	return location;
}

/*
	Sets and save the bussines name.
		bizid  - ID of the business to be saved.
		name[] - Name.
	returns
		This function doesn't return specific values
*/

stock SetBusinessName(bizid, name[])
{
	format(gBusinessData[bizid][E_BUSINESS_NAME], 24, "%s", name);

	new query[48 + MAX_BUSINESS_NAME];
	mysql_format(mysql, query, sizeof(query), "UPDATE `business` SET `Name`='%s' WHERE `ID`=%d", gBusinessData[bizid][E_BUSINESS_NAME], gBusinessData[bizid][E_BUSINESS_DATABASEID]);
	mysql_tquery(mysql, query);
	return 1;
}

/*
	Sets and save the bussines owner name.
		bizid  - ID of the business to be saved.
		name[] - Owner Name.
	returns
		This function doesn't return specific values
*/

stock SetBusinessOwnerName(bizid, name[])
{
	format(gBusinessData[bizid][E_BUSINESS_OWNER], MAX_PLAYER_NAME, "%s", name);

	new query[48 + MAX_PLAYER_NAME];
	mysql_format(mysql, query, sizeof(query), "UPDATE `business` SET `Owner`='%s' WHERE `ID`=%d", gBusinessData[bizid][E_BUSINESS_OWNER], gBusinessData[bizid][E_BUSINESS_DATABASEID]);
	mysql_tquery(mysql, query);
	return 1;
}

/*
	Sets and save the bussines owned state.
		bizid  - ID of the business to be saved.
		value  - Owned state.
	returns
		This function doesn't return specific values
*/

stock SetBusinessOwned(bizid, value)
{
	gBusinessData[bizid][E_BUSINESS_OWNED] = value;

	new query[58];
	mysql_format(mysql, query, sizeof(query), "UPDATE `business` SET `Owned`=%d WHERE `ID`=%d", gBusinessData[bizid][E_BUSINESS_OWNED], gBusinessData[bizid][E_BUSINESS_DATABASEID]);
	mysql_tquery(mysql, query);
	return 1;
}

/*
	Sets and save the bussines type.
		bizid  - ID of the business to be saved.
		value  - Type ID.
	returns
		This function doesn't return specific values
*/

stock SetBusinessType(bizid, value)
{
	gBusinessData[bizid][E_BUSINESS_TYPE] = value;

	new query[58];
	mysql_format(mysql, query, sizeof(query), "UPDATE `business` SET `Type`=%d WHERE `ID`=%d", gBusinessData[bizid][E_BUSINESS_TYPE], gBusinessData[bizid][E_BUSINESS_DATABASEID]);
	mysql_tquery(mysql, query);
	return 1;
}

/*
	Sets and save the bussines product price.
		bizid  - ID of the business to be saved.
		value  - Product price.
	returns
		This function doesn't return specific values
*/

stock SetBusinessProductPrice(bizid, value)
{
	gBusinessData[bizid][E_BUSINESS_PRODPRICE] = value;

	new query[58];
	mysql_format(mysql, query, sizeof(query), "UPDATE `business` SET `ProductPrice`=%d WHERE `ID`=%d", gBusinessData[bizid][E_BUSINESS_PRODPRICE], gBusinessData[bizid][E_BUSINESS_DATABASEID]);
	mysql_tquery(mysql, query);
	return 1;
}

/*
	Sets and save the bussines locked state.
		bizid  - ID of the business to be saved.
		value  - Locked state.
	returns
		This function doesn't return specific values
*/

stock SetBusinessLocked(bizid, value)
{
	if(value != 0) value = 1;
	gBusinessData[bizid][E_BUSINESS_LOCKED] = value;

	new query[58];
	mysql_format(mysql, query, sizeof(query), "UPDATE `business` SET `Locked`=%d WHERE `ID`=%d", gBusinessData[bizid][E_BUSINESS_LOCKED], gBusinessData[bizid][E_BUSINESS_DATABASEID]);
	mysql_tquery(mysql, query);
	return 1;
}

stock GetBusinessLockState(bizid)
{
	return gBusinessData[bizid][E_BUSINESS_LOCKED];
}

/*
	Sets and save the bussines price.
		bizid  - ID of the business to be saved.
		value  - Price value.
	returns
		This function doesn't return specific values
*/

stock SetBusinessPrice(bizid, value)
{
	gBusinessData[bizid][E_BUSINESS_PRICE] = value;

	new query[58];
	mysql_format(mysql, query, sizeof(query), "UPDATE `business` SET `Price`=%d WHERE `ID`=%d", gBusinessData[bizid][E_BUSINESS_PRICE], gBusinessData[bizid][E_BUSINESS_DATABASEID]);
	mysql_tquery(mysql, query);
	return 1;
}

/*
	Save the bussines current entrance position.
		bizid  - ID of the business to be saved.
	returns
		This function doesn't return specific values
*/

stock SaveBusinessEntrancePos(bizid)
{
	Get2DZoneName(gBusinessData[bizid][E_BUSINESS_LOCATION], gBusinessData[bizid][E_BUSINESS_ENTERX], gBusinessData[bizid][E_BUSINESS_ENTERY]);

	new query[184];
	mysql_format(mysql, query, sizeof(query), "UPDATE `business` SET `EnterX`=%.2f, `EnterY`=%.2f, `EnterZ`=%.2f, `EnterA`=%.2f, `EnterWorld`=%d, `EnterInt`=%d, `Location`='%e' WHERE `ID`=%d", \
	gBusinessData[bizid][E_BUSINESS_ENTERX], gBusinessData[bizid][E_BUSINESS_ENTERY], gBusinessData[bizid][E_BUSINESS_ENTERZ], gBusinessData[bizid][E_BUSINESS_ENTERA], gBusinessData[bizid][E_BUSINESS_ENTERWORLD], gBusinessData[bizid][E_BUSINESS_ENTERINT], gBusinessData[bizid][E_BUSINESS_LOCATION], gBusinessData[bizid][E_BUSINESS_DATABASEID]);
	mysql_tquery(mysql, query);
	return 1;
}

/*
	Gets the bussines current entrance position.
		bizid  - ID of the business to be saved.
		X		-- passed by reference
		Y		-- passed by reference
		Z		-- passed by reference
	returns
		This function doesn't return specific values
*/

stock GetBusinessEntrancePos(bizid, &Float:X, &Float:Y, &Float:Z)
{
	X = gBusinessData[bizid][E_BUSINESS_ENTERX];
	Y = gBusinessData[bizid][E_BUSINESS_ENTERY];
	Z = gBusinessData[bizid][E_BUSINESS_ENTERZ];
	return 1;
}

/*
	Save the bussines current exit position.
		bizid  - ID of the business to be saved.
	returns
		This function doesn't return specific values
*/

stock SaveBusinessExitPos(bizid)
{

	new query[164];
	mysql_format(mysql, query, sizeof(query), "UPDATE `business` SET `ExitX`=%.2f, `ExitY`=%.2f, `ExitZ`=%.2f, `ExitA`=%.2f, `ExitInt`=%d WHERE `ID`=%d", \
	gBusinessData[bizid][E_BUSINESS_EXITX], gBusinessData[bizid][E_BUSINESS_EXITY], gBusinessData[bizid][E_BUSINESS_EXITZ], gBusinessData[bizid][E_BUSINESS_EXITA], gBusinessData[bizid][E_BUSINESS_EXITINT], gBusinessData[bizid][E_BUSINESS_DATABASEID]);
	mysql_tquery(mysql, query);
	return 1;
}

/*
	Load a business data or creates if doesn't exit.
		bizid  - ID of the business to be loaded.
	returns
		This function doesn't return specific values
*/

public LoadDynamicBusiness()
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
		printf("Number of business loaded: %d", rows);
	}
	else
	{
		new query[360];
		mysql_format(mysql, query, sizeof(query), "INSERT INTO `business` (`ID`, `Name`, `Owner`, `EnterX`, `EnterY`, `EnterZ` ,`EnterA`, `ExitX`, `ExitY`, `ExitZ`, `ExitA`, `EnterWorld`, `EnterInt`, `ExitInt`, `Owned`, `Locked`, `Price`, `Till`, `Products`, `Type`, `ProductPrice`, `Location`) VALUES (%d, 'Nenhum', 'Ninguem', 0, 0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'San Andreas')", cache_insert_id());
		mysql_tquery(mysql, query);
		print("Number of business loaded: 0");
		return 0;
	}
	return 1;
}

/*
	Updates a business 3dtext.
		bizid  - ID of the business to be loaded.
	returns
		This function doesn't return specific values
*/

stock UpdateBusinessText3D(bizid)
{
	if(!IsValidDynamic3DTextLabel(gBusinessData[bizid][E_BUSINESS_TEXT3D])) return 1;

	new sBusiness3DText[148];

	if(gBusinessData[bizid][E_BUSINESS_OWNED])
	{
		switch(gBusinessData[bizid][E_BUSINESS_LOCKED]) {
			case 0: format(sBusiness3DText, sizeof(sBusiness3DText), "%s {E2FF69}está aberto.", gBusinessData[bizid][E_BUSINESS_NAME]);
			case 1: format(sBusiness3DText, sizeof(sBusiness3DText), "%s  {E2FF69}está fechado.", gBusinessData[bizid][E_BUSINESS_NAME]);
		}

		UpdateDynamic3DTextLabelText(gBusinessData[bizid][E_BUSINESS_TEXT3D], 0xffffffff, sBusiness3DText);
	}
	else
	{
		format(sBusiness3DText, sizeof(sBusiness3DText), "%s {00DEFF}está á venda!", gBusinessData[bizid][E_BUSINESS_NAME]);
		UpdateDynamic3DTextLabelText(gBusinessData[bizid][E_BUSINESS_TEXT3D], 0xffffffff, sBusiness3DText);
	}
	return 1;
}

/*
	Updates a business pickup, mapicon and 3dtext.
		bizid  - ID of the business to be loaded.
	returns
		This function doesn't return specific values
*/

stock UpdateBusinessPickup(bizid)
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
			case 0: format(sBusiness3DText, sizeof(sBusiness3DText), "%s {E2FF69}está aberto.", gBusinessData[bizid][E_BUSINESS_NAME]);
			case 1: format(sBusiness3DText, sizeof(sBusiness3DText), "%s  {E2FF69}está fechado.", gBusinessData[bizid][E_BUSINESS_NAME]);
		}

		gBusinessData[bizid][E_BUSINESS_TEXT3D] = CreateDynamic3DTextLabel(sBusiness3DText, 0xffffffff, gBusinessData[bizid][E_BUSINESS_ENTERX], gBusinessData[bizid][E_BUSINESS_ENTERY], gBusinessData[bizid][E_BUSINESS_ENTERZ], MAX_TEXT3D_RANGE, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
	} else {
		gBusinessData[bizid][E_BUSINESS_PICKUP] = CreateDynamicPickup(1272, 1, gBusinessData[bizid][E_BUSINESS_ENTERX], gBusinessData[bizid][E_BUSINESS_ENTERY], gBusinessData[bizid][E_BUSINESS_ENTERZ], gBusinessData[bizid][E_BUSINESS_ENTERWORLD]);

		format(sBusiness3DText, sizeof(sBusiness3DText), "%s {00DEFF}está á venda!", gBusinessData[bizid][E_BUSINESS_NAME]);
		gBusinessData[bizid][E_BUSINESS_TEXT3D] = CreateDynamic3DTextLabel(sBusiness3DText, 0xffffffff, gBusinessData[bizid][E_BUSINESS_ENTERX], gBusinessData[bizid][E_BUSINESS_ENTERY], gBusinessData[bizid][E_BUSINESS_ENTERZ], MAX_TEXT3D_RANGE, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
	}
}

ShowPlayerAmmunationDialog(playerid, dialogid, b)
{
	switch(dialogid)
	{
		case DIALOG_AMMU_GUNS:
		{
			new listitems[320];
			format(listitems, sizeof listitems, "Arma\tPreço\nColt45\t$%i\nColt45 c/ Silenciador\t$%i\nDesert Eagle\t$%i\nEscopeta\t$%i\
			\nEscopeta Cano-Serrado\t$%i\nEscopeta de Combate\t$%i\nMicro SMG\t$%i\nMP5\t$%i\nAK-47\t$%i\nM4\t$%i\nTEC9\t$%i\nRifle\t$%i\
			\nSniper Rifle\t$%i\nRPG\t$%i\nRPG Seguidora\t$%i\nGranada\t$%i",
			WEAPON_COLT45_PRICE, WEAPON_SILENCED_PRICE, WEAPON_DEAGLE_PRICE, WEAPON_SHOTGUN_PRICE, WEAPON_SAWEDOFF_PRICE, WEAPON_SPAS12_PRICE,
			WEAPON_UZI_PRICE, WEAPON_MP5_PRICE, WEAPON_AK47_PRICE, WEAPON_M4_PRICE, WEAPON_TEC9_PRICE, WEAPON_RIFLE_PRICE, WEAPON_SNIPER_PRICE,
			WEAPON_RPG_PRICE, WEAPON_HSR_PRICE, WEAPON_GRENADE_PRICE);
			ShowPlayerDialog(playerid, DIALOG_AMMU_GUNS, DIALOG_STYLE_TABLIST_HEADERS, gBusinessData[b][E_BUSINESS_NAME], listitems, "Comprar", "Voltar");
		}
		case DIALOG_AMMU_AMMO:
		{
			new listitems[400];
			format(listitems, sizeof listitems, "Arma\tPreço\tBalas\nColt45\t$%i\t50\nColt45 c/ Silenciador\t$%i\t50\nDesert Eagle\t$%i\t50\nEscopeta\t$%i\t25\
			\nEscopeta Cano-Serrado\t$%i\t10\nEscopeta de Combate\t$%i\t10\nMicro SMG\t$%i\t100\nMP5\t$%i\t100\nAK-47\t$%i\t125\nM4\t$%i\t125\nTEC9\t$%i\t100\nRifle\t$%i\t10\
			\nSniper Rifle\t$%i\t10\nRPG\t$%i\t1\nRPG Seguidora\t$%i\t1\nGranada\t$%i\t1",
			AMMO_COLT45_PRICE, AMMO_SILENCED_PRICE, AMMO_DEAGLE_PRICE, AMMO_SHOTGUN_PRICE, AMMO_SAWEDOFF_PRICE, AMMO_SPAS12_PRICE,
			AMMO_UZI_PRICE, AMMO_MP5_PRICE, AMMO_AK47_PRICE, AMMO_M4_PRICE, AMMO_TEC9_PRICE, AMMO_RIFLE_PRICE, AMMO_SNIPER_PRICE,
			AMMO_RPG_PRICE, AMMO_HSR_PRICE, AMMO_GRENADE_PRICE);
			ShowPlayerDialog(playerid, DIALOG_AMMU_AMMO, DIALOG_STYLE_TABLIST_HEADERS, gBusinessData[b][E_BUSINESS_NAME], listitems, "Comprar", "Voltar");
		}
	}
}

hook OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	if(clickedid == Text:INVALID_TEXT_DRAW && GetPVarInt(playerid, "gptIsVisible") && GetPVarInt(playerid, "gptType") == 1)
    {
		HidePlayerBusinessTD(playerid);
	}
	return 1;
}

hook OnPlayerClickPlayerTD(playerid, PlayerText:playertextid)
{
	if(!GetPVarInt(playerid, "gptIsVisible") || GetPVarInt(playerid, "gptType") != 1)
		return 1;

	if(playertextid == gpt_Business[playerid][28])
    {
		PlayErrorSound(playerid);
	}
	else if(playertextid == gpt_Business[playerid][26])
    {
		HidePlayerBusinessTD(playerid);
		PlayCancelSound(playerid);
		return 1;
	}
	else if(playertextid == gpt_Business[playerid][17])
	{
		new b = GetPVarInt(playerid, "gptPropID");
		if(gBusinessData[b][E_BUSINESS_LOCKED])
        {
			PlayErrorSound(playerid);
			SendClientMessage(playerid, COLOR_ERROR, "* Empresa trancada!");
			return 1;
		}
		else if(gBusinessData[b][E_BUSINESS_TYPE] == BUSINESS_TYPE_FUEL)
        {
			PlayErrorSound(playerid);
			SendClientMessage(playerid, COLOR_ERROR, "* Não é possível entrar dentro desta empresa!");
			return 1;
		}

		SetPlayerPos(playerid, gBusinessData[b][E_BUSINESS_EXITX], gBusinessData[b][E_BUSINESS_EXITY], gBusinessData[b][E_BUSINESS_EXITZ]);
		SetPlayerFacingAngle(playerid, gBusinessData[b][E_BUSINESS_EXITA]);
		SetPlayerInterior(playerid, gBusinessData[b][E_BUSINESS_EXITINT]);
		SetPlayerVirtualWorld(playerid, b);
		SendClientMessagef(playerid, COLOR_INFO, "* Bem vindo ao %s.", gBusinessData[b][E_BUSINESS_NAME]);
		SetPVarInt(playerid, "PickupDelay", PICKUP_DELAY);

		SetCameraBehindPlayer(playerid);
		OnPlayerEnterBusiness(playerid, b);
		HidePlayerBusinessTD(playerid);
	}
	else if(playertextid == gpt_Business[playerid][12])
	{
		new b = GetPVarInt(playerid, "gptPropID");
		if(GetPlayerCash(playerid) < gBusinessData[b][E_BUSINESS_PRICE])
        {
			PlayErrorSound(playerid);
			SendClientMessage(playerid, COLOR_ERROR, "* Você não possui dinheiro suficiente!");
			return 1;
		}
		else if(gPlayerKey[playerid] != INVALID_BUSINESS_ID)
        {
			PlayErrorSound(playerid);
			SendClientMessage(playerid, COLOR_ERROR, "* Você já possui uma empresa!");
			return 1;
		}
		else if(gBusinessData[GetPVarInt(playerid, "gptPropID")][E_BUSINESS_OWNED])
        {
			SendClientMessage(playerid, COLOR_ERROR, "* Essa empresa já tem dono!");
			PlayErrorSound(playerid);
			return 1;
		}

		PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_INFO, "* Você comprou a empresa.");
		SendClientActionMessage(playerid, 30.0, "assina os papeis e recebe a chave da empresa.");

		SetPlayerBusinessID(playerid, b);
		GivePlayerCash(playerid, -gBusinessData[b][E_BUSINESS_PRICE]);
		HidePlayerBusinessTD(playerid);

		SetBusinessTill(b, 0);
		SetBusinessOwned(b, 1);
		SetBusinessLocked(b, 0);
		SetBusinessProducts(b, 250);
		SetBusinessProductPrice(b, 10);
		SetBusinessOwnerName(b, GetPlayerNamef(playerid, false));
		UpdateBusinessPickup(b);
	}
	return 1;
}

HidePlayerBusinessTD(playerid)
{
	if(!GetPVarInt(playerid, "gptIsVisible"))
		return 1;

    DeletePVar(playerid, "gptType");
	defer gptVisibleDelayed(playerid);
	CancelSelectTextDraw(playerid);
	for (new i = 0; i < sizeof(gpt_Business[]); i++) {
		PlayerTextDrawDestroy(playerid, gpt_Business[playerid][i]);
	}
	return 1;
}

ShowPlayerBusinessTD(playerid, businessid)
{
	if(GetPVarInt(playerid, "gptIsVisible"))
		return 1;

    SetPVarInt(playerid, "gptType", 1);
    SetPVarInt(playerid, "gptIsVisible", 1);
    SetPVarInt(playerid, "gptPropID", businessid);
	new bool:islocked = false;
	new bool:isowned = false;
	if(gBusinessData[businessid][E_BUSINESS_LOCKED]) islocked = true;
	if(gBusinessData[businessid][E_BUSINESS_OWNED]) isowned = true;
	new sInfo[64];

	gpt_Business[playerid][0] = CreatePlayerTextDraw(playerid, 499.333526, 119.510978, "_");
	PlayerTextDrawLetterSize(playerid, gpt_Business[playerid][0], 0.680666, 13.388413);
	PlayerTextDrawTextSize(playerid, gpt_Business[playerid][0], 632.453674, 0.000000);
	PlayerTextDrawAlignment(playerid, gpt_Business[playerid][0], 1);
	PlayerTextDrawColor(playerid, gpt_Business[playerid][0], -1);
	PlayerTextDrawUseBox(playerid, gpt_Business[playerid][0], 1);
	PlayerTextDrawBoxColor(playerid, gpt_Business[playerid][0], 61);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, gpt_Business[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, gpt_Business[playerid][0], 255);
	PlayerTextDrawFont(playerid, gpt_Business[playerid][0], 2);
	PlayerTextDrawSetProportional(playerid, gpt_Business[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][0], 0);

	gpt_Business[playerid][1] = CreatePlayerTextDraw(playerid, 500.250061, 121.120323, "box");
	PlayerTextDrawLetterSize(playerid, gpt_Business[playerid][1], 0.000000, 1.845671);
	PlayerTextDrawTextSize(playerid, gpt_Business[playerid][1], 631.486328, 0.000000);
	PlayerTextDrawAlignment(playerid, gpt_Business[playerid][1], 1);
	PlayerTextDrawColor(playerid, gpt_Business[playerid][1], -1);
	PlayerTextDrawUseBox(playerid, gpt_Business[playerid][1], 1);
	PlayerTextDrawBoxColor(playerid, gpt_Business[playerid][1], 69);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, gpt_Business[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, gpt_Business[playerid][1], 255);
	PlayerTextDrawFont(playerid, gpt_Business[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, gpt_Business[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][1], 0);

	gpt_Business[playerid][2] = CreatePlayerTextDraw(playerid, 500.250061, 141.821578, "box");
	PlayerTextDrawLetterSize(playerid, gpt_Business[playerid][2], 0.000000, 7.578680);
	PlayerTextDrawTextSize(playerid, gpt_Business[playerid][2], 631.426086, 0.000000);
	PlayerTextDrawAlignment(playerid, gpt_Business[playerid][2], 1);
	PlayerTextDrawColor(playerid, gpt_Business[playerid][2], -1);
	PlayerTextDrawUseBox(playerid, gpt_Business[playerid][2], 1);
	PlayerTextDrawBoxColor(playerid, gpt_Business[playerid][2], 69);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, gpt_Business[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, gpt_Business[playerid][2], 255);
	PlayerTextDrawFont(playerid, gpt_Business[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, gpt_Business[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][2], 0);

	gpt_Business[playerid][3] = CreatePlayerTextDraw(playerid, 496.399902, 118.640647, "");
	PlayerTextDrawLetterSize(playerid, gpt_Business[playerid][3], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, gpt_Business[playerid][3], 21.666633, 21.970375);
	PlayerTextDrawAlignment(playerid, gpt_Business[playerid][3], 1);
	PlayerTextDrawColor(playerid, gpt_Business[playerid][3], -1258291202);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, gpt_Business[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, gpt_Business[playerid][3], 0);
	PlayerTextDrawFont(playerid, gpt_Business[playerid][3], 5);
	PlayerTextDrawSetProportional(playerid, gpt_Business[playerid][3], 0);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][3], 0);
	PlayerTextDrawSetPreviewModel(playerid, gpt_Business[playerid][3], 1272);
	PlayerTextDrawSetPreviewRot(playerid, gpt_Business[playerid][3], 0.000000, 0.000000, 0.000000, 1.000000);

	gpt_Business[playerid][4] = CreatePlayerTextDraw(playerid, 500.933563, 182.984573, "- Status:");
	PlayerTextDrawLetterSize(playerid, gpt_Business[playerid][4], 0.211998, 1.147850);
	PlayerTextDrawAlignment(playerid, gpt_Business[playerid][4], 1);
	PlayerTextDrawColor(playerid, gpt_Business[playerid][4], -1);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, gpt_Business[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, gpt_Business[playerid][4], 255);
	PlayerTextDrawFont(playerid, gpt_Business[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, gpt_Business[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][4], 0);

	if(gBusinessData[businessid][E_BUSINESS_OWNED])
		format(sInfo, sizeof(sInfo), "Emp. de %s", GetFirstName(gBusinessData[businessid][E_BUSINESS_OWNER]));
	else
		format(sInfo, sizeof(sInfo), "Empresa_a_Venda");
	gpt_Business[playerid][5] = CreatePlayerTextDraw(playerid, 518.150207, 124.568435, sInfo);
	PlayerTextDrawLetterSize(playerid, gpt_Business[playerid][5], 0.238333, 1.002665);
	PlayerTextDrawAlignment(playerid, gpt_Business[playerid][5], 1);
	PlayerTextDrawColor(playerid, gpt_Business[playerid][5], 1116457727);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][5], 1);
	PlayerTextDrawSetOutline(playerid, gpt_Business[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, gpt_Business[playerid][5], 255);
	PlayerTextDrawFont(playerid, gpt_Business[playerid][5], 3);
	PlayerTextDrawSetProportional(playerid, gpt_Business[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][5], 1);

	gpt_Business[playerid][6] = CreatePlayerTextDraw(playerid, 500.784240, 143.646331, "- Nome:");
	PlayerTextDrawLetterSize(playerid, gpt_Business[playerid][6], 0.211998, 1.147850);
	PlayerTextDrawAlignment(playerid, gpt_Business[playerid][6], 1);
	PlayerTextDrawColor(playerid, gpt_Business[playerid][6], -1);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, gpt_Business[playerid][6], 0);
	PlayerTextDrawBackgroundColor(playerid, gpt_Business[playerid][6], 255);
	PlayerTextDrawFont(playerid, gpt_Business[playerid][6], 1);
	PlayerTextDrawSetProportional(playerid, gpt_Business[playerid][6], 1);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][6], 0);

	format(sInfo, sizeof(sInfo), "%i", businessid);
	gpt_Business[playerid][7] = CreatePlayerTextDraw(playerid, 619.986267, 124.203620, sInfo);
	PlayerTextDrawLetterSize(playerid, gpt_Business[playerid][7], 0.238333, 1.002665);
	PlayerTextDrawAlignment(playerid, gpt_Business[playerid][7], 1);
	PlayerTextDrawColor(playerid, gpt_Business[playerid][7], -173);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, gpt_Business[playerid][7], 0);
	PlayerTextDrawBackgroundColor(playerid, gpt_Business[playerid][7], 255);
	PlayerTextDrawFont(playerid, gpt_Business[playerid][7], 3);
	PlayerTextDrawSetProportional(playerid, gpt_Business[playerid][7], 1);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][7], 0);

	gpt_Business[playerid][8] = CreatePlayerTextDraw(playerid, 500.600219, 156.532958, "- Tipo:");
	PlayerTextDrawLetterSize(playerid, gpt_Business[playerid][8], 0.211998, 1.147850);
	PlayerTextDrawAlignment(playerid, gpt_Business[playerid][8], 1);
	PlayerTextDrawColor(playerid, gpt_Business[playerid][8], -1);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, gpt_Business[playerid][8], 0);
	PlayerTextDrawBackgroundColor(playerid, gpt_Business[playerid][8], 255);
	PlayerTextDrawFont(playerid, gpt_Business[playerid][8], 1);
	PlayerTextDrawSetProportional(playerid, gpt_Business[playerid][8], 1);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][8], 0);

	gpt_Business[playerid][9] = CreatePlayerTextDraw(playerid, 500.933563, 169.833770, "- Local:");
	PlayerTextDrawLetterSize(playerid, gpt_Business[playerid][9], 0.211998, 1.147850);
	PlayerTextDrawAlignment(playerid, gpt_Business[playerid][9], 1);
	PlayerTextDrawColor(playerid, gpt_Business[playerid][9], -1);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][9], 0);
	PlayerTextDrawSetOutline(playerid, gpt_Business[playerid][9], 0);
	PlayerTextDrawBackgroundColor(playerid, gpt_Business[playerid][9], 255);
	PlayerTextDrawFont(playerid, gpt_Business[playerid][9], 1);
	PlayerTextDrawSetProportional(playerid, gpt_Business[playerid][9], 1);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][9], 0);

	gpt_Business[playerid][10] = CreatePlayerTextDraw(playerid, 500.933563, 196.485397, "- Valor por produto:");
	PlayerTextDrawLetterSize(playerid, gpt_Business[playerid][10], 0.211998, 1.147850);
	PlayerTextDrawAlignment(playerid, gpt_Business[playerid][10], 1);
	PlayerTextDrawColor(playerid, gpt_Business[playerid][10], -1);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][10], 0);
	PlayerTextDrawSetOutline(playerid, gpt_Business[playerid][10], 0);
	PlayerTextDrawBackgroundColor(playerid, gpt_Business[playerid][10], 255);
	PlayerTextDrawFont(playerid, gpt_Business[playerid][10], 1);
	PlayerTextDrawSetProportional(playerid, gpt_Business[playerid][10], 1);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][10], 0);

	gpt_Business[playerid][11] = CreatePlayerTextDraw(playerid, 630.755920, 143.231521, gBusinessData[businessid][E_BUSINESS_NAME]);
	PlayerTextDrawLetterSize(playerid, gpt_Business[playerid][11], 0.211998, 1.147850);
	PlayerTextDrawAlignment(playerid, gpt_Business[playerid][11], 3);
	PlayerTextDrawColor(playerid, gpt_Business[playerid][11], -134);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][11], 0);
	PlayerTextDrawSetOutline(playerid, gpt_Business[playerid][11], 0);
	PlayerTextDrawBackgroundColor(playerid, gpt_Business[playerid][11], 255);
	PlayerTextDrawFont(playerid, gpt_Business[playerid][11], 1);
	PlayerTextDrawSetProportional(playerid, gpt_Business[playerid][11], 1);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][11], 0);

	gpt_Business[playerid][12] = CreatePlayerTextDraw(playerid, 500.099945, 214.299957, "box");
	PlayerTextDrawLetterSize(playerid, gpt_Business[playerid][12], 0.000000, 2.712661);
	PlayerTextDrawTextSize(playerid, gpt_Business[playerid][12], 563.745605, 25.000000);
	PlayerTextDrawAlignment(playerid, gpt_Business[playerid][12], 1);
	PlayerTextDrawColor(playerid, gpt_Business[playerid][12], -1);
	PlayerTextDrawUseBox(playerid, gpt_Business[playerid][12], 1);
	PlayerTextDrawBoxColor(playerid, gpt_Business[playerid][12], (isowned) ? 2139062272 : 8388682);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][12], 0);
	PlayerTextDrawSetOutline(playerid, gpt_Business[playerid][12], 0);
	PlayerTextDrawBackgroundColor(playerid, gpt_Business[playerid][12], 255);
	PlayerTextDrawFont(playerid, gpt_Business[playerid][12], 2);
	PlayerTextDrawSetProportional(playerid, gpt_Business[playerid][12], 1);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][12], 0);
	PlayerTextDrawSetSelectable(playerid, gpt_Business[playerid][12], true);

	gpt_Business[playerid][13] = CreatePlayerTextDraw(playerid, 630.789306, 156.491531, GetBusinessTypeName(businessid));
	PlayerTextDrawLetterSize(playerid, gpt_Business[playerid][13], 0.211998, 1.147850);
	PlayerTextDrawAlignment(playerid, gpt_Business[playerid][13], 3);
	PlayerTextDrawColor(playerid, gpt_Business[playerid][13], -134);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][13], 0);
	PlayerTextDrawSetOutline(playerid, gpt_Business[playerid][13], 0);
	PlayerTextDrawBackgroundColor(playerid, gpt_Business[playerid][13], 255);
	PlayerTextDrawFont(playerid, gpt_Business[playerid][13], 1);
	PlayerTextDrawSetProportional(playerid, gpt_Business[playerid][13], 1);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][13], 0);

	gpt_Business[playerid][14] = CreatePlayerTextDraw(playerid, 630.956115, 169.733139, gBusinessData[businessid][E_BUSINESS_LOCATION]);
	PlayerTextDrawLetterSize(playerid, gpt_Business[playerid][14], 0.211998, 1.147850);
	PlayerTextDrawAlignment(playerid, gpt_Business[playerid][14], 3);
	PlayerTextDrawColor(playerid, gpt_Business[playerid][14], -134);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][14], 0);
	PlayerTextDrawSetOutline(playerid, gpt_Business[playerid][14], 0);
	PlayerTextDrawBackgroundColor(playerid, gpt_Business[playerid][14], 255);
	PlayerTextDrawFont(playerid, gpt_Business[playerid][14], 1);
	PlayerTextDrawSetProportional(playerid, gpt_Business[playerid][14], 1);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][14], 0);

	new bState[9] = "Trancada";
	if(!gBusinessData[businessid][E_BUSINESS_LOCKED]) bState = "Aberta";
	gpt_Business[playerid][15] = CreatePlayerTextDraw(playerid, 630.956115, 183.033950, bState);
	PlayerTextDrawLetterSize(playerid, gpt_Business[playerid][15], 0.211998, 1.147850);
	PlayerTextDrawAlignment(playerid, gpt_Business[playerid][15], 3);
	PlayerTextDrawColor(playerid, gpt_Business[playerid][15], -1523766279);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][15], 0);
	PlayerTextDrawSetOutline(playerid, gpt_Business[playerid][15], 0);
	PlayerTextDrawBackgroundColor(playerid, gpt_Business[playerid][15], 255);
	PlayerTextDrawFont(playerid, gpt_Business[playerid][15], 1);
	PlayerTextDrawSetProportional(playerid, gpt_Business[playerid][15], 1);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][15], 0);

	format(sInfo, sizeof(sInfo), "$%i", gBusinessData[businessid][E_BUSINESS_PRODPRICE]);
	gpt_Business[playerid][16] = CreatePlayerTextDraw(playerid, 630.956115, 196.834793, sInfo);
	PlayerTextDrawLetterSize(playerid, gpt_Business[playerid][16], 0.211998, 1.147850);
	PlayerTextDrawAlignment(playerid, gpt_Business[playerid][16], 3);
	PlayerTextDrawColor(playerid, gpt_Business[playerid][16], 8388863);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][16], 0);
	PlayerTextDrawSetOutline(playerid, gpt_Business[playerid][16], 0);
	PlayerTextDrawBackgroundColor(playerid, gpt_Business[playerid][16], 255);
	PlayerTextDrawFont(playerid, gpt_Business[playerid][16], 1);
	PlayerTextDrawSetProportional(playerid, gpt_Business[playerid][16], 1);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][16], 0);

	gpt_Business[playerid][17] = CreatePlayerTextDraw(playerid, 567.499877, 214.199890, "box");
	PlayerTextDrawLetterSize(playerid, gpt_Business[playerid][17], 0.000000, 2.712661);
	PlayerTextDrawTextSize(playerid, gpt_Business[playerid][17], 631.561645, 25.000000);
	PlayerTextDrawAlignment(playerid, gpt_Business[playerid][17], 1);
	PlayerTextDrawColor(playerid, gpt_Business[playerid][17], -1);
	PlayerTextDrawUseBox(playerid, gpt_Business[playerid][17], 1);
	PlayerTextDrawBoxColor(playerid, gpt_Business[playerid][17], (islocked) ? 2139062272 : -293376257);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][17], 0);
	PlayerTextDrawSetOutline(playerid, gpt_Business[playerid][17], 0);
	PlayerTextDrawBackgroundColor(playerid, gpt_Business[playerid][17], 255);
	PlayerTextDrawFont(playerid, gpt_Business[playerid][17], 2);
	PlayerTextDrawSetProportional(playerid, gpt_Business[playerid][17], 1);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][17], 0);
	PlayerTextDrawSetSelectable(playerid, gpt_Business[playerid][17], true);

	gpt_Business[playerid][18] = CreatePlayerTextDraw(playerid, 500.200012, 214.200012, "box");
	PlayerTextDrawLetterSize(playerid, gpt_Business[playerid][18], 0.000000, 1.255000);
	PlayerTextDrawTextSize(playerid, gpt_Business[playerid][18], 563.718200, 0.000000);
	PlayerTextDrawAlignment(playerid, gpt_Business[playerid][18], 1);
	PlayerTextDrawColor(playerid, gpt_Business[playerid][18], -1);
	PlayerTextDrawUseBox(playerid, gpt_Business[playerid][18], 1);
	PlayerTextDrawBoxColor(playerid, gpt_Business[playerid][18], (isowned) ? 2139062272 : -230);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][18], 0);
	PlayerTextDrawSetOutline(playerid, gpt_Business[playerid][18], 0);
	PlayerTextDrawBackgroundColor(playerid, gpt_Business[playerid][18], 255);
	PlayerTextDrawFont(playerid, gpt_Business[playerid][18], 2);
	PlayerTextDrawSetProportional(playerid, gpt_Business[playerid][18], 1);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][18], 0);

	gpt_Business[playerid][19] = CreatePlayerTextDraw(playerid, 493.000122, 215.562957, "");
	PlayerTextDrawLetterSize(playerid, gpt_Business[playerid][19], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, gpt_Business[playerid][19], 28.666673, 21.140745);
	PlayerTextDrawAlignment(playerid, gpt_Business[playerid][19], 1);
	PlayerTextDrawColor(playerid, gpt_Business[playerid][19], -1);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][19], 0);
	PlayerTextDrawSetOutline(playerid, gpt_Business[playerid][19], 0);
	PlayerTextDrawBackgroundColor(playerid, gpt_Business[playerid][19], 0);
	PlayerTextDrawFont(playerid, gpt_Business[playerid][19], 5);
	PlayerTextDrawSetProportional(playerid, gpt_Business[playerid][19], 0);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][19], 0);
	PlayerTextDrawSetPreviewModel(playerid, gpt_Business[playerid][19], 1274);
	PlayerTextDrawSetPreviewRot(playerid, gpt_Business[playerid][19], 0.000000, 0.000000, 180.000000, 1.000000);

	gpt_Business[playerid][20] = CreatePlayerTextDraw(playerid, 516.999938, 215.303680, "Comprar");
	PlayerTextDrawLetterSize(playerid, gpt_Business[playerid][20], 0.219332, 1.309628);
	PlayerTextDrawAlignment(playerid, gpt_Business[playerid][20], 1);
	PlayerTextDrawColor(playerid, gpt_Business[playerid][20], (isowned) ? -2139062017 : -1);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][20], 0);
	PlayerTextDrawSetOutline(playerid, gpt_Business[playerid][20], 0);
	PlayerTextDrawBackgroundColor(playerid, gpt_Business[playerid][20], 255);
	PlayerTextDrawFont(playerid, gpt_Business[playerid][20], 2);
	PlayerTextDrawSetProportional(playerid, gpt_Business[playerid][20], 1);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][20], 0);

	format(sInfo, sizeof(sInfo), "$%i", gBusinessData[businessid][E_BUSINESS_PRICE]);
	gpt_Business[playerid][21] = CreatePlayerTextDraw(playerid, 516.999755, 227.200012, sInfo);
	PlayerTextDrawLetterSize(playerid, gpt_Business[playerid][21], 0.170000, 0.766222);
	PlayerTextDrawAlignment(playerid, gpt_Business[playerid][21], 1);
	PlayerTextDrawColor(playerid, gpt_Business[playerid][21], -146);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][21], 0);
	PlayerTextDrawSetOutline(playerid, gpt_Business[playerid][21], 0);
	PlayerTextDrawBackgroundColor(playerid, gpt_Business[playerid][21], 255);
	PlayerTextDrawFont(playerid, gpt_Business[playerid][21], 2);
	PlayerTextDrawSetProportional(playerid, gpt_Business[playerid][21], 1);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][21], 0);

	gpt_Business[playerid][22] = CreatePlayerTextDraw(playerid, 567.399902, 214.200012, "box");
	PlayerTextDrawLetterSize(playerid, gpt_Business[playerid][22], 0.000000, 1.267994);
	PlayerTextDrawTextSize(playerid, gpt_Business[playerid][22], 631.023376, 0.000000);
	PlayerTextDrawAlignment(playerid, gpt_Business[playerid][22], 1);
	PlayerTextDrawColor(playerid, gpt_Business[playerid][22], -1);
	PlayerTextDrawUseBox(playerid, gpt_Business[playerid][22], 1);
	PlayerTextDrawBoxColor(playerid, gpt_Business[playerid][22], -226);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][22], 0);
	PlayerTextDrawSetOutline(playerid, gpt_Business[playerid][22], 0);
	PlayerTextDrawBackgroundColor(playerid, gpt_Business[playerid][22], 255);
	PlayerTextDrawFont(playerid, gpt_Business[playerid][22], 2);
	PlayerTextDrawSetProportional(playerid, gpt_Business[playerid][22], 1);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][22], 0);

	gpt_Business[playerid][23] = CreatePlayerTextDraw(playerid, 586.000000, 218.499969, "Entrar");
	PlayerTextDrawLetterSize(playerid, gpt_Business[playerid][23], 0.240333, 1.525333);
	PlayerTextDrawAlignment(playerid, gpt_Business[playerid][23], (islocked) ? -2139062017 : 1);
	PlayerTextDrawColor(playerid, gpt_Business[playerid][23], -1);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][23], 0);
	PlayerTextDrawSetOutline(playerid, gpt_Business[playerid][23], 0);
	PlayerTextDrawBackgroundColor(playerid, gpt_Business[playerid][23], 255);
	PlayerTextDrawFont(playerid, gpt_Business[playerid][23], 2);
	PlayerTextDrawSetProportional(playerid, gpt_Business[playerid][23], 1);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][23], 0);

	gpt_Business[playerid][24] = CreatePlayerTextDraw(playerid, 562.700561, 234.399963, "");
	PlayerTextDrawLetterSize(playerid, gpt_Business[playerid][24], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, gpt_Business[playerid][24], 25.450029, -18.016265);
	PlayerTextDrawAlignment(playerid, gpt_Business[playerid][24], 1);
	PlayerTextDrawColor(playerid, gpt_Business[playerid][24], -1);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][24], 0);
	PlayerTextDrawSetOutline(playerid, gpt_Business[playerid][24], 0);
	PlayerTextDrawBackgroundColor(playerid, gpt_Business[playerid][24], 0);
	PlayerTextDrawFont(playerid, gpt_Business[playerid][24], 5);
	PlayerTextDrawSetProportional(playerid, gpt_Business[playerid][24], 0);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][24], 0);
	PlayerTextDrawSetPreviewModel(playerid, gpt_Business[playerid][24], 1318);
	PlayerTextDrawSetPreviewRot(playerid, gpt_Business[playerid][24], 0.000000, 0.000000, 90.000000, 1.000000);

	gpt_Business[playerid][25] = CreatePlayerTextDraw(playerid, 628.000000, 111.400009, "box");
	PlayerTextDrawLetterSize(playerid, gpt_Business[playerid][25], 0.000000, 0.566664);
	PlayerTextDrawTextSize(playerid, gpt_Business[playerid][25], 632.666625, 0.000000);
	PlayerTextDrawAlignment(playerid, gpt_Business[playerid][25], 1);
	PlayerTextDrawColor(playerid, gpt_Business[playerid][25], -1);
	PlayerTextDrawUseBox(playerid, gpt_Business[playerid][25], 1);
	PlayerTextDrawBoxColor(playerid, gpt_Business[playerid][25], 58);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][25], 0);
	PlayerTextDrawSetOutline(playerid, gpt_Business[playerid][25], 0);
	PlayerTextDrawBackgroundColor(playerid, gpt_Business[playerid][25], 255);
	PlayerTextDrawFont(playerid, gpt_Business[playerid][25], 1);
	PlayerTextDrawSetProportional(playerid, gpt_Business[playerid][25], 1);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][25], 0);

	gpt_Business[playerid][26] = CreatePlayerTextDraw(playerid, 627.199951, 109.399993, "X");
	PlayerTextDrawLetterSize(playerid, gpt_Business[playerid][26], 0.257999, 0.948740);
	PlayerTextDrawTextSize(playerid, gpt_Business[playerid][26], 637.599951, 10.000);
	PlayerTextDrawAlignment(playerid, gpt_Business[playerid][26], 1);
	PlayerTextDrawColor(playerid, gpt_Business[playerid][26], -16776961);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][26], 0);
	PlayerTextDrawSetOutline(playerid, gpt_Business[playerid][26], 0);
	PlayerTextDrawBackgroundColor(playerid, gpt_Business[playerid][26], 255);
	PlayerTextDrawFont(playerid, gpt_Business[playerid][26], 1);
	PlayerTextDrawSetProportional(playerid, gpt_Business[playerid][26], 1);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][26], 0);
	PlayerTextDrawSetSelectable(playerid, gpt_Business[playerid][26], true);

	gpt_Business[playerid][27] = CreatePlayerTextDraw(playerid, 567.299926, 243.400024, "box");
	PlayerTextDrawLetterSize(playerid, gpt_Business[playerid][27], 0.000000, 0.966666);
	PlayerTextDrawTextSize(playerid, gpt_Business[playerid][27], 632.632934, 0.000000);
	PlayerTextDrawAlignment(playerid, gpt_Business[playerid][27], 1);
	PlayerTextDrawColor(playerid, gpt_Business[playerid][27], -1);
	PlayerTextDrawUseBox(playerid, gpt_Business[playerid][27], 1);
	PlayerTextDrawBoxColor(playerid, gpt_Business[playerid][27], 56);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][27], 0);
	PlayerTextDrawSetOutline(playerid, gpt_Business[playerid][27], 0);
	PlayerTextDrawBackgroundColor(playerid, gpt_Business[playerid][27], 255);
	PlayerTextDrawFont(playerid, gpt_Business[playerid][27], 1);
	PlayerTextDrawSetProportional(playerid, gpt_Business[playerid][27], 1);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][27], 0);

	gpt_Business[playerid][28] = CreatePlayerTextDraw(playerid, 568.200195, 243.200012, "box");
	PlayerTextDrawLetterSize(playerid, gpt_Business[playerid][28], 0.000000, 0.841335);
	PlayerTextDrawTextSize(playerid, gpt_Business[playerid][28], 631.479064, 7.5);
	PlayerTextDrawAlignment(playerid, gpt_Business[playerid][28], 1);
	PlayerTextDrawColor(playerid, gpt_Business[playerid][28], -5963521);
	PlayerTextDrawUseBox(playerid, gpt_Business[playerid][28], 1);
	PlayerTextDrawBoxColor(playerid, gpt_Business[playerid][28], -1378294188);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][28], 0);
	PlayerTextDrawSetOutline(playerid, gpt_Business[playerid][28], 0);
	PlayerTextDrawBackgroundColor(playerid, gpt_Business[playerid][28], 255);
	PlayerTextDrawFont(playerid, gpt_Business[playerid][28], 1);
	PlayerTextDrawSetProportional(playerid, gpt_Business[playerid][28], 1);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][28], 0);
	PlayerTextDrawSetSelectable(playerid, gpt_Business[playerid][28], true);

	gpt_Business[playerid][29] = CreatePlayerTextDraw(playerid, 568.200195, 243.200012, "box");
	PlayerTextDrawLetterSize(playerid, gpt_Business[playerid][29], 0.000000, 0.141335);
	PlayerTextDrawTextSize(playerid, gpt_Business[playerid][29], 631.145629, 0.000000);
	PlayerTextDrawAlignment(playerid, gpt_Business[playerid][29], 1);
	PlayerTextDrawColor(playerid, gpt_Business[playerid][29], -5963521);
	PlayerTextDrawUseBox(playerid, gpt_Business[playerid][29], 1);
	PlayerTextDrawBoxColor(playerid, gpt_Business[playerid][29], -226);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][29], 0);
	PlayerTextDrawSetOutline(playerid, gpt_Business[playerid][29], 0);
	PlayerTextDrawBackgroundColor(playerid, gpt_Business[playerid][29], 255);
	PlayerTextDrawFont(playerid, gpt_Business[playerid][29], 1);
	PlayerTextDrawSetProportional(playerid, gpt_Business[playerid][29], 1);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][29], 0);

	gpt_Business[playerid][30] = CreatePlayerTextDraw(playerid, 568.499877, 243.000000, "Administrar empresa");
	PlayerTextDrawLetterSize(playerid, gpt_Business[playerid][30], 0.134666, 0.741333);
	PlayerTextDrawAlignment(playerid, gpt_Business[playerid][30], 1);
	PlayerTextDrawColor(playerid, gpt_Business[playerid][30], -1);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][30], 0);
	PlayerTextDrawSetOutline(playerid, gpt_Business[playerid][30], 0);
	PlayerTextDrawBackgroundColor(playerid, gpt_Business[playerid][30], 255);
	PlayerTextDrawFont(playerid, gpt_Business[playerid][30], 2);
	PlayerTextDrawSetProportional(playerid, gpt_Business[playerid][30], 1);
	PlayerTextDrawSetShadow(playerid, gpt_Business[playerid][30], 0);

	for (new i = 0; i < sizeof(gpt_Business[]); i++) {
		PlayerTextDrawShow(playerid, gpt_Business[playerid][i]);
	}
	SelectTextDraw(playerid, 0x2aa6b3ff);
	return 1;
}

//------------------------------------------------------------------------------
/***
 *     ######     ###    ##       ##       ########     ###     ######  ##    ##
 *    ##    ##   ## ##   ##       ##       ##     ##   ## ##   ##    ## ##   ##
 *    ##        ##   ##  ##       ##       ##     ##  ##   ##  ##       ##  ##
 *    ##       ##     ## ##       ##       ########  ##     ## ##       #####
 *    ##       ######### ##       ##       ##     ## ######### ##       ##  ##
 *    ##    ## ##     ## ##       ##       ##     ## ##     ## ##    ## ##   ##
 *     ######  ##     ## ######## ######## ########  ##     ##  ######  ##    ##
 ***/
//------------------------------------------------------------------------------

/*
	Called when the gamemode starts
	returns
		This function doesn't return specific values
*/

hook OnGameModeInit()
{
	mysql_tquery(mysql, "CREATE TABLE IF NOT EXISTS `business` (`ID` int(11) NOT NULL AUTO_INCREMENT, `Name` VARCHAR(64), `Owner` VARCHAR(25), `EnterX` FLOAT(10), `EnterY` FLOAT(10), `EnterZ` FLOAT(10),\
	 `EnterA` FLOAT(10), `ExitX` FLOAT(10), `ExitY` FLOAT(10), `ExitZ` FLOAT(10), `ExitA` FLOAT(10), `EnterWorld` INT(10), `EnterInt` INT(10), `ExitInt` INT(10), `Owned` INT(10), `Locked` INT(10),\
	  `Price` INT(10), `Till` INT(10), `Products` INT(10), `Type` INT(10), `ProductPrice` INT(10), `Location` VARCHAR(28), PRIMARY KEY (ID), KEY (ID)) ENGINE = InnoDB DEFAULT CHARSET = latin1 AUTO_INCREMENT = 1;  ");

	mysql_tquery(mysql, "SELECT * FROM `business`", "LoadDynamicBusiness");

	for(new i; i < sizeof(gBusinessStoreCheckpoint); i++)
		gBusinessStoreCheckpointID[i] = CreateDynamicCP(gBusinessStoreCheckpoint[i][0], gBusinessStoreCheckpoint[i][1], gBusinessStoreCheckpoint[i][2], 1.0);

	for(new i; i < sizeof(gBusinessClothesCheckpoint); i++)
		gBusinessClothesCheckpointID[i] = CreateDynamicCP(gBusinessClothesCheckpoint[i][0], gBusinessClothesCheckpoint[i][1], gBusinessClothesCheckpoint[i][2], 1.0);

	for(new i; i < sizeof(gBusinessRestaurantCheckpoint); i++)
		gBusinessRestaurantCheckpointID[i] = CreateDynamicCP(gBusinessRestaurantCheckpoint[i][0], gBusinessRestaurantCheckpoint[i][1], gBusinessRestaurantCheckpoint[i][2], 1.0);

	for(new i; i < sizeof(gBusinessClubCheckpoint); i++)
		gBusinessClubCheckpointID[i] = CreateDynamicCP(gBusinessClubCheckpoint[i][0], gBusinessClubCheckpoint[i][1], gBusinessClubCheckpoint[i][2], 1.0);

	for(new i; i < sizeof(gBusinessAmmuCheckpoint); i++)
		gBusinessAmmuCheckpointID[i] = CreateDynamicCP(gBusinessAmmuCheckpoint[i][0], gBusinessAmmuCheckpoint[i][1], gBusinessAmmuCheckpoint[i][2], 1.0);

	gBusinessPizzaCheckpointID = CreateDynamicCP(gBusinessPizzaCheckpoint[0][0], gBusinessPizzaCheckpoint[0][1], gBusinessPizzaCheckpoint[0][2], 1.0, -1, 5);
	gBusinessPhoneCheckpointID = CreateDynamicCP(gBusinessPhoneCheckpoint[0][0], gBusinessPhoneCheckpoint[0][1], gBusinessPhoneCheckpoint[0][2], 1.0, -1, 1);
	gBusinessBurgerCheckpointID = CreateDynamicCP(gBusinessBurgerCheckpoint[0][0], gBusinessBurgerCheckpoint[0][1], gBusinessBurgerCheckpoint[0][2], 1.0, -1, 10);
	gBusinessCluckinCheckpointID = CreateDynamicCP(gBusinessCluckinCheckpoint[0][0], gBusinessCluckinCheckpoint[0][1], gBusinessCluckinCheckpoint[0][2], 1.0, -1, 9);
	gBusinessAdvertisesCheckpointID = CreateDynamicCP(gBusinessAdvertisesCheckpoint[0][0], gBusinessAdvertisesCheckpoint[0][1], gBusinessAdvertisesCheckpoint[0][2], 1.0, -1, 10);
	return 1;
}

//------------------------------------------------------------------------------

/* *************************************************************************** *
*  Assignment: Called when a player enters a business.
*
*  Params:
*			playerid: ID of the player.
*			businessid: ID of business.
*
*  Returns:
*			-
* *************************************************************************** */
public OnPlayerEnterBusiness(playerid, businessid)
{
	new b = GetPlayerVirtualWorld(playerid);
	if(GetBusinessProducts(b) > 0)
	{
		if(GetPVarFloat(playerid, "current_cp_pos_x") != 0.0)
		{
			SetPVarFloat(playerid, "old_cp_pos_x", GetPVarFloat(playerid, "current_cp_pos_x"));
			SetPVarFloat(playerid, "old_cp_pos_y", GetPVarFloat(playerid, "current_cp_pos_y"));
			SetPVarFloat(playerid, "old_cp_pos_z", GetPVarFloat(playerid, "current_cp_pos_z"));
			SetPVarFloat(playerid, "old_cp_size", GetPVarFloat(playerid, "current_cp_size"));
			SetPVarInt(playerid, "old_cp_id", GetPVarInt(playerid, "current_cp_id"));
		}
	}
	else
	{
		SendClientMessage(playerid, COLOR_ERROR, "* Desculpe, mas estamos sem produtos.");
	}
	return 1;
}

/* *************************************************************************** *
*  Assignment: Called when a player exits a business.
*
*  Params:
*			playerid: ID of the player.
*			businessid: ID of business.
*
*  Returns:
*			-
* *************************************************************************** */
public OnPlayerExitBusiness(playerid, businessid)
{
	if(GetPVarFloat(playerid, "old_cp_pos_y") != 0.0)
	{
		new
			Float:x = GetPVarFloat(playerid, "old_cp_pos_x"),
			Float:y = GetPVarFloat(playerid, "old_cp_pos_y"),
			Float:z = GetPVarFloat(playerid, "old_cp_pos_z"),
			Float:size = GetPVarFloat(playerid, "old_cp_size"),
			cpid = GetPVarInt(playerid, "old_cp_id");

		SetPlayerRaceCheckpoint(playerid, 1, x, y, z, 0.0, 0.0, 0.0, size);
		SetPlayerCPID(playerid, CHECKPOINT:cpid);

		DeletePVar(playerid, "old_cp_pos_x");
		DeletePVar(playerid, "old_cp_pos_y");
		DeletePVar(playerid, "old_cp_pos_z");
		DeletePVar(playerid, "old_cp_size");
		DeletePVar(playerid, "old_cp_id");
	}
	return 1;
}

//------------------------------------------------------------------------------

public OnPlayerModelSelection(playerid, response, listid, modelid)
{
	if(listid == maleskinlist || listid == femaleskinlist)
	{
		if(response)
		{
			SendClientMessagef(playerid, COLOR_SUCCESS, "* Você comprou uma nova roupa. (-$%i)", CLOTHES_PRICE);
			SetSpawnInfo(playerid, 255, modelid, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 0, 0);
			SetPlayerSkin(playerid, modelid, true);
			GivePlayerCash(playerid, -CLOTHES_PRICE);

			new b = GetPlayerVirtualWorld(playerid);
			SetBusinessTill(b, GetBusinessTill(b) + 100);
			SetBusinessProducts(b, GetBusinessProducts(b) - 1);
			ApplyAnimation(playerid, "CLOTHES", "CLO_Buy", 4.1, 0, 1, 1, 0, 0);
		}
		SetCameraBehindPlayer(playerid);
		return 1;
	}
	return 1;
}

//------------------------------------------------------------------------------

/* *************************************************************************** *
*  Assignment: Called when a player enters a checkpoint.
*
*  Params:
*			playerid: ID of playerid.
*
*  Returns:
*			-
* *************************************************************************** */
hook OnPlayerEnterDynamicCP(playerid, STREAMER_TAG_CP checkpointid)
{
	if(checkpointid == gBusinessStoreCheckpointID[0] || checkpointid == gBusinessStoreCheckpointID[1] || checkpointid == gBusinessStoreCheckpointID[2] ||
		checkpointid == gBusinessStoreCheckpointID[3] || checkpointid == gBusinessStoreCheckpointID[4] || checkpointid == gBusinessStoreCheckpointID[5])
	{
		new b = GetPlayerVirtualWorld(playerid);
		if(GetBusinessProducts(b) > 0)
		{
			PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);

			if(GetPlayerInterior(playerid) == 6)
			{
				SetPlayerCameraPos(playerid, -27.0071, -57.3524, 1005.4188);
				SetPlayerCameraLookAt(playerid, -26.0568, -57.0456, 1004.8592, CAMERA_MOVE);
				SetPlayerFacingAngle(playerid, 176.7691);
			}
			else if(GetPlayerInterior(playerid) == 16)
			{
				SetPlayerCameraPos(playerid, -24.8320, -141.5290, 1005.0829);
				SetPlayerCameraLookAt(playerid, -24.0691, -140.8846, 1004.6730, CAMERA_MOVE);
				SetPlayerFacingAngle(playerid, 175.7383);
			}
			else if(GetPlayerInterior(playerid) == 18)
			{
				SetPlayerCameraPos(playerid, -30.8943, -91.7713, 1005.0585);
				SetPlayerCameraLookAt(playerid, -30.0576, -91.2261, 1004.6835, CAMERA_MOVE);
				SetPlayerFacingAngle(playerid, 178.0717);
			}
			else if(GetPlayerInterior(playerid) == 4)
			{
				SetPlayerCameraPos(playerid, -27.5923, -31.6429, 1005.4991);
				SetPlayerCameraLookAt(playerid, -28.3867, -31.0378, 1004.8792, CAMERA_MOVE);
				SetPlayerFacingAngle(playerid, 178.0717);
			}
			else if(GetPlayerInterior(playerid) == 17)
			{
				SetPlayerCameraPos(playerid, -25.5656, -188.0256, 1005.6638);
				SetPlayerCameraLookAt(playerid, -26.3457, -187.4022, 1005.0290, CAMERA_MOVE);
				SetPlayerFacingAngle(playerid, 178.0717);
			}

			new listitems[178];
			format(listitems, sizeof listitems, "1.\tGPS\t\t\t$%i\n2.\tWalkie Talkie\t\t$%i\n3.\tCigarros\t\t\t$%i\n4.\tIsqueiro\t\t\t$%i\n5.\tSpray de Pimenta\t\t$%i\n6.\tAgenda Telefonica\t\t$%i", ITEM_GPS_PRICE, ITEM_WALKIE_TALKIE_PRICE, ITEM_CIGARETTS_PRICE, ITEM_LIGHTER_PRICE, ITEM_SPRAY_PRICE, ITEM_AGENDA_PRICE);
			ShowPlayerDialog(playerid, DIALOG_STORE, DIALOG_STYLE_LIST, gBusinessData[b][E_BUSINESS_NAME], listitems, "Comprar", "Cancelar");
			return 1;
		}
		else
		{
			PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_ERROR, "* Desculpe, mas estamos sem produtos.");
			return 1;
		}
	}
	else if(checkpointid == gBusinessClothesCheckpointID[0] || checkpointid == gBusinessClothesCheckpointID[1] || checkpointid == gBusinessClothesCheckpointID[2] ||
		 checkpointid == gBusinessClothesCheckpointID[3] || checkpointid == gBusinessClothesCheckpointID[4])
	{
		new b = GetPlayerVirtualWorld(playerid);
		if(GetBusinessProducts(b) > 0)
		{
			if(GetPlayerCash(playerid) < CLOTHES_PRICE)
			{
				SendClientMessagef(playerid, COLOR_ERROR, "* Você não possui dinheiro suficiente. [$%i]", CLOTHES_PRICE);
				return 1;
			}

			if(GetPlayerInterior(playerid) == 15)
			{
				SetPlayerCameraPos(playerid, 207.2263, -100.2974, 1005.4888);
				SetPlayerCameraLookAt(playerid, 207.2356, -99.2989, 1005.5842, CAMERA_MOVE);
			}
			else if(GetPlayerInterior(playerid) == 18)
			{
				SetPlayerCameraPos(playerid, 161.3240, -83.1676, 1002.0452);
				SetPlayerCameraLookAt(playerid, 161.3053, -82.1692, 1002.0804, CAMERA_MOVE);
			}
			else if(GetPlayerInterior(playerid) == 3)
			{
				SetPlayerCameraPos(playerid, 206.9843, -128.7801, 1003.7091);
				SetPlayerCameraLookAt(playerid, 207.0197, -127.7822, 1003.8792, CAMERA_MOVE);
			}
			else if(GetPlayerInterior(playerid) == 5)
			{
				SetPlayerCameraPos(playerid, 206.2719, -8.1154, 1001.3513);
				SetPlayerCameraLookAt(playerid, 205.2744, -8.1632, 1001.6419, CAMERA_MOVE);
			}
			else if(GetPlayerInterior(playerid) == 1)
			{
				SetPlayerCameraPos(playerid, 203.6564, -43.5176, 1002.1565);
				SetPlayerCameraLookAt(playerid, 203.6697, -42.5191, 1002.3218, CAMERA_MOVE);
			}

			PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
			new gender = GetPlayerGender(playerid);
			ShowModelSelectionMenu(playerid, (gender) ? femaleskinlist : maleskinlist, "Selecione a roupa", 0x00000046, (gender) ? 0xF5C0FF99 : 0x6FA3FF99, (gender) ? 0xFEE1FEAA : 0x9ABEFFAA);
			return 1;
		}
		else
		{
			PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_ERROR, "* Desculpe, mas estamos sem produtos.");
			return 1;
		}
	}
	else if(checkpointid == gBusinessBurgerCheckpointID)
	{
		new b = GetPlayerVirtualWorld(playerid);
		if(GetBusinessProducts(b) > 0)
		{
			PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
			SetPlayerCameraPos(playerid, 375.5232, -66.6764, 1001.9573);
			SetPlayerCameraLookAt(playerid, 376.2906, -66.0374, 1001.9174, CAMERA_MOVE);
			new listitems[128];
			format(listitems, sizeof listitems, "1.\tLanche Infantil\t\t$%i\n2.\tLanche Medio\t\t$%i\n3.\tLanche Grande\t\t$%i\n4.\tLanche Gigante\t$%i", ITEM_HAMBURGER_ONE_PRICE, ITEM_HAMBURGER_TWO_PRICE, ITEM_HAMBURGER_THREE_PRICE, ITEM_HAMBURGER_FOUR_PRICE);
			ShowPlayerDialog(playerid, DIALOG_BURGER, DIALOG_STYLE_LIST, gBusinessData[b][E_BUSINESS_NAME], listitems, "Comprar", "Cancelar");
			return 1;
		}
		else
		{
			PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_ERROR, "* Desculpe, mas estamos sem produtos.");
			return 1;
		}
	}
	else if(checkpointid == gBusinessCluckinCheckpointID)
	{
		new b = GetPlayerVirtualWorld(playerid);
		if(GetBusinessProducts(b) > 0)
		{
			PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
			SetPlayerCameraPos(playerid, 370.3350, -6.3950, 1002.2250);
			SetPlayerCameraLookAt(playerid, 370.3508, -5.3965, 1002.3049, CAMERA_MOVE);
			new listitems[128];
			format(listitems, sizeof listitems, "1.\tFrango Infantil\t\t$%i\n2.\tFrango Frito\t\t$%i\n3.\tFrango Assado\t\t$%i\n4.\tFrango Especial\t$%i", ITEM_CLUCKIN_PRICE_1, ITEM_CLUCKIN_PRICE_2, ITEM_CLUCKIN_PRICE_3, ITEM_CLUCKIN_PRICE_4);
			ShowPlayerDialog(playerid, DIALOG_CLUCKIN, DIALOG_STYLE_LIST, gBusinessData[b][E_BUSINESS_NAME], listitems, "Comprar", "Cancelar");
			return 1;
		}
		else
		{
			PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_ERROR, "* Desculpe, mas estamos sem produtos.");
			return 1;
		}
	}
	else if(checkpointid == gBusinessPizzaCheckpointID)
	{
		new b = GetPlayerVirtualWorld(playerid);
		if(GetBusinessProducts(b) > 0)
		{
			PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
			SetPlayerCameraPos(playerid, 373.5728, -118.4776, 1001.8399);
			SetPlayerCameraLookAt(playerid, 373.0085, -117.6538, 1001.8204, CAMERA_MOVE);
			new listitems[128];
			format(listitems, sizeof listitems, "1.\tFatia de Pizza\t\t$%i\n2.\t1/4 de Pizza\t\t$%i\n3.\t1/2 Pizza\t\t$%i\n4.\tPizza Inteira\t\t$%i", ITEM_PIZZA_PRICE_1, ITEM_PIZZA_PRICE_2, ITEM_PIZZA_PRICE_3, ITEM_PIZZA_PRICE_4);
			ShowPlayerDialog(playerid, DIALOG_PIZZA, DIALOG_STYLE_LIST, gBusinessData[b][E_BUSINESS_NAME], listitems, "Comprar", "Cancelar");
			return 1;
		}
		else
		{
			PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_ERROR, "* Desculpe, mas estamos sem produtos.");
			return 1;
		}
	}
	else if(checkpointid == gBusinessRestaurantCheckpointID[0])
	{
		new b = GetPlayerVirtualWorld(playerid);
		if(GetBusinessProducts(b) > 0)
		{
			PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
			SetPlayerCameraPos(playerid, 380.1041, -189.6649, 1001.1133);
			SetPlayerCameraLookAt(playerid, 381.0303, -189.2913, 1000.9438, CAMERA_MOVE);

			new listitems[128];
			format(listitems, sizeof listitems, "1.\tDonut\t\t\t\t$%i\n2.\tPorção de Donuts\t\t$%i\n3.\tCaixa de Donuts\t\t$%i\n4.\tDonuts Familia\t\t\t$%i", ITEM_DONUT_PRICE_1, ITEM_DONUT_PRICE_2, ITEM_DONUT_PRICE_3, ITEM_DONUT_PRICE_4);
			ShowPlayerDialog(playerid, DIALOG_DONUT, DIALOG_STYLE_LIST, gBusinessData[b][E_BUSINESS_NAME], listitems, "Comprar", "Cancelar");
			return 1;
		}
		else
		{
			PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_ERROR, "* Desculpe, mas estamos sem produtos.");
			return 1;
		}
	}
	else if(checkpointid == gBusinessRestaurantCheckpointID[1])
	{
		new b = GetPlayerVirtualWorld(playerid);
		if(GetBusinessProducts(b) > 0)
		{
			PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
			if(GetPlayerInterior(playerid) == 4)
			{
				SetPlayerCameraPos(playerid, 450.2831, -83.1952, 999.7273);
				SetPlayerCameraLookAt(playerid, 449.5947, -82.4719, 999.8727, CAMERA_MOVE);
			}
			new listitems[128];
			format(listitems, sizeof listitems, "1.\tRefeição basica\t$%i\n2.\tRefeição pequena\t$%i\n3.\tRefeição média\t$%i\n4.\tRefeição completa\t$%i", ITEM_RESTAURANT_PRICE_1, ITEM_RESTAURANT_PRICE_2, ITEM_RESTAURANT_PRICE_3, ITEM_RESTAURANT_PRICE_4);
			ShowPlayerDialog(playerid, DIALOG_RESTAURANT, DIALOG_STYLE_LIST, gBusinessData[b][E_BUSINESS_NAME], listitems, "Comprar", "Cancelar");
			return 1;
		}
		else
		{
			PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_ERROR, "* Desculpe, mas estamos sem produtos.");
			return 1;
		}
	}
	else if(checkpointid == gBusinessAdvertisesCheckpointID)
	{
		new b = GetPlayerVirtualWorld(playerid);
		if(GetBusinessProducts(b) > 0)
		{
			PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
			SetPlayerCameraPos(playerid, 222.9516, 107.3922, 1003.1736);
			SetPlayerCameraLookAt(playerid, 223.6406, 108.1151, 1003.1945, CAMERA_MOVE);
			new listitems[128];
			format(listitems, sizeof listitems, "O que você deseja anunciar?\nPreço: $%i por letra.", ADVERTISE_PRICE_PER_LETTER);
			ShowPlayerDialog(playerid, DIALOG_ADVERTISE, DIALOG_STYLE_INPUT, gBusinessData[b][E_BUSINESS_NAME], listitems, "Anunciar", "Cancelar");
			return 1;
		}
		else
		{
			PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_ERROR, "* Desculpe, mas estamos sem produtos.");
			return 1;
		}
	}
	else if(checkpointid == gBusinessPhoneCheckpointID)
	{
		new b = GetPlayerVirtualWorld(playerid);
		if(GetBusinessProducts(b) > 0)
		{
			PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
			SetPlayerCameraPos(playerid, 2164.5103, 1602.6633, 999.9777);
			SetPlayerCameraLookAt(playerid, 2165.4812, 1602.8905, 999.8538, CAMERA_MOVE);
			new listitems[128];
			format(listitems, sizeof listitems, "1.\tComprar celular\t$%i\n2.\tComprar creditos", PHONE_PRICE);
			ShowPlayerDialog(playerid, DIALOG_PHONE, DIALOG_STYLE_LIST, gBusinessData[b][E_BUSINESS_NAME], listitems, "Comprar", "Cancelar");
			return 1;
		}
		else
		{
			PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_ERROR, "* Desculpe, mas estamos sem produtos.");
			return 1;
		}
	}
	else if(checkpointid == gBusinessClubCheckpointID[0] || checkpointid == gBusinessClubCheckpointID[1] || checkpointid == gBusinessClubCheckpointID[2])
	{
		new b = GetPlayerVirtualWorld(playerid);
		if(GetBusinessProducts(b) > 0)
		{
			PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
			if(GetPlayerInterior(playerid) == 11)
			{
				SetPlayerCameraPos(playerid, 499.6945, -76.6519, 998.8717);
				SetPlayerCameraLookAt(playerid, 499.0761, -77.4361, 999.0717, CAMERA_MOVE);
			}
			else if(GetPlayerInterior(playerid) == 17)
			{
				SetPlayerCameraPos(playerid, 500.3352, -20.8465, 1000.8751);
				SetPlayerCameraLookAt(playerid, 501.2022, -20.3506, 1001.0704, CAMERA_MOVE);
			}
			else if(GetPlayerInterior(playerid) == 1)
			{
				SetPlayerCameraPos(playerid, 681.5732, -454.3299, -25.3677);
				SetPlayerCameraLookAt(playerid, 681.5938, -455.3282, -25.2428, CAMERA_MOVE);
			}
			new listitems[128];
			format(listitems, sizeof listitems, "1.\tChampagne \t$%i\n2.\tVodka\t\t$%i\n3.\tWhisky\t\t$%i\n4.\tAgua\t\t$%i", CHAMPAGNE_PRICE, VODKA_PRICE, WHISKY_PRICE, WATER_PRICE);
			ShowPlayerDialog(playerid, DIALOG_CLUB, DIALOG_STYLE_LIST, gBusinessData[b][E_BUSINESS_NAME], listitems, "Comprar", "Cancelar");
			return 1;
		}
		else
		{
			PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_ERROR, "* Desculpe, mas estamos sem produtos.");
			return 1;
		}
	}
	else if(checkpointid == gBusinessAmmuCheckpointID[0])
	{
		new b = GetPlayerVirtualWorld(playerid);
		if(GetBusinessProducts(b) > 0)
		{
			PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
			if(GetPlayerInterior(playerid) == 7)
			{
				SetPlayerCameraPos(playerid, 308.7108, -141.7872, 999.8026);
				SetPlayerCameraLookAt(playerid, 308.2343, -142.6647, 1000.1074, CAMERA_MOVE);
			}
			ShowPlayerDialog(playerid, DIALOG_AMMU, DIALOG_STYLE_LIST, gBusinessData[b][E_BUSINESS_NAME], "Arma\nMunição", "Selecionar", "Cancelar");
			return 1;
		}
		else
		{
			PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_ERROR, "* Desculpe, mas estamos sem produtos.");
			return 1;
		}
	}
	return 1;
}
/* *************************************************************************** *
*  Assignment: Called when a player picks a pickup.
*
*  Params:
*			playerid: ID of playerid.
*			pickupid: ID of pickup.
*
*  Returns:
*			-
* *************************************************************************** */
hook OnPlayerPickUpDynPickup(playerid, pickupid)
{
    if(GetPVarInt(playerid, "PickupDelay") > 0)
        return 1;

	foreach(new b: Business)
	{
		if(pickupid == gBusinessData[b][E_BUSINESS_PICKUP])
		{
			if(GetPlayerVirtualWorld(playerid) == gBusinessData[b][E_BUSINESS_ENTERWORLD] && GetPVarInt(playerid, "gptIsVisible") == 0)
			{
				ShowPlayerBusinessTD(playerid, b);
				SetPVarInt(playerid, "gptIsVisible", 1);
				return 1;
			}
		}
		else if(pickupid == gBusinessData[b][E_BUSINESS_PICKUP_EXIT])
		{
			if(GetPlayerVirtualWorld(playerid) == b)
			{
				SetPlayerPos(playerid, gBusinessData[b][E_BUSINESS_ENTERX], gBusinessData[b][E_BUSINESS_ENTERY], gBusinessData[b][E_BUSINESS_ENTERZ]);
				SetPlayerFacingAngle(playerid, gBusinessData[b][E_BUSINESS_ENTERA]);
				SetPlayerInterior(playerid, gBusinessData[b][E_BUSINESS_ENTERINT]);
				SetPlayerVirtualWorld(playerid, gBusinessData[b][E_BUSINESS_ENTERWORLD]);
				SetPVarInt(playerid, "PickupDelay", PICKUP_DELAY);

				SetCameraBehindPlayer(playerid);

				OnPlayerExitBusiness(playerid, b);
				return 1;
			}
		}
	}
	return 1;
}

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
		case DIALOG_STORE:
		{
			if(!response)
			{
				PlayerPlaySound(playerid, 1084, 0.0, 0.0, 0.0);
				SetCameraBehindPlayer(playerid);
				return 1;
			}
			foreach(new b: Business)
			{
				if(IsPlayerInBusiness(playerid, b, 25.0))
				{
					if(gBusinessData[b][E_BUSINESS_TYPE] == 1)
					{
						if(gBusinessData[b][E_BUSINESS_PRODUCTS] > 0)
						{
							switch(listitem)
							{
								case 0: // GPS
								{
									if(GetPlayerGPS(playerid) > gettime())
									{
										SendClientMessage(playerid, COLOR_ERROR, "* Você já possui um GPS.");
										SetCameraBehindPlayer(playerid);
										return 1;
									}

									if(GetPlayerCash(playerid) < ITEM_GPS_PRICE)
									{
										PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
										SendClientMessage(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiente.");
										SetCameraBehindPlayer(playerid);
										return 1;
									}

									PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);

									SendClientMessage(playerid, COLOR_SUCCESS, "* Você comprou um GPS. (/gps)");
									SendClientActionMessage(playerid, 15.0, "pagou para a empresa e recebeu um item em troca.");

									GivePlayerCash(playerid, -ITEM_GPS_PRICE);
									SetPlayerGPS(playerid, (gettime() + 604800));
									ShowPlayerGPS(playerid);

									SetBusinessProducts(b, GetBusinessProducts(b) - 1);
									SetBusinessTill(b, GetBusinessTill(b) + ITEM_GPS_PRICE);
								}
								case 1: // Walkie Talkie
								{
									if(GetPlayerWalkieTalkieFrequency(playerid) > 0)
									{
										SendClientMessage(playerid, COLOR_ERROR, "* Você já possui um WalkieTalkie.");
										SetCameraBehindPlayer(playerid);
										return 1;
									}

									if(GetPlayerCash(playerid) < ITEM_WALKIE_TALKIE_PRICE)
									{
										PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
										SendClientMessage(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiente.");
										SetCameraBehindPlayer(playerid);
										return 1;
									}

									PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);

									SendClientMessage(playerid, COLOR_SUCCESS, "* Você comprou um Walkie Talkie. (/ajudawalkie)");
									SendClientActionMessage(playerid, 15.0, "pagou para a empresa e recebeu um item em troca.");

									GivePlayerCash(playerid, -ITEM_WALKIE_TALKIE_PRICE);
									SetPlayerWalkieTalkieFrequency(playerid, 1000);

									SetBusinessProducts(b, GetBusinessProducts(b) - 1);
									SetBusinessTill(b, GetBusinessTill(b) + ITEM_WALKIE_TALKIE_PRICE);
								}
								case 2: // CIGARETTS
								{
									if(GetPlayerCigaretts(playerid) > 50)
									{
										SendClientMessage(playerid, COLOR_ERROR, "* Você não pode carregar mais cigarros.");
										SetCameraBehindPlayer(playerid);
										return 1;
									}

									if(GetPlayerCash(playerid) < ITEM_CIGARETTS_PRICE)
									{
										PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
										SendClientMessage(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiente.");
										SetCameraBehindPlayer(playerid);
										return 1;
									}

									PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);

									SendClientMessage(playerid, COLOR_SUCCESS, "* Você comprou um maço de cigarro. (/fumar)");
									SendClientActionMessage(playerid, 15.0, "pagou para a empresa e recebeu um item em troca.");

									GivePlayerCash(playerid, -ITEM_CIGARETTS_PRICE);
									SetPlayerCigaretts(playerid, GetPlayerCigaretts(playerid) + 5);

									SetBusinessProducts(b, GetBusinessProducts(b) - 1);
									SetBusinessTill(b, GetBusinessTill(b) + ITEM_CIGARETTS_PRICE);
								}
								case 3: // Lighter
								{
									if(GetPlayerLighter(playerid) > 1)
									{
										PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
										SendClientMessage(playerid, COLOR_ERROR, "* Você já possui um isqueiro.");
										SetCameraBehindPlayer(playerid);
										return 1;
									}

									if(GetPlayerCash(playerid) < ITEM_LIGHTER_PRICE)
									{
										PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
										SendClientMessage(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiente.");
										SetCameraBehindPlayer(playerid);
										return 1;
									}

									PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);

									SendClientMessage(playerid, COLOR_SUCCESS, "* Você comprou um isqueiro. (/fumar)");
									SendClientActionMessage(playerid, 15.0, "pagou para a empresa e recebeu um item em troca.");

									GivePlayerCash(playerid, -ITEM_LIGHTER_PRICE);
									SetPlayerLighter(playerid, 30 + random(10));

									SetBusinessProducts(b, GetBusinessProducts(b) - 1);
									SetBusinessTill(b, GetBusinessTill(b) + ITEM_LIGHTER_PRICE);
								}
								case 4: // Spray de pimenta
								{
									new weaponid, ammo;
									GetPlayerWeaponData(playerid, 9, weaponid, ammo);
									if(weaponid == 41 && ammo > 50)
									{
										SendClientMessage(playerid, COLOR_ERROR, "* Você não pode carregar mais sprays de pimenta.");
										PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
										SetCameraBehindPlayer(playerid);
										return 1;
									}

									if(GetPlayerCash(playerid) < ITEM_SPRAY_PRICE)
									{
										SendClientMessage(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiente.");
										PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
										SetCameraBehindPlayer(playerid);
										return 1;
									}

									PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);

									SendClientMessage(playerid, COLOR_SUCCESS, "* Você comprou um spray de pimenta.");
									SendClientActionMessage(playerid, 15.0, "pagou para a empresa e recebeu um item em troca.");

									GivePlayerCash(playerid, -ITEM_SPRAY_PRICE);
									GivePlayerWeapon(playerid, 41, 5);

									SetBusinessProducts(b, GetBusinessProducts(b) - 1);
									SetBusinessTill(b, GetBusinessTill(b) + ITEM_SPRAY_PRICE);
								}
								case 5: // Agenda Telefonica
								{
									if(GetPlayerAgenda(playerid) > gettime())
									{
										SendClientMessage(playerid, COLOR_ERROR, "* Você já tem uma agenda.");
										PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
										SetCameraBehindPlayer(playerid);
										return 1;
									}

									if(GetPlayerCash(playerid) < ITEM_AGENDA_PRICE)
									{
										SendClientMessage(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiente.");
										PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
										SetCameraBehindPlayer(playerid);
										return 1;
									}

									PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);

									SendClientMessage(playerid, COLOR_SUCCESS, "* Você comprou uma agenda telefonica. (/telefone [jogador])");
									SendClientActionMessage(playerid, 15.0, "pagou para a empresa e recebeu um item em troca.");

									SetPlayerAgenda(playerid, (gettime() + 654800));
									GivePlayerCash(playerid, -ITEM_AGENDA_PRICE);

									SetBusinessProducts(b, GetBusinessProducts(b) - 1);
									SetBusinessTill(b, GetBusinessTill(b) + ITEM_AGENDA_PRICE);
								}
							}
							new listitems[168];
							format(listitems, sizeof(listitems), "1.\tGPS\t\t\t$%i\n2.\tWalkie Talkie\t\t$%i\n3.\tCigarros\t\t\t$%i\n4.\tIsqueiro\t\t\t$%i\n5.\tSpray de Pimenta\t\t$%i\n6.\tAgenda Telefonica\t\t$%i", ITEM_GPS_PRICE, ITEM_WALKIE_TALKIE_PRICE, ITEM_CIGARETTS_PRICE, ITEM_LIGHTER_PRICE, ITEM_SPRAY_PRICE, ITEM_AGENDA_PRICE);
							ShowPlayerDialog(playerid, DIALOG_STORE, DIALOG_STYLE_LIST, gBusinessData[b][E_BUSINESS_NAME], listitems, "Comprar", "Cancelar");
						}
						else
						{
							PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
							SendClientMessage(playerid, COLOR_ERROR, "* Desculpe, mas estamos sem produtos.");
							SetCameraBehindPlayer(playerid);
						}
					}
				}
			}
		}
		case DIALOG_BURGER:
		{
			if(!response)
			{
				PlayerPlaySound(playerid, 1084, 0.0, 0.0, 0.0);
				SetCameraBehindPlayer(playerid);
				return 1;
			}
			foreach(new b: Business)
			{
				if(IsPlayerInBusiness(playerid, b, 25.0))
				{
					if(gBusinessData[b][E_BUSINESS_TYPE] == BUSINESS_TYPE_BURGER)
					{
						if(gBusinessData[b][E_BUSINESS_PRODUCTS] > 0)
						{
							switch(listitem)
							{
								case 0:
								{
									if(GetPlayerCash(playerid) < ITEM_HAMBURGER_ONE_PRICE)
									{
										PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
										SendClientMessage(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiente.");
										SetCameraBehindPlayer(playerid);
										return 1;
									}

									PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
									SendClientMessage(playerid, COLOR_SUCCESS, "* Você comprou um hamburger infantil.");
									SendClientActionMessage(playerid, 15.0, "comeu um hamburger infantil.");

									SetPlayerHunger(playerid, GetPlayerHunger(playerid) + 10.0);
									SetPlayerHealthEx(playerid, GetPlayerHealthf(playerid) + 10.0);

									GivePlayerCash(playerid, -ITEM_HAMBURGER_ONE_PRICE);

									SetBusinessProducts(b, GetBusinessProducts(b) - 1);
									SetBusinessTill(b, GetBusinessTill(b) + ITEM_HAMBURGER_ONE_PRICE);
								}
								case 1:
								{
									if(GetPlayerCash(playerid) < ITEM_HAMBURGER_TWO_PRICE)
									{
										PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
										SendClientMessage(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiente.");
										SetCameraBehindPlayer(playerid);
										return 1;
									}

									PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
									SendClientMessage(playerid, COLOR_SUCCESS, "* Você comprou um hamburger medio.");
									SendClientActionMessage(playerid, 15.0, "comeu um hamburger medio.");

									SetPlayerHunger(playerid, GetPlayerHunger(playerid) + 25.0);
									SetPlayerHealthEx(playerid, GetPlayerHealthf(playerid) + 20.0);

									GivePlayerCash(playerid, -ITEM_HAMBURGER_TWO_PRICE);

									SetBusinessProducts(b, GetBusinessProducts(b) - 1);
									SetBusinessTill(b, GetBusinessTill(b) + ITEM_HAMBURGER_TWO_PRICE);
								}
								case 2:
								{
									if(GetPlayerCash(playerid) < ITEM_HAMBURGER_THREE_PRICE)
									{
										PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
										SendClientMessage(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiente.");
										SetCameraBehindPlayer(playerid);
										return 1;
									}

									PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
									SendClientMessage(playerid, COLOR_SUCCESS, "* Você comprou um hamburger grande.");
									SendClientActionMessage(playerid, 15.0, "comeu um hamburger grande.");

									SetPlayerHunger(playerid, GetPlayerHunger(playerid) + 50.0);
									SetPlayerHealthEx(playerid, GetPlayerHealthf(playerid) + 30.0);

									GivePlayerCash(playerid, -ITEM_HAMBURGER_THREE_PRICE);

									SetBusinessProducts(b, GetBusinessProducts(b) - 1);
									SetBusinessTill(b, GetBusinessTill(b) + ITEM_HAMBURGER_THREE_PRICE);
								}
								case 3:
								{
									if(GetPlayerCash(playerid) < ITEM_HAMBURGER_FOUR_PRICE)
									{
										PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
										SendClientMessage(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiente.");
										SetCameraBehindPlayer(playerid);
										return 1;
									}

									PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
									SendClientMessage(playerid, COLOR_SUCCESS, "* Você comprou um hamburger gigante.");
									SendClientActionMessage(playerid, 15.0, "comeu um hamburger gigante.");

									SetPlayerHunger(playerid, GetPlayerHunger(playerid) + 75.0);
									SetPlayerHealthEx(playerid, GetPlayerHealthf(playerid) + 50.0);

									GivePlayerCash(playerid, -ITEM_HAMBURGER_FOUR_PRICE);

									SetBusinessProducts(b, GetBusinessProducts(b) - 1);
									SetBusinessTill(b, GetBusinessTill(b) + ITEM_HAMBURGER_FOUR_PRICE);
								}
							}
							new listitems[128];
							format(listitems, sizeof listitems, "1.\tLanche Infantil\t\t$%i\n2.\tLanche Medio\t\t$%i\n3.\tLanche Grande\t\t$%i\n4.\tLanche Gigante\t$%i", ITEM_HAMBURGER_ONE_PRICE, ITEM_HAMBURGER_TWO_PRICE, ITEM_HAMBURGER_THREE_PRICE, ITEM_HAMBURGER_FOUR_PRICE);
							ShowPlayerDialog(playerid, DIALOG_BURGER, DIALOG_STYLE_LIST, gBusinessData[b][E_BUSINESS_NAME], listitems, "Comprar", "Cancelar");
							ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4.1, 0, 1, 1, 0, 0);
						}
						else
						{
							PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
							SendClientMessage(playerid, COLOR_ERROR, "* Desculpe, mas estamos sem produtos.");
							SetCameraBehindPlayer(playerid);
						}
					}
				}
			}
		}
		case DIALOG_CLUCKIN:
		{
			if(!response)
			{
				PlayerPlaySound(playerid, 1084, 0.0, 0.0, 0.0);
				SetCameraBehindPlayer(playerid);
				return 1;
			}
			foreach(new b: Business)
			{
				if(IsPlayerInBusiness(playerid, b, 25.0))
				{
					if(gBusinessData[b][E_BUSINESS_TYPE] == BUSINESS_TYPE_CLUCKIN)
					{
						if(gBusinessData[b][E_BUSINESS_PRODUCTS] > 0)
						{
							switch(listitem)
							{
								case 0:
								{
									if(GetPlayerCash(playerid) < ITEM_CLUCKIN_PRICE_1)
									{
										PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
										SendClientMessage(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiente.");
										SetCameraBehindPlayer(playerid);
										return 1;
									}

									PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
									SendClientMessage(playerid, COLOR_SUCCESS, "* Você comprou um frango infantil.");
									SendClientActionMessage(playerid, 15.0, "comeu um frango infantil.");

									SetPlayerHunger(playerid, GetPlayerHunger(playerid) + 10.0);
									SetPlayerHealthEx(playerid, GetPlayerHealthf(playerid) + 10.0);

									GivePlayerCash(playerid, -ITEM_CLUCKIN_PRICE_1);

									SetBusinessProducts(b, GetBusinessProducts(b) - 1);
									SetBusinessTill(b, GetBusinessTill(b) + ITEM_CLUCKIN_PRICE_1);
								}
								case 1:
								{
									if(GetPlayerCash(playerid) < ITEM_CLUCKIN_PRICE_2)
									{
										PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
										SendClientMessage(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiente.");
										SetCameraBehindPlayer(playerid);
										return 1;
									}

									PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
									SendClientMessage(playerid, COLOR_SUCCESS, "* Você comprou um frango frito.");
									SendClientActionMessage(playerid, 15.0, "comeu um frango frito.");

									SetPlayerHunger(playerid, GetPlayerHunger(playerid) + 25.0);
									SetPlayerHealthEx(playerid, GetPlayerHealthf(playerid) + 20.0);

									GivePlayerCash(playerid, -ITEM_CLUCKIN_PRICE_2);

									SetBusinessProducts(b, GetBusinessProducts(b) - 1);
									SetBusinessTill(b, GetBusinessTill(b) + ITEM_CLUCKIN_PRICE_2);
								}
								case 2:
								{
									if(GetPlayerCash(playerid) < ITEM_CLUCKIN_PRICE_3)
									{
										PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
										SendClientMessage(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiente.");
										SetCameraBehindPlayer(playerid);
										return 1;
									}

									PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
									SendClientMessage(playerid, COLOR_SUCCESS, "* Você comprou um frango assado.");
									SendClientActionMessage(playerid, 15.0, "comeu um frango assado.");

									SetPlayerHunger(playerid, GetPlayerHunger(playerid) + 50.0);
									SetPlayerHealthEx(playerid, GetPlayerHealthf(playerid) + 30.0);

									GivePlayerCash(playerid, -ITEM_CLUCKIN_PRICE_3);

									SetBusinessProducts(b, GetBusinessProducts(b) - 1);
									SetBusinessTill(b, GetBusinessTill(b) + ITEM_CLUCKIN_PRICE_3);
								}
								case 3:
								{
									if(GetPlayerCash(playerid) < ITEM_CLUCKIN_PRICE_4)
									{
										PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
										SendClientMessage(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiente.");
										SetCameraBehindPlayer(playerid);
										return 1;
									}

									PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
									SendClientMessage(playerid, COLOR_SUCCESS, "* Você comprou um frango especial.");
									SendClientActionMessage(playerid, 15.0, "comeu um frango especial.");

									SetPlayerHunger(playerid, GetPlayerHunger(playerid) + 75.0);
									SetPlayerHealthEx(playerid, GetPlayerHealthf(playerid) + 50.0);

									GivePlayerCash(playerid, -ITEM_CLUCKIN_PRICE_4);

									SetBusinessProducts(b, GetBusinessProducts(b) - 1);
									SetBusinessTill(b, GetBusinessTill(b) + ITEM_CLUCKIN_PRICE_4);
								}
							}
							new listitems[128];
							format(listitems, sizeof listitems, "1.\tFrango Infantil\t\t$%i\n2.\tFrango Frito\t\t$%i\n3.\tFrango Assado\t\t$%i\n4.\tFrango Especial\t$%i", ITEM_CLUCKIN_PRICE_1, ITEM_CLUCKIN_PRICE_2, ITEM_CLUCKIN_PRICE_3, ITEM_CLUCKIN_PRICE_4);
							ShowPlayerDialog(playerid, DIALOG_CLUCKIN, DIALOG_STYLE_LIST, gBusinessData[b][E_BUSINESS_NAME], listitems, "Comprar", "Cancelar");
							ApplyAnimation(playerid, "FOOD", "EAT_Chicken", 4.1, 0, 1, 1, 0, 0);
						}
						else
						{
							PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
							SendClientMessage(playerid, COLOR_ERROR, "* Desculpe, mas estamos sem produtos.");
							SetCameraBehindPlayer(playerid);
						}
					}
				}
			}
		}
		case DIALOG_PIZZA:
		{
			if(!response)
			{
				PlayerPlaySound(playerid, 1084, 0.0, 0.0, 0.0);
				SetCameraBehindPlayer(playerid);
				return 1;
			}
			foreach(new b: Business)
			{
				if(IsPlayerInBusiness(playerid, b, 25.0))
				{
					if(gBusinessData[b][E_BUSINESS_TYPE] == BUSINESS_TYPE_PIZZA)
					{
						if(gBusinessData[b][E_BUSINESS_PRODUCTS] > 0)
						{
							switch(listitem)
							{
								case 0:
								{
									if(GetPlayerCash(playerid) < ITEM_PIZZA_PRICE_1)
									{
										PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
										SendClientMessage(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiente.");

										new listitems[128];
										format(listitems, sizeof listitems, "1.\tFatia de Pizza\t\t$%i\n2.\t1/4 de Pizza\t\t$%i\n3.\t1/2 Pizza\t\t$%i\n4.\tPizza Inteira\t\t$%i", ITEM_PIZZA_PRICE_1, ITEM_PIZZA_PRICE_2, ITEM_PIZZA_PRICE_3, ITEM_PIZZA_PRICE_4);
										ShowPlayerDialog(playerid, DIALOG_PIZZA, DIALOG_STYLE_LIST, gBusinessData[b][E_BUSINESS_NAME], listitems, "Comprar", "Cancelar");
										return 1;
									}

									PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
									SendClientMessage(playerid, COLOR_SUCCESS, "* Você comprou uma fatia de pizza.");
									SendClientActionMessage(playerid, 15.0, "comeu uma fatia de pizza.");

									SetPlayerHunger(playerid, GetPlayerHunger(playerid) + 10.0);
									SetPlayerHealthEx(playerid, GetPlayerHealthf(playerid) + 10.0);

									GivePlayerCash(playerid, -ITEM_PIZZA_PRICE_1);

									SetBusinessProducts(b, GetBusinessProducts(b) - 1);
									SetBusinessTill(b, GetBusinessTill(b) + ITEM_PIZZA_PRICE_1);
								}
								case 1:
								{
									if(GetPlayerCash(playerid) < ITEM_PIZZA_PRICE_2)
									{
										PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
										SendClientMessage(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiente.");

										new listitems[128];
										format(listitems, sizeof listitems, "1.\tFatia de Pizza\t\t$%i\n2.\t1/4 de Pizza\t\t$%i\n3.\t1/2 Pizza\t\t$%i\n4.\tPizza Inteira\t\t$%i", ITEM_PIZZA_PRICE_1, ITEM_PIZZA_PRICE_2, ITEM_PIZZA_PRICE_3, ITEM_PIZZA_PRICE_4);
										ShowPlayerDialog(playerid, DIALOG_PIZZA, DIALOG_STYLE_LIST, gBusinessData[b][E_BUSINESS_NAME], listitems, "Comprar", "Cancelar");
										return 1;
									}

									PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
									SendClientMessage(playerid, COLOR_SUCCESS, "* Você comprou 1/4 de pizza.");
									SendClientActionMessage(playerid, 15.0, "comeu 1/4 de pizza.");

									SetPlayerHunger(playerid, GetPlayerHunger(playerid) + 25.0);
									SetPlayerHealthEx(playerid, GetPlayerHealthf(playerid) + 20.0);

									GivePlayerCash(playerid, -ITEM_PIZZA_PRICE_2);

									SetBusinessProducts(b, GetBusinessProducts(b) - 1);
									SetBusinessTill(b, GetBusinessTill(b) + ITEM_PIZZA_PRICE_2);
								}
								case 2:
								{
									if(GetPlayerCash(playerid) < ITEM_PIZZA_PRICE_3)
									{
										PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
										SendClientMessage(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiente.");

										new listitems[128];
										format(listitems, sizeof listitems, "1.\tFatia de Pizza\t\t$%i\n2.\t1/4 de Pizza\t\t$%i\n3.\t1/2 Pizza\t\t$%i\n4.\tPizza Inteira\t\t$%i", ITEM_PIZZA_PRICE_1, ITEM_PIZZA_PRICE_2, ITEM_PIZZA_PRICE_3, ITEM_PIZZA_PRICE_4);
										ShowPlayerDialog(playerid, DIALOG_PIZZA, DIALOG_STYLE_LIST, gBusinessData[b][E_BUSINESS_NAME], listitems, "Comprar", "Cancelar");
										return 1;
									}

									PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
									SendClientMessage(playerid, COLOR_SUCCESS, "* Você comprou metade de uma pizza.");
									SendClientActionMessage(playerid, 15.0, "comeu metade de uma pizza.");

									SetPlayerHunger(playerid, GetPlayerHunger(playerid)  + 50.0);
									SetPlayerHealthEx(playerid, GetPlayerHealthf(playerid) + 30.0);

									GivePlayerCash(playerid, -ITEM_PIZZA_PRICE_3);

									SetBusinessProducts(b, GetBusinessProducts(b) - 1);
									SetBusinessTill(b, GetBusinessTill(b) + ITEM_PIZZA_PRICE_3);
								}
								case 3:
								{
									if(GetPlayerCash(playerid) < ITEM_PIZZA_PRICE_4)
									{
										PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
										SendClientMessage(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiente.");

										new listitems[128];
										format(listitems, sizeof listitems, "1.\tFatia de Pizza\t\t$%i\n2.\t1/4 de Pizza\t\t$%i\n3.\t1/2 Pizza\t\t$%i\n4.\tPizza Inteira\t\t$%i", ITEM_PIZZA_PRICE_1, ITEM_PIZZA_PRICE_2, ITEM_PIZZA_PRICE_3, ITEM_PIZZA_PRICE_4);
										ShowPlayerDialog(playerid, DIALOG_PIZZA, DIALOG_STYLE_LIST, gBusinessData[b][E_BUSINESS_NAME], listitems, "Comprar", "Cancelar");
										return 1;
									}

									PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
									SendClientMessage(playerid, COLOR_SUCCESS, "* Você comprou uma pizza inteira.");
									SendClientActionMessage(playerid, 15.0, "comeu uma pizza inteira.");

									SetPlayerHunger(playerid, GetPlayerHunger(playerid) + 75.0);
									SetPlayerHealthEx(playerid, GetPlayerHealthf(playerid) + 50.0);

									GivePlayerCash(playerid, -ITEM_PIZZA_PRICE_4);

									SetBusinessProducts(b, GetBusinessProducts(b) - 1);
									SetBusinessTill(b, GetBusinessTill(b) + ITEM_PIZZA_PRICE_4);
								}
							}
							new listitems[128];
							format(listitems, sizeof listitems, "1.\tFatia de Pizza\t\t$%i\n2.\t1/4 de Pizza\t\t$%i\n3.\t1/2 Pizza\t\t$%i\n4.\tPizza Inteira\t\t$%i", ITEM_PIZZA_PRICE_1, ITEM_PIZZA_PRICE_2, ITEM_PIZZA_PRICE_3, ITEM_PIZZA_PRICE_4);
							ShowPlayerDialog(playerid, DIALOG_PIZZA, DIALOG_STYLE_LIST, gBusinessData[b][E_BUSINESS_NAME], listitems, "Comprar", "Cancelar");
							ApplyAnimation(playerid, "FOOD", "EAT_Pizza", 4.1, 0, 1, 1, 0, 0);
						}
						else
						{
							PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
							SendClientMessage(playerid, COLOR_ERROR, "* Desculpe, mas estamos sem produtos.");
							SetCameraBehindPlayer(playerid);
						}
					}
				}
			}
		}
		case DIALOG_DONUT:
		{
			if(!response)
			{
				PlayerPlaySound(playerid, 1084, 0.0, 0.0, 0.0);
				SetCameraBehindPlayer(playerid);
				return 1;
			}
			foreach(new b: Business)
			{
				if(IsPlayerInBusiness(playerid, b, 25.0))
				{
					if(gBusinessData[b][E_BUSINESS_TYPE] == BUSINESS_TYPE_RESTAURANT)
					{
						if(gBusinessData[b][E_BUSINESS_PRODUCTS] > 0)
						{
							switch(listitem)
							{
								case 0:
								{
									if(GetPlayerCash(playerid) < ITEM_DONUT_PRICE_1)
									{
										PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
										SendClientMessage(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiente.");

										new listitems[128];
										format(listitems, sizeof listitems, "1.\tDonut\t\t\t\t$%i\n2.\tPorção de Donuts\t\t$%i\n3.\tCaixa de Donuts\t\t$%i\n4.\tDonuts Familia\t\t\t$%i", ITEM_DONUT_PRICE_1, ITEM_DONUT_PRICE_2, ITEM_DONUT_PRICE_3, ITEM_DONUT_PRICE_4);
										ShowPlayerDialog(playerid, DIALOG_DONUT, DIALOG_STYLE_LIST, gBusinessData[b][E_BUSINESS_NAME], listitems, "Comprar", "Cancelar");
										return 1;
									}

									PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
									SendClientMessage(playerid, COLOR_SUCCESS, "* Você comprou um donut.");
									SendClientActionMessage(playerid, 15.0, "comeu um donut.");

									SetPlayerHunger(playerid, GetPlayerHunger(playerid) + 10.0);
									SetPlayerHealthEx(playerid, GetPlayerHealthf(playerid) + 10.0);

									GivePlayerCash(playerid, -ITEM_DONUT_PRICE_1);

									SetBusinessProducts(b, GetBusinessProducts(b) - 1);
									SetBusinessTill(b, GetBusinessTill(b) + ITEM_DONUT_PRICE_1);

									new listitems[128];
									format(listitems, sizeof listitems, "1.\tDonut\t\t\t\t$%i\n2.\tPorção de Donuts\t\t$%i\n3.\tCaixa de Donuts\t\t$%i\n4.\tDonuts Familia\t\t\t$%i", ITEM_DONUT_PRICE_1, ITEM_DONUT_PRICE_2, ITEM_DONUT_PRICE_3, ITEM_DONUT_PRICE_4);
									ShowPlayerDialog(playerid, DIALOG_DONUT, DIALOG_STYLE_LIST, gBusinessData[b][E_BUSINESS_NAME], listitems, "Comprar", "Cancelar");
								}
								case 1:
								{
									if(GetPlayerCash(playerid) < ITEM_DONUT_PRICE_2)
									{
										PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
										SendClientMessage(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiente.");

										new listitems[128];
										format(listitems, sizeof listitems, "1.\tDonut\t\t\t\t$%i\n2.\tPorção de Donuts\t\t$%i\n3.\tCaixa de Donuts\t\t$%i\n4.\tDonuts Familia\t\t\t$%i", ITEM_DONUT_PRICE_1, ITEM_DONUT_PRICE_2, ITEM_DONUT_PRICE_3, ITEM_DONUT_PRICE_4);
										ShowPlayerDialog(playerid, DIALOG_DONUT, DIALOG_STYLE_LIST, gBusinessData[b][E_BUSINESS_NAME], listitems, "Comprar", "Cancelar");
										return 1;
									}

									PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
									SendClientMessage(playerid, COLOR_SUCCESS, "* Você comprou uma porção de donuts.");
									SendClientActionMessage(playerid, 15.0, "comeu uma porção de donuts.");

									SetPlayerHunger(playerid, GetPlayerHunger(playerid)  + 25.0);
									SetPlayerHealthEx(playerid, GetPlayerHealthf(playerid) + 20.0);

									GivePlayerCash(playerid, -ITEM_DONUT_PRICE_2);

									SetBusinessProducts(b, GetBusinessProducts(b) - 1);
									SetBusinessTill(b, GetBusinessTill(b) + ITEM_DONUT_PRICE_2);

									new listitems[128];
									format(listitems, sizeof listitems, "1.\tDonut\t\t\t\t$%i\n2.\tPorção de Donuts\t\t$%i\n3.\tCaixa de Donuts\t\t$%i\n4.\tDonuts Familia\t\t\t$%i", ITEM_DONUT_PRICE_1, ITEM_DONUT_PRICE_2, ITEM_DONUT_PRICE_3, ITEM_DONUT_PRICE_4);
									ShowPlayerDialog(playerid, DIALOG_DONUT, DIALOG_STYLE_LIST, gBusinessData[b][E_BUSINESS_NAME], listitems, "Comprar", "Cancelar");
								}
								case 2:
								{
									if(GetPlayerCash(playerid) < ITEM_DONUT_PRICE_3)
									{
										PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
										SendClientMessage(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiente.");

										new listitems[128];
										format(listitems, sizeof listitems, "1.\tDonut\t\t\t\t$%i\n2.\tPorção de Donuts\t\t$%i\n3.\tCaixa de Donuts\t\t$%i\n4.\tDonuts Familia\t\t\t$%i", ITEM_DONUT_PRICE_1, ITEM_DONUT_PRICE_2, ITEM_DONUT_PRICE_3, ITEM_DONUT_PRICE_4);
										ShowPlayerDialog(playerid, DIALOG_DONUT, DIALOG_STYLE_LIST, gBusinessData[b][E_BUSINESS_NAME], listitems, "Comprar", "Cancelar");
										return 1;
									}

									PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
									SendClientMessage(playerid, COLOR_SUCCESS, "* Você comprou uma caixa de donuts.");
									SendClientActionMessage(playerid, 15.0, "comeu uma caixa de donuts.");

									SetPlayerHunger(playerid, GetPlayerHunger(playerid) + 50.0);
									SetPlayerHealthEx(playerid, GetPlayerHealthf(playerid) + 30.0);

									GivePlayerCash(playerid, -ITEM_DONUT_PRICE_3);

									SetBusinessProducts(b, GetBusinessProducts(b) - 1);
									SetBusinessTill(b, GetBusinessTill(b) + ITEM_DONUT_PRICE_3);

									new listitems[128];
									format(listitems, sizeof listitems, "1.\tDonut\t\t\t\t$%i\n2.\tPorção de Donuts\t\t$%i\n3.\tCaixa de Donuts\t\t$%i\n4.\tDonuts Familia\t\t\t$%i", ITEM_DONUT_PRICE_1, ITEM_DONUT_PRICE_2, ITEM_DONUT_PRICE_3, ITEM_DONUT_PRICE_4);
									ShowPlayerDialog(playerid, DIALOG_DONUT, DIALOG_STYLE_LIST, gBusinessData[b][E_BUSINESS_NAME], listitems, "Comprar", "Cancelar");
								}
								case 3:
								{
									if(GetPlayerCash(playerid) < ITEM_DONUT_PRICE_4)
									{
										PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
										SendClientMessage(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiente.");

										new listitems[128];
										format(listitems, sizeof listitems, "1.\tDonut\t\t\t\t$%i\n2.\tPorção de Donuts\t\t$%i\n3.\tCaixa de Donuts\t\t$%i\n4.\tDonuts Familia\t\t\t$%i", ITEM_DONUT_PRICE_1, ITEM_DONUT_PRICE_2, ITEM_DONUT_PRICE_3, ITEM_DONUT_PRICE_4);
										ShowPlayerDialog(playerid, DIALOG_DONUT, DIALOG_STYLE_LIST, gBusinessData[b][E_BUSINESS_NAME], listitems, "Comprar", "Cancelar");
										return 1;
									}

									PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
									SendClientMessage(playerid, COLOR_SUCCESS, "* Você comprou donuts tamanho familia.");
									SendClientActionMessage(playerid, 15.0, "comeu um donuts tamanho familia.");

									SetPlayerHunger(playerid, GetPlayerHunger(playerid) + 75.0);
									SetPlayerHealthEx(playerid, GetPlayerHealthf(playerid) + 50.0);

									GivePlayerCash(playerid, -ITEM_DONUT_PRICE_4);

									SetBusinessProducts(b, GetBusinessProducts(b) - 1);
									SetBusinessTill(b, GetBusinessTill(b) + ITEM_DONUT_PRICE_4);

									new listitems[128];
									format(listitems, sizeof listitems, "1.\tDonut\t\t\t\t$%i\n2.\tPorção de Donuts\t\t$%i\n3.\tCaixa de Donuts\t\t$%i\n4.\tDonuts Familia\t\t\t$%i", ITEM_DONUT_PRICE_1, ITEM_DONUT_PRICE_2, ITEM_DONUT_PRICE_3, ITEM_DONUT_PRICE_4);
									ShowPlayerDialog(playerid, DIALOG_DONUT, DIALOG_STYLE_LIST, gBusinessData[b][E_BUSINESS_NAME], listitems, "Comprar", "Cancelar");
								}
							}
							ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4.1, 0, 1, 1, 0, 0);
						}
						else
						{
							PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
							SendClientMessage(playerid, COLOR_ERROR, "* Desculpe, mas estamos sem produtos.");
							SetCameraBehindPlayer(playerid);
						}
					}
				}
			}
		}
		case DIALOG_RESTAURANT:
		{
			if(!response)
			{
				PlayerPlaySound(playerid, 1084, 0.0, 0.0, 0.0);
				SetCameraBehindPlayer(playerid);
				return 1;
			}
			foreach(new b: Business)
			{
				if(IsPlayerInBusiness(playerid, b, 25.0))
				{
					if(gBusinessData[b][E_BUSINESS_TYPE] == BUSINESS_TYPE_RESTAURANT)
					{
						if(gBusinessData[b][E_BUSINESS_PRODUCTS] > 0)
						{
							switch(listitem)
							{
								case 0:
								{
									if(GetPlayerCash(playerid) < ITEM_RESTAURANT_PRICE_1)
									{
										PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
										SendClientMessage(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiente.");

										new listitems[128];
										format(listitems, sizeof listitems, "1.\tRefeição basica\t$%i\n2.\tRefeição pequena\t$%i\n3.\tRefeição média\t$%i\n4.\tRefeição completa\t$%i", ITEM_RESTAURANT_PRICE_1, ITEM_RESTAURANT_PRICE_2, ITEM_RESTAURANT_PRICE_3, ITEM_RESTAURANT_PRICE_4);
										ShowPlayerDialog(playerid, DIALOG_RESTAURANT, DIALOG_STYLE_LIST, gBusinessData[b][E_BUSINESS_NAME], listitems, "Comprar", "Cancelar");
										return 1;
									}

									PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
									SendClientMessage(playerid, COLOR_SUCCESS, "* Você comprou uma refeição basica.");
									SendClientActionMessage(playerid, 15.0, "comeu uma refeição basica.");

									SetPlayerHunger(playerid, GetPlayerHunger(playerid) + 10.0);
									SetPlayerHealthEx(playerid, GetPlayerHealthf(playerid) + 10.0);

									GivePlayerCash(playerid, -ITEM_RESTAURANT_PRICE_1);

									new listitems[128];
									format(listitems, sizeof listitems, "1.\tRefeição basica\t$%i\n2.\tRefeição pequena\t$%i\n3.\tRefeição média\t$%i\n4.\tRefeição completa\t$%i", ITEM_RESTAURANT_PRICE_1, ITEM_RESTAURANT_PRICE_2, ITEM_RESTAURANT_PRICE_3, ITEM_RESTAURANT_PRICE_4);
									ShowPlayerDialog(playerid, DIALOG_RESTAURANT, DIALOG_STYLE_LIST, gBusinessData[b][E_BUSINESS_NAME], listitems, "Comprar", "Cancelar");

									SetBusinessProducts(b, GetBusinessProducts(b) - 1);
									SetBusinessTill(b, GetBusinessTill(b) + ITEM_RESTAURANT_PRICE_1);
								}
								case 1:
								{
									if(GetPlayerCash(playerid) < ITEM_RESTAURANT_PRICE_2)
									{
										PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
										SendClientMessage(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiente.");

										new listitems[128];
										format(listitems, sizeof listitems, "1.\tRefeição basica\t$%i\n2.\tRefeição pequena\t$%i\n3.\tRefeição média\t$%i\n4.\tRefeição completa\t$%i", ITEM_RESTAURANT_PRICE_1, ITEM_RESTAURANT_PRICE_2, ITEM_RESTAURANT_PRICE_3, ITEM_RESTAURANT_PRICE_4);
										ShowPlayerDialog(playerid, DIALOG_RESTAURANT, DIALOG_STYLE_LIST, gBusinessData[b][E_BUSINESS_NAME], listitems, "Comprar", "Cancelar");
										return 1;
									}

									PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
									SendClientMessage(playerid, COLOR_SUCCESS, "* Você comprou uma refeição pequena.");
									SendClientActionMessage(playerid, 15.0, "comeu uma refeição pequena.");

									SetPlayerHunger(playerid, GetPlayerHunger(playerid) + 25.0);
									SetPlayerHealthEx(playerid, GetPlayerHealthf(playerid) + 20.0);

									GivePlayerCash(playerid, -ITEM_RESTAURANT_PRICE_2);

									new listitems[128];
									format(listitems, sizeof listitems, "1.\tRefeição basica\t$%i\n2.\tRefeição pequena\t$%i\n3.\tRefeição média\t$%i\n4.\tRefeição completa\t$%i", ITEM_RESTAURANT_PRICE_1, ITEM_RESTAURANT_PRICE_2, ITEM_RESTAURANT_PRICE_3, ITEM_RESTAURANT_PRICE_4);
									ShowPlayerDialog(playerid, DIALOG_RESTAURANT, DIALOG_STYLE_LIST, gBusinessData[b][E_BUSINESS_NAME], listitems, "Comprar", "Cancelar");

									SetBusinessProducts(b, GetBusinessProducts(b) - 1);
									SetBusinessTill(b, GetBusinessTill(b) + ITEM_RESTAURANT_PRICE_2);
								}
								case 2:
								{
									if(GetPlayerCash(playerid) < ITEM_RESTAURANT_PRICE_3)
									{
										PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
										SendClientMessage(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiente.");

										new listitems[128];
										format(listitems, sizeof listitems, "1.\tRefeição basica\t$%i\n2.\tRefeição pequena\t$%i\n3.\tRefeição média\t$%i\n4.\tRefeição completa\t$%i", ITEM_RESTAURANT_PRICE_1, ITEM_RESTAURANT_PRICE_2, ITEM_RESTAURANT_PRICE_3, ITEM_RESTAURANT_PRICE_4);
										ShowPlayerDialog(playerid, DIALOG_RESTAURANT, DIALOG_STYLE_LIST, gBusinessData[b][E_BUSINESS_NAME], listitems, "Comprar", "Cancelar");
										return 1;
									}

									PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
									SendClientMessage(playerid, COLOR_SUCCESS, "* Você comprou uma refeição média.");
									SendClientActionMessage(playerid, 15.0, "comeu uma refeição média.");

									SetPlayerHunger(playerid, GetPlayerHunger(playerid) + 50.0);
									SetPlayerHealthEx(playerid, GetPlayerHealthf(playerid) + 30.0);

									GivePlayerCash(playerid, -ITEM_RESTAURANT_PRICE_3);

									new listitems[128];
									format(listitems, sizeof listitems, "1.\tRefeição basica\t$%i\n2.\tRefeição pequena\t$%i\n3.\tRefeição média\t$%i\n4.\tRefeição completa\t$%i", ITEM_RESTAURANT_PRICE_1, ITEM_RESTAURANT_PRICE_2, ITEM_RESTAURANT_PRICE_3, ITEM_RESTAURANT_PRICE_4);
									ShowPlayerDialog(playerid, DIALOG_RESTAURANT, DIALOG_STYLE_LIST, gBusinessData[b][E_BUSINESS_NAME], listitems, "Comprar", "Cancelar");

									SetBusinessProducts(b, GetBusinessProducts(b) - 1);
									SetBusinessTill(b, GetBusinessTill(b) + ITEM_RESTAURANT_PRICE_3);
								}
								case 3:
								{
									if(GetPlayerCash(playerid) < ITEM_RESTAURANT_PRICE_4)
									{
										PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
										SendClientMessage(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiente.");

										new listitems[128];
										format(listitems, sizeof listitems, "1.\tRefeição basica\t$%i\n2.\tRefeição pequena\t$%i\n3.\tRefeição média\t$%i\n4.\tRefeição completa\t$%i", ITEM_RESTAURANT_PRICE_1, ITEM_RESTAURANT_PRICE_2, ITEM_RESTAURANT_PRICE_3, ITEM_RESTAURANT_PRICE_4);
										ShowPlayerDialog(playerid, DIALOG_RESTAURANT, DIALOG_STYLE_LIST, gBusinessData[b][E_BUSINESS_NAME], listitems, "Comprar", "Cancelar");
										return 1;
									}

									PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
									SendClientMessage(playerid, COLOR_SUCCESS, "* Você comprou uma refeição completa.");
									SendClientActionMessage(playerid, 15.0, "comeu uma refeição completa.");

									SetPlayerHunger(playerid, GetPlayerHunger(playerid) + 75.0);
									SetPlayerHealthEx(playerid, GetPlayerHealthf(playerid) + 50.0);

									GivePlayerCash(playerid, -ITEM_RESTAURANT_PRICE_4);

									new listitems[128];
									format(listitems, sizeof listitems, "1.\tRefeição basica\t$%i\n2.\tRefeição pequena\t$%i\n3.\tRefeição média\t$%i\n4.\tRefeição completa\t$%i", ITEM_RESTAURANT_PRICE_1, ITEM_RESTAURANT_PRICE_2, ITEM_RESTAURANT_PRICE_3, ITEM_RESTAURANT_PRICE_4);
									ShowPlayerDialog(playerid, DIALOG_RESTAURANT, DIALOG_STYLE_LIST, gBusinessData[b][E_BUSINESS_NAME], listitems, "Comprar", "Cancelar");

									SetBusinessProducts(b, GetBusinessProducts(b) - 1);
									SetBusinessTill(b, GetBusinessTill(b) + ITEM_RESTAURANT_PRICE_4);
								}
							}
							ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4.1, 0, 1, 1, 0, 0);
						}
						else
						{
							PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
							SendClientMessage(playerid, COLOR_ERROR, "* Desculpe, mas estamos sem produtos.");
							SetCameraBehindPlayer(playerid);
						}
					}
				}
			}
		}
		case DIALOG_ADVERTISE:
		{
			if(!response)
			{
				PlayerPlaySound(playerid, 1084, 0.0, 0.0, 0.0);
				SetCameraBehindPlayer(playerid);
				return 1;
			}
			foreach(new b: Business)
			{
				if(IsPlayerInBusiness(playerid, b, 25.0))
				{
					if(gBusinessData[b][E_BUSINESS_TYPE] == BUSINESS_TYPE_ADVERTISE)
					{
						if(gBusinessData[b][E_BUSINESS_PRODUCTS] > 0)
						{
							/*if(GetPlayerPlayedTime(playerid)/3600 < 3)
							{
								PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
								SendClientMessage(playerid, COLOR_ERROR, "* Você precisa ter pelo menos três horas jogadas para anunciar.");
								SetCameraBehindPlayer(playerid);
								return 1;
							}
							else
							{*/
								if(GetPlayerCash(playerid) < strlen(inputtext) * ADVERTISE_PRICE_PER_LETTER)
								{
									PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
									SendClientMessagef(playerid, COLOR_ERROR, "* Você não possui dinheiro suficiente. {C8C8C8}[$%i]", strlen(inputtext) * ADVERTISE_PRICE_PER_LETTER);

									new listitems[128];
									format(listitems, sizeof listitems, "O que você deseja anunciar?\nPreço: $%i por letra.", ADVERTISE_PRICE_PER_LETTER);
									ShowPlayerDialog(playerid, DIALOG_ADVERTISE, DIALOG_STYLE_INPUT, gBusinessData[b][E_BUSINESS_NAME], listitems, "Anunciar", "Cancelar");
									return 1;
								}
								else if(strlen(inputtext) < 5)
								{
									PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
									SendClientMessage(playerid, COLOR_ERROR, "* Anuncio muito curto. [Min: 5 characteres]");

									new listitems[128];
									format(listitems, sizeof listitems, "O que você deseja anunciar?\nPreço: $%i por letra.", ADVERTISE_PRICE_PER_LETTER);
									ShowPlayerDialog(playerid, DIALOG_ADVERTISE, DIALOG_STYLE_INPUT, gBusinessData[b][E_BUSINESS_NAME], listitems, "Anunciar", "Cancelar");
									return 1;
								}
								else if(strlen(inputtext) > 128)
								{
									PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
									SendClientMessage(playerid, COLOR_ERROR, "* Anuncio muito comprido. [Max: 128 characteres]");

									new listitems[128];
									format(listitems, sizeof listitems, "O que você deseja anunciar?\nPreço: $%i por letra.", ADVERTISE_PRICE_PER_LETTER);
									ShowPlayerDialog(playerid, DIALOG_ADVERTISE, DIALOG_STYLE_INPUT, gBusinessData[b][E_BUSINESS_NAME], listitems, "Anunciar", "Cancelar");
									return 1;
								}

								PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
								new advertiseMessage[32 + 8 + MAX_PLAYER_NAME + 128];
								format(advertiseMessage, sizeof advertiseMessage, "[Anuncio] %s: %s - Telefone: %i", GetPlayerNamef(playerid), inputtext, GetPlayerPhoneNumber(playerid));
								SendClientMessageToAll(0x1fc91fFF, advertiseMessage);

								format(advertiseMessage, sizeof advertiseMessage, "Anuncio publicado pela empresa {C8C8C8}%s{AFAFAF}.", GetBusinessName(b));
								SendClientMessageToAll(0xAFAFAFAF, advertiseMessage);

								GivePlayerCash(playerid, -(strlen(inputtext) * ADVERTISE_PRICE_PER_LETTER));
								SetBusinessTill(b, GetBusinessTill(b) + (strlen(inputtext) * ADVERTISE_PRICE_PER_LETTER));
								SendClientActionMessage(playerid, 15.0, "paga para a empresa enviar um anuncio.");

								new priceText[15];
								format(priceText, sizeof(priceText), "~r~-$%d", strlen(inputtext) * ADVERTISE_PRICE_PER_LETTER);
								GameTextForPlayer(playerid, priceText, 5000, 1);
								SetCameraBehindPlayer(playerid);
								return 1;
							//}
						}
						else
						{
							PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
							SendClientMessage(playerid, COLOR_ERROR, "* Desculpe, mas estamos sem produtos.");
							SetCameraBehindPlayer(playerid);
						}
					}
				}
			}
		}
		case DIALOG_PHONE:
		{
			if(!response)
			{
				PlayerPlaySound(playerid, 1084, 0.0, 0.0, 0.0);
				SetCameraBehindPlayer(playerid);
				return 1;
			}
			foreach(new b: Business)
			{
				if(IsPlayerInBusiness(playerid, b, 25.0))
				{
					if(gBusinessData[b][E_BUSINESS_TYPE] == BUSINESS_TYPE_PHONE)
					{
						if(gBusinessData[b][E_BUSINESS_PRODUCTS] > 0)
						{
							switch(listitem)
							{
								case 0:
								{
									if(GetPlayerCash(playerid) < PHONE_PRICE)
									{
										PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
										SendClientMessagef(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiente. {C8C8C8}[$%i]", PHONE_PRICE);
										SetCameraBehindPlayer(playerid);
										return 1;
									}

									PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
									SetPlayerPhoneNumber(playerid, GeneratePhoneNumber());
									SetPlayerPhoneNetwork(playerid, b);

									SendClientMessagef(playerid, COLOR_SUCCESS, "* Você comprou um celular, seu novo numero é {0087FA}%i", GetPlayerPhoneNumber(playerid));
									SendClientMessage(playerid, COLOR_INFO, "* Para obter ajuda sobre os comandos use {C8C8C8}/ajudacelular{AFAFAF}.");
									SendClientActionMessage(playerid, 15.0, "pagou para a empresa e recebeu um celular em troca.");

									GivePlayerCash(playerid, -PHONE_PRICE);
									SetPlayerPhoneCredit(playerid, 250);
									SetPlayerPhoneState(playerid, true);

									new listitems[128];
									format(listitems, sizeof listitems, "1.\tComprar celular\t$%i\n2.\tComprar creditos", PHONE_PRICE);
									ShowPlayerDialog(playerid, DIALOG_PHONE, DIALOG_STYLE_LIST, gBusinessData[b][E_BUSINESS_NAME], listitems, "Comprar", "Cancelar");

									SetBusinessTill(b, GetBusinessTill(b) + PHONE_PRICE);
									SetBusinessProducts(b, GetBusinessProducts(b) - 1);
									return 1;
								}
								case 1:
								{
									PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
									ShowPlayerDialog(playerid, DIALOG_BUY_CREDITS, DIALOG_STYLE_INPUT, "Comprar creditos", "Digite a quantia de creditos que deseja comprar:", "Comprar", "Voltar");
									return 1;
								}
							}
						}
						else
						{
							PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
							SendClientMessage(playerid, COLOR_ERROR, "* Desculpe, mas estamos sem produtos.");
							SetCameraBehindPlayer(playerid);
						}
					}
				}
			}
		}
		case DIALOG_BUY_CREDITS:
		{
			new b = GetPlayerVirtualWorld(playerid);
			if(!response)
			{
				PlayerPlaySound(playerid, 1084, 0.0, 0.0, 0.0);

				new listitems[128];
				format(listitems, sizeof listitems, "1.\tComprar celular\t$%i\n2.\tComprar creditos", PHONE_PRICE);
				ShowPlayerDialog(playerid, DIALOG_PHONE, DIALOG_STYLE_LIST, gBusinessData[b][E_BUSINESS_NAME], listitems, "Comprar", "Cancelar");
				return 1;
			}

			if(isnull(inputtext))
			{
				PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
				SendClientMessage(playerid, COLOR_ERROR, "* Quantia inválida.");
				ShowPlayerDialog(playerid, DIALOG_BUY_CREDITS, DIALOG_STYLE_INPUT, "Comprar creditos", "Digite a quantia de creditos que deseja comprar:", "Comprar", "Voltar");
				return 1;
			}
			else if(!IsNumeric(inputtext))
			{
				PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
				SendClientMessage(playerid, COLOR_ERROR, "* Utilize apenas numeros.");
				ShowPlayerDialog(playerid, DIALOG_BUY_CREDITS, DIALOG_STYLE_INPUT, "Comprar creditos", "Digite a quantia de creditos que deseja comprar:", "Comprar", "Voltar");
				return 1;
			}

			new credits = strval(inputtext);

			if(credits < 0)
			{
				PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
				SendClientMessage(playerid, COLOR_ERROR, "* Utilize apenas valores positivos.");
				ShowPlayerDialog(playerid, DIALOG_BUY_CREDITS, DIALOG_STYLE_INPUT, "Comprar creditos", "Digite a quantia de creditos que deseja comprar:", "Comprar", "Voltar");
				return 1;
			}

			if(GetPlayerCash(playerid) < credits)
			{
				PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
				SendClientMessagef(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiente. {C8C8C8}[$%i]", credits);
				ShowPlayerDialog(playerid, DIALOG_BUY_CREDITS, DIALOG_STYLE_INPUT, "Comprar creditos", "Digite a quantia de creditos que deseja comprar:", "Comprar", "Voltar");
				return 1;
			}

			SendClientMessagef(playerid, COLOR_SUCCESS, "* Você colocou $%i de creditos em seu celular.", credits);
			SendClientActionMessage(playerid, 15.0, "pagou para a empresa e recebeu creditos em troca.");

			GivePlayerCash(playerid, -credits);
			SetPlayerPhoneCredit(playerid, GetPlayerPhoneCredit(playerid) + credits);
			SetBusinessTill(b, GetBusinessTill(b) + credits);
			SetCameraBehindPlayer(playerid);
			return 1;
		}
		case DIALOG_CLUB:
		{
			if(!response)
			{
				PlayerPlaySound(playerid, 1084, 0.0, 0.0, 0.0);
				SetCameraBehindPlayer(playerid);
				return 1;
			}
			foreach(new b: Business)
			{
				if(IsPlayerInBusiness(playerid, b, 25.0))
				{
					if(gBusinessData[b][E_BUSINESS_TYPE] == BUSINESS_TYPE_CLUB)
					{
						if(gBusinessData[b][E_BUSINESS_PRODUCTS] > 0)
						{
							switch(listitem)
							{
								case 0:
								{
									if(GetPlayerCash(playerid) < CHAMPAGNE_PRICE)
									{
										PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
										SendClientMessage(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiente.");

										new listitems[128];
										format(listitems, sizeof listitems, "1.\tChampagne \t$%i\n2.\tVodka\t\t$%i\n3.\tWhisky\t\t$%i\n4.\tAgua\t\t$%i", CHAMPAGNE_PRICE, VODKA_PRICE, WHISKY_PRICE, WATER_PRICE);
										ShowPlayerDialog(playerid, DIALOG_CLUB, DIALOG_STYLE_LIST, gBusinessData[b][E_BUSINESS_NAME], listitems, "Comprar", "Cancelar");
										return 1;
									}

									PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
									SendClientMessage(playerid, COLOR_SUCCESS, "* Você comprou um champagne.");
									SendClientActionMessage(playerid, 15.0, "bebeu um champagne.");

									SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_WINE);

									GivePlayerCash(playerid, -CHAMPAGNE_PRICE);

									SetPlayerDrunkLevel(playerid, GetPlayerDrunkLevel(playerid) + 2500);
									SetPlayerThirst(playerid, GetPlayerThirst(playerid) + 10.0);

									new listitems[128];
									format(listitems, sizeof listitems, "1.\tChampagne \t$%i\n2.\tVodka\t\t$%i\n3.\tWhisky\t\t$%i\n4.\tAgua\t\t$%i", CHAMPAGNE_PRICE, VODKA_PRICE, WHISKY_PRICE, WATER_PRICE);
									ShowPlayerDialog(playerid, DIALOG_CLUB, DIALOG_STYLE_LIST, gBusinessData[b][E_BUSINESS_NAME], listitems, "Comprar", "Cancelar");

									SetBusinessProducts(b, GetBusinessProducts(b) - 1);
									SetBusinessTill(b, GetBusinessTill(b) + CHAMPAGNE_PRICE);
								}
								case 1:
								{
									if(GetPlayerCash(playerid) < VODKA_PRICE)
									{
										PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
										SendClientMessage(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiente.");

										new listitems[128];
										format(listitems, sizeof listitems, "1.\tChampagne \t$%i\n2.\tVodka\t\t$%i\n3.\tWhisky\t\t$%i\n4.\tAgua\t\t$%i", CHAMPAGNE_PRICE, VODKA_PRICE, WHISKY_PRICE, WATER_PRICE);
										ShowPlayerDialog(playerid, DIALOG_CLUB, DIALOG_STYLE_LIST, gBusinessData[b][E_BUSINESS_NAME], listitems, "Comprar", "Cancelar");
										return 1;
									}

									PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
									SendClientMessage(playerid, COLOR_SUCCESS, "* Você comprou uma vodka.");
									SendClientActionMessage(playerid, 15.0, "bebeu uma vodka.");

									SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_WINE);

									GivePlayerCash(playerid, -VODKA_PRICE);

									SetPlayerDrunkLevel(playerid, GetPlayerDrunkLevel(playerid) + 2500);
									SetPlayerThirst(playerid, GetPlayerThirst(playerid) + 10.0);

									new listitems[128];
									format(listitems, sizeof listitems, "1.\tChampagne \t$%i\n2.\tVodka\t\t$%i\n3.\tWhisky\t\t$%i\n4.\tAgua\t\t$%i", CHAMPAGNE_PRICE, VODKA_PRICE, WHISKY_PRICE, WATER_PRICE);
									ShowPlayerDialog(playerid, DIALOG_CLUB, DIALOG_STYLE_LIST, gBusinessData[b][E_BUSINESS_NAME], listitems, "Comprar", "Cancelar");

									SetBusinessProducts(b, GetBusinessProducts(b) - 1);
									SetBusinessTill(b, GetBusinessTill(b) + VODKA_PRICE);
								}
								case 2:
								{
									if(GetPlayerCash(playerid) < WHISKY_PRICE)
									{
										PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
										SendClientMessage(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiente.");

										new listitems[128];
										format(listitems, sizeof listitems, "1.\tChampagne \t$%i\n2.\tVodka\t\t$%i\n3.\tWhisky\t\t$%i\n4.\tAgua\t\t$%i", CHAMPAGNE_PRICE, VODKA_PRICE, WHISKY_PRICE, WATER_PRICE);
										ShowPlayerDialog(playerid, DIALOG_CLUB, DIALOG_STYLE_LIST, gBusinessData[b][E_BUSINESS_NAME], listitems, "Comprar", "Cancelar");
										return 1;
									}

									PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
									SendClientMessage(playerid, COLOR_SUCCESS, "* Você comprou um whisky.");
									SendClientActionMessage(playerid, 15.0, "bebeu um whisky.");

									SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_WINE);

									GivePlayerCash(playerid, -WHISKY_PRICE);

									SetPlayerDrunkLevel(playerid, GetPlayerDrunkLevel(playerid) + 2500);
									SetPlayerThirst(playerid, GetPlayerThirst(playerid) + 10.0);

									new listitems[128];
									format(listitems, sizeof listitems, "1.\tChampagne \t$%i\n2.\tVodka\t\t$%i\n3.\tWhisky\t\t$%i\n4.\tAgua\t\t$%i", CHAMPAGNE_PRICE, VODKA_PRICE, WHISKY_PRICE, WATER_PRICE);
									ShowPlayerDialog(playerid, DIALOG_CLUB, DIALOG_STYLE_LIST, gBusinessData[b][E_BUSINESS_NAME], listitems, "Comprar", "Cancelar");

									SetBusinessProducts(b, GetBusinessProducts(b) - 1);
									SetBusinessTill(b, GetBusinessTill(b) + WHISKY_PRICE);
								}
								case 3:
								{
									if(GetPlayerCash(playerid) < WATER_PRICE)
									{
										PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
										SendClientMessage(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiente.");

										new listitems[128];
										format(listitems, sizeof listitems, "1.\tChampagne \t$%i\n2.\tVodka\t\t$%i\n3.\tWhisky\t\t$%i\n4.\tAgua\t\t$%i", CHAMPAGNE_PRICE, VODKA_PRICE, WHISKY_PRICE, WATER_PRICE);
										ShowPlayerDialog(playerid, DIALOG_CLUB, DIALOG_STYLE_LIST, gBusinessData[b][E_BUSINESS_NAME], listitems, "Comprar", "Cancelar");
										return 1;
									}

									PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
									SendClientMessage(playerid, COLOR_SUCCESS, "* Você comprou um copo de agua.");
									SendClientActionMessage(playerid, 15.0, "bebeu um copo de agua.");

									GivePlayerCash(playerid, -WATER_PRICE);

									if(GetPlayerDrunkLevel(playerid) > 0)
										SetPlayerDrunkLevel(playerid, GetPlayerDrunkLevel(playerid) - 1000);
									SetPlayerThirst(playerid, GetPlayerThirst(playerid) + 50.0);

									new listitems[128];
									format(listitems, sizeof listitems, "1.\tChampagne \t$%i\n2.\tVodka\t\t$%i\n3.\tWhisky\t\t$%i\n4.\tAgua\t\t$%i", CHAMPAGNE_PRICE, VODKA_PRICE, WHISKY_PRICE, WATER_PRICE);
									ShowPlayerDialog(playerid, DIALOG_CLUB, DIALOG_STYLE_LIST, gBusinessData[b][E_BUSINESS_NAME], listitems, "Comprar", "Cancelar");

									SetBusinessProducts(b, GetBusinessProducts(b) - 1);
									SetBusinessTill(b, GetBusinessTill(b) + WATER_PRICE);
								}
							}
							ApplyAnimation(playerid, "VENDING", "VEND_Drink2_P", 4.1, 0, 1, 1, 0, 0);
						}
						else
						{
							PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
							SendClientMessage(playerid, COLOR_ERROR, "* Desculpe, mas estamos sem produtos.");
							SetCameraBehindPlayer(playerid);
						}
					}
				}
			}
		}
		case DIALOG_AMMU:
		{
			if(!response)
			{
				PlayerPlaySound(playerid, 1084, 0.0, 0.0, 0.0);
				SetCameraBehindPlayer(playerid);
				return 1;
			}
			foreach(new b: Business)
			{
				if(!IsPlayerInBusiness(playerid, b, 25.0))
					continue;
				if(gBusinessData[b][E_BUSINESS_TYPE] != BUSINESS_TYPE_AMMUNATION)
					continue;
				if(gBusinessData[b][E_BUSINESS_PRODUCTS] < 1)
				{
					PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
					SendClientMessage(playerid, COLOR_ERROR, "* Desculpe, mas estamos sem produtos.");
					SetCameraBehindPlayer(playerid);
					return 1;
				}
				else
				{
					switch(listitem)
					{
						case 0:
						{
							ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_GUNS, b);
							PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
						}
						case 1:
						{
							ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_AMMO, b);
							PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
						}
					}
				}
			}
		}
		case DIALOG_AMMU_GUNS:
		{
			if(!response)
			{
				foreach(new b: Business)
					if(IsPlayerInBusiness(playerid, b, 25.0))
						if(gBusinessData[b][E_BUSINESS_TYPE] == BUSINESS_TYPE_AMMUNATION)
							ShowPlayerDialog(playerid, DIALOG_AMMU, DIALOG_STYLE_LIST, gBusinessData[b][E_BUSINESS_NAME], "Arma\nMunição", "Selecionar", "Cancelar");
				PlayerPlaySound(playerid, 1084, 0.0, 0.0, 0.0);
				return 1;
			}

			foreach(new b: Business)
			{
				if(!IsPlayerInBusiness(playerid, b, 25.0))
					continue;

				if(gBusinessData[b][E_BUSINESS_TYPE] != BUSINESS_TYPE_AMMUNATION)
					continue;

				if(gBusinessData[b][E_BUSINESS_PRODUCTS] < 1)
				{
					PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
					SendClientMessage(playerid, COLOR_ERROR, "* Desculpe, mas estamos sem produtos.");
					SetCameraBehindPlayer(playerid);
					return 1;
				}
				else
				{
					switch(listitem)
					{
						case 0:
						{
                            new weapon, ammo;
						    GetPlayerWeaponData(playerid, 2, weapon, ammo);
							if(weapon == 22)
							{
								PlayErrorSound(playerid);
								ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_GUNS, b);
								SendClientMessage(playerid, COLOR_ERROR, "* Você já possui essa arma, compre munições.");
							}

							else if(GetPlayerCash(playerid) < WEAPON_COLT45_PRICE)
							{
								PlayErrorSound(playerid);
								ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_GUNS, b);
								SendClientMessage(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiante.");
							}
							else if(GetPlayerWeaponSkill(playerid, 0) < 500)
							{
								PlayErrorSound(playerid);
								ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_GUNS, b);
								SendClientMessage(playerid, COLOR_ERROR, "* Você não possui porte para esta arma, treine no estande antes.");
							}
							else
							{
								GivePlayerWeapon(playerid, 22, 50);
								GivePlayerCash(playerid, -WEAPON_COLT45_PRICE);
								SendClientActionMessage(playerid, 30.0, "paga para o vendedor e recebe uma pistola.");
								ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_GUNS, b);
							}
						}
						case 1:
						{
                            new weapon, ammo;
						    GetPlayerWeaponData(playerid, 2, weapon, ammo);
							if(weapon == 23)
							{
								PlayErrorSound(playerid);
								ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_GUNS, b);
								SendClientMessage(playerid, COLOR_ERROR, "* Você já possui essa arma, compre munições.");
							}

							else if(GetPlayerCash(playerid) < WEAPON_SILENCED_PRICE)
							{
								PlayErrorSound(playerid);
								ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_GUNS, b);
								SendClientMessage(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiante.");
							}
							else if(GetPlayerWeaponSkill(playerid, 1) < 500)
							{
								PlayErrorSound(playerid);
								ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_GUNS, b);
								SendClientMessage(playerid, COLOR_ERROR, "* Você não possui porte para esta arma, treine no estande antes.");
							}
							else
							{
								GivePlayerWeapon(playerid, 23, 50);
								GivePlayerCash(playerid, -WEAPON_SILENCED_PRICE);
								SendClientActionMessage(playerid, 30.0, "paga para o vendedor e recebe uma pistola.");
								ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_GUNS, b);
							}
						}
						case 2:
						{
                            new weapon, ammo;
						    GetPlayerWeaponData(playerid, 2, weapon, ammo);
							if(weapon == 24)
							{
								PlayErrorSound(playerid);
								ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_GUNS, b);
								SendClientMessage(playerid, COLOR_ERROR, "* Você já possui essa arma, compre munições.");
							}

							else if(GetPlayerCash(playerid) < WEAPON_DEAGLE_PRICE)
							{
								PlayErrorSound(playerid);
								ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_GUNS, b);
								SendClientMessage(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiante.");
							}
							else if(GetPlayerWeaponSkill(playerid, 2) < 500)
							{
								PlayErrorSound(playerid);
								ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_GUNS, b);
								SendClientMessage(playerid, COLOR_ERROR, "* Você não possui porte para esta arma, treine no estande antes.");
							}
							else
							{
								GivePlayerWeapon(playerid, 24, 25);
								GivePlayerCash(playerid, -WEAPON_DEAGLE_PRICE);
								SendClientActionMessage(playerid, 30.0, "paga para o vendedor e recebe um revolver.");
								ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_GUNS, b);
							}
						}
						case 3:
						{
                            new weapon, ammo;
						    GetPlayerWeaponData(playerid, 3, weapon, ammo);
							if(weapon == 25)
							{
								PlayErrorSound(playerid);
								ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_GUNS, b);
								SendClientMessage(playerid, COLOR_ERROR, "* Você já possui essa arma, compre munições.");
							}

							else if(GetPlayerCash(playerid) < WEAPON_SHOTGUN_PRICE)
							{
								PlayErrorSound(playerid);
								ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_GUNS, b);
								SendClientMessage(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiante.");
							}
							else if(GetPlayerWeaponSkill(playerid, 3) < 500)
							{
								PlayErrorSound(playerid);
								ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_GUNS, b);
								SendClientMessage(playerid, COLOR_ERROR, "* Você não possui porte para esta arma, treine no estande antes.");
							}
							else
							{
								GivePlayerWeapon(playerid, 25, 25);
								GivePlayerCash(playerid, -WEAPON_SHOTGUN_PRICE);
								SendClientActionMessage(playerid, 30.0, "paga para o vendedor e recebe uma escopeta.");
								ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_GUNS, b);
							}
						}
						case 4:
						{
							new weapon, ammo;
						    GetPlayerWeaponData(playerid, 3, weapon, ammo);
							if(weapon == 26)
							{
								PlayErrorSound(playerid);
								ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_GUNS, b);
								SendClientMessage(playerid, COLOR_ERROR, "* Você já possui essa arma, compre munições.");
							}

							else if(GetPlayerCash(playerid) < WEAPON_SAWEDOFF_PRICE)
							{
								PlayErrorSound(playerid);
								ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_GUNS, b);
								SendClientMessage(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiante.");
							}
							else if(GetPlayerWeaponSkill(playerid, 4) < 500)
							{
								PlayErrorSound(playerid);
								ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_GUNS, b);
								SendClientMessage(playerid, COLOR_ERROR, "* Você não possui porte para esta arma, treine no estande antes.");
							}
							else
							{
								GivePlayerWeapon(playerid, 26, 10);
								GivePlayerCash(playerid, -WEAPON_SAWEDOFF_PRICE);
								SendClientActionMessage(playerid, 30.0, "paga para o vendedor e recebe uma escopeta de cano serrado.");
								ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_GUNS, b);
							}
						}
						case 5:
						{
							new weapon, ammo;
						    GetPlayerWeaponData(playerid, 3, weapon, ammo);
							if(weapon == 27)
							{
								PlayErrorSound(playerid);
								ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_GUNS, b);
								SendClientMessage(playerid, COLOR_ERROR, "* Você já possui essa arma, compre munições.");
							}

							else if(GetPlayerCash(playerid) < WEAPON_SPAS12_PRICE)
							{
								PlayErrorSound(playerid);
								ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_GUNS, b);
								SendClientMessage(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiante.");
							}
							else if(GetPlayerWeaponSkill(playerid, 5) < 500)
							{
								SendClientMessage(playerid, COLOR_ERROR, "* Você não possui porte para esta arma, treine no estande antes.");
							}
							else
							{
								GivePlayerWeapon(playerid, 27, 10);
								GivePlayerCash(playerid, -WEAPON_SPAS12_PRICE);
								SendClientActionMessage(playerid, 30.0, "paga para o vendedor e recebe uma escopeta automatica.");
								ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_GUNS, b);
							}
						}
						case 6:
						{
							new weapon, ammo;
						    GetPlayerWeaponData(playerid, 4, weapon, ammo);
							if(weapon == 28)
							{
								PlayErrorSound(playerid);
								ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_GUNS, b);
								SendClientMessage(playerid, COLOR_ERROR, "* Você já possui essa arma, compre munições.");
							}

							else if(GetPlayerCash(playerid) < WEAPON_UZI_PRICE)
							{
								PlayErrorSound(playerid);
								ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_GUNS, b);
								SendClientMessage(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiante.");
							}
							else if(GetPlayerWeaponSkill(playerid, 6) < 500)
							{
								PlayErrorSound(playerid);
								ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_GUNS, b);
								SendClientMessage(playerid, COLOR_ERROR, "* Você não possui porte para esta arma, treine no estande antes.");
							}
							else
							{
								GivePlayerWeapon(playerid, 28, 100);
								GivePlayerCash(playerid, -WEAPON_UZI_PRICE);
								SendClientActionMessage(playerid, 30.0, "paga para o vendedor e recebe uma micro smg.");
								ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_GUNS, b);
							}
						}
						case 7:
						{
							new weapon, ammo;
						    GetPlayerWeaponData(playerid, 4, weapon, ammo);
							if(weapon == 29)
							{
								PlayErrorSound(playerid);
								ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_GUNS, b);
								SendClientMessage(playerid, COLOR_ERROR, "* Você já possui essa arma, compre munições.");
							}

							else if(GetPlayerCash(playerid) < WEAPON_MP5_PRICE)
							{
								PlayErrorSound(playerid);
								ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_GUNS, b);
								SendClientMessage(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiante.");
							}
							else if(GetPlayerWeaponSkill(playerid, 7) < 500)
							{
								PlayErrorSound(playerid);
								ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_GUNS, b);
								SendClientMessage(playerid, COLOR_ERROR, "* Você não possui porte para esta arma, treine no estande antes.");
							}
							else
							{
								GivePlayerWeapon(playerid, 29, 100);
								GivePlayerCash(playerid, -WEAPON_MP5_PRICE);
								SendClientActionMessage(playerid, 30.0, "paga para o vendedor e recebe uma mp5.");
								ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_GUNS, b);
							}
						}
						case 8:
						{
							new weapon, ammo;
						    GetPlayerWeaponData(playerid, 5, weapon, ammo);
							if(weapon == 30)
							{
								PlayErrorSound(playerid);
								ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_GUNS, b);
								SendClientMessage(playerid, COLOR_ERROR, "* Você já possui essa arma, compre munições.");
							}

							else if(GetPlayerCash(playerid) < WEAPON_AK47_PRICE)
							{
								PlayErrorSound(playerid);
								ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_GUNS, b);
								SendClientMessage(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiante.");
							}
							else if(GetPlayerWeaponSkill(playerid, 8) < 500)
							{
								PlayErrorSound(playerid);
								ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_GUNS, b);
								SendClientMessage(playerid, COLOR_ERROR, "* Você não possui porte para esta arma, treine no estande antes.");
							}
							else
							{
								GivePlayerWeapon(playerid, 30, 125);
								GivePlayerCash(playerid, -WEAPON_AK47_PRICE);
								SendClientActionMessage(playerid, 30.0, "paga para o vendedor e recebe uma ak-47.");
								ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_GUNS, b);
							}
						}
						case 9:
						{
							new weapon, ammo;
						    GetPlayerWeaponData(playerid, 5, weapon, ammo);
							if(weapon == 31)
							{
								PlayErrorSound(playerid);
								ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_GUNS, b);
								SendClientMessage(playerid, COLOR_ERROR, "* Você já possui essa arma, compre munições.");
							}

							else if(GetPlayerCash(playerid) < WEAPON_M4_PRICE)
							{
								PlayErrorSound(playerid);
								ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_GUNS, b);
								SendClientMessage(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiante.");
							}
							else if(GetPlayerWeaponSkill(playerid, 9) < 500)
							{
								PlayErrorSound(playerid);
								ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_GUNS, b);
								SendClientMessage(playerid, COLOR_ERROR, "* Você não possui porte para esta arma, treine no estande antes.");
							}
							else
							{
								GivePlayerWeapon(playerid, 31, 125);
								GivePlayerCash(playerid, -WEAPON_M4_PRICE);
								SendClientActionMessage(playerid, 30.0, "paga para o vendedor e recebe uma m4.");
								ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_GUNS, b);
							}
						}
						case 10:
						{
							new weapon, ammo;
						    GetPlayerWeaponData(playerid, 4, weapon, ammo);
							if(weapon == 32)
							{
								PlayErrorSound(playerid);
								ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_GUNS, b);
								SendClientMessage(playerid, COLOR_ERROR, "* Você já possui essa arma, compre munições.");
							}

							else if(GetPlayerCash(playerid) < WEAPON_TEC9_PRICE)
							{
								PlayErrorSound(playerid);
								ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_GUNS, b);
								SendClientMessage(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiante.");
							}
							else
							{
								GivePlayerWeapon(playerid, 32, 100);
								GivePlayerCash(playerid, -WEAPON_TEC9_PRICE);
								SendClientActionMessage(playerid, 30.0, "paga para o vendedor e recebe uma tec-9.");
								ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_GUNS, b);
							}
						}
						case 11:
						{
							new weapon, ammo;
						    GetPlayerWeaponData(playerid, 6, weapon, ammo);
							if(weapon == 33)
							{
								PlayErrorSound(playerid);
								ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_GUNS, b);
								SendClientMessage(playerid, COLOR_ERROR, "* Você já possui essa arma, compre munições.");
							}

							else if(GetPlayerCash(playerid) < WEAPON_RIFLE_PRICE)
							{
								PlayErrorSound(playerid);
								ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_GUNS, b);
								SendClientMessage(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiante.");
							}
							else
							{
								GivePlayerWeapon(playerid, 33, 10);
								GivePlayerCash(playerid, -WEAPON_RIFLE_PRICE);
								SendClientActionMessage(playerid, 30.0, "paga para o vendedor e recebe um rifle.");
								ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_GUNS, b);
							}
						}
						case 12:
						{
							new weapon, ammo;
						    GetPlayerWeaponData(playerid, 6, weapon, ammo);
							if(weapon == 34)
							{
								PlayErrorSound(playerid);
								ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_GUNS, b);
								SendClientMessage(playerid, COLOR_ERROR, "* Você já possui essa arma, compre munições.");
							}

							else if(GetPlayerCash(playerid) < WEAPON_SNIPER_PRICE)
							{
								PlayErrorSound(playerid);
								ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_GUNS, b);
								SendClientMessage(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiante.");
							}

							else if(GetPlayerWeaponSkill(playerid, 10) < 500)
							{
								PlayErrorSound(playerid);
								ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_GUNS, b);
								SendClientMessage(playerid, COLOR_ERROR, "* Você não possui porte para esta arma, treine no estande antes.");
							}

							else
							{
								GivePlayerWeapon(playerid, 34, 10);
								GivePlayerCash(playerid, -WEAPON_SNIPER_PRICE);
								SendClientActionMessage(playerid, 30.0, "paga para o vendedor e recebe uma sniper.");
								ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_GUNS, b);
							}
						}
						case 13:
						{
							new weapon, ammo;
						    GetPlayerWeaponData(playerid, 7, weapon, ammo);
							if(weapon == 35)
							{
								PlayErrorSound(playerid);
								ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_GUNS, b);
								SendClientMessage(playerid, COLOR_ERROR, "* Você já possui essa arma, compre munições.");
							}

							else if(GetPlayerCash(playerid) < WEAPON_RPG_PRICE)
							{
								PlayErrorSound(playerid);
								ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_GUNS, b);
								SendClientMessage(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiante.");
							}

							else
							{
								GivePlayerWeapon(playerid, 35, 1);
								GivePlayerCash(playerid, -WEAPON_RPG_PRICE);
								SendClientActionMessage(playerid, 30.0, "paga para o vendedor e recebe uma RPG.");
								ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_GUNS, b);
							}
						}
						case 14:
						{
							new weapon, ammo;
						    GetPlayerWeaponData(playerid, 7, weapon, ammo);
							if(weapon == 36)
							{
								PlayErrorSound(playerid);
								ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_GUNS, b);
								SendClientMessage(playerid, COLOR_ERROR, "* Você já possui essa arma, compre munições.");
							}

							else if(GetPlayerCash(playerid) < WEAPON_HSR_PRICE)
							{
								PlayErrorSound(playerid);
								ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_GUNS, b);
								SendClientMessage(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiante.");
							}

							else
							{
								GivePlayerWeapon(playerid, 36, 1);
								GivePlayerCash(playerid, -WEAPON_HSR_PRICE);
								SendClientActionMessage(playerid, 30.0, "paga para o vendedor e recebe uma RPG Seguidora.");
								ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_GUNS, b);
							}
						}
						case 15:
						{
							if(GetPlayerCash(playerid) < WEAPON_GRENADE)
							{
								PlayErrorSound(playerid);
								ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_GUNS, b);
								SendClientMessage(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiante.");
							}

							else
							{
								GivePlayerWeapon(playerid, 16, 1);
								GivePlayerCash(playerid, -WEAPON_GRENADE);
								SendClientActionMessage(playerid, 30.0, "paga para o vendedor e recebe uma RPG Seguidora.");
								ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_GUNS, b);
							}
						}
					}
				}
			}
		}
		case DIALOG_AMMU_AMMO:
		{
			if(!response)
			{
				foreach(new b: Business)
					if(IsPlayerInBusiness(playerid, b, 25.0))
						if(gBusinessData[b][E_BUSINESS_TYPE] == BUSINESS_TYPE_AMMUNATION)
							ShowPlayerDialog(playerid, DIALOG_AMMU, DIALOG_STYLE_LIST, gBusinessData[b][E_BUSINESS_NAME], "Arma\nMunição", "Selecionar", "Cancelar");
				PlayerPlaySound(playerid, 1084, 0.0, 0.0, 0.0);
				return 1;
			}

			foreach(new b: Business)
			{
				if(!IsPlayerInBusiness(playerid, b, 25.0))
					continue;
				if(gBusinessData[b][E_BUSINESS_TYPE] != BUSINESS_TYPE_AMMUNATION)
					continue;

				if(gBusinessData[b][E_BUSINESS_PRODUCTS] < 1)
				{
					PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
					SendClientMessage(playerid, COLOR_ERROR, "* Desculpe, mas estamos sem produtos.");
					SetCameraBehindPlayer(playerid);
				}
				else
				{
					new weapon[12], ammo;
					new bool:found = false;
					for(new i = 0; i <= 12; i++)
					{
						GetPlayerWeaponData(playerid, i, weapon[i], ammo);
						if(weapon[i] == gAmmunationWeaponAmmo[listitem][0])
							found = true;
					}

					if(GetPlayerCash(playerid) < gAmmunationWeaponAmmo[listitem][1])
					{
						PlayErrorSound(playerid);
						ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_AMMO, b);
						SendClientMessage(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiante.");
					}

					else if(!found)
					{
						PlayErrorSound(playerid);
						ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_AMMO, b);
						SendClientMessage(playerid, COLOR_ERROR, "* Você não tem essa arma.");
					}

					else
					{
						GivePlayerWeapon(playerid, gAmmunationWeaponAmmo[listitem][0], gAmmunationWeaponAmmo[listitem][2]);
						GivePlayerCash(playerid, -gAmmunationWeaponAmmo[listitem][1]);
						SendClientActionMessage(playerid, 30.0, "paga para o vendedor e recebe uma uma caixa com munições.");
						ShowPlayerAmmunationDialog(playerid, DIALOG_AMMU_AMMO, b);
					}
				}
			}
		}
	}
	return 1;
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

/***
 *
 *     #####  #        ##   #   # ###### #####
 *     #    # #       #  #   # #  #      #    #
 *     #    # #      #    #   #   #####  #    #
 *     #####  #      ######   #   #      #####
 *     #      #      #    #   #   #      #   #
 *     #      ###### #    #   #   ###### #    #
 *
 */

//------------------------------------------------------------------------------

/* *************************************************************************** *
*  Assignment: Open a dialog with options to buy items.
*
*  Params:
*			playerid: ID of the playerid.
* 			params[]: Params passed when used the command.
*
*  Returns:
*			Nothing
* *************************************************************************** */
YCMD:comprar(playerid, params[], help)
{
	foreach(new b: Business)
	{
		if(IsPlayerInBusiness(playerid, b, 25.0))
		{
			if(gBusinessData[b][E_BUSINESS_TYPE] == 1)
			{
				if(gBusinessData[b][E_BUSINESS_PRODUCTS] > 0)
				{

					new listitems[256];
					format(listitems, sizeof listitems, "1.\tGPS\t\t\t$%i\n2.\tWalkie Talkie\t\t$%i\n3.\tCigarros\t\t\t$%i\n4.\tIsqueiro\t\t\t$%i\n5.\tSpray de Pimenta\t\t$%i\n6.\tAgenda Telefonica\t\t$%i", ITEM_GPS_PRICE, ITEM_WALKIE_TALKIE_PRICE, ITEM_CIGARETTS_PRICE, ITEM_LIGHTER_PRICE, ITEM_SPRAY_PRICE, ITEM_AGENDA_PRICE);
					ShowPlayerDialog(playerid, DIALOG_STORE, DIALOG_STYLE_LIST, gBusinessData[b][E_BUSINESS_NAME], listitems, "Comprar", "Cancelar");
					return 1;
				}
				else
				{
					SendClientMessage(playerid, COLOR_ERROR, "* Desculpe, mas estamos sem produtos.");
					return 1;
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_ERROR, "* Desculpe, mas vendemos isto.");
				return 1;
			}
		}
	}
	SendClientMessage(playerid, COLOR_ERROR, "* Você não está em uma loja 24-7.");
	return 1;
}

//------------------------------------------------------------------------------

/* *************************************************************************** *
*  Assignment: Shows player business commands.
*
*  Params:
*			playerid: ID of the playerid.
* 			params[]: Params passed when used the command.
*
*  Returns:
*			Nothing
* *************************************************************************** */
YCMD:ajudaempresa(playerid, params[], help)
{
	SendClientMessage(playerid, COLOR_TITLE, "~~~~~~~~~~~~~~~~~~~~ Comandos Empresa ~~~~~~~~~~~~~~~~~~~~");
	SendClientMessage(playerid, COLOR_SUB_TITLE, "* /comprarempresa - /venderempresa - /sacarempresa - /depositarempresa - /infoempresa");
	SendClientMessage(playerid, COLOR_SUB_TITLE, "* /trancarempresa - /nomeempresa - /produtoempresa");
	SendClientMessage(playerid, COLOR_TITLE, "~~~~~~~~~~~~~~~~~~~~ Comandos Empresa ~~~~~~~~~~~~~~~~~~~~");
	return 1;
}

//------------------------------------------------------------------------------

/* *************************************************************************** *
*  Assignment: Buys a business.
*
*  Params:
*			playerid: ID of the playerid.
* 			params[]: Params passed when used the command.
*
*  Returns:
*			Nothing
* *************************************************************************** */
YCMD:comprarempresa(playerid, params[], help)
{
	if(GetPlayerBusinessID(playerid) != INVALID_BUSINESS_ID)
	{
		SendClientMessage(playerid, COLOR_ERROR, "* Você já possui uma empresa.");
	}
	else
	{
		new
			businessid = GetPlayerClosestBusinessID(playerid);

		if(businessid != INVALID_BUSINESS_ID)
		{
			if(gBusinessData[businessid][E_BUSINESS_OWNED])
			{
				SendClientMessage(playerid, COLOR_ERROR, "* Esta empresa já tem dono.");
			}

			else if(gBusinessData[businessid][E_BUSINESS_PRICE] < 1)
			{
				SendClientMessage(playerid, COLOR_ERROR, "* Esta empresa não está a venda.");
			}

			else if(GetPlayerCash(playerid) < gBusinessData[businessid][E_BUSINESS_PRICE])
			{
				SendClientMessagef(playerid, COLOR_ERROR, "* Você não possui dinheiro suficiente. [$%i]", gBusinessData[businessid][E_BUSINESS_PRICE]);
			}

			else
			{
				SendClientMessage(playerid, COLOR_INFO, "* Você comprou a empresa.");
				SendClientActionMessage(playerid, 30, "assina os papeis e recebe a chave da empresa.");

				SetPlayerBusinessID(playerid, businessid);
				GivePlayerCash(playerid, -gBusinessData[businessid][E_BUSINESS_PRICE]);

				SetBusinessOwned(businessid,		1);
				SetBusinessProducts(businessid,		250);
				SetBusinessProductPrice(businessid,	10);
				SetBusinessLocked(businessid,		0);
				SetBusinessTill(businessid,			0);
				SetBusinessOwnerName(businessid, GetPlayerNamef(playerid, false));

				UpdateBusinessPickup(businessid);
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_ERROR, "* Você não está no icone de uma empresa.");
		}
	}
	return 1;
}

//------------------------------------------------------------------------------

/* *************************************************************************** *
*  Assignment: Sells a business.
*
*  Params:
*			playerid: ID of the playerid.
* 			params[]: Params passed when used the command.
*
*  Returns:
*			Nothing
* *************************************************************************** */
YCMD:venderempresa(playerid, params[], help)
{
	new
		playerName[MAX_PLAYER_NAME],
		businessid = GetPlayerBusinessID(playerid);

	GetPlayerName(playerid, playerName, sizeof(playerName));

	if(businessid != INVALID_BUSINESS_ID && strcmp(playerName, gBusinessData[businessid][E_BUSINESS_OWNER], true) == 0)
	{
		if(IsPlayerInRangeOfBusiness(playerid, businessid))
		{
			SendClientMessage(playerid, COLOR_INFO, "* Você vendeu sua empresa.");
			SendClientActionMessage(playerid, 30, "rasga os papeis e joga a chave da empresa fora.");

			SetPlayerBusinessID(playerid, INVALID_BUSINESS_ID);
			GivePlayerCash(playerid, gBusinessData[businessid][E_BUSINESS_PRICE] / 3);

			SetBusinessOwned(businessid,		0);
			SetBusinessProducts(businessid,		2500);
			SetBusinessProductPrice(businessid,	10);
			SetBusinessLocked(businessid,		0);
			SetBusinessTill(businessid,			0);
			SetBusinessOwnerName(businessid, "Ninguem");

			UpdateBusinessPickup(businessid);
		}
		else
		{
			SendClientMessage(playerid, COLOR_ERROR, "* Você não está na entrada de sua empresa.");
		}
	}
	else
	{
		SendClientMessage(playerid, COLOR_ERROR, "* Você não possui uma empresa.");
	}
	return 1;
}

//------------------------------------------------------------------------------

/* *************************************************************************** *
*  Assignment: Withdraw business cash.
*
*  Params:
*			playerid: ID of the playerid.
* 			params[]: Params passed when used the command.
*
*  Returns:
*			Nothing
* *************************************************************************** */
YCMD:sacarempresa(playerid, params[], help)
{
	new
		playerName[MAX_PLAYER_NAME],
		businessid = GetPlayerBusinessID(playerid);

	GetPlayerName(playerid, playerName, sizeof(playerName));

	if(businessid != INVALID_BUSINESS_ID && strcmp(playerName, gBusinessData[businessid][E_BUSINESS_OWNER], true) == 0)
	{
		if(IsPlayerInBusiness(playerid, businessid))
		{
			new
				value;

			if(sscanf(params, "i", value))
			{
				SendClientMessage(playerid, COLOR_INFO, "* /sacarempresa [quantia]");
			}

			else if(value > gBusinessData[businessid][E_BUSINESS_TILL])
			{
				SendClientMessage(playerid, COLOR_ERROR, "* Você não tem esta quantia de dinheiro no cofre.");
			}

			else if(value < 1)
			{
				SendClientMessage(playerid, COLOR_ERROR, "* Use apenas valores positivos.");
			}

			else
			{
				SendClientMessagef(playerid, COLOR_INFO, "* Você sacou $%i do cofre da sua empresa.", value);
				SendClientActionMessage(playerid, 30, "abre o cofre da empresa e retira uma quantia de dinheiro.");

				GivePlayerCash(playerid, value);
				SetBusinessTill(businessid, GetBusinessTill(businessid) - value);
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_ERROR, "* Você não está dentro da sua empresa.");
		}
	}
	else
	{
		SendClientMessage(playerid, COLOR_ERROR, "* Você não possui uma empresa.");
	}
	return 1;
}

//------------------------------------------------------------------------------

/* *************************************************************************** *
*  Assignment: Deposits business cash.
*
*  Params:
*			playerid: ID of the playerid.
* 			params[]: Params passed when used the command.
*
*  Returns:
*			Nothing
* *************************************************************************** */
YCMD:depositarempresa(playerid, params[], help)
{
	new
		playerName[MAX_PLAYER_NAME],
		businessid = GetPlayerBusinessID(playerid);
	GetPlayerName(playerid, playerName, sizeof(playerName));

	if(businessid != INVALID_BUSINESS_ID && strcmp(playerName, gBusinessData[businessid][E_BUSINESS_OWNER], true) == 0)
	{
		if(IsPlayerInBusiness(playerid, businessid))
		{
			new
				value;

			if(sscanf(params, "i", value))
			{
				SendClientMessage(playerid, COLOR_INFO, "* /depositarempresa [quantia]");
			}

			else if(value > GetPlayerCash(playerid))
			{
				SendClientMessage(playerid, COLOR_ERROR, "* Você não tem esta quantia de dinheiro.");
			}

			else if(value < 1)
			{
				SendClientMessage(playerid, COLOR_ERROR, "* Use apenas valores positivos.");
			}

			else
			{
				SendClientMessagef(playerid, COLOR_INFO, "* Você depositou $%i no cofre da sua empresa.", value);
				SendClientActionMessage(playerid, 30, "abre o cofre da empresa e deposita uma quantia de dinheiro.");

				GivePlayerCash(playerid, -value);
				SetBusinessTill(businessid, GetBusinessTill(businessid) + value);
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_ERROR, "* Você não está dentro da sua empresa.");
		}
	}
	else
	{
		SendClientMessage(playerid, COLOR_ERROR, "* Você não possui uma empresa.");
	}
	return 1;
}

//------------------------------------------------------------------------------

/* *************************************************************************** *
*  Assignment: Toggle business locked state.
*
*  Params:
*			playerid: ID of the playerid.
* 			params[]: Params passed when used the command.
*
*  Returns:
*			Nothing
* *************************************************************************** */
YCMD:trancarempresa(playerid, params[], help)
{
	new
		playerName[MAX_PLAYER_NAME],
		businessid = GetPlayerBusinessID(playerid);
	GetPlayerName(playerid, playerName, sizeof(playerName));

	if(businessid != INVALID_BUSINESS_ID && strcmp(playerName, gBusinessData[businessid][E_BUSINESS_OWNER], true) == 0)
	{
		if(IsPlayerInRangeOfBusiness(playerid, businessid))
		{
			if(gBusinessData[businessid][E_BUSINESS_TYPE] == BUSINESS_TYPE_FUEL)
            {
				PlayErrorSound(playerid);
				SendClientMessage(playerid, COLOR_ERROR, "* Não é possível destrancar esta empresa!");
				return 1;
			}
			switch(gBusinessData[businessid][E_BUSINESS_LOCKED])
			{
				case 0:
				{
					SendClientMessage(playerid, COLOR_INFO, "* Você trancou sua empresa.");
					SendClientActionMessage(playerid, 30, "gira a chave e tranca a empresa.");
					SetBusinessLocked(businessid, true);
				}
				default:
				{
					SendClientMessage(playerid, COLOR_INFO, "* Você destrancou sua empresa.");
					SendClientActionMessage(playerid, 30, "gira a chave e destranca a empresa.");
					SetBusinessLocked(businessid, false);
				}
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_ERROR, "* Você não está na entrada da sua empresa.");
		}
	}
	else
	{
		SendClientMessage(playerid, COLOR_ERROR, "* Você não possui uma empresa.");
	}
	return 1;
}

//------------------------------------------------------------------------------

/* *************************************************************************** *
*  Assignment: Sets business product price.
*
*  Params:
*			playerid: ID of the playerid.
* 			params[]: Params passed when used the command.
*
*  Returns:
*			Nothing
* *************************************************************************** */
YCMD:produtoempresa(playerid, params[], help)
{
	new
		playerName[MAX_PLAYER_NAME],
		businessid = GetPlayerBusinessID(playerid);

	GetPlayerName(playerid, playerName, sizeof(playerName));

	if(businessid != INVALID_BUSINESS_ID && strcmp(playerName, gBusinessData[businessid][E_BUSINESS_OWNER], true) == 0)
	{
		if(IsPlayerInBusiness(playerid, businessid))
		{
			new
				value;

			if(sscanf(params, "i", value))
			{
				SendClientMessage(playerid, COLOR_INFO, "* /produtoempresa [preço]");
			}

			else if(value < 0 || value > 999)
			{
				SendClientMessage(playerid, COLOR_ERROR, "* Use apenas valores entre $0 e $999.");
			}
			else
			{

				SendClientMessagef(playerid, COLOR_INFO, "* Sua empresa agora pagará $%i por produtos.", value);
				SetBusinessProductPrice(businessid, value);
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_ERROR, "* Você não está dentro da sua empresa.");
		}
	}
	else
	{
		SendClientMessage(playerid, COLOR_ERROR, "* Você não possui uma empresa.");
	}
	return 1;
}

//------------------------------------------------------------------------------

/* *************************************************************************** *
*  Assignment: Sets business name.
*
*  Params:
*			playerid: ID of the playerid.
* 			params[]: Params passed when used the command.
*
*  Returns:
*			Nothing
* *************************************************************************** */
YCMD:nomeempresa(playerid, params[], help)
{
	new
		playerName[MAX_PLAYER_NAME],
		businessid = GetPlayerBusinessID(playerid);
	GetPlayerName(playerid, playerName, sizeof(playerName));

	if(businessid != INVALID_BUSINESS_ID && strcmp(playerName, gBusinessData[businessid][E_BUSINESS_OWNER], true) == 0)
	{
		if(IsPlayerInBusiness(playerid, businessid) || GetBusinessType(businessid) == BUSINESS_TYPE_FUEL)
		{
			new
				name[MAX_BUSINESS_NAME];

			if(sscanf(params, "s[64]", name))
			{
				SendClientMessage(playerid, COLOR_INFO, "* /nomeempresa [nome]");
			}
			else
			{
				SendClientMessagef(playerid, COLOR_INFO, "* Sua empresa agora se chama %s.", name);

				SetBusinessName(businessid, name);
				UpdateBusinessText3D(businessid);
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_ERROR, "* Você não está dentro da sua empresa.");
		}
	}
	else
	{
		SendClientMessage(playerid, COLOR_ERROR, "* Você não possui uma empresa.");
	}
	return 1;
}

//------------------------------------------------------------------------------

/* *************************************************************************** *
*  Assignment: Shows info of the business.
*
*  Params:
*			playerid: ID of the playerid.
* 			params[]: Params passed when used the command.
*
*  Returns:
*			Nothing
* *************************************************************************** */
YCMD:infoempresa(playerid, params[], help)
{
	new
		playerName[MAX_PLAYER_NAME],
		businessid = GetPlayerBusinessID(playerid);
	GetPlayerName(playerid, playerName, sizeof(playerName));

	if(businessid != INVALID_BUSINESS_ID && strcmp(playerName, gBusinessData[businessid][E_BUSINESS_OWNER], true) == 0)
	{
		if(IsPlayerInRangeOfBusiness(playerid, businessid))
		{
			new
				lockedText[4];

			switch(gBusinessData[businessid][E_BUSINESS_LOCKED])
			{
				case 0: lockedText = "Não";
				case 1: lockedText = "Sim";
				default: lockedText = "???";
			}

			SendClientMessage(playerid,  0xFAD669FF, "~~~~~~~~~~~~~~~~~~~~ Estatisticas Empresa ~~~~~~~~~~~~~~~~~~~~");
			SendClientMessagef(playerid, -1, "* Nome: %s - Produtos: %i.", gBusinessData[businessid][E_BUSINESS_NAME], gBusinessData[businessid][E_BUSINESS_PRODUCTS]);
			SendClientMessagef(playerid, -1, "* Cofre: $%i - Trancada: %s.", gBusinessData[businessid][E_BUSINESS_TILL], lockedText);
			SendClientMessage(playerid,  0xFAD669FF, "~~~~~~~~~~~~~~~~~~~~ Estatisticas Empresa ~~~~~~~~~~~~~~~~~~~~");
			SendClientActionMessage(playerid, 30, "confere as estatisticas da empresa.");
		}
		else
		{
			SendClientMessage(playerid, COLOR_ERROR, "* Você não está na entrada da sua empresa.");
		}
	}
	else
	{
		SendClientMessage(playerid, COLOR_ERROR, "* Você não possui uma empresa.");
	}
	return 1;
}

//------------------------------------------------------------------------------

/***
 *     ######  ####### #     # ####### #       ####### ######  ####### ######
 *     #     # #       #     # #       #       #     # #     # #       #     #
 *     #     # #       #     # #       #       #     # #     # #       #     #
 *     #     # #####   #     # #####   #       #     # ######  #####   ######
 *     #     # #        #   #  #       #       #     # #       #       #   #
 *     #     # #         # #   #       #       #     # #       #       #    #
 *     ######  #######    #    ####### ####### ####### #       ####### #     #
 *
 */

/* *************************************************************************** *
*  Assignment: Show business develper commands.
*
*  Params:
*			playerid: ID of the playerid.
* 			params[]: Params passed when used the command.
*
*  Returns:
*			Nothing
* *************************************************************************** */
YCMD:abusinesscmds(playerid, params[], help)
{
	if(GetPlayerRank(playerid) < PLAYER_RANK_DEVELOPER)
	{
		SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");
	}
	else
	{
		SendClientMessage(playerid, COLOR_TITLE, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Business Comandos ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
		SendClientMessage(playerid, COLOR_SUB_TITLE, "/abusinessentrance - /abusinessexit - /abusinessprice - /abusinesslock - /abusinesstill - /abusinessprodprice");
		SendClientMessage(playerid, COLOR_SUB_TITLE, "/abusinessproducts - /abusinesssell - /abusinesstype - /abusinessname - /abusinessvowner - /abusinessowner");
		SendClientMessage(playerid, COLOR_TITLE, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	}
	return 1;
}

//------------------------------------------------------------------------------

/* *************************************************************************** *
*  Assignment: Sets the business entrance position, world and interior.
*
*  Params:
*			playerid: ID of the playerid.
* 			params[]: Params passed when used the command.
*
*  Returns:
*			Nothing
* *************************************************************************** */
YCMD:abusinessentrance(playerid, params[], help)
{
	if(GetPlayerRank(playerid) < PLAYER_RANK_DEVELOPER)
	{
		SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");
	}
	else
	{
		new
			businessid;

		if(sscanf(params, "i", businessid))
		{
			SendClientMessage(playerid, COLOR_INFO, "* /abusinessentrance [empresaid]");
		}

		else if(businessid < 1 || businessid > (MAX_BUSINESS - 1))
		{
			SendClientMessagef(playerid, COLOR_ERROR, "* Empresa inválida. [Apenas valores entre 1 e %i]", MAX_BUSINESS - 1);
		}

		else
		{

			if(gBusinessData[businessid][E_BUSINESS_ENTERX] == 0.0 && gBusinessData[businessid][E_BUSINESS_ENTERY] == 0.0)
			{
				Iter_Add(Business, businessid);
			}

			GetPlayerPos(playerid, gBusinessData[businessid][E_BUSINESS_ENTERX], gBusinessData[businessid][E_BUSINESS_ENTERY], gBusinessData[businessid][E_BUSINESS_ENTERZ]);
			GetPlayerFacingAngle(playerid, gBusinessData[businessid][E_BUSINESS_ENTERA]);

			gBusinessData[businessid][E_BUSINESS_ENTERINT] = GetPlayerInterior(playerid);
			gBusinessData[businessid][E_BUSINESS_ENTERWORLD] = GetPlayerVirtualWorld(playerid);

			UpdateBusinessPickup(businessid);

			SendClientMessagef(playerid, COLOR_SUCCESS, "* Você alterou a posição da entrada da empresa %i.", businessid);
			SaveBusinessEntrancePos(businessid);
		}
	}
	return 1;
}

//------------------------------------------------------------------------------

/* *************************************************************************** *
*  Assignment: Sets the business entrance position and interior.
*
*  Params:
*			playerid: ID of the playerid.
* 			params[]: Params passed when used the command.
*
*  Returns:
*			Nothing
* *************************************************************************** */
YCMD:abusinessexit(playerid, params[], help)
{
	if(GetPlayerRank(playerid) < PLAYER_RANK_DEVELOPER)
	{
		SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");
	}
	else
	{
		new
			businessid;

		if(sscanf(params, "i", businessid))
		{
			SendClientMessage(playerid, COLOR_INFO, "* /abusinessexit [empresaid]");
		}

		else if(businessid < 1 || businessid > (MAX_BUSINESS - 1))
		{
			SendClientMessagef(playerid, COLOR_ERROR, "* Empresa inválida. [Apenas valores entre 1 e %i]", MAX_BUSINESS - 1);
		}

		else
		{
			GetPlayerPos(playerid, gBusinessData[businessid][E_BUSINESS_EXITX], gBusinessData[businessid][E_BUSINESS_EXITY], gBusinessData[businessid][E_BUSINESS_EXITZ]);
			GetPlayerFacingAngle(playerid, gBusinessData[businessid][E_BUSINESS_EXITA]);

			gBusinessData[businessid][E_BUSINESS_EXITINT] = GetPlayerInterior(playerid);

			SendClientMessagef(playerid, COLOR_SUCCESS, "* Você alterou a posição da saída da empresa %i.", businessid);

			UpdateBusinessPickup(businessid);
			SaveBusinessExitPos(businessid);
		}
	}
	return 1;
}

//------------------------------------------------------------------------------

/* *************************************************************************** *
*  Assignment: Sets the business price.
*
*  Params:
*			playerid: ID of the playerid.
* 			params[]: Params passed when used the command.
*
*  Returns:
*			Nothing
* *************************************************************************** */
YCMD:abusinessprice(playerid, params[], help)
{
	if(GetPlayerRank(playerid) < PLAYER_RANK_DEVELOPER)
	{
		SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");
	}
	else
	{
		new
			businessid,
			price;

		if(sscanf(params, "ii", businessid, price))
		{
			SendClientMessage(playerid, COLOR_INFO, "* /abusinessprice [empresaid] [preço]");
		}

		else if(businessid < 1 || businessid > (MAX_BUSINESS - 1))
		{
			SendClientMessagef(playerid, COLOR_ERROR, "* Empresa inválida. [Apenas valores entre 1 e %i]", MAX_BUSINESS - 1);
		}

		else if(price < 0)
		{
			SendClientMessage(playerid, COLOR_ERROR, "* Use apenas valores positivos.");
		}

		else
		{
			SendClientMessagef(playerid, COLOR_SUCCESS, "* Você alterou o preço da empresa %i para $%i.", businessid, price);
			SetBusinessPrice(businessid, price);
			UpdateBusinessText3D(businessid);
		}
	}
	return 1;
}

//------------------------------------------------------------------------------

/* *************************************************************************** *
*  Assignment: Sets the business lock state.
*
*  Params:
*			playerid: ID of the playerid.
* 			params[]: Params passed when used the command.
*
*  Returns:
*			Nothing
* *************************************************************************** */
YCMD:abusinesslock(playerid, params[], help)
{
	if(GetPlayerRank(playerid) < PLAYER_RANK_DEVELOPER)
	{
		SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");
	}
	else
	{
		new
			businessid;

		if(sscanf(params, "i", businessid))
		{
			SendClientMessage(playerid, COLOR_INFO, "* /abusinesslock [empresaid]");
		}

		else if(businessid < 1 || businessid > (MAX_BUSINESS - 1))
		{
			SendClientMessagef(playerid, COLOR_ERROR, "* Empresa inválida. [Apenas valores entre 1 e %i]", MAX_BUSINESS - 1);
		}

		else
		{
			if(gBusinessData[businessid][E_BUSINESS_LOCKED])
			{
				SendClientMessagef(playerid, COLOR_SUCCESS, "* Você destrancou a empresaid %i.", businessid);
				SetBusinessLocked(businessid, false);
			}
			else
			{
				SendClientMessagef(playerid, COLOR_SUCCESS, "* Você trancou a empresaid %i.", businessid);
				SetBusinessLocked(businessid, true);
			}
		}
	}
	return 1;
}

//------------------------------------------------------------------------------

/* *************************************************************************** *
*  Assignment: Sets the business till value.
*
*  Params:
*			playerid: ID of the playerid.
* 			params[]: Params passed when used the command.
*
*  Returns:
*			Nothing
* *************************************************************************** */
YCMD:abusinesstill(playerid, params[], help)
{
	if(GetPlayerRank(playerid) < PLAYER_RANK_DEVELOPER)
	{
		SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");
	}
	else
	{
		new
			businessid,
			value;

		if(sscanf(params, "ii", businessid, value))
		{
			SendClientMessage(playerid, COLOR_INFO, "* /abusinesstill [empresaid] [quantia]");
		}

		else if(businessid < 1 || businessid > (MAX_BUSINESS - 1))
		{
			SendClientMessagef(playerid, COLOR_ERROR, "* Empresa inválida. [Apenas valores entre 1 e %i]", MAX_BUSINESS - 1);
		}

		else if(value < 0)
		{
			SendClientMessage(playerid, COLOR_ERROR, "* Use apenas valores positivos.");
		}

		else
		{
			SendClientMessagef(playerid, COLOR_SUCCESS, "* Você alterou a quantia do cofre da empresa %i para $%i.", businessid, value);
			SetBusinessTill(businessid, value);
		}
	}
	return 1;
}

//------------------------------------------------------------------------------

/* *************************************************************************** *
*  Assignment: Sets the business products price.
*
*  Params:
*			playerid: ID of the playerid.
* 			params[]: Params passed when used the command.
*
*  Returns:
*			Nothing
* *************************************************************************** */
YCMD:abusinessprodprice(playerid, params[], help)
{
	if(GetPlayerRank(playerid) < PLAYER_RANK_DEVELOPER)
	{
		SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");
	}
	else
	{
		new
			businessid,
			price;

		if(sscanf(params, "ii", businessid, price))
		{
			SendClientMessage(playerid, COLOR_INFO, "* /abusinessprodprice [empresaid] [preço]");
		}

		else if(businessid < 1 || businessid > (MAX_BUSINESS - 1))
		{
			SendClientMessagef(playerid, COLOR_ERROR, "* Empresa inválida. [Apenas valores entre 1 e %i]", MAX_BUSINESS - 1);
		}

		else if(price < 0)
		{
			SendClientMessage(playerid, COLOR_ERROR, "* Use apenas valores positivos.");
		}

		else
		{
			SendClientMessagef(playerid, COLOR_SUCCESS, "* Você alterou o preço dos produtos da empresa %i para $%i.", businessid, price);
			SetBusinessProductPrice(businessid, price);
		}
	}
	return 1;
}

//------------------------------------------------------------------------------

/* *************************************************************************** *
*  Assignment: Sets the business products amount.
*
*  Params:
*			playerid: ID of the playerid.
* 			params[]: Params passed when used the command.
*
*  Returns:
*			Nothing
* *************************************************************************** */
YCMD:abusinessproducts(playerid, params[], help)
{
	if(GetPlayerRank(playerid) < PLAYER_RANK_DEVELOPER)
	{
		SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");
	}
	else
	{
		new
			businessid,
			value;

		if(sscanf(params, "ii", businessid, value))
		{
			SendClientMessage(playerid, COLOR_INFO, "* /abusinessproducts [empresaid] [quantia]");
		}

		else if(businessid < 1 || businessid > (MAX_BUSINESS - 1))
		{
			SendClientMessagef(playerid, COLOR_ERROR, "* Empresa inválida. [Apenas valores entre 1 e %i]", MAX_BUSINESS - 1);
		}

		else if(value < 0)
		{
			SendClientMessage(playerid, COLOR_ERROR, "* Use apenas valores positivos.");
		}

		else
		{
			SendClientMessagef(playerid, COLOR_SUCCESS, "* Você alterou a quantidade de produtos da empresa %i para %i.", businessid, value);
			SetBusinessProducts(businessid, value);
		}
	}
	return 1;
}

//------------------------------------------------------------------------------

/* *************************************************************************** *
*  Assignment: Sets the business type.
*
*  Params:
*			playerid: ID of the playerid.
* 			params[]: Params passed when used the command.
*
*  Returns:
*			Nothing
* *************************************************************************** */
YCMD:abusinesstype(playerid, params[], help)
{
	if(GetPlayerRank(playerid) < PLAYER_RANK_DEVELOPER)
	{
		SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");
	}
	else
	{
		new
			businessid,
			value;

		if(sscanf(params, "ii", businessid, value))
		{
			SendClientMessage(playerid, COLOR_INFO, "* /abusinesstype [empresaid] [tipo]");
			SendClientMessage(playerid, COLOR_INFO, "* 1. 24-7 | 2. Telefonia | 3. Restaurante | 4. Ammu-nation | 5. Loja de Roupas | 6. Posto de Gasolina");
			SendClientMessage(playerid, COLOR_INFO, "* 7. Publicidade | 8. Bar/Club | 9. Locadora de veículo | 10. Fast-food(Burger Shot) | 11. Fast-food(Cluckin' Bell)");
			SendClientMessage(playerid, COLOR_INFO, "* 12. Fast-food(Pizzaria)");
		}

		else if(businessid < 1 || businessid > (MAX_BUSINESS - 1))
		{
			SendClientMessagef(playerid, COLOR_ERROR, "* Empresa inválida. [Apenas valores entre 1 e %i]", MAX_BUSINESS - 1);
		}

		else if(value < 0)
		{
			SendClientMessage(playerid, COLOR_ERROR, "* Use apenas valores positivos.");
		}

		else
		{
			SetBusinessType(businessid, value);
			SendClientMessagef(playerid, COLOR_SUCCESS, "* Você alterou o tipo da empresa %i para %s.", businessid, GetBusinessTypeName(businessid));
			UpdateBusinessText3D(businessid);
		}
	}
	return 1;
}

//------------------------------------------------------------------------------

/* *************************************************************************** *
*  Assignment: Sells a business.
*
*  Params:
*			playerid: ID of the playerid.
* 			params[]: Params passed when used the command.
*
*  Returns:
*			Nothing
* *************************************************************************** */
YCMD:abusinesssell(playerid, params[], help)
{
	if(GetPlayerRank(playerid) < PLAYER_RANK_DEVELOPER)
	{
		SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");
	}
	else
	{
		new
			businessid;

		if(sscanf(params, "i", businessid))
		{
			SendClientMessage(playerid, COLOR_INFO, "* /abusinesssell [empresaid]");
		}

		else if(businessid < 1 || businessid > (MAX_BUSINESS - 1))
		{
			SendClientMessagef(playerid, COLOR_ERROR, "* Empresa inválida. [Apenas valores entre 1 e %i]", MAX_BUSINESS - 1);
		}

		else
		{
			SendClientMessagef(playerid, COLOR_SUCCESS, "* Você vendeu a empresa %i.", businessid);

			SetBusinessOwned(businessid,		0);
			SetBusinessLocked(businessid,		0);
			SetBusinessTill(businessid,			0);
			SetBusinessProducts(businessid,		0);
			SetBusinessProductPrice(businessid,	10);
			SetBusinessOwnerName(businessid,	"Ninguem");

			UpdateBusinessPickup(businessid);
		}
	}
	return 1;
}

//------------------------------------------------------------------------------

/* *************************************************************************** *
*  Assignment: Sets the name.
*
*  Params:
*			playerid: ID of the playerid.
* 			params[]: Params passed when used the command.
*
*  Returns:
*			Nothing
* *************************************************************************** */
YCMD:abusinessname(playerid, params[], help)
{
	if(GetPlayerRank(playerid) < PLAYER_RANK_DEVELOPER)
	{
		SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");
	}
	else
	{
		new
			businessid,
			name[MAX_BUSINESS_NAME];

		if(sscanf(params, "is[64]", businessid, name))
		{
			SendClientMessage(playerid, COLOR_INFO, "* /abusinessname [empresaid] [nome]");
		}

		else if(businessid < 1 || businessid > (MAX_BUSINESS - 1))
		{
			SendClientMessagef(playerid, COLOR_ERROR, "* Empresa inválida. [Apenas valores entre 1 e %i]", MAX_BUSINESS - 1);
		}

		else
		{
			SendClientMessagef(playerid, COLOR_SUCCESS, "* Você alterou o nome da empresa %i para %s.", businessid, name);
			SetBusinessName(businessid, name);
			UpdateBusinessText3D(businessid);
		}
	}
	return 1;
}

//------------------------------------------------------------------------------

/* *************************************************************************** *
*  Assignment: Sets the business owner name.
*
*  Params:
*			playerid: ID of the playerid.
* 			params[]: Params passed when used the command.
*
*  Returns:
*			Nothing
* *************************************************************************** */
YCMD:abusinessowner(playerid, params[], help)
{
	if(GetPlayerRank(playerid) < PLAYER_RANK_DEVELOPER)
	{
		SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");
	}
	else
	{
		new
			businessid,
			name[MAX_PLAYER_NAME];

		if(sscanf(params, "is[25]", businessid, name))
		{
			SendClientMessage(playerid, COLOR_INFO, "* /abusinessowner [empresaid] [nome]");
		}

		else if(businessid < 1 || businessid > (MAX_BUSINESS - 1))
		{
			SendClientMessagef(playerid, COLOR_ERROR, "* Empresa inválida. [Apenas valores entre 1 e %i]", MAX_BUSINESS - 1);
		}

		else
		{
			SendClientMessagef(playerid, COLOR_SUCCESS, "* Você alterou o nome do dono da empresa %i para %s.", businessid, name);

			SetBusinessOwnerName(businessid, name);
			UpdateBusinessText3D(businessid);
		}
	}
	return 1;
}
