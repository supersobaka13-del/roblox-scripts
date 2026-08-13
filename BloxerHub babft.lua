-- ==========================================================
-- СОВРЕМЕННЫЙ ИНТЕРФЕЙС АВТОРИЗАЦИИ (KEY SYSTEM)
-- ==========================================================
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local AuthGui = Instance.new("ScreenGui")
AuthGui.Name = "BloxerAuth"
AuthGui.Parent = CoreGui
AuthGui.ResetOnSpawn = false

-- ===== ГЛАВНОЕ ОКНО =====
local AuthFrame = Instance.new("Frame")
AuthFrame.Size = UDim2.new(0, 320, 0, 220)
AuthFrame.Position = UDim2.new(0.5, -160, 0.5, -110)
AuthFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
AuthFrame.BorderSizePixel = 0
AuthFrame.Parent = AuthGui

local AuthCorner = Instance.new("UICorner")
AuthCorner.CornerRadius = UDim.new(0, 10)
AuthCorner.Parent = AuthFrame

local AuthStroke = Instance.new("UIStroke")
AuthStroke.Color = Color3.fromRGB(40, 40, 48)
AuthStroke.Thickness = 1
AuthStroke.Parent = AuthFrame

-- ===== ЗАГОЛОВОК =====
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 45)
TitleBar.BackgroundColor3 = Color3.fromRGB(18, 18, 23)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = AuthFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = TitleBar

local TitleBlend = Instance.new("Frame")
TitleBlend.Size = UDim2.new(1, 0, 0, 6)
TitleBlend.Position = UDim2.new(0, 0, 1, -6)
TitleBlend.BackgroundColor3 = Color3.fromRGB(18, 18, 23)
TitleBlend.BorderSizePixel = 0
TitleBlend.Parent = TitleBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 1, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Bloxer Hub"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 18
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Parent = TitleBar

-- ===== ПОЛЕ ВВОДА =====
local InputBox = Instance.new("TextBox")
InputBox.Size = UDim2.new(0, 220, 0, 40)
InputBox.Position = UDim2.new(0.5, -110, 0, 75)
InputBox.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
InputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
InputBox.TextSize = 15
InputBox.Font = Enum.Font.Gotham
InputBox.Text = ""
InputBox.PlaceholderText = "Keypass"
InputBox.PlaceholderColor3 = Color3.fromRGB(130, 130, 140)
InputBox.ClearTextOnFocus = false
InputBox.Parent = AuthFrame

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 6)
InputCorner.Parent = InputBox

local InputStroke = Instance.new("UIStroke")
InputStroke.Color = Color3.fromRGB(50, 50, 60)
InputStroke.Thickness = 1
InputStroke.Parent = InputBox

-- ===== КНОПКИ =====
local GetKeyBtn = Instance.new("TextButton")
GetKeyBtn.Size = UDim2.new(0, 130, 0, 38)
GetKeyBtn.Position = UDim2.new(0.5, -145, 0, 130)
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(42, 42, 50)
GetKeyBtn.Text = "Get Key"
GetKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
GetKeyBtn.TextSize = 14
GetKeyBtn.Font = Enum.Font.GothamBold
GetKeyBtn.AutoButtonColor = false
GetKeyBtn.Parent = AuthFrame

local GetKeyCorner = Instance.new("UICorner")
GetKeyCorner.CornerRadius = UDim.new(0, 6)
GetKeyCorner.Parent = GetKeyBtn

local VerifyBtn = Instance.new("TextButton")
VerifyBtn.Size = UDim2.new(0, 130, 0, 38)
VerifyBtn.Position = UDim2.new(0.5, 15, 0, 130)
VerifyBtn.BackgroundColor3 = Color3.fromRGB(0, 125, 255)
VerifyBtn.Text = "Verify"
VerifyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
VerifyBtn.TextSize = 14
VerifyBtn.Font = Enum.Font.GothamBold
VerifyBtn.AutoButtonColor = false
VerifyBtn.Parent = AuthFrame

local VerifyCorner = Instance.new("UICorner")
VerifyCorner.CornerRadius = UDim.new(0, 6)
VerifyCorner.Parent = VerifyBtn

-- ===== СТАТУС БАР =====
local StatusAuth = Instance.new("TextLabel")
StatusAuth.Size = UDim2.new(1, 0, 0, 20)
StatusAuth.Position = UDim2.new(0, 0, 0, 180)
StatusAuth.BackgroundTransparency = 1
StatusAuth.Text = ""
StatusAuth.TextColor3 = Color3.fromRGB(200, 200, 200)
StatusAuth.TextSize = 12
StatusAuth.Font = Enum.Font.Gotham
StatusAuth.TextXAlignment = Enum.TextXAlignment.Center
StatusAuth.Parent = AuthFrame

-- Hover эффекты
local function hoverEffect(btn, hoverColor, normalColor)
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = hoverColor}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = normalColor}):Play()
    end)
end
hoverEffect(GetKeyBtn, Color3.fromRGB(62, 62, 72), Color3.fromRGB(42, 42, 50))
hoverEffect(VerifyBtn, Color3.fromRGB(40, 165, 255), Color3.fromRGB(0, 125, 255))

-- ==========================================================
-- ЛОГИКА АВТОРИЗАЦИИ
-- ==========================================================
GetKeyBtn.MouseButton1Click:Connect(function()
    local url = "https://t.me/BloxerHub"
    if pcall(function() game:GetService("GuiService"):OpenBrowserWindow(url) end) then
        StatusAuth.Text = "Telegram opened."
        StatusAuth.TextColor3 = Color3.fromRGB(255, 255, 0)
    else
        setclipboard(url)
        StatusAuth.Text = "Link copied to clipboard!"
        StatusAuth.TextColor3 = Color3.fromRGB(255, 255, 0)
    end
end)

VerifyBtn.MouseButton1Click:Connect(function()
    local enteredKey = InputBox.Text:gsub("%s+", "")
    if enteredKey == "BloxerHub" then
        StatusAuth.Text = "✅ Success! Loading hub..."
        StatusAuth.TextColor3 = Color3.fromRGB(0, 255, 0)
        task.wait(0.8)
        AuthGui:Destroy()

        -- ==========================================================
        -- ОСНОВНОЙ ХАБ (С ИСПРАВЛЕННОЙ СТАТИСТИКОЙ АВТОФАРМА)
        -- ==========================================================
        local success, err = pcall(function()
            loadstring([[
                -- =============================================================
                -- BLOXER HUB v1.0 (С ИСПРАВЛЕННОЙ СТАТИСТИКОЙ АВТОФАРМА)
                -- =============================================================
                local Players = game:GetService("Players")
                local RunService = game:GetService("RunService")
                local TweenService = game:GetService("TweenService")
                local LocalPlayer = Players.LocalPlayer
                local UserInputService = game:GetService("UserInputService")
                local Workspace = game:GetService("Workspace")
                local Camera = Workspace.CurrentCamera
                local StarterGui = game:GetService("StarterGui")
                local TeleportService = game:GetService("TeleportService")

                local MAX_DISTANCE = 5000

                -- ===================== УВЕДОМЛЕНИЯ =====================
                local function sendNotification(text, duration)
                    StarterGui:SetCore("SendNotification", {
                        Title = "Bloxer",
                        Text = text,
                        Duration = duration or 2,
                        Icon = ""
                    })
                end

                -- ===================== ПОЛУЧЕНИЕ ЗОЛОТА (ИСПРАВЛЕНО) =====================
                local function getGold()
                    -- Сначала ищем в Data.Gold
                    local data = LocalPlayer:FindFirstChild("Data")
                    if data then
                        local gold = data:FindFirstChild("Gold")
                        if gold then return gold.Value end
                    end
                    -- Если нет, ищем в leaderstats
                    local stats = LocalPlayer:FindFirstChild("leaderstats")
                    if stats then
                        local gold = stats:FindFirstChild("Gold") or stats:FindFirstChild("Coins")
                        if gold then return gold.Value end
                    end
                    return 0
                end

                -- ===================== GUI ХАБА =====================
                local ScreenGui = Instance.new("ScreenGui")
                ScreenGui.Name = "BloxerHub"
                ScreenGui.ResetOnSpawn = false
                ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

                -- ===== ГЛАВНАЯ ПАНЕЛЬ =====
                local MainFrame = Instance.new("Frame")
                MainFrame.Size = UDim2.new(0, 320, 0, 460)
                MainFrame.Position = UDim2.new(0.5, -160, 0.5, -230)
                MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                MainFrame.BackgroundTransparency = 0
                MainFrame.BorderSizePixel = 1
                MainFrame.BorderColor3 = Color3.fromRGB(40, 40, 40)
                MainFrame.Active = true
                MainFrame.Draggable = true
                MainFrame.ClipsDescendants = false
                MainFrame.Visible = true
                MainFrame.Parent = ScreenGui

                local PanelCorner = Instance.new("UICorner")
                PanelCorner.CornerRadius = UDim.new(0, 10)
                PanelCorner.Parent = MainFrame

                local GlowBorder = Instance.new("Frame")
                GlowBorder.Size = UDim2.new(1, 6, 1, 6)
                GlowBorder.Position = UDim2.new(0, -3, 0, -3)
                GlowBorder.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
                GlowBorder.BackgroundTransparency = 0.5
                GlowBorder.BorderSizePixel = 0
                GlowBorder.Parent = MainFrame
                local GlowCorner = Instance.new("UICorner")
                GlowCorner.CornerRadius = UDim.new(0, 13)
                GlowCorner.Parent = GlowBorder

                -- ===== ЗАГОЛОВОК =====
                local TitleBar = Instance.new("Frame")
                TitleBar.Size = UDim2.new(1, 0, 0, 44)
                TitleBar.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
                TitleBar.BorderSizePixel = 0
                TitleBar.Parent = MainFrame
                local TitleCorner = Instance.new("UICorner")
                TitleCorner.CornerRadius = UDim.new(0, 10)
                TitleCorner.Parent = TitleBar

                local AccentLine = Instance.new("Frame")
                AccentLine.Size = UDim2.new(0.8, 0, 0, 2)
                AccentLine.Position = UDim2.new(0.1, 0, 1, -2)
                AccentLine.BackgroundColor3 = Color3.fromRGB(100, 180, 255)
                AccentLine.BackgroundTransparency = 0.3
                AccentLine.BorderSizePixel = 0
                AccentLine.Parent = TitleBar

                -- ===== КРУГЛЫЕ КНОПКИ НАВИГАЦИИ =====
                local MainNavBtn = Instance.new("TextButton")
                MainNavBtn.Size = UDim2.new(0, 32, 0, 32)
                MainNavBtn.Position = UDim2.new(0, 8, 0, -40)
                MainNavBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
                MainNavBtn.BorderSizePixel = 0
                MainNavBtn.Text = "🏠"
                MainNavBtn.TextColor3 = Color3.fromRGB(200, 200, 220)
                MainNavBtn.TextSize = 20
                MainNavBtn.Font = Enum.Font.GothamBold
                MainNavBtn.AutoButtonColor = false
                MainNavBtn.Parent = TitleBar
                local cornerM = Instance.new("UICorner")
                cornerM.CornerRadius = UDim.new(1, 0)
                cornerM.Parent = MainNavBtn

                local OtherNavBtn = Instance.new("TextButton")
                OtherNavBtn.Size = UDim2.new(0, 32, 0, 32)
                OtherNavBtn.Position = UDim2.new(0, 8+32+8, 0, -40)
                OtherNavBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
                OtherNavBtn.BorderSizePixel = 0
                OtherNavBtn.Text = "🎯"
                OtherNavBtn.TextColor3 = Color3.fromRGB(200, 200, 220)
                OtherNavBtn.TextSize = 20
                OtherNavBtn.Font = Enum.Font.GothamBold
                OtherNavBtn.AutoButtonColor = false
                OtherNavBtn.Parent = TitleBar
                local cornerO = Instance.new("UICorner")
                cornerO.CornerRadius = UDim.new(1, 0)
                cornerO.Parent = OtherNavBtn

                local SettingsNavBtn = Instance.new("TextButton")
                SettingsNavBtn.Size = UDim2.new(0, 32, 0, 32)
                SettingsNavBtn.Position = UDim2.new(0, 8+32+8+32+8, 0, -40)
                SettingsNavBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
                SettingsNavBtn.BorderSizePixel = 0
                SettingsNavBtn.Text = "⚙️"
                SettingsNavBtn.TextColor3 = Color3.fromRGB(200, 200, 220)
                SettingsNavBtn.TextSize = 20
                SettingsNavBtn.Font = Enum.Font.GothamBold
                SettingsNavBtn.AutoButtonColor = false
                SettingsNavBtn.Parent = TitleBar
                local cornerS = Instance.new("UICorner")
                cornerS.CornerRadius = UDim.new(1, 0)
                cornerS.Parent = SettingsNavBtn

                local function setupNavHover(btn)
                    btn.MouseEnter:Connect(function()
                        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 60)}):Play()
                    end)
                    btn.MouseLeave:Connect(function()
                        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(25, 25, 35)}):Play()
                    end)
                end
                setupNavHover(MainNavBtn)
                setupNavHover(OtherNavBtn)
                setupNavHover(SettingsNavBtn)

                local TitleLabel = Instance.new("TextLabel")
                TitleLabel.Size = UDim2.new(0, 200, 1, 0)
                TitleLabel.Position = UDim2.new(0, 15, 0, 0)
                TitleLabel.BackgroundTransparency = 1
                TitleLabel.Text = "Bloxer Hub: babft"
                TitleLabel.TextColor3 = Color3.fromRGB(230, 230, 255)
                TitleLabel.TextSize = 22
                TitleLabel.Font = Enum.Font.GothamBlack
                TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
                TitleLabel.Parent = TitleBar

                -- ===== КНОПКИ УПРАВЛЕНИЯ =====
                local CloseBtn = Instance.new("TextButton")
                CloseBtn.Size = UDim2.new(0, 28, 0, 28)
                CloseBtn.Position = UDim2.new(1, -66, 0, 8)
                CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
                CloseBtn.BorderSizePixel = 0
                CloseBtn.Text = "✕"
                CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                CloseBtn.TextSize = 14
                CloseBtn.Font = Enum.Font.SourceSansBold
                CloseBtn.AutoButtonColor = false
                CloseBtn.Parent = TitleBar
                local CloseCorner = Instance.new("UICorner")
                CloseCorner.CornerRadius = UDim.new(0, 4)
                CloseCorner.Parent = CloseBtn

                local HideBtn = Instance.new("TextButton")
                HideBtn.Size = UDim2.new(0, 28, 0, 28)
                HideBtn.Position = UDim2.new(1, -34, 0, 8)
                HideBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
                HideBtn.BorderSizePixel = 0
                HideBtn.Text = "▼"
                HideBtn.TextColor3 = Color3.fromRGB(200, 200, 220)
                HideBtn.TextSize = 14
                HideBtn.Font = Enum.Font.SourceSansBold
                HideBtn.AutoButtonColor = false
                HideBtn.Parent = TitleBar
                local HideCorner = Instance.new("UICorner")
                HideCorner.CornerRadius = UDim.new(0, 4)
                HideCorner.Parent = HideBtn

                local function setupBtnHover(btn, hover, leave)
                    btn.MouseEnter:Connect(function() TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = hover}):Play() end)
                    btn.MouseLeave:Connect(function() TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = leave}):Play() end)
                end
                setupBtnHover(HideBtn, Color3.fromRGB(60, 60, 80), Color3.fromRGB(30, 30, 40))
                setupBtnHover(CloseBtn, Color3.fromRGB(220, 60, 60), Color3.fromRGB(180, 40, 40))

                -- ===== SCROLLING CONTENT =====
                local ScrollContainer = Instance.new("ScrollingFrame")
                ScrollContainer.Size = UDim2.new(1, -16, 1, -56)
                ScrollContainer.Position = UDim2.new(0, 8, 0, 50)
                ScrollContainer.BackgroundTransparency = 1
                ScrollContainer.BorderSizePixel = 0
                ScrollContainer.ScrollBarThickness = 4
                ScrollContainer.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 80)
                ScrollContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
                ScrollContainer.Parent = MainFrame

                -- ===== СТРАНИЦЫ =====
                local MainPage = Instance.new("Frame")
                MainPage.Size = UDim2.new(1, 0, 0, 0)
                MainPage.BackgroundTransparency = 1
                MainPage.Visible = true
                MainPage.Parent = ScrollContainer

                local MainLayout = Instance.new("UIListLayout")
                MainLayout.SortOrder = Enum.SortOrder.LayoutOrder
                MainLayout.Padding = UDim.new(0, 4)
                MainLayout.Parent = MainPage

                local OtherPage = Instance.new("Frame")
                OtherPage.Size = UDim2.new(1, 0, 0, 0)
                OtherPage.BackgroundTransparency = 1
                OtherPage.Visible = false
                OtherPage.Parent = ScrollContainer

                local OtherLayout = Instance.new("UIListLayout")
                OtherLayout.SortOrder = Enum.SortOrder.LayoutOrder
                OtherLayout.Padding = UDim.new(0, 4)
                OtherLayout.Parent = OtherPage

                local SettingsPage = Instance.new("Frame")
                SettingsPage.Size = UDim2.new(1, 0, 0, 0)
                SettingsPage.BackgroundTransparency = 1
                SettingsPage.Visible = false
                SettingsPage.Parent = ScrollContainer

                local SettingsLayout = Instance.new("UIListLayout")
                SettingsLayout.SortOrder = Enum.SortOrder.LayoutOrder
                SettingsLayout.Padding = UDim.new(0, 8)
                SettingsLayout.Parent = SettingsPage

                -- ============================================================
                -- ГЛАВНАЯ СТРАНИЦА – АККОРДЕОН
                -- ============================================================
                local function createCategoryHeader(parent, title, icon)
                    local header = Instance.new("TextButton")
                    header.Size = UDim2.new(1, 0, 0, 30)
                    header.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
                    header.BorderSizePixel = 0
                    header.Text = ""
                    header.AutoButtonColor = false
                    header.Parent = parent
                    local headerCorner = Instance.new("UICorner")
                    headerCorner.CornerRadius = UDim.new(0, 6)
                    headerCorner.Parent = header

                    local iconLabel = Instance.new("TextLabel")
                    iconLabel.Size = UDim2.new(0, 20, 1, 0)
                    iconLabel.Position = UDim2.new(0, 6, 0, 0)
                    iconLabel.BackgroundTransparency = 1
                    iconLabel.Text = icon
                    iconLabel.TextColor3 = Color3.fromRGB(200, 200, 220)
                    iconLabel.TextSize = 14
                    iconLabel.Font = Enum.Font.SourceSans
                    iconLabel.TextXAlignment = Enum.TextXAlignment.Left
                    iconLabel.Parent = header

                    local titleLabel = Instance.new("TextLabel")
                    titleLabel.Size = UDim2.new(1, -60, 1, 0)
                    titleLabel.Position = UDim2.new(0, 30, 0, 0)
                    titleLabel.BackgroundTransparency = 1
                    titleLabel.Text = title
                    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    titleLabel.TextSize = 14
                    titleLabel.Font = Enum.Font.SourceSansBold
                    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
                    titleLabel.Parent = header

                    local arrow = Instance.new("TextLabel")
                    arrow.Size = UDim2.new(0, 20, 1, 0)
                    arrow.Position = UDim2.new(1, -24, 0, 0)
                    arrow.BackgroundTransparency = 1
                    arrow.Text = "▶"
                    arrow.TextColor3 = Color3.fromRGB(180, 180, 210)
                    arrow.TextSize = 14
                    arrow.Font = Enum.Font.SourceSans
                    arrow.TextXAlignment = Enum.TextXAlignment.Center
                    arrow.Parent = header

                    local content = Instance.new("Frame")
                    content.Size = UDim2.new(1, 0, 0, 0)
                    content.BackgroundTransparency = 1
                    content.Visible = false
                    content.AutomaticSize = Enum.AutomaticSize.Y
                    content.Parent = parent

                    local contentLayout = Instance.new("UIListLayout")
                    contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
                    contentLayout.Padding = UDim.new(0, 2)
                    contentLayout.Parent = content

                    return header, content, arrow
                end

                local headerESP, contentESP, arrowESP = createCategoryHeader(MainPage, "ESP & Features", "👁")
                local headerFarm, contentFarm, arrowFarm = createCategoryHeader(MainPage, "Auto Farm", "🚀")

                -- ESP Toggle
                local ToggleFrameESP = Instance.new("Frame")
                ToggleFrameESP.Size = UDim2.new(1, 0, 0, 34)
                ToggleFrameESP.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
                ToggleFrameESP.BorderSizePixel = 0
                ToggleFrameESP.Parent = contentESP
                local ToggleCornerESP = Instance.new("UICorner")
                ToggleCornerESP.CornerRadius = UDim.new(0, 4)
                ToggleCornerESP.Parent = ToggleFrameESP

                local RowESP = Instance.new("Frame")
                RowESP.Size = UDim2.new(1, 0, 1, 0)
                RowESP.BackgroundTransparency = 1
                RowESP.Parent = ToggleFrameESP

                local EyeIcon = Instance.new("TextLabel")
                EyeIcon.Size = UDim2.new(0, 16, 0, 16)
                EyeIcon.Position = UDim2.new(0, 6, 0, 9)
                EyeIcon.BackgroundTransparency = 1
                EyeIcon.Text = "👁"
                EyeIcon.TextSize = 14
                EyeIcon.Parent = RowESP

                local ToggleLabelESP = Instance.new("TextLabel")
                ToggleLabelESP.Size = UDim2.new(0, 26, 1, 0)
                ToggleLabelESP.Position = UDim2.new(0, 26, 0, 0)
                ToggleLabelESP.BackgroundTransparency = 1
                ToggleLabelESP.Text = "ESP"
                ToggleLabelESP.TextColor3 = Color3.fromRGB(255, 255, 255)
                ToggleLabelESP.TextSize = 12
                ToggleLabelESP.Font = Enum.Font.SourceSansBold
                ToggleLabelESP.TextXAlignment = Enum.TextXAlignment.Left
                ToggleLabelESP.Parent = RowESP

                local InfoLabel = Instance.new("TextLabel")
                InfoLabel.Size = UDim2.new(0, 110, 1, 0)
                InfoLabel.Position = UDim2.new(0, 56, 0, 0)
                InfoLabel.BackgroundTransparency = 1
                InfoLabel.Text = "Players: 0 | R:5000"
                InfoLabel.TextColor3 = Color3.fromRGB(180, 180, 210)
                InfoLabel.TextSize = 10
                InfoLabel.Font = Enum.Font.SourceSans
                InfoLabel.TextXAlignment = Enum.TextXAlignment.Left
                InfoLabel.Parent = RowESP

                local ToggleButtonESP = Instance.new("TextButton")
                ToggleButtonESP.Size = UDim2.new(0, 36, 0, 18)
                ToggleButtonESP.Position = UDim2.new(1, -40, 0, 8)
                ToggleButtonESP.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
                ToggleButtonESP.BorderSizePixel = 0
                ToggleButtonESP.Text = "OFF"
                ToggleButtonESP.TextColor3 = Color3.fromRGB(255, 255, 255)
                ToggleButtonESP.TextSize = 10
                ToggleButtonESP.Font = Enum.Font.SourceSansBold
                ToggleButtonESP.AutoButtonColor = false
                ToggleButtonESP.Parent = RowESP
                local ToggleCornerBtnESP = Instance.new("UICorner")
                ToggleCornerBtnESP.CornerRadius = UDim.new(0, 3)
                ToggleCornerBtnESP.Parent = ToggleButtonESP

                -- Spectator Toggle
                local ToggleFrameSpectator = Instance.new("Frame")
                ToggleFrameSpectator.Size = UDim2.new(1, 0, 0, 34)
                ToggleFrameSpectator.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
                ToggleFrameSpectator.BorderSizePixel = 0
                ToggleFrameSpectator.Parent = contentESP
                local ToggleCornerSpectator = Instance.new("UICorner")
                ToggleCornerSpectator.CornerRadius = UDim.new(0, 4)
                ToggleCornerSpectator.Parent = ToggleFrameSpectator

                local RowSpectator = Instance.new("Frame")
                RowSpectator.Size = UDim2.new(1, 0, 1, 0)
                RowSpectator.BackgroundTransparency = 1
                RowSpectator.Parent = ToggleFrameSpectator

                local SpectatorIcon = Instance.new("TextLabel")
                SpectatorIcon.Size = UDim2.new(0, 16, 0, 16)
                SpectatorIcon.Position = UDim2.new(0, 6, 0, 9)
                SpectatorIcon.BackgroundTransparency = 1
                SpectatorIcon.Text = "👀"
                SpectatorIcon.TextSize = 14
                SpectatorIcon.Parent = RowSpectator

                local ToggleLabelSpectator = Instance.new("TextLabel")
                ToggleLabelSpectator.Size = UDim2.new(0, 26, 1, 0)
                ToggleLabelSpectator.Position = UDim2.new(0, 26, 0, 0)
                ToggleLabelSpectator.BackgroundTransparency = 1
                ToggleLabelSpectator.Text = "Spectator"
                ToggleLabelSpectator.TextColor3 = Color3.fromRGB(255, 255, 255)
                ToggleLabelSpectator.TextSize = 12
                ToggleLabelSpectator.Font = Enum.Font.SourceSansBold
                ToggleLabelSpectator.TextXAlignment = Enum.TextXAlignment.Left
                ToggleLabelSpectator.Parent = RowSpectator

                local SpectatorStatusLabel = Instance.new("TextLabel")
                SpectatorStatusLabel.Size = UDim2.new(0, 110, 1, 0)
                SpectatorStatusLabel.Position = UDim2.new(0, 82, 0, 0)
                SpectatorStatusLabel.BackgroundTransparency = 1
                SpectatorStatusLabel.Text = "Off"
                SpectatorStatusLabel.TextColor3 = Color3.fromRGB(180, 180, 210)
                SpectatorStatusLabel.TextSize = 10
                SpectatorStatusLabel.Font = Enum.Font.SourceSans
                SpectatorStatusLabel.TextXAlignment = Enum.TextXAlignment.Left
                SpectatorStatusLabel.Parent = RowSpectator

                local ToggleButtonSpectator = Instance.new("TextButton")
                ToggleButtonSpectator.Size = UDim2.new(0, 36, 0, 18)
                ToggleButtonSpectator.Position = UDim2.new(1, -40, 0, 8)
                ToggleButtonSpectator.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
                ToggleButtonSpectator.BorderSizePixel = 0
                ToggleButtonSpectator.Text = "OFF"
                ToggleButtonSpectator.TextColor3 = Color3.fromRGB(255, 255, 255)
                ToggleButtonSpectator.TextSize = 10
                ToggleButtonSpectator.Font = Enum.Font.SourceSansBold
                ToggleButtonSpectator.AutoButtonColor = false
                ToggleButtonSpectator.Parent = RowSpectator
                local ToggleCornerBtnSpectator = Instance.new("UICorner")
                ToggleCornerBtnSpectator.CornerRadius = UDim.new(0, 3)
                ToggleCornerBtnSpectator.Parent = ToggleButtonSpectator

                -- ============================================================
                -- AUTO FARM TOGGLE + ИСПРАВЛЕННАЯ СТАТИСТИКА
                -- ============================================================
                local ToggleFrameFarm = Instance.new("Frame")
                ToggleFrameFarm.Size = UDim2.new(1, 0, 0, 34)
                ToggleFrameFarm.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
                ToggleFrameFarm.BorderSizePixel = 0
                ToggleFrameFarm.Parent = contentFarm
                local ToggleCornerFarm = Instance.new("UICorner")
                ToggleCornerFarm.CornerRadius = UDim.new(0, 4)
                ToggleCornerFarm.Parent = ToggleFrameFarm

                local RowFarm = Instance.new("Frame")
                RowFarm.Size = UDim2.new(1, 0, 1, 0)
                RowFarm.BackgroundTransparency = 1
                RowFarm.Parent = ToggleFrameFarm

                local FarmIcon = Instance.new("TextLabel")
                FarmIcon.Size = UDim2.new(0, 16, 0, 16)
                FarmIcon.Position = UDim2.new(0, 6, 0, 9)
                FarmIcon.BackgroundTransparency = 1
                FarmIcon.Text = "🚀"
                FarmIcon.TextSize = 14
                FarmIcon.Parent = RowFarm

                local ToggleLabelFarm = Instance.new("TextLabel")
                ToggleLabelFarm.Size = UDim2.new(0, 26, 1, 0)
                ToggleLabelFarm.Position = UDim2.new(0, 26, 0, 0)
                ToggleLabelFarm.BackgroundTransparency = 1
                ToggleLabelFarm.Text = "Auto Farm"
                ToggleLabelFarm.TextColor3 = Color3.fromRGB(255, 255, 255)
                ToggleLabelFarm.TextSize = 12
                ToggleLabelFarm.Font = Enum.Font.SourceSansBold
                ToggleLabelFarm.TextXAlignment = Enum.TextXAlignment.Left
                ToggleLabelFarm.Parent = RowFarm

                local FarmStatusLabel = Instance.new("TextLabel")
                FarmStatusLabel.Size = UDim2.new(0, 110, 1, 0)
                FarmStatusLabel.Position = UDim2.new(0, 82, 0, 0)
                FarmStatusLabel.BackgroundTransparency = 1
                FarmStatusLabel.Text = "Idle"
                FarmStatusLabel.TextColor3 = Color3.fromRGB(180, 180, 210)
                FarmStatusLabel.TextSize = 10
                FarmStatusLabel.Font = Enum.Font.SourceSans
                FarmStatusLabel.TextXAlignment = Enum.TextXAlignment.Left
                FarmStatusLabel.Parent = RowFarm

                local ToggleButtonFarm = Instance.new("TextButton")
                ToggleButtonFarm.Size = UDim2.new(0, 36, 0, 18)
                ToggleButtonFarm.Position = UDim2.new(1, -40, 0, 8)
                ToggleButtonFarm.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
                ToggleButtonFarm.BorderSizePixel = 0
                ToggleButtonFarm.Text = "OFF"
                ToggleButtonFarm.TextColor3 = Color3.fromRGB(255, 255, 255)
                ToggleButtonFarm.TextSize = 10
                ToggleButtonFarm.Font = Enum.Font.SourceSansBold
                ToggleButtonFarm.AutoButtonColor = false
                ToggleButtonFarm.Parent = RowFarm
                local ToggleCornerBtnFarm = Instance.new("UICorner")
                ToggleCornerBtnFarm.CornerRadius = UDim.new(0, 3)
                ToggleCornerBtnFarm.Parent = ToggleButtonFarm

                -- ============================================================
                -- НОВАЯ СТАТИСТИКА АВТОФАРМА (GUI) – ИСПРАВЛЕНО
                -- ============================================================
                local farmStatsGui = nil
                local farmStatsFrame = nil
                local farmTimerLabel, farmGoldLabel, farmProgressFill, farmGoalLabel, farmGoalInput, farmSetGoalBtn
                local farmStartTime, farmStartGold, farmEarnedGold, farmGoal, farmGoalReached = 0, 0, 0, nil, false
                local farmUpdateConnection = nil
                local farmRunning = false

                local function createFarmStats()
                    if farmStatsGui then return end
                    farmStatsGui = Instance.new("ScreenGui")
                    farmStatsGui.Name = "FarmStats"
                    farmStatsGui.ResetOnSpawn = false
                    farmStatsGui.Parent = LocalPlayer.PlayerGui

                    farmStatsFrame = Instance.new("Frame")
                    farmStatsFrame.Size = UDim2.new(0, 280, 0, 210)
                    farmStatsFrame.Position = UDim2.new(0.8, -140, 0.2, 0) -- справа сверху
                    farmStatsFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
                    farmStatsFrame.BorderSizePixel = 1
                    farmStatsFrame.BorderColor3 = Color3.fromRGB(40, 40, 48)
                    farmStatsFrame.Active = true
                    farmStatsFrame.Draggable = true
                    farmStatsFrame.Parent = farmStatsGui
                    local frameCorner = Instance.new("UICorner")
                    frameCorner.CornerRadius = UDim.new(0, 8)
                    frameCorner.Parent = farmStatsFrame

                    -- Заголовок
                    local title = Instance.new("TextLabel")
                    title.Size = UDim2.new(1, 0, 0, 30)
                    title.BackgroundColor3 = Color3.fromRGB(18, 18, 23)
                    title.Text = "Auto Farm Stats"
                    title.TextColor3 = Color3.fromRGB(255, 255, 255)
                    title.TextSize = 14
                    title.Font = Enum.Font.GothamBold
                    title.Parent = farmStatsFrame
                    local titleCorner = Instance.new("UICorner")
                    titleCorner.CornerRadius = UDim.new(0, 8)
                    titleCorner.Parent = title

                    -- Таймер (по центру)
                    farmTimerLabel = Instance.new("TextLabel")
                    farmTimerLabel.Size = UDim2.new(1, 0, 0, 25)
                    farmTimerLabel.Position = UDim2.new(0, 0, 0, 34)
                    farmTimerLabel.BackgroundTransparency = 1
                    farmTimerLabel.Text = "Time: 00:00"
                    farmTimerLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
                    farmTimerLabel.TextSize = 13
                    farmTimerLabel.Font = Enum.Font.Gotham
                    farmTimerLabel.TextXAlignment = Enum.TextXAlignment.Center
                    farmTimerLabel.Parent = farmStatsFrame

                    -- Счётчик голды (под таймером)
                    farmGoldLabel = Instance.new("TextLabel")
                    farmGoldLabel.Size = UDim2.new(1, 0, 0, 25)
                    farmGoldLabel.Position = UDim2.new(0, 0, 0, 59)
                    farmGoldLabel.BackgroundTransparency = 1
                    farmGoldLabel.Text = "Gold: 0"
                    farmGoldLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
                    farmGoldLabel.TextSize = 13
                    farmGoldLabel.Font = Enum.Font.GothamBold
                    farmGoldLabel.TextXAlignment = Enum.TextXAlignment.Center
                    farmGoldLabel.Parent = farmStatsFrame

                    -- Полоска прогресса (снизу)
                    local progressBg = Instance.new("Frame")
                    progressBg.Size = UDim2.new(0.9, 0, 0, 16)
                    progressBg.Position = UDim2.new(0.05, 0, 0, 92)
                    progressBg.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                    progressBg.BorderSizePixel = 0
                    progressBg.Parent = farmStatsFrame
                    local bgCorner = Instance.new("UICorner")
                    bgCorner.CornerRadius = UDim.new(0, 4)
                    bgCorner.Parent = progressBg

                    farmProgressFill = Instance.new("Frame")
                    farmProgressFill.Size = UDim2.new(0, 0, 1, 0)
                    farmProgressFill.BackgroundColor3 = Color3.fromRGB(0, 125, 255)
                    farmProgressFill.BorderSizePixel = 0
                    farmProgressFill.Parent = progressBg
                    local fillCorner = Instance.new("UICorner")
                    fillCorner.CornerRadius = UDim.new(0, 4)
                    fillCorner.Parent = farmProgressFill

                    -- Текст цели
                    farmGoalLabel = Instance.new("TextLabel")
                    farmGoalLabel.Size = UDim2.new(1, 0, 0, 20)
                    farmGoalLabel.Position = UDim2.new(0, 0, 0, 114)
                    farmGoalLabel.BackgroundTransparency = 1
                    farmGoalLabel.Text = "Goal: Not set"
                    farmGoalLabel.TextColor3 = Color3.fromRGB(180, 180, 200)
                    farmGoalLabel.TextSize = 11
                    farmGoalLabel.Font = Enum.Font.Gotham
                    farmGoalLabel.TextXAlignment = Enum.TextXAlignment.Center
                    farmGoalLabel.Parent = farmStatsFrame

                    -- Поле ввода цели (теперь текст "0" по умолчанию)
                    farmGoalInput = Instance.new("TextBox")
                    farmGoalInput.Size = UDim2.new(0, 100, 0, 24)
                    farmGoalInput.Position = UDim2.new(0.05, 0, 0, 138)
                    farmGoalInput.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
                    farmGoalInput.TextColor3 = Color3.fromRGB(255, 255, 255)
                    farmGoalInput.TextSize = 13
                    farmGoalInput.Font = Enum.Font.Gotham
                    farmGoalInput.Text = "0"  -- <-- ИСПРАВЛЕНО: теперь 0
                    farmGoalInput.ClearTextOnFocus = false
                    farmGoalInput.Parent = farmStatsFrame
                    local inputCorner = Instance.new("UICorner")
                    inputCorner.CornerRadius = UDim.new(0, 4)
                    inputCorner.Parent = farmGoalInput

                    farmSetGoalBtn = Instance.new("TextButton")
                    farmSetGoalBtn.Size = UDim2.new(0, 70, 0, 24)
                    farmSetGoalBtn.Position = UDim2.new(0.55, 0, 0, 138)
                    farmSetGoalBtn.BackgroundColor3 = Color3.fromRGB(40, 160, 80)
                    farmSetGoalBtn.Text = "Set Goal"
                    farmSetGoalBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                    farmSetGoalBtn.TextSize = 12
                    farmSetGoalBtn.Font = Enum.Font.GothamBold
                    farmSetGoalBtn.BorderSizePixel = 0
                    farmSetGoalBtn.AutoButtonColor = false
                    farmSetGoalBtn.Parent = farmStatsFrame
                    local btnCorner = Instance.new("UICorner")
                    btnCorner.CornerRadius = UDim.new(0, 4)
                    btnCorner.Parent = farmSetGoalBtn

                    -- Обработчики
                    farmSetGoalBtn.MouseButton1Click:Connect(function()
                        local val = tonumber(farmGoalInput.Text)
                        if val and val > 0 then
                            farmGoal = val
                            farmGoalReached = false
                            sendNotification("Goal set to +" .. val, 2)
                            updateFarmStats()
                        else
                            sendNotification("Enter a positive number", 2)
                        end
                    end)

                    farmGoalInput.FocusLost:Connect(function(enter)
                        if enter then farmSetGoalBtn.MouseButton1Click:Fire() end
                    end)

                    -- Кнопка закрыть (скрывает окно, но фарм продолжается)
                    local closeStatsBtn = Instance.new("TextButton")
                    closeStatsBtn.Size = UDim2.new(0, 20, 0, 20)
                    closeStatsBtn.Position = UDim2.new(1, -24, 0, 4)
                    closeStatsBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
                    closeStatsBtn.BorderSizePixel = 0
                    closeStatsBtn.Text = "✕"
                    closeStatsBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                    closeStatsBtn.TextSize = 12
                    closeStatsBtn.Font = Enum.Font.SourceSansBold
                    closeStatsBtn.AutoButtonColor = false
                    closeStatsBtn.Parent = farmStatsFrame
                    local closeCorner = Instance.new("UICorner")
                    closeCorner.CornerRadius = UDim.new(0, 4)
                    closeCorner.Parent = closeStatsBtn
                    closeStatsBtn.MouseButton1Click:Connect(function()
                        if farmStatsFrame then farmStatsFrame.Visible = false end
                    end)
                end

                local function destroyFarmStats()
                    if farmStatsGui then
                        farmStatsGui:Destroy()
                        farmStatsGui = nil
                        farmStatsFrame = nil
                        farmTimerLabel = nil
                        farmGoldLabel = nil
                        farmProgressFill = nil
                        farmGoalLabel = nil
                        farmGoalInput = nil
                        farmSetGoalBtn = nil
                    end
                end

                -- ИСПРАВЛЕНО: логика подсчёта прироста
                local function updateFarmStats()
                    if not farmStatsFrame or not farmTimerLabel then return end
                    local currentGold = getGold()
                    farmEarnedGold = currentGold - farmStartGold
                    if farmEarnedGold < 0 then farmEarnedGold = 0 end

                    local elapsed = os.time() - farmStartTime
                    local mins = math.floor(elapsed / 60)
                    local secs = elapsed % 60
                    farmTimerLabel.Text = string.format("Time: %02d:%02d", mins, secs)
                    farmGoldLabel.Text = "Gold: " .. farmEarnedGold

                    if farmGoal and farmGoal > 0 then
                        local progress = math.min(farmEarnedGold / farmGoal, 1)
                        farmProgressFill.Size = UDim2.new(progress, 0, 1, 0)
                        farmGoalLabel.Text = "Goal: " .. farmEarnedGold .. " / " .. farmGoal
                        if not farmGoalReached and farmEarnedGold >= farmGoal then
                            farmGoalReached = true
                            sendNotification("Goal reached! Kicking...", 3)
                            task.wait(1)
                            LocalPlayer:Kick("Goal reached!")   -- <-- сообщение на английском
                        end
                    else
                        farmProgressFill.Size = UDim2.new(0, 0, 1, 0)
                        farmGoalLabel.Text = "Goal: Not set"
                    end
                end

                -- ============================================================
                -- ЛОГИКА АВТОФАРМА (с интеграцией статистики)
                -- ============================================================
                local autoFarmEnabled = false
                local farmTask = nil
                local farmRunning = false

                local function resetGravity()
                    Workspace.Gravity = 196.2
                end

                local function getPart(path)
                    local parts = {}
                    for partName in string.gmatch(path, "[^%.]+") do
                        table.insert(parts, partName)
                    end
                    local current = Workspace
                    for _, name in ipairs(parts) do
                        current = current and current:FindFirstChild(name)
                        if not current then break end
                    end
                    return current
                end

                local function flyTo(targetPosition, duration)
                    local char = LocalPlayer.Character
                    if not char then return false end
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    if not hrp then return false end
                    hrp.Velocity = Vector3.new(0, 0, 0)
                    hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                    local targetCFrame = CFrame.new(targetPosition)
                    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
                    local tween = TweenService:Create(hrp, tweenInfo, {CFrame = targetCFrame})
                    tween:Play()
                    local completed = false
                    tween.Completed:Connect(function()
                        completed = true
                    end)
                    while not completed and autoFarmEnabled and farmRunning do
                        task.wait(0.05)
                    end
                    return completed
                end

                local function waitForRespawn()
                    local char = LocalPlayer.Character
                    if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChildOfClass("Humanoid") and char.Humanoid.Health > 0 then
                        return true
                    end
                    local respawned = false
                    local event = LocalPlayer.CharacterAdded:Connect(function()
                        respawned = true
                        event:Disconnect()
                    end)
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and LocalPlayer.Character.Humanoid.Health > 0 then
                        respawned = true
                        event:Disconnect()
                    end
                    while not respawned and autoFarmEnabled and farmRunning do
                        task.wait(0.2)
                        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and LocalPlayer.Character.Humanoid.Health > 0 then
                            respawned = true
                            event:Disconnect()
                            break
                        end
                    end
                    return respawned
                end

                local function farmLoop()
                    farmRunning = true
                    while autoFarmEnabled and farmRunning do
                        local char = LocalPlayer.Character
                        while not char or not char:FindFirstChild("HumanoidRootPart") or not char:FindFirstChildOfClass("Humanoid") or char.Humanoid.Health <= 0 do
                            if not autoFarmEnabled or not farmRunning then return end
                            char = LocalPlayer.Character
                            task.wait(0.5)
                        end

                        Workspace.Gravity = 0

                        for stage = 1, 10 do
                            if not autoFarmEnabled or not farmRunning then break end
                            local path = "BoatStages.NormalStages.CaveStage" .. stage .. ".DarknessPart"
                            local part = getPart(path)
                            if part then
                                FarmStatusLabel.Text = "Flying to stage " .. stage
                                local success = flyTo(part.Position, 1.25)
                                if success then
                                    task.wait(1.5)
                                else
                                    FarmStatusLabel.Text = "Flight failed, retrying..."
                                    task.wait(1)
                                end
                            else
                                FarmStatusLabel.Text = "Stage " .. stage .. " not found"
                                task.wait(1)
                            end
                        end

                        if not autoFarmEnabled or not farmRunning then break end

                        local currentChar = LocalPlayer.Character
                        local hum = currentChar and currentChar:FindFirstChildOfClass("Humanoid")
                        if hum then
                            hum.Health = 0
                            FarmStatusLabel.Text = "Killed, respawning..."
                        end

                        local respawnSuccess = waitForRespawn()
                        if respawnSuccess then
                            FarmStatusLabel.Text = "Respawned, restarting cycle..."
                        else
                            FarmStatusLabel.Text = "Respawn failed, stopping farm"
                            break
                        end
                    end
                    farmRunning = false
                    resetGravity()
                    FarmStatusLabel.Text = "Idle"
                end

                local function setAutoFarm(state)
                    autoFarmEnabled = state
                    ToggleButtonFarm.Text = state and "ON" or "OFF"
                    ToggleButtonFarm.BackgroundColor3 = state and Color3.fromRGB(30, 180, 30) or Color3.fromRGB(180, 40, 40)
                    if state then
                        -- Запускаем статистику
                        farmStartGold = getGold()
                        farmStartTime = os.time()
                        farmEarnedGold = 0
                        farmGoalReached = false
                        createFarmStats()
                        if farmStatsFrame then farmStatsFrame.Visible = true end
                        if farmUpdateConnection then farmUpdateConnection:Disconnect() end
                        farmUpdateConnection = RunService.Heartbeat:Connect(function()
                            if autoFarmEnabled then updateFarmStats() end
                        end)
                        sendNotification("Auto Farm Enabled", 2)
                        FarmStatusLabel.Text = "Starting..."
                        if farmTask then
                            task.cancel(farmTask)
                            farmTask = nil
                        end
                        farmTask = task.spawn(farmLoop)
                    else
                        -- Останавливаем статистику
                        if farmUpdateConnection then
                            farmUpdateConnection:Disconnect()
                            farmUpdateConnection = nil
                        end
                        destroyFarmStats()
                        sendNotification("Auto Farm Disabled", 2)
                        farmRunning = false
                        if farmTask then
                            task.cancel(farmTask)
                            farmTask = nil
                        end
                        resetGravity()
                        FarmStatusLabel.Text = "Stopped"
                        farmGoal = nil
                    end
                end

                ToggleButtonFarm.MouseButton1Click:Connect(function()
                    setAutoFarm(not autoFarmEnabled)
                end)

                -- ============================================================
                -- СТРАНИЦА OTHER (Noclip + Inf Jump + Teleport Teams)
                -- ============================================================
                local OtherTitle = Instance.new("TextLabel")
                OtherTitle.Size = UDim2.new(1, 0, 0, 20)
                OtherTitle.BackgroundTransparency = 1
                OtherTitle.Text = "🎯 Other Features"
                OtherTitle.TextColor3 = Color3.fromRGB(200, 200, 220)
                OtherTitle.TextSize = 16
                OtherTitle.Font = Enum.Font.GothamBold
                OtherTitle.TextXAlignment = Enum.TextXAlignment.Left
                OtherTitle.Parent = OtherPage

                -- Noclip Toggle
                local ToggleFrameNoclip = Instance.new("Frame")
                ToggleFrameNoclip.Size = UDim2.new(1, 0, 0, 34)
                ToggleFrameNoclip.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
                ToggleFrameNoclip.BorderSizePixel = 0
                ToggleFrameNoclip.Parent = OtherPage
                local ToggleCornerNoclip = Instance.new("UICorner")
                ToggleCornerNoclip.CornerRadius = UDim.new(0, 4)
                ToggleCornerNoclip.Parent = ToggleFrameNoclip

                local RowNoclip = Instance.new("Frame")
                RowNoclip.Size = UDim2.new(1, 0, 1, 0)
                RowNoclip.BackgroundTransparency = 1
                RowNoclip.Parent = ToggleFrameNoclip

                local NoclipIcon = Instance.new("TextLabel")
                NoclipIcon.Size = UDim2.new(0, 16, 0, 16)
                NoclipIcon.Position = UDim2.new(0, 6, 0, 9)
                NoclipIcon.BackgroundTransparency = 1
                NoclipIcon.Text = "🌀"
                NoclipIcon.TextSize = 14
                NoclipIcon.Parent = RowNoclip

                local ToggleLabelNoclip = Instance.new("TextLabel")
                ToggleLabelNoclip.Size = UDim2.new(0, 26, 1, 0)
                ToggleLabelNoclip.Position = UDim2.new(0, 26, 0, 0)
                ToggleLabelNoclip.BackgroundTransparency = 1
                ToggleLabelNoclip.Text = "Noclip"
                ToggleLabelNoclip.TextColor3 = Color3.fromRGB(255, 255, 255)
                ToggleLabelNoclip.TextSize = 12
                ToggleLabelNoclip.Font = Enum.Font.SourceSansBold
                ToggleLabelNoclip.TextXAlignment = Enum.TextXAlignment.Left
                ToggleLabelNoclip.Parent = RowNoclip

                local NoclipStatusLabel = Instance.new("TextLabel")
                NoclipStatusLabel.Size = UDim2.new(0, 110, 1, 0)
                NoclipStatusLabel.Position = UDim2.new(0, 82, 0, 0)
                NoclipStatusLabel.BackgroundTransparency = 1
                NoclipStatusLabel.Text = "Off"
                NoclipStatusLabel.TextColor3 = Color3.fromRGB(180, 180, 210)
                NoclipStatusLabel.TextSize = 10
                NoclipStatusLabel.Font = Enum.Font.SourceSans
                NoclipStatusLabel.TextXAlignment = Enum.TextXAlignment.Left
                NoclipStatusLabel.Parent = RowNoclip

                local ToggleButtonNoclip = Instance.new("TextButton")
                ToggleButtonNoclip.Size = UDim2.new(0, 36, 0, 18)
                ToggleButtonNoclip.Position = UDim2.new(1, -40, 0, 8)
                ToggleButtonNoclip.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
                ToggleButtonNoclip.BorderSizePixel = 0
                ToggleButtonNoclip.Text = "OFF"
                ToggleButtonNoclip.TextColor3 = Color3.fromRGB(255, 255, 255)
                ToggleButtonNoclip.TextSize = 10
                ToggleButtonNoclip.Font = Enum.Font.SourceSansBold
                ToggleButtonNoclip.AutoButtonColor = false
                ToggleButtonNoclip.Parent = RowNoclip
                local ToggleCornerBtnNoclip = Instance.new("UICorner")
                ToggleCornerBtnNoclip.CornerRadius = UDim.new(0, 3)
                ToggleCornerBtnNoclip.Parent = ToggleButtonNoclip

                -- Inf Jump Toggle
                local ToggleFrameInfJump = Instance.new("Frame")
                ToggleFrameInfJump.Size = UDim2.new(1, 0, 0, 34)
                ToggleFrameInfJump.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
                ToggleFrameInfJump.BorderSizePixel = 0
                ToggleFrameInfJump.Parent = OtherPage
                local ToggleCornerInfJump = Instance.new("UICorner")
                ToggleCornerInfJump.CornerRadius = UDim.new(0, 4)
                ToggleCornerInfJump.Parent = ToggleFrameInfJump

                local RowInfJump = Instance.new("Frame")
                RowInfJump.Size = UDim2.new(1, 0, 1, 0)
                RowInfJump.BackgroundTransparency = 1
                RowInfJump.Parent = ToggleFrameInfJump

                local InfJumpIcon = Instance.new("TextLabel")
                InfJumpIcon.Size = UDim2.new(0, 16, 0, 16)
                InfJumpIcon.Position = UDim2.new(0, 6, 0, 9)
                InfJumpIcon.BackgroundTransparency = 1
                InfJumpIcon.Text = "🦘"
                InfJumpIcon.TextSize = 14
                InfJumpIcon.Parent = RowInfJump

                local ToggleLabelInfJump = Instance.new("TextLabel")
                ToggleLabelInfJump.Size = UDim2.new(0, 26, 1, 0)
                ToggleLabelInfJump.Position = UDim2.new(0, 26, 0, 0)
                ToggleLabelInfJump.BackgroundTransparency = 1
                ToggleLabelInfJump.Text = "Inf Jump"
                ToggleLabelInfJump.TextColor3 = Color3.fromRGB(255, 255, 255)
                ToggleLabelInfJump.TextSize = 12
                ToggleLabelInfJump.Font = Enum.Font.SourceSansBold
                ToggleLabelInfJump.TextXAlignment = Enum.TextXAlignment.Left
                ToggleLabelInfJump.Parent = RowInfJump

                local InfJumpStatusLabel = Instance.new("TextLabel")
                InfJumpStatusLabel.Size = UDim2.new(0, 110, 1, 0)
                InfJumpStatusLabel.Position = UDim2.new(0, 82, 0, 0)
                InfJumpStatusLabel.BackgroundTransparency = 1
                InfJumpStatusLabel.Text = "Off"
                InfJumpStatusLabel.TextColor3 = Color3.fromRGB(180, 180, 210)
                InfJumpStatusLabel.TextSize = 10
                InfJumpStatusLabel.Font = Enum.Font.SourceSans
                InfJumpStatusLabel.TextXAlignment = Enum.TextXAlignment.Left
                InfJumpStatusLabel.Parent = RowInfJump

                local ToggleButtonInfJump = Instance.new("TextButton")
                ToggleButtonInfJump.Size = UDim2.new(0, 36, 0, 18)
                ToggleButtonInfJump.Position = UDim2.new(1, -40, 0, 8)
                ToggleButtonInfJump.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
                ToggleButtonInfJump.BorderSizePixel = 0
                ToggleButtonInfJump.Text = "OFF"
                ToggleButtonInfJump.TextColor3 = Color3.fromRGB(255, 255, 255)
                ToggleButtonInfJump.TextSize = 10
                ToggleButtonInfJump.Font = Enum.Font.SourceSansBold
                ToggleButtonInfJump.AutoButtonColor = false
                ToggleButtonInfJump.Parent = RowInfJump
                local ToggleCornerBtnInfJump = Instance.new("UICorner")
                ToggleCornerBtnInfJump.CornerRadius = UDim.new(0, 3)
                ToggleCornerBtnInfJump.Parent = ToggleButtonInfJump

                -- Teleport Teams Toggle
                local ToggleFrameTeleport = Instance.new("Frame")
                ToggleFrameTeleport.Size = UDim2.new(1, 0, 0, 34)
                ToggleFrameTeleport.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
                ToggleFrameTeleport.BorderSizePixel = 0
                ToggleFrameTeleport.Parent = OtherPage
                local ToggleCornerTeleport = Instance.new("UICorner")
                ToggleCornerTeleport.CornerRadius = UDim.new(0, 4)
                ToggleCornerTeleport.Parent = ToggleFrameTeleport

                local RowTeleport = Instance.new("Frame")
                RowTeleport.Size = UDim2.new(1, 0, 1, 0)
                RowTeleport.BackgroundTransparency = 1
                RowTeleport.Parent = ToggleFrameTeleport

                local TeleportIcon = Instance.new("TextLabel")
                TeleportIcon.Size = UDim2.new(0, 16, 0, 16)
                TeleportIcon.Position = UDim2.new(0, 6, 0, 9)
                TeleportIcon.BackgroundTransparency = 1
                TeleportIcon.Text = "📍"
                TeleportIcon.TextSize = 14
                TeleportIcon.Parent = RowTeleport

                local ToggleLabelTeleport = Instance.new("TextLabel")
                ToggleLabelTeleport.Size = UDim2.new(0, 26, 1, 0)
                ToggleLabelTeleport.Position = UDim2.new(0, 26, 0, 0)
                ToggleLabelTeleport.BackgroundTransparency = 1
                ToggleLabelTeleport.Text = "Teleport Teams"
                ToggleLabelTeleport.TextColor3 = Color3.fromRGB(255, 255, 255)
                ToggleLabelTeleport.TextSize = 12
                ToggleLabelTeleport.Font = Enum.Font.SourceSansBold
                ToggleLabelTeleport.TextXAlignment = Enum.TextXAlignment.Left
                ToggleLabelTeleport.Parent = RowTeleport

                local TeleportStatusLabel = Instance.new("TextLabel")
                TeleportStatusLabel.Size = UDim2.new(0, 110, 1, 0)
                TeleportStatusLabel.Position = UDim2.new(0, 82, 0, 0)
                TeleportStatusLabel.BackgroundTransparency = 1
                TeleportStatusLabel.Text = "Off"
                TeleportStatusLabel.TextColor3 = Color3.fromRGB(180, 180, 210)
                TeleportStatusLabel.TextSize = 10
                TeleportStatusLabel.Font = Enum.Font.SourceSans
                TeleportStatusLabel.TextXAlignment = Enum.TextXAlignment.Left
                TeleportStatusLabel.Parent = RowTeleport

                local ToggleButtonTeleport = Instance.new("TextButton")
                ToggleButtonTeleport.Size = UDim2.new(0, 36, 0, 18)
                ToggleButtonTeleport.Position = UDim2.new(1, -40, 0, 8)
                ToggleButtonTeleport.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
                ToggleButtonTeleport.BorderSizePixel = 0
                ToggleButtonTeleport.Text = "OFF"
                ToggleButtonTeleport.TextColor3 = Color3.fromRGB(255, 255, 255)
                ToggleButtonTeleport.TextSize = 10
                ToggleButtonTeleport.Font = Enum.Font.SourceSansBold
                ToggleButtonTeleport.AutoButtonColor = false
                ToggleButtonTeleport.Parent = RowTeleport
                local ToggleCornerBtnTeleport = Instance.new("UICorner")
                ToggleCornerBtnTeleport.CornerRadius = UDim.new(0, 3)
                ToggleCornerBtnTeleport.Parent = ToggleButtonTeleport

                -- ============================================================
                -- GUI для телепорта на команды
                -- ============================================================
                local TeleportGUI = Instance.new("Frame")
                TeleportGUI.Size = UDim2.new(0, 400, 0, 60)
                TeleportGUI.Position = UDim2.new(0.5, -200, 0, 20)
                TeleportGUI.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                TeleportGUI.BackgroundTransparency = 0.5
                TeleportGUI.BorderSizePixel = 1
                TeleportGUI.BorderColor3 = Color3.fromRGB(40, 40, 40)
                TeleportGUI.Visible = false
                TeleportGUI.ClipsDescendants = false
                TeleportGUI.ZIndex = 5
                TeleportGUI.Parent = ScreenGui
                local TeleportGUICorner = Instance.new("UICorner")
                TeleportGUICorner.CornerRadius = UDim.new(0, 8)
                TeleportGUICorner.Parent = TeleportGUI

                local TeleportCloseBtn = Instance.new("TextButton")
                TeleportCloseBtn.Size = UDim2.new(0, 28, 0, 28)
                TeleportCloseBtn.Position = UDim2.new(1, -34, 0, 4)
                TeleportCloseBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
                TeleportCloseBtn.BorderSizePixel = 0
                TeleportCloseBtn.Text = "✕"
                TeleportCloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                TeleportCloseBtn.TextSize = 16
                TeleportCloseBtn.Font = Enum.Font.SourceSansBold
                TeleportCloseBtn.AutoButtonColor = false
                TeleportCloseBtn.ZIndex = 6
                TeleportCloseBtn.Parent = TeleportGUI
                local TeleportCloseCorner = Instance.new("UICorner")
                TeleportCloseCorner.CornerRadius = UDim.new(0, 4)
                TeleportCloseCorner.Parent = TeleportCloseBtn

                local ColorsFrame = Instance.new("Frame")
                ColorsFrame.Size = UDim2.new(1, -60, 1, -10)
                ColorsFrame.Position = UDim2.new(0, 10, 0, 5)
                ColorsFrame.BackgroundTransparency = 1
                ColorsFrame.Parent = TeleportGUI

                local ColorsLayout = Instance.new("UIListLayout")
                ColorsLayout.FillDirection = Enum.FillDirection.Horizontal
                ColorsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
                ColorsLayout.VerticalAlignment = Enum.VerticalAlignment.Center
                ColorsLayout.Padding = UDim.new(0, 6)
                ColorsLayout.Parent = ColorsFrame

                local teamData = {
                    {Name = "CamoZone", Color = Color3.fromRGB(0, 255, 0)},
                    {Name = "BlackZone", Color = Color3.fromRGB(0, 0, 0)},
                    {Name = "MagentaZone", Color = Color3.fromRGB(128, 0, 128)},
                    {Name = "New YellerZone", Color = Color3.fromRGB(255, 255, 0)},
                    {Name = "Really blueZone", Color = Color3.fromRGB(0, 0, 255)},
                    {Name = "Really redZone", Color = Color3.fromRGB(255, 0, 0)},
                    {Name = "WhiteZone", Color = Color3.fromRGB(255, 255, 255)},
                }

                local teamButtons = {}
                for _, data in ipairs(teamData) do
                    local btn = Instance.new("TextButton")
                    btn.Size = UDim2.new(0, 40, 0, 40)
                    btn.BackgroundColor3 = data.Color
                    btn.BorderSizePixel = 1
                    btn.BorderColor3 = Color3.fromRGB(60, 60, 60)
                    btn.Text = ""
                    btn.AutoButtonColor = false
                    btn.ZIndex = 6
                    btn.Parent = ColorsFrame
                    local btnCorner = Instance.new("UICorner")
                    btnCorner.CornerRadius = UDim.new(1, 0)
                    btnCorner.Parent = btn
                    if data.Name == "BlackZone" then
                        btn.BorderColor3 = Color3.fromRGB(200, 200, 200)
                    end
                    btn.Name = data.Name
                    table.insert(teamButtons, btn)
                end

                -- ============================================================
                -- ЛОГИКА РАСКРЫТИЯ КАТЕГОРИЙ
                -- ============================================================
                local function toggleCategory(header, content, arrow)
                    local isOpen = content.Visible
                    content.Visible = not isOpen
                    arrow.Text = (not isOpen) and "▼" or "▶"
                    task.wait(0.05)
                    updateCanvasSize()
                end

                headerESP.MouseButton1Click:Connect(function()
                    toggleCategory(headerESP, contentESP, arrowESP)
                end)

                headerFarm.MouseButton1Click:Connect(function()
                    toggleCategory(headerFarm, contentFarm, arrowFarm)
                end)

                contentESP.Visible = true
                arrowESP.Text = "▼"
                contentFarm.Visible = false
                arrowFarm.Text = "▶"

                -- ============================================================
                -- КНОПКА ГОТОВНОСТИ СПЕКТАТОРА
                -- ============================================================
                local SpectatorReadyBtn = Instance.new("TextButton")
                SpectatorReadyBtn.Size = UDim2.new(0, 50, 0, 50)
                SpectatorReadyBtn.Position = UDim2.new(0, 10, 1, -60)
                SpectatorReadyBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SpectatorReadyBtn.Text = "👁"
                SpectatorReadyBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
                SpectatorReadyBtn.TextSize = 28
                SpectatorReadyBtn.Font = Enum.Font.SourceSansBold
                SpectatorReadyBtn.BorderSizePixel = 0
                SpectatorReadyBtn.AutoButtonColor = false
                SpectatorReadyBtn.Visible = false
                SpectatorReadyBtn.ZIndex = 10
                SpectatorReadyBtn.Parent = ScreenGui
                local ReadyCorner = Instance.new("UICorner")
                ReadyCorner.CornerRadius = UDim.new(1, 0)
                ReadyCorner.Parent = SpectatorReadyBtn

                SpectatorReadyBtn.MouseEnter:Connect(function()
                    TweenService:Create(SpectatorReadyBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(230, 230, 230)}):Play()
                end)
                SpectatorReadyBtn.MouseLeave:Connect(function()
                    TweenService:Create(SpectatorReadyBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
                end)

                -- ============================================================
                -- СПЕКТАТОР UI
                -- ============================================================
                local SpectatorUI = Instance.new("Frame")
                SpectatorUI.Size = UDim2.new(0, 500, 0, 120)
                SpectatorUI.Position = UDim2.new(0.5, -250, 1, -140)
                SpectatorUI.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                SpectatorUI.BackgroundTransparency = 0.5
                SpectatorUI.BorderSizePixel = 2
                SpectatorUI.BorderColor3 = Color3.fromRGB(60, 60, 80)
                SpectatorUI.Visible = false
                SpectatorUI.Parent = ScreenGui
                local SpectatorUICorner = Instance.new("UICorner")
                SpectatorUICorner.CornerRadius = UDim.new(0, 12)
                SpectatorUICorner.Parent = SpectatorUI

                local SpectatorExitBtn = Instance.new("TextButton")
                SpectatorExitBtn.Size = UDim2.new(0, 42, 0, 42)
                SpectatorExitBtn.Position = UDim2.new(0.5, -21, 0, 6)
                SpectatorExitBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
                SpectatorExitBtn.Text = "👁️‍🗨️"
                SpectatorExitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                SpectatorExitBtn.TextSize = 24
                SpectatorExitBtn.Font = Enum.Font.SourceSansBold
                SpectatorExitBtn.BorderSizePixel = 0
                SpectatorExitBtn.AutoButtonColor = false
                SpectatorExitBtn.Parent = SpectatorUI
                local SpectatorExitCorner = Instance.new("UICorner")
                SpectatorExitCorner.CornerRadius = UDim.new(1, 0)
                SpectatorExitCorner.Parent = SpectatorExitBtn

                local SpectatorLeft = Instance.new("TextButton")
                SpectatorLeft.Size = UDim2.new(0, 70, 0, 70)
                SpectatorLeft.Position = UDim2.new(0, 8, 0.5, -35)
                SpectatorLeft.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
                SpectatorLeft.Text = "◄"
                SpectatorLeft.TextColor3 = Color3.fromRGB(200, 200, 220)
                SpectatorLeft.TextSize = 35
                SpectatorLeft.Font = Enum.Font.SourceSansBold
                SpectatorLeft.BorderSizePixel = 0
                SpectatorLeft.AutoButtonColor = false
                SpectatorLeft.Parent = SpectatorUI
                local SpectatorLeftCorner = Instance.new("UICorner")
                SpectatorLeftCorner.CornerRadius = UDim.new(0, 10)
                SpectatorLeftCorner.Parent = SpectatorLeft

                local SpectatorRight = Instance.new("TextButton")
                SpectatorRight.Size = UDim2.new(0, 70, 0, 70)
                SpectatorRight.Position = UDim2.new(1, -78, 0.5, -35)
                SpectatorRight.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
                SpectatorRight.Text = "►"
                SpectatorRight.TextColor3 = Color3.fromRGB(200, 200, 220)
                SpectatorRight.TextSize = 35
                SpectatorRight.Font = Enum.Font.SourceSansBold
                SpectatorRight.BorderSizePixel = 0
                SpectatorRight.AutoButtonColor = false
                SpectatorRight.Parent = SpectatorUI
                local SpectatorRightCorner = Instance.new("UICorner")
                SpectatorRightCorner.CornerRadius = UDim.new(0, 10)
                SpectatorRightCorner.Parent = SpectatorRight

                local SpectatorNameLabel = Instance.new("TextLabel")
                SpectatorNameLabel.Size = UDim2.new(1, -200, 1, 0)
                SpectatorNameLabel.Position = UDim2.new(0, 100, 0, 0)
                SpectatorNameLabel.BackgroundTransparency = 1
                SpectatorNameLabel.Text = "@PlayerName"
                SpectatorNameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                SpectatorNameLabel.TextSize = 36
                SpectatorNameLabel.Font = Enum.Font.GothamBold
                SpectatorNameLabel.TextXAlignment = Enum.TextXAlignment.Center
                SpectatorNameLabel.TextYAlignment = Enum.TextYAlignment.Center
                SpectatorNameLabel.Parent = SpectatorUI

                -- ============================================================
                -- СТРАНИЦА SETTINGS
                -- ============================================================
                local SettingsTitle = Instance.new("TextLabel")
                SettingsTitle.Size = UDim2.new(1, 0, 0, 20)
                SettingsTitle.BackgroundTransparency = 1
                SettingsTitle.Text = "⚙️ Settings"
                SettingsTitle.TextColor3 = Color3.fromRGB(200, 200, 220)
                SettingsTitle.TextSize = 16
                SettingsTitle.Font = Enum.Font.GothamBold
                SettingsTitle.TextXAlignment = Enum.TextXAlignment.Left
                SettingsTitle.Parent = SettingsPage

                local currentSpeed = 16
                local currentJumpPower = 50

                local function applyCharacterSettings()
                    local char = LocalPlayer.Character
                    if not char then
                        task.delay(0.5, applyCharacterSettings)
                        return
                    end
                    local humanoid = char:FindFirstChildOfClass("Humanoid")
                    if not humanoid then
                        task.delay(0.5, applyCharacterSettings)
                        return
                    end
                    humanoid.WalkSpeed = currentSpeed
                    humanoid.JumpPower = currentJumpPower
                end

                LocalPlayer.CharacterAdded:Connect(function()
                    task.wait(0.5)
                    applyCharacterSettings()
                end)

                local function createSettingRow(parent, labelText, defaultText, labelUpdateFunc, applyFunc, resetFunc, hasReset)
                    local row = Instance.new("Frame")
                    row.Size = UDim2.new(1, 0, 0, 30)
                    row.BackgroundTransparency = 1
                    row.Parent = parent

                    local label = Instance.new("TextLabel")
                    label.Size = UDim2.new(0, 80, 1, 0)
                    label.BackgroundTransparency = 1
                    label.Text = labelText
                    label.TextColor3 = Color3.fromRGB(180, 180, 210)
                    label.TextSize = 13
                    label.Font = Enum.Font.Gotham
                    label.TextXAlignment = Enum.TextXAlignment.Left
                    label.Parent = row

                    local input = Instance.new("TextBox")
                    input.Size = UDim2.new(0, 70, 1, -4)
                    input.Position = UDim2.new(0, 80, 0, 2)
                    input.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
                    input.TextColor3 = Color3.fromRGB(255, 255, 255)
                    input.TextSize = 13
                    input.Font = Enum.Font.Gotham
                    input.Text = defaultText
                    input.ClearTextOnFocus = false
                    input.BorderSizePixel = 1
                    input.BorderColor3 = Color3.fromRGB(60, 60, 80)
                    input.Parent = row
                    local inputCorner = Instance.new("UICorner")
                    inputCorner.CornerRadius = UDim.new(0, 4)
                    inputCorner.Parent = input

                    local applyBtn = Instance.new("TextButton")
                    applyBtn.Size = UDim2.new(0, 50, 1, -4)
                    applyBtn.Position = UDim2.new(0, 155, 0, 2)
                    applyBtn.BackgroundColor3 = Color3.fromRGB(40, 160, 80)
                    applyBtn.Text = "Apply"
                    applyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                    applyBtn.TextSize = 12
                    applyBtn.Font = Enum.Font.GothamBold
                    applyBtn.BorderSizePixel = 0
                    applyBtn.AutoButtonColor = false
                    applyBtn.Parent = row
                    local applyCorner = Instance.new("UICorner")
                    applyCorner.CornerRadius = UDim.new(0, 4)
                    applyCorner.Parent = applyBtn

                    local resetBtn
                    if hasReset then
                        resetBtn = Instance.new("TextButton")
                        resetBtn.Size = UDim2.new(0, 50, 1, -4)
                        resetBtn.Position = UDim2.new(0, 210, 0, 2)
                        resetBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
                        resetBtn.Text = "Reset"
                        resetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                        resetBtn.TextSize = 12
                        resetBtn.Font = Enum.Font.GothamBold
                        resetBtn.BorderSizePixel = 0
                        resetBtn.AutoButtonColor = false
                        resetBtn.Parent = row
                        local resetCorner = Instance.new("UICorner")
                        resetCorner.CornerRadius = UDim.new(0, 4)
                        resetCorner.Parent = resetBtn
                    end

                    local function setupBtnHover(btn, hover, normal)
                        btn.MouseEnter:Connect(function() TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = hover}):Play() end)
                        btn.MouseLeave:Connect(function() TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = normal}):Play() end)
                    end
                    setupBtnHover(applyBtn, Color3.fromRGB(60, 200, 100), Color3.fromRGB(40, 160, 80))
                    if hasReset then
                        setupBtnHover(resetBtn, Color3.fromRGB(220, 60, 60), Color3.fromRGB(180, 40, 40))
                    end

                    applyBtn.MouseButton1Click:Connect(function()
                        local val = tonumber(input.Text)
                        if val and val > 0 then
                            labelUpdateFunc(val, label)
                            applyFunc(val)
                        end
                    end)

                    if hasReset then
                        resetBtn.MouseButton1Click:Connect(function()
                            local default = tonumber(defaultText)
                            input.Text = defaultText
                            labelUpdateFunc(default, label)
                            resetFunc()
                        end)
                    end

                    return {label = label, input = input, apply = applyBtn, reset = resetBtn}
                end

                local radiusRow = createSettingRow(SettingsPage, "ESP Radius", "5000",
                    function(val, label) label.Text = "ESP Radius: " .. val end,
                    function(val)
                        MAX_DISTANCE = val
                        InfoLabel.Text = "Players: " .. (#Players:GetPlayers()-1) .. " | R:" .. val
                    end,
                    nil, false
                )

                local speedRow = createSettingRow(SettingsPage, "Speed", tostring(currentSpeed),
                    function(val, label) label.Text = "Speed: " .. val end,
                    function(val)
                        currentSpeed = val
                        applyCharacterSettings()
                    end,
                    function()
                        currentSpeed = 16
                        applyCharacterSettings()
                    end,
                    true
                )

                local jumpRow = createSettingRow(SettingsPage, "Jump Power", tostring(currentJumpPower),
                    function(val, label) label.Text = "Jump Power: " .. val end,
                    function(val)
                        currentJumpPower = val
                        applyCharacterSettings()
                    end,
                    function()
                        currentJumpPower = 50
                        applyCharacterSettings()
                    end,
                    true
                )

                -- ============================================================
                -- НАВИГАЦИЯ ПО СТРАНИЦАМ
                -- ============================================================
                local function SwitchPage(page)
                    if page == "Main" then
                        MainPage.Visible = true
                        OtherPage.Visible = false
                        SettingsPage.Visible = false
                        MainNavBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
                        OtherNavBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
                        SettingsNavBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
                    elseif page == "Other" then
                        MainPage.Visible = false
                        OtherPage.Visible = true
                        SettingsPage.Visible = false
                        MainNavBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
                        OtherNavBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
                        SettingsNavBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
                    else -- Settings
                        MainPage.Visible = false
                        OtherPage.Visible = false
                        SettingsPage.Visible = true
                        MainNavBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
                        OtherNavBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
                        SettingsNavBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
                    end
                    updateCanvasSize()
                end

                MainNavBtn.MouseButton1Click:Connect(function()
                    SwitchPage("Main")
                end)

                OtherNavBtn.MouseButton1Click:Connect(function()
                    SwitchPage("Other")
                end)

                SettingsNavBtn.MouseButton1Click:Connect(function()
                    SwitchPage("Settings")
                end)

                -- ============================================================
                -- ФУНКЦИЯ ОБНОВЛЕНИЯ ПРОКРУТКИ
                -- ============================================================
                local function updateCanvasSize()
                    task.wait(0.05)
                    local visiblePage = nil
                    if MainPage.Visible then visiblePage = MainPage
                    elseif OtherPage.Visible then visiblePage = OtherPage
                    elseif SettingsPage.Visible then visiblePage = SettingsPage
                    end
                    if not visiblePage then return end
                    local layout = visiblePage:FindFirstChildOfClass("UIListLayout")
                    if layout then
                        ScrollContainer.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 20)
                    else
                        local total = 0
                        for _, child in ipairs(visiblePage:GetChildren()) do
                            if child:IsA("Frame") or child:IsA("TextLabel") or child:IsA("TextButton") then
                                total = total + child.Size.Y.Offset + 4
                            end
                        end
                        ScrollContainer.CanvasSize = UDim2.new(0, 0, 0, total + 20)
                    end
                end

                local function setupAutoUpdate(page)
                    local layout = page:FindFirstChildOfClass("UIListLayout")
                    if layout then
                        layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateCanvasSize)
                    end
                end

                setupAutoUpdate(MainPage)
                setupAutoUpdate(OtherPage)
                setupAutoUpdate(SettingsPage)

                -- ============================================================
                -- ESP SYSTEM
                -- ============================================================
                local espEnabled = false
                local highlights = {}
                local nametags = {}
                local heartbeatConnection

                local function updateHighlight(player, enable)
                    if enable then
                        if not highlights[player] then
                            local char = player.Character
                            if char then
                                local hl = Instance.new("Highlight")
                                hl.Name = "ESP_Highlight"
                                hl.FillTransparency = 1
                                hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                                hl.OutlineTransparency = 0
                                hl.Adornee = char
                                hl.Parent = char
                                highlights[player] = hl
                            end
                        end
                    else
                        if highlights[player] then
                            highlights[player]:Destroy()
                            highlights[player] = nil
                        end
                    end
                end

                local function updateNametag(player, enable)
                    if enable then
                        if not nametags[player] then
                            local char = player.Character
                            if char and char:FindFirstChild("Head") then
                                local bill = Instance.new("BillboardGui")
                                bill.Name = "ESP_Nametag"
                                bill.Adornee = char.Head
                                bill.Size = UDim2.new(0, 200, 0, 28)
                                bill.StudsOffset = Vector3.new(0, 1.5, 0)
                                bill.AlwaysOnTop = true
                                bill.Parent = char
                                local label = Instance.new("TextLabel")
                                label.Size = UDim2.new(1, 0, 1, 0)
                                label.BackgroundTransparency = 1
                                label.TextColor3 = Color3.fromRGB(255, 255, 255)
                                label.TextStrokeTransparency = 0.7
                                label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                                label.TextSize = 14
                                label.Font = Enum.Font.SourceSansBold
                                label.Text = player.Name
                                label.Parent = bill
                                nametags[player] = bill
                            end
                        else
                            local bill = nametags[player]
                            if bill and bill.Parent and bill.Adornee then
                                local label = bill:FindFirstChildOfClass("TextLabel")
                                if label then label.Text = player.Name end
                            end
                        end
                    else
                        if nametags[player] then
                            nametags[player]:Destroy()
                            nametags[player] = nil
                        end
                    end
                end

                local function clearAllESP()
                    for _, hl in pairs(highlights) do hl:Destroy() end
                    highlights = {}
                    for _, tag in pairs(nametags) do tag:Destroy() end
                    nametags = {}
                end

                local function refreshESP()
                    if not espEnabled then return end
                    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if not root then clearAllESP() return end
                    local myPos = root.Position
                    for _, player in ipairs(Players:GetPlayers()) do
                        if player == LocalPlayer then continue end
                        local char = player.Character
                        if char and char:FindFirstChild("HumanoidRootPart") then
                            local dist = (char.HumanoidRootPart.Position - myPos).Magnitude
                            if dist <= MAX_DISTANCE then
                                updateHighlight(player, true)
                                updateNametag(player, true)
                            else
                                updateHighlight(player, false)
                                updateNametag(player, false)
                            end
                        else
                            updateHighlight(player, false)
                            updateNametag(player, false)
                        end
                    end
                end

                local function setESP(state)
                    espEnabled = state
                    ToggleButtonESP.Text = state and "ON" or "OFF"
                    ToggleButtonESP.BackgroundColor3 = state and Color3.fromRGB(30, 180, 30) or Color3.fromRGB(180, 40, 40)
                    if state then
                        sendNotification("ESP Enabled", 2)
                        refreshESP()
                        if not heartbeatConnection then
                            heartbeatConnection = RunService.Heartbeat:Connect(function()
                                if espEnabled then refreshESP() end
                            end)
                        end
                    else
                        sendNotification("ESP Disabled", 2)
                        clearAllESP()
                        if heartbeatConnection then
                            heartbeatConnection:Disconnect()
                            heartbeatConnection = nil
                        end
                    end
                end

                ToggleButtonESP.MouseButton1Click:Connect(function()
                    setESP(not espEnabled)
                end)

                -- ===== PLAYER EVENTS for ESP =====
                local function onCharAdded(player, char)
                    if espEnabled then task.wait(0.5) refreshESP() end
                end

                local function onCharRemoving(player, char)
                    updateHighlight(player, false)
                    updateNametag(player, false)
                end

                for _, player in ipairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer then
                        player.CharacterAdded:Connect(function(char) onCharAdded(player, char) end)
                        player.CharacterRemoving:Connect(function(char) onCharRemoving(player, char) end)
                        if player.Character then task.spawn(function() onCharAdded(player, player.Character) end) end
                    end
                end

                Players.PlayerAdded:Connect(function(player)
                    player.CharacterAdded:Connect(function(char) onCharAdded(player, char) end)
                    player.CharacterRemoving:Connect(function(char) onCharRemoving(player, char) end)
                end)

                Players.PlayerRemoving:Connect(function(player)
                    updateHighlight(player, false)
                    updateNametag(player, false)
                end)

                -- ===== UPDATE INFO =====
                local function updateInfo()
                    local count = #Players:GetPlayers() - 1
                    InfoLabel.Text = "Players: " .. count .. " | R:" .. MAX_DISTANCE
                end

                Players.PlayerAdded:Connect(updateInfo)
                Players.PlayerRemoving:Connect(updateInfo)
                updateInfo()

                -- ============================================================
                -- СПЕКТАТОР СИСТЕМА
                -- ============================================================
                local spectatorFunctionEnabled = false
                local spectatorReady = false
                local spectatorActive = false
                local spectatorPlayers = {}
                local spectatorIndex = 1
                local spectatorConnection = nil
                local cameraTypeBackup = Enum.CameraType.Custom
                local cameraSmoothPosition = Vector3.new()
                local isFirstFrame = true

                local function getValidPlayers()
                    local list = {}
                    for _, player in ipairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
                            table.insert(list, player)
                        end
                    end
                    return list
                end

                local function updateSpectatorUI()
                    local players = getValidPlayers()
                    if #players == 0 then
                        SpectatorNameLabel.Text = "@No players"
                        SpectatorUI.Visible = true
                        return
                    end
                    if spectatorIndex > #players then spectatorIndex = 1 end
                    if spectatorIndex < 1 then spectatorIndex = #players end
                    local target = players[spectatorIndex]
                    if target then
                        SpectatorNameLabel.Text = "@" .. target.Name
                    else
                        SpectatorNameLabel.Text = "@Unknown"
                    end
                    SpectatorUI.Visible = true
                end

                local function switchSpectator(direction)
                    local players = getValidPlayers()
                    if #players == 0 then return end
                    spectatorIndex = spectatorIndex + direction
                    if spectatorIndex > #players then spectatorIndex = 1 end
                    if spectatorIndex < 1 then spectatorIndex = #players end
                    updateSpectatorUI()
                    isFirstFrame = true
                end

                local function updateCamera()
                    if not spectatorActive then return end
                    local players = getValidPlayers()
                    if #players == 0 then
                        return
                    end
                    if spectatorIndex > #players then spectatorIndex = 1 end
                    if spectatorIndex < 1 then spectatorIndex = #players end
                    local target = players[spectatorIndex]
                    if not target or not target.Character then
                        switchSpectator(1)
                        return
                    end
                    local root = target.Character:FindFirstChild("HumanoidRootPart")
                    if not root then return end
                    local head = target.Character:FindFirstChild("Head")
                    local centerPos = head and head.Position or root.Position
                    local lookDirection = root.CFrame.LookVector
                    local distance = 10
                    local height = 3
                    local offset = -lookDirection * distance + Vector3.new(0, height, 0)
                    local targetPos = centerPos + offset
                    if isFirstFrame then
                        cameraSmoothPosition = targetPos
                        isFirstFrame = false
                    else
                        cameraSmoothPosition = cameraSmoothPosition:Lerp(targetPos, 0.15)
                    end
                    Camera.CFrame = CFrame.new(cameraSmoothPosition, centerPos)
                end

                local function startSpectator()
                    if spectatorActive then return end
                    spectatorActive = true
                    SpectatorUI.Visible = true
                    SpectatorReadyBtn.Visible = false
                    isFirstFrame = true
                    spectatorPlayers = getValidPlayers()
                    if #spectatorPlayers > 0 then
                        spectatorIndex = 1
                    else
                        spectatorIndex = 1
                    end
                    updateSpectatorUI()
                    if spectatorConnection then spectatorConnection:Disconnect() end
                    spectatorConnection = RunService.RenderStepped:Connect(updateCamera)
                    sendNotification("Observing mode ON", 2)
                end

                local function stopSpectator(returnToReady)
                    if not spectatorActive then return end
                    spectatorActive = false
                    SpectatorUI.Visible = false
                    if spectatorConnection then
                        spectatorConnection:Disconnect()
                        spectatorConnection = nil
                    end
                    Camera.CameraType = cameraTypeBackup
                    if returnToReady and spectatorFunctionEnabled then
                        SpectatorReadyBtn.Visible = true
                    end
                    sendNotification("Observing mode OFF", 2)
                end

                local function toggleSpectatorFunction()
                    spectatorFunctionEnabled = not spectatorFunctionEnabled
                    if spectatorFunctionEnabled then
                        spectatorReady = true
                        SpectatorReadyBtn.Visible = true
                        ToggleButtonSpectator.Text = "ON"
                        ToggleButtonSpectator.BackgroundColor3 = Color3.fromRGB(30, 180, 30)
                        SpectatorStatusLabel.Text = "Ready"
                        if spectatorActive then
                            stopSpectator(false)
                        end
                        sendNotification("Spectator Ready", 2)
                    else
                        spectatorReady = false
                        SpectatorReadyBtn.Visible = false
                        if spectatorActive then
                            stopSpectator(false)
                        end
                        ToggleButtonSpectator.Text = "OFF"
                        ToggleButtonSpectator.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
                        SpectatorStatusLabel.Text = "Off"
                        sendNotification("Spectator Disabled", 2)
                    end
                end

                ToggleButtonSpectator.MouseButton1Click:Connect(toggleSpectatorFunction)

                SpectatorReadyBtn.MouseButton1Click:Connect(function()
                    if spectatorFunctionEnabled and not spectatorActive then
                        cameraTypeBackup = Camera.CameraType
                        Camera.CameraType = Enum.CameraType.Scriptable
                        startSpectator()
                    end
                end)

                SpectatorExitBtn.MouseButton1Click:Connect(function()
                    if spectatorActive then
                        stopSpectator(true)
                    end
                end)

                SpectatorLeft.MouseButton1Click:Connect(function()
                    if spectatorActive then
                        switchSpectator(-1)
                    end
                end)

                SpectatorRight.MouseButton1Click:Connect(function()
                    if spectatorActive then
                        switchSpectator(1)
                    end
                end)

                local function onPlayerAdded(player)
                    if spectatorActive then
                        updateSpectatorUI()
                    end
                end

                local function onPlayerRemoving(player)
                    if spectatorActive then
                        local players = getValidPlayers()
                        if #players == 0 then
                            stopSpectator(true)
                        else
                            if spectatorIndex > #players then
                                spectatorIndex = #players
                            end
                            updateSpectatorUI()
                        end
                    end
                end

                Players.PlayerAdded:Connect(onPlayerAdded)
                Players.PlayerRemoving:Connect(onPlayerRemoving)

                local function onCharacterAdded(player)
                    if spectatorActive then
                        updateSpectatorUI()
                    end
                end

                for _, player in ipairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer then
                        player.CharacterAdded:Connect(function() onCharacterAdded(player) end)
                    end
                end

                Players.PlayerAdded:Connect(function(player)
                    if player ~= LocalPlayer then
                        player.CharacterAdded:Connect(function() onCharacterAdded(player) end)
                    end
                end)

                UserInputService.InputBegan:Connect(function(input, gp)
                    if gp then return end
                    if input.KeyCode == Enum.KeyCode.X then
                        if spectatorFunctionEnabled then
                            if spectatorActive then
                                stopSpectator(true)
                            else
                                cameraTypeBackup = Camera.CameraType
                                Camera.CameraType = Enum.CameraType.Scriptable
                                startSpectator()
                            end
                        end
                    end
                end)

                -- ============================================================
                -- NOCLIP
                -- ============================================================
                local noclipEnabled = false
                local noclipConnection = nil

                local function setNoclip(state)
                    noclipEnabled = state
                    ToggleButtonNoclip.Text = state and "ON" or "OFF"
                    ToggleButtonNoclip.BackgroundColor3 = state and Color3.fromRGB(30, 180, 30) or Color3.fromRGB(180, 40, 40)
                    NoclipStatusLabel.Text = state and "On" or "Off"
                    if state then
                        sendNotification("Noclip Enabled", 2)
                        if noclipConnection then noclipConnection:Disconnect() end
                        noclipConnection = RunService.Heartbeat:Connect(function()
                            local char = LocalPlayer.Character
                            if char then
                                for _, part in ipairs(char:GetChildren()) do
                                    if part:IsA("BasePart") then
                                        part.CanCollide = false
                                    end
                                end
                            end
                        end)
                    else
                        sendNotification("Noclip Disabled", 2)
                        if noclipConnection then
                            noclipConnection:Disconnect()
                            noclipConnection = nil
                        end
                        local char = LocalPlayer.Character
                        if char then
                            for _, part in ipairs(char:GetChildren()) do
                                if part:IsA("BasePart") then
                                    part.CanCollide = true
                                end
                            end
                        end
                    end
                end

                ToggleButtonNoclip.MouseButton1Click:Connect(function()
                    setNoclip(not noclipEnabled)
                end)

                LocalPlayer.CharacterAdded:Connect(function()
                    if noclipEnabled then
                        task.wait(0.5)
                        local char = LocalPlayer.Character
                        if char then
                            for _, part in ipairs(char:GetChildren()) do
                                if part:IsA("BasePart") then
                                    part.CanCollide = false
                                end
                            end
                        end
                    end
                end)

                -- ============================================================
                -- INF JUMP (РАБОТАЕТ ПРИ ЗАЖАТИИ)
                -- ============================================================
                local infJumpEnabled = false
                local infJumpBeganConnection = nil
                local infJumpEndedConnection = nil
                local jumpHeld = false
                local infJumpConnection = nil

                local function startJump()
                    if not infJumpEnabled then return end
                    local char = LocalPlayer.Character
                    if char then
                        local humanoid = char:FindFirstChildOfClass("Humanoid")
                        if humanoid then
                            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                        end
                    end
                end

                local function setInfJump(state)
                    infJumpEnabled = state
                    ToggleButtonInfJump.Text = state and "ON" or "OFF"
                    ToggleButtonInfJump.BackgroundColor3 = state and Color3.fromRGB(30, 180, 30) or Color3.fromRGB(180, 40, 40)
                    InfJumpStatusLabel.Text = state and "On" or "Off"

                    if state then
                        sendNotification("Inf Jump Enabled", 2)
                        if infJumpBeganConnection then infJumpBeganConnection:Disconnect() end
                        if infJumpEndedConnection then infJumpEndedConnection:Disconnect() end
                        infJumpBeganConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
                            if gameProcessed then return end
                            if input.KeyCode == Enum.KeyCode.Space then
                                jumpHeld = true
                                startJump()
                            end
                        end)
                        infJumpEndedConnection = UserInputService.InputEnded:Connect(function(input, gameProcessed)
                            if gameProcessed then return end
                            if input.KeyCode == Enum.KeyCode.Space then
                                jumpHeld = false
                            end
                        end)
                        if not infJumpConnection then
                            infJumpConnection = RunService.Heartbeat:Connect(function()
                                if infJumpEnabled and jumpHeld then
                                    startJump()
                                end
                            end)
                        end
                    else
                        sendNotification("Inf Jump Disabled", 2)
                        if infJumpBeganConnection then infJumpBeganConnection:Disconnect(); infJumpBeganConnection = nil end
                        if infJumpEndedConnection then infJumpEndedConnection:Disconnect(); infJumpEndedConnection = nil end
                        if infJumpConnection then infJumpConnection:Disconnect(); infJumpConnection = nil end
                        jumpHeld = false
                    end
                end

                ToggleButtonInfJump.MouseButton1Click:Connect(function()
                    setInfJump(not infJumpEnabled)
                end)

                -- ============================================================
                -- ТЕЛЕПОРТ НА КОМАНДЫ
                -- ============================================================
                local teleportEnabled = false

                local function teleportToTeam(teamName)
                    local spawnPart = nil
                    local spawnsFolder = Workspace:FindFirstChild("Spawns")
                    if spawnsFolder then
                        spawnPart = spawnsFolder:FindFirstChild(teamName)
                    end
                    if not spawnPart then
                        spawnPart = Workspace:FindFirstChild(teamName)
                    end
                    if not spawnPart then
                        for _, child in ipairs(Workspace:GetChildren()) do
                            if child.Name:lower():find(teamName:lower()) then
                                spawnPart = child
                                break
                            end
                        end
                    end

                    if spawnPart and spawnPart:IsA("BasePart") then
                        local char = LocalPlayer.Character
                        if char and char:FindFirstChild("HumanoidRootPart") then
                            char.HumanoidRootPart.CFrame = CFrame.new(spawnPart.Position + Vector3.new(0, 2, 0))
                            sendNotification("Teleported to " .. teamName, 2)
                        else
                            sendNotification("Character not ready", 2)
                        end
                    else
                        sendNotification("Spawn for " .. teamName .. " not found", 2)
                    end
                end

                local function setTeleport(state)
                    teleportEnabled = state
                    ToggleButtonTeleport.Text = state and "ON" or "OFF"
                    ToggleButtonTeleport.BackgroundColor3 = state and Color3.fromRGB(30, 180, 30) or Color3.fromRGB(180, 40, 40)
                    TeleportStatusLabel.Text = state and "On" or "Off"
                    if state then
                        sendNotification("Teleport Teams Enabled", 2)
                        TeleportGUI.Visible = true
                        for _, btn in ipairs(teamButtons) do
                            btn.MouseButton1Click:Connect(function()
                                if teleportEnabled then
                                    teleportToTeam(btn.Name)
                                end
                            end)
                        end
                    else
                        sendNotification("Teleport Teams Disabled", 2)
                        TeleportGUI.Visible = false
                    end
                end

                ToggleButtonTeleport.MouseButton1Click:Connect(function()
                    setTeleport(not teleportEnabled)
                end)

                TeleportCloseBtn.MouseButton1Click:Connect(function()
                    if teleportEnabled then
                        setTeleport(false)
                    end
                end)

                -- ============================================================
                -- HIDE / REOPEN / CLOSE (с отключением всех функций)
                -- ============================================================
                local ReopenBtn = Instance.new("TextButton")
                ReopenBtn.Name = "ReopenBtn"
                ReopenBtn.Size = UDim2.new(0, 44, 0, 44)
                ReopenBtn.Position = UDim2.new(0.02, 0, 0.88, 0)
                ReopenBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                ReopenBtn.BorderSizePixel = 1
                ReopenBtn.BorderColor3 = Color3.fromRGB(40, 40, 40)
                ReopenBtn.Text = "▲"
                ReopenBtn.TextColor3 = Color3.fromRGB(200, 200, 220)
                ReopenBtn.TextSize = 20
                ReopenBtn.Font = Enum.Font.SourceSansBold
                ReopenBtn.Visible = false
                ReopenBtn.AutoButtonColor = false
                ReopenBtn.Parent = ScreenGui
                local ReopenCorner = Instance.new("UICorner")
                ReopenCorner.CornerRadius = UDim.new(0, 6)
                ReopenCorner.Parent = ReopenBtn

                HideBtn.MouseButton1Click:Connect(function()
                    MainFrame.Visible = false
                    ReopenBtn.Visible = true
                    if teleportEnabled then TeleportGUI.Visible = false end
                end)

                ReopenBtn.MouseButton1Click:Connect(function()
                    MainFrame.Visible = true
                    ReopenBtn.Visible = false
                    if teleportEnabled then TeleportGUI.Visible = true end
                end)

                local function closeHub()
                    if espEnabled then setESP(false) else clearAllESP() end
                    if heartbeatConnection then heartbeatConnection:Disconnect(); heartbeatConnection = nil end
                    if autoFarmEnabled then setAutoFarm(false) end
                    if noclipEnabled then setNoclip(false) end
                    if infJumpEnabled then setInfJump(false) end
                    if teleportEnabled then setTeleport(false) end
                    if spectatorFunctionEnabled then
                        spectatorFunctionEnabled = false
                        spectatorReady = false
                        SpectatorReadyBtn.Visible = false
                        if spectatorActive then
                            stopSpectator(false)
                        end
                        ToggleButtonSpectator.Text = "OFF"
                        ToggleButtonSpectator.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
                        SpectatorStatusLabel.Text = "Off"
                    end
                    resetGravity()
                    destroyFarmStats()
                    ScreenGui:Destroy()
                end

                CloseBtn.MouseButton1Click:Connect(closeHub)

                UserInputService.InputBegan:Connect(function(input, gp)
                    if gp then return end
                    if input.KeyCode == Enum.KeyCode.K then
                        if MainFrame.Visible then
                            MainFrame.Visible = false
                            ReopenBtn.Visible = true
                            if teleportEnabled then TeleportGUI.Visible = false end
                        else
                            MainFrame.Visible = true
                            ReopenBtn.Visible = false
                            if teleportEnabled then TeleportGUI.Visible = true end
                        end
                    end
                end)

                -- ============================================================
                -- ИНИЦИАЛИЗАЦИЯ
                -- ============================================================
                SwitchPage("Main")
                applyCharacterSettings()
                updateCanvasSize()
                print("Bloxer Hub v1.0 loaded – с исправленной статистикой автофарма.")
            ]])()
        end)
        
        if not success then
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Bloxer Hub",
                Text = "Failed to load script: " .. err,
                Duration = 5
            })
        end
    else
        StatusAuth.Text = "❌ Invalid key! Please try again."
        StatusAuth.TextColor3 = Color3.fromRGB(255, 0, 0)
    end
end)

-- Нажатие Enter в поле ввода
InputBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        VerifyBtn.MouseButton1Click:Fire()
    end
end)

print("Bloxer Hub Auth system loaded. Enter key 'BloxerHub'.")
