Components.Notification = (function()
	local Spring = Flipper.Spring.new
	local Instant = Flipper.Instant.new
	local New = Creator.New

	local Notification = {}

	function Notification:Init(GUI)
		Notification.Holder = New("Frame", {
			Position = UDim2.new(1, -30, 1, -30),
			Size = UDim2.new(0, 310, 1, -30),
			AnchorPoint = Vector2.new(1, 1),
			BackgroundTransparency = 1,
			Parent = GUI,
		}, {
			New("UIListLayout", {
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
				VerticalAlignment = Enum.VerticalAlignment.Bottom,
				Padding = UDim.new(0, 20),
			}),
		})
	end

	function Notification:New(Config)
		Config.Title = Config.Title or "Title"
		Config.Content = Config.Content or "Content"
		Config.SubContent = Config.SubContent or ""
		Config.Duration = Config.Duration or nil
		Config.Buttons = Config.Buttons or {}
		local NewNotification = {
			Closed = false,
		}

		NewNotification.AcrylicPaint = Acrylic.AcrylicPaint()

		local ResolvedIcon = Config.Icon
		if type(ResolvedIcon) == "string" and ResolvedIcon ~= ""
			and not ResolvedIcon:match("^rbxassetid://")
			and not ResolvedIcon:match("^rbxasset://")
			and not ResolvedIcon:match("^http") then
			ResolvedIcon = Library:GetIcon(ResolvedIcon)
		end

		local IconImage, IconRectOffset, IconRectSize
		if type(ResolvedIcon) == "table" then
			IconImage = ResolvedIcon.Image
			IconRectOffset = ResolvedIcon.ImageRectOffset
			IconRectSize = ResolvedIcon.ImageRectSize
		elseif type(ResolvedIcon) == "string" and ResolvedIcon ~= "" then
			IconImage = ResolvedIcon
		end

		local IconOffset = IconImage and 26 or 0

		NewNotification.Title = New("TextLabel", {
			Text = Config.Title,
			RichText = true,
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextTransparency = 0,
			FontFace = Font.new(Library.Font),
			TextSize = 13,
			TextXAlignment = "Left",
			TextYAlignment = "Center",
			Size = UDim2.new(1, 0, 0, 12),
			TextWrapped = true,
			BackgroundTransparency = 1,
			LayoutOrder = 1,
			ThemeTag = {
				TextColor3 = "Text",
			},
		})

		NewNotification.ContentLabel = New("TextLabel", {
			FontFace = Font.new(Library.Font),
			Text = Config.Content,
			TextColor3 = Color3.fromRGB(240, 240, 240),
			TextSize = 14,
			TextXAlignment = Enum.TextXAlignment.Left,
			AutomaticSize = Enum.AutomaticSize.Y,
			Size = UDim2.new(1, 0, 0, 14),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			TextWrapped = true,
			ThemeTag = {
				TextColor3 = "Text",
			},
		})

		NewNotification.SubContentLabel = New("TextLabel", {
			FontFace = Font.new(Library.Font),
			Text = Config.SubContent,
			TextColor3 = Color3.fromRGB(240, 240, 240),
			TextSize = 14,
			TextXAlignment = Enum.TextXAlignment.Left,
			AutomaticSize = Enum.AutomaticSize.Y,
			Size = UDim2.new(1, 0, 0, 14),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			TextWrapped = true,
			ThemeTag = {
				TextColor3 = "SubText",
			},
		})

		NewNotification.LabelHolder = New("Frame", {
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, 0),
			LayoutOrder = 2,
		}, {
			New("UIListLayout", {
				SortOrder = Enum.SortOrder.LayoutOrder,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				Padding = UDim.new(0, 3),
			}),
			NewNotification.ContentLabel,
			NewNotification.SubContentLabel,
		})

		NewNotification.TextHolder = New("Frame", {
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			Position = UDim2.fromOffset(14 + IconOffset, 17),
			Size = UDim2.new(1, -28 - IconOffset, 0, 0),
		}, {
			New("UIListLayout", {
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 11),
			}),
			NewNotification.Title,
			NewNotification.LabelHolder,
		})

		if IconImage then
			NewNotification.IconLabel = New("ImageLabel", {
				Image = IconImage,
				ImageRectOffset = IconRectOffset,
				ImageRectSize = IconRectSize,
				Size = UDim2.fromOffset(20, 20),
				Position = UDim2.fromOffset(14, 17),
				BackgroundTransparency = 1,
				ZIndex = 2,
				ThemeTag = {
					ImageColor3 = "Text",
				},
			})

			local function UpdateIconPosition()
				local TextHeight = NewNotification.TextHolder.AbsoluteSize.Y
				NewNotification.IconLabel.Position = UDim2.fromOffset(14, 17 + (TextHeight / 2) - 10)
			end

			Creator.AddSignal(NewNotification.TextHolder:GetPropertyChangedSignal("AbsoluteSize"), UpdateIconPosition)
			task.defer(UpdateIconPosition)
		end

		NewNotification.CloseButton = New("TextButton", {
			Text = "",
			Position = UDim2.new(1, -14, 0, 13),
			Size = UDim2.fromOffset(20, 20),
			AnchorPoint = Vector2.new(1, 0),
			BackgroundTransparency = 1,
		}, {
			New("ImageLabel", {
				Image = (Library.NewVisual and Components.AssetsNew or Components.Assets).Close,
				Size = UDim2.fromOffset(16, 16),
				Position = UDim2.fromScale(0.5, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundTransparency = 1,
				ThemeTag = {
					ImageColor3 = "Text",
				},
			}),
		})

		local RootChildren = {
			NewNotification.AcrylicPaint.Frame,
			NewNotification.CloseButton,
			NewNotification.TextHolder,
		}
		if NewNotification.IconLabel then
			table.insert(RootChildren, NewNotification.IconLabel)
		end

		NewNotification.Root = New("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, 0),
			Position = UDim2.fromScale(1, 0),
		}, RootChildren)

		if Config.Content == "" then
			NewNotification.ContentLabel.Visible = false
		end

		if Config.SubContent == "" then
			NewNotification.SubContentLabel.Visible = false
		end

		NewNotification.Holder = New("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, 200),
			Parent = Notification.Holder,
		}, {
			NewNotification.Root,
		})

		local RootMotor = Flipper.GroupMotor.new({
			Scale = 1,
			Offset = 60,
		})

		RootMotor:onStep(function(Values)
			NewNotification.Root.Position = UDim2.new(Values.Scale, Values.Offset, 0, 0)
		end)

		Creator.AddSignal(NewNotification.CloseButton.MouseButton1Click, function()
			NewNotification:Close()
		end)

		function NewNotification:Open()
			local ContentSize = NewNotification.LabelHolder.AbsoluteSize.Y
			NewNotification.Holder.Size = UDim2.new(1, 0, 0, 58 + ContentSize)

			RootMotor:setGoal({
				Scale = Spring(0, { frequency = 5 }),
				Offset = Spring(0, { frequency = 5 }),
			})
		end

		function NewNotification:Close()
			if not NewNotification.Closed then
				NewNotification.Closed = true
				task.spawn(function()
					RootMotor:setGoal({
						Scale = Spring(1, { frequency = 5 }),
						Offset = Spring(60, { frequency = 5 }),
					})
					task.wait(0.4)
					if Library.UseAcrylic then
						NewNotification.AcrylicPaint.Model:Destroy()
					end
					NewNotification.Holder:Destroy()
				end)
			end
		end

		NewNotification:Open()
		if Config.Duration then
			task.delay(Config.Duration, function()
				NewNotification:Close()
			end)
		end
		return NewNotification
	end

	return Notification
end)()

