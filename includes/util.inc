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

/*
    Sounds macro
*/
#define PlayConfirmSound(%0)    PlayerPlaySound(%0,1058,0.0,0.0,0.0)
#define PlaySelectSound(%0)     PlayerPlaySound(%0,1083,0.0,0.0,0.0)
#define PlayCancelSound(%0)     PlayerPlaySound(%0,1084,0.0,0.0,0.0)
#define PlayErrorSound(%0)      PlayerPlaySound(%0,1085,0.0,0.0,0.0)

//------------------------------------------------------------------------------

/*
    Clear player's chat
*/
stock ClearPlayerScreen(playerid, lines = 100)
{
    for (new i = 0; i < lines; i++)
        SendClientMessage(playerid, -1, " ");
}

//------------------------------------------------------------------------------

stock GetPlayerNamef(playerid)
{
	new playerName[MAX_PLAYER_NAME];
	GetPlayerName(playerid, playerName, sizeof(playerName));
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

GetVehicleModelIDFromName(vname[])
{
	for(new i = 0; i < 211; i++)
	{
		if ( strfind(aVehicleNames[i], vname, true) != -1 )
			return i + 400;
	}
	return -1;
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
