/*******************************************************************************
* FILENAME :        modules/objects/hospital.pwn
*
* DESCRIPTION :
*       Create Hospital objects
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

hook OnGameModeInit()
{
	// Beds
	CreateDynamicObject(1798, 346.7344, 165.5153, 1013.1875, 0.000000, 0.000000, 270, 1, 3, -1, 25);
	CreateDynamicObject(1798, 346.7344, 163.0153, 1013.1875, 0.000000, 0.000000, 270, 1, 3, -1, 25);
	CreateDynamicObject(1798, 346.7344, 160.5153, 1013.1875, 0.000000, 0.000000, 270, 1, 3, -1, 25);

    // Door
	CreateDynamicObject(7927, 345.7073, 157.3066, 1014.4075, -0.00000, 0.000000, 90, 1, 3, -1, 25);

    // Computers
	CreateDynamicObject(3395, 345.52322, 160.25531, 1013.18347,   0.00000, 0.00000, 210.00000, 1, 3, -1, 25);
	CreateDynamicObject(3397, 345.11392, 165.10481, 1013.18359,   0.00000, 0.00000, 160.00000, 1, 3, -1, 25);

    // Chair
	CreateDynamicObject(1721, 346.36526, 164.40199, 1013.18359,   0.00000, 0.00000, 70.00000, 1, 3, -1, 25);
    return 1;
}
