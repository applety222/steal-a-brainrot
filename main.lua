-- STEAL A BRAINROT ULTIMATE HACK v5.0
-- 텔레포트 + 사소한 기능 + ON/OFF 토글 완전 추가!
-- 키링크: https://applety222.github.io/Rivals-ket/

repeat wait() until game:IsLoaded()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

-- Rayfield GUI
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- 실시간 키링크 추출
local function GetKeys()
   local success, html = pcall(game.HttpGet, game, "https://applety222.github.io/Rivals-ket/")
   if success then
      local keys = {}
      for key in html:gmatch("([A-Za-z0-9%-_]{8,25})") do
         if #key >= 8 and not table.find(keys, key) then
            table.insert(keys, key)
         end
      end
      return keys
   end
   return {"BRAINROT", "STEAL2025", "FREEKEY"}
end

local VALID_KEYS = GetKeys()

-- 메인 윈도우
local Window = Rayfield:CreateWindow({
   Name = "STEAL A BRAINROT v5.0",
   LoadingTitle = "텔레포트 + 사소기능 로딩중...",
   LoadingSubtitle = "ON/OFF 완벽 지원",
   KeySystem = true,
   KeySettings = {
      Title = "키 인증",
      Subtitle = "applety222.github.io/Rivals-ket/",
      Note = #VALID_KEYS .. "개 키 사용 가능!",
      Key = VALID_KEYS
   }
})

-- 탭 생성
local Main = Window:CreateTab("홈", 4483362458)
local Teleport = Window:CreateTab("텔레포트", 4483362458)
local Steal = Window:CreateTab("도둑질", 4483362458)
local Farm = Window:CreateTab("파밍", 4483362458)
local Visual = Window:CreateTab("ESP", 4483362458)
local Utils = Window:CreateTab("사소기능", 4483362458)
local Mobile = Window:CreateTab("모바일", 4483362458)

-- 캐릭터 함수
local function GetChar()
   return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end

-- 텔레포트 위치 저장
local SavedPositions = {}

-- 텔레포트 탭
local TeleportSection = Teleport:CreateSection("텔레포트")

Teleport:CreateButton({
   Name = "내 위치 저장",
   Callback = function()
      local root = GetChar():FindFirstChild("HumanoidRootPart")
      if root then
         SavedPositions["MyPos"] = root.Position
         Rayfield:Notify({Title="저장됨!", Content="내 위치 저장 완료!"})
      end
   end
})

Teleport:CreateButton({
   Name = "저장된 위치로 이동",
   Callback = function()
      local root = GetChar():FindFirstChild("HumanoidRootPart")
      if root and SavedPositions["MyPos"] then
         root.CFrame = CFrame.new(SavedPositions["MyPos"])
      end
   end
})

Teleport:CreateButton({
   Name = "스폰 포인트",
   Callback = function()
      local root = GetChar():FindFirstChild("HumanoidRootPart")
      if root then
         root.CFrame = CFrame.new(0, 50, 0)
      end
   end
})

Teleport:CreateButton({
   Name = "랜덤 플레이어에게",
   Callback = function()
      local target = Players:GetPlayers()[math.random(2, #Players:GetPlayers())]
      if target and target.Character then
         GetChar().HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame
      end
   end
})

-- 도둑질 탭
Steal:CreateToggle({
   Name = "자동 도둑질 (ON/OFF)",
   CurrentValue = false,
   Callback = function(v)
      getgenv().AutoSteal = v
      spawn(function()
         while getgenv().AutoSteal do
            for _, obj in pairs(workspace:GetDescendants()) do
               if obj.Name:find("Brainrot") and obj:FindFirstChildOfClass("ClickDetector") then
                  local dist = (obj.Position - GetChar().HumanoidRootPart.Position).Magnitude
                  if dist < 25 then
                     fireclickdetector(obj:FindFirstChildOfClass("ClickDetector"))
                     wait(0.1)
                  end
               end
            end
            wait(0.3)
         end
      end)
   end
})

-- 파밍 탭
Farm:CreateToggle({
   Name = "자동 돈 수집 (ON/OFF)",
   CurrentValue = false,
   Callback = function(v)
      getgenv().AutoCollect = v
      spawn(function()
         while getgenv().AutoCollect do
            pcall(function()
               local cash = workspace:FindFirstChild("Cash")
               if cash and cash:FindFirstChildOfClass("ClickDetector") then
                  fireclickdetector(cash:FindFirstChildOfClass("ClickDetector"))
               end
            end)
            wait(1)
         end
      end)
   end
})

-- ESP 탭
Visual:CreateToggle({
   Name = "Brainrot ESP (ON/OFF)",
   CurrentValue = false,
   Callback = function(v)
      if v then
         loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Functions/ESP.lua"))()
      end
   end
})

-- 사소한 기능 탭 (모두 ON/OFF)
local UtilsSection = Utils:CreateSection("사소한 기능 (ON/OFF)")

Utils:CreateToggle({
   Name = "자동 점프 (ON/OFF)",
   CurrentValue = false,
   Callback = function(v)
      getgenv().AutoJump = v
      spawn(function()
         while getgenv().AutoJump do
            GetChar().Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            wait(0.5)
         end
      end)
   end
})

Utils:CreateToggle({
   Name = "무한 점프 (ON/OFF)",
   CurrentValue = false,
   Callback = function(v)
      getgenv().InfJump = v
      if v then
         game:GetService("UserInputService").JumpRequest:Connect(function()
            if getgenv().InfJump then
               GetChar().Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
         end)
      end
   end
})

Utils:CreateToggle({
   Name = "NoClip (ON/OFF)",
   CurrentValue = false,
   Callback = function(v)
      getgenv().NoClip = v
      spawn(function()
         while getgenv().NoClip do
            for _, part in pairs(GetChar():GetDescendants()) do
               if part:IsA("BasePart") then part.CanCollide = false end
            end
            wait()
         end
      end)
   end
})

Utils:CreateToggle({
   Name = "갓모드 (ON/OFF)",
   CurrentValue = false,
   Callback = function(v)
      getgenv().Godmode = v
      spawn(function()
         while getgenv().Godmode do
            pcall(function()
               GetChar().Humanoid.Health = GetChar().Humanoid.MaxHealth
            end)
            wait(0.1)
         end
      end)
   end
})

Utils:CreateSlider({
   Name = "시야 (FOV)",
   Range = {70, 120},
   Increment = 5,
   CurrentValue = 70,
   Callback = function(v)
      Camera.FieldOfView = v
   end
})

Utils:CreateButton({
   Name = "재생성 (Respawn)",
   Callback = function()
      LocalPlayer.Character:BreakJoints()
   end
})

-- 모바일 탭
Mobile:CreateToggle({
   Name = "터치 에임봇 (ON/OFF)",
   CurrentValue = false,
   Callback = function(v)
      getgenv().TouchAim = v
      spawn(function()
         while getgenv().TouchAim do
            local closest = nil
            local minDist = 300
            for _, plr in pairs(Players:GetPlayers()) do
               if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") then
                  local head = plr.Character.Head
                  local screen, onScreen = Camera:WorldToViewportPoint(head.Position)
                  if onScreen then
                     local dist = (Vector2.new(screen.X, screen.Y) - game:GetService("UserInputService"):GetMouseLocation()).Magnitude
                     if dist < minDist then
                        minDist = dist
                        closest = head
                     end
                  end
               end
            end
            if closest then
               Camera.CFrame = CFrame.new(Camera.CFrame.Position, closest.Position)
            end
            wait(0.01)
         end
      end)
   end
})

Mobile:CreateButton({
   Name = "모바일 플라이",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/Fly-Gui-V2/main/Fly%20Gui%20V2"))()
   end
})

-- 키 리프레시
Main:CreateButton({
   Name = "키 새로고침",
   Callback = function()
      VALID_KEYS = GetKeys()
      Rayfield:Notify({Title="업데이트!", Content=#VALID_KEYS.."개 키 리프레시!"})
   end
})

-- 완료 알림
Rayfield:Notify({
   Title = "v5.0 완벽 로드!",
   Content = "텔레포트✓ 사소기능✓ ON/OFF✓\n모바일 완벽!",
   Duration = 8,
   Image = 4483362458
})

print("STEAL A BRAINROT v5.0 실행 완료!")
