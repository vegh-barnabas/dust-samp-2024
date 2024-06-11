// todo refact these textdraws because they are ugly

// Base
new PlayerText:phoneBg[MAX_PLAYERS];
new PlayerText:screenBg[MAX_PLAYERS];

new PlayerText:screenTopLine[MAX_PLAYERS];
new PlayerText:topLineSignalIndicator1[MAX_PLAYERS];
new PlayerText:topLineSignalIndicator2[MAX_PLAYERS];
new PlayerText:topLineSignalIndicator3[MAX_PLAYERS];
new PlayerText:topLineSignalIndicator4[MAX_PLAYERS];
new PlayerText:topLineHourIndicator[MAX_PLAYERS];
new PlayerText:topLineDayIndicator[MAX_PLAYERS];

new PlayerText:screenBottomLine[MAX_PLAYERS];
new PlayerText:screenLeftBtn[MAX_PLAYERS];
new PlayerText:screenRightBtn[MAX_PLAYERS];
new PlayerText:screenMiddleBtn[MAX_PLAYERS];

new PlayerText:buttonPanelPhoneIcon[MAX_PLAYERS];
new PlayerText:buttonPanelABC[MAX_PLAYERS];
new PlayerText:buttonPanelDEF[MAX_PLAYERS];
new PlayerText:buttonPanelGHI[MAX_PLAYERS];
new PlayerText:buttonPanelJKL[MAX_PLAYERS];
new PlayerText:buttonPanelMNO[MAX_PLAYERS];
new PlayerText:buttonPanelPQRS[MAX_PLAYERS];
new PlayerText:buttonPanelTUV[MAX_PLAYERS];
new PlayerText:buttonPanelWXYZ[MAX_PLAYERS];

new PlayerText:buttonPanel1[MAX_PLAYERS];
new PlayerText:buttonPanel2[MAX_PLAYERS];
new PlayerText:buttonPanel3[MAX_PLAYERS];
new PlayerText:buttonPanel4[MAX_PLAYERS];
new PlayerText:buttonPanel5[MAX_PLAYERS];
new PlayerText:buttonPanel6[MAX_PLAYERS];
new PlayerText:buttonPanel7[MAX_PLAYERS];
new PlayerText:buttonPanel8[MAX_PLAYERS];
new PlayerText:buttonPanel9[MAX_PLAYERS];

// Main Menu
enum mainMenuButtons
{
    PlayerText:phonebook,
    PlayerText:messages,
    PlayerText:rentACar,
    PlayerText:options
}
new menuButtons[MAX_PLAYERS][mainMenuButtons];
new menuButtonBackgrounds[MAX_PLAYERS][mainMenuButtons];
new mainMenuButtonCount = 4; // increment this when you add a new button!

// Messages
new PlayerText:messageListItem1Bg[MAX_PLAYERS];
new PlayerText:messageListItem1Row1[MAX_PLAYERS];
new PlayerText:messageListItem1Row2[MAX_PLAYERS];
new PlayerText:messageListItem1Active[MAX_PLAYERS];
new PlayerText:messageListItem1Sender[MAX_PLAYERS];
new PlayerText:messageListItem1Time[MAX_PLAYERS];

new PlayerText:messageListItem2Bg[MAX_PLAYERS];
new PlayerText:messageListItem2Row1[MAX_PLAYERS];
new PlayerText:messageListItem2Row2[MAX_PLAYERS];
new PlayerText:messageListItem2Active[MAX_PLAYERS];
new PlayerText:messageListItem2Sender[MAX_PLAYERS];
new PlayerText:messageListItem2Time[MAX_PLAYERS];

Server:CreatePhoneBaseTextDraws(playerid)
{
    // Static
    phoneBg[playerid] = CreatePlayerTextDraw(playerid, 500.000, 299.000, "New textdraw");
    PlayerTextDrawLetterSize(playerid, phoneBg[playerid], 0.230, 16.600);
    PlayerTextDrawTextSize(playerid, phoneBg[playerid], 582.000, 30.000);
    PlayerTextDrawAlignment(playerid, phoneBg[playerid], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, phoneBg[playerid], 0);
    PlayerTextDrawUseBox(playerid, phoneBg[playerid], true);
    PlayerTextDrawBoxColour(playerid, phoneBg[playerid], 255);
    PlayerTextDrawSetShadow(playerid, phoneBg[playerid], 1);
    PlayerTextDrawSetOutline(playerid, phoneBg[playerid], 1);
    PlayerTextDrawBackgroundColour(playerid, phoneBg[playerid], 0);
    PlayerTextDrawFont(playerid, phoneBg[playerid], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, phoneBg[playerid], true);

    screenBg[playerid] = CreatePlayerTextDraw(playerid, 507.000, 307.000, "New textdraw");
    PlayerTextDrawLetterSize(playerid, screenBg[playerid], 0.230, 10.899);
    PlayerTextDrawTextSize(playerid, screenBg[playerid], 575.000, 77.000);
    PlayerTextDrawAlignment(playerid, screenBg[playerid], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, screenBg[playerid], 0);
    PlayerTextDrawUseBox(playerid, screenBg[playerid], true);
    PlayerTextDrawBoxColour(playerid, screenBg[playerid], -2086495233);
    PlayerTextDrawSetShadow(playerid, screenBg[playerid], 1);
    PlayerTextDrawSetOutline(playerid, screenBg[playerid], 1);
    PlayerTextDrawBackgroundColour(playerid, screenBg[playerid], 0);
    PlayerTextDrawFont(playerid, screenBg[playerid], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, screenBg[playerid], true);

    screenTopLine[playerid] = CreatePlayerTextDraw(playerid, 507.000, 307.000, "New textdraw");
    PlayerTextDrawLetterSize(playerid, screenTopLine[playerid], 0.230, 1.199);
    PlayerTextDrawTextSize(playerid, screenTopLine[playerid], 575.000, 72.000);
    PlayerTextDrawAlignment(playerid, screenTopLine[playerid], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, screenTopLine[playerid], 0);
    PlayerTextDrawUseBox(playerid, screenTopLine[playerid], true);
    PlayerTextDrawBoxColour(playerid, screenTopLine[playerid], 150);
    PlayerTextDrawSetShadow(playerid, screenTopLine[playerid], 1);
    PlayerTextDrawSetOutline(playerid, screenTopLine[playerid], 1);
    PlayerTextDrawBackgroundColour(playerid, screenTopLine[playerid], 0);
    PlayerTextDrawFont(playerid, screenTopLine[playerid], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, screenTopLine[playerid], true);

    screenBottomLine[playerid] = CreatePlayerTextDraw(playerid, 507.000, 395.000, "New textdraw");
    PlayerTextDrawLetterSize(playerid, screenBottomLine[playerid], 0.230, 1.199);
    PlayerTextDrawTextSize(playerid, screenBottomLine[playerid], 575.000, 72.000);
    PlayerTextDrawAlignment(playerid, screenBottomLine[playerid], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, screenBottomLine[playerid], 0);
    PlayerTextDrawUseBox(playerid, screenBottomLine[playerid], true);
    PlayerTextDrawBoxColour(playerid, screenBottomLine[playerid], 150);
    PlayerTextDrawSetShadow(playerid, screenBottomLine[playerid], 1);
    PlayerTextDrawSetOutline(playerid, screenBottomLine[playerid], 1);
    PlayerTextDrawBackgroundColour(playerid, screenBottomLine[playerid], 0);
    PlayerTextDrawFont(playerid, screenBottomLine[playerid], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, screenBottomLine[playerid], true);

    buttonPanel3[playerid] = CreatePlayerTextDraw(playerid, 558.500, 412.000, "3");
    PlayerTextDrawLetterSize(playerid, buttonPanel3[playerid], 0.209, 1.399);
    PlayerTextDrawAlignment(playerid, buttonPanel3[playerid], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, buttonPanel3[playerid], -1);
    PlayerTextDrawSetShadow(playerid, buttonPanel3[playerid], 0);
    PlayerTextDrawSetOutline(playerid, buttonPanel3[playerid], 0);
    PlayerTextDrawBackgroundColour(playerid, buttonPanel3[playerid], -1);
    PlayerTextDrawFont(playerid, buttonPanel3[playerid], TEXT_DRAW_FONT_2);
    PlayerTextDrawSetProportional(playerid, buttonPanel3[playerid], true);

    buttonPanel2[playerid] = CreatePlayerTextDraw(playerid, 535.000, 412.000, "2");
    PlayerTextDrawLetterSize(playerid, buttonPanel2[playerid], 0.209, 1.399);
    PlayerTextDrawAlignment(playerid, buttonPanel2[playerid], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, buttonPanel2[playerid], -1);
    PlayerTextDrawSetShadow(playerid, buttonPanel2[playerid], 0);
    PlayerTextDrawSetOutline(playerid, buttonPanel2[playerid], 0);
    PlayerTextDrawBackgroundColour(playerid, buttonPanel2[playerid], -1);
    PlayerTextDrawFont(playerid, buttonPanel2[playerid], TEXT_DRAW_FONT_2);
    PlayerTextDrawSetProportional(playerid, buttonPanel2[playerid], true);

    buttonPanel1[playerid] = CreatePlayerTextDraw(playerid, 513.000, 412.000, "1");
    PlayerTextDrawLetterSize(playerid, buttonPanel1[playerid], 0.209, 1.399);
    PlayerTextDrawAlignment(playerid, buttonPanel1[playerid], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, buttonPanel1[playerid], -1);
    PlayerTextDrawSetShadow(playerid, buttonPanel1[playerid], 0);
    PlayerTextDrawSetOutline(playerid, buttonPanel1[playerid], 0);
    PlayerTextDrawBackgroundColour(playerid, buttonPanel1[playerid], -1);
    PlayerTextDrawFont(playerid, buttonPanel1[playerid], TEXT_DRAW_FONT_2);
    PlayerTextDrawSetProportional(playerid, buttonPanel1[playerid], true);

    buttonPanelDEF[playerid] = CreatePlayerTextDraw(playerid, 566.500, 416.000, "DEF");
    PlayerTextDrawLetterSize(playerid, buttonPanelDEF[playerid], 0.128, 0.799);
    PlayerTextDrawAlignment(playerid, buttonPanelDEF[playerid], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, buttonPanelDEF[playerid], -1);
    PlayerTextDrawSetShadow(playerid, buttonPanelDEF[playerid], 0);
    PlayerTextDrawSetOutline(playerid, buttonPanelDEF[playerid], 0);
    PlayerTextDrawBackgroundColour(playerid, buttonPanelDEF[playerid], -1);
    PlayerTextDrawFont(playerid, buttonPanelDEF[playerid], TEXT_DRAW_FONT_2);
    PlayerTextDrawSetProportional(playerid, buttonPanelDEF[playerid], true);

    buttonPanelABC[playerid] = CreatePlayerTextDraw(playerid, 542.500, 416.000, "ABC");
    PlayerTextDrawLetterSize(playerid, buttonPanelABC[playerid], 0.128, 0.799);
    PlayerTextDrawAlignment(playerid, buttonPanelABC[playerid], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, buttonPanelABC[playerid], -1);
    PlayerTextDrawSetShadow(playerid, buttonPanelABC[playerid], 0);
    PlayerTextDrawSetOutline(playerid, buttonPanelABC[playerid], 0);
    PlayerTextDrawBackgroundColour(playerid, buttonPanelABC[playerid], -1);
    PlayerTextDrawFont(playerid, buttonPanelABC[playerid], TEXT_DRAW_FONT_2);
    PlayerTextDrawSetProportional(playerid, buttonPanelABC[playerid], true);

    buttonPanel4[playerid] = CreatePlayerTextDraw(playerid, 513.000, 424.000, "4");
    PlayerTextDrawLetterSize(playerid, buttonPanel4[playerid], 0.209, 1.399);
    PlayerTextDrawAlignment(playerid, buttonPanel4[playerid], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, buttonPanel4[playerid], -1);
    PlayerTextDrawSetShadow(playerid, buttonPanel4[playerid], 0);
    PlayerTextDrawSetOutline(playerid, buttonPanel4[playerid], 0);
    PlayerTextDrawBackgroundColour(playerid, buttonPanel4[playerid], -1);
    PlayerTextDrawFont(playerid, buttonPanel4[playerid], TEXT_DRAW_FONT_2);
    PlayerTextDrawSetProportional(playerid, buttonPanel4[playerid], true);

    buttonPanel5[playerid] = CreatePlayerTextDraw(playerid, 535.000, 424.000, "5");
    PlayerTextDrawLetterSize(playerid, buttonPanel5[playerid], 0.209, 1.399);
    PlayerTextDrawAlignment(playerid, buttonPanel5[playerid], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, buttonPanel5[playerid], -1);
    PlayerTextDrawSetShadow(playerid, buttonPanel5[playerid], 0);
    PlayerTextDrawSetOutline(playerid, buttonPanel5[playerid], 0);
    PlayerTextDrawBackgroundColour(playerid, buttonPanel5[playerid], -1);
    PlayerTextDrawFont(playerid, buttonPanel5[playerid], TEXT_DRAW_FONT_2);
    PlayerTextDrawSetProportional(playerid, buttonPanel5[playerid], true);

    buttonPanel6[playerid] = CreatePlayerTextDraw(playerid, 559.000, 424.000, "6");
    PlayerTextDrawLetterSize(playerid, buttonPanel6[playerid], 0.209, 1.399);
    PlayerTextDrawAlignment(playerid, buttonPanel6[playerid], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, buttonPanel6[playerid], -1);
    PlayerTextDrawSetShadow(playerid, buttonPanel6[playerid], 0);
    PlayerTextDrawSetOutline(playerid, buttonPanel6[playerid], 0);
    PlayerTextDrawBackgroundColour(playerid, buttonPanel6[playerid], -1);
    PlayerTextDrawFont(playerid, buttonPanel6[playerid], TEXT_DRAW_FONT_2);
    PlayerTextDrawSetProportional(playerid, buttonPanel6[playerid], true);

    buttonPanel7[playerid] = CreatePlayerTextDraw(playerid, 513.000, 436.000, "7");
    PlayerTextDrawLetterSize(playerid, buttonPanel7[playerid], 0.209, 1.399);
    PlayerTextDrawAlignment(playerid, buttonPanel7[playerid], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, buttonPanel7[playerid], -1);
    PlayerTextDrawSetShadow(playerid, buttonPanel7[playerid], 0);
    PlayerTextDrawSetOutline(playerid, buttonPanel7[playerid], 0);
    PlayerTextDrawBackgroundColour(playerid, buttonPanel7[playerid], -1);
    PlayerTextDrawFont(playerid, buttonPanel7[playerid], TEXT_DRAW_FONT_2);
    PlayerTextDrawSetProportional(playerid, buttonPanel7[playerid], true);

    buttonPanel8[playerid] = CreatePlayerTextDraw(playerid, 535.000, 436.000, "8");
    PlayerTextDrawLetterSize(playerid, buttonPanel8[playerid], 0.209, 1.399);
    PlayerTextDrawAlignment(playerid, buttonPanel8[playerid], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, buttonPanel8[playerid], -1);
    PlayerTextDrawSetShadow(playerid, buttonPanel8[playerid], 0);
    PlayerTextDrawSetOutline(playerid, buttonPanel8[playerid], 0);
    PlayerTextDrawBackgroundColour(playerid, buttonPanel8[playerid], -1);
    PlayerTextDrawFont(playerid, buttonPanel8[playerid], TEXT_DRAW_FONT_2);
    PlayerTextDrawSetProportional(playerid, buttonPanel8[playerid], true);

    buttonPanelJKL[playerid] = CreatePlayerTextDraw(playerid, 542.500, 428.000, "JKL");
    PlayerTextDrawLetterSize(playerid, buttonPanelJKL[playerid], 0.128, 0.799);
    PlayerTextDrawAlignment(playerid, buttonPanelJKL[playerid], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, buttonPanelJKL[playerid], -1);
    PlayerTextDrawSetShadow(playerid, buttonPanelJKL[playerid], 0);
    PlayerTextDrawSetOutline(playerid, buttonPanelJKL[playerid], 0);
    PlayerTextDrawBackgroundColour(playerid, buttonPanelJKL[playerid], -1);
    PlayerTextDrawFont(playerid, buttonPanelJKL[playerid], TEXT_DRAW_FONT_2);
    PlayerTextDrawSetProportional(playerid, buttonPanelJKL[playerid], true);

    buttonPanel9[playerid] = CreatePlayerTextDraw(playerid, 559.000, 436.000, "9");
    PlayerTextDrawLetterSize(playerid, buttonPanel9[playerid], 0.209, 1.399);
    PlayerTextDrawAlignment(playerid, buttonPanel9[playerid], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, buttonPanel9[playerid], -1);
    PlayerTextDrawSetShadow(playerid, buttonPanel9[playerid], 0);
    PlayerTextDrawSetOutline(playerid, buttonPanel9[playerid], 0);
    PlayerTextDrawBackgroundColour(playerid, buttonPanel9[playerid], -1);
    PlayerTextDrawFont(playerid, buttonPanel9[playerid], TEXT_DRAW_FONT_2);
    PlayerTextDrawSetProportional(playerid, buttonPanel9[playerid], true);

    buttonPanelTUV[playerid] = CreatePlayerTextDraw(playerid, 543.000, 440.000, "TUV");
    PlayerTextDrawLetterSize(playerid, buttonPanelTUV[playerid], 0.128, 0.799);
    PlayerTextDrawAlignment(playerid, buttonPanelTUV[playerid], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, buttonPanelTUV[playerid], -1);
    PlayerTextDrawSetShadow(playerid, buttonPanelTUV[playerid], 0);
    PlayerTextDrawSetOutline(playerid, buttonPanelTUV[playerid], 0);
    PlayerTextDrawBackgroundColour(playerid, buttonPanelTUV[playerid], -1);
    PlayerTextDrawFont(playerid, buttonPanelTUV[playerid], TEXT_DRAW_FONT_2);
    PlayerTextDrawSetProportional(playerid, buttonPanelTUV[playerid], true);

    buttonPanelMNO[playerid] = CreatePlayerTextDraw(playerid, 567.000, 428.000, "MNO");
    PlayerTextDrawLetterSize(playerid, buttonPanelMNO[playerid], 0.128, 0.799);
    PlayerTextDrawAlignment(playerid, buttonPanelMNO[playerid], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, buttonPanelMNO[playerid], -1);
    PlayerTextDrawSetShadow(playerid, buttonPanelMNO[playerid], 0);
    PlayerTextDrawSetOutline(playerid, buttonPanelMNO[playerid], 0);
    PlayerTextDrawBackgroundColour(playerid, buttonPanelMNO[playerid], -1);
    PlayerTextDrawFont(playerid, buttonPanelMNO[playerid], TEXT_DRAW_FONT_2);
    PlayerTextDrawSetProportional(playerid, buttonPanelMNO[playerid], true);

    buttonPanelWXYZ[playerid] = CreatePlayerTextDraw(playerid, 561.500, 439.000, "WXYZ");
    PlayerTextDrawLetterSize(playerid, buttonPanelWXYZ[playerid], 0.100, 0.898);
    PlayerTextDrawAlignment(playerid, buttonPanelWXYZ[playerid], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, buttonPanelWXYZ[playerid], -1);
    PlayerTextDrawSetShadow(playerid, buttonPanelWXYZ[playerid], 0);
    PlayerTextDrawSetOutline(playerid, buttonPanelWXYZ[playerid], 0);
    PlayerTextDrawBackgroundColour(playerid, buttonPanelWXYZ[playerid], -1);
    PlayerTextDrawFont(playerid, buttonPanelWXYZ[playerid], TEXT_DRAW_FONT_2);
    PlayerTextDrawSetProportional(playerid, buttonPanelWXYZ[playerid], true);

    buttonPanelGHI[playerid] = CreatePlayerTextDraw(playerid, 520.000, 428.000, "GHI");
    PlayerTextDrawLetterSize(playerid, buttonPanelGHI[playerid], 0.128, 0.799);
    PlayerTextDrawAlignment(playerid, buttonPanelGHI[playerid], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, buttonPanelGHI[playerid], -1);
    PlayerTextDrawSetShadow(playerid, buttonPanelGHI[playerid], 0);
    PlayerTextDrawSetOutline(playerid, buttonPanelGHI[playerid], 0);
    PlayerTextDrawBackgroundColour(playerid, buttonPanelGHI[playerid], -1);
    PlayerTextDrawFont(playerid, buttonPanelGHI[playerid], TEXT_DRAW_FONT_2);
    PlayerTextDrawSetProportional(playerid, buttonPanelGHI[playerid], true);

    buttonPanelPQRS[playerid] = CreatePlayerTextDraw(playerid, 515.500, 439.000, "PQRS");
    PlayerTextDrawLetterSize(playerid, buttonPanelPQRS[playerid], 0.100, 0.898);
    PlayerTextDrawAlignment(playerid, buttonPanelPQRS[playerid], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, buttonPanelPQRS[playerid], -1);
    PlayerTextDrawSetShadow(playerid, buttonPanelPQRS[playerid], 0);
    PlayerTextDrawSetOutline(playerid, buttonPanelPQRS[playerid], 0);
    PlayerTextDrawBackgroundColour(playerid, buttonPanelPQRS[playerid], -1);
    PlayerTextDrawFont(playerid, buttonPanelPQRS[playerid], TEXT_DRAW_FONT_2);
    PlayerTextDrawSetProportional(playerid, buttonPanelPQRS[playerid], true);

    buttonPanelPhoneIcon[playerid] = CreatePlayerTextDraw(playerid, 516.500, 416.000, "(");
    PlayerTextDrawLetterSize(playerid, buttonPanelPhoneIcon[playerid], 0.128, 0.799);
    PlayerTextDrawAlignment(playerid, buttonPanelPhoneIcon[playerid], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, buttonPanelPhoneIcon[playerid], -1);
    PlayerTextDrawSetShadow(playerid, buttonPanelPhoneIcon[playerid], 0);
    PlayerTextDrawSetOutline(playerid, buttonPanelPhoneIcon[playerid], 0);
    PlayerTextDrawBackgroundColour(playerid, buttonPanelPhoneIcon[playerid], -1);
    PlayerTextDrawFont(playerid, buttonPanelPhoneIcon[playerid], TEXT_DRAW_FONT_2);
    PlayerTextDrawSetProportional(playerid, buttonPanelPhoneIcon[playerid], true);

    // Dynamic
    screenLeftBtn[playerid] = CreatePlayerTextDraw(playerid, 508.000, 395.000, "Select");
    PlayerTextDrawLetterSize(playerid, screenLeftBtn[playerid], 0.209, 1.098);
    PlayerTextDrawTextSize(playerid, screenLeftBtn[playerid], -1.000, 0.000);
    PlayerTextDrawAlignment(playerid, screenLeftBtn[playerid], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, screenLeftBtn[playerid], 8388863);
    PlayerTextDrawSetShadow(playerid, screenLeftBtn[playerid], 0);
    PlayerTextDrawSetOutline(playerid, screenLeftBtn[playerid], 1);
    PlayerTextDrawBackgroundColour(playerid, screenLeftBtn[playerid], 255);
    PlayerTextDrawFont(playerid, screenLeftBtn[playerid], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, screenLeftBtn[playerid], true);

    screenRightBtn[playerid] = CreatePlayerTextDraw(playerid, 574.000, 395.000, "Back");
    PlayerTextDrawLetterSize(playerid, screenRightBtn[playerid], 0.209, 1.098);
    PlayerTextDrawTextSize(playerid, screenRightBtn[playerid], -1.000, 0.000);
    PlayerTextDrawAlignment(playerid, screenRightBtn[playerid], TEXT_DRAW_ALIGN_RIGHT);
    PlayerTextDrawColour(playerid, screenRightBtn[playerid], -2147483393);
    PlayerTextDrawSetShadow(playerid, screenRightBtn[playerid], 0);
    PlayerTextDrawSetOutline(playerid, screenRightBtn[playerid], 1);
    PlayerTextDrawBackgroundColour(playerid, screenRightBtn[playerid], 255);
    PlayerTextDrawFont(playerid, screenRightBtn[playerid], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, screenRightBtn[playerid], true);

    screenMiddleBtn[playerid] = CreatePlayerTextDraw(playerid, 543.000, 395.000, "New");
    PlayerTextDrawLetterSize(playerid, screenMiddleBtn[playerid], 0.209, 1.098);
    PlayerTextDrawTextSize(playerid, screenMiddleBtn[playerid], -1.000, 0.000);
    PlayerTextDrawAlignment(playerid, screenMiddleBtn[playerid], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, screenMiddleBtn[playerid], -2686721);
    PlayerTextDrawSetShadow(playerid, screenMiddleBtn[playerid], 0);
    PlayerTextDrawSetOutline(playerid, screenMiddleBtn[playerid], 1);
    PlayerTextDrawBackgroundColour(playerid, screenMiddleBtn[playerid], 255);
    PlayerTextDrawFont(playerid, screenMiddleBtn[playerid], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, screenMiddleBtn[playerid], true);

    topLineHourIndicator[playerid] = CreatePlayerTextDraw(playerid, 575.000, 305.000, "23:34");
    PlayerTextDrawLetterSize(playerid, topLineHourIndicator[playerid], 0.216, 1.399);
    PlayerTextDrawTextSize(playerid, topLineHourIndicator[playerid], -1.000, 4.000);
    PlayerTextDrawAlignment(playerid, topLineHourIndicator[playerid], TEXT_DRAW_ALIGN_RIGHT);
    PlayerTextDrawColour(playerid, topLineHourIndicator[playerid], -2139062017);
    PlayerTextDrawSetShadow(playerid, topLineHourIndicator[playerid], 0);
    PlayerTextDrawSetOutline(playerid, topLineHourIndicator[playerid], 1);
    PlayerTextDrawBackgroundColour(playerid, topLineHourIndicator[playerid], 255);
    PlayerTextDrawFont(playerid, topLineHourIndicator[playerid], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, topLineHourIndicator[playerid], true);

    topLineDayIndicator[playerid] = CreatePlayerTextDraw(playerid, 550.000, 308.000, "WED");
    PlayerTextDrawLetterSize(playerid, topLineDayIndicator[playerid], 0.166, 0.998);
    PlayerTextDrawTextSize(playerid, topLineDayIndicator[playerid], -1.000, 4.000);
    PlayerTextDrawAlignment(playerid, topLineDayIndicator[playerid], TEXT_DRAW_ALIGN_RIGHT);
    PlayerTextDrawColour(playerid, topLineDayIndicator[playerid], -2139062017);
    PlayerTextDrawSetShadow(playerid, topLineDayIndicator[playerid], 0);
    PlayerTextDrawSetOutline(playerid, topLineDayIndicator[playerid], 1);
    PlayerTextDrawBackgroundColour(playerid, topLineDayIndicator[playerid], 255);
    PlayerTextDrawFont(playerid, topLineDayIndicator[playerid], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, topLineDayIndicator[playerid], true);

    topLineSignalIndicator1[playerid] = CreatePlayerTextDraw(playerid, 511.000, 317.000, "New textdraw");
    PlayerTextDrawLetterSize(playerid, topLineSignalIndicator1[playerid], 0.000, -0.201);
    PlayerTextDrawTextSize(playerid, topLineSignalIndicator1[playerid], 508.000, 77.000);
    PlayerTextDrawAlignment(playerid, topLineSignalIndicator1[playerid], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, topLineSignalIndicator1[playerid], 1768516095);
    PlayerTextDrawUseBox(playerid, topLineSignalIndicator1[playerid], true);
    PlayerTextDrawBoxColour(playerid, topLineSignalIndicator1[playerid], 2005441023);
    PlayerTextDrawSetShadow(playerid, topLineSignalIndicator1[playerid], 1);
    PlayerTextDrawSetOutline(playerid, topLineSignalIndicator1[playerid], 1);
    PlayerTextDrawBackgroundColour(playerid, topLineSignalIndicator1[playerid], 0);
    PlayerTextDrawFont(playerid, topLineSignalIndicator1[playerid], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, topLineSignalIndicator1[playerid], true);

    topLineSignalIndicator2[playerid] = CreatePlayerTextDraw(playerid, 513.000, 317.000, "New textdraw");
    PlayerTextDrawLetterSize(playerid, topLineSignalIndicator2[playerid], 0.028, -0.300);
    PlayerTextDrawTextSize(playerid, topLineSignalIndicator2[playerid], 510.000, 77.000);
    PlayerTextDrawAlignment(playerid, topLineSignalIndicator2[playerid], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, topLineSignalIndicator2[playerid], 0);
    PlayerTextDrawUseBox(playerid, topLineSignalIndicator2[playerid], true);
    PlayerTextDrawBoxColour(playerid, topLineSignalIndicator2[playerid], 1887473919);
    PlayerTextDrawSetShadow(playerid, topLineSignalIndicator2[playerid], 1);
    PlayerTextDrawSetOutline(playerid, topLineSignalIndicator2[playerid], 1);
    PlayerTextDrawBackgroundColour(playerid, topLineSignalIndicator2[playerid], 0);
    PlayerTextDrawFont(playerid, topLineSignalIndicator2[playerid], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, topLineSignalIndicator2[playerid], true);

    topLineSignalIndicator3[playerid] = CreatePlayerTextDraw(playerid, 515.000, 317.000, "New textdraw");
    PlayerTextDrawLetterSize(playerid, topLineSignalIndicator3[playerid], 0.008, -0.400);
    PlayerTextDrawTextSize(playerid, topLineSignalIndicator3[playerid], 512.000, 75.000);
    PlayerTextDrawAlignment(playerid, topLineSignalIndicator3[playerid], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, topLineSignalIndicator3[playerid], 0);
    PlayerTextDrawUseBox(playerid, topLineSignalIndicator3[playerid], true);
    PlayerTextDrawBoxColour(playerid, topLineSignalIndicator3[playerid], 1768516095);
    PlayerTextDrawSetShadow(playerid, topLineSignalIndicator3[playerid], 1);
    PlayerTextDrawSetOutline(playerid, topLineSignalIndicator3[playerid], 1);
    PlayerTextDrawBackgroundColour(playerid, topLineSignalIndicator3[playerid], 0);
    PlayerTextDrawFont(playerid, topLineSignalIndicator3[playerid], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, topLineSignalIndicator3[playerid], true);

    topLineSignalIndicator4[playerid] = CreatePlayerTextDraw(playerid, 517.000, 317.000, "New textdraw");
    PlayerTextDrawLetterSize(playerid, topLineSignalIndicator4[playerid], 0.008, -0.500);
    PlayerTextDrawTextSize(playerid, topLineSignalIndicator4[playerid], 514.000, 75.000);
    PlayerTextDrawAlignment(playerid, topLineSignalIndicator4[playerid], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, topLineSignalIndicator4[playerid], 0);
    PlayerTextDrawUseBox(playerid, topLineSignalIndicator4[playerid], true);
    PlayerTextDrawBoxColour(playerid, topLineSignalIndicator4[playerid], 1768516095);
    PlayerTextDrawSetShadow(playerid, topLineSignalIndicator4[playerid], 1);
    PlayerTextDrawSetOutline(playerid, topLineSignalIndicator4[playerid], 1);
    PlayerTextDrawBackgroundColour(playerid, topLineSignalIndicator4[playerid], 0);
    PlayerTextDrawFont(playerid, topLineSignalIndicator4[playerid], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, topLineSignalIndicator4[playerid], true);


    return true;
}

Server:CreatePhoneMainMenuTextDraws(playerid)
{
    menuButtonBackgrounds[playerid][phonebook] = CreatePlayerTextDraw(playerid, 510.000, 324.000, "a");
    PlayerTextDrawLetterSize(playerid, menuButtonBackgrounds[playerid][phonebook], 0.209, 0.999);
    PlayerTextDrawTextSize(playerid, menuButtonBackgrounds[playerid][phonebook], 572.000, 2.000);
    PlayerTextDrawAlignment(playerid, menuButtonBackgrounds[playerid][phonebook], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, menuButtonBackgrounds[playerid][phonebook], 0);
    PlayerTextDrawUseBox(playerid, menuButtonBackgrounds[playerid][phonebook], true);
    PlayerTextDrawBoxColour(playerid, menuButtonBackgrounds[playerid][phonebook], 150);
    PlayerTextDrawSetShadow(playerid, menuButtonBackgrounds[playerid][phonebook], 0);
    PlayerTextDrawSetOutline(playerid, menuButtonBackgrounds[playerid][phonebook], 1);
    PlayerTextDrawBackgroundColour(playerid, menuButtonBackgrounds[playerid][phonebook], 0);
    PlayerTextDrawFont(playerid, menuButtonBackgrounds[playerid][phonebook], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, menuButtonBackgrounds[playerid][phonebook], true);

    menuButtonBackgrounds[playerid][messages] = CreatePlayerTextDraw(playerid, 510.000, 335.000, "a");
    PlayerTextDrawLetterSize(playerid, menuButtonBackgrounds[playerid][messages], 0.209, 0.999);
    PlayerTextDrawTextSize(playerid, menuButtonBackgrounds[playerid][messages], 572.000, 2.000);
    PlayerTextDrawAlignment(playerid, menuButtonBackgrounds[playerid][messages], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, menuButtonBackgrounds[playerid][messages], 0);
    PlayerTextDrawUseBox(playerid, menuButtonBackgrounds[playerid][messages], false);
    PlayerTextDrawBoxColour(playerid, menuButtonBackgrounds[playerid][messages], 150);
    PlayerTextDrawSetShadow(playerid, menuButtonBackgrounds[playerid][messages], 0);
    PlayerTextDrawSetOutline(playerid, menuButtonBackgrounds[playerid][messages], 1);
    PlayerTextDrawBackgroundColour(playerid, menuButtonBackgrounds[playerid][messages], 0);
    PlayerTextDrawFont(playerid, menuButtonBackgrounds[playerid][messages], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, menuButtonBackgrounds[playerid][messages], true);

    menuButtonBackgrounds[playerid][rentACar] = CreatePlayerTextDraw(playerid, 510.000, 346.000, "a");
    PlayerTextDrawLetterSize(playerid, menuButtonBackgrounds[playerid][rentACar], 0.209, 0.999);
    PlayerTextDrawTextSize(playerid, menuButtonBackgrounds[playerid][rentACar], 572.000, 2.000);
    PlayerTextDrawAlignment(playerid, menuButtonBackgrounds[playerid][rentACar], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, menuButtonBackgrounds[playerid][rentACar], 0);
    PlayerTextDrawUseBox(playerid, menuButtonBackgrounds[playerid][rentACar], false);
    PlayerTextDrawBoxColour(playerid, menuButtonBackgrounds[playerid][rentACar], 150);
    PlayerTextDrawSetShadow(playerid, menuButtonBackgrounds[playerid][rentACar], 0);
    PlayerTextDrawSetOutline(playerid, menuButtonBackgrounds[playerid][rentACar], 1);
    PlayerTextDrawBackgroundColour(playerid, menuButtonBackgrounds[playerid][rentACar], 0);
    PlayerTextDrawFont(playerid, menuButtonBackgrounds[playerid][rentACar], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, menuButtonBackgrounds[playerid][rentACar], true);

    menuButtonBackgrounds[playerid][options] = CreatePlayerTextDraw(playerid, 510.000, 357.000, "a");
    PlayerTextDrawLetterSize(playerid, menuButtonBackgrounds[playerid][options], 0.209, 0.999);
    PlayerTextDrawTextSize(playerid, menuButtonBackgrounds[playerid][options], 572.000, 2.000);
    PlayerTextDrawAlignment(playerid, menuButtonBackgrounds[playerid][options], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, menuButtonBackgrounds[playerid][options], 0);
    PlayerTextDrawUseBox(playerid, menuButtonBackgrounds[playerid][options], false);
    PlayerTextDrawBoxColour(playerid, menuButtonBackgrounds[playerid][options], 150);
    PlayerTextDrawSetShadow(playerid, menuButtonBackgrounds[playerid][options], 0);
    PlayerTextDrawSetOutline(playerid, menuButtonBackgrounds[playerid][options], 1);
    PlayerTextDrawBackgroundColour(playerid, menuButtonBackgrounds[playerid][options], 0);
    PlayerTextDrawFont(playerid, menuButtonBackgrounds[playerid][options], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, menuButtonBackgrounds[playerid][options], true);

    menuButtons[playerid][phonebook] = CreatePlayerTextDraw(playerid, 510.000, 324.000, "Phonebook");
    PlayerTextDrawLetterSize(playerid, menuButtons[playerid][phonebook], 0.209, 0.999);
    PlayerTextDrawTextSize(playerid, menuButtons[playerid][phonebook], 572.000, 2.000);
    PlayerTextDrawAlignment(playerid, menuButtons[playerid][phonebook], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, menuButtons[playerid][phonebook], -1);
    PlayerTextDrawUseBox(playerid, menuButtons[playerid][phonebook], false);
    PlayerTextDrawBoxColour(playerid, menuButtons[playerid][phonebook], 150);
    PlayerTextDrawSetShadow(playerid, menuButtons[playerid][phonebook], 0);
    PlayerTextDrawSetOutline(playerid, menuButtons[playerid][phonebook], 1);
    PlayerTextDrawBackgroundColour(playerid, menuButtons[playerid][phonebook], 0);
    PlayerTextDrawFont(playerid, menuButtons[playerid][phonebook], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, menuButtons[playerid][phonebook], true);

    menuButtons[playerid][messages] = CreatePlayerTextDraw(playerid, 510.000, 335.000, "Messages");
    PlayerTextDrawLetterSize(playerid, menuButtons[playerid][messages], 0.209, 0.999);
    PlayerTextDrawTextSize(playerid, menuButtons[playerid][messages], 572.000, 2.000);
    PlayerTextDrawAlignment(playerid, menuButtons[playerid][messages], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, menuButtons[playerid][messages], -1);
    PlayerTextDrawUseBox(playerid, menuButtons[playerid][messages], false);
    PlayerTextDrawBoxColour(playerid, menuButtons[playerid][messages], 150);
    PlayerTextDrawSetShadow(playerid, menuButtons[playerid][messages], 0);
    PlayerTextDrawSetOutline(playerid, menuButtons[playerid][messages], 1);
    PlayerTextDrawBackgroundColour(playerid, menuButtons[playerid][messages], 0);
    PlayerTextDrawFont(playerid, menuButtons[playerid][messages], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, menuButtons[playerid][messages], true);

    menuButtons[playerid][rentACar] = CreatePlayerTextDraw(playerid, 510.000, 346.000, "Rent-A-Car");
    PlayerTextDrawLetterSize(playerid, menuButtons[playerid][rentACar], 0.209, 0.999);
    PlayerTextDrawTextSize(playerid, menuButtons[playerid][rentACar], 572.000, 2.000);
    PlayerTextDrawAlignment(playerid, menuButtons[playerid][rentACar], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, menuButtons[playerid][rentACar], -1);
    PlayerTextDrawUseBox(playerid, menuButtons[playerid][rentACar], false);
    PlayerTextDrawBoxColour(playerid, menuButtons[playerid][rentACar], 150);
    PlayerTextDrawSetShadow(playerid, menuButtons[playerid][rentACar], 0);
    PlayerTextDrawSetOutline(playerid, menuButtons[playerid][rentACar], 1);
    PlayerTextDrawBackgroundColour(playerid, menuButtons[playerid][rentACar], 0);
    PlayerTextDrawFont(playerid, menuButtons[playerid][rentACar], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, menuButtons[playerid][rentACar], true);

    menuButtons[playerid][options] = CreatePlayerTextDraw(playerid, 510.000, 357.000, "Options");
    PlayerTextDrawLetterSize(playerid, menuButtons[playerid][options], 0.209, 0.999);
    PlayerTextDrawTextSize(playerid, menuButtons[playerid][options], 572.000, 2.000);
    PlayerTextDrawAlignment(playerid, menuButtons[playerid][options], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, menuButtons[playerid][options], -1);
    PlayerTextDrawUseBox(playerid, menuButtons[playerid][options], false);
    PlayerTextDrawBoxColour(playerid, menuButtons[playerid][options], 150);
    PlayerTextDrawSetShadow(playerid, menuButtons[playerid][options], 0);
    PlayerTextDrawSetOutline(playerid, menuButtons[playerid][options], 1);
    PlayerTextDrawBackgroundColour(playerid, menuButtons[playerid][options], 0);
    PlayerTextDrawFont(playerid, menuButtons[playerid][options], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, menuButtons[playerid][options], true);

    return true;
}

Server:CreatePhoneMessagesTextDraws(playerid)
{
    // Row 1
    messageListItem1Bg[playerid] = CreatePlayerTextDraw(playerid, 510.000, 324.000, ".");
    PlayerTextDrawLetterSize(playerid, messageListItem1Bg[playerid], 0.209, 3.497);
    PlayerTextDrawTextSize(playerid, messageListItem1Bg[playerid], 572.000, 7.000);
    PlayerTextDrawAlignment(playerid, messageListItem1Bg[playerid], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, messageListItem1Bg[playerid], 0);
    PlayerTextDrawUseBox(playerid, messageListItem1Bg[playerid], true);
    PlayerTextDrawBoxColour(playerid, messageListItem1Bg[playerid], 150);
    PlayerTextDrawSetShadow(playerid, messageListItem1Bg[playerid], 0);
    PlayerTextDrawSetOutline(playerid, messageListItem1Bg[playerid], 1);
    PlayerTextDrawBackgroundColour(playerid, messageListItem1Bg[playerid], 0);
    PlayerTextDrawFont(playerid, messageListItem1Bg[playerid], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, messageListItem1Bg[playerid], true);

    messageListItem1Row1[playerid] = CreatePlayerTextDraw(playerid, 511.000, 333.000, "Hello! az ugyben irok");
    PlayerTextDrawLetterSize(playerid, messageListItem1Row1[playerid], 0.148, 0.998);
    PlayerTextDrawAlignment(playerid, messageListItem1Row1[playerid], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, messageListItem1Row1[playerid], -252116993);
    PlayerTextDrawSetShadow(playerid, messageListItem1Row1[playerid], 0);
    PlayerTextDrawSetOutline(playerid, messageListItem1Row1[playerid], 0);
    PlayerTextDrawBackgroundColour(playerid, messageListItem1Row1[playerid], -421070081);
    PlayerTextDrawFont(playerid, messageListItem1Row1[playerid], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, messageListItem1Row1[playerid], true);

    messageListItem1Row2[playerid] = CreatePlayerTextDraw(playerid, 511.000, 342.000, "hogy mi az ujsag vel...");
    PlayerTextDrawLetterSize(playerid, messageListItem1Row2[playerid], 0.148, 0.998);
    PlayerTextDrawAlignment(playerid, messageListItem1Row2[playerid], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, messageListItem1Row2[playerid], -252116993);
    PlayerTextDrawSetShadow(playerid, messageListItem1Row2[playerid], 0);
    PlayerTextDrawSetOutline(playerid, messageListItem1Row2[playerid], 0);
    PlayerTextDrawBackgroundColour(playerid, messageListItem1Row2[playerid], -421070081);
    PlayerTextDrawFont(playerid, messageListItem1Row2[playerid], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, messageListItem1Row2[playerid], true);

    messageListItem1Active[playerid] = CreatePlayerTextDraw(playerid, 511.000, 324.000, ".");
    PlayerTextDrawLetterSize(playerid, messageListItem1Active[playerid], 0.289, 3.497);
    PlayerTextDrawTextSize(playerid, messageListItem1Active[playerid], 508.000, 10.000);
    PlayerTextDrawAlignment(playerid, messageListItem1Active[playerid], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, messageListItem1Active[playerid], 0);
    PlayerTextDrawUseBox(playerid, messageListItem1Active[playerid], true);
    PlayerTextDrawBoxColour(playerid, messageListItem1Active[playerid], -1378294017);
    PlayerTextDrawSetShadow(playerid, messageListItem1Active[playerid], 0);
    PlayerTextDrawSetOutline(playerid, messageListItem1Active[playerid], 1);
    PlayerTextDrawBackgroundColour(playerid, messageListItem1Active[playerid], 0);
    PlayerTextDrawFont(playerid, messageListItem1Active[playerid], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, messageListItem1Active[playerid], true);

    messageListItem1Sender[playerid] = CreatePlayerTextDraw(playerid, 511.000, 324.000, "kuldo fredi");
    PlayerTextDrawLetterSize(playerid, messageListItem1Sender[playerid], 0.118, 0.697);
    PlayerTextDrawAlignment(playerid, messageListItem1Sender[playerid], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, messageListItem1Sender[playerid], -1061109505);
    PlayerTextDrawSetShadow(playerid, messageListItem1Sender[playerid], 0);
    PlayerTextDrawSetOutline(playerid, messageListItem1Sender[playerid], 0);
    PlayerTextDrawBackgroundColour(playerid, messageListItem1Sender[playerid], -421070081);
    PlayerTextDrawFont(playerid, messageListItem1Sender[playerid], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, messageListItem1Sender[playerid], true);

    messageListItem1Time[playerid] = CreatePlayerTextDraw(playerid, 572.000, 324.000, "2024.03.17 18:40");
    PlayerTextDrawLetterSize(playerid, messageListItem1Time[playerid], 0.118, 0.697);
    PlayerTextDrawAlignment(playerid, messageListItem1Time[playerid], TEXT_DRAW_ALIGN_RIGHT);
    PlayerTextDrawColour(playerid, messageListItem1Time[playerid], -2139062017);
    PlayerTextDrawSetShadow(playerid, messageListItem1Time[playerid], 0);
    PlayerTextDrawSetOutline(playerid, messageListItem1Time[playerid], 0);
    PlayerTextDrawBackgroundColour(playerid, messageListItem1Time[playerid], -421070081);
    PlayerTextDrawFont(playerid, messageListItem1Time[playerid], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, messageListItem1Time[playerid], true);

    // Row 2
    messageListItem2Bg[playerid] = CreatePlayerTextDraw(playerid, 510.000, 358.000, ".");
    PlayerTextDrawLetterSize(playerid, messageListItem2Bg[playerid], 0.209, 3.497);
    PlayerTextDrawTextSize(playerid, messageListItem2Bg[playerid], 572.000, 7.000);
    PlayerTextDrawAlignment(playerid, messageListItem2Bg[playerid], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, messageListItem2Bg[playerid], 0);
    PlayerTextDrawUseBox(playerid, messageListItem2Bg[playerid], true);
    PlayerTextDrawBoxColour(playerid, messageListItem2Bg[playerid], 150);
    PlayerTextDrawSetShadow(playerid, messageListItem2Bg[playerid], 0);
    PlayerTextDrawSetOutline(playerid, messageListItem2Bg[playerid], 1);
    PlayerTextDrawBackgroundColour(playerid, messageListItem2Bg[playerid], 0);
    PlayerTextDrawFont(playerid, messageListItem2Bg[playerid], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, messageListItem2Bg[playerid], true);

    messageListItem2Row1[playerid] = CreatePlayerTextDraw(playerid, 511.000, 367.000, "Hello! az ugyben irok");
    PlayerTextDrawLetterSize(playerid, messageListItem2Row1[playerid], 0.148, 0.998);
    PlayerTextDrawAlignment(playerid, messageListItem2Row1[playerid], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, messageListItem2Row1[playerid], -252116993);
    PlayerTextDrawSetShadow(playerid, messageListItem2Row1[playerid], 0);
    PlayerTextDrawSetOutline(playerid, messageListItem2Row1[playerid], 0);
    PlayerTextDrawBackgroundColour(playerid, messageListItem2Row1[playerid], -421070081);
    PlayerTextDrawFont(playerid, messageListItem2Row1[playerid], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, messageListItem2Row1[playerid], true);

    messageListItem2Row2[playerid] = CreatePlayerTextDraw(playerid, 511.000, 376.000, "hogy mi az ujsag vel...");
    PlayerTextDrawLetterSize(playerid, messageListItem2Row2[playerid], 0.148, 0.998);
    PlayerTextDrawAlignment(playerid, messageListItem2Row2[playerid], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, messageListItem2Row2[playerid], -252116993);
    PlayerTextDrawSetShadow(playerid, messageListItem2Row2[playerid], 0);
    PlayerTextDrawSetOutline(playerid, messageListItem2Row2[playerid], 0);
    PlayerTextDrawBackgroundColour(playerid, messageListItem2Row2[playerid], -421070081);
    PlayerTextDrawFont(playerid, messageListItem2Row2[playerid], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, messageListItem2Row2[playerid], true);

    messageListItem2Active[playerid] = CreatePlayerTextDraw(playerid, 511.000, 358.000, ".");
    PlayerTextDrawLetterSize(playerid, messageListItem2Active[playerid], 0.289, 3.496);
    PlayerTextDrawTextSize(playerid, messageListItem2Active[playerid], 508.000, 10.000);
    PlayerTextDrawAlignment(playerid, messageListItem2Active[playerid], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, messageListItem2Active[playerid], 0);
    PlayerTextDrawUseBox(playerid, messageListItem2Active[playerid], true);
    PlayerTextDrawBoxColour(playerid, messageListItem2Active[playerid], -1378294017);
    PlayerTextDrawSetShadow(playerid, messageListItem2Active[playerid], 0);
    PlayerTextDrawSetOutline(playerid, messageListItem2Active[playerid], 1);
    PlayerTextDrawBackgroundColour(playerid, messageListItem2Active[playerid], 0);
    PlayerTextDrawFont(playerid, messageListItem2Active[playerid], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, messageListItem2Active[playerid], true);

    messageListItem2Sender[playerid] = CreatePlayerTextDraw(playerid, 511.000, 358.000, "kuldo fredi");
    PlayerTextDrawLetterSize(playerid, messageListItem2Sender[playerid], 0.118, 0.697);
    PlayerTextDrawAlignment(playerid, messageListItem2Sender[playerid], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, messageListItem2Sender[playerid], -1061109505);
    PlayerTextDrawSetShadow(playerid, messageListItem2Sender[playerid], 0);
    PlayerTextDrawSetOutline(playerid, messageListItem2Sender[playerid], 0);
    PlayerTextDrawBackgroundColour(playerid, messageListItem2Sender[playerid], -421070081);
    PlayerTextDrawFont(playerid, messageListItem2Sender[playerid], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, messageListItem2Sender[playerid], true);

    messageListItem2Time[playerid] = CreatePlayerTextDraw(playerid, 572.000, 358.000, "2024.03.17 18:40");
    PlayerTextDrawLetterSize(playerid, messageListItem2Time[playerid], 0.118, 0.697);
    PlayerTextDrawAlignment(playerid, messageListItem2Time[playerid], TEXT_DRAW_ALIGN_RIGHT);
    PlayerTextDrawColour(playerid, messageListItem2Time[playerid], -2139062017);
    PlayerTextDrawSetShadow(playerid, messageListItem2Time[playerid], 0);
    PlayerTextDrawSetOutline(playerid, messageListItem2Time[playerid], 0);
    PlayerTextDrawBackgroundColour(playerid, messageListItem2Time[playerid], -421070081);
    PlayerTextDrawFont(playerid, messageListItem2Time[playerid], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, messageListItem2Time[playerid], true);

    return true;
}

Server:CreatePhoneTextDraws(playerid)
{
    CreatePhoneBaseTextDraws(playerid);

    CreatePhoneMainMenuTextDraws(playerid);
    CreatePhoneMessagesTextDraws(playerid);

    return true;
}