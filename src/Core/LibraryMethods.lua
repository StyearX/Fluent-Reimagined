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

	return Window
end

function Library:SetTheme(Value)
	if not Library.Window then return end
	if type(Value) == "table" then
		Library.Theme = Value.Name or "Custom"
		Library.CustomThemeData = Value
		Creator.UpdateTheme()
	elseif table.find(Library.Themes, Value) then
		Library.Theme = Value
		Library.CustomThemeData = nil
		Creator.UpdateTheme()
	end
end

function Library:SetFont(fontAsset)
	Library.Font = fontAsset
	Creator.UpdateFont()
end

function Library:Destroy()
	if Library.Window then
		Library.Unloaded = true
		if Library.UseAcrylic then
			Library.Window.AcrylicPaint.Model:Destroy()
		end
		Creator.Disconnect()
		Library.GUI:Destroy()
	end
end

function Library:ToggleAcrylic(Value)
	if Library.Window then
		if Library.UseAcrylic then
			Library.Acrylic = Value
			Library.Window.AcrylicPaint.Model.Transparency = Value and 0.98 or 1
			if Value then
				Acrylic.Enable()
			else
				Acrylic.Disable()
			end
		end
	end
end

function Library:SetTransparency(Value)
	if type(Value) == "boolean" then
		Value = Value and 0.35 or 0
	end
	Value = math.clamp(tonumber(Value) or 0, 0, 1)
	Library.Transparency = Value
	if Library.Window then
		Library.Window.AcrylicPaint.Frame.Background.BackgroundTransparency = Value
	end
	for _, DropdownFrame in next, Creator.DropdownTransparencyFrames do
		DropdownFrame.BackgroundTransparency = Value
	end
end

function Library:ToggleTransparency(Value)
	Library:SetTransparency(Value)
end

function Library:ToggleUserInfo(Value)
	if Library.Window and Library.Window.UserInfoFrame then
		Library.Window.UserInfoFrame.Visible = Value
	end
end

function Library:ToggleKeepWindowInsideFrame(Value)
	Library.KeepWindowInsideFrame = Value
end

function Library:SetBoundaryMargin(Value)
	Library.BoundaryMargin = Value or 0
	if Library.Window and Library.Window.RefreshBoundary then
		Library.Window.RefreshBoundary()
	end
end

function Library:SetBoundaryInset(Inset)
	Inset = Inset or {}
	Library.BoundaryInset = {
		Top = Inset.Top or 0,
		Bottom = Inset.Bottom or 0,
		Left = Inset.Left or 0,
		Right = Inset.Right or 0,
	}
	if Library.Window and Library.Window.RefreshBoundary then
		Library.Window.RefreshBoundary()
	end
end

local backgroundImageCache = {}
local backgroundCacheFolder = "FluentReimaginedBackgroundCache"

local function hashBackgroundUrl(Url)
	local hash = 0
	for i = 1, #Url do
		hash = (hash * 31 + string.byte(Url, i)) % 1000000007
	end
	return tostring(hash)
end

function Library:ResolveBackgroundImage(Input)
	if not Input or Input == "" then
		return ""
	end

	if
		Input:match("^rbxassetid://")
		or Input:match("^rbxasset://")
		or Input:match("^https?://www%.roblox%.com/asset")
	then
		return Input
	end

	if tonumber(Input) then
		return "rbxassetid://" .. Input
	end

	if Input:match("^https?://") then
		if backgroundImageCache[Input] then
			return backgroundImageCache[Input]
		end

		local success, result = pcall(function()
			if not isfolder(backgroundCacheFolder) then
				makefolder(backgroundCacheFolder)
			end

			local fileName = backgroundCacheFolder .. "/" .. hashBackgroundUrl(Input) .. ".png"
			if not isfile(fileName) then
				writefile(fileName, game:HttpGet(Input))
			end

			return getcustomasset(fileName)
		end)

		if success and result then
			backgroundImageCache[Input] = result
			return result
		end

		warn("[Background] Failed to load image from URL: " .. Input)
		return ""
	end

	return Input
end

function Library:UpdateBackground()
	if not Library.Window or not Library.Window.BackgroundImage then
		return
	end

	local backgroundImage = Library.Window.BackgroundImage

	if Library.DisableBackground then
		backgroundImage.ImageTransparency = 1
		return
	end

	backgroundImage.Image = Library:ResolveBackgroundImage(Creator.GetThemeProperty("Background"))
	backgroundImage.ImageTransparency = Creator.GetThemeProperty("BackgroundTransparency")
end

function Library:ToggleBackground(Value)
	Library.DisableBackground = Value
	Library:UpdateBackground()
end

Creator.OnThemeChanged(function()
	Library:UpdateBackground()
end)

function Library:Notify(Config)
	return NotificationModule:New(Config)
end

