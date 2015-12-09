/*******************************************************************************
* FILENAME :        modules/game/mapicons.pwn
*
* DESCRIPTION :
*       Adds map icons to the server.
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

// Bank positions
new Float:gBankPositions[][] =
{
	// WHEN ADDING MORE NEED TO ADD MORE IN /modules/gameplay/bank.pwn CP
	{1545.8734, -1770.8802, 13.1970}, // Near City Hall
	{2140.0452, -1164.1554, 23.6275},
	{1102.8614, -1460.4182, 15.4615}, // Near Hospital
	{375.0207, -2055.4102, 7.6778}
};

hook OnGameModeInit()
{
    printf("Creating mapicons...");
	CreateDynamicMapIcon(1481.0702, -1771.9099, 18.7958, 56, 0x00FFFFFF, -1, -1, -1, MAX_MAPICON_RANGE); // City Hall
	CreateDynamicMapIcon(1554.9802, -1675.5162, 16.1953, 30, 0x0000FFFF, -1, -1, -1, MAX_MAPICON_RANGE); // LSPD
	CreateDynamicMapIcon(1172.8984, -1323.3942, 15.3992, 22, 0x0000FFFF, -1, -1, -1, MAX_MAPICON_RANGE); // Hospital All Saints LS
	CreateDynamicMapIcon(2038.5936, -1409.7347, 17.1641, 22, 0x0000FFFF, -1, -1, -1, MAX_MAPICON_RANGE); // Hospital Country General LS
	CreateDynamicMapIcon(2194.1707, -999.58280, 63.1271, 21, 0x0000FFFF, -1, -1, -1, MAX_MAPICON_RANGE); // Small Church
	CreateDynamicMapIcon(2232.9041, -1333.3239, 23.9816, 21, 0x0000FFFF, -1, -1, -1, MAX_MAPICON_RANGE); // Big Church
	CreateDynamicMapIcon(1631.7057, -1172.1077, 24.0781, 25, 0x0000FFFF, -1, -1, -1, MAX_MAPICON_RANGE); // Lottery
	CreateDynamicMapIcon(2229.8728, -1721.2327, 13.5610, 54, 0x0000FFFF, -1, -1, -1, MAX_MAPICON_RANGE); // GYM
	CreateDynamicMapIcon(2440.9358, -2091.3459, 13.6391, 51, 0x0000FFFF, -1, -1, -1, MAX_MAPICON_RANGE); // Truckers Zone
	CreateDynamicMapIcon(1960.7174, -2186.0178, 13.1016, 05, 0x0000FFFF, -1, -1, -1, MAX_MAPICON_RANGE); // Airport
	CreateDynamicMapIcon(914.46550, -1004.2324, 37.9874, 52, 0x0000FFFF, -1, -1, -1, MAX_MAPICON_RANGE); // Bank
	CreateDynamicMapIcon(1310.1067, -1367.2267, 13.5247, 55, 0x0000FFFF, -1, -1, -1, MAX_MAPICON_RANGE); // Auto Escola
	CreateDynamicMapIcon(559.15270, -1292.2704, 17.2482, 55, 0x0000FFFF, -1, -1, -1, MAX_MAPICON_RANGE); // Concessionaria
	CreateDynamicMapIcon(560.8210,	-1506.7863,	14.5440, 18, 0x0000FFFF, -1, -1, -1, MAX_MAPICON_RANGE); // Paintball

    for(new i; i < sizeof(gBankPositions); i++)
		CreateDynamicMapIcon(gBankPositions[i][0], gBankPositions[i][1], gBankPositions[i][2], 52, 0x00FFFFFF, -1, -1, -1, MAX_MAPICON_RANGE);// ATM
    return 1;
}
