/*******************************************************************************
* FILENAME :        modules/def/getset.pwn
*
* DESCRIPTION :
*       Getters and setters is here.
*
* NOTES :
*       This file should only contain get and set functions.
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/
//Ir removendo conforme for usando
#pragma unused GetPlayerLastLogin
#pragma unused GetPlayerRegDate
#pragma unused SetPlayerPassword
#pragma unused SetPlayerRegDate
#pragma unused SetPlayerState

/********************************************************************************
*
*     ###### #    # #    # #    # ###### #####    ##   #####  ####  #####   ####
*     #      ##   # #    # ##  ## #      #    #  #  #    #   #    # #    # #
*     ####   # #  # #    # # ## # ####   #    # #    #   #   #    # #    #  ####
*     #      #  # # #    # #    # #      #####  ######   #   #    # #####       #
*     #      #   ## #    # #    # #      #   #  #    #   #   #    # #   #  #    #
*     ###### #    #  ####  #    # ###### #    # #    #   #    ####  #    #  ####
*
********************************************************************************/
/////////////////////////////////////////////////////////////////////////////////
// ACC DATA
/////////////////////////////////////////////////////////////////////////////////
enum e_player_adata
{
    e_player_database_id,
    e_player_password[MAX_PLAYER_PASSWORD],
    e_player_regdate,
    e_player_ip[16],
    e_player_lastlogin
}
static gPlayerAccountData[MAX_PLAYERS][e_player_adata];

/////////////////////////////////////////////////////////////////////////////////
// POSITION DATA
/////////////////////////////////////////////////////////////////////////////////
enum e_player_pdata
{
    Float:e_player_x,
    Float:e_player_y,
    Float:e_player_z,
    Float:e_player_a,
    e_player_int,
    e_player_vw
}
static gPlayerPositionData[MAX_PLAYERS][e_player_pdata];

/////////////////////////////////////////////////////////////////////////////////
// CHARACTER DATA
/////////////////////////////////////////////////////////////////////////////////
enum e_player_cdata
{
    e_player_skin,
    e_player_gender,
    e_player_money,
    e_player_faction,
    e_player_frank,
    e_player_ticket,
    Job:e_player_jobid,
    e_player_jobxp,
    e_player_joblv,
    Float:e_player_health,
    Float:e_player_armour
}
static gPlayerCharacterData[MAX_PLAYERS][e_player_cdata];

/////////////////////////////////////////////////////////////////////////////////
// PHONE DATA
/////////////////////////////////////////////////////////////////////////////////
enum e_player_phdata
{
    e_player_phone_number,
    e_player_phone_network,
    e_player_phone_credits,
    e_player_phone_state
}

static gPlayerPhoneData[MAX_PLAYERS][e_player_phdata];

/////////////////////////////////////////////////////////////////////////////////
// WEAPON DATA
/////////////////////////////////////////////////////////////////////////////////
enum e_player_wdata
{
    e_player_weapon[13],
    e_player_ammo[13]
}
static gPlayerWeaponData[MAX_PLAYERS][e_player_wdata];

/////////////////////////////////////////////////////////////////////////////////
// STATE DATA
/////////////////////////////////////////////////////////////////////////////////
enum E_PLAYER_STATE (<<= 1)
{
    E_PLAYER_STATE_NONE,
    E_PLAYER_STATE_LOGGED = 1
}
static E_PLAYER_STATE:gPlayerStates[MAX_PLAYERS];

/********************************************************************************
*
*      ###### ###### ##### ##### ###### #####   ####
*     #       #        #     #   #      #    # #
*     #       ####     #     #   ####   #    #  ####
*     #   ### #        #     #   #      #####       #
*     #     # #        #     #   #      #   #  #    #
*      #####  ######   #     #   ###### #    #  ####
*
********************************************************************************/
/////////////////////////////////////////////////////////////////////////////////
// DATABASE GETTERS
/////////////////////////////////////////////////////////////////////////////////
GetPlayerDatabaseID(playerid) {
    return gPlayerAccountData[playerid][e_player_database_id];
}

GetPlayerPassword(playerid) {
    new s[MAX_PLAYER_PASSWORD];
    format(s, MAX_PLAYER_PASSWORD, "%s", gPlayerAccountData[playerid][e_player_password]);
    return s;
}

GetPlayerRegDate(playerid) {
    return gPlayerAccountData[playerid][e_player_regdate];
}

GetPlayerIPf(playerid) {
    new ip[16];
    GetPlayerIp(playerid, ip, 16);
    return ip;
}

GetPlayerLastLogin(playerid) {
    return gPlayerAccountData[playerid][e_player_lastlogin];
}

/////////////////////////////////////////////////////////////////////////////////
// CHARACTER GETTERS
/////////////////////////////////////////////////////////////////////////////////
GetPlayerLotteryTicket(playerid) {
    return gPlayerCharacterData[playerid][e_player_ticket];
}

GetPlayerFactionID(playerid) {
    return gPlayerCharacterData[playerid][e_player_faction];
}

Job:GetPlayerJobID(playerid) {
    return gPlayerCharacterData[playerid][e_player_jobid];
}

GetPlayerJobLV(playerid) {
    return gPlayerCharacterData[playerid][e_player_joblv];
}

GetPlayerJobXP(playerid) {
    return gPlayerCharacterData[playerid][e_player_jobxp];
}

GetPlayerCash(playerid) {
    return gPlayerCharacterData[playerid][e_player_money];
}

GetPlayerGender(playerid) {
    return gPlayerCharacterData[playerid][e_player_gender];
}

GetPlayerFactionRank(playerid) {
    return gPlayerCharacterData[playerid][e_player_frank];
}

/////////////////////////////////////////////////////////////////////////////////
// PHONE GETTERS
/////////////////////////////////////////////////////////////////////////////////
GetPlayerPhoneNumber(playerid) {
    return gPlayerPhoneData[playerid][e_player_phone_number];
}

GetPlayerPhoneNetwork(playerid) {
    return gPlayerPhoneData[playerid][e_player_phone_network];
}

GetPlayerPhoneCredit(playerid) {
    return gPlayerPhoneData[playerid][e_player_phone_credits];
}

GetPlayerPhoneState(playerid) {
    return gPlayerPhoneData[playerid][e_player_phone_state];
}

/////////////////////////////////////////////////////////////////////////////////
// STATE GETTERS
/////////////////////////////////////////////////////////////////////////////////
IsPlayerLogged(playerid)
{
    if(gPlayerStates[playerid] & E_PLAYER_STATE_LOGGED)
        return 1;

    return 0;
}

/********************************************************************************
*
*      #####  ###### ##### ##### ###### #####   ####
*     #       #        #     #   #      #    # #
*      #####  ####     #     #   ####   #    #  ####
*           # #        #     #   #      #####       #
*     #     # #        #     #   #      #   #  #    #
*      #####  ######   #     #   ###### #    #  ####
*
********************************************************************************/
/////////////////////////////////////////////////////////////////////////////////
// DATABASE SETTERS
/////////////////////////////////////////////////////////////////////////////////
SetPlayerDatabaseID(playerid, id) {
    gPlayerAccountData[playerid][e_player_database_id] = id;
}

SetPlayerPassword(playerid, password[MAX_PLAYER_PASSWORD]) {
    format(gPlayerAccountData[playerid][e_player_password], MAX_PLAYER_PASSWORD, "%s", password);
}

SetPlayerRegDate(playerid, unixt) {
    gPlayerAccountData[playerid][e_player_regdate] = unixt;
}

SetPlayerIP(playerid, ip[16]) {
    format(gPlayerAccountData[playerid][e_player_ip], 16, "%s", ip);
}

SetPlayerLastLogin(playerid, unixt) {
    gPlayerAccountData[playerid][e_player_lastlogin] = unixt;
}

/////////////////////////////////////////////////////////////////////////////////
// POSITION DATA
/////////////////////////////////////////////////////////////////////////////////
SetPlayerPosEx(playerid, Float:PosX, Float:PosY, Float:PosZ, Float:Angle, int, vw)
{
    gPlayerPositionData[playerid][e_player_x]    = PosX;
    gPlayerPositionData[playerid][e_player_y]    = PosY;
    gPlayerPositionData[playerid][e_player_z]    = PosZ;
    gPlayerPositionData[playerid][e_player_a]    = Angle;
    gPlayerPositionData[playerid][e_player_int]  = int;
    gPlayerPositionData[playerid][e_player_vw]   = vw;

    SetPlayerPos(playerid, PosX, PosY, PosZ);
    SetPlayerFacingAngle(playerid, Angle);
    SetPlayerInterior(playerid, int);
    SetPlayerVirtualWorld(playerid, vw);
}

/////////////////////////////////////////////////////////////////////////////////
// CHARACTER GETTERS
/////////////////////////////////////////////////////////////////////////////////
SetPlayerLotteryTicket(playerid, val) {
    gPlayerCharacterData[playerid][e_player_ticket] = val;
}

SetPlayerJobID(playerid, Job:id) {
    gPlayerCharacterData[playerid][e_player_jobid] = id;
}

SetPlayerJobLV(playerid, val) {
    gPlayerCharacterData[playerid][e_player_joblv] = val;
}

SetPlayerJobXP(playerid, val) {
    gPlayerCharacterData[playerid][e_player_jobxp] = val;
}

SetPlayerGender(playerid, gender) {
    gPlayerCharacterData[playerid][e_player_gender] = gender;
}

SetPlayerFaction(playerid, faction) {
    gPlayerCharacterData[playerid][e_player_faction] = faction;
}

SetPlayerFactionRank(playerid, rank) {
    gPlayerCharacterData[playerid][e_player_frank] = rank;
}

SetPlayerCash(playerid, money) {
    ResetPlayerMoney(playerid);
    gPlayerCharacterData[playerid][e_player_money] = money;
    GivePlayerMoney(playerid, money);
}

GivePlayerCash(playerid, money) {
    ResetPlayerMoney(playerid);
    gPlayerCharacterData[playerid][e_player_money] += money;
    GivePlayerMoney(playerid, money);
}

/////////////////////////////////////////////////////////////////////////////////
// PHONE SETTERS
/////////////////////////////////////////////////////////////////////////////////
SetPlayerPhoneNumber(playerid, phonenumber) {
    gPlayerPhoneData[playerid][e_player_phone_number] = phonenumber;
}

SetPlayerPhoneNetwork(playerid, networkid) {
    gPlayerPhoneData[playerid][e_player_phone_network] = networkid;
}

SetPlayerPhoneCredit(playerid, credits) {
    gPlayerPhoneData[playerid][e_player_phone_credits] = credits;
}

SetPlayerPhoneState(playerid, ph_state) {
  gPlayerPhoneData[playerid][e_player_phone_state] = ph_state;
}

/////////////////////////////////////////////////////////////////////////////////
// STATE SETTERS
/////////////////////////////////////////////////////////////////////////////////
SetPlayerLogged(playerid, bool:set)
{
    if(!set)
        gPlayerStates[playerid] &= ~E_PLAYER_STATE_LOGGED;
    else
        gPlayerStates[playerid] |= E_PLAYER_STATE_LOGGED;
}

SetPlayerState(playerid, E_PLAYER_STATE:status, bool:set)
{
    if(!set)
        gPlayerStates[playerid] &= ~status;
    else
        gPlayerStates[playerid] |= status;
}

/////////////////////////////////////////////////////////////////////////////////
// STATE GETTERS
/////////////////////////////////////////////////////////////////////////////////

/********************************************************************************
*
*     #####  ######  ####  ###### #####
*     #    # #      #      #        #
*     #    # #####   ####  ####     #
*     #####  #           # #        #
*     #   #  #      #    # #        #
*     #    # ######  ####  ######   #
*
********************************************************************************/
ResetPlayerData(playerid)
{
    // Current Time
    new ct = gettime();

    // Reset all player status
    gPlayerStates[playerid] = E_PLAYER_STATE_NONE;

    gPlayerAccountData[playerid][e_player_database_id]  = 0;
    gPlayerAccountData[playerid][e_player_regdate]      = ct;
    gPlayerAccountData[playerid][e_player_lastlogin]    = ct;

    gPlayerPositionData[playerid][e_player_x]           = 1449.01;
    gPlayerPositionData[playerid][e_player_y]           = -2287.10;
    gPlayerPositionData[playerid][e_player_z]           = 13.54;
    gPlayerPositionData[playerid][e_player_a]           = 96.36;
    gPlayerPositionData[playerid][e_player_int]         = 0;
    gPlayerPositionData[playerid][e_player_vw]          = 0;

    gPlayerCharacterData[playerid][e_player_gender]     = 0;
    gPlayerCharacterData[playerid][e_player_money]      = 350;
    gPlayerCharacterData[playerid][e_player_skin]       = 299;
    gPlayerCharacterData[playerid][e_player_faction]    = 0;
    gPlayerCharacterData[playerid][e_player_frank]      = 0;
    gPlayerCharacterData[playerid][e_player_ticket]     = 0;
    gPlayerCharacterData[playerid][e_player_jobid]      = INVALID_JOB_ID;
    gPlayerCharacterData[playerid][e_player_jobxp]      = 0;
    gPlayerCharacterData[playerid][e_player_joblv]      = 1;
    gPlayerCharacterData[playerid][e_player_health]     = 100.0;
    gPlayerCharacterData[playerid][e_player_armour]     = 0.0;

    gPlayerPhoneData[playerid][e_player_phone_number]   = 0;
    gPlayerPhoneData[playerid][e_player_phone_network]  = -1;
    gPlayerPhoneData[playerid][e_player_phone_credits]  = 0;
    gPlayerPhoneData[playerid][e_player_phone_state]    = 0;

    for (new i = 0; i < sizeof(gPlayerWeaponData[][]); i++)
        gPlayerWeaponData[playerid][e_player_weapon][i] = 0;
}
