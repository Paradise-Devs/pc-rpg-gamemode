/*******************************************************************************
* FILENAME :        modules/def/job.pwn
*
* DESCRIPTION :
*       Global constants and funcs of jobs.
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*/

//------------------------------------------------------------------------------

enum Job (+=1)
{
    INVALID_JOB_ID,
    PILOT_JOB_ID = 1,
    TRUCKER_JOB_ID
}

//------------------------------------------------------------------------------

GetJobName(Job:id, bool:capitalize = false)
{
  new jobName[32];
  switch(id)
  {
    case PILOT_JOB_ID:
      jobName = "piloto";
    case TRUCKER_JOB_ID:
      jobName = "caminhoneiro";
    default:
      jobName = "desempregado";
  }
  if(capitalize)
    jobName[0] = toupper(jobName[0]);
  return jobName;
}
