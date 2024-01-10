CMD:testcommands(playerid, params[])
{
    SendClientMessage(playerid, COLOR_WHITE, "Test commands: /giveinjury");

    return true;
}

CMD:giveinjury(playerid, params[])
{
    new bodyPart = 3 + random(6);

    // new validWeapons[] = {0, 1, 2, 3, 5, 6, 7, 10, 11, 12, 13, 14, 15, 4, 8, 9, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 16, 18, 35, 36, 37, 39, 40};

    new WEAPON:validWeapons[] = { WEAPON_FIST, WEAPON_BRASSKNUCKLE, WEAPON_GOLFCLUB, WEAPON_NITESTICK, WEAPON_BAT, WEAPON_SHOVEL, WEAPON_POOLSTICK, WEAPON_DILDO, WEAPON_DILDO2, WEAPON_VIBRATOR, WEAPON_VIBRATOR2, WEAPON_FLOWER, WEAPON_CANE, WEAPON_KNIFE, WEAPON_KATANA, WEAPON_CHAINSAW, WEAPON_COLT45, WEAPON_SILENCED, WEAPON_DEAGLE, WEAPON_SHOTGUN, WEAPON_SAWEDOFF, WEAPON_SHOTGSPA, WEAPON_UZI, WEAPON_MP5, WEAPON_AK47, WEAPON_M4, WEAPON_TEC9, WEAPON_RIFLE, WEAPON_SNIPER, WEAPON_GRENADE, WEAPON_MOLOTOV, WEAPON_ROCKETLAUNCHER, WEAPON_HEATSEEKER, WEAPON_FLAMETHROWER, WEAPON_SATCHEL, WEAPON_BOMB };

    new WEAPON:weaponId = validWeapons[random(sizeof(validWeapons) - 1)];

    new weaponName[25] = EOS;
    GetWeaponName(weaponId, weaponName, sizeof(weaponName));

    new Float:amount = random(100);

    SaveDamageData(playerid, weaponId, bodyPart, amount);

    new string[128];
    format(string, sizeof(string), "Injury given to yourself. (%s (%s) - %s | %f HP)", GetDamageType(weaponId), weaponName, GetBoneDamaged(bodyPart), amount);
    SendLocalMessage(playerid, COLOR_EMOTE, string);

    return true;
}

CMD:givecash(playerid, params[])
{
    if (!LoggedIn[playerid]) return true;

    if (PlayerData[playerid][pAdminLevel] == 0) return SendMessage(playerid, "Unknown command.");

    if (PlayerData[playerid][pAdminLevel] < 3) return SendMessage(playerid, "You re not the required admin level to use this command. (level 3)");

    new id, amount;
    if (sscanf(params, "ui", id, amount)) return SendMessage(playerid, "/givecash [player id or name] [amount]", MESSAGE_TYPE_USAGE);

    if (!IsPlayerConnected(id)) return SendMessage(playerid, "That player isn't connected.");
    if (!LoggedIn[id]) return SendMessage(playerid, "This player isn't logged in.");

    GiveCash(id, amount);

    new string[128];

    format(string, sizeof(string), "You gave %s %d$.", NameRP(id), amount);
    SendMessage(playerid, string, MESSAGE_TYPE_ADMIN);

    format(string, sizeof(string), "%s gave you %d$.", NameRP(playerid), amount);
    SendMessage(id, string, MESSAGE_TYPE_ADMIN);

    return true;
}