state("dfz")
{
    int gameTimeRAM  : "mono.dll", 0x002681D0, 0x18, 0x148, 0x20, 0x38, 0x20;
    int turnCountRAM : "mono.dll", 0x002681D0, 0x18, 0x148, 0x20, 0x38, 0x24;
    int dungeonIdRAM : "mono.dll", 0x002681D0, 0x18, 0x148, 0x20, 0x40, 0x10;
    int floorRAM     : "mono.dll", 0x002681D0, 0x18, 0x148, 0x20, 0x40, 0x18;
}

startup
{
    vars.totalTime    = new TimeSpan(0);
    vars.restartFlg   = false;
    refreshRate       = 60;
}

start
{
    vars.totalTime    = new TimeSpan(0);
    if (current.dungeonIdRAM != 1 && current.dungeonIdRAM != 5 && current.floorRAM == 1) {
        return true;
    }
    if (vars.restartFlg == true) {
        vars.restartFlg = false;
        return true;
    }
    vars.restartFlg = false;
}

reset
{
    vars.restartFlg = false;
    if (current.dungeonIdRAM < 1) {
        return false;
    }
    
    if (current.dungeonIdRAM == 1) {
        return true;
    } else if (old.floorRAM == 0 && current.floorRAM == 1) {
        vars.restartFlg = true;
        return true;
    }
}

update
{
    if (old.gameTimeRAM < current.gameTimeRAM) {
        vars.totalTime = TimeSpan.FromMilliseconds(current.gameTimeRAM);
    }
}

gameTime
{
    return vars.totalTime;
}

isLoading
{
    return true;
}
