/*******************************************************************************
* FILENAME :        modules/job/trucker.pwn
*
* DESCRIPTION :
*       Adds trucker job to the server.
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

#include <YSI\y_hooks>

//------------------------------------------------------------------------------
/*
// Amount of XP multipled by job level to level up.
static const REQUIRED_XP = 90;

// Amount of XP multipled by job level the player will recieve for deliver.
static const XP_SCALE = 10;
*/

// Job position
static const Float:JOB_POSITION[] = {2442.5039, -2110.0667, 13.5530};

// Load position
static const Float:LOAD_POSITION[] = {2434.1604, -2094.9910, 13.5469};

//------------------------------------------------------------------------------

static gTruckerServices[][][] =
{
  // Service        Payment Level isLegal
  {"Roupas",          1000,   1,  1},
  {"Drogas",          1250,   1,  0},
  {"Comida",          2500,   2,  1},
  {"Armas",           3000,   2,  0},
  {"Materiais",       5000,   3,  1},
  {"Animais",         6000,   3,  0},
  {"Combutível",      10000,  4,  1},
  {"Pessoas",         12000,  4,  0}
};

//------------------------------------------------------------------------------

enum TRAILER_CARGO (+=1)
{
  TRAILER_CARGO_NONE,
  TRAILER_CARGO_CLOTHES = 1,
  TRAILER_CARGO_DRUGS,
  TRAILER_CARGO_FOOD,
  TRAILER_CARGO_GUNS,
  TRAILER_CARGO_MATERIALS,
  TRAILER_CARGO_ANIMALS,
  TRAILER_CARGO_FUEL,
  TRAILER_CARGO_PEOPLE
}
static TRAILER_CARGO:gTrailerCargo[MAX_PLAYERS];

//------------------------------------------------------------------------------

static gPlayerTruckID[MAX_PLAYERS] = {INVALID_VEHICLE_ID, ...};
static gPlayerTrailerID[MAX_PLAYERS] = {INVALID_VEHICLE_ID, ...};

//------------------------------------------------------------------------------

hook OnGameModeInit()
{
  CreateDynamicPickup(1210, 1, JOB_POSITION[0], JOB_POSITION[1], JOB_POSITION[2], 0, 0, -1, MAX_PICKUP_RANGE);
  CreateDynamic3DTextLabel("Caminhoneiro\nPressione Y", 0xFFFFFFFF, JOB_POSITION[0], JOB_POSITION[1], JOB_POSITION[2], MAX_TEXT3D_RANGE, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);

  CreateDynamicPickup(1239, 1, LOAD_POSITION[0], LOAD_POSITION[1], LOAD_POSITION[2], 0, 0, -1, MAX_PICKUP_RANGE);
  CreateDynamic3DTextLabel("Serviços\nPressione Y", 0xFFFFFFFF, LOAD_POSITION[0], LOAD_POSITION[1], LOAD_POSITION[2], MAX_TEXT3D_RANGE, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
  return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerDisconnect(playerid, reason)
{
  if(gPlayerTruckID[playerid] != INVALID_VEHICLE_ID)
  {
    DestroyVehicle(gPlayerTruckID[playerid]);
    DestroyVehicle(gPlayerTrailerID[playerid]);

    gPlayerTruckID[playerid] = INVALID_VEHICLE_ID;
    gPlayerTrailerID[playerid] = INVALID_VEHICLE_ID;
  }
  return 1;
}

//------------------------------------------------------------------------------

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
  switch(dialogid)
  {
    case DIALOG_TRUCK_JOB:
    {
      if(!response)
          PlayCancelSound(playerid);
      else
      {
        if(GetPlayerJobID(playerid) != INVALID_JOB_ID)
        {
            PlayErrorSound(playerid);
            SendClientMessage(playerid, COLOR_ERROR, "* Você já possui um emprego.");
        }
        else
        {
            SetPlayerJobID(playerid, PILOT_JOB_ID);
            SendClientMessage(playerid, COLOR_SPECIAL, "* Agora você é um caminhoneiro!");
            SendClientMessage(playerid, COLOR_SUB_TITLE, "* Vá até o ícone na entrada para escolher um serviço.");
            PlayConfirmSound(playerid);
        }
      }
    }
    case DIALOG_TRUCKER_SERVICES:
    {
      if(!response)
          PlayCancelSound(playerid);
      else
      {
        if(!response)
            PlayCancelSound(playerid);
        else if(GetPlayerJobLV(playerid) < gTruckerServices[listitem][2][0])
        {
          SendClientMessage(playerid, COLOR_ERROR, "* Você não tem nível de emprego suficiente para este serviço.");
          PlayErrorSound(playerid);
        }
        else
        {
          SendClientMessage(playerid, COLOR_SPECIAL, "* Vá entregar a mercadoria no local indicado.");
          if(!gTruckerServices[listitem][3][0])
            SendClientMessage(playerid, COLOR_SUB_TITLE, "* Você está carregando uma carga ilegal, cuidado com a polícia.");

          gTrailerCargo[playerid] = TRAILER_CARGO:(listitem+1);
        }
      }
    }
  }
  return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
  if((newkeys == KEY_YES) && IsPlayerInRangeOfPoint(playerid, 1.5, JOB_POSITION[0], JOB_POSITION[1], JOB_POSITION[2]))
  {
    PlaySelectSound(playerid);
    ShowPlayerDialog(playerid, DIALOG_TRUCK_JOB, DIALOG_STYLE_MSGBOX, "Emprego: Caminhoneiro", "Você deseja se tornar um caminhoneiro?", "Sim", "Não");
    return 1;
  }
  else if((newkeys == KEY_YES) && IsPlayerInRangeOfPoint(playerid, 1.5, LOAD_POSITION[0], LOAD_POSITION[1], LOAD_POSITION[2]))
  {
    if(GetPlayerJobID(playerid) != TRUCKER_JOB_ID)
    return SendClientMessage(playerid, COLOR_ERROR, "* Você não é um caminhoneiro.");
    else if(gPlayerTruckID[playerid] != INVALID_VEHICLE_ID)
    return SendClientMessage(playerid, COLOR_ERROR, "* Você já está em um serviço.");

    PlaySelectSound(playerid);
    new info[300], buffer[60], sIsLegal[4];
    strcat(info, "Serviço\tPagamento\tNível\tLegal");
    for(new i = 0; i < sizeof(gTruckerServices); i++)
    {
      if(gTruckerServices[i][3][0]) format(sIsLegal, sizeof(sIsLegal), "Sim");
      else format(sIsLegal, sizeof(sIsLegal), "Não");
      format(buffer, sizeof(buffer), "\n%s\t$%s\t%i\t%s", gTruckerServices[i][0], formatnumber(gTruckerServices[i][1][0]), gTruckerServices[i][2][0], sIsLegal);
      strcat(info, buffer);
    }
    ShowPlayerDialog(playerid, DIALOG_TRUCKER_SERVICES,  DIALOG_STYLE_TABLIST_HEADERS, "Caminhoneiro -> Serviços", info, "Aceitar", "Recusar");
  }
  return 1;
}

//------------------------------------------------------------------------------
