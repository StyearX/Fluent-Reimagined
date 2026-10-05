function Library:CreateWindow(Config)
	assert(Config.Title, "Window - Missing Title")

	if Library.Window then
		print("You cannot create more than one window.")
		return
	end

	Library.MinimizeKey = Config.MinimizeKey or Enum.KeyCode.LeftControl
	Library.UseAcrylic = Config.Acrylic or false
	Library.Acrylic = Config.Acrylic or false
	Library.Theme = Config.Theme or "Dark"
	if Config.Acrylic then
		Acrylic.init()
	end

	Library.NewVisual = Config.NewVisual == true

	local Window = Components.Window({
		Parent = GUI,
		Size = Config.Size,
		Title = Config.Title,
		SubTitle = Config.SubTitle,
		TabWidth = Config.TabWidth,
		Search = Config.Search,
		UserInfo = Config.UserInfo,
		NewVisual = Library.NewVisual,
	})

	Library.Window = Window
	Library:SetTheme(Config.Theme)

	if Config.Font then
		Library:SetFont(Config.Font)
	end
	if Config.Transparency ~= nil then
		local Transparency = Config.Transparency
		if type(Transparency) == "number" and Transparency > 1 then
			Transparency = Transparency / 100
		end
		Library:SetTransparency(Transparency)
	end
	if Config.ShowUserInfo ~= nil then
		Library:ToggleUserInfo(Config.ShowUserInfo)
	end
	if Config.DisableBackground ~= nil then
		Library.DisableBackground = Config.DisableBackground
	end
	if Config.KeepWindowInsideFrame ~= nil then
		Library:ToggleKeepWindowInsideFrame(Config.KeepWindowInsideFrame)
	end

	return Window
end

