/*******************************************************************************
* FILENAME :        util.inc
*
* DESCRIPTION :
*       Useful functions and macros for SA-MP.
*
* NOTES :
*       -
*
*       Copyright Larceny 2015.  All rights reserved.
*
* AUTHOR :    Larceny           START DATE :    25 Jul 15
*
*/

//------------------------------------------------------------------------------

new aVehicleNames[212][] = {	// Vehicle Names - Betamaster
	{"Landstalker"},
	{"Bravura"},
	{"Buffalo"},
	{"Linerunner"},
	{"Perrenial"},
	{"Sentinel"},
	{"Dumper"},
	{"Firetruck"},
	{"Trashmaster"},
	{"Stretch"},
	{"Manana"},
	{"Infernus"},
	{"Voodoo"},
	{"Pony"},
	{"Mule"},
	{"Cheetah"},
	{"Ambulance"},
	{"Leviathan"},
	{"Moonbeam"},
	{"Esperanto"},
	{"Taxi"},
	{"Washington"},
	{"Bobcat"},
	{"Mr Whoopee"},
	{"BF Injection"},
	{"Hunter"},
	{"Premier"},
	{"Enforcer"},
	{"Securicar"},
	{"Banshee"},
	{"Predator"},
	{"Bus"},
	{"Rhino"},
	{"Barracks"},
	{"Hotknife"},
	{"Trailer 1"}, //artict1
	{"Previon"},
	{"Coach"},
	{"Cabbie"},
	{"Stallion"},
	{"Rumpo"},
	{"RC Bandit"},
	{"Romero"},
	{"Packer"},
	{"Monster"},
	{"Admiral"},
	{"Squalo"},
	{"Seasparrow"},
	{"Pizzaboy"},
	{"Tram"},
	{"Trailer 2"}, //artict2
	{"Turismo"},
	{"Speeder"},
	{"Reefer"},
	{"Tropic"},
	{"Flatbed"},
	{"Yankee"},
	{"Caddy"},
	{"Solair"},
	{"Berkley's RC Van"},
	{"Skimmer"},
	{"PCJ-600"},
	{"Faggio"},
	{"Freeway"},
	{"RC Baron"},
	{"RC Raider"},
	{"Glendale"},
	{"Oceanic"},
	{"Sanchez"},
	{"Sparrow"},
	{"Patriot"},
	{"Quad"},
	{"Coastguard"},
	{"Dinghy"},
	{"Hermes"},
	{"Sabre"},
	{"Rustler"},
	{"ZR-350"},
	{"Walton"},
	{"Regina"},
	{"Comet"},
	{"BMX"},
	{"Burrito"},
	{"Camper"},
	{"Marquis"},
	{"Baggage"},
	{"Dozer"},
	{"Maverick"},
	{"News Chopper"},
	{"Rancher"},
	{"FBI Rancher"},
	{"Virgo"},
	{"Greenwood"},
	{"Jetmax"},
	{"Hotring"},
	{"Sandking"},
	{"Blista Compact"},
	{"Police Maverick"},
	{"Boxville"},
	{"Benson"},
	{"Mesa"},
	{"RC Goblin"},
	{"Hotring Racer A"}, //hotrina
	{"Hotring Racer B"}, //hotrinb
	{"Bloodring Banger"},
	{"Rancher"},
	{"Super GT"},
	{"Elegant"},
	{"Journey"},
	{"Bike"},
	{"Mountain Bike"},
	{"Beagle"},
	{"Cropdust"},
	{"Stunt"},
	{"Tanker"}, //petro
	{"Roadtrain"},
	{"Nebula"},
	{"Majestic"},
	{"Buccaneer"},
	{"Shamal"},
	{"Hydra"},
	{"FCR-900"},
	{"NRG-500"},
	{"HPV1000"},
	{"Cement Truck"},
	{"Tow Truck"},
	{"Fortune"},
	{"Cadrona"},
	{"FBI Truck"},
	{"Willard"},
	{"Forklift"},
	{"Tractor"},
	{"Combine"},
	{"Feltzer"},
	{"Remington"},
	{"Slamvan"},
	{"Blade"},
	{"Freight"},
	{"Streak"},
	{"Vortex"},
	{"Vincent"},
	{"Bullet"},
	{"Clover"},
	{"Sadler"},
	{"Firetruck LA"}, //firela
	{"Hustler"},
	{"Intruder"},
	{"Primo"},
	{"Cargobob"},
	{"Tampa"},
	{"Sunrise"},
	{"Merit"},
	{"Utility"},
	{"Nevada"},
	{"Yosemite"},
	{"Windsor"},
	{"Monster A"}, //monstera
	{"Monster B"}, //monsterb
	{"Uranus"},
	{"Jester"},
	{"Sultan"},
	{"Stratum"},
	{"Elegy"},
	{"Raindance"},
	{"RC Tiger"},
	{"Flash"},
	{"Tahoma"},
	{"Savanna"},
	{"Bandito"},
	{"Freight Flat"}, //freiflat
	{"Streak Carriage"}, //streakc
	{"Kart"},
	{"Mower"},
	{"Duneride"},
	{"Sweeper"},
	{"Broadway"},
	{"Tornado"},
	{"AT-400"},
	{"DFT-30"},
	{"Huntley"},
	{"Stafford"},
	{"BF-400"},
	{"Newsvan"},
	{"Tug"},
	{"Trailer 3"}, //petrotr
	{"Emperor"},
	{"Wayfarer"},
	{"Euros"},
	{"Hotdog"},
	{"Club"},
	{"Freight Carriage"}, //freibox
	{"Trailer 3"}, //artict3
	{"Andromada"},
	{"Dodo"},
	{"RC Cam"},
	{"Launch"},
	{"Police Car (LSPD)"},
	{"Police Car (SFPD)"},
	{"Police Car (LVPD)"},
	{"Police Ranger"},
	{"Picador"},
	{"S.W.A.T. Van"},
	{"Alpha"},
	{"Phoenix"},
	{"Glendale"},
	{"Sadler"},
	{"Luggage Trailer A"}, //bagboxa
	{"Luggage Trailer B"}, //bagboxb
	{"Stair Trailer"}, //tugstair
	{"Boxville"},
	{"Farm Plow"}, //farmtr1
	{"Utility Trailer"} //utiltr1
};

//------------------------------------------------------------------------------

enum
{
	INVALID_GENDER_SKIN,
	SKIN_GENDER_MALE,
	SKIN_GENDER_FEMALE
}

static male_skins[] =
{
	0,		1,		2,		3,		4,		5,		6,		7,		8,		14,
	15,		16,		17,		18,		19,		20,		21,		22,		23,		24,
	25,		26,		27,		28,		29,		30,		32,		33,		34,		35,
	36,		37,		42,		43,		44,		45,		46,		47,		48,		49,
	50,		51,		52,		57,		58,		59,		60,		61,		62,		66,
	67,		68,		70,		71,		72,		73,		78,		79,		80,		81,
	82,		83,		84,		86,		94,		95,		96,		97,		98,		99,
	100,	101,	102,	103,	104,	105,	106,	107,	108,	109,
	110,	111,	112,	113,	114,	115,	116,	117,	118,	119,
	120,	121,	122,	123,	124,	125,	126,	127,	128,	132,
	133,	134,	135,	136,	137,	142,	143,	144,	146,	147,
	149,	153,	154,	155,	156,	158,	159,	160,	161,	162,
	163,	164,	165,	166,	167,	168,	170,	171,	173,	174,
	175,	176,	177,	179,	180,	181,	182,	183,	184,	185,
	186,	187,	188,	189,	200,	201,	202,	203,	204,	206,
	208,	209,	210,	212,	213,	217,	220,	221,	222,	223,
	227,	228,	229,	230,	234,	235,	236,	239,	240,	241,
	242,	247,	248,	249,	250,	252,	253,	254,	255,	258,
	259,	260,	261,	262,	264,	265,	266,	267,	268,	269,
	270,	271,	272,	273,	274,	275,	276,	277,	278,	279,
	280,	281,	282,	283,	284,	285,	286,	287,	288,	289,
	290,	291,	292,	293,	294,	295,	296,	297,	299,	300,
	301,	302,	303,	304,	305,	310,	311
};

static female_skins[] =
{
	9,		10,		11,		12,		13,		31,		38,		39,		40,		41,
	53,		54,		55,		56,		63,		64,		65,		69,		75,		76,
	77,		85,		87,		88,		89,		90,		91,		92,		93,		129,
	130,	131,	138,	139,	140,	141,	145,	148,	150,	151,
	152,	157,	169,	172,	178,	190,	191,	192,	193,	194,
	195,	196,	197,	198,	199,	201,	205,	207,	211,	214,
	215,	216,	218,	219,	224,	225,	226,	231,	232,	233,
	237,	238,	243,	244,	245,	246,	251,	256,	257,	263,
	298,	306,	307,	308,	309
};

stock minrand(min, max) return random(max - min) + min;

stock GetPlayerSkinGender(playerid)
{
	for(new i = 0; i < sizeof(male_skins); i++)
	{
		if(GetPlayerSkin(playerid) == male_skins[i])
			return SKIN_GENDER_MALE;
	}

	for(new i = 0; i < sizeof(female_skins); i++)
	{
		if(GetPlayerSkin(playerid) == female_skins[i])
			return SKIN_GENDER_FEMALE;
	}

	return INVALID_GENDER_SKIN;
}

//------------------------------------------------------------------------------

/*
    Sounds macro
*/
#define PlayConfirmSound(%0)    PlayerPlaySound(%0,1058,0.0,0.0,0.0)
#define PlaySelectSound(%0)     PlayerPlaySound(%0,1083,0.0,0.0,0.0)
#define PlayCancelSound(%0)     PlayerPlaySound(%0,1084,0.0,0.0,0.0)
#define PlayErrorSound(%0)      PlayerPlaySound(%0,1085,0.0,0.0,0.0)

//------------------------------------------------------------------------------

enum
{
	VEHICLE_CATEGORY_INVALID,
	VEHICLE_CATEGORY_BIKE,
	VEHICLE_CATEGORY_HELICOPTER,
	VEHICLE_CATEGORY_BOAT,
	VEHICLE_CATEGORY_TAXI,
	VEHICLE_CATEGORY_POLICE
}

//------------------------------------------------------------------------------

/* *************************************************************************** *
*  Assignment: Checks if the player name is a valid roleplay name
*
*  Params:
*			name[]: Player's name
*
*  Returns:
*			0 if player's name has not dot (.)
*			1 if player's name is okay
*			2 if player's name has numbers
*			3 if player's name has not the first letter capitalized
*			4 if player's name has not the first surname letter capitalized
*			5 if player's name has capitalized letters
*			6 if player's name has more than one dot
* *************************************************************************** */
stock IsAValidName(const name[])
{
	// bypassing custom names
	if((!strcmp(name, "Los", true)) || (!strcmp(name, "Larceny", true)) || (!strcmp(name, "Eduardo", true)) || (!strcmp(name, "Nominal", true)) || (!strcmp(name, "ReDKiiL", true)))
		return 1;

	new
		ch = name[0],
		sur_ch,
		dots
	;


	// checking if name has dot
	if(strfind(name, ".") == -1)
		return 0;

	// checking if first letter is capitalized
	if(ch < 'A' || ch > 'Z')
		return 3;

	for(new i = 0; i < strlen(name); i++)
	{
		// checking if name has numbers
		if(name[i] >= '0' && name[i] <= '9')
			return 2;

		// looking for more dots
		if(name[i] == '.')
			dots++;

		if(!strfind(name[i], "."))
		{
			name[++i];
			sur_ch = i;

			// checking if first surname letter is capitalized
			if(name[i] < 'A' || name[i] > 'Z')
				return 4;
		}

		// looking for (others) capitalized letters
		if(name[i] >= 'A' && name[i] <= 'Z' && i != 0 && sur_ch != i)
			return 5;
		else
			continue;
	}

	// if name has more than one underline
	if(dots > 1)
		return 6;
	return 1;
}

/*
    Clear player's chat
*/
stock ClearPlayerScreen(playerid, lines = 100)
{
    for (new i = 0; i < lines; i++)
        SendClientMessage(playerid, -1, " ");
}

//------------------------------------------------------------------------------

#define swap(%1,%2) \
	%1 ^= %2, %2 ^= %1, %1 ^= %2

//------------------------------------------------------------------------------

stock IsPlayerInCube(playerid, Float:minx, Float:miny, Float:minz, Float:maxx, Float:maxy, Float:maxz)
{
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    if(x <= maxx && x >= minx && y <= maxy && y >= miny && z <= maxz && z >= minz)
        return 1;
    return 0;
}

//------------------------------------------------------------------------------

stock ConvertToGameText(in[])
{
    new string[256];
    for(new i = 0; in[i]; ++i)
    {
        string[i] = in[i];
        switch(string[i])
        {
            case 0xC0 .. 0xC3: string[i] -= 0x40;
            case 0xC7 .. 0xC9: string[i] -= 0x42;
            case 0xD2 .. 0xD5: string[i] -= 0x44;
            case 0xD9 .. 0xDC: string[i] -= 0x47;
            case 0xE0 .. 0xE3: string[i] -= 0x49;
            case 0xE7 .. 0xEF: string[i] -= 0x4B;
            case 0xF2 .. 0xF5: string[i] -= 0x4D;
            case 0xF9 .. 0xFC: string[i] -= 0x50;
            case 0xC4, 0xE4: string[i] = 0x83;
            case 0xC6, 0xE6: string[i] = 0x84;
            case 0xD6, 0xF6: string[i] = 0x91;
            case 0xD1, 0xF1: string[i] = 0xEC;
            case 0xDF: string[i] = 0x96;
            case 0xBF: string[i] = 0xAF;
        }
    }
    return string;
}

//------------------------------------------------------------------------------

stock GetPlayerNamef(playerid, bool:_removeDot = true)
{
    new playerName[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playerName, sizeof(playerName));
    if(_removeDot == true) {
        for(new i = 0; i < MAX_PLAYER_NAME; i++) {
            if(playerName[i] == '.') playerName[i] = ' ';
        }
    }
    if(isnull(playerName)) {
        playerName = "Desconhecido";
    }
    return playerName;
}

//------------------------------------------------------------------------------

/*
    Gets the player first name(before the _)
*/
stock GetPlayerFirstName(playerid)
{
    new playerName[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playerName, sizeof(playerName));
    for(new i = 0; i < MAX_PLAYER_NAME; i++)
        if(playerName[i] == '_')
            playerName[i] = '\0';
    if(isnull(playerName))
        playerName = "Desconhecido";
    return playerName;
}

//------------------------------------------------------------------------------

stock GetVehicleModelIDFromName(vname[])
{
	for(new i = 0; i < 211; i++)
	{
		if ( strfind(aVehicleNames[i], vname, true) != -1 )
			return i + 400;
	}
	return -1;
}

//------------------------------------------------------------------------------

stock IsVehicleOccupied(vehicleid)
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerInVehicle(i, vehicleid))
		{
			return true;
		}
	}
	return false;
}

//------------------------------------------------------------------------------

stock GetVehicleName(vehicleid)
{
    new vehiclename[32] = "Nenhum";
    if(!GetVehicleModel(vehicleid))
        return vehiclename;
    format(vehiclename, sizeof(vehiclename), aVehicleNames[GetVehicleModel(vehicleid) - 400]);
    return vehiclename;
}
//------------------------------------------------------------------------------

stock GetVehicleNameFromModel(modelid)
{
    new vehiclename[32] = "Nenhum";
    if(modelid < 400 || modelid > 611)
        return vehiclename;
    format(vehiclename, sizeof(vehiclename), aVehicleNames[modelid - 400]);
    return vehiclename;
}

//------------------------------------------------------------------------------

stock Float:GetPlayerSpeed(playerid)
{// Using Gamer_Z and MP2 calculations (https://github.com/grasmanek94/GPB/blob/master/Speeds/AccurateGTASpeed.inc)
	new Float:VelocityX, Float:VelocityY, Float:VelocityZ;
	if(IsPlayerInAnyVehicle(playerid))
		GetVehicleVelocity(GetPlayerVehicleID(playerid), VelocityX, VelocityY, VelocityZ);
	else
		GetPlayerVelocity(playerid, VelocityX, VelocityY, VelocityZ);

	return (VelocityX*VelocityX+VelocityY*VelocityY+VelocityZ*VelocityZ)*(427833329/2935682);// old 5871364
}

//------------------------------------------------------------------------------

// Convert UNIX time to human readable time
stock convertTimestamp( timestamp, _form=0 )
{
    timestamp -= 10800;
    new year=1970, day=0, month=0, hour=0, mins=0, sec=0;

    new days_of_month[12] = { 31,28,31,30,31,30,31,31,30,31,30,31 };
    new names_of_month[12][10] = {"Janeiro","Fevereiro","Março","Abril","Maio","Junho","Julho","Agosto","Setembro","Outubro","Novembro","Dezembro"};
    new returnstring[32];

    while(timestamp>31622400){
        timestamp -= 31536000;
        if ( ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0) ) timestamp -= 86400;
        year++;
    }

    if ( ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0) )
        days_of_month[1] = 29;
    else
        days_of_month[1] = 28;


    while(timestamp>86400){
        timestamp -= 86400, day++;
        if(day==days_of_month[month]) day=0, month++;
    }

    while(timestamp>60){
        timestamp -= 60, mins++;
        if( mins == 60) mins=0, hour++;
    }

    sec=timestamp;

    switch( _form ){
        case 1: format(returnstring, 31, "%02d/%02d/%d %02d:%02d:%02d", day+1, month+1, year, hour, mins, sec);
        case 2: format(returnstring, 31, "%s %02d, %d, %02d:%02d:%02d", names_of_month[month],day+1,year, hour, mins, sec);
        case 3: format(returnstring, 31, "%d %c%c%c %d, %02d:%02d", day+1,names_of_month[month][0],names_of_month[month][1],names_of_month[month][2], year,hour,mins);
        case 4: format(returnstring, 31, "%02d.%02d.%d-%02d:%02d:%02d", day+1, month+1, year, hour, mins, sec);
        default: format(returnstring, 31, "%02d:%02d:%02d %02d/%02d/%d", hour, mins, sec, day+1, month+1, year);
    }

    return returnstring;
}

//------------------------------------------------------------------------------

Float:GetPlayerDistanceFromPlayer(playerid, targetid)
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	return GetPlayerDistanceFromPoint(targetid, x, y, z);
}

//------------------------------------------------------------------------------

timer UnfreezePlayer[5000](playerid)
{
	TogglePlayerControllable(playerid, true);
}

//------------------------------------------------------------------------------

GetXYInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance)
{	// Created by Y_Less

	new Float:a;

	GetPlayerPos(playerid, x, y, a);
	GetPlayerFacingAngle(playerid, a);

	if (GetPlayerVehicleID(playerid)) {
	    GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
	}

	x += (distance * floatsin(-a, degrees));
	y += (distance * floatcos(-a, degrees));
}

//------------------------------------------------------------------------------

GetPlayerLastName(playerid)
{
    new playerName[MAX_PLAYER_NAME + 1], splittedname[2][MAX_PLAYER_NAME + 1];
    GetPlayerName(playerid, playerName, sizeof(playerName));
    split(playerName, splittedname, '_');
    if(isnull(splittedname[1])) {
        splittedname[1] = "N/A";
    }

    return splittedname[1];
}

//------------------------------------------------------------------------------

stock IsPlayerRunning(playerid)
{
    new
        keys,
        ud,
        lr;

    GetPlayerKeys(playerid, keys, ud, lr);

    if(keys & KEY_WALK)
        return false;

    if(ud == 0 && lr == 0)
        return false;

    return true;
}

//------------------------------------------------------------------------------

stock GetFirstName(const name[])
{
    new playerName[MAX_PLAYER_NAME];
    format(playerName, sizeof(playerName), "%s", name);
    for(new i = 0; i < MAX_PLAYER_NAME; i++) {
        if(playerName[i] == '_') playerName[i] = '\0';
    }
    if(isnull(playerName)) {
        playerName = "Desconhecido";
    }

    return playerName;
}

//------------------------------------------------------------------------------

stock IsNumeric(const string[])
{
    for (new i = 0, j = strlen(string); i < j; i++)
    {
        if (string[i] > '9' || string[i] < '0') return 0;
    }
    return 1;
}

//------------------------------------------------------------------------------

stock SetPlayerHealthEx(playerid, Float:health, Float:limit = Float:0x7F800000)
{
    if(health > limit)
        health = limit;

    SetPlayerHealth(playerid, health);
    return 1;
}

stock Float:GetPlayerHealthf(playerid)
{
    new Float:health;
    GetPlayerHealth(playerid, health);
    return health;
}

//------------------------------------------------------------------------------

stock GetVehicleCategory(vehicleid)
{
    switch(GetVehicleModel(vehicleid))
    {
        case 509, 510, 481, 461..463, 448, 581, 521..523, 586, 468, 471:
            return VEHICLE_CATEGORY_BIKE;
        case 417, 425, 447, 469, 487, 488, 497, 563, 548:
            return VEHICLE_CATEGORY_HELICOPTER;
        case 430, 446, 452, 453, 454, 472, 473, 484, 493, 595:
            return VEHICLE_CATEGORY_BOAT;
        case 420, 438:
            return VEHICLE_CATEGORY_TAXI;
        case 596, 597, 598, 599, 601:
            return VEHICLE_CATEGORY_POLICE;
    }
    return VEHICLE_CATEGORY_INVALID;
}

//------------------------------------------------------------------------------

stock split(const strsrc[], strdest[][], delimiter)
{
    new i, li;
    new aNum;
    new len;
    while(i <= strlen(strsrc))
    {
        if(strsrc[i] == delimiter || i == strlen(strsrc))
        {
            len = strmid(strdest[aNum], strsrc, li, i, 128);
            strdest[aNum][len] = 0;
            li = i+1;
            aNum++;
        }
        i++;
    }
    return 1;
}
