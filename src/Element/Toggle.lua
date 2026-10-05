local TweenService: TweenService = cloneref(game:GetService("TweenService"))

ElementsTable.Toggle = (function()
	local New = Creator.New

	local Element = {}
	Element.__index = Element
	Element.__type = "Toggle"

	function Element:New(Idx, Config)
		local Library = self.Library
		assert(Config.Title, "Toggle - Missing Title")

		local Toggle = {
			Value = Config.Default or false,
			Callback = Config.Callback or function(Value) end,
			Type = "Toggle",
		}

		local IsGrouped = self.Type == "Group" or self.Type == "HStack" or self.Type == "VStack"

		local ToggleFrame = Components.Element(Config.Title, Config.Description, self.Container, true, Config.LayoutOrder, Config.Icon, Config.Marquee)
		ToggleFrame.DescLabel.Size = UDim2.new(1, -54, 0, 14)
		ToggleFrame.TitleLabel.Size = UDim2.new(1, -54, 0, 14)

		Toggle.SetTitle = ToggleFrame.SetTitle
		Toggle.SetDesc = ToggleFrame.SetDesc

		local ToggleCircle = New("ImageLabel", {
			AnchorPoint = Vector2.new(0, 0.5),
			Size = UDim2.fromOffset(14, 14),
			Position = UDim2.new(0, 2, 0.5, 0),
			Image = "http://www.roblox.com/asset/?id=12266946128",
			ImageTransparency = 0.5,
			ThemeTag = {
				ImageColor3 = "ToggleSlider",
			},
		})

		local ToggleBorder = New("UIStroke", {
			Transparency = 0.5,
			ThemeTag = {
				Color = "ToggleSlider",
			},
		})

		local ToggleSlider = New("Frame", {
			Size = UDim2.fromOffset(36, 18),
			AnchorPoint = Vector2.new(1, 0.5),
			Position = UDim2.new(1, -10, 0.5, 0),
			Parent = ToggleFrame.Frame,
			BackgroundTransparency = 1,
			ThemeTag = {
				BackgroundColor3 = "Accent",
			},
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 9),
			}),
			ToggleBorder,
			ToggleCircle,
		})

		function Toggle:OnChanged(Func)
			Toggle.Changed = Func
			Func(Toggle.Value)
		end

		local ToggleCircleIcon
		if Library.NewVisual then
			ToggleCircleIcon = New("ImageLabel", {
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.fromScale(0.5, 0.5),
				Size = UDim2.fromOffset(8, 8),
				BackgroundTransparency = 1,
				Image = "rbxassetid://110786993356448",
				ImageColor3 = Color3.new(1, 1, 1),
				ZIndex = 2,
				Parent = ToggleCircle,
			})
		end

		local function UpdateToggleIconColor()
			if not ToggleCircleIcon then return end
			local KnobColor = Creator.GetThemeProperty(Toggle.Value and "ToggleToggled" or "ToggleSlider")
			ToggleCircleIcon.ImageColor3 = Color3.new(1 - KnobColor.R, 1 - KnobColor.G, 1 - KnobColor.B)
		end

		if Library.NewVisual then
			Creator.OnThemeChanged(UpdateToggleIconColor)
		end

		function Toggle:SetValue(Value)
			Value = not not Value
			Toggle.Value = Value

			Creator.OverrideTag(ToggleBorder, { Color = Toggle.Value and "Accent" or "ToggleSlider" })
			Creator.OverrideTag(ToggleCircle, { ImageColor3 = Toggle.Value and "ToggleToggled" or "ToggleSlider" })
			if Library.NewVisual then
				ToggleCircleIcon.Image = Toggle.Value and "rbxassetid://93898873302694" or "rbxassetid://110786993356448"
				UpdateToggleIconColor()
			end
			TweenService:Create(
				ToggleCircle,
				TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
				{ Position = UDim2.new(0, Toggle.Value and 19 or 2, 0.5, 0) }
			):Play()
			TweenService:Create(
				ToggleSlider,
				TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
				{ BackgroundTransparency = Toggle.Value and 0 or 1 }
			):Play()
			ToggleCircle.ImageTransparency = Toggle.Value and 0 or 0.5

			Library:SafeCallback(Toggle.Callback, Toggle.Value)
			Library:SafeCallback(Toggle.Changed, Toggle.Value)
		end

		function Toggle:Destroy()
			ToggleFrame:Destroy()
			Library.Options[Idx] = nil
		end

		Creator.AddSignal(ToggleFrame.Frame.MouseButton1Click, function()
			Toggle:SetValue(not Toggle.Value)
		end)

		Toggle:SetValue(Toggle.Value)

		Library.Options[Idx] = Toggle
		return Toggle
	end

	return Element
end)()

