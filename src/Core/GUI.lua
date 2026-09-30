local New = Creator.New

local GUI = New("ScreenGui", {
	Parent = RunService:IsStudio() and LocalPlayer.PlayerGui or CoreGui,
})
ProtectGui(GUI)
Library.GUI = GUI

