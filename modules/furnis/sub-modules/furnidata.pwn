/*******************************************************************************
* FILENAME :        modules/furnis/sub-modules/furnidata.pwn
*
* DESCRIPTION :
*       This file holds all informations and configs related to furnitures
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*/

#define MAX_FURNI_MODELS 20000
#define MAX_FURNIS 32500
#define MAX_FURNIS_ACTIONS 4

enum FurniData
{
  Float:model_radius_size,
  Float:dyn_mov_x,
  Float:dyn_mov_y,
  Float:dyn_mov_z,
  Float:dyn_mov_rx,
  Float:dyn_mov_ry,
  Float:dyn_mov_rz,
};
new Furni[MAX_FURNI_MODELS][MAX_FURNIS_ACTIONS][FurniData];
