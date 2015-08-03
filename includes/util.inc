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

stock GetPlayerNamef(playerid, bool:_removeUnderline = true)
{
    new playerName[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playerName, sizeof(playerName));
    if(_removeUnderline == true) {
        for(new i = 0; i < MAX_PLAYER_NAME; i++) {
            if(playerName[i] == '_') playerName[i] = ' ';
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
    new names_of_month[12][10] = {"Janeiro","Fevereiro","Mar�o","Abril","Maio","Junho","Julho","Agosto","Setembro","Outubro","Novembro","Dezembro"};
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
