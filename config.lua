Config = {}

---------------------------------
-- shop settings
---------------------------------
Config = {
    ResearchShopItems = {
        { name = 'bpo_pickaxe', amount = 10, price = 500 },
        { name = 'bpo_weapon_revolver_cattleman', amount = 10, price = 1000 },
        { name = 'bpo_weapon_pistol_volcanic', amount = 10, price = 1000 },
        { name = 'bpo_weapon_repeater_carbine', amount = 10, price = 1000 },
        { name = 'bpo_weapon_rifle_varmint', amount = 10, price = 1000 },
        { name = 'bpo_weapon_shotgun_doublebarrel', amount = 10, price = 1000 },
    },
    PersistStock = true, --should stock save in database and load it after restart, to 'remember' stock value before restart
}

---------------------------------
-- settings
---------------------------------
Config.Image = "rsg-inventory/html/images/"
Config.Keybind = 'J'
Config.EnableTarget = true
Config.CopyTime = 10000

---------------------------------
-- npc settings
---------------------------------
Config.DistanceSpawn = 20.0
Config.FadeIn = true

---------------------------------
-- blip settings
---------------------------------
Config.Blip = {
    blipName = 'Research Lab', -- Config.Blip.blipName
    blipSprite = 'blip_mp_ugc', -- Config.Blip.blipSprite
    blipScale = 0.2 -- Config.Blip.blipScale
}

---------------------------------
-- npc locations
---------------------------------
Config.ResearchLocations = {
    {
        name = 'Research',
        prompt = 'research_lab',
        coords = vector3(2516.90, 2285.04, 177.35),
        npcmodel = `cs_crackpotrobot`,
        npccoords = vector4(2516.90, 2285.04, 177.35, 252.51),
        showblip = true
    },
}

---------------------------------
-- blueprints
---------------------------------
Config.Blueprints = {
    {
        item = 'bpo_pickaxe',
        receive = 'bpc_pickaxe',
        runcost = 1,
        copytime = 10000,
    },
    {
        item = 'bpo_weapon_revolver_cattleman',
        receive = 'bpc_weapon_revolver_cattleman',
        runcost = 1,
        copytime = 10000,
    },
    {
        item = 'bpo_weapon_pistol_volcanic',
        receive = 'bpc_weapon_pistol_volcanic',
        runcost = 1,
        copytime = 10000,
    },
    {
        item = 'bpo_weapon_repeater_carbine',
        receive = 'bpc_weapon_repeater_carbine',
        runcost = 1,
        copytime = 10000,
    },
    {
        item = 'bpo_weapon_rifle_varmint',
        receive = 'bpc_weapon_rifle_varmint',
        runcost = 1,
        copytime = 10000,
    },
    {
        item = 'bpo_weapon_shotgun_doublebarrel',
        receive = 'bpc_weapon_shotgun_doublebarrel',
        runcost = 1,
        copytime = 10000,
    },
}
