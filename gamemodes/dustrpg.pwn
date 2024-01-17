#include <open.mp> // v1.1.0.2612 https://github.com/openmultiplayer/open.mp/releases
#include <izcmd> // latest https://github.com/vegh-barnabas/hungarian-accents-I-ZCMD
#include <a_mysql> // R-41-4 https://github.com/pBlueG/SA-MP-MySQL/releases/tag/R41-4
#include <streamer> // v2.9.6 https://github.com/samp-incognito/samp-streamer-plugin/releases
#include <foreach> // 0.4.3 https://github.com/karimcambridge/samp-foreach/releases/tag/v19.1
#include <sscanf2> // 2.3.18 https://github.com/Y-Less/sscanf/releases
#include <fixes> // latest https://github.com/pawn-lang/sa-mp-fixes
#include <mapfix> // latest https://github.com/NexiusTailer/MapFix

#include "../gamemodes/Includes/VariablesEnumsDefines.pwn"
#include "../gamemodes/Includes/OtherFunctions.pwn"
#include "../gamemodes/Includes/Publics.pwn"

#include "../gamemodes/Includes/General_Commands.pwn"
#include "../gamemodes/Includes/Account_Commands.pwn"
#include "../gamemodes/Includes/Test_Commands.pwn"

#include "../gamemodes/Includes/Houses.pwn"
#include "../gamemodes/Includes/Businesses.pwn"
#include "../gamemodes/Includes/OwnedVehicles.pwn"
#include "../gamemodes/Includes/Factions.pwn"
#include "../gamemodes/Includes/FactionVehicles.pwn"
#include "../gamemodes/Includes/TemporaryVehicles.pwn"

main() {}

public OnGameModeInit()
{
    SetGameModeText("Basic Roleplay "VERSION_TEXT"");

    EnableStuntBonusForAll(false);
    DisableInteriorEnterExits();

    mysql_log(ALL);

    sqlConnection = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_PASSWORD, MYSQL_DATABASE);
    new errno = mysql_errno(sqlConnection);

    if (sqlConnection == MYSQL_INVALID_HANDLE || errno != 0)
    {
        new error[100];

        mysql_error(error, sizeof(error), sqlConnection);
        printf("[ERROR] #%d '%s'", errno, error);

        SendRconCommand("exit");
    }

    OneSecondTimer = SetTimer("TIMER_OneSecondTimer", 1000, true);

    LoadServerHouses();
    LoadServerBusinesses();
    print("[MySQL]: Loading finished.");

    return true;
}

public OnGameModeExit()
{
    KillTimer(OneSecondTimer);

    mysql_close(sqlConnection);

    return false;
}

public OnPlayerConnect(playerid)
{
    DefaultPlayerValues(playerid);
    DoesPlayerExist(playerid);

    SetTimerEx("TIMER_SetCameraPos", 1000, false, "i", playerid);

    return true;
}

public OnPlayerDisconnect(playerid, reason)
{
    DefaultPlayerValues(playerid);

    return true;
}

public OnPlayerSpawn(playerid)
{
    ResetDamageData(playerid);

    return true;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch (dialogid)
    {
        case DIALOG_REGISTER:
        {
            if (!response) return Kick(playerid);

            if (strlen(inputtext) < 3 || strlen(inputtext) > 30)
            {
                ShowRegisterDialog(playerid, "Password length must be above 3 characters and below 30 characters long.");

                return true;
            }

            new query[256];
            mysql_format(sqlConnection, query, sizeof(query), "INSERT INTO players (Name, Password, RegIP) VALUES('%e', sha1('%e'), '%e')", GetName(playerid), inputtext, GetIP(playerid));
            mysql_pquery(sqlConnection, query, "SQL_OnAccountRegister", "i", playerid);
        }
        case DIALOG_LOGIN:
        {
            if (!response) return Kick(playerid);

            new query[256];
            mysql_format(sqlConnection, query, sizeof(query), "SELECT id FROM players WHERE Name = '%e' AND Password = sha1('%e') LIMIT 1", GetName(playerid), inputtext);
            mysql_pquery(sqlConnection, query, "SQL_OnAccountLogin", "i", playerid);
        }
    }

    return false;
}

public OnPlayerTakeDamage(playerid, issuerid, Float:amount, WEAPON:weaponid, bodypart)
{
    if (issuerid != INVALID_PLAYER_ID)
    {
        SaveDamageData(playerid, weaponid, bodypart, amount);
    }

    return true;
}

public OnPlayerText(playerid, text[])
{
    new pText[144];
    format(pText, sizeof(pText), "%s says: %s", NameRP(playerid), text);
    SendLocalMessageEx(playerid, COLOR_WHITE, pText, 7.5);

    return false;
}

public OnVehicleDeath(vehicleid, killerid)
{
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

    return true;
}

public OnPlayerUpdate(playerid)
{
    if (GetPlayerMoney(playerid) != GetPVarInt(playerid, "currentMoney")) OnPlayerChangeMoney(playerid, GetPVarInt(playerid, "currentMoney"), GetPlayerMoney(playerid));

    return true;
}

Server:OnPlayerChangeMoney(playerid, oldAmount, newAmount)
{
    if (newAmount == PlayerData[playerid][pMoney])
    {
        SetPVarInt(playerid, "currentMoney", newAmount);
    }
    else Ban(playerid);
}