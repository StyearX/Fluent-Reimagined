local CoreGui: CoreGui = cloneref(game:GetService("CoreGui"))
local RunService: RunService = cloneref(game:GetService("RunService"))

local New = Creator.New

local GUI = New("ScreenGui", {
	Parent = RunService:IsStudio() and LocalPlayer.PlayerGui or CoreGui,
})
ProtectGui(GUI)
Library.GUI = GUI

