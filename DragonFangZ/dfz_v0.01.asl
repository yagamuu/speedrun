state("dfz")
{
    int gameTime  : "mono.dll", 0x002681D0, 0x18, 0x148, 0x20, 0x38, 0x20;
    int dungeonId : "mono.dll", 0x002681D0, 0x18, 0x148, 0x20, 0x40, 0x10;
    int floor     : "mono.dll", 0x002681D0, 0x18, 0x148, 0x20, 0x40, 0x18;
}

startup
{
    vars.totalTime    = new TimeSpan(0);;
    refreshRate       = 60;
}

start
{
    vars.totalTime    = new TimeSpan(0);
    if (current.dungeonId != 1 && current.dungeonId != 5 && current.floor == 1) {
        return true;
    }
}

reset
{
    if (current.dungeonId == 1) {
        return true;
    }
}

update
{
    if (old.gameTime < current.gameTime) {
        vars.totalTime = TimeSpan.FromMilliseconds(current.gameTime);
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
