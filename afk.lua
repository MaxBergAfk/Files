local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Window = OrionLib:MakeWindow({Name = "Emergency Hamburg | Dev Version", HidePremium = false, SaveConfig = true, ConfigFolder = "OrionTest"})


local PlayerTab = Window:MakeTab({
	Name = "Player",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local VehicleTab = Window:MakeTab({
	Name = "Vehicle",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local CrimeTab = Window:MakeTab({
	Name = "Crime",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local TeleportsTab = Window:MakeTab({
	Name = "Teleports",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})


TeleportsTab:AddButton({
	Name = "Ares Tank",
	Callback = function()
      		print("button pressed")
  	end    
})

TeleportsTab:AddButton({
	Name = "Gas N Go Tank",
	Callback = function()
      		print("button pressed")
  	end    
})

TeleportsTab:AddButton({
	Name = "Osso Tank",
	Callback = function()
      		print("button pressed")
  	end    
})

TeleportsTab:AddButton({
	Name = "Tool Shop",
	Callback = function()
      		print("button pressed")
  	end    
})

TeleportsTab:AddButton({
	Name = "Farm Shop",
	Callback = function()
      		print("button pressed")
  	end    
})

TeleportsTab:AddButton({
	Name = "Clothing Shop",
	Callback = function()
      		print("button pressed")
  	end    
})

TeleportsTab:AddButton({
	Name = "Club",
	Callback = function()
      		print("button pressed")
  	end    
})

TeleportsTab:AddButton({
	Name = "Bank",
	Callback = function()
      		print("button pressed")
  	end    
})

TeleportsTab:AddButton({
	Name = "Juwelier",
	Callback = function()
      		print("button pressed")
  	end    
})

CrimeTab:AddLabel("ESP")

-- Lokaler Spieler
local localPlayer = game.Players.LocalPlayer

-- Name ESP Variablen
local nameESPActive = false
local nameESPTexts = {}

-- Funktion zum Erstellen des Name ESP
local function createNameESP(player)
    local character = player.Character
    if not character then return end

    local head = character:FindFirstChild("Head")
    if not head then return end

    -- Erstelle Text für den Namen
    local nameLabel = Drawing.new("Text")
    nameLabel.Text = player.Name
    nameLabel.Color = Color3.fromRGB(255, 255, 255) -- Farbe des Textes (Weiß)
    nameLabel.Size = 16 -- Schriftgröße
    nameLabel.Outline = true -- Umriss
    nameLabel.Transparency = 1 -- Transparenz (1 ist vollständig sichtbar)

    -- Update der Position des Namens
    local updateConnection
    updateConnection = game:GetService("RunService").RenderStepped:Connect(function()
        if character and head and nameESPActive then
            local headPos = head.Position
            local screenPos, onScreen = game.Workspace.CurrentCamera:WorldToViewportPoint(headPos)

            if onScreen then
                nameLabel.Position = Vector2.new(screenPos.X, screenPos.Y)
                nameLabel.Visible = true
            else
                nameLabel.Visible = false
            end
        else
            nameLabel.Visible = false
        end
    end)

    table.insert(nameESPTexts, {label = nameLabel, connection = updateConnection})
end

-- Name ESP aktivieren/deaktivieren
local function toggleNameESP()
    nameESPActive = not nameESPActive

    if nameESPActive then
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= localPlayer then
                createNameESP(player)
            end
        end
    else
        -- Alle Namenslabels löschen, wenn Name ESP deaktiviert ist
        for _, nameESP in pairs(nameESPTexts) do
            nameESP.label:Remove()
            nameESP.connection:Disconnect()
        end
        nameESPTexts = {}
    end
end

CrimeTab:AddButton({
	Name = "Name ESP",
	Callback = function()
        toggleNameESP()
  	end    
})

local localPlayer = game.Players.LocalPlayer

-- ESP Variablen
local espActive = false
local espLines = {}

-- Funktion zum Erstellen der ESP-Linien
local function createESP(player)
    local character = player.Character
    if not character then return end

    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return end

    local line = Drawing.new("Line")
    line.Color = Color3.fromRGB(255, 255, 255) -- Farbe der Linien (Rot)
    line.Thickness = 2 -- Dicke der Linien
    line.Transparency = 1 -- Transparenz (1 ist vollständig sichtbar)

    -- Update der Positionen
    local updateConnection
    updateConnection = game:GetService("RunService").RenderStepped:Connect(function()
        if character and rootPart and espActive then
            local rootPos = rootPart.Position
            local screenPos, onScreen = game.Workspace.CurrentCamera:WorldToViewportPoint(rootPos)

            if onScreen then
                localPlayerPos = game.Workspace.CurrentCamera:WorldToViewportPoint(localPlayer.Character.HumanoidRootPart.Position)
                line.From = Vector2.new(localPlayerPos.X, localPlayerPos.Y) -- Startposition (Lokaler Spieler)
                line.To = Vector2.new(screenPos.X, screenPos.Y) -- Zielposition (Gegner)
                line.Visible = true
            else
                line.Visible = false
            end
        else
            line.Visible = false
        end
    end)

    table.insert(espLines, {line = line, connection = updateConnection})
end

-- ESP aktivieren/deaktivieren
local function toggleESP()
    espActive = not espActive

    if espActive then
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= localPlayer then
                createESP(player)
            end
        end
    else
        -- Alle Linien löschen, wenn ESP deaktiviert ist
        for _, espLine in pairs(espLines) do
            espLine.line:Remove()
            espLine.connection:Disconnect()
        end
        espLines = {}
    end
end

CrimeTab:AddButton({
	Name = "Lines ESP",
	Callback = function()
        toggleESP()
  	end    
})

-- Funktion, um den Spieler voll zu heilen
local function FullHeal()
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("Humanoid") then
        local humanoid = player.Character.Humanoid
        humanoid.Health = humanoid.MaxHealth
    end
end

-- Funktion zum Zurücksetzen des Charakters
local function ResetCharacter()
    local player = game.Players.LocalPlayer
    if player and player.Character then
        player.Character:BreakJoints() -- Dies zwingt den Charakter zum "Respawn"
    end
end

PlayerTab:AddButton({
	Name = "Full Heal",
	Callback = function()
        FullHeal()
  	end    
})

PlayerTab:AddButton({
	Name = "Reset Character",
	Callback = function()
        ResetCharacter()
  	end    
})

local Player = game:GetService'Players'.LocalPlayer;
local UIS = game:GetService'UserInputService';

PlayerTab:AddButton({
	Name = "Infinity Jump",
	Callback = function()
        _G.JumpHeight = 50;
        function Action(Object, Function) if Object ~= nil then Function(Object); end end

        UIS.InputBegan:connect(function(UserInput)
            if UserInput.UserInputType == Enum.UserInputType.Keyboard and UserInput.KeyCode == Enum.KeyCode.Space then
                Action(Player.Character.Humanoid, function(self)
                    if self:GetState() == Enum.HumanoidStateType.Jumping or self:GetState() == Enum.HumanoidStateType.Freefall then
                        Action(self.Parent.HumanoidRootPart, function(self)
                            self.Velocity = Vector3.new(0, _G.JumpHeight, 0);
                        end)
                    end
                end)
            end
        end)
  	end    
})
