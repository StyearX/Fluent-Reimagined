ElementsTable.Slider = (function()
	local New = Creator.New

	local Element = {}
	Element.__index = Element
	Element.__type = "Slider"

	function Element:New(Idx, Config)
		local Library = self.Library
		assert(Config.Title, "Slider - Missing Title.")
		assert(Config.Default, "Slider - Missing default value.")
		assert(Config.Min, "Slider - Missing minimum value.")
		assert(Config.Max, "Slider - Missing maximum value.")
		assert(Config.Rounding, "Slider - Missing rounding value.")

		local Slider = {
			Value = nil,
			Min = Config.Min,
			Max = Config.Max,
			Rounding = Config.Rounding,
			Callback = Config.Callback or function(Value) end,
			Type = "Slider",
		}

		local Dragging = false
		local IsGrouped = self.Type == "Group" or self.Type == "HStack" or self.Type == "VStack"

		local SliderFrame = Components.Element(Config.Title, Config.Description, self.Container, false, Config.LayoutOrder, Config.Icon, Config.Marquee)

		local SliderDot, SliderRail, SliderFill, SliderDisplay, SliderInner, SliderRow, SliderHit, SliderValueTooltip, SliderConstraint
		local ShowTooltip, HideTooltip

		SliderRow = New("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, 20),
			LayoutOrder = 2,
			Visible = IsGrouped,
			Parent = SliderFrame.LabelHolder,
		})

		if Library.NewVisual then

			SliderValueTooltip = New("CanvasGroup", {
				AnchorPoint = Vector2.new(0.5, 1),
				Position = UDim2.new(0, 0, 0, -6),
				Size = UDim2.fromOffset(48, 22),
				BackgroundTransparency = 0,
				GroupTransparency = 1,
				Visible = true,
				ZIndex = 10,
				ThemeTag = {
					BackgroundColor3 = "Element",
				},
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(0, 4),
				}),
				New("UIStroke", {
					Thickness = 1,
					Transparency = 0.5,
					ThemeTag = {
						Color = "InElementBorder",
					},
				}),
				New("TextLabel", {
					Name = "ValueLabel",
					FontFace = Font.new(Library.Font, Enum.FontWeight.Medium, Enum.FontStyle.Normal),
					Text = "0",
					TextSize = 11,
					TextXAlignment = Enum.TextXAlignment.Center,
					BackgroundTransparency = 1,
					Size = UDim2.fromScale(1, 1),
					ZIndex = 10,
					ThemeTag = {
						TextColor3 = "Text",
					},
				}),
			})

			SliderDot = New("Frame", {
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.new(0, 0, 0.5, 0),
				Size = UDim2.fromOffset(3, 18),
				ZIndex = 5,
				ThemeTag = {
					BackgroundColor3 = "Accent",
				},
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(0, 2),
				}),
				New("UIStroke", {
					Thickness = 1.5,
					Transparency = 0.3,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					ThemeTag = {
						Color = "AcrylicBorder",
					},
				}),
				SliderValueTooltip,
			})

			SliderRail = New("Frame", {
				BackgroundTransparency = 1,
				Position = UDim2.fromOffset(0, 0),
				Size = UDim2.fromScale(1, 1),
			}, {
				SliderDot,
			})

			SliderFill = New("Frame", {
				Size = UDim2.new(0, 0, 1, 0),
				ThemeTag = {
					BackgroundColor3 = "Accent",
				},
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(1, 0),
				}),
			})

			SliderInner = New("Frame", {
				Size = IsGrouped and UDim2.new(1, -40, 0, 4) or UDim2.new(1, 0, 0, 4),
				AnchorPoint = Vector2.new(1, 0.5),
				Position = IsGrouped and UDim2.new(1, -8, 0.5, 0) or UDim2.new(1, -10, 0.5, 0),
				BackgroundTransparency = 0.4,
				Parent = IsGrouped and SliderRow or SliderFrame.Frame,
				ThemeTag = {
					BackgroundColor3 = "SliderRail",
				},
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(1, 0),
				}),
			})

			SliderDisplay = New("TextLabel", {
				FontFace = Font.new(Library.Font),
				Text = "Value",
				TextSize = 12,
				TextWrapped = true,
				TextXAlignment = Enum.TextXAlignment.Right,
				BackgroundTransparency = 1,
				Size = UDim2.new(0, 100, 0, 14),
				Position = UDim2.new(0, -4, 0.5, 0),
				AnchorPoint = Vector2.new(1, 0.5),
				Visible = IsGrouped,
				Parent = SliderInner,
				ThemeTag = {
					TextColor3 = "SubText",
				},
			})

			SliderConstraint = New("UISizeConstraint", {
				MaxSize = IsGrouped and Vector2.new(math.huge, math.huge) or Vector2.new(150, math.huge),
				Parent = SliderInner,
			})

			SliderFill.Parent = SliderInner
			SliderRail.Parent = SliderInner

			SliderHit = New("Frame", {
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.fromScale(0.5, 0.5),
				Size = UDim2.new(1, 12, 0, 24),
				BackgroundTransparency = 1,
				ZIndex = 2,
				Parent = SliderInner,
			})

			local TooltipTween

			local function SetTooltipVisible(Visible)
				if TooltipTween then
					TooltipTween:Cancel()
				end
				TooltipTween = TweenService:Create(
					SliderValueTooltip,
					TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{ GroupTransparency = Visible and 0 or 1 }
				)
				TooltipTween:Play()
			end

			ShowTooltip = function()
				SetTooltipVisible(true)
			end

			HideTooltip = function()
				SetTooltipVisible(false)
			end
		else
			SliderDot = New("ImageLabel", {
				AnchorPoint = Vector2.new(0, 0.5),
				Position = UDim2.new(0, -7, 0.5, 0),
				Size = UDim2.fromOffset(14, 14),
				Image = "http://www.roblox.com/asset/?id=12266946128",
				ThemeTag = {
					ImageColor3 = "Accent",
				},
			})

			SliderRail = New("Frame", {
				BackgroundTransparency = 1,
				Position = UDim2.fromOffset(7, 0),
				Size = UDim2.new(1, -14, 1, 0),
			}, {
				SliderDot,
			})

			SliderFill = New("Frame", {
				Size = UDim2.new(0, 0, 1, 0),
				ThemeTag = {
					BackgroundColor3 = "Accent",
				},
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(1, 0),
				}),
			})

			SliderDisplay = New("TextLabel", {
				FontFace = Font.new(Library.Font),
				Text = "Value",
				TextSize = 12,
				TextWrapped = true,
				TextXAlignment = Enum.TextXAlignment.Right,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				Size = UDim2.new(0, 100, 0, 14),
				Position = UDim2.new(0, -4, 0.5, 0),
				AnchorPoint = Vector2.new(1, 0.5),
				ThemeTag = {
					TextColor3 = "SubText",
				},
			})

			SliderConstraint = New("UISizeConstraint", {
				MaxSize = IsGrouped and Vector2.new(math.huge, math.huge) or Vector2.new(150, math.huge),
			})

			SliderInner = New("Frame", {
				Size = IsGrouped and UDim2.new(1, -40, 0, 4) or UDim2.new(1, 0, 0, 4),
				AnchorPoint = Vector2.new(1, 0.5),
				Position = IsGrouped and UDim2.new(1, -8, 0.5, 0) or UDim2.new(1, -10, 0.5, 0),
				BackgroundTransparency = 0.4,
				Parent = IsGrouped and SliderRow or SliderFrame.Frame,
				ThemeTag = {
					BackgroundColor3 = "SliderRail",
				},
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(1, 0),
				}),
				SliderConstraint,
				SliderDisplay,
				SliderFill,
				SliderRail,
			})
		end

		Creator.Adaptive(SliderFrame, 170, 340, not IsGrouped, function(Inline)
			SliderRow.Visible = not Inline
			SliderInner.Parent = Inline and SliderFrame.Frame or SliderRow
			SliderInner.Size = Inline and UDim2.new(1, 0, 0, 4) or UDim2.new(1, -40, 0, 4)
			SliderInner.Position = Inline and UDim2.new(1, -10, 0.5, 0) or UDim2.new(1, -8, 0.5, 0)
			SliderConstraint.MaxSize = Inline and Vector2.new(150, math.huge) or Vector2.new(math.huge, math.huge)
			if Library.NewVisual then
				SliderDisplay.Visible = not Inline
			end
		end)

		Slider.SetTitle = SliderFrame.SetTitle
		Slider.SetDesc = SliderFrame.SetDesc

		local function BeginDrag(Input)
			if
				Input.UserInputType == Enum.UserInputType.MouseButton1
				or Input.UserInputType == Enum.UserInputType.Touch
			then
				Dragging = true
				if ShowTooltip then
					ShowTooltip()
				end
				local SizeScale =
					math.clamp((Input.Position.X - SliderRail.AbsolutePosition.X) / SliderRail.AbsoluteSize.X, 0, 1)
				Slider:SetValue(Slider.Min + ((Slider.Max - Slider.Min) * SizeScale))
			end
		end

		Creator.AddSignal(SliderDot.InputBegan, function(Input)
			if
				Input.UserInputType == Enum.UserInputType.MouseButton1
				or Input.UserInputType == Enum.UserInputType.Touch
			then
				Dragging = true
				if ShowTooltip then
					ShowTooltip()
				end
			end
		end)

		Creator.AddSignal(SliderRail.InputBegan, BeginDrag)

		if SliderHit then
			Creator.AddSignal(SliderHit.InputBegan, BeginDrag)
		end

		Creator.AddSignal(UserInputService.InputEnded, function(Input)
			if
				Input.UserInputType == Enum.UserInputType.MouseButton1
				or Input.UserInputType == Enum.UserInputType.Touch
			then
				Dragging = false
				if HideTooltip then
					HideTooltip()
				end
			end
		end)

		Creator.AddSignal(UserInputService.InputChanged, function(Input)
			if
				Dragging
				and (
					Input.UserInputType == Enum.UserInputType.MouseMovement
					or Input.UserInputType == Enum.UserInputType.Touch
				)
			then
				local SizeScale =
					math.clamp((Input.Position.X - SliderRail.AbsolutePosition.X) / SliderRail.AbsoluteSize.X, 0, 1)
				Slider:SetValue(Slider.Min + ((Slider.Max - Slider.Min) * SizeScale))
			end
		end)

		function Slider:OnChanged(Func)
			Slider.Changed = Func
			Func(Slider.Value)
		end

		function Slider:SetValue(Value)
			self.Value = Library:Round(math.clamp(Value, Slider.Min, Slider.Max), Slider.Rounding)
			local Scale = (self.Value - Slider.Min) / (Slider.Max - Slider.Min)
			if SliderValueTooltip then
				SliderDot.Position = UDim2.new(Scale, 0, 0.5, 0)
				SliderValueTooltip.ValueLabel.Text = tostring(self.Value)
			else
				SliderDot.Position = UDim2.new(Scale, -7, 0.5, 0)
			end
			SliderFill.Size = UDim2.fromScale(Scale, 1)
			if SliderDisplay then
				SliderDisplay.Text = tostring(self.Value)
			end

			Library:SafeCallback(Slider.Callback, self.Value)
			Library:SafeCallback(Slider.Changed, self.Value)
		end

		function Slider:Destroy()
			SliderFrame:Destroy()
			Library.Options[Idx] = nil
		end

		Slider:SetValue(Config.Default)

		Library.Options[Idx] = Slider
		return Slider
	end

	return Element
end)()


