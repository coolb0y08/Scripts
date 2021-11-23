-- Functions --

local GetService = game.GetService;
local FindFirstChild = game.FindFirstChild;
local FindFirstChildOfClass = game.FindFirstChildOfClass;
local wrap = coroutine.wrap;

-- Services --

local HttpService = GetService(game, "HttpService");
local TestService = GetService(game, "TestService");
local CoreGui = GetService(game, "CoreGui");
local Players = GetService(game, "Players");
local ReplicatedStorage = GetService(game, "ReplicatedStorage");

-- CoreGUI Rich text --

wrap(function()
    CoreGui.DescendantAdded:Connect(function(t)
        if t.Name == "msg" then
            t.RichText = true;
    
            if string.find(t.Text, "TestService:") then
                local Text = t.Text:gsub("TestService: ", "<font color='rgb(110, 38, 224)'>[🌌] : </font>");
                t.Text = Text;
            end;
        end;
    end);
end)()

-- Miscellaneous functions --

getplayers = function()
    local PlayerList = { };
    for i,v in pairs(Players:GetPlayers()) do
        if v.Name ~= Players.LocalPlayer.Name then
            table.insert(PlayerList, v.Name)
        end
    end
    return PlayerList
end

Player = Players.LocalPlayer;

-- Functions --

load = function(id)
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/coolb0y08/Scripts/main/Hubs/Galaxy-Ware/Modules/"..id..".lua"));
end

-- Libraries --

local ESP = load("Kiriot-ESP")();
local UI = load("UI-Library")();

-- UI Setting up --

local Theme = UI.theme
Theme.accentcolor = Color3.fromRGB(62, 40, 191);
Theme.topcolor2 = Color3.fromRGB(20, 20, 20);

local Elements = {};
Elements.Colorpickers = {};
Elements.Toggles = {};
Elements.Textboxes = {};
Elements.Dropdowns = {};
Elements.PlayerLists = {}
Elements.Buttons = {};
Elements.Labels = {};
Elements.Sections = {};
Elements.Tabs = {};
Elements.Seperators = {};
Elements.WeaponList = {};

Elements.Window = UI:CreateWindow("galaxyware", Vector2.new(492, 300), "none");

if game.PlaceId == 5400959086 then
    Elements.Watermark = UI:CreateWatermark("galaxy-ware | v1 | {game} | {fps}");

    -- Tabs --

    Elements.Tabs.Game = Elements.Window:CreateTab("Task Force");
    Elements.Tabs.Visuals = Elements.Window:CreateTab("Visuals");
    Elements.Tabs.Settings = Elements.Window:CreateTab("Settings");

    -- Game --

    Elements.Sections.Game = Elements.Tabs.Game:CreateSector("Exploits", "Left"); do
        Elements.Sections.Game:AddButton("Invite all", function(t)
            for i,v in pairs(Players:GetPlayers()) do
                local ohString1 = "AcceptedRequest"
                local ohInstance2 = v
                
                ReplicatedStorage.Event:FireServer(ohString1, ohInstance2)
            end
        end);

        Elements.Sections.Game:AddTextbox("Change Code Name", "", function(t)
            game:GetService("ReplicatedStorage").Event:FireServer("SetCodeName", t)
        end)
    end
    
    

    -- Settings --

    Elements.Sections.UI = Elements.Tabs.Settings:CreateSector("UI", "Left"); do
        Elements.Sections.UI:AddKeybind("Toggle UI", Enum.KeyCode.RightShift, nil, function(t)
            if Elements.Window.Frame.Visible == true then
                Elements.Window.Frame.Visible = false;
            else
                Elements.Window.Frame.Visible = true;
            end;
        end);

        Elements.Toggles.ChangeName = Elements.Sections.UI:AddToggle("Change UI Name", false, function(t)
            if t then
                Elements.Window.NameLabel.Text = UI.flags["UI-Name"];
            else
                Elements.Window.NameLabel.Text = "galaxyware";
            end;
        end, "Change-UI-Name");

        Elements.Textboxes.Name = Elements.Sections.UI:AddTextbox("Name", "galaxyware", function(t)
            if UI.flags["Change-UI-Name"] then
                Elements.Window.NameLabel.Text = t;
            end;
        end, "UI-Name");

        Elements.Colorpickers.AccentColor1 = Elements.Sections.UI:AddColorpicker("Accent Color 1", Theme.accentcolor, function(t)
            Theme.accentcolor = t;
            Elements.Window:UpdateTheme();
            Elements.Watermark:UpdateTheme();
        end);
        
        Elements.Colorpickers.AccentColor2 = Elements.Sections.UI:AddColorpicker("Accent Color 2", Theme.accentcolor2, function(t)
            Theme.accentcolor2 = t;
            Elements.Window:UpdateTheme();
            Elements.Watermark:UpdateTheme();
        end);
        
        Elements.Colorpickers.TopColor1 = Elements.Sections.UI:AddColorpicker("Top Color 1", Theme.topcolor, function(t)
            Theme.topcolor = t;
            Elements.Window:UpdateTheme();
            Elements.Watermark:UpdateTheme();
        end);
        
        Elements.Colorpickers.TopColor2 = Elements.Sections.UI:AddColorpicker("Top Color 2", Theme.topcolor2, function(t)
            Theme.topcolor2 = t;
            Elements.Window:UpdateTheme();
            Elements.Watermark:UpdateTheme();
        end);
        
        Elements.Colorpickers.BackgroundColor = Elements.Sections.UI:AddColorpicker("Background Color", Theme.backgroundcolor, function(t)
            Theme.backgroundcolor = t;
            Elements.Window:UpdateTheme();
            Elements.Watermark:UpdateTheme();
        end);
    end;

    Elements.Tabs.Settings:CreateConfigSystem("Right");

    TestService:Message("<font color='rgb(75, 96, 191)'>Created Settings Tab.</font>");
else
    Elements.Watermark = UI:CreateWatermark("galaxy-ware | v1 | {game} | {fps}");

    -- Tabs --

    Elements.Tabs.Game = Elements.Window:CreateTab("Task Force");
    Elements.Tabs.Visuals = Elements.Window:CreateTab("Visuals");
    Elements.Tabs.Settings = Elements.Window:CreateTab("Settings");

    -- Game --

    Elements.Sections.Game = Elements.Tabs.Game:CreateSector("Exploits", "Left"); do
        Elements.Sections.Game:AddButton("Restore Mags", function(t)
            for i,v in pairs(Player.Backpack.System.Mags:GetChildren()) do
                v.Value = 30
            end
        end);

        Elements.Sections.Game:AddButton("Revive TeamMates", function(t)
            for _,p in pairs(Players:GetPlayers()) do
                game.ReplicatedStorage.Event:FireServer("Revive", p);
            end
        end);

        Elements.Toggles.Godmode = Elements.Sections.Game:AddToggle("Godmode", false, nil, "Godmode");

        Elements.Sections.Game:AddToggle("Anti 096 Trigger", false, nil, "096");
    
        Elements.Sections.Game:AddToggle("Anti 939 Trigger", false, nil, "939");

        Elements.Sections.Game:AddKeybind("Heal", Enum.KeyCode.Y, nil, function()
            for i=1,2 do
                game.ReplicatedStorage.Event:FireServer("Heal");
            end
        end)

        Elements.Sections.Game:AddKeybind("Restore Mags", Enum.KeyCode.U, nil, function()
            for i,v in pairs(Player.Backpack.System.Mags:GetChildren()) do
                v.Value = 30
            end
        end)
    end

    -- Visuals --

    Elements.Sections.ESP = Elements.Tabs.Visuals:CreateSector("ESP", "Left"); do
	    Elements.Sections.ESP:AddToggle("Enabled", false, function(t)
		    ESP.Enabled = t
	    end);

	    Elements.Sections.ESP:AddToggle("Names", false, function(t)
		    ESP.Names = t
	    end);

	    Elements.Sections.ESP:AddToggle("Boxes", false, function(t)
		    ESP.Boxes = t
	    end);

	    Elements.Sections.ESP:AddToggle("Tracers", false, function(t)
		    ESP.Tracers = t
        end);

	    Elements.Sections.ESP:AddColorpicker("Color", Theme.accentcolor, function(t)
            ESP.Color = t
        end);
    end

    TestService:Message("<font color='rgb(75, 96, 191)'>Created Visuals Tab.</font>");

    -- Settings --

    Elements.Sections.UI = Elements.Tabs.Settings:CreateSector("UI", "Left"); do
        Elements.Sections.UI:AddKeybind("Toggle UI", Enum.KeyCode.RightShift, nil, function(t)
            if Elements.Window.Frame.Visible == true then
                Elements.Window.Frame.Visible = false;
            else
                Elements.Window.Frame.Visible = true;
            end;
        end);

        Elements.Toggles.ChangeName = Elements.Sections.UI:AddToggle("Change UI Name", false, function(t)
            if t then
                Elements.Window.NameLabel.Text = UI.flags["UI-Name"];
            else
                Elements.Window.NameLabel.Text = "galaxyware";
            end;
        end, "Change-UI-Name");

        Elements.Textboxes.Name = Elements.Sections.UI:AddTextbox("Name", "galaxyware", function(t)
            if UI.flags["Change-UI-Name"] then
                Elements.Window.NameLabel.Text = t;
            end;
        end, "UI-Name");

        Elements.Colorpickers.AccentColor1 = Elements.Sections.UI:AddColorpicker("Accent Color 1", Theme.accentcolor, function(t)
            Theme.accentcolor = t;
            Elements.Window:UpdateTheme();
            Elements.Watermark:UpdateTheme();
        end);
        
        Elements.Colorpickers.AccentColor2 = Elements.Sections.UI:AddColorpicker("Accent Color 2", Theme.accentcolor2, function(t)
            Theme.accentcolor2 = t;
            Elements.Window:UpdateTheme();
            Elements.Watermark:UpdateTheme();
        end);
        
        Elements.Colorpickers.TopColor1 = Elements.Sections.UI:AddColorpicker("Top Color 1", Theme.topcolor, function(t)
            Theme.topcolor = t;
            Elements.Window:UpdateTheme();
            Elements.Watermark:UpdateTheme();
        end);
        
        Elements.Colorpickers.TopColor2 = Elements.Sections.UI:AddColorpicker("Top Color 2", Theme.topcolor2, function(t)
            Theme.topcolor2 = t;
            Elements.Window:UpdateTheme();
            Elements.Watermark:UpdateTheme();
        end);
        
        Elements.Colorpickers.BackgroundColor = Elements.Sections.UI:AddColorpicker("Background Color", Theme.backgroundcolor, function(t)
            Theme.backgroundcolor = t;
            Elements.Window:UpdateTheme();
            Elements.Watermark:UpdateTheme();
        end);
    end;

    Elements.Tabs.Settings:CreateConfigSystem("Right");

    TestService:Message("<font color='rgb(75, 96, 191)'>Created Settings Tab.</font>");

    Event = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
        local args = {...};
        local method = getnamecallmethod();
     
        if not checkcaller() and tostring(self) == "Event" and method == "FireServer" then
            if args[1] == "Trigger096" and UI.flags[096] then
                return
            elseif args[1] == "Alert939" and UI.flags[939] then
                return
            end
        end

        return Event(self, ...);
    end))

    while task.wait() do
        if(UI.flags.Godmode) then
            ReplicatedStorage.Event:FireServer("Heal");
        end
    end
end
