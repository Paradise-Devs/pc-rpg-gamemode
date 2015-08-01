/*******************************************************************************
* FILENAME :        modules/vehicle/status.pwn
*
* DESCRIPTION :
*       Updates vehicle data, engine, fuel, oil, tires...
*
* NOTES :
*       This file should only contain information about vehicle status.
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

new glvUpdate = 0;

//------------------------------------------------------------------------------

task OnVehicleUpdate[1000]()
{
    new tc = tickcount();
    new engine, lights, alarm, doors, bonnet, boot, objective;
    foreach(new i: Vehicle)
    {
        GetVehicleParamsEx(i, engine, lights, alarm, doors, bonnet, boot, objective);
        if(glvUpdate < tc && engine == VEHICLE_PARAMS_ON)
            SetVehicleFuel(i, GetVehicleFuel(i) - 1.0);

        if(GetVehicleFuel(i) == 0 && engine == VEHICLE_PARAMS_ON)
            SetVehicleParamsEx(i, VEHICLE_PARAMS_OFF, lights, alarm, doors, bonnet, boot, objective);

        if(GetVehicleHealthf(i) < 250.0)
        {
            SetVehicleHealth(i, 250.0);
            SetVehicleParamsEx(i, VEHICLE_PARAMS_OFF, lights, alarm, doors, bonnet, boot, objective);
        }
    }

    if(glvUpdate < tc)
        glvUpdate = tc + 60000;
}
