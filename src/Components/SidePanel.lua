local TweenService: TweenService = cloneref(game:GetService("TweenService"))

Components.SidePanel = (function()
	local Spring = Flipper.Spring.new
	local New = Creator.New

	local SidePanel = {
		Window = nil,
	}

	function SidePanel:Init(Window)
		SidePanel.Window = Window
		return SidePanel
	end

	local MenuButtonTags = { Background = "MenuButton", Border = "MenuButtonBorder" }
	local MenuInputTags = {
		Input = "MenuInput",
		InputLine = "MenuInputLine",
		InputBorder = "MenuButtonBorder",
		InputFocused = "MenuInputFocused",
	}

	function SidePanel:Create(Config)
		Config = Config or {}
		local Side = Config.Side == "Left" and "Left" or "Right"
		local PanelWidth = Config.Width or 300
		local AnchorX = Side == "Right" and 1 or 0

		local NewPanel = {
			Buttons = 0,
			Rows = 0,
			Side = Side,
		}

		setmetatable(NewPanel, Elements)

		NewPanel.TintFrame = New("TextButton", {
			Text = "",
			Size = UDim2.fromScale(1, 1),
			BackgroundColor3 = Color3.fromRGB(0, 0, 0),
			BackgroundTransparency = 1,
			Parent = SidePanel.Window.Root,
		})

		local TintMotor, TintTransparency = Creator.SpringMotor(1, NewPanel.TintFrame, "BackgroundTransparency", true)

		NewPanel.Title = New("TextLabel", {
			FontFace = Font.new(Library.Font, Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
			Text = Config.Title or "Panel",
			TextColor3 = Color3.fromRGB(240, 240, 240),
			TextSize = 18,
			TextXAlignment = Enum.TextXAlignment.Left,
			Size = UDim2.new(1, -40, 0, 20),
			Position = UDim2.fromOffset(20, 18),
			BackgroundTransparency = 1,
			ThemeTag = {
				TextColor3 = "Text",
			},
		})

		NewPanel.Description = New("TextLabel", {
			FontFace = Font.new(Library.Font),
			Text = Config.Description or "",
			Visible = Config.Description ~= nil and Config.Description ~= "",
			TextColor3 = Color3.fromRGB(200, 200, 200),
			TextSize = 13,
			TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Left,
			Size = UDim2.new(1, -40, 0, 16),
			Position = UDim2.fromOffset(20, 42),
			BackgroundTransparency = 1,
			ThemeTag = {
				TextColor3 = "SubText",
			},
		})

		NewPanel.RowHolder = New("ScrollingFrame", {
			Size = UDim2.new(1, -20, 1, -140),
			Position = UDim2.fromOffset(10, 68),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ScrollBarThickness = 3,
			ScrollBarImageTransparency = 0.4,
			CanvasSize = UDim2.fromScale(0, 0),
			AutomaticCanvasSize = Enum.AutomaticSize.Y,
			ScrollingDirection = Enum.ScrollingDirection.Y,
			ClipsDescendants = true,
		}, {
			New("UIListLayout", {
				Padding = UDim.new(0, 8),
				SortOrder = Enum.SortOrder.LayoutOrder,
			}),
			New("UIPadding", {
				PaddingTop = UDim.new(0, 4),
				PaddingBottom = UDim.new(0, 8),
				PaddingLeft = UDim.new(0, 4),
				PaddingRight = UDim.new(0, 4),
			}),
		})

		NewPanel.Container = NewPanel.RowHolder
		NewPanel.Type = "Group"
		NewPanel.ScrollFrame = NewPanel.RowHolder
		NewPanel.Library = Library

		NewPanel.HolderLine = New("Frame", {
			Size = UDim2.new(1, 0, 0, 1),
			ThemeTag = {
				BackgroundColor3 = "MenuHolderLine",
			},
		})

		NewPanel.ButtonHolder = New("Frame", {
			Size = UDim2.new(1, -20, 0, 32),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundTransparency = 1,
		}, {
			New("UIListLayout", {
				Padding = UDim.new(0, 10),
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
			}),
		})

		NewPanel.ButtonHolderFrame = New("Frame", {
			Size = UDim2.new(1, 0, 0, 64),
			Position = UDim2.new(0, 0, 1, -64),
			ThemeTag = {
				BackgroundColor3 = "MenuHolder",
			},
		}, {
			NewPanel.HolderLine,
			NewPanel.ButtonHolder,
		})

		NewPanel.SlideOffset = Side == "Right" and (PanelWidth + 24) or -(PanelWidth + 24)
		local SlideMotor = Flipper.SingleMotor.new(NewPanel.SlideOffset)

		NewPanel.Root = New("CanvasGroup", {
			Size = UDim2.new(0, PanelWidth, 1, -20),
			AnchorPoint = Vector2.new(AnchorX, 0.5),
			Position = UDim2.new(AnchorX, NewPanel.SlideOffset, 0.5, 0),
			GroupTransparency = 1,
			BackgroundTransparency = 1,
			Parent = NewPanel.TintFrame,
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 8),
			}),
			New("UIStroke", {
				Transparency = 0.5,
				ThemeTag = {
					Color = "MenuBorder",
				},
			}),
			New("Frame", {
				Name = "MenuBackground",
				Size = UDim2.fromScale(1, 1),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(0, 8),
				}),
				New("UIGradient", {
					ThemeTag = {
						Color = "MenuBackground",
						Rotation = "MenuBackgroundRotation",
					},
				}),
			}),
			NewPanel.Title,
			NewPanel.Description,
			NewPanel.RowHolder,
			NewPanel.ButtonHolderFrame,
		})

		SlideMotor:onStep(function(Value)
			NewPanel.Root.Position = UDim2.new(AnchorX, Value, 0.5, 0)
		end)

		local RootMotor, RootTransparency = Creator.SpringMotor(1, NewPanel.Root, "GroupTransparency")

		function NewPanel:Open()
			Library.DialogOpen = true
			TintTransparency(0.75)
			RootTransparency(0)
			SlideMotor:setGoal(Spring(0, { frequency = 5 }))
		end

		Creator.AddSignal(NewPanel.TintFrame.MouseButton1Click, function()
			pcall(function()
				NewPanel:Close()
			end)
		end)

		function NewPanel:Close()
			if NewPanel.Closing then
				return
			end
			NewPanel.Closing = true
			Library.DialogOpen = false

			-- stop the open springs so they do not fight the close tween
			pcall(function()
				SlideMotor:stop()
				RootMotor:stop()
				TintMotor:stop()
			end)

			local SlideInfo = TweenInfo.new(0.32, Enum.EasingStyle.Quart, Enum.EasingDirection.In)

			TweenService:Create(NewPanel.TintFrame, TweenInfo.new(0.32, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				BackgroundTransparency = 1,
			}):Play()

			TweenService:Create(NewPanel.Root, SlideInfo, {
				Position = UDim2.new(AnchorX, NewPanel.SlideOffset, 0.5, 0),
				GroupTransparency = 1,
			}):Play()

			local Stroke = NewPanel.Root:FindFirstChildOfClass("UIStroke")
			if Stroke then
				TweenService:Create(Stroke, SlideInfo, { Transparency = 1 }):Play()
			end

			task.delay(0.34, function()
				pcall(function()
					NewPanel.TintFrame:Destroy()
				end)
			end)
		end

		function NewPanel:Button(Title, Callback)
			NewPanel.Buttons = NewPanel.Buttons + 1
			Title = Title or "Button"
			Callback = Callback or function() end

			local Button = Components.Button("", NewPanel.ButtonHolder, true, MenuButtonTags)
			Button.Title.Text = Title
			Button.Frame.LayoutOrder = NewPanel.Buttons

			for _, Btn in next, NewPanel.ButtonHolder:GetChildren() do
				if Btn:IsA("TextButton") then
					Btn.Size = UDim2.new(1 / NewPanel.Buttons, -(((NewPanel.Buttons - 1) * 10) / NewPanel.Buttons), 0, 32)
				end
			end

			Creator.AddSignal(Button.Frame.MouseButton1Click, function()
				Library:SafeCallback(Callback)
			end)

			return Button
		end

		function NewPanel:AddInput(IdxOrConfig, RowConfig)
			local Idx
			if type(IdxOrConfig) == "table" then
				RowConfig = IdxOrConfig
			else
				Idx = IdxOrConfig
			end
			RowConfig = RowConfig or {}
			NewPanel.Rows = NewPanel.Rows + 1

			local Row = Components.Element(
				RowConfig.Title,
				RowConfig.Description,
				NewPanel.RowHolder,
				false,
				NewPanel.Rows,
				RowConfig.Icon,
				RowConfig.Marquee ~= false
			)

			local Textbox = Components.Textbox(Row.Frame, true, MenuInputTags)
			Textbox.Frame.Position = UDim2.new(1, -10, 0.5, 0)
			Textbox.Frame.AnchorPoint = Vector2.new(1, 0.5)
			Textbox.Frame.Size = UDim2.fromOffset(140, 30)
			Textbox.Input.Text = RowConfig.Default or ""
			Textbox.Input.PlaceholderText = RowConfig.Placeholder or ""

			local RowInput = {
				Value = RowConfig.Default or "",
				Frame = Row.Frame,
				Type = "Input",
				SetTitle = Row.SetTitle,
				SetDesc = Row.SetDesc,
			}

			local function Commit()
				RowInput.Value = Textbox.Input.Text
				Library:SafeCallback(RowConfig.Callback, RowInput.Value)
			end

			if RowConfig.Finished then
				Creator.AddSignal(Textbox.Input.FocusLost, function(EnterPressed)
					Commit()
				end)
			else
				Creator.AddSignal(Textbox.Input:GetPropertyChangedSignal("Text"), Commit)
			end

			function RowInput:SetValue(Text)
				Textbox.Input.Text = Text
				RowInput.Value = Text
			end

			function RowInput:Destroy()
				if Idx then
					Library.Options[Idx] = nil
				end
			end

			if Idx then
				Library.Options[Idx] = RowInput
			end

			return RowInput
		end

		function NewPanel:AddButton(IdxOrConfig, RowConfig)
			if type(IdxOrConfig) == "table" then
				RowConfig = IdxOrConfig
			end
			RowConfig = RowConfig or {}
			NewPanel.Rows = NewPanel.Rows + 1

			local Row = Components.Element(
				RowConfig.Title,
				RowConfig.Description,
				NewPanel.RowHolder,
				true,
				NewPanel.Rows,
				RowConfig.Icon,
				RowConfig.Marquee ~= false
			)

			New("ImageLabel", {
				Image = "rbxassetid://10709791437",
				Size = UDim2.fromOffset(16, 16),
				AnchorPoint = Vector2.new(1, 0.5),
				Position = UDim2.new(1, -10, 0.5, 0),
				BackgroundTransparency = 1,
				Parent = Row.Frame,
				ThemeTag = {
					ImageColor3 = "Text",
				},
			})

			Creator.AddSignal(Row.Frame.MouseButton1Click, function()
				Library:SafeCallback(RowConfig.Callback)
			end)

			return {
				Frame = Row.Frame,
				Type = "Button",
				SetTitle = Row.SetTitle,
				SetDesc = Row.SetDesc,
			}
		end

		function NewPanel:AddToggle(Idx, RowConfig)
			RowConfig = RowConfig or {}
			NewPanel.Rows = NewPanel.Rows + 1
			RowConfig.LayoutOrder = NewPanel.Rows
			return Elements.AddToggle(NewPanel, Idx, RowConfig)
		end

		function NewPanel:AddSlider(Idx, RowConfig)
			RowConfig = RowConfig or {}
			NewPanel.Rows = NewPanel.Rows + 1
			RowConfig.LayoutOrder = NewPanel.Rows
			return Elements.AddSlider(NewPanel, Idx, RowConfig)
		end

		function NewPanel:AddColorpicker(Idx, RowConfig)
			RowConfig = RowConfig or {}
			NewPanel.Rows = NewPanel.Rows + 1
			RowConfig.LayoutOrder = NewPanel.Rows
			return Elements.AddColorpicker(NewPanel, Idx, RowConfig)
		end

		function NewPanel:AddDropdown(Idx, RowConfig)
			RowConfig = RowConfig or {}
			NewPanel.Rows = NewPanel.Rows + 1
			RowConfig.LayoutOrder = NewPanel.Rows
			return Elements.AddDropdown(NewPanel, Idx, RowConfig)
		end

		function NewPanel:AddGradientPicker(Idx, RowConfig)
			RowConfig = RowConfig or {}
			NewPanel.Rows = NewPanel.Rows + 1
			RowConfig.LayoutOrder = NewPanel.Rows
			return Elements.AddGradientPicker(NewPanel, Idx, RowConfig)
		end

		function NewPanel:PromptImport(ImportConfig)
			ImportConfig = ImportConfig or {}

			local ImportDialog = Components.Dialog:Create()
			ImportDialog.Title.Text = ImportConfig.Title or "Import"
			ImportDialog.Root.Size = UDim2.fromOffset(320, 190)

			local ImportBox = Components.Textbox(nil, false)
			ImportBox.Frame.Parent = ImportDialog.Root
			ImportBox.Frame.Position = UDim2.fromOffset(20, 60)
			ImportBox.Frame.Size = UDim2.new(1, -40, 0, 32)
			ImportBox.Input.Text = ImportConfig.Default or ""
			ImportBox.Input.PlaceholderText = ImportConfig.Placeholder or "Paste import string here"

			ImportDialog:Button("Cancel", function()
				Library:SafeCallback(ImportConfig.OnCancel)
			end)

			ImportDialog:Button("Confirm", function()
				Library:SafeCallback(ImportConfig.Callback, ImportBox.Input.Text)
			end)

			ImportDialog:Open()
			return ImportDialog
		end

		if Config.Buttons and #Config.Buttons > 0 then
			for _, BtnCfg in ipairs(Config.Buttons) do
				NewPanel:Button(BtnCfg.Title or "Button", function()
					Library:SafeCallback(BtnCfg.Callback)
					if BtnCfg.CloseOnClick ~= false then
						pcall(function() NewPanel:Close() end)
					end
				end)
			end
		end

		return NewPanel
	end

	return SidePanel
end)()

