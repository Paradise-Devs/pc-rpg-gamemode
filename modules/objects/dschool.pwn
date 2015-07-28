/*******************************************************************************
* FILENAME :        modules/objects/school.pwn
*
* DESCRIPTION :
*       Create and Destroy AutoSchool objects.
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

static gObjTest1[MAX_PLAYERS][164];
static bool:gIsObjectsCreated[MAX_PLAYERS];
static gplCurrentCreatedObjects[MAX_PLAYERS] = {-1, ...};

//------------------------------------------------------------------------------

DestroyAutoSchoolObject(playerid)
{
    if(!gIsObjectsCreated[playerid])
        return 1;

    gIsObjectsCreated[playerid] = false;
    gplCurrentCreatedObjects[playerid] = -1;
    for(new i = 0; i < sizeof(gObjTest1[]); i++)
    {
        if(gObjTest1[playerid][i] != INVALID_OBJECT_ID)
        {
            DestroyDynamicObject(gObjTest1[playerid][i]);
            gObjTest1[playerid][i] = INVALID_OBJECT_ID;
        }
    }
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerDisconnect(playerid, reason)
{
    if(gIsObjectsCreated[playerid])
        DestroyAutoSchoolObject(playerid);

    gplCurrentCreatedObjects[playerid] = -1;
    return 1;
}

//------------------------------------------------------------------------------

CreateAutoSchoolObject(playerid, test)
{
    if(gplCurrentCreatedObjects[playerid] == test)
        return 1;

    if(gIsObjectsCreated[playerid])
    {
        for(new i = 0; i < sizeof(gObjTest1[]); i++)
            if(gObjTest1[playerid][i] != INVALID_OBJECT_ID)
                DestroyDynamicObject(gObjTest1[playerid][i]);
    }

    for(new i = 0; i < sizeof(gObjTest1[]); i++)
        gObjTest1[playerid][i] = INVALID_OBJECT_ID;

    gIsObjectsCreated[playerid] = true;
    gplCurrentCreatedObjects[playerid] = test;

    switch(test)
    {
        case 0:
        {
            gObjTest1[playerid][0]    = CreateDynamicObject(1238, -2045.33997, -107.80455, 34.53610,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][1]    = CreateDynamicObject(1238, -2050.92578, -107.76794, 34.53610,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][2]    = CreateDynamicObject(1238, -2045.37952, -110.80859, 34.53610,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][3]    = CreateDynamicObject(1238, -2050.95898, -110.93183, 34.53610,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][4]    = CreateDynamicObject(1238, -2045.53650, -114.37772, 34.53610,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][5]    = CreateDynamicObject(1238, -2051.02319, -114.37706, 34.53610,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][6]    = CreateDynamicObject(1238, -2051.05054, -117.85901, 34.53610,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][7]    = CreateDynamicObject(1238, -2045.56458, -117.99049, 34.53610,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][8]    = CreateDynamicObject(1238, -2045.63660, -121.99386, 34.53610,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][9]    = CreateDynamicObject(1238, -2051.07788, -122.10122, 34.53610,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][10]   = CreateDynamicObject(1238, -2045.71484, -125.43324, 34.53610,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][11]   = CreateDynamicObject(1238, -2053.55835, -124.06095, 34.59549,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][12]   = CreateDynamicObject(1238, -2048.57568, -128.61099, 34.53610,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][13]   = CreateDynamicObject(1238, -2057.42261, -124.12130, 34.63261,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][14]   = CreateDynamicObject(1238, -2052.60107, -129.83980, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][15]   = CreateDynamicObject(1238, -2057.07275, -129.86679, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][16]   = CreateDynamicObject(1238, -2061.05176, -124.15096, 34.63261,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][17]   = CreateDynamicObject(1238, -2060.92285, -129.66037, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][18]   = CreateDynamicObject(1238, -2065.02344, -124.03492, 34.63261,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][19]   = CreateDynamicObject(1238, -2065.11572, -129.30829, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][20]   = CreateDynamicObject(1238, -2069.34033, -123.32486, 34.63261,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][21]   = CreateDynamicObject(1238, -2069.71021, -129.05730, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][22]   = CreateDynamicObject(1238, -2073.89478, -123.40980, 34.63261,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][23]   = CreateDynamicObject(1238, -2078.47485, -126.32671, 34.63261,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][24]   = CreateDynamicObject(1238, -2079.32935, -130.57243, 34.63261,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][25]   = CreateDynamicObject(1238, -2073.23218, -130.84955, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][26]   = CreateDynamicObject(1238, -2072.86157, -136.20848, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][27]   = CreateDynamicObject(1238, -2079.15674, -135.72719, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][28]   = CreateDynamicObject(1238, -2079.19360, -140.99858, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][29]   = CreateDynamicObject(1238, -2072.74219, -140.80162, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][30]   = CreateDynamicObject(1238, -2072.63770, -145.76059, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][31]   = CreateDynamicObject(1238, -2079.20728, -146.01956, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][32]   = CreateDynamicObject(1238, -2079.20728, -146.01956, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][33]   = CreateDynamicObject(1238, -2079.20728, -146.01956, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][34]   = CreateDynamicObject(1238, -2079.31128, -151.30905, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][35]   = CreateDynamicObject(1238, -2072.73779, -151.25037, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][36]   = CreateDynamicObject(1238, -2072.63013, -156.13602, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][37]   = CreateDynamicObject(1238, -2079.50220, -156.49805, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][38]   = CreateDynamicObject(1238, -2079.38159, -161.71439, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][39]   = CreateDynamicObject(1238, -2072.58569, -161.62869, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][40]   = CreateDynamicObject(1238, -2079.62573, -167.29065, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][41]   = CreateDynamicObject(1238, -2072.79199, -167.19788, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][42]   = CreateDynamicObject(1238, -2072.93262, -172.87294, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][43]   = CreateDynamicObject(1238, -2079.51172, -173.14992, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][44]   = CreateDynamicObject(1238, -2077.85620, -179.08171, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][45]   = CreateDynamicObject(1238, -2072.95508, -181.55473, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][46]   = CreateDynamicObject(1238, -2066.42798, -181.01122, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][47]   = CreateDynamicObject(1238, -2067.18433, -172.74132, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][48]   = CreateDynamicObject(1238, -2066.63354, -168.05132, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][49]   = CreateDynamicObject(1238, -2061.26172, -178.11537, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][50]   = CreateDynamicObject(1238, -2060.02344, -172.98856, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][51]   = CreateDynamicObject(1238, -2059.86133, -167.97568, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][52]   = CreateDynamicObject(1238, -2069.88257, -174.19388, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][53]   = CreateDynamicObject(1238, -2066.59302, -162.66518, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][54]   = CreateDynamicObject(1238, -2059.83521, -162.71022, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][55]   = CreateDynamicObject(1238, -2066.73389, -157.72720, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][56]   = CreateDynamicObject(1238, -2059.57422, -157.58327, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][57]   = CreateDynamicObject(1238, -2066.91260, -152.98357, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][58]   = CreateDynamicObject(1238, -2059.66992, -152.94685, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][59]   = CreateDynamicObject(1238, -2066.86768, -148.32028, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][60]   = CreateDynamicObject(1238, -2059.63208, -148.04887, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][61]   = CreateDynamicObject(1238, -2059.63208, -148.04887, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][62]   = CreateDynamicObject(1238, -2066.65601, -143.64627, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][63]   = CreateDynamicObject(1238, -2059.49463, -144.14958, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][64]   = CreateDynamicObject(1238, -2066.17871, -138.83542, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][65]   = CreateDynamicObject(1238, -2064.98901, -135.32948, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][66]   = CreateDynamicObject(1238, -2060.64404, -133.53343, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][67]   = CreateDynamicObject(1238, -2059.62695, -140.16769, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][68]   = CreateDynamicObject(1238, -2055.02441, -133.43524, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][69]   = CreateDynamicObject(1238, -2055.02808, -139.96390, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][70]   = CreateDynamicObject(1238, -2050.83228, -140.11198, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][71]   = CreateDynamicObject(1238, -2050.34351, -133.45073, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][72]   = CreateDynamicObject(1238, -2046.58899, -133.42410, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][73]   = CreateDynamicObject(1238, -2046.94250, -140.47902, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][74]   = CreateDynamicObject(1238, -2042.09155, -133.31978, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][75]   = CreateDynamicObject(1238, -2042.52222, -140.28471, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][76]   = CreateDynamicObject(1238, -2038.37939, -140.32590, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][77]   = CreateDynamicObject(1238, -2037.19287, -133.63383, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][78]   = CreateDynamicObject(1238, -2032.76953, -135.23468, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][79]   = CreateDynamicObject(1238, -2030.82642, -139.11542, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][80]   = CreateDynamicObject(1238, -2030.79041, -143.50720, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][81]   = CreateDynamicObject(1238, -2037.36353, -143.65485, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][82]   = CreateDynamicObject(1238, -2037.12012, -148.37430, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][83]   = CreateDynamicObject(1238, -2030.82983, -148.25430, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][84]   = CreateDynamicObject(1238, -2037.12012, -152.19441, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][85]   = CreateDynamicObject(1238, -2030.94006, -152.20273, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][86]   = CreateDynamicObject(1238, -2030.87781, -156.44238, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][87]   = CreateDynamicObject(1238, -2037.15808, -156.51457, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][88]   = CreateDynamicObject(1238, -2037.00037, -161.10931, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][89]   = CreateDynamicObject(1238, -2030.91663, -161.18988, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][90]   = CreateDynamicObject(1238, -2030.85608, -165.73930, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][91]   = CreateDynamicObject(1238, -2036.77271, -165.90779, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][92]   = CreateDynamicObject(1238, -2036.78015, -170.56017, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][93]   = CreateDynamicObject(1238, -2030.77942, -170.76933, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][94]   = CreateDynamicObject(1238, -2030.82434, -175.56053, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][95]   = CreateDynamicObject(1238, -2036.67664, -175.68616, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][96]   = CreateDynamicObject(1238, -2036.49182, -180.39949, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][97]   = CreateDynamicObject(1238, -2030.78967, -180.28479, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][98]   = CreateDynamicObject(1238, -2030.71729, -185.23329, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][99]   = CreateDynamicObject(1238, -2036.58862, -185.34407, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][100]  = CreateDynamicObject(1238, -2036.44885, -190.57599, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][101]  = CreateDynamicObject(1238, -2030.66711, -190.24091, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][102]  = CreateDynamicObject(1238, -2030.58484, -195.20924, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][103]  = CreateDynamicObject(1238, -2036.52661, -195.56870, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][104]  = CreateDynamicObject(1238, -2036.54797, -200.61258, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][105]  = CreateDynamicObject(1238, -2030.32336, -200.18553, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][106]  = CreateDynamicObject(1238, -2030.05115, -204.83765, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][107]  = CreateDynamicObject(1238, -2036.51074, -205.38687, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][108]  = CreateDynamicObject(1238, -2036.32910, -210.29439, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][109]  = CreateDynamicObject(1238, -2030.21204, -210.36165, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][110]  = CreateDynamicObject(1238, -2030.20325, -215.56236, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][111]  = CreateDynamicObject(1238, -2036.44666, -215.36632, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][112]  = CreateDynamicObject(1238, -2036.44714, -220.52557, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][113]  = CreateDynamicObject(1238, -2030.18530, -220.85687, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][114]  = CreateDynamicObject(1238, -2030.13757, -225.45552, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][115]  = CreateDynamicObject(1238, -2036.61902, -225.23430, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][116]  = CreateDynamicObject(1238, -2036.59326, -230.89648, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][117]  = CreateDynamicObject(1238, -2030.06042, -230.95555, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][118]  = CreateDynamicObject(1238, -2029.79297, -236.93808, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][119]  = CreateDynamicObject(1238, -2036.58691, -236.59828, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][120]  = CreateDynamicObject(1238, -2036.64685, -242.33142, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][121]  = CreateDynamicObject(1238, -2029.78455, -242.54716, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][122]  = CreateDynamicObject(1238, -2030.98401, -248.06099, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][123]  = CreateDynamicObject(1238, -2034.66956, -251.12811, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][124]  = CreateDynamicObject(1238, -2039.58643, -251.24907, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][125]  = CreateDynamicObject(1238, -2039.55566, -244.22650, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][126]  = CreateDynamicObject(1238, -2044.12183, -244.18977, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][127]  = CreateDynamicObject(1238, -2044.55237, -251.11642, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][128]  = CreateDynamicObject(1238, -2049.19287, -251.16002, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][129]  = CreateDynamicObject(1238, -2049.28687, -244.22063, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][130]  = CreateDynamicObject(1238, -2053.85278, -251.20377, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][131]  = CreateDynamicObject(1238, -2054.10645, -244.36661, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][132]  = CreateDynamicObject(1238, -2058.01221, -251.12485, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][133]  = CreateDynamicObject(1238, -2060.73096, -246.68321, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][134]  = CreateDynamicObject(1238, -2061.05566, -241.05775, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][135]  = CreateDynamicObject(1238, -2054.22974, -240.67871, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][136]  = CreateDynamicObject(1238, -2053.98950, -235.58124, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][137]  = CreateDynamicObject(1238, -2060.69263, -235.76109, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][138]  = CreateDynamicObject(1238, -2060.62720, -229.74121, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][139]  = CreateDynamicObject(1238, -2054.18970, -230.06921, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][140]  = CreateDynamicObject(1238, -2054.29028, -224.87491, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][141]  = CreateDynamicObject(1238, -2061.04468, -224.68893, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][142]  = CreateDynamicObject(1238, -2061.12109, -220.45609, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][143]  = CreateDynamicObject(1238, -2054.16138, -220.42865, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][144]  = CreateDynamicObject(1238, -2061.14282, -216.37439, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][145]  = CreateDynamicObject(1238, -2053.97974, -216.38573, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][146]  = CreateDynamicObject(1238, -2054.37378, -211.88847, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][147]  = CreateDynamicObject(1238, -2057.18164, -208.40112, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][148]  = CreateDynamicObject(1238, -2060.84351, -205.95383, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][149]  = CreateDynamicObject(1238, -2062.27734, -213.11148, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][150]  = CreateDynamicObject(1238, -2065.56128, -211.70256, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][151]  = CreateDynamicObject(1238, -2064.82007, -204.98915, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][152]  = CreateDynamicObject(1238, -2069.41699, -210.98775, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][153]  = CreateDynamicObject(1238, -2068.38159, -204.32959, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][154]  = CreateDynamicObject(1238, -2073.15723, -210.73866, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][155]  = CreateDynamicObject(1238, -2072.59229, -204.30353, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][156]  = CreateDynamicObject(1238, -2076.23608, -210.90929, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][157]  = CreateDynamicObject(1238, -2076.57104, -204.62897, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][158]  = CreateDynamicObject(1238, -2080.15454, -204.68929, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][159]  = CreateDynamicObject(1238, -2079.91675, -210.76070, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][160]  = CreateDynamicObject(1238, -2083.63892, -210.79633, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][161]  = CreateDynamicObject(1238, -2083.59863, -204.73419, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][162]  = CreateDynamicObject(1238, -2083.64087, -206.61383, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
            gObjTest1[playerid][163]  = CreateDynamicObject(1238, -2083.57129, -208.73737, 34.59550,   0.00000, 0.00000, 0.00000, (playerid+1), 0, playerid);
        }
    }
    return 1;
}
