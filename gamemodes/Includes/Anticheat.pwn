// TODO put this on anticheat or something?
Server:OnPlayerChangeMoney(playerid, oldAmount, newAmount)
{
    if (newAmount == PlayerData[playerid][pMoney])
    {
        SetPVarInt(playerid, "currentMoney", newAmount);
    }
    else Ban(playerid); // TODO refact this to a reason ban system
}