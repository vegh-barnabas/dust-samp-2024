Server:SpawnTemporaryCar(playerid, modelid)
{
    if (totalTempVehicles >= MAX_TEMP_VEHICLES)
    {
        new str[128];
        format(str, sizeof(str), "The temporary vehicle limit is reached (%d/%d cars)!", totalTempVehicles, MAX_TEMP_VEHICLES);
        return SendMessage(playerid, str, MESSAGE_TYPE_ERROR);
    }

    new Float:x, Float:y, Float:z, Float:rot;
    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, rot);

    new	vehId = CreateVehicle(modelid, x, y, z, rot, -1, -1, -1);
    if (vehId == 0 || vehId == INVALID_VEHICLE_ID) return SendMessage(playerid, "Couldn't spawn vehicle! Maybe you gave a bad model ID.", MESSAGE_TYPE_ERROR);

    PutPlayerInVehicle(playerid, vehId, 0);

    TempVehicleData[totalTempVehicles][TempVehicleID] = vehId;
    TempVehicleData[totalTempVehicles][TempVehicle3DText] = Create3DTextLabel("(( Temporary vehicle ))", COLOR_LIGHTBLUE, 0.0, 0.0, 0.0, 20.0, 0);
    TempVehicleData[totalTempVehicles][TempVehicleSpawnerSQLID] = PlayerData[playerid][pSQLID];

    Attach3DTextLabelToVehicle(TempVehicleData[totalTempVehicles][TempVehicle3DText], TempVehicleData[totalTempVehicles][TempVehicleID], 0.0, 0.0, 0.4);

    totalTempVehicles++;

    new str[64];
    format(str, sizeof(str), "Temporary vehicle ID %d spawned. (%d/%d)", vehId, totalTempVehicles, MAX_TEMP_VEHICLES);
    SendMessage(playerid, str, MESSAGE_TYPE_SUCCESS);

    return true;
}

bool:DespawnTemporaryCar(vehicleid)
{
    if(vehicleid == 0 || vehicleid == INVALID_VEHICLE_ID) return false;

    for (new i = 0; i < totalTempVehicles; i++)
    {
        if (vehicleid == TempVehicleData[i][TempVehicleID])
        {
            Delete3DTextLabel(TempVehicleData[i][TempVehicle3DText]);
            DestroyVehicle(TempVehicleData[i][TempVehicleID]);

            // switch deleted element with last element so there isn't an empty space in the middle of the array
            TempVehicleData[i][TempVehicle3DText] = TempVehicleData[totalTempVehicles][TempVehicle3DText];
            TempVehicleData[i][TempVehicleID] = TempVehicleData[totalTempVehicles][TempVehicleID];

            TempVehicleData[totalTempVehicles][TempVehicle3DText] = INVALID_3DTEXT_ID;
            TempVehicleData[totalTempVehicles][TempVehicleID] = INVALID_VEHICLE_ID;

            totalTempVehicles--;

            return true;
        }
    }

    return false;
}

bool:DespawnAllTemporaryCars()
{
    for (new i = totalTempVehicles; i >= 0; i--)
    {
        Delete3DTextLabel(TempVehicleData[i][TempVehicle3DText]);
        DestroyVehicle(TempVehicleData[i][TempVehicleID]);

        TempVehicleData[i][TempVehicle3DText] = INVALID_3DTEXT_ID;
        TempVehicleData[i][TempVehicleID] = INVALID_VEHICLE_ID;
    }

    totalTempVehicles = 0;

    return true;
}

CMD:tempcar(playerid, params[])
{
    if (!LoggedIn[playerid]) return true;

    if (PlayerData[playerid][pAdminLevel] == 0) return SendMessage(playerid, "Unknown command.");

    if (PlayerData[playerid][pAdminLevel] < 3) return SendMessage(playerid, "You re not the required admin level to use this command. (level 3)");

    new option[64];
    if (sscanf(params, "s[64]{}", option)) return SendMessage(playerid, "/tempcar [spawn/despawn/despawnall]", MESSAGE_TYPE_USAGE);

    if (strmatch(option, "spawn"))
    {
        new modelid = -1;
        sscanf(params, "{s[64]}D(-1)", modelid);

        if(modelid == -1) return SendMessage(playerid, "/tempcar spawn [model ID]", MESSAGE_TYPE_USAGE);

        if(modelid < 400 || modelid > 611) return SendMessage(playerid, "The model ID is invalid. (must be between 400 and 611)", MESSAGE_TYPE_ERROR);

        return SpawnTemporaryCar(playerid, modelid);
    }
    else if (strmatch(option, "despawn"))
    {
        new vehicleid = -1;
        sscanf(params, "{s[64]}D(-1)", vehicleid);

        if(vehicleid == -1) return SendMessage(playerid, "/tempcar despawn [vehicle ID]", MESSAGE_TYPE_USAGE);

        new bool:success = DespawnTemporaryCar(vehicleid);

        if (success)
        {
            new str[64];
            format(str, sizeof(str), "Temporary vehicle despawned. (%d/%d)", totalTempVehicles, MAX_TEMP_VEHICLES);
            return SendMessage(playerid, str, MESSAGE_TYPE_SUCCESS);
        }

        new str[128];
        format(str, sizeof(str), "Couldn't despawn temporary vehicle ID %d. Maybe it's not a temporary vehicle.", vehicleid);
        return SendMessage(playerid, str, MESSAGE_TYPE_ERROR);
    }
    else if (strmatch(option, "despawnall"))
    {
        new bool:success = DespawnAllTemporaryCars();

        if (success) return SendMessage(playerid, "All temporary vehicles despawned.", MESSAGE_TYPE_SUCCESS);
        return SendMessage(playerid, "Couldn't despawn temporary vehicles. (Notify the scripter if you see this)", MESSAGE_TYPE_ERROR);
    }

    return true;
}
CMD:tempvehicle(playerid, params[]) return cmd_tempcar(playerid, params);