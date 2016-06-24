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
#define MAX_FURNIS_ACTIONS 5

enum FurniActionsData
{
  //player anim
  action_caption[32],
  action_anim_name[32],
  action_anim_lib[32],
  Float:action_anim_fdelta,
  bool:action_anim_lock_x,
  bool:action_anim_lock_y,
  bool:action_anim_freeze,
  action_anim_time,
  //furni anim
  furni_model_id,
  furni_mov_speed,
  Float:furni_mov_x,
  Float:furni_mov_y,
  Float:furni_mov_z,
  Float:furni_mov_rx,
  Float:furni_mov_ry,
  Float:furni_mov_rz
};
new FurniAction[MAX_FURNI_MODELS][MAX_FURNIS_ACTIONS][FurniActionsData];

enum FurniData
{
    furni_model_id,
    furni_model_type[32],
    furni_model_caption[32],
    furni_model_description[32],
    Float:furni_pos_x,
    Float:furni_pos_y,
    Float:furni_pos_z,
    Float:furni_pos_rx,
    Float:furni_pos_ry,
    Float:furni_pos_rz,
    furni_actions_id[5]
};
new Furni[MAX_FURNIS][FurniData];

