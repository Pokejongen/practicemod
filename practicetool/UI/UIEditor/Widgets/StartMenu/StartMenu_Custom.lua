--StartMenu_Custom.lua

require( "ui.uieditor.widgets.Scrollbars.verticalScrollbar" )
require( "ui.uieditor.widgets.Scrollbars.verticalCounter" )
--require( "ui.uieditor.widgets.BackgroundFrames.GenericMenuFrame" )
require( "ui.uieditor.widgets.StartMenu.StartMenu_lineGraphics_Options" )
require( "ui.uieditor.widgets.TabbedWidgets.basicTabList" )
require( "ui.uieditor.widgets.TabbedWidgets.paintshopTabWidget" )
require( "ui.uieditor.widgets.PC.StartMenu.Dropdown.OptionDropdown" )
require( "ui.uieditor.widgets.StartMenu.StartMenu_Options_CheckBoxOption" )
require( "ui.uieditor.widgets.StartMenu.StartMenu_Options_SliderBar" )
require( "ui.uieditor.widgets.PC.Utility.VerticalListSpacer" )
require( "ui.uieditor.widgets.StartMenu.AddAllInOneCommands" ) -- Ensure the correct file name

-- Add the new tab to the StartMenuTabs data source
DataSources.StartMenuTabs = ListHelper_SetupDataSource( "StartMenuTabs", function ( f1_arg0 )
    local f1_local0 = {}
    table.insert( f1_local0, {
        models = {
            tabIcon = CoD.buttonStrings.shoulderl
        },
        properties = {
            m_mouseDisabled = true
        }
    } )
    table.insert( f1_local0, {
        models = {
            tabName = SessionModeToUnlocalizedSessionModeCaps( Engine.CurrentSessionMode() ),
            tabWidget = "CoD.StartMenu_GameOptions_ZM",
            tabIcon = ""
        },
        properties = {
            tabId = "gameOptions"
        }
    } )
    table.insert( f1_local0, {
        models = {
            tabName = "MENU_TAB_OPTIONS_CAPS",
            tabWidget = "CoD.StartMenu_Options",
            tabIcon = ""
        },
        properties = {
            tabId = "options"
        }
    } )
    -- Add the new "ALL IN ONE" tab
    table.insert( f1_local0, {
        models = {
            tabName = "PRACTICE PATCHES",
            tabWidget = "CoD.StartMenu_AllInOne",
            tabIcon = ""
        },
        properties = {
            tabId = "allInOne"
        }
    } )
    table.insert( f1_local0, {
        models = {
            tabIcon = CoD.buttonStrings.shoulderr
        },
        properties = {
            m_mouseDisabled = true
        }
    } )
    return f1_local0
end, true )

-- Define the data source for the "ALL IN ONE" tab
DataSources.StartMenuAllInOne = ListHelper_SetupDataSource( "StartMenuAllInOne", function ( f2_arg0 )
    return CoD.AddAllInOneCommands( f2_arg0 ) -- Reference the functionality
end, true )

-- Define the UI element for the "ALL IN ONE" tab
CoD.StartMenu_AllInOne = InheritFrom(LUI.UIElement)
CoD.StartMenu_AllInOne.new = function(f6_arg0, f6_arg1)
    local f6_local0 = CoD.StartMenu_GameOptions_ZM.new(f6_arg0, f6_arg1)
    f6_local0:setClass(CoD.StartMenu_AllInOne)
    f6_local0.id = "StartMenu_AllInOne"

    -- Add the rectangle image above the button list for "All"
    local rectangleImage = LUI.UIImage.new()
    if Engine.GetCurrentMap() == "zm_zod" then
        rectangleImage:setLeftRight(true, false, -20, 140)
    elseif Engine.GetCurrentMap() == "zm_factory" then   
        rectangleImage:setLeftRight(true, false, -10, 130)
    elseif Engine.GetCurrentMap() == "zm_castle" then   
        rectangleImage:setLeftRight(true, false, -10, 130)
    elseif Engine.GetCurrentMap() == "zm_island" then   
        rectangleImage:setLeftRight(true, false, -20, 140)
    elseif Engine.GetCurrentMap() == "zm_stalingrad" then   
        rectangleImage:setLeftRight(true, false, -10, 130)
    elseif Engine.GetCurrentMap() == "zm_genesis" then   
        rectangleImage:setLeftRight(true, false, -20, 140)
    elseif Engine.GetCurrentMap() == "zm_prototype" then   
        rectangleImage:setLeftRight(true, false, -40, 160)
    elseif Engine.GetCurrentMap() == "zm_asylum" then   
        rectangleImage:setLeftRight(true, false, -50, 170)
    elseif Engine.GetCurrentMap() == "zm_sumpf" then   
        rectangleImage:setLeftRight(true, false, -20, 140)
    elseif Engine.GetCurrentMap() == "zm_theater" then   
        rectangleImage:setLeftRight(true, false, -30, 150)
    elseif Engine.GetCurrentMap() == "zm_cosmodrome" then   
        rectangleImage:setLeftRight(true, false, -20, 140)
    elseif Engine.GetCurrentMap() == "zm_temple" then   
        rectangleImage:setLeftRight(true, false, -40, 160)
    elseif Engine.GetCurrentMap() == "zm_moon" then   
        rectangleImage:setLeftRight(true, false, -30, 150)
    elseif Engine.GetCurrentMap() == "zm_tomb" then   
        rectangleImage:setLeftRight(true, false, -45, 165)
    else 
        rectangleImage:setLeftRight(true, false, -30, 150)
    end
    rectangleImage:setTopBottom(true, false, 10, 50)
    rectangleImage:setImage(RegisterImage("uie_t7_menu_cac_itemtitleglowmm"))
    rectangleImage:setAlpha(1)
    f6_local0:addElement(rectangleImage)

    -- Add text over the rectangle image for "All"
    local titleText = LUI.UIText.new()
    titleText:setLeftRight(true, false, -40, 160)
    titleText:setTopBottom(true, false, 20, 40)
    if Engine.GetCurrentMap() == "zm_zod" then
        titleText:setText(Engine.Localize("SOE Patches"))
    elseif Engine.GetCurrentMap() == "zm_factory" then   
        titleText:setText(Engine.Localize("TG Patches"))
    elseif Engine.GetCurrentMap() == "zm_castle" then   
        titleText:setText(Engine.Localize("DE Patches"))
    elseif Engine.GetCurrentMap() == "zm_island" then   
        titleText:setText(Engine.Localize("ZNS Patches"))
    elseif Engine.GetCurrentMap() == "zm_stalingrad" then   
        titleText:setText(Engine.Localize("GK Patches"))
    elseif Engine.GetCurrentMap() == "zm_genesis" then   
        titleText:setText(Engine.Localize("REV Patches"))
    elseif Engine.GetCurrentMap() == "zm_prototype" then   
        titleText:setText(Engine.Localize("NACHT Patches"))
    elseif Engine.GetCurrentMap() == "zm_asylum" then   
        titleText:setText(Engine.Localize("VERRUCKT Patches"))
    elseif Engine.GetCurrentMap() == "zm_sumpf" then   
        titleText:setText(Engine.Localize("SNN Patches"))
    elseif Engine.GetCurrentMap() == "zm_theater" then   
        titleText:setText(Engine.Localize("KINO Patches"))
    elseif Engine.GetCurrentMap() == "zm_cosmodrome" then   
        titleText:setText(Engine.Localize("ASC Patches"))
    elseif Engine.GetCurrentMap() == "zm_temple" then   
        titleText:setText(Engine.Localize("SHANG Patches"))
    elseif Engine.GetCurrentMap() == "zm_moon" then   
        titleText:setText(Engine.Localize("MOON Patches"))
    elseif Engine.GetCurrentMap() == "zm_tomb" then   
        titleText:setText(Engine.Localize("ORIGINS Patches"))
    else 
        titleText:setText(Engine.Localize("Prac Patches"))
    end
    titleText:setTTF("fonts/escom.ttf")
    titleText:setAlignment(LUI.Alignment.Center)
    titleText:setRGB(0, 0, 0)
    titleText:setAlpha(1)
    titleText:setScale(1.3)
    titleText:setLetterSpacing(2)
    titleText:setMaterial(LUI.UIImage.GetCachedMaterial("sw4_2d_uie_font_cached_glow"))
    titleText:setShaderVector(0, 0.1, 0, 0, 0)
    titleText:setShaderVector(1, 0, 0, 0, 0)
    titleText:setShaderVector(2, 1, 0, 0, 0)
    f6_local0:addElement(titleText)

    -- Adjust the button list to be below the rectangle image for "All"
    if f6_local0.buttonList then
        f6_local0.buttonList:setSpacing(1.5)
        f6_local0.buttonList:setVerticalCount(7)
        f6_local0.buttonList:setHorizontalCount(1)
        f6_local0.buttonList:setVerticalScrollbar(CoD.verticalScrollbar)
        f6_local0.buttonList:setVerticalCounter(CoD.verticalCounter)
        f6_local0.buttonList:setDataSource("StartMenuAllInOne")
        f6_local0.buttonList:setTopBottom(true, false, 60, 300)
    end
    
    return f6_local0
end

-- Define the data source for the "ALL IN ONE" tab

--[[ Define the data source for the "CAMO" tab
DataSources.StartMenuCamo = ListHelper_SetupDataSource( "StartMenuCamo", function ( f2_arg0 )
    return CoD.CamoMenuCustom.GetDataSource( f2_arg0 )
end, true )

-- Define the UI element for the "CAMO" tab
CoD.StartMenu_Camo = InheritFrom(LUI.UIElement)
CoD.StartMenu_Camo.new = function(f6_arg0, f6_arg1)
    local f6_local0 = CoD.StartMenu_GameOptions_ZM.new(f6_arg0, f6_arg1)
    f6_local0:setClass(CoD.StartMenu_Camo)
    f6_local0.id = "StartMenu_Camo"
    CoD.CamoMenuCustom.SetupUI(f6_local0, f6_arg1)
    return f6_local0
end

DataSources.GunsmithWeaponOptions = {
    getModel = function(controller)
        return Engine.GetModel(Engine.GetModelForController(controller), "GunsmithWeaponOptions")
    end,
    setCurrentFilterItem = function(filter)
        -- Set the current filter for the data source
    end
}]]