majorMash = {"cmd", "alt", "ctrl"}
minorMash = {"shift", "alt", "ctrl"}

hs.loadSpoon("SpoonInstall", {
    use_syncinstall = true
})

-- todo add multiple repos

-- spoon.SpoonInstall.repos.HammerspoonShiftit = {
--     url = "https://github.com/azarakovskiy/hammerspoon-shiftit",
--     desc = "HammerspoonShiftit spoon repository",
--     branch = "master",
-- }
-- spoon.SpoonInstall:updateRepo('HammerspoonShiftit')
Install=spoon.SpoonInstall


Install:andUse("Caffeine", {
    start = true, hotkeys = { 
        toggle = { minorMash, "c" }
    }
})

Install:andUse("MouseCircle", {    
    config = {
        color = hs.drawing.color.x11.darkred        
    },
    hotkeys = { 
        show = { minorMash, "m" }
    }
})

hs.loadSpoon("ShiftIt")
spoon.HammerspoonShiftIt:bindHotkeys({});
