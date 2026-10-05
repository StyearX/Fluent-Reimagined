local TweenService: TweenService = cloneref(game:GetService("TweenService"))

Components.Toast = (function()
	local New = Creator.New

	local Toast = {
		Holders = {},
		Order = 0,
	}

	local TypeStyles = {
		Info = { Icons = { "info" }, Color = nil },
		Success = { Icons = { "circle-check", "check-circle", "check" }, Color = Color3.fromRGB(80, 200, 120) },
		Warning = { Icons = { "triangle-alert", "alert-triangle", "alert-circle" }, Color = Color3.fromRGB(255, 190, 70) },
		Error = { Icons = { "circle-x", "x-circle", "x" }, Color = Color3.fromRGB(240, 85, 85) },
	}

	function Toast:Init(GUI)
		Toast.GUI = GUI
	end

	local function ResolveIcon(Name)
		if type(Name) ~= "string" or Name == "" then
			return nil
		end
		if Name:match("^rbxassetid://") or Name:match("^rbxasset://") or Name:match("^http") then
			return { Image = Name }
		end
		local Ok, Icon = pcall(function()
			return Library:GetIcon(Name)
		end)
		if Ok and type(Icon) == "table" and Icon.Image then
			return Icon
		end
		return nil
	end

	local function GetHolder(Position)
		local Key = Position == "Top" and "Top" or "Bottom"
		local Existing = Toast.Holders[Key]
		if Existing and Existing.Parent then
			return Existing, Key == "Top"
		end

		local IsTop = Key == "Top"
		local Holder = New("Frame", {
			Name = "ToastHolder" .. Key,
			AnchorPoint = Vector2.new(0.5, IsTop and 0 or 1),
			Position = UDim2.new(0.5, 0, IsTop and 0 or 1, IsTop and 30 or -30),
			Size = UDim2.new(0, 380, 1, -60),
			BackgroundTransparency = 1,
			Parent = Toast.GUI,
		}, {
			New("UIListLayout", {
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = IsTop and Enum.VerticalAlignment.Top or Enum.VerticalAlignment.Bottom,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 8),
			}),
		})

		Toast.Holders[Key] = Holder
		return Holder, IsTop
	end

	function Toast:New(Config)
		if type(Config) == "string" then
			Config = { Content = Config }
		end
		Config = Config or {}

		local Title = Config.Title and tostring(Config.Title) or ""
		local Content = Config.Content and tostring(Config.Content) or ""
		local Duration = Config.Duration
		if Duration == nil then
			Duration = 3
		end
		local ShowProgress = type(Duration) == "number" and Duration > 0 and Config.Progress ~= false
		local Style = TypeStyles[Config.Type or "Info"] or TypeStyles.Info
		local Holder, IsTop = GetHolder(Config.Position)
		local Offset = IsTop and -16 or 16

		local NewToast = {
			Closed = false,
			Ready = false,
		}

		local IconData
		if Config.Icon ~= false then
			if type(Config.Icon) == "string" then
				IconData = ResolveIcon(Config.Icon)
			end
			if not IconData and Config.Icon == nil then
				for _, Name in ipairs(Style.Icons) do
					IconData = ResolveIcon(Name)
					if IconData then
						break
					end
				end
			end
		end

		local function AccentTag(Property)
			if Style.Color then
				return nil
			end
			return { [Property] = "Accent" }
		end

		local ContentChildren = {}

		if IconData then
			table.insert(ContentChildren, New("ImageLabel", {
				Name = "ToastIcon",
				Image = IconData.Image,
				ImageRectOffset = IconData.ImageRectOffset or Vector2.zero,
				ImageRectSize = IconData.ImageRectSize or Vector2.zero,
				ImageColor3 = Style.Color or Color3.fromRGB(255, 255, 255),
				Size = UDim2.fromOffset(18, 18),
				BackgroundTransparency = 1,
				LayoutOrder = 1,
				ThemeTag = AccentTag("ImageColor3"),
			}))
		end

		local TextChildren = {
			New("UIListLayout", {
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 2),
			}),
		}

		if Title ~= "" then
			table.insert(TextChildren, New("TextLabel", {
				Name = "ToastTitle",
				FontFace = Font.new(Library.Font, Enum.FontWeight.Medium, Enum.FontStyle.Normal),
				Text = Title,
				RichText = true,
				TextSize = 13,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextWrapped = true,
				AutomaticSize = Enum.AutomaticSize.XY,
				Size = UDim2.fromOffset(0, 14),
				BackgroundTransparency = 1,
				LayoutOrder = 1,
				ThemeTag = {
					TextColor3 = "Text",
				},
			}, {
				New("UISizeConstraint", {
					MaxSize = Vector2.new(290, math.huge),
				}),
			}))
		end

		if Content ~= "" then
			table.insert(TextChildren, New("TextLabel", {
				Name = "ToastContent",
				FontFace = Font.new(Library.Font),
				Text = Content,
				RichText = true,
				TextSize = 13,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextWrapped = true,
				AutomaticSize = Enum.AutomaticSize.XY,
				Size = UDim2.fromOffset(0, 14),
				BackgroundTransparency = 1,
				LayoutOrder = 2,
				ThemeTag = {
					TextColor3 = Title ~= "" and "SubText" or "Text",
				},
			}, {
				New("UISizeConstraint", {
					MaxSize = Vector2.new(290, math.huge),
				}),
			}))
		end

		table.insert(ContentChildren, New("Frame", {
			Name = "ToastText",
			BackgroundTransparency = 1,
			AutomaticSize = Enum.AutomaticSize.XY,
			Size = UDim2.fromOffset(0, 0),
			LayoutOrder = 2,
		}, TextChildren))

		table.insert(ContentChildren, New("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 10),
		}))
		table.insert(ContentChildren, New("UIPadding", {
			PaddingTop = UDim.new(0, 10),
			PaddingBottom = UDim.new(0, 10),
			PaddingLeft = UDim.new(0, 14),
			PaddingRight = UDim.new(0, 14),
		}))

		local ContentButton = New("TextButton", {
			Name = "ToastContentHolder",
			Text = "",
			BackgroundTransparency = 1,
			AutomaticSize = Enum.AutomaticSize.XY,
			Size = UDim2.fromOffset(0, 0),
			LayoutOrder = 1,
		}, ContentChildren)

		local ProgressFill = New("Frame", {
			Name = "ToastProgressFill",
			Size = UDim2.fromScale(1, 1),
			BackgroundColor3 = Style.Color or Color3.fromRGB(255, 255, 255),
			BorderSizePixel = 0,
			ThemeTag = AccentTag("BackgroundColor3"),
		})

		local PillChildren = {
			New("UICorner", {
				CornerRadius = UDim.new(0, 8),
			}),
			New("UIStroke", {
				Transparency = 0.3,
				ThemeTag = {
					Color = "DialogBorder",
				},
			}),
			New("UIListLayout", {
				SortOrder = Enum.SortOrder.LayoutOrder,
				HorizontalAlignment = Enum.HorizontalAlignment.Left,
			}),
			ContentButton,
		}

		if ShowProgress then
			table.insert(PillChildren, New("Frame", {
				Name = "ToastProgress",
				Size = UDim2.new(1, 0, 0, 2),
				BackgroundTransparency = 1,
				LayoutOrder = 2,
			}, {
				ProgressFill,
			}))
		end

		NewToast.Wrapper = New("Frame", {
			Name = "ToastWrapper",
			Size = UDim2.new(1, 0, 0, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			LayoutOrder = (function()
				Toast.Order = Toast.Order + 1
				return Toast.Order
			end)(),
			Parent = Holder,
		})

		NewToast.Pill = New("CanvasGroup", {
			Name = "Toast",
			AnchorPoint = Vector2.new(0.5, 0),
			Position = UDim2.new(0.5, 0, 0, 0),
			Size = UDim2.fromOffset(0, 0),
			AutomaticSize = Enum.AutomaticSize.XY,
			GroupTransparency = 1,
			BackgroundTransparency = 0,
			BackgroundColor3 = Color3.fromRGB(30, 30, 30),
			Parent = NewToast.Wrapper,
			ThemeTag = {
				BackgroundColor3 = "Dialog",
			},
		}, PillChildren)

		function NewToast:Close()
			if NewToast.Closed then
				return
			end
			NewToast.Closed = true

			local Wrapper, Pill = NewToast.Wrapper, NewToast.Pill
			if not Wrapper or not Wrapper.Parent then
				return
			end

			if not NewToast.Ready then
				Wrapper:Destroy()
				return
			end

			TweenService:Create(Pill, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
				GroupTransparency = 1,
				Position = UDim2.new(0.5, 0, 0, Offset),
			}):Play()

			task.delay(0.12, function()
				if not Wrapper.Parent then
					return
				end
				local Collapse = TweenService:Create(Wrapper, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
					Size = UDim2.new(1, 0, 0, 0),
				})
				Collapse:Play()
				task.delay(0.27, function()
					Wrapper:Destroy()
				end)
			end)

			if Config.OnClose then
				Library:SafeCallback(Config.OnClose)
			end
		end

		if Config.Closable ~= false then
			Creator.AddSignal(ContentButton.MouseButton1Click, function()
				NewToast:Close()
			end)
		end

		task.spawn(function()
			task.wait()
			local Wrapper, Pill = NewToast.Wrapper, NewToast.Pill
			if NewToast.Closed or not Wrapper.Parent then
				return
			end

			local Height = Pill.AbsoluteSize.Y
			Wrapper.AutomaticSize = Enum.AutomaticSize.None
			Wrapper.Size = UDim2.new(1, 0, 0, 0)
			Pill.Position = UDim2.new(0.5, 0, 0, Offset)
			NewToast.Ready = true

			TweenService:Create(Wrapper, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
				Size = UDim2.new(1, 0, 0, Height),
			}):Play()
			TweenService:Create(Pill, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
				GroupTransparency = 0,
				Position = UDim2.new(0.5, 0, 0, 0),
			}):Play()

			if type(Duration) == "number" and Duration > 0 then
				if ShowProgress then
					TweenService:Create(ProgressFill, TweenInfo.new(Duration, Enum.EasingStyle.Linear), {
						Size = UDim2.fromScale(0, 1),
					}):Play()
				end
				task.delay(Duration, function()
					NewToast:Close()
				end)
			end
		end)

		return NewToast
	end

	return Toast
end)()

