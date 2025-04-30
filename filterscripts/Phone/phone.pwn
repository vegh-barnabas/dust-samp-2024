// -- PHONE SYSTEM --
// TODO make phone unopenable while jumping or sprinting
// TODO only standing still or crouching or driving is ok to open phone
// TODO in a car only standing still can open phone OR in car you can open the phone but control it with num keys, and on exiting put away the phone
// TODO in the advanced version, there could be a change between num keys and arrows
// TODO there could be a scrollbar when writing messages and dynamically calculate it
// TODO fix phone clock - put 0 when the minute is not a 2 szamjegyu, also check if clocks works like this too? probably yes if its a number type
// TODO add gps

#include <open.mp> // v1.1.0.2612 https://github.com/openmultiplayer/open.mp/releases
#include <izcmd> // latest https://github.com/vegh-barnabas/hungarian-accents-I-ZCMD
#include <a_mysql> // R-41-4 https://github.com/pBlueG/SA-MP-MySQL/releases/tag/R41-4

#include "../gamemodes/Includes/VariablesEnumsDefines.pwn" // Days
#include "../gamemodes/Includes/OtherFunctions.pwn" // GetCurentDay

#include "../gamemodes/Includes/Anticheat.pwn" // OnPlayerChangeMoney

#include "../filterscripts/Phone/Includes/Phone_Textdraws.pwn"

// key defines
#define RELEASED(%0) (((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))

#define KEY_ENTER       KEY_SECONDARY_ATTACK
#define KEY_SPACE       KEY_SPRINT

// phone defines
#define PHONE_MENU_NONE         0
#define PHONE_MENU_MAIN         1
#define PHONE_MENU_PHONEBOOK    2
#define PHONE_MENU_MESSAGES     3

// #define PHONE_MENU_OPTION_NONE      0
#define PHONE_MENU_OPTION_PHONEBOOK 0
#define PHONE_MENU_OPTION_MESSAGES  1
#define PHONE_MENU_OPTION_RENTACAR  2
#define PHONE_MENU_OPTION_OPTIONS   3

#define NEXT_BUTTON     0
#define PREVIOUS_BUTTON 1

// phone variables
new isPhoneShowing[MAX_PLAYERS];
new phoneButtonPressTimer[MAX_PLAYERS];
new phoneButtonPressAllowed[MAX_PLAYERS];
new setPlayerClockTimer[MAX_PLAYERS];
new selectedMenuButtonIndex[MAX_PLAYERS];
new phoneMenuLocation[MAX_PLAYERS];

public OnFilterScriptInit()
{
    print("[Filterscript]: Phone Filterscript v0.1 by ugrobolha loaded!");

    return true;
}

public OnFilterScriptExit()
{
    return true;
}

public OnPlayerConnect(playerid)
{
    CreatePhoneTextDraws(playerid);
    SetDefaultPhoneValues(playerid);

    isPhoneShowing[playerid] = false;

    return true;
}

public OnPlayerDisconnect(playerid, reason)
{
    isPhoneShowing[playerid] = false;
    KillTimer(phoneButtonPressTimer[playerid]);

    return true;
}

public OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys)
{
    if (RELEASED(KEY_ENTER))
    {
        if (isPhoneShowing[playerid])
        {
            if (phoneMenuLocation[playerid] == PHONE_MENU_MAIN)
            {
                // todo this is a duplicate code, can be unified
                HidePhoneBase(playerid);
                HidePhoneMenuSelection(playerid);
                HidePhoneMainMenu(playerid); // todo this should be HidePhoneCurrentMenu - or maybe not

                isPhoneShowing[playerid] = false;
                selectedMenuButtonIndex[playerid] = 0;

                TogglePlayerControllable(playerid, true);

                KillTimer(setPlayerClockTimer[playerid]);
            }
            else if (phoneMenuLocation[playerid] == PHONE_MENU_MESSAGES)
            {
                HidePhoneMessagesMenuSelection(playerid);
                HidePhoneMessagesMenu(playerid);

                selectedMenuButtonIndex[playerid] = 0;
                ShowPhoneMenuSelection(playerid);

                ShowPhoneMainMenu(playerid);
            }
        }
    }
    else if (RELEASED(KEY_SPACE))
    {
        if (isPhoneShowing[playerid])
        {
            if (phoneMenuLocation[playerid] == PHONE_MENU_MAIN)
            {
                if (selectedMenuButtonIndex[playerid] == PHONE_MENU_OPTION_PHONEBOOK)
                {
                    SendClientMessage(playerid, -1, "phonebook");
                }
                else if (selectedMenuButtonIndex[playerid] == PHONE_MENU_OPTION_MESSAGES)
                {
                    HidePhoneMainMenu(playerid);
                    HidePhoneMenuSelection(playerid);

                    ShowPhoneMessagesMenu(playerid);

                    selectedMenuButtonIndex[playerid] = 0;

                    ShowPhoneMessagesMenuSelection(playerid);
                }
                else if (selectedMenuButtonIndex[playerid] == PHONE_MENU_OPTION_RENTACAR)
                {
                    SendClientMessage(playerid, -1, "rentacar");
                }
                else if (selectedMenuButtonIndex[playerid] == PHONE_MENU_OPTION_OPTIONS)
                {
                    SendClientMessage(playerid, -1, "options");
                }
            }
        }
    }

    return true;
}

public OnPlayerUpdate(playerid)
{
    if (GetPlayerMoney(playerid) != GetPVarInt(playerid, "currentMoney")) OnPlayerChangeMoney(playerid, GetPVarInt(playerid, "currentMoney"), GetPlayerMoney(playerid));

    if (isPhoneShowing[playerid] && phoneButtonPressAllowed[playerid])
    {
        new KEY:keys, updown, leftright;

        GetPlayerKeys(playerid, keys, updown, leftright);

        if (updown == KEY_UP)
        {
            NextMenuButton(playerid, PREVIOUS_BUTTON);

            phoneButtonPressAllowed[playerid] = false;
            // TODO maybe go with a timerless method?
            phoneButtonPressTimer[playerid] = SetTimerEx("TIMER_PhoneButtonPressTimer", 300, false, "i", playerid);
        }
        else if (updown == KEY_DOWN)
        {
            NextMenuButton(playerid, NEXT_BUTTON);

            phoneButtonPressAllowed[playerid] = false;
            phoneButtonPressTimer[playerid] = SetTimerEx("TIMER_PhoneButtonPressTimer", 300, false, "i", playerid);
        }
        else
        {
            KillTimer(phoneButtonPressTimer[playerid]);
        }
    }

    return true;
}



Server:SetPlayerPhoneDay(playerid)
{
    new currentDayTextdrawText[4] = "-";
    new currentDay = GetCurrentDay();
    switch (currentDay)
    {
        case DAY_MONDAY: currentDayTextdrawText = "MON";
        case DAY_TUESDAY: currentDayTextdrawText = "TUE";
        case DAY_WEDNESDAY: currentDayTextdrawText = "WEN";
        case DAY_THURSDAY: currentDayTextdrawText = "THU";
        case DAY_FRIDAY: currentDayTextdrawText = "FRI";
        case DAY_SATURDAY: currentDayTextdrawText = "SAT";
        case DAY_SUNDAY: currentDayTextdrawText = "SUN";
    }

    PlayerTextDrawSetString(playerid, topLineDayIndicator[playerid], currentDayTextdrawText);

    return true;
}

Server:SetPlayerPhoneTime(playerid)
{
    new hour, minute;
    GetPlayerTime(playerid, hour, minute);

    new hourStr[4];
    new minuteStr[4];

    if (hour < 10)
    {
        format(hourStr, sizeof(hourStr), "0%d", hour);
    }
    else
    {
        format(hourStr, sizeof(hourStr), "%d", hour);
    }

    if (minute < 10)
    {
        format(minuteStr, sizeof(minuteStr), "0%d", minute);
    }
    else
    {
        format(minuteStr, sizeof(minuteStr), "%d", minute);
    }

    new string[12];
    format(string, sizeof(string), "%s:%s", hourStr, minuteStr);
    PlayerTextDrawSetString(playerid, topLineHourIndicator[playerid], string);

    return true;
}

CMD:phone(playerid, params[])
{
    if (!isPhoneShowing[playerid])
    {
        SetPlayerPhoneTime(playerid);
        SetPlayerPhoneDay(playerid);

        ShowPhoneBase(playerid);
        HidePhoneMenuSelection(playerid);
        ShowPhoneMainMenu(playerid);

        isPhoneShowing[playerid] = true;

        ShowPhoneMenuSelection(playerid);

        TogglePlayerControllable(playerid, false);

        setPlayerClockTimer[playerid] = SetTimerEx("TIMER_SetPlayerClockTimer", 15 * 1000, true, "i", playerid);
    }
    else
    {
        HidePhoneBase(playerid);

        if (phoneMenuLocation[playerid] == PHONE_MENU_MAIN)
        {
            HidePhoneMenuSelection(playerid);
            HidePhoneMainMenu(playerid);
        }
        else if (phoneMenuLocation[playerid] == PHONE_MENU_MESSAGES)
        {
            HidePhoneMessagesMenu(playerid);
        }

        TogglePlayerControllable(playerid, true);

        KillTimer(setPlayerClockTimer[playerid]);

        SetDefaultPhoneValues(playerid);
    }

    return true;
}

SetDefaultPhoneValues(playerid)
{
    selectedMenuButtonIndex[playerid] = 0;
    isPhoneShowing[playerid] = false;
    phoneButtonPressAllowed[playerid] = true;

    return true;
}

ShowPhoneBase(playerid)
{
    PlayerTextDrawShow(playerid, phoneBg[playerid]);
    PlayerTextDrawShow(playerid, screenBg[playerid]);

    PlayerTextDrawShow(playerid, screenBottomLine[playerid]);
    PlayerTextDrawShow(playerid, screenLeftBtn[playerid]);
    PlayerTextDrawShow(playerid, screenRightBtn[playerid]);

    PlayerTextDrawShow(playerid, screenTopLine[playerid]);
    PlayerTextDrawShow(playerid, topLineSignalIndicator1[playerid]);
    PlayerTextDrawShow(playerid, topLineSignalIndicator2[playerid]);
    PlayerTextDrawShow(playerid, topLineSignalIndicator3[playerid]);
    PlayerTextDrawShow(playerid, topLineSignalIndicator4[playerid]);
    PlayerTextDrawShow(playerid, topLineHourIndicator[playerid]);
    PlayerTextDrawShow(playerid, topLineDayIndicator[playerid]);

    PlayerTextDrawShow(playerid, buttonPanelPhoneIcon[playerid]);
    PlayerTextDrawShow(playerid, buttonPanelABC[playerid]);
    PlayerTextDrawShow(playerid, buttonPanelDEF[playerid]);
    PlayerTextDrawShow(playerid, buttonPanelGHI[playerid]);
    PlayerTextDrawShow(playerid, buttonPanelJKL[playerid]);
    PlayerTextDrawShow(playerid, buttonPanelMNO[playerid]);
    PlayerTextDrawShow(playerid, buttonPanelPQRS[playerid]);
    PlayerTextDrawShow(playerid, buttonPanelTUV[playerid]);
    PlayerTextDrawShow(playerid, buttonPanelWXYZ[playerid]);

    PlayerTextDrawShow(playerid, buttonPanel1[playerid]);
    PlayerTextDrawShow(playerid, buttonPanel2[playerid]);
    PlayerTextDrawShow(playerid, buttonPanel3[playerid]);
    PlayerTextDrawShow(playerid, buttonPanel4[playerid]);
    PlayerTextDrawShow(playerid, buttonPanel5[playerid]);
    PlayerTextDrawShow(playerid, buttonPanel6[playerid]);
    PlayerTextDrawShow(playerid, buttonPanel7[playerid]);
    PlayerTextDrawShow(playerid, buttonPanel8[playerid]);
    PlayerTextDrawShow(playerid, buttonPanel9[playerid]);

    PlayerTextDrawShow(playerid, menuButtonBackgrounds[playerid][phonebook]);
    PlayerTextDrawShow(playerid, menuButtonBackgrounds[playerid][messages]);
    PlayerTextDrawShow(playerid, menuButtonBackgrounds[playerid][rentACar]);
    PlayerTextDrawShow(playerid, menuButtonBackgrounds[playerid][options]);

    return true;
}

HidePhoneBase(playerid)
{
    PlayerTextDrawHide(playerid, phoneBg[playerid]);
    PlayerTextDrawHide(playerid, screenBg[playerid]);

    PlayerTextDrawHide(playerid, screenBottomLine[playerid]);
    PlayerTextDrawHide(playerid, screenLeftBtn[playerid]);
    PlayerTextDrawHide(playerid, screenRightBtn[playerid]);

    PlayerTextDrawHide(playerid, screenTopLine[playerid]);
    PlayerTextDrawHide(playerid, topLineSignalIndicator1[playerid]);
    PlayerTextDrawHide(playerid, topLineSignalIndicator2[playerid]);
    PlayerTextDrawHide(playerid, topLineSignalIndicator3[playerid]);
    PlayerTextDrawHide(playerid, topLineSignalIndicator4[playerid]);
    PlayerTextDrawHide(playerid, topLineHourIndicator[playerid]);
    PlayerTextDrawHide(playerid, topLineDayIndicator[playerid]);

    PlayerTextDrawHide(playerid, buttonPanelPhoneIcon[playerid]);
    PlayerTextDrawHide(playerid, buttonPanelABC[playerid]);
    PlayerTextDrawHide(playerid, buttonPanelDEF[playerid]);
    PlayerTextDrawHide(playerid, buttonPanelGHI[playerid]);
    PlayerTextDrawHide(playerid, buttonPanelJKL[playerid]);
    PlayerTextDrawHide(playerid, buttonPanelMNO[playerid]);
    PlayerTextDrawHide(playerid, buttonPanelPQRS[playerid]);
    PlayerTextDrawHide(playerid, buttonPanelTUV[playerid]);
    PlayerTextDrawHide(playerid, buttonPanelWXYZ[playerid]);

    PlayerTextDrawHide(playerid, buttonPanel1[playerid]);
    PlayerTextDrawHide(playerid, buttonPanel2[playerid]);
    PlayerTextDrawHide(playerid, buttonPanel3[playerid]);
    PlayerTextDrawHide(playerid, buttonPanel4[playerid]);
    PlayerTextDrawHide(playerid, buttonPanel5[playerid]);
    PlayerTextDrawHide(playerid, buttonPanel6[playerid]);
    PlayerTextDrawHide(playerid, buttonPanel7[playerid]);
    PlayerTextDrawHide(playerid, buttonPanel8[playerid]);
    PlayerTextDrawHide(playerid, buttonPanel9[playerid]);

    return true;
}

ShowPhoneMessagesMenu(playerid)
{
    phoneMenuLocation[playerid] = PHONE_MENU_MESSAGES; // todo this shouldnt be here as its not here in the hide one

    PlayerTextDrawShow(playerid, messageListItem1Bg[playerid]);
    PlayerTextDrawShow(playerid, messageListItem1Row1[playerid]);
    PlayerTextDrawShow(playerid, messageListItem1Row2[playerid]);
    PlayerTextDrawShow(playerid, messageListItem1Sender[playerid]);
    PlayerTextDrawShow(playerid, messageListItem1Time[playerid]);

    PlayerTextDrawShow(playerid, messageListItem2Bg[playerid]);
    PlayerTextDrawShow(playerid, messageListItem2Row1[playerid]);
    PlayerTextDrawShow(playerid, messageListItem2Row2[playerid]);
    PlayerTextDrawShow(playerid, messageListItem2Sender[playerid]);
    PlayerTextDrawShow(playerid, messageListItem2Time[playerid]);

    PlayerTextDrawShow(playerid, screenMiddleBtn[playerid]);

    return true;
}

HidePhoneMessagesMenu(playerid)
{
    PlayerTextDrawHide(playerid, messageListItem1Bg[playerid]);
    PlayerTextDrawHide(playerid, messageListItem1Row1[playerid]);
    PlayerTextDrawHide(playerid, messageListItem1Row2[playerid]);
    PlayerTextDrawHide(playerid, messageListItem1Sender[playerid]);
    PlayerTextDrawHide(playerid, messageListItem1Time[playerid]);

    PlayerTextDrawHide(playerid, messageListItem2Bg[playerid]);
    PlayerTextDrawHide(playerid, messageListItem2Row1[playerid]);
    PlayerTextDrawHide(playerid, messageListItem2Row2[playerid]);
    PlayerTextDrawHide(playerid, messageListItem2Sender[playerid]);
    PlayerTextDrawHide(playerid, messageListItem2Time[playerid]);

    PlayerTextDrawHide(playerid, screenMiddleBtn[playerid]);

    return true;
}

ShowPhoneMainMenu(playerid)
{
    phoneMenuLocation[playerid] = PHONE_MENU_MAIN;

    PlayerTextDrawShow(playerid, menuButtons[playerid][phonebook]);
    PlayerTextDrawShow(playerid, menuButtons[playerid][messages]);
    PlayerTextDrawShow(playerid, menuButtons[playerid][rentACar]);
    PlayerTextDrawShow(playerid, menuButtons[playerid][options]);

    return true;
}

HidePhoneMainMenu(playerid)
{
    phoneMenuLocation[playerid] = PHONE_MENU_NONE;

    PlayerTextDrawHide(playerid, menuButtons[playerid][phonebook]);
    PlayerTextDrawHide(playerid, menuButtons[playerid][messages]);
    PlayerTextDrawHide(playerid, menuButtons[playerid][rentACar]);
    PlayerTextDrawHide(playerid, menuButtons[playerid][options]);

    return true;
}

HidePhoneMessagesMenuSelection(playerid)
{
    switch (selectedMenuButtonIndex[playerid])
    {
        case 0: ToggleMenuButtonBackground(playerid, messageListItem1Active[playerid], false);
        case 1: ToggleMenuButtonBackground(playerid, messageListItem2Active[playerid], false);
    }

    return true;
}

HidePhoneMenuSelection(playerid)
{
    switch (selectedMenuButtonIndex[playerid])
    {
        case 0: ToggleMenuButtonBackground(playerid, menuButtonBackgrounds[playerid][phonebook], false);
        case 1: ToggleMenuButtonBackground(playerid, menuButtonBackgrounds[playerid][messages], false);
        case 2: ToggleMenuButtonBackground(playerid, menuButtonBackgrounds[playerid][rentACar], false);
        case 3: ToggleMenuButtonBackground(playerid, menuButtonBackgrounds[playerid][options], false);
    }

    return true;
}

ShowPhoneMessagesMenuSelection(playerid)
{
    switch (selectedMenuButtonIndex[playerid])
    {
        case 0: ToggleMenuButtonBackground(playerid, messageListItem1Active[playerid], true);
        case 1: ToggleMenuButtonBackground(playerid, messageListItem2Active[playerid], true);
    }

    return true;
}

ShowPhoneMenuSelection(playerid)
{
    switch (selectedMenuButtonIndex[playerid])
    {
        case 0: ToggleMenuButtonBackground(playerid, menuButtonBackgrounds[playerid][phonebook], true);
        case 1: ToggleMenuButtonBackground(playerid, menuButtonBackgrounds[playerid][messages], true);
        case 2: ToggleMenuButtonBackground(playerid, menuButtonBackgrounds[playerid][rentACar], true);
        case 3: ToggleMenuButtonBackground(playerid, menuButtonBackgrounds[playerid][options], true);
    }

    return true;
}

ShowPhonePhonebookMenuSelection(playerid)
{

}

CMD:next(playerid, params[])
{
    if (!isPhoneShowing[playerid]) return true;

    NextMenuButton(playerid, NEXT_BUTTON);

    return true;
}

CMD:previous(playerid, params[])
{
    if (!isPhoneShowing[playerid]) return true;

    NextMenuButton(playerid, PREVIOUS_BUTTON);

    return true;
}

NextMenuButton(const playerid, const moveDirection)
{
    // todo make this simpler
    if (phoneMenuLocation[playerid] == PHONE_MENU_MAIN)
    {
        // todo default error
        switch (selectedMenuButtonIndex[playerid])
        {
            case 0: ToggleMenuButtonBackground(playerid, menuButtonBackgrounds[playerid][phonebook], false);
            case 1: ToggleMenuButtonBackground(playerid, menuButtonBackgrounds[playerid][messages], false);
            case 2: ToggleMenuButtonBackground(playerid, menuButtonBackgrounds[playerid][rentACar], false);
            case 3: ToggleMenuButtonBackground(playerid, menuButtonBackgrounds[playerid][options], false);
        }

        if (moveDirection == NEXT_BUTTON)
        {
            if (selectedMenuButtonIndex[playerid] == mainMenuButtonCount - 1) selectedMenuButtonIndex[playerid] = 0;
            else selectedMenuButtonIndex[playerid]++;
        }
        else if (moveDirection == PREVIOUS_BUTTON)
        {

            if (selectedMenuButtonIndex[playerid] == 0) selectedMenuButtonIndex[playerid] = mainMenuButtonCount - 1;
            else selectedMenuButtonIndex[playerid]--;
        }
        else
        {
            // todo error
        }


        // todo default error
        switch (selectedMenuButtonIndex[playerid])
        {
            case 0: ToggleMenuButtonBackground(playerid, menuButtonBackgrounds[playerid][phonebook], true);
            case 1: ToggleMenuButtonBackground(playerid, menuButtonBackgrounds[playerid][messages], true);
            case 2: ToggleMenuButtonBackground(playerid, menuButtonBackgrounds[playerid][rentACar], true);
            case 3: ToggleMenuButtonBackground(playerid, menuButtonBackgrounds[playerid][options], true);
        }
    }
    else if (phoneMenuLocation[playerid] == PHONE_MENU_MESSAGES)
    {
        if (selectedMenuButtonIndex[playerid] == 0)
        {
            // todo maybe make these variables like menubuttonbrancgrounds
            // todo rename menubuttonbrancsgrounds to mainmenubuttonselectors or something
            ToggleMenuButtonBackground(playerid, messageListItem1Active[playerid], false);
            ToggleMenuButtonBackground(playerid, messageListItem2Active[playerid], true);
        }
        else
        {
            ToggleMenuButtonBackground(playerid, messageListItem1Active[playerid], true);
            ToggleMenuButtonBackground(playerid, messageListItem2Active[playerid], false);
        }

        if (moveDirection == NEXT_BUTTON)
        {
            if (selectedMenuButtonIndex[playerid] == 0)
            {
                selectedMenuButtonIndex[playerid] = 1;
            }
            else selectedMenuButtonIndex[playerid] = 0;
        }
        else if (moveDirection == PREVIOUS_BUTTON)
        {
            if (selectedMenuButtonIndex[playerid] == 0)
            {
                selectedMenuButtonIndex[playerid] = 1;
            }
            else selectedMenuButtonIndex[playerid] = 0;
        }
    }

    return true;
}

Server:TIMER_PhoneButtonPressTimer(playerid)
{
    phoneButtonPressAllowed[playerid] = true;

    return true;
}

Server:TIMER_SetPlayerClockTimer(playerid)
{
    SetPlayerPhoneTime(playerid);

    SendClientMessage(playerid, -1, "time changed"); // todo not working properly

    return true;
}

ToggleMenuButtonBackground(const playerid, const PlayerText:menuButtonBackground, const bool:hide)
{
    PlayerTextDrawHide(playerid, menuButtonBackground);
    PlayerTextDrawUseBox(playerid, menuButtonBackground, hide);
    PlayerTextDrawShow(playerid, menuButtonBackground);

    return true;
}