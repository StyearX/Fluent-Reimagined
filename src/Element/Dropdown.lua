local TweenService: TweenService = cloneref(game:GetService("TweenService"))
local UserInputService: UserInputService = cloneref(game:GetService("UserInputService"))

ElementsTable.Dropdown = (function()
	local New = Creator.New

	local Element = {}
	Element.__index = Element
	Element.__type = "Dropdown"

	function Element:New(Idx, Config)
		local Library = self.Library

		local InitialValue = Config.Default
		if Config.Multi then
			InitialValue = {}
			if type(Config.Default) == "table" then
				for Key, State in next, Config.Default do
					if type(Key) == "string" and State == true then
						InitialValue[Key] = true
					end
				end
			end
		end

		local Dropdown = {
			Values = Config.Values,
			Value = InitialValue,
			Multi = Config.Multi,
			Buttons = {},
			Opened = false,
			Type = "Dropdown",
			Callback = Config.Callback or function() end,
		}

		local IsGrouped = self.Type == "Group" or self.Type == "HStack" or self.Type == "VStack"

		local DropdownFrame = Components.Element(Config.Title, Config.Description, self.Container, false, Config.LayoutOrder, Config.Icon, Config.Marquee)

		local DropdownRow = New("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, 34),
			LayoutOrder = 2,
			Visible = IsGrouped,
			Parent = DropdownFrame.LabelHolder,
		})

		Dropdown.SetTitle = DropdownFrame.SetTitle
		Dropdown.SetDesc = DropdownFrame.SetDesc

		local DropdownDisplay = New("TextLabel", {
			FontFace = Font.new(Library.Font, Enum.FontWeight.Regular, Enum.FontStyle.Normal),
			Text = "Value",
			TextColor3 = Color3.fromRGB(240, 240, 240),
			TextSize = 13,
			TextXAlignment = Enum.TextXAlignment.Left,
			Size = UDim2.new(1, -40, 1, 0),
			Position = UDim2.new(0, 8, 0.5, 0),
			AnchorPoint = Vector2.new(0, 0.5),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			TextTruncate = Enum.TextTruncate.AtEnd,
			ThemeTag = {
				TextColor3 = "Text",
			},
		})

		local DropdownIco = New("ImageLabel", {
			Image = "rbxassetid://10709790948",
			Size = UDim2.fromOffset(16, 16),
			AnchorPoint = Vector2.new(1, 0.5),
			Position = UDim2.new(1, -8, 0.5, 0),
			BackgroundTransparency = 1,
			ThemeTag = {
				ImageColor3 = "SubText",
			},
		})

		local IcoMotor, SetIcoRotation = Creator.SpringMotor(0, DropdownIco, "Rotation", true)

		local DropdownInner = New("TextButton", {
			Size = IsGrouped and UDim2.new(1, 0, 0, 30) or UDim2.fromOffset(160, 30),
			Position = IsGrouped and UDim2.new(0, 0, 0.5, 0) or UDim2.new(1, -10, 0.5, 0),
			AnchorPoint = IsGrouped and Vector2.new(0, 0.5) or Vector2.new(1, 0.5),
			BackgroundTransparency = 0.9,
			Parent = IsGrouped and DropdownRow or DropdownFrame.Frame,
			ThemeTag = {
				BackgroundColor3 = "DropdownFrame",
			},
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 5),
			}),
			New("UIStroke", {
				Transparency = 0.5,
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				ThemeTag = {
					Color = "InElementBorder",
				},
			}),
			DropdownIco,
			DropdownDisplay,
		})

		Creator.Adaptive(DropdownFrame, 170, 340, not IsGrouped, function(Inline)
			DropdownInner.Parent = Inline and DropdownFrame.Frame or DropdownRow
			DropdownInner.Size = Inline and UDim2.fromOffset(160, 30) or UDim2.new(1, 0, 0, 30)
			DropdownInner.Position = Inline and UDim2.new(1, -10, 0.5, 0) or UDim2.new(0, 0, 0.5, 0)
			DropdownInner.AnchorPoint = Inline and Vector2.new(1, 0.5) or Vector2.new(0, 0.5)
			DropdownRow.Visible = not Inline
		end)

		local DropdownListLayout = New("UIListLayout", {
			Padding = UDim.new(0, 3),
		})

		local DROPDOWN_Z_INDEX = 100000 -- keeps the list above every window layer

		local DropdownScrollFrame = New("ScrollingFrame", {
			Size = UDim2.new(1, -5, 1, -10),
			Position = UDim2.fromOffset(5, 5),
			BackgroundTransparency = 1,
			ScrollBarImageColor3 = Color3.fromRGB(200, 200, 200),
			ScrollBarImageTransparency = 0.4,
			ScrollBarThickness = 3,
			BorderSizePixel = 0,
			CanvasSize = UDim2.fromScale(0, 0),
			ScrollingDirection = Enum.ScrollingDirection.Y,
			ElasticBehavior = Enum.ElasticBehavior.Always,
			ZIndex = DROPDOWN_Z_INDEX + 2,
			ThemeTag = {
				ScrollBarImageColor3 = "SubText",
			},
		}, {
			DropdownListLayout,
		})

		local DropdownSearchBox, DropdownSearchHolder
		if Config.Search then
			local DropdownSearchIcon = New("ImageLabel", {
				Image = "rbxassetid://10734943674",
				Size = UDim2.fromOffset(16, 16),
				AnchorPoint = Vector2.new(0, 0.5),
				Position = UDim2.new(0, 10, 0.5, 0),
				BackgroundTransparency = 1,
				ImageTransparency = 0.3,
				ZIndex = DROPDOWN_Z_INDEX + 4,
				ThemeTag = {
					ImageColor3 = "SubText",
				},
			})

			DropdownSearchBox = New("TextBox", {
				FontFace = Font.new(Library.Font, Enum.FontWeight.Regular, Enum.FontStyle.Normal),
				PlaceholderText = "Search...",
				Text = "",
				ClearTextOnFocus = false,
				TextColor3 = Color3.fromRGB(200, 200, 200),
				PlaceholderColor3 = Color3.fromRGB(120, 120, 120),
				TextSize = 13,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextYAlignment = Enum.TextYAlignment.Center,
				Size = UDim2.new(1, -36, 1, 0),
				Position = UDim2.new(0, 32, 0, 0),
				BackgroundTransparency = 1,
				ZIndex = DROPDOWN_Z_INDEX + 3,
				ThemeTag = {
					TextColor3 = "Text",
					PlaceholderColor3 = "SubText",
				},
			})

			DropdownSearchHolder = New("Frame", {
				Size = UDim2.new(1, -10, 0, 28),
				Position = UDim2.fromOffset(5, 5),
				BackgroundTransparency = 0.7,
				BackgroundColor3 = Color3.fromRGB(20, 20, 20),
				ZIndex = DROPDOWN_Z_INDEX + 2,
				ThemeTag = {
					BackgroundColor3 = "Element",
				},
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(0, 4),
				}),
				DropdownSearchIcon,
				DropdownSearchBox,
			})

			DropdownScrollFrame.Position = UDim2.fromOffset(5, 38)
			DropdownScrollFrame.Size = UDim2.new(1, -5, 1, -43)
		end

		local DropdownHolderChildren = {
			DropdownScrollFrame,
			New("UICorner", {
				CornerRadius = UDim.new(0, 7),
			}),
			New("UIStroke", {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				ThemeTag = {
					Color = "DropdownBorder",
				},
			}),
			New("ImageLabel", {
				BackgroundTransparency = 1,
				Image = "http://www.roblox.com/asset/?id=5554236805",
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = Rect.new(23, 23, 277, 277),
				Size = UDim2.fromScale(1, 1) + UDim2.fromOffset(30, 30),
				Position = UDim2.fromOffset(-15, -15),
				ImageColor3 = Color3.fromRGB(0, 0, 0),
				ImageTransparency = 0.1,
				ZIndex = DROPDOWN_Z_INDEX,
			}),
		}
		if DropdownSearchHolder then
			table.insert(DropdownHolderChildren, DropdownSearchHolder)
		end

		local DropdownHolderFrame = New("Frame", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 0,
			ZIndex = DROPDOWN_Z_INDEX + 1,
			ThemeTag = {
				BackgroundColor3 = "DropdownHolder",
			},
		}, DropdownHolderChildren)

		local DropdownHolderCanvas = New("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.fromOffset(170, 300),
			Parent = self.Library.GUI,
			Visible = false,
			ZIndex = DROPDOWN_Z_INDEX,
		}, {
			DropdownHolderFrame,
			New("UISizeConstraint", {
				MinSize = Vector2.new(170, 0),
			}),
		})
		table.insert(Library.OpenFrames, DropdownHolderCanvas)

		local function RecalculateListPosition()
			local Add = 0
			if Camera.ViewportSize.Y - DropdownInner.AbsolutePosition.Y < DropdownHolderCanvas.AbsoluteSize.Y - 5 then
				Add = DropdownHolderCanvas.AbsoluteSize.Y
					- 5
					- (Camera.ViewportSize.Y - DropdownInner.AbsolutePosition.Y)
					+ 40
			end
			DropdownHolderCanvas.Position =
				UDim2.fromOffset(DropdownInner.AbsolutePosition.X - 1, DropdownInner.AbsolutePosition.Y - 5 - Add)
		end

		local ListSizeX = 0

		local function RecalculateListSize()
			local VisibleCount = 0
			for _, Option in next, DropdownScrollFrame:GetChildren() do
				if Option:IsA("TextButton") and Option.Visible then
					VisibleCount = VisibleCount + 1
				end
			end

			local ItemHeight = 32
			local ItemPadding = 3
			local InnerMargins = 10
			local SearchHeight = DropdownSearchHolder and 38 or 0
			local Content = VisibleCount > 0 and (VisibleCount * ItemHeight + (VisibleCount - 1) * ItemPadding) or 0
			local Height = math.min(Content + InnerMargins + SearchHeight, 392)
			local Width = math.max(DropdownInner.AbsoluteSize.X, ListSizeX)

			DropdownHolderCanvas.Size = UDim2.fromOffset(Width, Height)
			RecalculateListPosition()
		end

		local function RecalculateCanvasSize()
			DropdownScrollFrame.CanvasSize = UDim2.fromOffset(0, DropdownListLayout.AbsoluteContentSize.Y)
		end

		RecalculateListPosition()
		RecalculateListSize()

		Creator.AddSignal(DropdownListLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
			RecalculateCanvasSize()
			RecalculateListSize()
		end)

		Creator.AddSignal(DropdownInner:GetPropertyChangedSignal("AbsolutePosition"), RecalculateListPosition)

		Creator.AddSignal(DropdownInner.MouseButton1Click, function()
			Dropdown:Open()
		end)

		Creator.AddSignal(UserInputService.InputBegan, function(Input)
			if
				Input.UserInputType == Enum.UserInputType.MouseButton1
				or Input.UserInputType == Enum.UserInputType.Touch
			then
				local AbsPos, AbsSize = DropdownHolderFrame.AbsolutePosition, DropdownHolderFrame.AbsoluteSize
				if
					Mouse.X < AbsPos.X
					or Mouse.X > AbsPos.X + AbsSize.X
					or Mouse.Y < (AbsPos.Y - 20 - 1)
					or Mouse.Y > AbsPos.Y + AbsSize.Y
				then
					Dropdown:Close()
				end
			end
		end)

		function Dropdown:FilterOptions(Query)
			Query = (Query or ""):lower()
			for _, Option in next, DropdownScrollFrame:GetChildren() do
				if Option:IsA("TextButton") then
					local Label = Option:FindFirstChild("ButtonLabel")
					Option.Visible = Label == nil
						or Query == ""
						or string.find(Label.Text:lower(), Query, 1, true) ~= nil
				end
			end
			RecalculateCanvasSize()
			RecalculateListSize()
		end

		local ScrollFrame = self.ScrollFrame
		function Dropdown:Open()
			Dropdown.Opened = true
			ScrollFrame.ScrollingEnabled = false
			DropdownHolderCanvas.Visible = true
			SetIcoRotation(180)
			if DropdownSearchBox then
				DropdownSearchBox.Text = ""
				Dropdown:FilterOptions("")
			end
			TweenService:Create(
				DropdownHolderFrame,
				TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
				{ Size = UDim2.fromScale(1, 1) }
			):Play()
		end

		function Dropdown:Close()
			Dropdown.Opened = false
			ScrollFrame.ScrollingEnabled = true
			DropdownHolderFrame.Size = UDim2.fromScale(1, 0.6)
			DropdownHolderCanvas.Visible = false
			SetIcoRotation(0)
		end

		if DropdownSearchBox then
			Creator.AddSignal(DropdownSearchBox:GetPropertyChangedSignal("Text"), function()
				Dropdown:FilterOptions(DropdownSearchBox.Text)
			end)
		end

		function Dropdown:Display()
			local Values = Dropdown.Values
			local Str = ""

			if Config.Multi then
				for Idx, Value in next, Values do
					if Dropdown.Value[Value] then
						Str = Str .. Value .. ", "
					end
				end
				Str = Str:sub(1, #Str - 2)
			else
				Str = Dropdown.Value or ""
			end

			DropdownDisplay.Text = (Str == "" and "--" or Str)
		end

		function Dropdown:GetActiveValues()
			if Config.Multi then
				local T = {}

				for Value, Bool in next, Dropdown.Value do
					table.insert(T, Value)
				end

				return T
			else
				return Dropdown.Value and 1 or 0
			end
		end

		function Dropdown:BuildDropdownList()
			local rawValues = Dropdown.Values
			local Buttons = {}

			for _, child in next, DropdownScrollFrame:GetChildren() do
				if not child:IsA("UIListLayout") then
					child:Destroy()
				end
			end

			local letters, numbers = {}, {}
			for _, v in ipairs(rawValues) do
				local first = tostring(v):sub(1, 1)
				if first:match("%d") then
					table.insert(numbers, v)
				else
					table.insert(letters, v)
				end
			end
			table.sort(letters, function(a, b)
				return tostring(a):lower() < tostring(b):lower()
			end)
			table.sort(numbers, function(a, b)
				return tonumber(tostring(a):match("^%d+")) < tonumber(tostring(b):match("^%d+"))
			end)
			local Values = {}
			for _, v in ipairs(letters) do table.insert(Values, v) end
			for _, v in ipairs(numbers) do table.insert(Values, v) end

			local Count = 0

			local CheckIconData
			if Library.NewVisual then
				local Ok, Icon = pcall(function()
					return Library:GetIcon("check")
				end)
				if Ok and type(Icon) == "table" and Icon.Image then
					CheckIconData = Icon
				end
			end

			for Idx, Value in next, Values do
				local Table = {}

				Count = Count + 1

				local NewVisual = Library.NewVisual == true
				local TextOffset = 10
				local CheckTextOffset = 32

				local ButtonSelector
				local SelectorProp
				if NewVisual then
					if CheckIconData then
						ButtonSelector = New("ImageLabel", {
							Name = "ButtonCheck",
							Image = CheckIconData.Image,
							ImageRectOffset = CheckIconData.ImageRectOffset or Vector2.zero,
							ImageRectSize = CheckIconData.ImageRectSize or Vector2.zero,
							Size = UDim2.fromOffset(14, 14),
							Position = UDim2.new(0, 10, 0.5, 0),
							AnchorPoint = Vector2.new(0, 0.5),
							BackgroundTransparency = 1,
							ImageTransparency = 1,
							ZIndex = DROPDOWN_Z_INDEX + 4,
							ThemeTag = {
								ImageColor3 = "Accent",
							},
						})
						SelectorProp = "ImageTransparency"
					else
						ButtonSelector = New("TextLabel", {
							Name = "ButtonCheck",
							Text = "v",
							TextSize = 13,
							FontFace = Font.new(Library.Font, Enum.FontWeight.Bold, Enum.FontStyle.Normal),
							Size = UDim2.fromOffset(14, 14),
							Position = UDim2.new(0, 10, 0.5, 0),
							AnchorPoint = Vector2.new(0, 0.5),
							BackgroundTransparency = 1,
							TextTransparency = 1,
							ZIndex = DROPDOWN_Z_INDEX + 4,
							ThemeTag = {
								TextColor3 = "Accent",
							},
						})
						SelectorProp = "TextTransparency"
					end
				else
					ButtonSelector = New("Frame", {
						Size = UDim2.fromOffset(4, 6),
						BackgroundColor3 = Color3.fromRGB(76, 194, 255),
						BackgroundTransparency = 1,
						Position = UDim2.new(0, -1, 0.5, 0),
						AnchorPoint = Vector2.new(0, 0.5),
						ZIndex = DROPDOWN_Z_INDEX + 4,
						ThemeTag = {
							BackgroundColor3 = "Accent",
						},
					}, {
						New("UICorner", {
							CornerRadius = UDim.new(0, 2),
						}),
					})
					SelectorProp = "BackgroundTransparency"
				end

				local ButtonLabel = New("TextLabel", {
					FontFace = Font.new(Library.Font),
					Text = Value,
					TextColor3 = Color3.fromRGB(200, 200, 200),
					TextSize = 13,
					TextXAlignment = Enum.TextXAlignment.Left,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundTransparency = 1,
					Size = UDim2.new(1, -TextOffset, 1, 0),
					Position = UDim2.fromOffset(TextOffset, 0),
					ZIndex = DROPDOWN_Z_INDEX + 4,
					Name = "ButtonLabel",
					ThemeTag = {
						TextColor3 = "Text",
					},
				})

				local Button = New("TextButton", {
					Size = UDim2.new(1, -5, 0, 32),
					BackgroundTransparency = 1,
					ZIndex = DROPDOWN_Z_INDEX + 3,
					Text = "",
					Parent = DropdownScrollFrame,
					ThemeTag = {
						BackgroundColor3 = "DropdownOption",
					},
				}, {
					ButtonSelector,
					ButtonLabel,
					New("UICorner", {
						CornerRadius = UDim.new(0, 6),
					}),
				})

				local Selected

				if Config.Multi then
					Selected = Dropdown.Value[Value]
				else
					Selected = Dropdown.Value == Value
				end

				local BackMotor, SetBackTransparency = Creator.SpringMotor(1, Button, "BackgroundTransparency", true)
				local SelMotor, SetSelTransparency = Creator.SpringMotor(1, ButtonSelector, SelectorProp, true, not NewVisual)
				local SelectorSizeMotor = Flipper.SingleMotor.new(6)
				local LabelMotor = Flipper.SingleMotor.new(TextOffset)

				SelectorSizeMotor:onStep(function(value)
					if not NewVisual then
						ButtonSelector.Size = UDim2.new(0, 4, 0, value)
					end
				end)

				LabelMotor:onStep(function(value)
					ButtonLabel.Position = UDim2.fromOffset(value, 0)
					ButtonLabel.Size = UDim2.new(1, -value, 1, 0)
				end)

				Creator.AddSignal(Button.MouseEnter, function()
					SetBackTransparency(Selected and 0.85 or 0.89)
				end)
				Creator.AddSignal(Button.MouseLeave, function()
					SetBackTransparency(Selected and 0.89 or 1)
				end)
				Creator.AddSignal(Button.MouseButton1Down, function()
					SetBackTransparency(0.92)
				end)
				Creator.AddSignal(Button.MouseButton1Up, function()
					SetBackTransparency(Selected and 0.85 or 0.89)
				end)

				function Table:UpdateButton()
					if Config.Multi then
						Selected = Dropdown.Value[Value]
						if Selected then
							SetBackTransparency(0.89)
						end
					else
						Selected = Dropdown.Value == Value
						SetBackTransparency(Selected and 0.89 or 1)
					end

					if NewVisual then
						LabelMotor:setGoal(Flipper.Spring.new(Selected and CheckTextOffset or TextOffset, { frequency = 6 }))
					else
						SelectorSizeMotor:setGoal(Flipper.Spring.new(Selected and 14 or 6, { frequency = 6 }))
					end
					SetSelTransparency(Selected and 0 or 1)
				end

				Creator.AddSignal(Button.Activated, function()
					local Try = not Selected

					if Dropdown:GetActiveValues() == 1 and not Try and not Config.AllowNull then
					else
						if Config.Multi then
							Selected = Try
							Dropdown.Value[Value] = Selected and true or nil
						else
							Selected = Try
							Dropdown.Value = Selected and Value or nil

							for _, OtherButton in next, Buttons do
								OtherButton:UpdateButton()
							end
						end

						Table:UpdateButton()
						Dropdown:Display()

						Library:SafeCallback(Dropdown.Callback, Dropdown.Value)
						Library:SafeCallback(Dropdown.Changed, Dropdown.Value)
					end
				end)

				Table:UpdateButton()
				Dropdown:Display()

				Buttons[Button] = Table
			end

			ListSizeX = 0
			for Button, Table in next, Buttons do
				if Button.ButtonLabel then
					if Button.ButtonLabel.TextBounds.X > ListSizeX then
						ListSizeX = Button.ButtonLabel.TextBounds.X
					end
				end
			end
			ListSizeX = ListSizeX + (Library.NewVisual and 52 or 30)

			RecalculateCanvasSize()
			RecalculateListSize()

			if DropdownSearchBox then
				Dropdown:FilterOptions(DropdownSearchBox.Text)
			end
		end

		function Dropdown:SetValues(NewValues)
			if NewValues then
				Dropdown.Values = NewValues
			end

			Dropdown:BuildDropdownList()
		end

		function Dropdown:OnChanged(Func)
			Dropdown.Changed = Func
			Func(Dropdown.Value)
		end

		function Dropdown:SetValue(Val)
			if Dropdown.Multi then
				local nTable = {}

				for Value, Bool in next, Val do
					if table.find(Dropdown.Values, Value) then
						nTable[Value] = true
					end
				end

				Dropdown.Value = nTable
			else
				if not Val then
					Dropdown.Value = nil
				elseif table.find(Dropdown.Values, Val) then
					Dropdown.Value = Val
				end
			end

			Dropdown:BuildDropdownList()

			Library:SafeCallback(Dropdown.Callback, Dropdown.Value)
			Library:SafeCallback(Dropdown.Changed, Dropdown.Value)
		end

		function Dropdown:Destroy()
			DropdownFrame:Destroy()
			Library.Options[Idx] = nil
		end

		Dropdown:BuildDropdownList()
		Dropdown:Display()

		local Defaults = {}

		if type(Config.Default) == "string" then
			local Idx = table.find(Dropdown.Values, Config.Default)
			if Idx then
				table.insert(Defaults, Idx)
			end
		elseif type(Config.Default) == "table" then
			for _, Value in next, Config.Default do
				local Idx = table.find(Dropdown.Values, Value)
				if Idx then
					table.insert(Defaults, Idx)
				end
			end
		elseif type(Config.Default) == "number" and Dropdown.Values[Config.Default] ~= nil then
			table.insert(Defaults, Config.Default)
		end

		if next(Defaults) then
			for i = 1, #Defaults do
				local Index = Defaults[i]
				if Config.Multi then
					Dropdown.Value[Dropdown.Values[Index]] = true
				else
					Dropdown.Value = Dropdown.Values[Index]
				end

				if not Config.Multi then
					break
				end
			end

			Dropdown:BuildDropdownList()
			Dropdown:Display()
		end

		Library.Options[Idx] = Dropdown
		return Dropdown
	end

	return Element
end)()

