LoadServerBusinesses()
{
    return mysql_pquery(sqlConnection, "SELECT * FROM businesses ORDER BY id ASC", "SQL_LoadServerBusinesses");
}

Server:SQL_LoadServerBusinesses()
{
    if (cache_num_rows() == 0) return print("No businesses available to load from database!");

    new rows, fields;
    cache_get_row_count(rows);
    cache_get_field_count(fields);

    for (new i = 0; i < rows && i < MAX_BUSINESSES; i++)
    {
        cache_get_value_name_int(i, "id", BusinessData[i + 1][BusinessID]);
        cache_get_value_name_int(i, "OwnerSQL", BusinessData[i + 1][BusinessOwnerSQL]);
        cache_get_value_name_int(i, "Type",  BusinessData[i + 1][BusinessType]);
        cache_get_value_name(i, "Name", BusinessData[i + 1][BusinessName]);
        cache_get_value_name_int(i, "IntID", BusinessData[i + 1][BusinessInterior]);

        cache_get_value_name_float(i, "ExtX", BusinessData[i + 1][BusinessExterior][0]);
        cache_get_value_name_float(i, "ExtY", BusinessData[i + 1][BusinessExterior][1]);
        cache_get_value_name_float(i, "ExtZ", BusinessData[i + 1][BusinessExterior][2]);
        cache_get_value_name_float(i, "ExtA", BusinessData[i + 1][BusinessExterior][3]);

        cache_get_value_name_int(i, "Price",  BusinessData[i + 1][BusinessPrice]);
        cache_get_value_name_int(i, "Locked", BusinessData[i + 1][BusinessLocked]);

        totalBusinessesCreated++;
    }

    CreateServerBusinessData();

    printf("%i businesses loaded from the database.", totalBusinessesCreated);

    return true;
}

CreateServerBusinessData()
{
    for (new i = 0; i < MAX_BUSINESSES; i++)
    {
        if (BusinessData[i][BusinessID] != 0)
        {
            BusinessData[i][BusinessPickup] = CreatePickup(1272, 1, BusinessData[i][BusinessExterior][0], BusinessData[i][BusinessExterior][1], BusinessData[i][BusinessExterior][2], 0);
            BusinessData[i][BusinessLabel] = Create3DTextLabel(BusinessData[i][BusinessName], 0xFFFFFFFF, BusinessData[i][BusinessExterior][0], BusinessData[i][BusinessExterior][1], BusinessData[i][BusinessExterior][2], 10.0, 0);
        }
    }

    return true;
}

static Float:bCreateExt[4], bCreateInt, bCreateName[40], bCreatePrice, bCreateType;

CMD:makebusiness(playerid, params[])
{
    if (!LoggedIn[playerid]) return true;

    if (PlayerData[playerid][pAdminLevel] == 0) return SendMessage(playerid, "Unknown command.", MESSAGE_TYPE_ERROR);

    if (PlayerData[playerid][pAdminLevel] < 5) return SendMessage(playerid, "You re not the required admin level to use this command. (level 5)", MESSAGE_TYPE_ERROR);

    new section[10], extra[40], string[64];
    if (sscanf(params, "s[10]S('None')[40]", section, extra)) return SendMessage(playerid, "/makebusiness [exterior/interior/name/price/type/complete]", MESSAGE_TYPE_USAGE);

    if (strmatch(section, "exterior"))
    {
        GetPlayerPos(playerid, bCreateExt[0], bCreateExt[1], bCreateExt[2]);
        GetPlayerFacingAngle(playerid, bCreateExt[3]);

        SendMessage(playerid, "Exterior position set successfully.", MESSAGE_TYPE_SUCCESS);
    }
    else if (strmatch(section, "interior"))
    {
        // not working
        if (strmatch(extra, "None")) return SendMessage(playerid, "/makebusiness interior [interior ID (/intids)]", MESSAGE_TYPE_USAGE);

        if (strval(extra) != INTERIOR_GROCERIES_1) return SendMessage(playerid, "Invalid interior id!", MESSAGE_TYPE_ERROR);

        bCreateInt = strval(extra);

        format(string, sizeof(string), "Interior set successfully: %s.", GetInteriorNameFromId(bCreateInt));
        SendMessage(playerid, string, MESSAGE_TYPE_SUCCESS);
    }
    else if (strmatch(section, "name"))
    {
        if (strmatch(extra, "None")) return SendMessage(playerid, "Usage: /makebusiness name [name to set]", MESSAGE_TYPE_USAGE);

        if (strlen(extra) > 39 || strlen(extra) < 3) return SendMessage(playerid, "Name length must be between 3 and 39 characters long.", MESSAGE_TYPE_ERROR);

        bCreateName = extra;

        format(string, sizeof(string), "Name set successfully: %s.", bCreateName);
        SendMessage(playerid, string, MESSAGE_TYPE_SUCCESS);
    }
    else if (strmatch(section, "price"))
    {
        if (strmatch(extra, "None")) return SendMessage(playerid, "/makebusiness price [price to set]", MESSAGE_TYPE_USAGE);

        if (strval(extra) < 1) return SendMessage(playerid, "Price must be above 1$.", MESSAGE_TYPE_ERROR);

        bCreatePrice = strval(extra);

        format(string, sizeof(string), "Price set successfully: %d$.", bCreatePrice);
        SendMessage(playerid, string, MESSAGE_TYPE_SUCCESS);
    }
    else if (strmatch(section, "type"))
    {
        // not working
        if (strmatch(extra, "None")) return SendMessage(playerid, "/makeBusiness type [type (1 - Shop, 2 - Dealership)]", MESSAGE_TYPE_USAGE);

        if (strval(extra) != BUSINESS_TYPE_SHOP) return SendMessage(playerid, "Invalid type.", MESSAGE_TYPE_ERROR);

        bCreateType = strval(extra);

        format(string, sizeof(string), "Type set successfully: %s", GetBusinessTypeFromId(bCreateType));
        SendMessage(playerid, string, MESSAGE_TYPE_SUCCESS);
    }
    else if (strmatch(section, "complete"))
    {
        if (bCreatePrice == 0) return SendMessage(playerid, "The business doesn't have a price!", MESSAGE_TYPE_ERROR);
        if (bCreateInt == 0) return SendMessage(playerid, "The business doesn't have an interior!", MESSAGE_TYPE_ERROR);
        if (bCreateType == 0) return SendMessage(playerid, "The business doesn't have a type!", MESSAGE_TYPE_ERROR);
        if (strmatch(bCreateName, "None")) return SendMessage(playerid, "The business doesn't have a name!", MESSAGE_TYPE_ERROR);

        SaveBusinessToDatabase(playerid);
        SendMessage(playerid, "Business created!", MESSAGE_TYPE_SUCCESS);

        SetPlayerPos(playerid, bCreateExt[0], bCreateExt[1], bCreateExt[2]);
        SetPlayerFacingAngle(playerid, bCreateExt[3]);

        SetPlayerInterior(playerid, 0);
        SetPlayerVirtualWorld(playerid, 0);
    }

    return true;
}

Server:SaveBusinessToDatabase(playerid)
{
    new query[512];

    mysql_format(sqlConnection, query, sizeof(query), "INSERT INTO businesses (OwnerSQL, Type, Name, ExtX, ExtY, ExtZ, ExtA, IntID, Price) VALUES(0, %i, '%e', %f, %f, %f, %f, %i, %i)", bCreateType, bCreateName, bCreateExt[0], bCreateExt[1], bCreateExt[2], bCreateExt[3], bCreateInt, bCreatePrice);
    mysql_pquery(sqlConnection, query, "SQL_SaveBusinessToDatabase", "i", playerid);

    return true;
}

Server:SQL_SaveBusinessToDatabase(playerid)
{
    totalBusinessesCreated++;

    BusinessData[totalBusinessesCreated][BusinessID] = cache_insert_id();
    BusinessData[totalBusinessesCreated][BusinessOwnerSQL] = 0;

    format(BusinessData[totalBusinessesCreated][BusinessName], 40, bCreateName);

    BusinessData[totalBusinessesCreated][BusinessExterior][0] = bCreateExt[0];
    BusinessData[totalBusinessesCreated][BusinessExterior][1] = bCreateExt[1];
    BusinessData[totalBusinessesCreated][BusinessExterior][2] = bCreateExt[2];
    BusinessData[totalBusinessesCreated][BusinessExterior][3] = bCreateExt[3];

    BusinessData[totalBusinessesCreated][BusinessInterior] = bCreateInt;

    BusinessData[totalBusinessesCreated][BusinessType] = bCreateType;
    BusinessData[totalBusinessesCreated][BusinessPrice] = bCreatePrice;
    BusinessData[totalBusinessesCreated][BusinessLocked] = 0;

    BusinessData[totalBusinessesCreated][BusinessPickup] = CreatePickup(PICKUP_BLUE_HOUSE, 1, BusinessData[totalBusinessesCreated][BusinessExterior][0], BusinessData[totalBusinessesCreated][BusinessExterior][1], BusinessData[totalBusinessesCreated][BusinessExterior][2], 0);
    BusinessData[totalBusinessesCreated][BusinessLabel] = Create3DTextLabel(BusinessData[totalBusinessesCreated][BusinessName], COLOR_WHITE, BusinessData[totalBusinessesCreated][BusinessExterior][0], BusinessData[totalBusinessesCreated][BusinessExterior][1], BusinessData[totalBusinessesCreated][BusinessExterior][2], 10.0, 0);

    printf("Business ID %i created by %s", BusinessData[totalBusinessesCreated][BusinessID], GetName(playerid));

    new string[256];
    format(string, sizeof(string), "Business ID %i (SQLID %i) created: %s, %d$, type %s, interior %s.", totalBusinessesCreated, BusinessData[totalBusinessesCreated][BusinessID], BusinessData[totalBusinessesCreated][BusinessName], BusinessData[totalBusinessesCreated][BusinessPrice], GetBusinessTypeFromId(BusinessData[totalBusinessesCreated][BusinessType]), GetInteriorNameFromId(BusinessData[totalBusinessesCreated][BusinessInterior]));

    SendMessage(playerid, string, MESSAGE_TYPE_SUCCESS);

    return true;
}


CMD:intids(playerid)
{
    SendMessage(playerid, "Grocery 1 - 17");

    return true;
}

GetInteriorNameFromId(intId)
{
    new intName[32];

    switch (intId)
    {
        case 17: intName = "Grocery 1";
        default:
            intName = "Invalid";
    }

    // todo: If invalid, log error

    return intName;
}

GetBusinessTypeFromId(typeId)
{
    new typeName[32];

    switch (typeId)
    {
        case 1: typeName = "Shop";
        case 2: typeName = "Dealership";
        default:
            typeName = "Invalid";
    }

    // todo: If invalid, log error

    return typeName;
}