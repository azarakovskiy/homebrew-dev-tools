majorMash = {"cmd", "alt", "ctrl"}
minorMash = {"shift", "alt", "ctrl"}

hs.loadSpoon("SpoonInstall", {
    use_syncinstall = true
})

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
spoon.ShiftIt:bindHotkeys({});

require("bluetooth")
