/*******************************************************************************
* FILENAME :        modules/gameplay/weather.pwn
*
* DESCRIPTION :
*       Adds dynamic weather to the server.
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

enum e_WETHER_TYPE
{
	e_WEATHER_SUNNY			= 2,
	e_WEATHER_CLOUDY_1		= 4,
	e_WEATHER_CLOUDY_2		= 7,
	e_WEATHER_RAINY			= 8
}

new g_currentWeather	= e_WEATHER_SUNNY;
new g_nextWeather		= e_WEATHER_CLOUDY_1;
new g_timeToNextWeather	= 0;

//------------------------------------------------------------------------------

forward OnLoadWeather();
forward OnSaveWeather();
forward OnWeatherUpdate();

/*
	GetCurrentWeather()
		Gets the current weather of the server.
	return
		e_WEATHER_SUNNY
		e_WEATHER_CLOUDY_1
		e_WEATHER_CLOUDY_2
		e_WEATHER_RAINY
*/
GetCurrentWeather()
	return g_currentWeather;

/*
	OnGameModeInit
		Called when the gamemode starts
*/
hook OnGameModeInit()
{
	mysql_tquery(mysql, "SELECT * FROM `weather`", "OnLoadWeather");
}

/*
	OnPlayerSpawn
		Called everytime the player spawns
*/
hook OnPlayerSpawn(playerid)
{
	if(IsPlayerNPC(playerid))
        return 1;
	
    SetPlayerWeather(playerid, GetCurrentWeather());
	return 1;
}

/*
	OnLoadWeather
		Called when the server loads the weather from database
*/
public OnLoadWeather()
{
	new rows, fields;
	cache_get_data(rows, fields, mysql);
	if(rows)
	{
		g_currentWeather	= cache_get_field_content_int(0, "CurrentWeather");
		g_nextWeather		= cache_get_field_content_int(0, "NextWeather");
		g_timeToNextWeather	= cache_get_field_content_int(0, "TimeToNextWeather");
	}
	else
	{
		new query[128];
		mysql_format(mysql, query, sizeof(query), "INSERT INTO `weather` (`CurrentWeather`, `NextWeather`, `TimeToNextWeather`) VALUES (%d, %d, %d)", e_WEATHER_SUNNY, e_WEATHER_CLOUDY_1, gettime() + 86400);
		mysql_tquery(mysql, query);
	}
}

/*
	OnSaveWeather
		Called when the server saves the weather to database
*/
public OnSaveWeather()
{
	new query[120];
	mysql_format(mysql, query, sizeof(query), "UPDATE `weather` SET `CurrentWeather`=%d, `NextWeather`=%d, `TimeToNextWeather`=%d WHERE `ID`=1", g_currentWeather, g_nextWeather, g_timeToNextWeather);
	mysql_tquery(mysql, query);
}

/*
	OnWeatherUpdate
		Called every hour to check for weather change
*/
task OnWeatherUpdate[3600000]()
{
	if(gettime() > g_timeToNextWeather)
	{
		g_currentWeather = g_nextWeather;
		switch(g_nextWeather)
		{
			case e_WEATHER_SUNNY:
			{
				SetWeather(e_WEATHER_SUNNY);
				g_nextWeather = e_WEATHER_CLOUDY_1;
				g_timeToNextWeather = gettime() + 86400;
			}
			case e_WEATHER_CLOUDY_1:
			{
				SetWeather(e_WEATHER_CLOUDY_1);
				g_nextWeather = e_WEATHER_RAINY;
				g_timeToNextWeather = gettime() + 14400;
			}
			case e_WEATHER_RAINY:
			{
				SetWeather(e_WEATHER_RAINY);
				g_nextWeather = e_WEATHER_CLOUDY_2;
				g_timeToNextWeather = gettime() + 7200;
			}
			case e_WEATHER_CLOUDY_2:
			{
				SetWeather(e_WEATHER_CLOUDY_2);
				g_nextWeather = e_WEATHER_SUNNY;
				g_timeToNextWeather = gettime() + 14400;
			}
		}
		OnSaveWeather();
	}
}
