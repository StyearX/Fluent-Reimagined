local TextService: TextService = cloneref(game:GetService("TextService"))

Components.Tab = (function()
	local New = Creator.New
	local Spring = Flipper.Spring.new
	local Instant = Flipper.Instant.new

	local function GetHeaderTextWidth(Text)
		return TextService:GetTextSize(
			Text,
			12,
			Enum.Font.GothamMedium,
			Vector2.new(math.huge, math.huge)
		).X
	end

	local function CreateHeaderChip(TabModule, TabIndex, Title, IconImage, IconRectOffset, IconRectSize)
		local Window = TabModule.Window
		local HasIcon = IconImage ~= nil
		local CollapsedWidth = HasIcon and 36 or 26
		local ExpandedWidth = CollapsedWidth + GetHeaderTextWidth(Title) + (HasIcon and 10 or 8)

		local Chip = {
			Selected = false,
			Hovering = false,
		}

		Chip.Frame = New("Frame", {
			Size = UDim2.fromOffset(CollapsedWidth, 28),
			BackgroundTransparency = 1,
			LayoutOrder = TabIndex,
			ClipsDescendants = true,
			Parent = Window.NavigatorHolder,
			ThemeTag = {
				BackgroundColor3 = "Tab",
			},
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 6),
			}),
		})

		if HasIcon then
			Chip.Icon = New("ImageLabel", {
				Size = UDim2.fromOffset(16, 16),
				Position = UDim2.new(0, 10, 0.5, 0),
				AnchorPoint = Vector2.new(0, 0.5),
				BackgroundTransparency = 1,
				Image = IconImage,
				ImageRectOffset = IconRectOffset,
				ImageRectSize = IconRectSize,
				Parent = Chip.Frame,
				ThemeTag = {
					ImageColor3 = "Text",
				},
			})
		else
			Chip.Icon = New("TextLabel", {
				Size = UDim2.fromOffset(16, 16),
				Position = UDim2.new(0, 5, 0.5, 0),
				AnchorPoint = Vector2.new(0, 0.5),
				BackgroundTransparency = 1,
				Text = string.upper(string.sub(Title, 1, 1)),
				RichText = true,
				FontFace = Font.new(Library.Font, Enum.FontWeight.Bold, Enum.FontStyle.Normal),
				TextSize = 13,
				TextXAlignment = "Center",
				TextYAlignment = "Center",
				Parent = Chip.Frame,
				ThemeTag = {
					TextColor3 = "Text",
				},
			})
		end

		local LabelOffset = HasIcon and 32 or 24

		Chip.Label = New("TextLabel", {
			Text = Title,
			RichText = true,
			TextTransparency = 1,
			FontFace = Font.new(Library.Font, Enum.FontWeight.Medium, Enum.FontStyle.Normal),
			TextSize = 12,
			TextXAlignment = "Left",
			TextYAlignment = "Center",
			BackgroundTransparency = 1,
			Size = UDim2.new(1, -(LabelOffset + 6), 1, 0),
			Position = UDim2.fromOffset(LabelOffset, 0),
			Parent = Chip.Frame,
			ThemeTag = {
				TextColor3 = "Text",
			},
		})

		Chip.HitBox = New("TextButton", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			Text = "",
			Parent = Chip.Frame,
		})

		local WidthMotor = Flipper.SingleMotor.new(CollapsedWidth)
		WidthMotor:onStep(function(Value)
			Chip.Frame.Size = UDim2.fromOffset(Value, 28)
		end)

		local BackgroundMotor, SetBackgroundTransparency = Creator.SpringMotor(1, Chip.Frame, "BackgroundTransparency")
		local LabelMotor, SetLabelTransparency = Creator.SpringMotor(1, Chip.Label, "TextTransparency")

		local SetInitialTransparency
		local LabelPosMotor
		if not HasIcon then
			local InitialMotor
			InitialMotor, SetInitialTransparency = Creator.SpringMotor(0, Chip.Icon, "TextTransparency")
			LabelPosMotor = Flipper.SingleMotor.new(LabelOffset)
			LabelPosMotor:onStep(function(Value)
				Chip.Label.Position = UDim2.fromOffset(Value, 0)
				Chip.Label.Size = UDim2.new(1, -(Value + 6), 1, 0)
			end)
		end

		local function SetExpanded(Expanded)
			WidthMotor:setGoal(Spring(Expanded and ExpandedWidth or CollapsedWidth, { frequency = 7 }))
			SetLabelTransparency(Expanded and 0 or 1)
			if SetInitialTransparency then
				SetInitialTransparency(Expanded and 1 or 0)
				LabelPosMotor:setGoal(Spring(Expanded and 8 or LabelOffset, { frequency = 7 }))
			end
		end

		Creator.AddSignal(Chip.HitBox.MouseEnter, function()
			Chip.Hovering = true
			if not Chip.Selected then
				SetBackgroundTransparency(0.94)
				SetExpanded(true)
			end
		end)

		Creator.AddSignal(Chip.HitBox.MouseLeave, function()
			Chip.Hovering = false
			if not Chip.Selected then
				SetBackgroundTransparency(1, true)
				SetExpanded(false)
			end
		end)

		Creator.AddSignal(Chip.HitBox.MouseButton1Click, function()
			TabModule:SelectTab(TabIndex)
		end)

		Creator.AddSignal(Chip.Frame:GetPropertyChangedSignal("AbsoluteSize"), function()
			if Chip.Selected then
				TabModule:UpdateNavigatorSelector(true)
			end
		end)

		Creator.AddSignal(Chip.Frame:GetPropertyChangedSignal("AbsolutePosition"), function()
			if Chip.Selected then
				TabModule:UpdateNavigatorSelector(true)
			end
		end)

		function Chip.SetTransparency(Value, Ignore)
			Chip.Selected = Value < 1
			SetBackgroundTransparency(Value, Ignore)
			if Chip.Selected then
				SetExpanded(true)
			elseif not Chip.Hovering then
				SetExpanded(false)
			end
		end

		function Chip.SetTitle(Set)
			Set = Set or ""
			Chip.Label.Text = Set
			if not HasIcon then
				Chip.Icon.Text = string.upper(string.sub(Set, 1, 1))
			end
			ExpandedWidth = CollapsedWidth + GetHeaderTextWidth(Set) + (HasIcon and 10 or 8)
			if Chip.Selected or Chip.Hovering then
				SetExpanded(true)
			end
		end

		return Chip
	end

	local TabModule = {
		Window = nil,
		Tabs = {},
		Containers = {},
		SelectedTab = 0,
		TabCount = 0,
		SearchQuery = "",
	}

	function TabModule:Init(Window)
		TabModule.Window = Window
		return TabModule
	end

	function TabModule:GetCurrentTabPos()
		local TabHolderPos = TabModule.Window.TabHolder.AbsolutePosition.Y
		local TabPos = TabModule.Tabs[TabModule.SelectedTab].Frame.AbsolutePosition.Y

		return TabPos - TabHolderPos
	end

	function TabModule:UpdateNavigatorSelector(UseInstant)
		local Window = TabModule.Window
		if not Window.NavigatorHolder then
			return
		end

		local Tab = TabModule.Tabs[TabModule.SelectedTab]
		if not (Tab and Tab.HeaderChip) then
			return
		end

		Window.NavigatorSelector.Visible = true

		local ChipFrame = Tab.HeaderChip.Frame
		local X = ChipFrame.AbsolutePosition.X - Window.NavigatorHolder.AbsolutePosition.X
		local Width = ChipFrame.AbsoluteSize.X

		local MotorType = UseInstant and Instant or Spring
		Window.NavigatorSelectorMotor:setGoal({
			X = MotorType(X, { frequency = 10 }),
			Width = MotorType(Width, { frequency = 10 }),
		})
	end

	function TabModule:ApplyFilter(Query)
		TabModule.SearchQuery = Query or ""
		local Container = TabModule.Containers[TabModule.SelectedTab]
		if not Container then return end

		local NormalizedQuery = TabModule.SearchQuery:lower()

		for _, Descendant in next, Container:GetDescendants() do
			if Descendant.Name == "ElementTitle" then
				local ElementFrame = Descendant.Parent and Descendant.Parent.Parent
				if ElementFrame then
					ElementFrame.Visible = NormalizedQuery == ""
						or string.find(Descendant.Text:lower(), NormalizedQuery, 1, true) ~= nil
				end
			end
		end

		for _, Descendant in next, Container:GetDescendants() do
			if Descendant.Name == "SectionRoot" then
				local Visible = NormalizedQuery == ""
				if not Visible then
					for _, Inner in next, Descendant:GetDescendants() do
						if Inner.Name == "ElementFrame" and Inner.Visible then
							Visible = true
							break
						end
					end
				end
				Descendant.Visible = Visible
			end
		end
	end

	function TabModule:New(Title, Icon, Parent, IsHeaderTab)
		local Window = TabModule.Window
		local Elements = Library.Elements

		TabModule.TabCount = TabModule.TabCount + 1
		local TabIndex = TabModule.TabCount

		local Tab = {
			Selected = false,
			Name = Title,
			Type = "Tab",
			IsHeaderTab = IsHeaderTab or false,
			_layoutOrder = 0,
		}

		if Icon == "" or Icon == nil then
			Icon = nil
		else
			Icon = Library:GetIcon(Icon)
		end

		local IconImage = Icon
		local IconRectOffset, IconRectSize
		if type(Icon) == "table" then
			IconImage = Icon.Image
			IconRectOffset = Icon.ImageRectOffset
			IconRectSize = Icon.ImageRectSize
		end

		if Tab.IsHeaderTab then
			Tab.HeaderChip = CreateHeaderChip(TabModule, TabIndex, Title, IconImage, IconRectOffset, IconRectSize)
			Tab.SetTransparency = Tab.HeaderChip.SetTransparency

			function Tab:SetTitle(Set)
				Set = Set or ""
				Tab.Name = Set
				Tab.HeaderChip.SetTitle(Set)
			end
		else
			Tab.TitleLabel = New("TextLabel", {
				AnchorPoint = Vector2.new(0, 0.5),
				Position = Icon and UDim2.new(0, 30, 0.5, 0) or UDim2.new(0, 12, 0.5, 0),
				Text = Title,
				RichText = true,
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextTransparency = 0,
				FontFace = Font.new(Library.Font, Enum.FontWeight.Regular, Enum.FontStyle.Normal),
				TextSize = 12,
				TextXAlignment = "Left",
				TextYAlignment = "Center",
				Size = UDim2.new(1, -12, 1, 0),
				BackgroundTransparency = 1,
				ThemeTag = {
					TextColor3 = "Text",
				},
			})

			Tab.Frame = New("TextButton", {
				Size = UDim2.new(1, 0, 0, 34),
				BackgroundTransparency = 1,
				Parent = Parent,
				LayoutOrder = TabIndex,
				ThemeTag = {
					BackgroundColor3 = "Tab",
				},
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(0, 6),
				}),
				Tab.TitleLabel,
				New("ImageLabel", {
					AnchorPoint = Vector2.new(0, 0.5),
					Size = UDim2.fromOffset(16, 16),
					Position = UDim2.new(0, 8, 0.5, 0),
					BackgroundTransparency = 1,
					Image = IconImage,
					ImageRectOffset = IconRectOffset,
					ImageRectSize = IconRectSize,
					ThemeTag = {
						ImageColor3 = "Text",
					},
				}),
			})

			Creator.AttachTitleDesc(Tab, Tab.TitleLabel, nil)
			local BaseSetTitle = Tab.SetTitle
			function Tab:SetTitle(Set)
				Tab.Name = Set or ""
				BaseSetTitle(Tab, Set)
			end

			Tab.Motor, Tab.SetTransparency = Creator.SpringMotor(1, Tab.Frame, "BackgroundTransparency")

			Creator.AddSignal(Tab.Frame.MouseEnter, function()
				Tab.SetTransparency(Tab.Selected and 0.85 or 0.89)
			end)
			Creator.AddSignal(Tab.Frame.MouseLeave, function()
				Tab.SetTransparency(Tab.Selected and 0.89 or 1)
			end)
			Creator.AddSignal(Tab.Frame.MouseButton1Down, function()
				Tab.SetTransparency(0.92)
			end)
			Creator.AddSignal(Tab.Frame.MouseButton1Up, function()
				Tab.SetTransparency(Tab.Selected and 0.85 or 0.89)
			end)
			Creator.AddSignal(Tab.Frame.MouseButton1Click, function()
				TabModule:SelectTab(TabIndex)
			end)
		end

		local ContainerLayout = New("UIListLayout", {
			Padding = UDim.new(0, 5),
			SortOrder = Enum.SortOrder.LayoutOrder,
		})

		Tab.ContainerFrame = New("ScrollingFrame", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			Parent = Window.ContainerHolder,
			Visible = false,
			BottomImage = "rbxassetid://6889812791",
			MidImage = "rbxassetid://6889812721",
			TopImage = "rbxassetid://6276641225",
			ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255),
			ScrollBarImageTransparency = 0.95,
			ScrollBarThickness = 3,
			BorderSizePixel = 0,
			CanvasSize = UDim2.fromScale(0, 0),
			ScrollingDirection = Enum.ScrollingDirection.Y,
		}, {
			ContainerLayout,
			New("UIPadding", {
				PaddingRight = UDim.new(0, 10),
				PaddingLeft = UDim.new(0, 1),
				PaddingTop = UDim.new(0, 1),
				PaddingBottom = UDim.new(0, 1),
			}),
		})

		Creator.AddSignal(ContainerLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
			Tab.ContainerFrame.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y + 2)
		end)

		TabModule.Containers[TabIndex] = Tab.ContainerFrame
		TabModule.Tabs[TabIndex] = Tab

		Tab.Container = Tab.ContainerFrame
		Tab.ScrollFrame = Tab.Container

		function Tab:AddSection(SectionTitle)
			local Section = { Type = "Section", _layoutOrder = 0 }

			Tab._layoutOrder = (Tab._layoutOrder or 0) + 1
			local SectionFrame = Components.Section(SectionTitle, Tab.Container)
			SectionFrame.Root.LayoutOrder = Tab._layoutOrder

			Section.Container = SectionFrame.Container
			Section.ScrollFrame = Tab.Container
			Creator.AttachTitleDesc(Section, SectionFrame.TitleLabel, nil)

			setmetatable(Section, Elements)
			return Section
		end
		Tab.Section = Tab.AddSection

		setmetatable(Tab, Elements)
		return Tab
	end

	function TabModule:SelectTab(Tab)
		local Window = TabModule.Window

		TabModule.SelectedTab = Tab

		for _, TabObject in next, TabModule.Tabs do
			TabObject.SetTransparency(1)
			TabObject.Selected = false
		end
		TabModule.Tabs[Tab].SetTransparency(0.89)
		TabModule.Tabs[Tab].Selected = true

		Window.TabDisplay.Text = TabModule.Tabs[Tab].Name

		if TabModule.Tabs[Tab].IsHeaderTab then
			Window.Selector.Visible = false
			TabModule:UpdateNavigatorSelector()
		else
			Window.NavigatorSelector.Visible = false
			Window.Selector.Visible = true
			Window.SelectorPosMotor:setGoal(Spring(TabModule:GetCurrentTabPos(), { frequency = 6 }))
		end

		task.spawn(function()
			Window.ContainerHolder.Parent = Window.ContainerAnim

			Window.ContainerPosMotor:setGoal(Spring(15, { frequency = 10 }))
			Window.ContainerBackMotor:setGoal(Spring(1, { frequency = 10 }))
			task.wait(0.12)
			for _, Container in next, TabModule.Containers do
				Container.Visible = false
			end
			TabModule.Containers[Tab].Visible = true
			TabModule:ApplyFilter(TabModule.SearchQuery)
			Window.ContainerPosMotor:setGoal(Spring(0, { frequency = 5 }))
			Window.ContainerBackMotor:setGoal(Spring(0, { frequency = 8 }))
			task.wait(0.12)
			Window.ContainerHolder.Parent = Window.ContainerCanvas
		end)
	end

	return TabModule
end)()

