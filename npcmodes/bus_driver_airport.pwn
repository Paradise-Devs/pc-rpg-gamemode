#include <a_npc>

public ScanTimer();
public StartPlayback();
public ResumePlayback();

enum
{
	RECORDING_STATE_OFF,
	RECORDING_STATE_START,
	RECORDING_STATE_PAUSE,
	RECORDING_STATE_BACK
}

new gRecordingState = RECORDING_STATE_OFF;
new gVehicleid;

//------------------------------------------

main(){}

//------------------------------------------

public OnNPCModeInit()
{
	SetTimer("ScanTimer", 1000, 1);
}

//------------------------------------------

public ScanTimer()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(GetPlayerVehicleID(i) == gVehicleid && gRecordingState == RECORDING_STATE_OFF)
		{
			gRecordingState = RECORDING_STATE_START;
			SetTimer("ResumePlayback", 15000, false);
			break;
		}
		else if(GetPlayerVehicleID(i) == gVehicleid && gRecordingState == RECORDING_STATE_START)
		{
			new Float:distance;
			GetDistanceFromMeToPoint(1490.5167, -1735.7382, 13.5161, distance);
			if(distance < 4.4)
			{
				gRecordingState = RECORDING_STATE_PAUSE;
				PauseRecordingPlayback();
				SetTimer("ResumePlayback", 15000, false);				
			}
			break;
		}
	}
}

//------------------------------------------

public StartPlayback()
{
	StartRecordingPlayback(PLAYER_RECORDING_TYPE_DRIVER, "bus_driver_airport");
}

//------------------------------------------

public ResumePlayback()
{
	ResumeRecordingPlayback();
}

//------------------------------------------

public OnRecordingPlaybackEnd()
{
	StartPlayback();
	PauseRecordingPlayback();
	gRecordingState = RECORDING_STATE_OFF;
}

//------------------------------------------

public OnNPCEnterVehicle(vehicleid, seatid)
{
	StartPlayback();
	PauseRecordingPlayback();
	gRecordingState = RECORDING_STATE_OFF;
    gVehicleid = vehicleid;
}

//------------------------------------------

public OnNPCExitVehicle()
{
    StopRecordingPlayback();
}

//------------------------------------------