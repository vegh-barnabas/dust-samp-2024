LoadServerRentableVehicles()
{
    return mysql_pquery(sqlConnection, "SELECT * FROM rentablecars ORDER BY id ASC", "SQL_LoadServerRentableVehicles");
}

Server:SQL_LoadServerRentableVehicles()
{
    if (cache_num_rows() == 0) return print("No rentable cars available to load from database!");

    new rows, fields;
    cache_get_row_count(rows);
    cache_get_field_count(fields);

    new totalRentableVehiclesCreated = 0;

    for (new i = 0; i < rows && i < MAX_VEHICLES; i++)
    {
        new modelId;
        new Float:posX, Float:posY, Float:posZ, Float:posA;
        new Float:spawnPosX, Float:spawnPosY, Float:spawnPosZ, Float:spawnPosA;
        new color1, color2;
        new rentStart, rentDuration;

        new currentTime = gettime();

        cache_get_value_name_int(i, "ModelID", modelId);

        cache_get_value_name_int(i, "Color1", color1);
        cache_get_value_name_int(i, "Color2", color2);

        cache_get_value_name_int(i, "RentStart", rentStart);
        cache_get_value_name_int(i, "RentDuration", rentDuration);

        // if the rent period is over
        if (currentTime > rentStart + rentDuration)
        {
            cache_get_value_name_float(i, "SpawnPosX", posX);
            cache_get_value_name_float(i, "SpawnPosY", posY);
            cache_get_value_name_float(i, "SpawnPosZ", posZ);
            cache_get_value_name_float(i, "SpawnPosA", posA);
        }
        else
        {
            cache_get_value_name_float(i, "PosX", posX);
            cache_get_value_name_float(i, "PosY", posY);
            cache_get_value_name_float(i, "PosZ", posZ);
            cache_get_value_name_float(i, "PosA", posA);
        }

        vehicleId = CreateVehicle(modelId, posX, posY, posZ, posA, color1, color2, -1);

        if (vehicleId != INVALID_VEHICLE_ID)
        {
            RentableCarData[vehicleId][Model] = modelId;

            RentableCarData[vehicleId][Color][0] = color1;
            RentableCarData[vehicleId][Color][1] = color2;

            RentableCarData[vehicleId][Pos][0] = posX;
            RentableCarData[vehicleId][Pos][1] = posY;
            RentableCarData[vehicleId][Pos][2] = posZ;
            RentableCarData[vehicleId][Pos][3] = posA;

            cache_get_value_name_int(i, "Price", RentableCarData[vehicleId][Price]);

            cache_get_value_name(i, "Plate", RentableCarData[vehicleId][OwnedCarPlate]);
            SetVehicleNumberPlate(vehicleId, RentableCarData[vehicleId][OwnedCarPlate]);

            cache_get_value_name_float(i, "SpawnPosX", RentableCarData[vehicleId][SpawnPos][0]);
            cache_get_value_name_float(i, "SpawnPosY", RentableCarData[vehicleId][SpawnPos][1]);
            cache_get_value_name_float(i, "SpawnPosZ", RentableCarData[vehicleId][SpawnPos][2]);
            cache_get_value_name_float(i, "SpawnPosA", RentableCarData[vehicleId][SpawnPos][3]);

            // if the rent period is over
            if (currentTime > rentStart + rentDuration)
            {
                RentableCarData[vehicleId][RenterSQL] = -1;
                RentableCarData[vehicleId][RentStart] = 0;
                RentableCarData[vehicleId][RentDuration] = 0;
                RentableCarData[vehicleId][LockState] = 0;
            }
            else
            {
                RentableCarData[vehicleId][RentStart] = rentStart;
                RentableCarData[vehicleId][RentDuration] = rentDuration;

                cache_get_value_name_int(i, "RenterSQL", RentableCarData[vehicleId][RenterSQL]);
                cache_get_value_name_int(i, "LockState", RentableCarData[vehicleId][LockState]);
            }

            SetVehicleToRespawn(vehicleId);

            if (RentableCarData[vehicleId][LockState] == 1) ToggleVehicleLock(vehicleId, true);
            else ToggleVehicleLock(vehicleId, false);

            totalRentableVehiclesCreated++;
        }
    }

    printf("%i rentable vehicles loaded from the database.", totalRentableVehiclesCreated);

    // fields: model, posX, posY, posZ, posA, spawnPosX, spawnPosY, spawnPosZ, spawnPosA, color1, color2, price, renterSQLID, rentStart, rentDuration
    // rentDuration and start is in ms
    // there is no timer, only when the player gets in, the server starts or the rentable vehicles get listed with /car rentables or something
    // if the current time is greater than rentStart+rentDuration, then the rent is over and the car is free
    // or check it in every 5 minutes
    // unlock it if the rent is over
    // or maybe it's easier to create a timer to each car AND check on server start if the rent period is over
}

// TODO when creating one, first you get the vehicle spawned, after you park it, and then the position gets saved
// /car create [rentable/ownable/work/etc...]
// /car create rentable [modelID (name also works)] [color1 (code or name)] [color2 (code or name)] [price]
// it gets spawned and you have to park it like mentioned before

// /car rent [minutes] - rents the car for x minutes - price times x gets subtracted from money

// later on when whe have the cool GTA IV style phone system, we can implement that the phone pops up when the player gets in the rentable vehicle
// the phone asks wether the player wants to rent the car and for how long
// or only if they want to rent it, and if yes, it gets rented for x minutes, and they can extend it by x on their phone

// if the car is outside a certain area, it will respawn

// TODO implement renting cars
CMD:rent(playerid, params[])
{

    return true;
}

// aliases: veh, vehicle, v
CMD:rentablecar(playerid, params[])
{
    if (!LoggedIn[playerid]) return true;

    new option[64];
    if (sscanf(params, "s[64]{}", option))
    {
        if (PlayerData[playerid][pAdminLevel] > 0) return SendMessage(playerid, "/rentablecar [create]", MESSAGE_TYPE_USAGE);

        return SendMessage(playerid, "/rentablecar [...]", MESSAGE_TYPE_USAGE); // TODO extend this
    }

    if (strmatch(option, "create"))
    {
        if (PlayerData[playerid][pAdminLevel] == 0) return SendMessage(playerid, "Unknown command.");
        if (PlayerData[playerid][pAdminLevel] < 3) return SendMessage(playerid, "You re not the required admin level to use this command. (level 3)");

        new modelid = -1, color1 = -1, color2 = -1, price = -1;
        sscanf(params, "{s[64]}d(-1)d(-1)d(-1)d(-1)", modelid, color1, color2, price);

        if (modelid == -1 || color1 == -1 || color2 == -1) return SendMessage(playerid, "/rentablecar create [model ID] [color 1] [color 2] [price]", MESSAGE_TYPE_USAGE);

        if (modelid < 400 || modelid > 611) return SendMessage(playerid, "The model ID is invalid. (must be between 400 and 611)", MESSAGE_TYPE_ERROR);
        if (color1 < 0 || color1 > 255) return SendMessage(playerid, "The first color is invalid. (must be above 0 and below 255)", MESSAGE_TYPE_ERROR);
        if (color2 < 0 || color2 > 255) return SendMessage(playerid, "The second color is invalid. (must be above 0 and below 255)", MESSAGE_TYPE_ERROR);
        if (price < 0) return SendMessage(playerid, "The price is invalid. (must be above 0)", MESSAGE_TYPE_ERROR);

        return CreateRentableCar(playerid, modelid);
    }

    return true;
}

Server:CreateRentableCar(playerid, modelid)
{
    if (totalRentableVehiclesCreated >= MAX_RENTABLE_VEHICLES)
    {
        new str[128];
        format(str, sizeof(str), "The rentable vehicle limit is reached (%d/%d cars)!", totalRentableVehiclesCreated, MAX_RENTABLE_VEHICLES);
        return SendMessage(playerid, str, MESSAGE_TYPE_ERROR);
    }

    new Float:x, Float:y, Float:z, Float:rot;
    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, rot);

    new	vehId = CreateVehicle(modelid, x, y, z, rot, -1, -1, -1);
    if (vehId == 0 || vehId == INVALID_VEHICLE_ID) return SendMessage(playerid, "Couldn't spawn vehicle! Maybe you gave a bad model ID.", MESSAGE_TYPE_ERROR);

    PutPlayerInVehicle(playerid, vehId, 0);

    // might not needed but give it a think:
    // TempVehicleData[totalTempVehicles][TempVehicleID] = vehId;
    // TempVehicleData[totalTempVehicles][TempVehicleSpawnerSQLID] = PlayerData[playerid][pSQLID];

    new str[64];
    format(str, sizeof(str), "Park the car where you want it to be, and leave it to save its position.");
    SendMessage(playerid, str, MESSAGE_TYPE_ADMIN);
    // remove all temporary stuff if the user crashes

    // TODO this part needs to be implemented in the OnPlayerExitVehicle
    // implement the SQL query to insert and spawn the car like  in SQL_LoadServerRentableVehicles function
    totalRentableVehiclesCreated++;

    return true;
}

// TODO implement adding text to the rentable car on spawning and on creating