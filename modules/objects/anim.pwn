new animStep, animStep2;

forward DoAnimFrame(objectid);

timer DoAnimFrame[50](objectid)
{
    new Float:objPos[3];
    GetDynamicObjectPos(objectid, objPos[0], objPos[1], objPos[2]);

    SetDynamicObjectPos(objectid, objPos[0], objPos[1], objPos[2] + (floatsin(float(animStep), degrees)/2));

    animStep += 15;
    if(animStep == 360) animStep = 0;

    return 1;
}

public OnObjectMoved(objectid)
{
    new Float:objPos[3];
    GetDynamicObjectPos(objectid, objPos[0], objPos[1], objPos[2]);

    if(animStep2 == 0)//up
        SetDynamicObjectPos(objectid, objPos[0], objPos[1], objPos[2] + 0.3);

    else // down
        SetDynamicObjectPos(objectid, objPos[0], objPos[1], objPos[2]);

    animStep2 = !animStep2;

    return 1;
}
