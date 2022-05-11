state("dfz")
{
    int gameTimeRAM  : "mono.dll", 0x002681D0, 0x18, 0x148, 0x20, 0x38, 0x20;   // ゲーム内タイム
    int turnCountRAM : "mono.dll", 0x002681D0, 0x18, 0x148, 0x20, 0x38, 0x24;   // ターン数
    int dungeonIdRAM : "mono.dll", 0x002681D0, 0x18, 0x148, 0x20, 0x40, 0x10;   // ダンジョンID
    int floorRAM     : "mono.dll", 0x002681D0, 0x18, 0x148, 0x20, 0x40, 0x18;   // 現在階層
    int cradleClearNumRAM  : "mono.dll", 0x00268180, 0x100, 0x138, 0x344, 0x40, 0xE0, 0x10, 0x48, 0x18;  // ゆりかごクリア回数
    int abyssClearNumRAM : "mono.dll", 0x00268180, 0x100, 0x138, 0x344, 0x40, 0xE0, 0x10, 0x60, 0x18;  // 深淵クリア回数
    int fangsClearNumRAM : "mono.dll", 0x00268180, 0x100, 0x138, 0x344, 0x40, 0xE0, 0x10, 0x70, 0x18;  // 牙クリア回数
    int hollowClearNumRAM  : "mono.dll", 0x00268180, 0x100, 0x138, 0x344, 0x40, 0xE0, 0x10, 0x58, 0x18;  // 奈落クリア回数
    int friendshipClearNumRAM  : "mono.dll", 0x00268180, 0x100, 0x138, 0x344, 0x40, 0xE0, 0x10, 0x68, 0x18;  // 友絆クリア回数
    int eggClearNumRAM  : "mono.dll", 0x00268180, 0x100, 0x138, 0x344, 0x40, 0xE0, 0x10, 0x40, 0x18;  // たまごクリア回数
}

startup
{
    vars.totalTime    = new TimeSpan(0);
    refreshRate       = 60;

    // 時の宿り木のID
    vars.startDungeonId = 1;

    // 各種ダンジョンのID
    vars.targetDungeonId = 13;
    vars.cradleDungeonId = 11;
    vars.abyssDungeonId = 12;
    vars.fangsDungeonId = 13;
    vars.hollowDungeonId = 14;
    vars.eggDungeonId = 16;
    vars.friendshipDungeonId = 17;

    string prefix = "";
    int totalFloor = 0;

    //------------------
    // オプション項目作成
    //------------------

    settings.Add("reset_on_tree", true, "時の宿り木に戻ったらリセット(Auto Reset on Tree of Time)");
    settings.Add("reset_on_restart", true, "再挑戦を選択したらリセット(Auto Reset on Restart)");

    // 竜のゆりかご
    prefix = "cradle";
    totalFloor = 30;
    settings.Add("enable_" + prefix, false, "竜のゆりかご(Dragon's Cradle)");
    settings.CurrentDefaultParent = "enable_" + prefix;    
        settings.Add(prefix + "_auto_split_dungeon_start", false, "ダンジョン開始時(Dungeon Start)");
        settings.Add(prefix + "_auto_split_dungeon_clear", false, "ダンジョンクリア(Dungeon Clear)");
        settings.Add(settings.CurrentDefaultParent + "_floor_split", false, "階層到達時(Arrival floor)");
        for (int floor = 2; floor <= totalFloor; ++floor) {
            settings.Add(prefix + "_" + floor, false, floor + "F", settings.CurrentDefaultParent + "_floor_split");
        }
    settings.CurrentDefaultParent = null;

    // 竜の深淵
    prefix = "abyss";
    totalFloor = 50;
    settings.Add("enable_" + prefix, false, "竜の深淵(Dragon's Abyss)");
    settings.CurrentDefaultParent = "enable_" + prefix;
        settings.Add(prefix + "_auto_split_dungeon_start", false, "ダンジョン開始時(Dungeon Start)");
        settings.Add(prefix + "_auto_split_dungeon_clear", false, "ダンジョンクリア(Dungeon Clear)");
        settings.Add(settings.CurrentDefaultParent + "_floor_split", false, "階層到達時(Arrival floor)");
        for (int floor = 2; floor <= totalFloor; ++floor) {
            settings.Add(prefix + "_" + floor, false, floor + "F", settings.CurrentDefaultParent + "_floor_split");
        }
    settings.CurrentDefaultParent = null;

    // 牙の洞窟
    prefix = "fangs";
    totalFloor = 30;
    settings.Add("enable_" + prefix, false, "牙の洞窟(The Cave of Fangs)");
    settings.CurrentDefaultParent = "enable_" + prefix;
        settings.Add(prefix + "_auto_split_dungeon_start", false, "ダンジョン開始時(Dungeon Start)");
        settings.Add(prefix + "_auto_split_dungeon_clear", false, "ダンジョンクリア(Dungeon Clear)");
        settings.Add(settings.CurrentDefaultParent + "_floor_split", false, "階層到達時(Arrival floor)");
        for (int floor = 2; floor <= totalFloor; ++floor) {
            settings.Add(prefix + "_" + floor, false, floor + "F", settings.CurrentDefaultParent + "_floor_split");
        }
    settings.CurrentDefaultParent = null;

    // 奈落の修練場
    prefix = "hollow";
    totalFloor = 60;
    settings.Add("enable_" + prefix, false, "奈落の修練場(The Inferno Hollow)");
    settings.CurrentDefaultParent = "enable_" + prefix;
        settings.Add(prefix + "_auto_split_dungeon_start", false, "ダンジョン開始時(Dungeon Start)");
        settings.Add(prefix + "_auto_split_dungeon_clear", false, "ダンジョンクリア(Dungeon Clear)");
        settings.Add(settings.CurrentDefaultParent + "_floor_split", false, "階層到達時(Arrival floor)");
        for (int floor = 2; floor <= totalFloor; ++floor) {
            settings.Add(prefix + "_" + floor, false, floor + "F", settings.CurrentDefaultParent + "_floor_split");
        }
    settings.CurrentDefaultParent = null;

    // 友絆の迷宮
    prefix = "friendship";
    totalFloor = 30;
    settings.Add("enable_" + prefix, false, "友絆の迷宮(Friendship's Labyrinth)");
    settings.CurrentDefaultParent = "enable_" + prefix;
        settings.Add(prefix + "_auto_split_dungeon_start", false, "ダンジョン開始時(Dungeon Start)");
        settings.Add(prefix + "_auto_split_dungeon_clear", false, "ダンジョンクリア(Dungeon Clear)");
        settings.Add(settings.CurrentDefaultParent + "_floor_split", false, "階層到達時(Arrival floor)");
        for (int floor = 2; floor <= totalFloor; ++floor) {
            settings.Add(prefix + "_" + floor, false, floor + "F", settings.CurrentDefaultParent + "_floor_split");
        }
    settings.CurrentDefaultParent = null;
    
    // 竜のたまご
    prefix = "egg";
    totalFloor = 10;
    settings.Add("enable_" + prefix, false, "竜のたまご(Dragon's Egg)");
    settings.CurrentDefaultParent = "enable_" + prefix;
        settings.Add(prefix + "_auto_split_dungeon_start", false, "ダンジョン開始時(Dungeon Start)");
        settings.Add(prefix + "_auto_split_dungeon_clear", false, "ダンジョンクリア(Dungeon Clear)");
        settings.Add(settings.CurrentDefaultParent + "_floor_split", false, "階層到達時(Arrival floor)");
        for (int floor = 2; floor <= totalFloor; ++floor) {
            settings.Add(prefix + "_" + floor, false, floor + "F", settings.CurrentDefaultParent + "_floor_split");
        }
    settings.CurrentDefaultParent = null;
}

start
{
    vars.totalTime    = new TimeSpan(0);

    if (current.floorRAM != 1) {
        return false;
    }

    // 竜のゆりかご
    if (settings["cradle_auto_split_dungeon_start"]) {
        if (current.dungeonIdRAM == vars.cradleDungeonId) {
            return true;
        }
    }

    // 竜の深淵
    if (settings["abyss_auto_split_dungeon_start"]) {
        if (current.dungeonIdRAM == vars.abyssDungeonId) {
            return true;
        }
    }

    // 牙の洞窟
    if (settings["fangs_auto_split_dungeon_start"]) {
        if (current.dungeonIdRAM == vars.fangsDungeonId) {
            return true;
        }
    }

    // 奈落の修練場
    if (settings["hollow_auto_split_dungeon_start"]) {
        if (current.dungeonIdRAM == vars.hollowDungeonId) {
            return true;
        }
    }

    // 友絆の迷宮
    if (settings["friendship_auto_split_dungeon_start"]) {
        if (current.dungeonIdRAM == vars.friendshipDungeonId) {
            return true;
        }
    }
    
    // 竜のたまご
    if (settings["egg_auto_split_dungeon_start"]) {
        if (current.dungeonIdRAM == vars.eggDungeonId) {
            return true;
        }
    }
}

reset
{
    // 時の宿り木に戻った場合リセット
    if (settings["reset_on_tree"]) {
        if (current.dungeonIdRAM == vars.startDungeonId) {
            return true;
        }
    }

    // 再挑戦を選択時リセット
    if (settings["reset_on_restart"]) {
        if (current.floorRAM == 0) {
            return false;
        }
        if (current.dungeonIdRAM != vars.startDungeonId
            && current.floorRAM == 1
            && old.floorRAM == 0
            && current.turnCountRAM == 0
        ) {
            return true;
        }
    }
}

split
{
    string key = "";

    // 竜のゆりかご
    if (settings["cradle_auto_split_dungeon_clear"]) {
        if (current.cradleClearNumRAM > old.cradleClearNumRAM && old.cradleClearNumRAM != 0) {
            return true;
        }
    }
    if (current.dungeonIdRAM == vars.cradleDungeonId) {
        for (int floor = 2; floor <= 30; ++floor) {
            key = "cradle_" + floor;
            if (settings[key]
                && current.floorRAM > old.floorRAM
                && current.floorRAM == floor
            ) {
                return true;
            }
        }
    }

    // 竜の深淵
    if (settings["abyss_auto_split_dungeon_clear"]) {
        if (current.abyssClearNumRAM > old.abyssClearNumRAM && old.abyssClearNumRAM != 0) {
            return true;
        }
    }
    if (current.dungeonIdRAM == vars.abyssDungeonId) {
        for (int floor = 2; floor <= 50; ++floor) {
            key = "abyss_" + floor;
            if (settings[key]
                && current.floorRAM > old.floorRAM
                && current.floorRAM == floor
            ) {
                return true;
            }
        }
    }

    // 牙の洞窟
    if (settings["fangs_auto_split_dungeon_clear"]) {
        if (current.fangsClearNumRAM > old.fangsClearNumRAM && old.fangsClearNumRAM != 0) {
            return true;
        }
    }
    if (current.dungeonIdRAM == vars.fangsDungeonId) {
        for (int floor = 2; floor <= 30; ++floor) {
            key = "fangs_" + floor;
            if (settings[key]
                && current.floorRAM > old.floorRAM
                && current.floorRAM == floor
            ) {
                return true;
            }
        }
    }

    // 奈落の修練場
    if (settings["hollow_auto_split_dungeon_clear"]) {
        if (current.hollowClearNumRAM > old.hollowClearNumRAM && old.hollowClearNumRAM != 0) {
            return true;
        }
    }
    if (current.dungeonIdRAM == vars.hollowDungeonId) {
        for (int floor = 2; floor <= 60; ++floor) {
            key = "hollow_" + floor;
            if (settings[key]
                && current.floorRAM > old.floorRAM
                && current.floorRAM == floor
            ) {
                return true;
            }
        }
    }

    // 友絆の迷宮
    if (settings["friendship_auto_split_dungeon_clear"]) {
        if (current.friendshipClearNumRAM > old.friendshipClearNumRAM && old.friendshipClearNumRAM != 0) {
            return true;
        }
    }
    if (current.dungeonIdRAM == vars.friendshipDungeonId) {
        for (int floor = 2; floor <= 30; ++floor) {
            key = "friendship_" + floor;
            if (settings[key]
                && current.floorRAM > old.floorRAM
                && current.floorRAM == floor
            ) {
                return true;
            }
        }
    }
    
    // 竜のたまご
    if (settings["egg_auto_split_dungeon_clear"]) {
        if (current.eggClearNumRAM > old.eggClearNumRAM && old.eggClearNumRAM != 0) {
            return true;
        }
    }
    if (current.dungeonIdRAM == vars.eggDungeonId) {
        for (int floor = 2; floor <= 10; ++floor) {
            key = "egg_" + floor;
            if (settings[key]
                && current.floorRAM > old.floorRAM
                && current.floorRAM == floor
            ) {
                return true;
            }
        }
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