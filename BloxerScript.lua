local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

local function hasFileFunctions()
    return type(writefile) == "function" and type(readfile) == "function" and type(isfile) == "function" and type(delfile) == "function"
end

local function SaveToFile(filename, data)
    if hasFileFunctions() then
        local json = HttpService:JSONEncode(data)
        writefile(filename, json)
        return true
    else
        warn("File functions not available, saving to memory only (will be lost on restart)")
        return false
    end
end

local function LoadFromFile(filename)
    if hasFileFunctions() and isfile(filename) then
        local json = readfile(filename)
        return HttpService:JSONDecode(json)
    end
    return nil
end

local function DeleteFile(filename)
    if hasFileFunctions() and isfile(filename) then
        delfile(filename)
        return true
    end
    return false
end

local LANGUAGES = {
    English = {
        Title = "⚡ Bloxer Script",
        TabMain = "Main",
        TabSettings = "Settings",
        ESP = "ESP",
        Noclip = "Noclip",
        InfinityJump = "Infinity Jump",
        Fly = "Fly",
        WalkSpeed = "WalkSpeed",
        ESP_ON = "ESP ON",
        ESP_OFF = "ESP OFF",
        NOCLIP_ON = "NOCLIP ON",
        NOCLIP_OFF = "NOCLIP OFF",
        JUMP_ON = "JUMP ON",
        JUMP_OFF = "JUMP OFF",
        FLY_ON = "FLY ON",
        FLY_OFF = "FLY OFF",
        Apply = "Apply",
        Reset = "Reset",
        Hotkey = "Hotkey",
        Language = "Language",
        SaveSlots = "Save Slots (3 max)",
        Save = "Save",
        Load = "Load",
        Delete = "Delete",
        Empty = "Empty",
        Saved = "Saved",
        LangEnglish = "English",
        LangRussian = "Russian",
        LangChinese = "Chinese",
        LoadingTitle = "⚡ Bloxer Script",
        Disclaimer = "The creator is not responsible for any bans in the game. Good luck!",
        Yes = "Yes",
        No = "No",
        FlySpeedPlaceholder = "Fly Speed",
        WalkSpeedPlaceholder = "Walk Speed",
        HotkeyPlaceholder = "Enter key",
    },
    Russian = {
        Title = "⚡ Bloxer Script",
        TabMain = "Основное",
        TabSettings = "Настройки",
        ESP = "ESP",
        Noclip = "Ноклип",
        InfinityJump = "Бесконечный прыжок",
        Fly = "Полет",
        WalkSpeed = "Скорость ходьбы",
        ESP_ON = "ESP ВКЛ",
        ESP_OFF = "ESP ВЫКЛ",
        NOCLIP_ON = "НОКЛИП ВКЛ",
        NOCLIP_OFF = "НОКЛИП ВЫКЛ",
        JUMP_ON = "ПРЫЖОК ВКЛ",
        JUMP_OFF = "ПРЫЖОК ВЫКЛ",
        FLY_ON = "ПОЛЕТ ВКЛ",
        FLY_OFF = "ПОЛЕТ ВЫКЛ",
        Apply = "Применить",
        Reset = "Сбросить",
        Hotkey = "Горячая клавиша",
        Language = "Язык",
        SaveSlots = "Слоты сохранения (макс. 3)",
        Save = "Сохранить",
        Load = "Загрузить",
        Delete = "Удалить",
        Empty = "Пусто",
        Saved = "Сохранено",
        LangEnglish = "Английский",
        LangRussian = "Русский",
        LangChinese = "Китайский",
        LoadingTitle = "⚡ Bloxer Script",
        Disclaimer = "Создатель не несет ответственности за любые баны в игре. Удачи!",
        Yes = "Да",
        No = "Нет",
        FlySpeedPlaceholder = "Скорость полета",
        WalkSpeedPlaceholder = "Скорость ходьбы",
        HotkeyPlaceholder = "Введите клавишу",
    },
    Chinese = {
        Title = "⚡ Bloxer Script",
        TabMain = "主要",
        TabSettings = "设置",
        ESP = "ESP",
        Noclip = "无碰撞",
        InfinityJump = "无限跳跃",
        Fly = "飞行",
        WalkSpeed = "行走速度",
        ESP_ON = "ESP 开",
        ESP_OFF = "ESP 关",
        NOCLIP_ON = "无碰撞 开",
        NOCLIP_OFF = "无碰撞 关",
        JUMP_ON = "跳跃 开",
        JUMP_OFF = "跳跃 关",
        FLY_ON = "飞行 开",
        FLY_OFF = "飞行 关",
        Apply = "应用",
        Reset = "重置",
        Hotkey = "快捷键",
        Language = "语言",
        SaveSlots = "保存槽位 (最多3个)",
        Save = "保存",
        Load = "加载",
        Delete = "删除",
        Empty = "空",
        Saved = "已保存",
        LangEnglish = "英语",
        LangRussian = "俄语",
        LangChinese = "中文",
        LoadingTitle = "⚡ Bloxer Script",
        Disclaimer = "创作者对游戏中的任何封禁概不负责。祝好运！",
        Yes = "是",
        No = "否",
        FlySpeedPlaceholder = "飞行速度",
        WalkSpeedPlaceholder = "行走速度",
        HotkeyPlaceholder = "输入键位",
    }
}

local CURRENT_LANG = "English"
local function T(key) return LANGUAGES[CURRENT_LANG][key] or key end

-- ========== LOADING SCREEN ==========
local LoaderGui = Instance.new("ScreenGui")
LoaderGui.Name = "LoaderGUI"
LoaderGui.ResetOnSpawn = false
LoaderGui.IgnoreGuiInset = true
LoaderGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local Bg = Instance.new("Frame")
Bg.Size = UDim2.new(1, 0, 1, 0)
Bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Bg.BackgroundTransparency = 0
Bg.BorderSizePixel = 0
Bg.Parent = LoaderGui

local TitleLoad = Instance.new("TextLabel")
TitleLoad.Size = UDim2.new(1, 0, 0, 80)
TitleLoad.Position = UDim2.new(0, 0, 0.2, 0)
TitleLoad.BackgroundTransparency = 1
TitleLoad.Text = T("LoadingTitle")
TitleLoad.TextColor3 = Color3.fromRGB(200, 200, 200)
TitleLoad.TextSize = 48
TitleLoad.Font = Enum.Font.GothamBold
TitleLoad.TextScaled = true
TitleLoad.Parent = Bg

local ProgBg = Instance.new("Frame")
ProgBg.Size = UDim2.new(0.6, 0, 0, 24)
ProgBg.Position = UDim2.new(0.2, 0, 0.45, 0)
ProgBg.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ProgBg.BorderSizePixel = 1
ProgBg.BorderColor3 = Color3.fromRGB(60, 60, 60)
ProgBg.Parent = Bg
local ProgBgCorner = Instance.new("UICorner")
ProgBgCorner.CornerRadius = UDim.new(0, 6)
ProgBgCorner.Parent = ProgBg

local ProgFill = Instance.new("Frame")
ProgFill.Size = UDim2.new(0, 0, 1, 0)
ProgFill.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
ProgFill.BorderSizePixel = 0
ProgFill.Parent = ProgBg
local ProgFillCorner = Instance.new("UICorner")
ProgFillCorner.CornerRadius = UDim.new(0, 6)
ProgFillCorner.Parent = ProgFill

local ProgText = Instance.new("TextLabel")
ProgText.Size = UDim2.new(0.6, 0, 0, 30)
ProgText.Position = UDim2.new(0.2, 0, 0.5, 0)
ProgText.BackgroundTransparency = 1
ProgText.Text = "0%"
ProgText.TextColor3 = Color3.fromRGB(200, 200, 200)
ProgText.TextSize = 18
ProgText.Font = Enum.Font.GothamBold
ProgText.Parent = Bg

-- ========== DISCLAIMER ==========
local DisFrame = Instance.new("Frame")
DisFrame.Size = UDim2.new(0.8, 0, 0, 200)
DisFrame.Position = UDim2.new(0.1, 0, 0.5, 0)
DisFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
DisFrame.BorderSizePixel = 1
DisFrame.BorderColor3 = Color3.fromRGB(40, 40, 40)
DisFrame.Visible = false
DisFrame.Parent = Bg
local DisCorner = Instance.new("UICorner")
DisCorner.CornerRadius = UDim.new(0, 12)
DisCorner.Parent = DisFrame

local DisLabel = Instance.new("TextLabel")
DisLabel.Size = UDim2.new(1, -20, 1, -80)
DisLabel.Position = UDim2.new(0, 10, 0, 10)
DisLabel.BackgroundTransparency = 1
DisLabel.Text = T("Disclaimer")
DisLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
DisLabel.TextSize = 20
DisLabel.Font = Enum.Font.GothamBold
DisLabel.TextWrapped = true
DisLabel.TextScaled = true
DisLabel.Parent = DisFrame

local YesBtn = Instance.new("TextButton")
YesBtn.Size = UDim2.new(0.25, -10, 0, 40)
YesBtn.Position = UDim2.new(0.15, 0, 1, -50)
YesBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
YesBtn.Text = T("Yes")
YesBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
YesBtn.TextSize = 18
YesBtn.Font = Enum.Font.GothamBold
YesBtn.BorderSizePixel = 0
YesBtn.Parent = DisFrame
local YesCorner = Instance.new("UICorner")
YesCorner.CornerRadius = UDim.new(0, 8)
YesCorner.Parent = YesBtn

local NoBtn = Instance.new("TextButton")
NoBtn.Size = UDim2.new(0.25, -10, 0, 40)
NoBtn.Position = UDim2.new(0.6, 0, 1, -50)
NoBtn.BackgroundColor3 = Color3.fromRGB(60, 20, 20)
NoBtn.Text = T("No")
NoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
NoBtn.TextSize = 18
NoBtn.Font = Enum.Font.GothamBold
NoBtn.BorderSizePixel = 0
NoBtn.Parent = DisFrame
local NoCorner = Instance.new("UICorner")
NoCorner.CornerRadius = UDim.new(0, 8)
NoCorner.Parent = NoBtn

YesBtn.MouseEnter:Connect(function()
    TweenService:Create(YesBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
end)
YesBtn.MouseLeave:Connect(function()
    TweenService:Create(YesBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
end)
NoBtn.MouseEnter:Connect(function()
    TweenService:Create(NoBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(80, 30, 30)}):Play()
end)
NoBtn.MouseLeave:Connect(function()
    TweenService:Create(NoBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 20, 20)}):Play()
end)

-- ========== LOADING ANIMATION ==========
local function StartLoading()
    local duration = 5
    local steps = 100
    local stepTime = duration / steps
    for i = 1, steps do
        local percent = i / steps * 100
        ProgFill.Size = UDim2.new(percent / 100, 0, 1, 0)
        ProgText.Text = math.floor(percent) .. "%"
        task.wait(stepTime)
    end
    ProgFill.Size = UDim2.new(1, 0, 1, 0)
    ProgText.Text = "100%"
    ProgBg.Visible = false
    ProgText.Visible = false
    DisFrame.Visible = true
end

coroutine.wrap(StartLoading)()

-- ========== BUTTONS ==========
YesBtn.MouseButton1Click:Connect(function()
    local s = Instance.new("Sound")
    s.SoundId = "rbxassetid://9120372170"
    s.Volume = 0.5
    s.Parent = SoundService
    s:Play()
    task.delay(s.TimeLength + 0.1, function() s:Destroy() end)
    LoaderGui:Destroy()
    Main()
end)

NoBtn.MouseButton1Click:Connect(function()
    local s = Instance.new("Sound")
    s.SoundId = "rbxassetid://9120372170"
    s.Volume = 0.5
    s.Parent = SoundService
    s:Play()
    task.delay(s.TimeLength + 0.1, function() s:Destroy() end)
    LoaderGui:Destroy()
    print("User declined.")
end)

-- ============================================================
-- ===== MAIN SCRIPT ==========================================
-- ============================================================
function Main()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local RunService = game:GetService("RunService")
    local TweenService = game:GetService("TweenService")
    local SoundService = game:GetService("SoundService")
    local UserInputService = game:GetService("UserInputService")
    local Camera = workspace.CurrentCamera

    -- ===== SETTINGS =====
    local ESP_ENABLED = false
    local NOCLIP_ENABLED = false
    local FLY_ENABLED = false
    local INFINITY_JUMP_ENABLED = false
    local FLY_SPEED = 50
    local WALK_SPEED = 16
    local UPDATE_INTERVAL = 0.15
    local SOUND_VOLUME = 0.5
    local SOUND_ENABLED = true
    local MAX_DISTANCE = 1000

    local HOTKEY = Enum.KeyCode.K
    local HotkeyConnection = nil

    -- ===== ДОБАВЛЕНО: функция применения скорости =====
    local function ApplyWalkSpeed()
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChild("Humanoid")
            if hum then
                hum.WalkSpeed = WALK_SPEED
            end
        end
    end

    -- ===== SOUND =====
    local function PlayClick()
        if not SOUND_ENABLED then return end
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://9120372170"
        sound.Volume = SOUND_VOLUME
        sound.Parent = SoundService
        sound:Play()
        task.delay(sound.TimeLength + 0.1, function() sound:Destroy() end)
    end

    -- ===== CREATE MAIN GUI =====
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "BloxerScriptGUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

    local MainPanel = Instance.new("Frame")
    MainPanel.Name = "MainPanel"
    MainPanel.Size = UDim2.new(0, 360, 0, 580)
    MainPanel.Position = UDim2.new(0.5, -180, 0.5, -290)
    MainPanel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    MainPanel.BackgroundTransparency = 0
    MainPanel.BorderSizePixel = 1
    MainPanel.BorderColor3 = Color3.fromRGB(40, 40, 40)
    MainPanel.Active = true
    MainPanel.Draggable = true
    MainPanel.Parent = ScreenGui
    local PanelCorner = Instance.new("UICorner")
    PanelCorner.CornerRadius = UDim.new(0, 12)
    PanelCorner.Parent = MainPanel

    -- ===== TITLE BAR =====
    local TitleBar = Instance.new("Frame")
    TitleBar.Size = UDim2.new(1, 0, 0, 38)
    TitleBar.Position = UDim2.new(0, 0, 0, 0)
    TitleBar.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    TitleBar.BackgroundTransparency = 0
    TitleBar.BorderSizePixel = 0
    TitleBar.Parent = MainPanel
    local TitleCorner = Instance.new("UICorner")
    TitleCorner.CornerRadius = UDim.new(0, 12)
    TitleCorner.Parent = TitleBar

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, -90, 1, 0)
    TitleLabel.Position = UDim2.new(0, 15, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = T("Title")
    TitleLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    TitleLabel.TextSize = 17
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = TitleBar

    local MinBtn = Instance.new("TextButton")
    MinBtn.Size = UDim2.new(0, 28, 0, 28)
    MinBtn.Position = UDim2.new(1, -36, 0, 5)
    MinBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MinBtn.Text = "─"
    MinBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    MinBtn.TextSize = 18
    MinBtn.Font = Enum.Font.GothamBold
    MinBtn.BorderSizePixel = 0
    MinBtn.Parent = TitleBar
    local MinCorner = Instance.new("UICorner")
    MinCorner.CornerRadius = UDim.new(1, 0)
    MinCorner.Parent = MinBtn

    local DestroyBtn = Instance.new("TextButton")
    DestroyBtn.Size = UDim2.new(0, 28, 0, 28)
    DestroyBtn.Position = UDim2.new(1, -68, 0, 5)
    DestroyBtn.BackgroundColor3 = Color3.fromRGB(60, 15, 15)
    DestroyBtn.Text = "✕"
    DestroyBtn.TextColor3 = Color3.fromRGB(200, 150, 150)
    DestroyBtn.TextSize = 15
    DestroyBtn.Font = Enum.Font.GothamBold
    DestroyBtn.BorderSizePixel = 0
    DestroyBtn.Parent = TitleBar
    local DestroyCorner = Instance.new("UICorner")
    DestroyCorner.CornerRadius = UDim.new(1, 0)
    DestroyCorner.Parent = DestroyBtn

    local OpenBtn = Instance.new("TextButton")
    OpenBtn.Name = "OpenBtn"
    OpenBtn.Size = UDim2.new(0, 64, 0, 64)
    OpenBtn.Position = UDim2.new(0.02, 0, 0.85, 0)
    OpenBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    OpenBtn.Text = "⚡"
    OpenBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    OpenBtn.TextSize = 32
    OpenBtn.Font = Enum.Font.GothamBold
    OpenBtn.Visible = false
    OpenBtn.BorderSizePixel = 1
    OpenBtn.BorderColor3 = Color3.fromRGB(40, 40, 40)
    OpenBtn.Parent = ScreenGui
    local OpenCorner = Instance.new("UICorner")
    OpenCorner.CornerRadius = UDim.new(1, 0)
    OpenCorner.Parent = OpenBtn

    MinBtn.MouseButton1Click:Connect(function()
        PlayClick()
        MainPanel.Visible = false
        OpenBtn.Visible = true
    end)

    OpenBtn.MouseButton1Click:Connect(function()
        PlayClick()
        MainPanel.Visible = true
        OpenBtn.Visible = false
    end)

    -- ===== ВКЛАДКИ =====
    local TabBar = Instance.new("Frame")
    TabBar.Size = UDim2.new(1, 0, 0, 28)
    TabBar.Position = UDim2.new(0, 0, 0, 38)
    TabBar.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    TabBar.BackgroundTransparency = 0
    TabBar.BorderSizePixel = 0
    TabBar.Parent = MainPanel

    local TabMain = Instance.new("TextButton")
    TabMain.Size = UDim2.new(0.5, 0, 1, 0)
    TabMain.Position = UDim2.new(0, 0, 0, 0)
    TabMain.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    TabMain.Text = T("TabMain")
    TabMain.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabMain.TextSize = 12
    TabMain.Font = Enum.Font.GothamBold
    TabMain.BorderSizePixel = 0
    TabMain.Parent = TabBar
    local TabMainCorner = Instance.new("UICorner")
    TabMainCorner.CornerRadius = UDim.new(0, 0)
    TabMainCorner.Parent = TabMain

    local TabSettings = Instance.new("TextButton")
    TabSettings.Size = UDim2.new(0.5, 0, 1, 0)
    TabSettings.Position = UDim2.new(0.5, 0, 0, 0)
    TabSettings.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    TabSettings.Text = T("TabSettings")
    TabSettings.TextColor3 = Color3.fromRGB(200, 200, 200)
    TabSettings.TextSize = 12
    TabSettings.Font = Enum.Font.GothamBold
    TabSettings.BorderSizePixel = 0
    TabSettings.Parent = TabBar
    local TabSettingsCorner = Instance.new("UICorner")
    TabSettingsCorner.CornerRadius = UDim.new(0, 0)
    TabSettingsCorner.Parent = TabSettings

    local ScrollContainer = Instance.new("ScrollingFrame")
    ScrollContainer.Name = "ScrollContainer"
    ScrollContainer.Size = UDim2.new(1, -20, 1, -52 - 28)
    ScrollContainer.Position = UDim2.new(0, 10, 0, 42 + 28)
    ScrollContainer.BackgroundTransparency = 1
    ScrollContainer.BorderSizePixel = 0
    ScrollContainer.ScrollBarThickness = 4
    ScrollContainer.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 60)
    ScrollContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
    ScrollContainer.Parent = MainPanel

    local MainPage = Instance.new("Frame")
    MainPage.Size = UDim2.new(1, 0, 0, 0)
    MainPage.BackgroundTransparency = 1
    MainPage.Visible = true
    MainPage.Parent = ScrollContainer
    local MainLayout = Instance.new("UIListLayout")
    MainLayout.SortOrder = Enum.SortOrder.LayoutOrder
    MainLayout.Padding = UDim.new(0, 2)
    MainLayout.Parent = MainPage

    local SettingsPage = Instance.new("Frame")
    SettingsPage.Size = UDim2.new(1, 0, 0, 0)
    SettingsPage.BackgroundTransparency = 1
    SettingsPage.Visible = false
    SettingsPage.Parent = ScrollContainer
    local SettingsLayout = Instance.new("UIListLayout")
    SettingsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    SettingsLayout.Padding = UDim.new(0, 6)
    SettingsLayout.Parent = SettingsPage

    local function UpdateCanvas()
        local total = 0
        local visiblePage = MainPage.Visible and MainPage or SettingsPage.Visible and SettingsPage
        if visiblePage then
            for _, child in ipairs(visiblePage:GetChildren()) do
                if child:IsA("Frame") then
                    local layout = visiblePage:FindFirstChild("UIListLayout")
                    local padding = layout and layout.Padding.Offset or 0
                    total = total + child.Size.Y.Offset + padding
                end
            end
            ScrollContainer.CanvasSize = UDim2.new(0, 0, 0, total + 10)
        else
            ScrollContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
        end
    end

    local function SwitchTab(tab)
        if tab == "Main" then
            MainPage.Visible = true
            SettingsPage.Visible = false
            TabMain.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
            TabMain.TextColor3 = Color3.fromRGB(255, 255, 255)
            TabSettings.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
            TabSettings.TextColor3 = Color3.fromRGB(200, 200, 200)
        else
            MainPage.Visible = false
            SettingsPage.Visible = true
            TabSettings.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
            TabSettings.TextColor3 = Color3.fromRGB(255, 255, 255)
            TabMain.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
            TabMain.TextColor3 = Color3.fromRGB(200, 200, 200)
        end
        UpdateCanvas()
    end

    TabMain.MouseButton1Click:Connect(function()
        PlayClick()
        SwitchTab("Main")
    end)

    TabSettings.MouseButton1Click:Connect(function()
        PlayClick()
        SwitchTab("Settings")
    end)

    -- ===== СЕКЦИИ MAIN =====
    local EspSection = Instance.new("Frame")
    EspSection.Size = UDim2.new(1, 0, 0, 45)
    EspSection.BackgroundTransparency = 1
    EspSection.Parent = MainPage
    EspSection.LayoutOrder = 1

    local EspLabel = Instance.new("TextLabel")
    EspLabel.Size = UDim2.new(0.5, 0, 0, 16)
    EspLabel.Position = UDim2.new(0, 0, 0, 0)
    EspLabel.BackgroundTransparency = 1
    EspLabel.Text = T("ESP")
    EspLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
    EspLabel.TextSize = 13
    EspLabel.Font = Enum.Font.GothamBold
    EspLabel.TextXAlignment = Enum.TextXAlignment.Left
    EspLabel.Parent = EspSection

    local EspButton = Instance.new("TextButton")
    EspButton.Size = UDim2.new(1, 0, 0, 24)
    EspButton.Position = UDim2.new(0, 0, 0, 18)
    EspButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    EspButton.Text = T("ESP_OFF")
    EspButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    EspButton.TextSize = 13
    EspButton.Font = Enum.Font.GothamBold
    EspButton.BorderSizePixel = 0
    EspButton.Parent = EspSection
    local EspCorner = Instance.new("UICorner")
    EspCorner.CornerRadius = UDim.new(0, 5)
    EspCorner.Parent = EspButton
    EspButton.MouseEnter:Connect(function()
        TweenService:Create(EspButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
    end)
    EspButton.MouseLeave:Connect(function()
        TweenService:Create(EspButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
    end)

    local NoclipSection = Instance.new("Frame")
    NoclipSection.Size = UDim2.new(1, 0, 0, 45)
    NoclipSection.BackgroundTransparency = 1
    NoclipSection.Parent = MainPage
    NoclipSection.LayoutOrder = 2

    local NoclipLabel = Instance.new("TextLabel")
    NoclipLabel.Size = UDim2.new(0.5, 0, 0, 16)
    NoclipLabel.Position = UDim2.new(0, 0, 0, 0)
    NoclipLabel.BackgroundTransparency = 1
    NoclipLabel.Text = T("Noclip")
    NoclipLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
    NoclipLabel.TextSize = 13
    NoclipLabel.Font = Enum.Font.GothamBold
    NoclipLabel.TextXAlignment = Enum.TextXAlignment.Left
    NoclipLabel.Parent = NoclipSection

    local NoclipButton = Instance.new("TextButton")
    NoclipButton.Size = UDim2.new(1, 0, 0, 24)
    NoclipButton.Position = UDim2.new(0, 0, 0, 18)
    NoclipButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    NoclipButton.Text = T("NOCLIP_OFF")
    NoclipButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    NoclipButton.TextSize = 13
    NoclipButton.Font = Enum.Font.GothamBold
    NoclipButton.BorderSizePixel = 0
    NoclipButton.Parent = NoclipSection
    local NoclipCorner = Instance.new("UICorner")
    NoclipCorner.CornerRadius = UDim.new(0, 5)
    NoclipCorner.Parent = NoclipButton
    NoclipButton.MouseEnter:Connect(function()
        TweenService:Create(NoclipButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
    end)
    NoclipButton.MouseLeave:Connect(function()
        TweenService:Create(NoclipButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
    end)

    local JumpSection = Instance.new("Frame")
    JumpSection.Size = UDim2.new(1, 0, 0, 45)
    JumpSection.BackgroundTransparency = 1
    JumpSection.Parent = MainPage
    JumpSection.LayoutOrder = 3

    local JumpLabel = Instance.new("TextLabel")
    JumpLabel.Size = UDim2.new(0.5, 0, 0, 16)
    JumpLabel.Position = UDim2.new(0, 0, 0, 0)
    JumpLabel.BackgroundTransparency = 1
    JumpLabel.Text = T("InfinityJump")
    JumpLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
    JumpLabel.TextSize = 13
    JumpLabel.Font = Enum.Font.GothamBold
    JumpLabel.TextXAlignment = Enum.TextXAlignment.Left
    JumpLabel.Parent = JumpSection

    local JumpButton = Instance.new("TextButton")
    JumpButton.Size = UDim2.new(1, 0, 0, 24)
    JumpButton.Position = UDim2.new(0, 0, 0, 18)
    JumpButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    JumpButton.Text = T("JUMP_OFF")
    JumpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    JumpButton.TextSize = 13
    JumpButton.Font = Enum.Font.GothamBold
    JumpButton.BorderSizePixel = 0
    JumpButton.Parent = JumpSection
    local JumpCorner = Instance.new("UICorner")
    JumpCorner.CornerRadius = UDim.new(0, 5)
    JumpCorner.Parent = JumpButton
    JumpButton.MouseEnter:Connect(function()
        TweenService:Create(JumpButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
    end)
    JumpButton.MouseLeave:Connect(function()
        TweenService:Create(JumpButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
    end)

    local FlySection = Instance.new("Frame")
    FlySection.Size = UDim2.new(1, 0, 0, 90)
    FlySection.BackgroundTransparency = 1
    FlySection.Parent = MainPage
    FlySection.LayoutOrder = 4

    local FlyLabel = Instance.new("TextLabel")
    FlyLabel.Size = UDim2.new(0.5, 0, 0, 16)
    FlyLabel.Position = UDim2.new(0, 0, 0, 0)
    FlyLabel.BackgroundTransparency = 1
    FlyLabel.Text = T("Fly")
    FlyLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
    FlyLabel.TextSize = 13
    FlyLabel.Font = Enum.Font.GothamBold
    FlyLabel.TextXAlignment = Enum.TextXAlignment.Left
    FlyLabel.Parent = FlySection

    local FlyButton = Instance.new("TextButton")
    FlyButton.Size = UDim2.new(1, 0, 0, 24)
    FlyButton.Position = UDim2.new(0, 0, 0, 18)
    FlyButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    FlyButton.Text = T("FLY_OFF")
    FlyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    FlyButton.TextSize = 13
    FlyButton.Font = Enum.Font.GothamBold
    FlyButton.BorderSizePixel = 0
    FlyButton.Parent = FlySection
    local FlyCorner = Instance.new("UICorner")
    FlyCorner.CornerRadius = UDim.new(0, 5)
    FlyCorner.Parent = FlyButton
    FlyButton.MouseEnter:Connect(function()
        TweenService:Create(FlyButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
    end)
    FlyButton.MouseLeave:Connect(function()
        TweenService:Create(FlyButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
    end)

    local FlySpeedInput = Instance.new("TextBox")
    FlySpeedInput.Size = UDim2.new(1, 0, 0, 22)
    FlySpeedInput.Position = UDim2.new(0, 0, 0, 44)
    FlySpeedInput.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    FlySpeedInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    FlySpeedInput.TextSize = 13
    FlySpeedInput.Font = Enum.Font.Gotham
    FlySpeedInput.Text = tostring(FLY_SPEED)
    FlySpeedInput.PlaceholderText = T("FlySpeedPlaceholder")
    FlySpeedInput.ClearTextOnFocus = false
    FlySpeedInput.BorderSizePixel = 1
    FlySpeedInput.BorderColor3 = Color3.fromRGB(40, 40, 40)
    FlySpeedInput.Parent = FlySection
    local FlyInputCorner = Instance.new("UICorner")
    FlyInputCorner.CornerRadius = UDim.new(0, 5)
    FlyInputCorner.Parent = FlySpeedInput

    local FlyBtnRow = Instance.new("Frame")
    FlyBtnRow.Size = UDim2.new(1, 0, 0, 22)
    FlyBtnRow.Position = UDim2.new(0, 0, 0, 68)
    FlyBtnRow.BackgroundTransparency = 1
    FlyBtnRow.Parent = FlySection

    local FlyApplyBtn = Instance.new("TextButton")
    FlyApplyBtn.Size = UDim2.new(0.45, -5, 1, 0)
    FlyApplyBtn.Position = UDim2.new(0, 0, 0, 0)
    FlyApplyBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    FlyApplyBtn.Text = T("Apply")
    FlyApplyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    FlyApplyBtn.TextSize = 12
    FlyApplyBtn.Font = Enum.Font.GothamBold
    FlyApplyBtn.BorderSizePixel = 0
    FlyApplyBtn.Parent = FlyBtnRow
    local FlyApplyCorner = Instance.new("UICorner")
    FlyApplyCorner.CornerRadius = UDim.new(0, 5)
    FlyApplyCorner.Parent = FlyApplyBtn
    FlyApplyBtn.MouseEnter:Connect(function()
        TweenService:Create(FlyApplyBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
    end)
    FlyApplyBtn.MouseLeave:Connect(function()
        TweenService:Create(FlyApplyBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
    end)

    local FlyResetBtn = Instance.new("TextButton")
    FlyResetBtn.Size = UDim2.new(0.45, -5, 1, 0)
    FlyResetBtn.Position = UDim2.new(0.55, 5, 0, 0)
    FlyResetBtn.BackgroundColor3 = Color3.fromRGB(60, 20, 20)
    FlyResetBtn.Text = T("Reset")
    FlyResetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    FlyResetBtn.TextSize = 12
    FlyResetBtn.Font = Enum.Font.GothamBold
    FlyResetBtn.BorderSizePixel = 0
    FlyResetBtn.Parent = FlyBtnRow
    local FlyResetCorner = Instance.new("UICorner")
    FlyResetCorner.CornerRadius = UDim.new(0, 5)
    FlyResetCorner.Parent = FlyResetBtn
    FlyResetBtn.MouseEnter:Connect(function()
        TweenService:Create(FlyResetBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(80, 30, 30)}):Play()
    end)
    FlyResetBtn.MouseLeave:Connect(function()
        TweenService:Create(FlyResetBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(60, 20, 20)}):Play()
    end)

    local WsSection = Instance.new("Frame")
    WsSection.Size = UDim2.new(1, 0, 0, 90)
    WsSection.BackgroundTransparency = 1
    WsSection.Parent = MainPage
    WsSection.LayoutOrder = 5

    local WsLabel = Instance.new("TextLabel")
    WsLabel.Size = UDim2.new(0.5, 0, 0, 16)
    WsLabel.Position = UDim2.new(0, 0, 0, 0)
    WsLabel.BackgroundTransparency = 1
    WsLabel.Text = T("WalkSpeed")
    WsLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
    WsLabel.TextSize = 13
    WsLabel.Font = Enum.Font.GothamBold
    WsLabel.TextXAlignment = Enum.TextXAlignment.Left
    WsLabel.Parent = WsSection

    local WsInput = Instance.new("TextBox")
    WsInput.Size = UDim2.new(1, 0, 0, 22)
    WsInput.Position = UDim2.new(0, 0, 0, 18)
    WsInput.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    WsInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    WsInput.TextSize = 13
    WsInput.Font = Enum.Font.Gotham
    WsInput.Text = tostring(WALK_SPEED)
    WsInput.PlaceholderText = T("WalkSpeedPlaceholder")
    WsInput.ClearTextOnFocus = false
    WsInput.BorderSizePixel = 1
    WsInput.BorderColor3 = Color3.fromRGB(40, 40, 40)
    WsInput.Parent = WsSection
    local WsInputCorner = Instance.new("UICorner")
    WsInputCorner.CornerRadius = UDim.new(0, 5)
    WsInputCorner.Parent = WsInput

    local WsBtnRow = Instance.new("Frame")
    WsBtnRow.Size = UDim2.new(1, 0, 0, 22)
    WsBtnRow.Position = UDim2.new(0, 0, 0, 44)
    WsBtnRow.BackgroundTransparency = 1
    WsBtnRow.Parent = WsSection

    local WsApplyBtn = Instance.new("TextButton")
    WsApplyBtn.Size = UDim2.new(0.45, -5, 1, 0)
    WsApplyBtn.Position = UDim2.new(0, 0, 0, 0)
    WsApplyBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    WsApplyBtn.Text = T("Apply")
    WsApplyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    WsApplyBtn.TextSize = 12
    WsApplyBtn.Font = Enum.Font.GothamBold
    WsApplyBtn.BorderSizePixel = 0
    WsApplyBtn.Parent = WsBtnRow
    local WsApplyCorner = Instance.new("UICorner")
    WsApplyCorner.CornerRadius = UDim.new(0, 5)
    WsApplyCorner.Parent = WsApplyBtn
    WsApplyBtn.MouseEnter:Connect(function()
        TweenService:Create(WsApplyBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
    end)
    WsApplyBtn.MouseLeave:Connect(function()
        TweenService:Create(WsApplyBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
    end)

    local WsResetBtn = Instance.new("TextButton")
    WsResetBtn.Size = UDim2.new(0.45, -5, 1, 0)
    WsResetBtn.Position = UDim2.new(0.55, 5, 0, 0)
    WsResetBtn.BackgroundColor3 = Color3.fromRGB(60, 20, 20)
    WsResetBtn.Text = T("Reset")
    WsResetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    WsResetBtn.TextSize = 12
    WsResetBtn.Font = Enum.Font.GothamBold
    WsResetBtn.BorderSizePixel = 0
    WsResetBtn.Parent = WsBtnRow
    local WsResetCorner = Instance.new("UICorner")
    WsResetCorner.CornerRadius = UDim.new(0, 5)
    WsResetCorner.Parent = WsResetBtn
    WsResetBtn.MouseEnter:Connect(function()
        TweenService:Create(WsResetBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(80, 30, 30)}):Play()
    end)
    WsResetBtn.MouseLeave:Connect(function()
        TweenService:Create(WsResetBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(60, 20, 20)}):Play()
    end)

    -- ===== СТРАНИЦА SETTINGS =====
    -- Hotkey
    local HotkeySection = Instance.new("Frame")
    HotkeySection.Size = UDim2.new(1, 0, 0, 70)
    HotkeySection.BackgroundTransparency = 1
    HotkeySection.Parent = SettingsPage
    HotkeySection.LayoutOrder = 1

    local HotkeyLabel = Instance.new("TextLabel")
    HotkeyLabel.Size = UDim2.new(0.5, 0, 0, 20)
    HotkeyLabel.Position = UDim2.new(0, 0, 0, 0)
    HotkeyLabel.BackgroundTransparency = 1
    HotkeyLabel.Text = T("Hotkey")
    HotkeyLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
    HotkeyLabel.TextSize = 13
    HotkeyLabel.Font = Enum.Font.GothamBold
    HotkeyLabel.TextXAlignment = Enum.TextXAlignment.Left
    HotkeyLabel.Parent = HotkeySection

    local HotkeyDisplay = Instance.new("TextButton")
    HotkeyDisplay.Size = UDim2.new(0.4, 0, 0, 28)
    HotkeyDisplay.Position = UDim2.new(0.3, 0, 0, 22)
    HotkeyDisplay.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    HotkeyDisplay.Text = "K"
    HotkeyDisplay.TextColor3 = Color3.fromRGB(255, 255, 255)
    HotkeyDisplay.TextSize = 14
    HotkeyDisplay.Font = Enum.Font.GothamBold
    HotkeyDisplay.BorderSizePixel = 1
    HotkeyDisplay.BorderColor3 = Color3.fromRGB(60, 60, 60)
    HotkeyDisplay.Parent = HotkeySection
    local HotkeyCorner = Instance.new("UICorner")
    HotkeyCorner.CornerRadius = UDim.new(0, 5)
    HotkeyCorner.Parent = HotkeyDisplay

    local HotkeyInput = Instance.new("TextBox")
    HotkeyInput.Size = HotkeyDisplay.Size
    HotkeyInput.Position = HotkeyDisplay.Position
    HotkeyInput.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    HotkeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    HotkeyInput.TextSize = 14
    HotkeyInput.Font = Enum.Font.Gotham
    HotkeyInput.Text = "K"
    HotkeyInput.PlaceholderText = T("HotkeyPlaceholder")
    HotkeyInput.ClearTextOnFocus = false
    HotkeyInput.BorderSizePixel = 1
    HotkeyInput.BorderColor3 = Color3.fromRGB(60, 60, 60)
    HotkeyInput.Visible = false
    HotkeyInput.Parent = HotkeySection
    local HotkeyInputCorner = Instance.new("UICorner")
    HotkeyInputCorner.CornerRadius = UDim.new(0, 5)
    HotkeyInputCorner.Parent = HotkeyInput

    HotkeyInput:GetPropertyChangedSignal("Text"):Connect(function()
        local text = HotkeyInput.Text
        if text and text ~= "" then
            if #text > 1 then
                text = string.sub(text, 1, 1)
                HotkeyInput.Text = text
            end
            local upper = string.upper(text)
            if upper ~= text then
                HotkeyInput.Text = upper
            end
        end
    end)

    local function SetHotkey(newKeyCode)
        HOTKEY = newKeyCode
        local keyName = HOTKEY.Name
        HotkeyDisplay.Text = keyName
        HotkeyInput.Text = keyName
        if HotkeyConnection then
            HotkeyConnection:Disconnect()
            HotkeyConnection = nil
        end
        HotkeyConnection = UserInputService.InputBegan:Connect(function(input, gp)
            if gp then return end
            if input.KeyCode == HOTKEY then
                PlayClick()
                if MainPanel.Visible then
                    MainPanel.Visible = false
                    OpenBtn.Visible = true
                else
                    MainPanel.Visible = true
                    OpenBtn.Visible = false
                end
            end
        end)
        print("Hotkey changed to " .. keyName)
    end

    HotkeyDisplay.MouseButton1Click:Connect(function()
        PlayClick()
        HotkeyDisplay.Visible = false
        HotkeyInput.Visible = true
        HotkeyInput:CaptureFocus()
        HotkeyInput.Text = ""
        HotkeyInput.PlaceholderText = T("HotkeyPlaceholder")
    end)

    HotkeyInput.FocusLost:Connect(function(enterPressed)
        local inputText = HotkeyInput.Text
        if inputText and inputText ~= "" then
            local keyName = string.upper(string.sub(inputText, 1, 1))
            local success, keyCode = pcall(function()
                return Enum.KeyCode[keyName]
            end)
            if success and keyCode then
                SetHotkey(keyCode)
            else
                HotkeyInput.Text = HOTKEY.Name
                warn("Invalid key, keeping " .. HOTKEY.Name)
            end
        else
            HotkeyInput.Text = HOTKEY.Name
        end
        HotkeyDisplay.Visible = true
        HotkeyInput.Visible = false
    end)

    SetHotkey(Enum.KeyCode.K)

    -- ===== ЯЗЫК =====
    local LangSection = Instance.new("Frame")
    LangSection.Size = UDim2.new(1, 0, 0, 100)
    LangSection.BackgroundTransparency = 1
    LangSection.Parent = SettingsPage
    LangSection.LayoutOrder = 2

    local LangLabel = Instance.new("TextLabel")
    LangLabel.Size = UDim2.new(1, 0, 0, 20)
    LangLabel.Position = UDim2.new(0, 0, 0, 0)
    LangLabel.BackgroundTransparency = 1
    LangLabel.Text = T("Language")
    LangLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
    LangLabel.TextSize = 13
    LangLabel.Font = Enum.Font.GothamBold
    LangLabel.TextXAlignment = Enum.TextXAlignment.Center
    LangLabel.Parent = LangSection

    local LangBtnContainer = Instance.new("Frame")
    LangBtnContainer.Size = UDim2.new(1, 0, 1, -24)
    LangBtnContainer.Position = UDim2.new(0, 0, 0, 24)
    LangBtnContainer.BackgroundTransparency = 1
    LangBtnContainer.Parent = LangSection

    local function SetLanguage(lang)
        CURRENT_LANG = lang
        -- Обновляем все тексты в GUI
        TitleLabel.Text = T("Title")
        TabMain.Text = T("TabMain")
        TabSettings.Text = T("TabSettings")
        EspLabel.Text = T("ESP")
        NoclipLabel.Text = T("Noclip")
        JumpLabel.Text = T("InfinityJump")
        FlyLabel.Text = T("Fly")
        WsLabel.Text = T("WalkSpeed")
        EspButton.Text = ESP_ENABLED and T("ESP_ON") or T("ESP_OFF")
        NoclipButton.Text = NOCLIP_ENABLED and T("NOCLIP_ON") or T("NOCLIP_OFF")
        JumpButton.Text = INFINITY_JUMP_ENABLED and T("JUMP_ON") or T("JUMP_OFF")
        FlyButton.Text = FLY_ENABLED and T("FLY_ON") or T("FLY_OFF")
        FlyApplyBtn.Text = T("Apply")
        FlyResetBtn.Text = T("Reset")
        WsApplyBtn.Text = T("Apply")
        WsResetBtn.Text = T("Reset")
        HotkeyLabel.Text = T("Hotkey")
        HotkeyInput.PlaceholderText = T("HotkeyPlaceholder")
        LangLabel.Text = T("Language")
        SlotsLabel.Text = T("SaveSlots")
        -- Обновляем статусы слотов
        for slot = 1, 3 do
            local saveBtn = slotSaveBtns[slot]
            local loadBtn = slotLoadBtns[slot]
            local delBtn = slotDelBtns[slot]
            if saveBtn then saveBtn.Text = T("Save") end
            if loadBtn then loadBtn.Text = T("Load") end
            if delBtn then delBtn.Text = T("Delete") end
            UpdateSlotUI(slot)
        end
        -- Обновляем языковые кнопки
        LangEngBtn.Text = T("LangEnglish")
        LangRusBtn.Text = T("LangRussian")
        LangChiBtn.Text = T("LangChinese")
        print("Language set to " .. lang)
    end

    local function MakeLangButton(text, langCode, xPos)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.3, -5, 0.7, 0)
        btn.Position = UDim2.new(xPos, 0, 0.15, 0)
        btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        btn.Text = text
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextSize = 12
        btn.Font = Enum.Font.GothamBold
        btn.BorderSizePixel = 0
        btn.Parent = LangBtnContainer
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 5)
        corner.Parent = btn
        btn.MouseEnter:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
        end)
        btn.MouseLeave:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
        end)
        btn.MouseButton1Click:Connect(function()
            PlayClick()
            SetLanguage(langCode)
        end)
        return btn
    end

    local LangEngBtn = MakeLangButton(T("LangEnglish"), "English", 0)
    local LangRusBtn = MakeLangButton(T("LangRussian"), "Russian", 0.35)
    local LangChiBtn = MakeLangButton(T("LangChinese"), "Chinese", 0.7)

    -- ===== СЛОТЫ СОХРАНЕНИЯ (С РЕАЛЬНЫМ ВРЕМЕНЕМ) =====
    local SlotsSection = Instance.new("Frame")
    SlotsSection.Size = UDim2.new(1, 0, 0, 240)
    SlotsSection.BackgroundTransparency = 1
    SlotsSection.Parent = SettingsPage
    SlotsSection.LayoutOrder = 3

    local SlotsLabel = Instance.new("TextLabel")
    SlotsLabel.Size = UDim2.new(1, 0, 0, 20)
    SlotsLabel.Position = UDim2.new(0, 0, 0, 0)
    SlotsLabel.BackgroundTransparency = 1
    SlotsLabel.Text = T("SaveSlots")
    SlotsLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
    SlotsLabel.TextSize = 13
    SlotsLabel.Font = Enum.Font.GothamBold
    SlotsLabel.TextXAlignment = Enum.TextXAlignment.Center
    SlotsLabel.Parent = SlotsSection

    local SlotsContainer = Instance.new("Frame")
    SlotsContainer.Size = UDim2.new(1, 0, 1, -24)
    SlotsContainer.Position = UDim2.new(0, 0, 0, 24)
    SlotsContainer.BackgroundTransparency = 1
    SlotsContainer.Parent = SlotsSection

    local SlotsLayout = Instance.new("UIListLayout")
    SlotsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    SlotsLayout.Padding = UDim.new(0, 6)
    SlotsLayout.Parent = SlotsContainer

    -- Функции для работы со слотами
    local function getSlotFile(slot)
        return "bloxer_save" .. slot .. ".json"
    end

    local function SlotExists(slot)
        local filename = getSlotFile(slot)
        return hasFileFunctions() and isfile(filename)
    end

    local function LoadSlotData(slot)
        return LoadFromFile(getSlotFile(slot))
    end

    -- Функция сохранения
    local function SaveSlot(slot)
        local data = {
            esp = ESP_ENABLED,
            noclip = NOCLIP_ENABLED,
            fly = FLY_ENABLED,
            infinityJump = INFINITY_JUMP_ENABLED,
            flySpeed = FLY_SPEED,
            walkSpeed = WALK_SPEED,
            hotkey = HOTKEY.Name,
            language = CURRENT_LANG
        }
        local success = SaveToFile(getSlotFile(slot), data)
        if success then
            print("Slot " .. slot .. " saved")
        else
            warn("Failed to save slot " .. slot)
        end
        UpdateSlotUI(slot) -- обновляем статус сразу
    end

    -- Функция загрузки
    local function LoadSlot(slot)
        local data = LoadSlotData(slot)
        if data then
            ESP_ENABLED = data.esp or false
            NOCLIP_ENABLED = data.noclip or false
            FLY_ENABLED = data.fly or false
            INFINITY_JUMP_ENABLED = data.infinityJump or false
            FLY_SPEED = data.flySpeed or 50
            WALK_SPEED = data.walkSpeed or 16

            EspButton.Text = ESP_ENABLED and T("ESP_ON") or T("ESP_OFF")
            NoclipButton.Text = NOCLIP_ENABLED and T("NOCLIP_ON") or T("NOCLIP_OFF")
            JumpButton.Text = INFINITY_JUMP_ENABLED and T("JUMP_ON") or T("JUMP_OFF")
            FlyButton.Text = FLY_ENABLED and T("FLY_ON") or T("FLY_OFF")
            FlySpeedInput.Text = tostring(FLY_SPEED)
            WsInput.Text = tostring(WALK_SPEED)

            local hotkeyName = data.hotkey or "K"
            local success, keyCode = pcall(function()
                return Enum.KeyCode[hotkeyName]
            end)
            if success and keyCode then
                SetHotkey(keyCode)
            else
                SetHotkey(Enum.KeyCode.K)
            end

            local lang = data.language or "English"
            if LANGUAGES[lang] then
                SetLanguage(lang)
            else
                SetLanguage("English")
            end

            for _, pdata in pairs(ESPData) do
                if pdata.Billboard then pdata.Billboard.Enabled = ESP_ENABLED end
                if pdata.Highlight then pdata.Highlight.Enabled = ESP_ENABLED end
            end
            SetNoclip(NOCLIP_ENABLED)
            if FLY_ENABLED then
                if not flyLoopRunning then StartFly() end
                FlyButton.Text = T("FLY_ON")
            else
                StopFly()
                FlyButton.Text = T("FLY_OFF")
            end
            local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
            if hum then hum.WalkSpeed = WALK_SPEED end

            print("Slot " .. slot .. " loaded")
        else
            warn("Slot " .. slot .. " is empty")
        end
        UpdateSlotUI(slot)
    end

    -- Функция удаления
    local function DeleteSlot(slot)
        if hasFileFunctions() and isfile(getSlotFile(slot)) then
            DeleteFile(getSlotFile(slot))
            print("Slot " .. slot .. " deleted")
        else
            warn("Cannot delete, file not found")
        end
        UpdateSlotUI(slot)
    end

    local slotStatusLabels = {}
    local slotSaveBtns = {}
    local slotLoadBtns = {}
    local slotDelBtns = {}

    -- Функция обновления UI для слота (реальное время)
    local function UpdateSlotUI(slot)
        local label = slotStatusLabels[slot]
        if label then
            if SlotExists(slot) then
                label.Text = T("Saved")
                label.TextColor3 = Color3.fromRGB(100, 200, 100)
            else
                label.Text = T("Empty")
                label.TextColor3 = Color3.fromRGB(150, 150, 150)
            end
        end
    end

    -- Создаём слоты
    for slot = 1, 3 do
        local slotFrame = Instance.new("Frame")
        slotFrame.Size = UDim2.new(1, 0, 0, 70)
        slotFrame.BackgroundTransparency = 1
        slotFrame.Parent = SlotsContainer
        slotFrame.LayoutOrder = slot

        local nameLabel = Instance.new("TextLabel")
        nameLabel.Size = UDim2.new(0.15, 0, 0.3, 0)
        nameLabel.Position = UDim2.new(0, 0, 0, 0)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = "Save" .. slot
        nameLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        nameLabel.TextSize = 13
        nameLabel.Font = Enum.Font.GothamBold
        nameLabel.TextXAlignment = Enum.TextXAlignment.Left
        nameLabel.Parent = slotFrame

        local statusLabel = Instance.new("TextLabel")
        statusLabel.Size = UDim2.new(0.4, 0, 0.3, 0)
        statusLabel.Position = UDim2.new(0.15, 0, 0, 0)
        statusLabel.BackgroundTransparency = 1
        statusLabel.Text = T("Empty")
        statusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
        statusLabel.TextSize = 12
        statusLabel.Font = Enum.Font.Gotham
        statusLabel.TextXAlignment = Enum.TextXAlignment.Left
        statusLabel.Parent = slotFrame
        slotStatusLabels[slot] = statusLabel

        local btnContainer = Instance.new("Frame")
        btnContainer.Size = UDim2.new(1, 0, 0.55, 0)
        btnContainer.Position = UDim2.new(0, 0, 0.4, 0)
        btnContainer.BackgroundTransparency = 1
        btnContainer.Parent = slotFrame

        local btnWidth = 0.28
        local gap = 0.02
        local btnY = 0

        local saveBtn = Instance.new("TextButton")
        saveBtn.Size = UDim2.new(btnWidth, 0, 1, 0)
        saveBtn.Position = UDim2.new(0, 0, btnY, 0)
        saveBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        saveBtn.Text = T("Save")
        saveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        saveBtn.TextSize = 12
        saveBtn.Font = Enum.Font.GothamBold
        saveBtn.BorderSizePixel = 0
        saveBtn.Parent = btnContainer
        local sCorner = Instance.new("UICorner")
        sCorner.CornerRadius = UDim.new(0, 4)
        sCorner.Parent = saveBtn
        saveBtn.MouseEnter:Connect(function()
            TweenService:Create(saveBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
        end)
        saveBtn.MouseLeave:Connect(function()
            TweenService:Create(saveBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
        end)
        saveBtn.MouseButton1Click:Connect(function()
            PlayClick()
            SaveSlot(slot)
        end)
        slotSaveBtns[slot] = saveBtn

        local loadBtn = Instance.new("TextButton")
        loadBtn.Size = UDim2.new(btnWidth, 0, 1, 0)
        loadBtn.Position = UDim2.new(btnWidth + gap, 0, btnY, 0)
        loadBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        loadBtn.Text = T("Load")
        loadBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        loadBtn.TextSize = 12
        loadBtn.Font = Enum.Font.GothamBold
        loadBtn.BorderSizePixel = 0
        loadBtn.Parent = btnContainer
        local lCorner = Instance.new("UICorner")
        lCorner.CornerRadius = UDim.new(0, 4)
        lCorner.Parent = loadBtn
        loadBtn.MouseEnter:Connect(function()
            TweenService:Create(loadBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
        end)
        loadBtn.MouseLeave:Connect(function()
            TweenService:Create(loadBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
        end)
        loadBtn.MouseButton1Click:Connect(function()
            PlayClick()
            LoadSlot(slot)
        end)
        slotLoadBtns[slot] = loadBtn

        local delBtn = Instance.new("TextButton")
        delBtn.Size = UDim2.new(btnWidth, 0, 1, 0)
        delBtn.Position = UDim2.new(2*(btnWidth + gap), 0, btnY, 0)
        delBtn.BackgroundColor3 = Color3.fromRGB(60, 20, 20)
        delBtn.Text = T("Delete")
        delBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        delBtn.TextSize = 12
        delBtn.Font = Enum.Font.GothamBold
        delBtn.BorderSizePixel = 0
        delBtn.Parent = btnContainer
        local dCorner = Instance.new("UICorner")
        dCorner.CornerRadius = UDim.new(0, 4)
        dCorner.Parent = delBtn
        delBtn.MouseEnter:Connect(function()
            TweenService:Create(delBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(80, 30, 30)}):Play()
        end)
        delBtn.MouseLeave:Connect(function()
            TweenService:Create(delBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 20, 20)}):Play()
        end)
        delBtn.MouseButton1Click:Connect(function()
            PlayClick()
            DeleteSlot(slot)
        end)
        slotDelBtns[slot] = delBtn

        -- Инициализация статуса
        UpdateSlotUI(slot)
    end

    -- ===== INFINITY JUMP LOGIC =====
    local jumpKeyHeld = false
    local jumpLoopRunning = false

    local function InfiniteJumpLoop()
        while jumpKeyHeld and INFINITY_JUMP_ENABLED do
            local char = LocalPlayer.Character
            if char then
                local humanoid = char:FindFirstChildOfClass("Humanoid")
                local root = char:FindFirstChild("HumanoidRootPart")
                if humanoid and root then
                    local state = humanoid:GetState()
                    if state == Enum.HumanoidStateType.Jumping or state == Enum.HumanoidStateType.Freefall then
                        local currentVel = root.Velocity
                        root.Velocity = Vector3.new(currentVel.X, 50, currentVel.Z)
                    end
                end
            end
            task.wait()
        end
        jumpLoopRunning = false
    end

    UserInputService.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.KeyCode == Enum.KeyCode.Space and INFINITY_JUMP_ENABLED then
            jumpKeyHeld = true
            if not jumpLoopRunning then
                jumpLoopRunning = true
                coroutine.wrap(InfiniteJumpLoop)()
            end
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.Space then
            jumpKeyHeld = false
        end
    end)

    JumpButton.MouseButton1Click:Connect(function()
        PlayClick()
        INFINITY_JUMP_ENABLED = not INFINITY_JUMP_ENABLED
        JumpButton.Text = INFINITY_JUMP_ENABLED and T("JUMP_ON") or T("JUMP_OFF")
        if not INFINITY_JUMP_ENABLED then
            jumpKeyHeld = false
            jumpLoopRunning = false
        end
    end)

    -- ========================================================
    -- FUNCTIONS (ESP, Noclip, Fly, WalkSpeed)
    -- ========================================================
    local ESPData = {}
    local flyBodyVelocity = nil
    local flyBodyGyro = nil
    local flyKeys = {W=false, A=false, S=false, D=false, Space=false, Shift=false}
    local flyLoopRunning = false

    local function GetPlayerHealth(player)
        local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
        if humanoid then return math.floor(humanoid.Health) end
        return 0
    end

    local function TeleportToPlayer(targetPlayer)
        if targetPlayer == LocalPlayer then return end
        if not targetPlayer.Character then return end
        local hrp = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        local localHrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not localHrp then return end
        localHrp.CFrame = hrp.CFrame + Vector3.new(0, 2, 0)
        PlayClick()
    end

    -- Noclip
    local function SetNoclip(state)
        NOCLIP_ENABLED = state
        local character = LocalPlayer.Character
        if not character then return end
        local hrp = character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        if state then
            for _, part in ipairs(character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
            NoclipButton.Text = T("NOCLIP_ON")
        else
            hrp.CFrame = hrp.CFrame + Vector3.new(0, 5, 0)
            task.wait(0.05)
            for _, part in ipairs(character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = true end
            end
            NoclipButton.Text = T("NOCLIP_OFF")
        end
    end

    -- Fly
    local function UpdateFlySpeed()
        local newSpeed = tonumber(FlySpeedInput.Text)
        if newSpeed and newSpeed > 0 then FLY_SPEED = newSpeed end
    end

    local function StartFly()
        local char = LocalPlayer.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        if flyBodyVelocity then flyBodyVelocity:Destroy() end
        if flyBodyGyro then flyBodyGyro:Destroy() end

        flyBodyGyro = Instance.new("BodyGyro")
        flyBodyGyro.MaxTorque = Vector3.new(1, 1, 1) * 1e6
        flyBodyGyro.P = 1e4
        flyBodyGyro.D = 500
        flyBodyGyro.CFrame = hrp.CFrame
        flyBodyGyro.Parent = hrp

        flyBodyVelocity = Instance.new("BodyVelocity")
        flyBodyVelocity.MaxForce = Vector3.new(1, 1, 1) * 1e6
        flyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
        flyBodyVelocity.Parent = hrp

        if not flyLoopRunning then
            flyLoopRunning = true
            UserInputService.InputBegan:Connect(function(input, processed)
                if processed then return end
                local key = input.KeyCode
                if key == Enum.KeyCode.W then flyKeys.W = true
                elseif key == Enum.KeyCode.A then flyKeys.A = true
                elseif key == Enum.KeyCode.S then flyKeys.S = true
                elseif key == Enum.KeyCode.D then flyKeys.D = true
                elseif key == Enum.KeyCode.Space then flyKeys.Space = true
                elseif key == Enum.KeyCode.LeftShift then flyKeys.Shift = true
                end
            end)
            UserInputService.InputEnded:Connect(function(input, processed)
                local key = input.KeyCode
                if key == Enum.KeyCode.W then flyKeys.W = false
                elseif key == Enum.KeyCode.A then flyKeys.A = false
                elseif key == Enum.KeyCode.S then flyKeys.S = false
                elseif key == Enum.KeyCode.D then flyKeys.D = false
                elseif key == Enum.KeyCode.Space then flyKeys.Space = false
                elseif key == Enum.KeyCode.LeftShift then flyKeys.Shift = false
                end
            end)

            coroutine.wrap(function()
                while flyLoopRunning do
                    if FLY_ENABLED and LocalPlayer.Character and flyBodyVelocity and flyBodyGyro then
                        local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            local forward = Camera.CFrame.LookVector
                            local right = Camera.CFrame.RightVector
                            local up = Camera.CFrame.UpVector
                            local move = Vector3.new(0, 0, 0)
                            if flyKeys.W then move = move + forward end
                            if flyKeys.S then move = move - forward end
                            if flyKeys.A then move = move - right end
                            if flyKeys.D then move = move + right end
                            if flyKeys.Space then move = move + up end
                            if flyKeys.Shift then move = move - up end
                            if move.Magnitude > 0 then move = move.Unit * FLY_SPEED else move = Vector3.new(0,0,0) end
                            flyBodyVelocity.Velocity = move
                            flyBodyGyro.CFrame = hrp.CFrame
                        end
                    end
                    task.wait()
                end
            end)()
        end
    end

    local function StopFly()
        FLY_ENABLED = false
        if flyBodyVelocity then flyBodyVelocity:Destroy() flyBodyVelocity = nil end
        if flyBodyGyro then flyBodyGyro:Destroy() flyBodyGyro = nil end
        FlyButton.Text = T("FLY_OFF")
        flyLoopRunning = false
    end

    local function ToggleFly()
        if FLY_ENABLED then StopFly()
        else
            UpdateFlySpeed()
            FLY_ENABLED = true
            StartFly()
            FlyButton.Text = T("FLY_ON")
        end
    end

    -- ===== ИЗМЕНЕНО: добавлен вызов ApplyWalkSpeed() =====
    LocalPlayer.CharacterAdded:Connect(function(char)
        task.wait(0.2)
        if NOCLIP_ENABLED then SetNoclip(true) end
        if FLY_ENABLED then
            flyBodyVelocity = nil; flyBodyGyro = nil
            StartFly()
            FlyButton.Text = T("FLY_ON")
        end
        ApplyWalkSpeed() -- Применяем скорость при появлении персонажа
    end)

    -- ESP
    local function CreateESP(player)
        if player == LocalPlayer then return end
        local old = ESPData[player]
        if old then
            if old.Billboard then old.Billboard:Destroy() end
            if old.Highlight then old.Highlight:Destroy() end
            ESPData[player] = nil
        end
        local character = player.Character
        if not character then
            player.CharacterAdded:Connect(function()
                task.wait(0.2)
                CreateESP(player)
            end)
            return
        end
        local head = character:FindFirstChild("Head")
        if not head then
            task.wait(0.3)
            head = character:FindFirstChild("Head")
            if not head then return end
        end

        local billboard = Instance.new("BillboardGui")
        billboard.Adornee = head
        billboard.Size = UDim2.new(0, 240, 0, 64)
        billboard.StudsOffset = Vector3.new(0, 3, 0)
        billboard.MaxDistance = MAX_DISTANCE
        billboard.AlwaysOnTop = true
        billboard.Enabled = ESP_ENABLED

        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 1, 0)
        btn.BackgroundTransparency = 1
        btn.Text = player.Name .. "\nHP: " .. GetPlayerHealth(player)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextSize = 18
        btn.Font = Enum.Font.GothamBold
        btn.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        btn.TextStrokeTransparency = 0.1
        btn.TextScaled = false
        btn.TextWrapped = true
        btn.Parent = billboard

        btn.MouseButton1Click:Connect(function()
            if ESP_ENABLED then TeleportToPlayer(player) end
        end)

        billboard.Parent = head

        local highlight = Instance.new("Highlight")
        highlight.Adornee = character
        highlight.FillColor = Color3.fromRGB(255, 0, 0)
        highlight.FillTransparency = 0.85
        highlight.OutlineColor = Color3.fromRGB(200, 200, 200)
        highlight.OutlineTransparency = 0.1
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.Enabled = ESP_ENABLED
        highlight.Parent = character

        ESPData[player] = {
            Billboard = billboard,
            Button = btn,
            Highlight = highlight,
            Head = head,
            Character = character,
            Player = player
        }
    end

    local function UpdateESPTexts()
        for player, data in pairs(ESPData) do
            if player and player.Parent and player.Character then
                local health = GetPlayerHealth(player)
                data.Button.Text = player.Name .. "\nHP: " .. health
                data.Billboard.Enabled = ESP_ENABLED
                data.Highlight.Enabled = ESP_ENABLED
            else
                if data.Billboard then data.Billboard:Destroy() end
                if data.Highlight then data.Highlight:Destroy() end
                ESPData[player] = nil
            end
        end
    end

    local function SetESPState(state)
        ESP_ENABLED = state
        for _, data in pairs(ESPData) do
            if data.Billboard then data.Billboard.Enabled = state end
            if data.Highlight then data.Highlight.Enabled = state end
        end
        EspButton.Text = state and T("ESP_ON") or T("ESP_OFF")
    end

    local function SetupAllESP()
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then CreateESP(p) end
        end
    end

    Players.PlayerAdded:Connect(function(p)
        if p ~= LocalPlayer then
            p.CharacterAdded:Connect(function()
                task.wait(0.2)
                CreateESP(p)
            end)
            task.wait(0.2)
            CreateESP(p)
        end
    end)

    Players.PlayerRemoving:Connect(function(p)
        local data = ESPData[p]
        if data then
            if data.Billboard then data.Billboard:Destroy() end
            if data.Highlight then data.Highlight:Destroy() end
            ESPData[p] = nil
        end
    end)

    -- ===== BUTTON EVENTS =====
    EspButton.MouseButton1Click:Connect(function() PlayClick() SetESPState(not ESP_ENABLED) end)
    NoclipButton.MouseButton1Click:Connect(function() PlayClick() SetNoclip(not NOCLIP_ENABLED) end)
    FlyButton.MouseButton1Click:Connect(function() PlayClick() ToggleFly() end)
    FlyApplyBtn.MouseButton1Click:Connect(function() PlayClick() UpdateFlySpeed() end)
    FlyResetBtn.MouseButton1Click:Connect(function() PlayClick() FLY_SPEED=50 FlySpeedInput.Text="50" end)

    WsApplyBtn.MouseButton1Click:Connect(function()
        PlayClick()
        local speed = tonumber(WsInput.Text)
        if speed and speed > 0 then
            local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
            if hum then
                hum.WalkSpeed = speed
                WALK_SPEED = speed
            end
        end
    end)

    WsResetBtn.MouseButton1Click:Connect(function()
        PlayClick()
        local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
        if hum then
            hum.WalkSpeed = 16
            WALK_SPEED = 16
            WsInput.Text = "16"
        end
    end)

    DestroyBtn.MouseButton1Click:Connect(function()
        PlayClick()
        StopFly()
        flyLoopRunning = false
        jumpKeyHeld = false
        jumpLoopRunning = false
        INFINITY_JUMP_ENABLED = false
        if HotkeyConnection then
            HotkeyConnection:Disconnect()
            HotkeyConnection = nil
        end
        for _, data in pairs(ESPData) do
            if data.Billboard then data.Billboard:Destroy() end
            if data.Highlight then data.Highlight:Destroy() end
        end
        ESPData = {}
        ScreenGui:Destroy()
    end)

    -- ===== UPDATE LOOP (с постоянным применением скорости) =====
    local function UpdateLoop()
        while ScreenGui and ScreenGui.Parent do
            if ESP_ENABLED then
                UpdateESPTexts()
            end
            -- Постоянное поддержание скорости ходьбы/бега
            ApplyWalkSpeed()
            task.wait(UPDATE_INTERVAL)
        end
    end

    -- ===== INIT =====
    SetupAllESP()
    task.wait(0.5)
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and not ESPData[p] then CreateESP(p) end
    end
    coroutine.wrap(UpdateLoop)()

    print("Bloxer Script loaded with localization, real-time slot updates, and constant WalkSpeed.")
end