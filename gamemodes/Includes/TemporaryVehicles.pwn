CMD:tempvehicle(playerid, params[])
{
    if (!LoggedIn[playerid]) return true;

    if (PlayerData[playerid][pAdminLevel] == 0) return SendMessage(playerid, "Unknown command.");

    if (PlayerData[playerid][pAdminLevel] < 3) return SendMessage(playerid, "You re not the required admin level to use this command. (level 3)");

    if (isnull(params)) return SendMessage(playerid, "/tempvehicle [vehicle id]", MESSAGE_TYPE_USAGE);

    new Float:x, Float:y, Float:z, Float:rot;
    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, rot);

    new	vehId = CreateVehicle(strval(params), x, y, z, rot, -1, -1, -1);

    if (vehId == 0 || vehId == INVALID_VEHICLE_ID) return SendMessage(playerid, "Couldn't spawn vehicle!", MESSAGE_TYPE_ERROR);

    PutPlayerInVehicle(playerid, vehId, 0);

    TempVehicleData[totalTempVehicles][TempVehicleID] = vehId;
    TempVehicleData[totalTempVehicles][TempVehicle3DText] = Create3DTextLabel("Temporary vehicle", COLOR_RED, 0.0, 0.0, 0.0, 25.0, 0);
    Attach3DTextLabelToVehicle(TempVehicleData[totalTempVehicles][TempVehicle3DText], TempVehicleData[totalTempVehicles][TempVehicleID], 0.0, 0.0, 1.0);

    totalTempVehicles++;

    return true;
}