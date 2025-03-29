--AddAllInOneCommands.lua

EnableGlobals()

-- List of DVars to control
local dvars = {"patch"}

-- Function to initialize the color selection model
local f0_local0 = function(controller)
    if not Engine.GetModel(Engine.GetModelForController(controller), "currentColorModel") then
        Engine.CreateModel(Engine.GetModelForController(controller), "currentColorModel")
        Engine.SetModelValue(Engine.CreateModel(Engine.GetModelForController(controller), "currentColorModel"), "") -- Default to OFF
    end
end

-- Function to set all DVars to a specific color
local f0_local1 = function(controller, color)
    for _, dvar in ipairs(dvars) do
        Engine.SetDvar(dvar, color)
    end
end

-- Function to handle color selection
local f0_local2 = function(button, controller, color)
    local currentColor = Engine.GetModelValue(Engine.GetModel(Engine.GetModelForController(controller), "currentColorModel"))
    
    -- Reset all DVars to OFF before applying the new color
    for _, dvar in ipairs(dvars) do
        Engine.SetDvar(dvar, "") -- Set all DVars to OFF
    end

    if currentColor == color then
        -- If the same color is selected again, toggle it OFF
        Engine.SetModelValue(Engine.GetModel(Engine.GetModelForController(controller), "currentColorModel"), "")
    else
        -- Set all DVars to the new color
        for _, dvar in ipairs(dvars) do
            Engine.SetDvar(dvar, color)
        end
        Engine.SetModelValue(Engine.GetModel(Engine.GetModelForController(controller), "currentColorModel"), color)
    end

    -- Highlight the selected button
    if color == "purple" then
        button:setRGB(0.42, 0.19, 0.6) -- Set text color to purple
        button:setMaterial(LUI.UIImage.GetCachedMaterial("sw4_2d_uie_font_cached_glow")) -- Add glow effect
        button:setShaderVector(0, 1, 0, 0, 0) -- Glow intensity
        button:setShaderVector(1, 0.42, 0.19, 0.6, 1) -- Glow color (purple)
        button:setShaderVector(2, 1, 0, 0, 0) -- Glow size
    else
        -- Reset other buttons to default
        button:setRGB(1, 1, 1) -- Reset text color to white
        button:setMaterial(nil) -- Remove glow effect
    end
end

-- Function to dynamically update button text based on the current color state
local f0_local3 = function(controller, color)
    local currentColor = Engine.GetModelValue(Engine.GetModel(Engine.GetModelForController(controller), "currentColorModel"))
    if currentColor == color then
        -- Apply color codes based on the selected color
        if color == "ovum" then
            return "ovum"
        elseif color == "flag" then
            return "flag"
        elseif color == "lineup" then
            return "lineup"
        elseif color == "keeper" then
            return "keeper"
        elseif color == "wisp" then
            return "wisp"
        elseif color == "midgame" then
            return "midgame"
        elseif color == "bow shots" then
            return "bow shots"
        elseif color == "spider bounce" then
            return "spider bounce"
        elseif color == "boss" then
            return "boss"
        elseif color == "challenges" then
            return "challenges"
        elseif color == "gersch" then
            return "gersch"
        elseif color == "sophia" then
            return "sophia"
        elseif color == "ld skip" then
            return "ld skip"
        elseif color == "arnies" then
            return "arnies"
        elseif color == "bones" then
            return "bones"
        elseif color == "eggs" then
            return "eggs"
        elseif color == "basketball" then
            return "basketball"
        elseif color == "boss 1" then
            return "boss 1"
        elseif color == "boss 2" then
            return "boss 2"
        elseif color == "lander skip" then
            return "lander skip"
        elseif color == "coop tiles" then
            return "coop tiles"
        elseif color == "simon says" then
            return "simon says"
        elseif color == "lightning parts" then
            return "lightning parts"
        elseif color == "self med" then
            return "self med"
        elseif color == "ending" then
            return "ending"
        elseif color == "soft" then
            return "soft"
        elseif color == "song" then
            return "song"
        elseif color == "pap" then
            return "pap"
        end
    else
        return color:upper() .. " [" .. "^1OFF^7" .. "]" -- Default OFF state
    end
end

-- Add the functionality to the "ALL IN ONE" tab
CoD.AddAllInOneCommands = function(controller)
    f0_local0(controller) -- Initialize the color model
    local f3_local0 = {}

    -- Function to create a color option
    local f3_local1 = function(color)
        local option = {
            models = {
                displayText = f0_local3(controller, color),
                action = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4)
                    f0_local2(f1_arg1, controller, color)
                    -- Update the button text dynamically
                    Engine.SetModelValue(Engine.GetModel(f1_arg1:getModel(), "displayText"), f0_local3(controller, color))
                end
            }
        }

        return option
    end

    -- Add color options
    if Engine.GetCurrentMap() == "zm_zod" then
        table.insert(f3_local0, f3_local1("ovum"))
        table.insert(f3_local0, f3_local1("flag"))
        table.insert(f3_local0, f3_local1("soft"))
        table.insert(f3_local0, f3_local1("song"))
        table.insert(f3_local0, f3_local1("pap"))
    elseif Engine.GetCurrentMap() == "zm_factory" then   
        table.insert(f3_local0, f3_local1("lineup"))
        table.insert(f3_local0, f3_local1("soft"))
        table.insert(f3_local0, f3_local1("song"))
        table.insert(f3_local0, f3_local1("pap"))
    elseif Engine.GetCurrentMap() == "zm_castle" then   
        table.insert(f3_local0, f3_local1("keeper"))
        table.insert(f3_local0, f3_local1("wisp"))
        table.insert(f3_local0, f3_local1("midgame"))
        table.insert(f3_local0, f3_local1("bow shots"))
        table.insert(f3_local0, f3_local1("soft"))
        table.insert(f3_local0, f3_local1("song"))
        table.insert(f3_local0, f3_local1("pap"))
    elseif Engine.GetCurrentMap() == "zm_island" then   
        table.insert(f3_local0, f3_local1("spider bounce"))
        table.insert(f3_local0, f3_local1("soft"))
        table.insert(f3_local0, f3_local1("song"))
        table.insert(f3_local0, f3_local1("pap"))
    elseif Engine.GetCurrentMap() == "zm_stalingrad" then   
        table.insert(f3_local0, f3_local1("boss"))
        table.insert(f3_local0, f3_local1("challenges"))
        table.insert(f3_local0, f3_local1("gersch"))
        table.insert(f3_local0, f3_local1("sophia"))
        table.insert(f3_local0, f3_local1("ld skip"))
        table.insert(f3_local0, f3_local1("soft"))
        table.insert(f3_local0, f3_local1("song"))
        table.insert(f3_local0, f3_local1("pap"))
    elseif Engine.GetCurrentMap() == "zm_genesis" then   
        table.insert(f3_local0, f3_local1("arnies"))
        table.insert(f3_local0, f3_local1("bones"))
        table.insert(f3_local0, f3_local1("eggs"))
        table.insert(f3_local0, f3_local1("basketball"))
        table.insert(f3_local0, f3_local1("boss 1"))
        table.insert(f3_local0, f3_local1("boss 2"))
        table.insert(f3_local0, f3_local1("soft"))
        table.insert(f3_local0, f3_local1("song"))
        table.insert(f3_local0, f3_local1("pap"))
    elseif Engine.GetCurrentMap() == "zm_prototype" then
    elseif Engine.GetCurrentMap() == "zm_asylum" then   
        table.insert(f3_local0, f3_local1("song"))
    elseif Engine.GetCurrentMap() == "zm_sumpf" then   
        table.insert(f3_local0, f3_local1("song"))
    elseif Engine.GetCurrentMap() == "zm_theater" then   
        table.insert(f3_local0, f3_local1("song"))
        table.insert(f3_local0, f3_local1("pap"))
    elseif Engine.GetCurrentMap() == "zm_cosmodrome" then
        table.insert(f3_local0, f3_local1("lander skip"))  
        table.insert(f3_local0, f3_local1("soft"))
        table.insert(f3_local0, f3_local1("song"))
        table.insert(f3_local0, f3_local1("pap"))
    elseif Engine.GetCurrentMap() == "zm_temple" then
        table.insert(f3_local0, f3_local1("coop tiles"))   
        table.insert(f3_local0, f3_local1("soft"))
        table.insert(f3_local0, f3_local1("song"))
        table.insert(f3_local0, f3_local1("pap"))
    elseif Engine.GetCurrentMap() == "zm_moon" then
        table.insert(f3_local0, f3_local1("simon says"))
        table.insert(f3_local0, f3_local1("soft"))
        table.insert(f3_local0, f3_local1("song"))
        table.insert(f3_local0, f3_local1("pap"))
    elseif Engine.GetCurrentMap() == "zm_tomb" then
        table.insert(f3_local0, f3_local1("lightning parts"))
        table.insert(f3_local0, f3_local1("self med"))
        table.insert(f3_local0, f3_local1("ending")) 
        table.insert(f3_local0, f3_local1("soft"))
        table.insert(f3_local0, f3_local1("song"))
        table.insert(f3_local0, f3_local1("pap"))
    end

    return f3_local0
end