local TweenService: TweenService = cloneref(game:GetService("TweenService"))
local UserInputService: UserInputService = cloneref(game:GetService("UserInputService"))

Components.Window = (function()

	local Spring = Flipper.Spring.new
	local Instant = Flipper.Instant.new
	local New = Creator.New

	return function(Config)

		local Window = {
			Minimized = false,
			Maximized = false,
			Size = Config.Size,
			CurrentPos = 0,
			TabWidth = 0,
			Position = UDim2.fromOffset(
				Camera.ViewportSize.X / 2 - Config.Size.X.Offset / 2,
				Camera.ViewportSize.Y / 2 - Config.Size.Y.Offset / 2
			),
		}

		local Dragging, DragInput, MousePos, StartPos = false
		local Resizing, ResizePos = false
		local MinimizeNotif = false

		Window.AcrylicPaint = Acrylic.AcrylicPaint()
		Window.TabWidth = Config.TabWidth

		local UserInfoConfig = Config.UserInfo
		if UserInfoConfig == true then
			UserInfoConfig = {}
		elseif not UserInfoConfig then
			UserInfoConfig = nil
		end

		local UserInfoHeight = 58
		local UserInfoSpacing = 8
		local UserInfoPosition = UserInfoConfig and (UserInfoConfig.Position or "Bottom") or nil

		local TabHolderTopOffset = Config.Search and 36 or 0
		if UserInfoConfig and UserInfoPosition == "Top" then
			TabHolderTopOffset = TabHolderTopOffset + UserInfoHeight + UserInfoSpacing
		end

		local TabHolderBottomOffset = 0
		if UserInfoConfig and UserInfoPosition ~= "Top" then
			TabHolderBottomOffset = UserInfoHeight + UserInfoSpacing
		end

		local Selector = New("Frame", {
			Size = UDim2.fromOffset(4, 0),
			BackgroundColor3 = Color3.fromRGB(76, 194, 255),
			Position = UDim2.fromOffset(0, 17 + TabHolderTopOffset),
			AnchorPoint = Vector2.new(0, 0.5),
			ThemeTag = {
				BackgroundColor3 = "Accent",
			},
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 2),
			}),
		})
		Window.Selector = Selector

		local ResizeStartFrame = New("Frame", {
			Size = UDim2.fromOffset(20, 20),
			BackgroundTransparency = 1,
			Position = UDim2.new(1, -20, 1, -20),
		})

		Window.TabHolder = New("ScrollingFrame", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			BottomImage = "rbxassetid://0",
			MidImage = "rbxassetid://0",
			TopImage = "rbxassetid://0",
			ScrollBarThickness = 0,
			BorderSizePixel = 0,
			CanvasSize = UDim2.fromScale(0, 0),
			ScrollingDirection = Enum.ScrollingDirection.Y,
		}, {
			New("UIListLayout", {
				Padding = UDim.new(0, 4),
				SortOrder = Enum.SortOrder.LayoutOrder,
			}),
		})

		local TabSearchBox, TabSearchHolder
		if Config.Search then
			local TabSearchIcon = New("ImageLabel", {
				Image = "rbxassetid://10734943674",
				Size = UDim2.fromOffset(14, 14),
				AnchorPoint = Vector2.new(0, 0.5),
				Position = UDim2.new(0, 8, 0.5, 0),
				BackgroundTransparency = 1,
				ThemeTag = {
					ImageColor3 = "SubText",
				},
			})

			TabSearchBox = New("TextBox", {
				FontFace = Font.new(Library.Font, Enum.FontWeight.Regular, Enum.FontStyle.Normal),
				PlaceholderText = "Search....",
				Text = "",
				ClearTextOnFocus = false,
				TextColor3 = Color3.fromRGB(240, 240, 240),
				TextSize = 13,
				TextXAlignment = Enum.TextXAlignment.Left,
				Size = UDim2.new(1, -32, 1, 0),
				Position = UDim2.new(0, 28, 0, 0),
				BackgroundTransparency = 1,
				ThemeTag = {
					TextColor3 = "Text",
					PlaceholderColor3 = "SubText",
				},
			})

			TabSearchHolder = New("Frame", {
				Size = UDim2.new(1, 0, 0, 30),
				Position = UDim2.fromOffset(0, 0),
				BackgroundTransparency = 0.9,
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
				TabSearchIcon,
				TabSearchBox,
			})

		end

		Window.TabHolder.Position = UDim2.fromOffset(0, TabHolderTopOffset)
		Window.TabHolder.Size = UDim2.new(1, 0, 1, -TabHolderTopOffset - TabHolderBottomOffset)

		local UserInfoFrame
		if UserInfoConfig then
			local UserInfoIcon = UserInfoConfig.Icon
				or ("rbxthumb://type=AvatarHeadShot&id=" .. LocalPlayer.UserId .. "&w=420&h=420")
			local UserInfoTitle = UserInfoConfig.Title or LocalPlayer.DisplayName
			local UserInfoSubtitle = UserInfoConfig.Subtitle

			local UserInfoIconSize = 38
			local UserInfoTitleHeight = 18
			local UserInfoSubtitleHeight = 14
			local UserInfoTextGap = 2
			local UserInfoCenterY = UserInfoHeight / 2

			local UserInfoTitleY
			local UserInfoSubtitleY

			if UserInfoSubtitle then
				local UserInfoBlockHeight = UserInfoTitleHeight + UserInfoTextGap + UserInfoSubtitleHeight
				local UserInfoBlockTop = UserInfoCenterY - UserInfoBlockHeight / 2
				UserInfoTitleY = UserInfoBlockTop
				UserInfoSubtitleY = UserInfoBlockTop + UserInfoTitleHeight + UserInfoTextGap
			else
				UserInfoTitleY = UserInfoCenterY - UserInfoTitleHeight / 2
			end

			local UserInfoIconImage = New("ImageLabel", {
				Name = "Icon",
				Size = UDim2.fromOffset(UserInfoIconSize, UserInfoIconSize),
				Position = UDim2.fromOffset(9, (UserInfoHeight - UserInfoIconSize) / 2),
				BackgroundTransparency = 1,
				Image = UserInfoIcon,
				ScaleType = Enum.ScaleType.Crop,
			}, {
				New("UICorner", { CornerRadius = UDim.new(1, 0) }),
			})

			local UserInfoTitleLabel = New("TextLabel", {
				Name = "Title",
				Text = UserInfoTitle,
				FontFace = Font.new(Library.Font, Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
				TextSize = 14,
				TextTruncate = Enum.TextTruncate.AtEnd,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextYAlignment = Enum.TextYAlignment.Center,
				Size = UDim2.new(1, -60, 0, UserInfoTitleHeight),
				Position = UDim2.fromOffset(9 + UserInfoIconSize + 9, UserInfoTitleY),
				BackgroundTransparency = 1,
				ThemeTag = {
					TextColor3 = "Text",
				},
			})

			local UserInfoChildren = { UserInfoIconImage, UserInfoTitleLabel }

			if UserInfoSubtitle then
				table.insert(UserInfoChildren, New("TextLabel", {
					Name = "Subtitle",
					Text = UserInfoSubtitle,
					FontFace = Font.new(Library.Font, Enum.FontWeight.Regular, Enum.FontStyle.Normal),
					TextSize = 12,
					TextTruncate = Enum.TextTruncate.AtEnd,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextYAlignment = Enum.TextYAlignment.Center,
					Size = UDim2.new(1, -60, 0, UserInfoSubtitleHeight),
					Position = UDim2.fromOffset(9 + UserInfoIconSize + 9, UserInfoSubtitleY),
					BackgroundTransparency = 1,
					ThemeTag = {
						TextColor3 = "SubText",
					},
				}))
			end

			UserInfoFrame = New("Frame", {
				Name = "UserInfo",
				Size = UDim2.new(1, 0, 0, UserInfoHeight),
				Position = UserInfoPosition == "Top"
					and UDim2.fromOffset(0, Config.Search and 36 or 0)
					or UDim2.new(0, 0, 1, -UserInfoHeight),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
			}, UserInfoChildren)
		end

		local TabFrameChildren = { Window.TabHolder, Selector }
		if TabSearchHolder then
			table.insert(TabFrameChildren, 1, TabSearchHolder)
		end
		if UserInfoFrame then
			table.insert(TabFrameChildren, UserInfoFrame)
		end

		Window.UserInfoFrame = UserInfoFrame

		Window.BackgroundImage = New("ImageLabel", {
			Name = "Background",
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			ScaleType = Enum.ScaleType.Crop,
			ImageTransparency = 0,
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 8),
			}),
		})

		local TabFrame = New("Frame", {
			Size = UDim2.new(0, Window.TabWidth, 1, -66),
			Position = UDim2.new(0, 12, 0, 54),
			BackgroundTransparency = 1,
			ClipsDescendants = true,
		}, TabFrameChildren)

		Window.TabDisplay = New("TextLabel", {
			RichText = true,
			Text = "",
			TextTransparency = 0,
			FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
			TextSize = 28,
			TextXAlignment = "Left",
			TextYAlignment = "Center",
			Size = UDim2.new(1, -16, 0, 28),
			Position = UDim2.fromOffset(Window.TabWidth + 26, 56),
			BackgroundTransparency = 1,
			ThemeTag = {
				TextColor3 = "Text",
			},
		})

		Window.ContainerHolder = New("Frame", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
		})

		Window.ContainerAnim = New("CanvasGroup", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
		})

		Window.ContainerCanvas = New("Frame", {
			Size = UDim2.new(1, -Window.TabWidth - 32, 1, -102),
			Position = UDim2.fromOffset(Window.TabWidth + 26, 90),
			BackgroundTransparency = 1,
		}, {
			Window.ContainerAnim,
			Window.ContainerHolder
		})

		Window.Boundary = New("Frame", {
			Name = "Boundary",
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1),
			ClipsDescendants = false,
			Parent = Config.Parent,
		})

		Window.Root = New("Frame", {
			BackgroundTransparency = 1,
			Size = Window.Size,
			Position = Window.Position,
			Parent = Window.Boundary,
		}, {
			Window.BackgroundImage,
			Window.AcrylicPaint.Frame,
			Window.TabDisplay,
			Window.ContainerCanvas,
			TabFrame,
			ResizeStartFrame,
		})

		Window.TitleBar = Components.TitleBar({
			Title = Config.Title,
			SubTitle = Config.SubTitle,
			Parent = Window.Root,
			Window = Window,
		})

		function Window:SetTitle(Set)
			Window.TitleBar:SetTitle(Set)
		end

		function Window:SetSubTitle(Set)
			Window.TitleBar:SetSubTitle(Set)
		end
		Window.SetDesc = Window.SetSubTitle

		Window.NavigatorSelectorMotor = Flipper.GroupMotor.new({ X = 0, Width = 0 })

		Window.NavigatorSelector = New("Frame", {
			Size = UDim2.fromOffset(0, 2),
			AnchorPoint = Vector2.new(0, 1),
			Position = UDim2.new(0, 0, 1, 0),
			BackgroundTransparency = 0,
			Visible = false,
			ThemeTag = {
				BackgroundColor3 = "Accent",
			},
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(1, 0),
			}),
		})

		Window.NavigatorSelectorMotor:onStep(function(Values)
			Window.NavigatorSelector.Position = UDim2.new(0, Values.X, 1, 0)
			Window.NavigatorSelector.Size = UDim2.fromOffset(Values.Width, 2)
		end)

		local NavigatorListLayout = New("UIListLayout", {
			Padding = UDim.new(0, 4),
			FillDirection = Enum.FillDirection.Horizontal,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			SortOrder = Enum.SortOrder.LayoutOrder,
		})

		Window.NavigatorHolder = New("ScrollingFrame", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ScrollBarThickness = 0,
			ScrollingDirection = Enum.ScrollingDirection.X,
			CanvasSize = UDim2.fromScale(0, 0),
			AutomaticCanvasSize = Enum.AutomaticSize.X,
		}, {
			NavigatorListLayout,
		})

		local function UpdateNavigatorAlignment()
			local Fits = NavigatorListLayout.AbsoluteContentSize.X <= Window.NavigatorHolder.AbsoluteSize.X
			NavigatorListLayout.HorizontalAlignment = Fits and Enum.HorizontalAlignment.Center or Enum.HorizontalAlignment.Left
		end

		Creator.AddSignal(NavigatorListLayout:GetPropertyChangedSignal("AbsoluteContentSize"), UpdateNavigatorAlignment)
		Creator.AddSignal(Window.NavigatorHolder:GetPropertyChangedSignal("AbsoluteSize"), UpdateNavigatorAlignment)

		Window.NavigatorFrame = New("Frame", {
			Size = UDim2.new(1, -280, 1, -10),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			BackgroundTransparency = 1,
			ClipsDescendants = true,
			Parent = Window.TitleBar.Frame,
		}, {
			Window.NavigatorHolder,
			Window.NavigatorSelector,
		})

		if Library.UseAcrylic then
			Window.AcrylicPaint.AddParent(Window.Root)
		end

		local SizeMotor = Flipper.GroupMotor.new({
			X = Window.Size.X.Offset,
			Y = Window.Size.Y.Offset,
		})

		local PosMotor = Flipper.GroupMotor.new({
			X = Window.Position.X.Offset,
			Y = Window.Position.Y.Offset,
		})

		Window.SelectorPosMotor = Flipper.SingleMotor.new(17)
		Window.SelectorSizeMotor = Flipper.SingleMotor.new(0)
		Window.ContainerBackMotor = Flipper.SingleMotor.new(0)
		Window.ContainerPosMotor = Flipper.SingleMotor.new(94)

		SizeMotor:onStep(function(values)
			Window.Root.Size = UDim2.new(0, values.X, 0, values.Y)
		end)

		PosMotor:onStep(function(values)
			Window.Root.Position = UDim2.new(0, values.X, 0, values.Y)
		end)

		local LastValue = 0
		local LastTime = 0
		Window.SelectorPosMotor:onStep(function(Value)
			Selector.Position = UDim2.new(0, 0, 0, Value + 17 + TabHolderTopOffset)
			local Now = tick()
			local DeltaTime = Now - LastTime

			if LastValue ~= nil then
				Window.SelectorSizeMotor:setGoal(Spring((math.abs(Value - LastValue) / (DeltaTime * 60)) + 16))
				LastValue = Value
			end
			LastTime = Now
		end)

		Window.SelectorSizeMotor:onStep(function(Value)
			Selector.Size = UDim2.new(0, 4, 0, Value)
		end)

		Window.ContainerBackMotor:onStep(function(Value)
			Window.ContainerAnim.GroupTransparency = Value
		end)

		Window.ContainerPosMotor:onStep(function(Value)
			Window.ContainerAnim.Position = UDim2.fromOffset(0, Value)
		end)

		local OldSizeX
		local OldSizeY
		local OldPosX
		local OldPosY
		local function getBoundaryBounds()
			local inset = Library.BoundaryInset or {}
			local margin = Library.BoundaryMargin or 0
			local left = (inset.Left or 0) + margin
			local top = (inset.Top or 0) + margin
			local right = (inset.Right or 0) + margin
			local bottom = (inset.Bottom or 0) + margin
			local size = Window.Boundary.AbsoluteSize
			local usableX = math.max(0, size.X - left - right)
			local usableY = math.max(0, size.Y - top - bottom)
			return left, top, usableX, usableY
		end

		local function clampToBoundary(targetPosition, windowSize)
			if not Library.KeepWindowInsideFrame then
				return targetPosition
			end
			local left, top, usableX, usableY = getBoundaryBounds()
			local maxX = math.max(left, left + usableX - windowSize.X)
			local maxY = math.max(top, top + usableY - windowSize.Y)
			return Vector2.new(math.clamp(targetPosition.X, left, maxX), math.clamp(targetPosition.Y, top, maxY))
		end

		local function fitToBoundary(Instant)
			local left, top, usableX, usableY = getBoundaryBounds()
			SizeMotor:setGoal({
				X = Flipper[Instant and "Instant" or "Spring"].new(usableX, { frequency = 6 }),
				Y = Flipper[Instant and "Instant" or "Spring"].new(usableY, { frequency = 6 }),
			})
			Window.Size = UDim2.fromOffset(usableX, usableY)
			PosMotor:setGoal({
				X = Flipper[Instant and "Instant" or "Spring"].new(left, { frequency = 6 }),
				Y = Flipper[Instant and "Instant" or "Spring"].new(top, { frequency = 6 }),
			})
			Window.Position = UDim2.fromOffset(left, top)
		end

		Window.RefreshBoundary = function()
			if Window.Maximized then
				fitToBoundary(true)
			end
		end

		Window.Maximize = function(Value, NoPos, Instant)
			if Window.Maximized == Value then
				return
			end

			Window.Maximized = Value
			local WindowAssets = Library.NewVisual and Components.AssetsNew or Components.Assets
			Window.TitleBar.MaxButton.Frame.Icon.Image = Value and WindowAssets.Restore or WindowAssets.Max

			if Value then
				OldSizeX = Window.Size.X.Offset
				OldSizeY = Window.Size.Y.Offset
				OldPosX = Window.Position.X.Offset
				OldPosY = Window.Position.Y.Offset
			end

			if Value then
				fitToBoundary(Instant)
				return
			end

			SizeMotor:setGoal({
				X = Flipper[Instant and "Instant" or "Spring"].new(OldSizeX, { frequency = 6 }),
				Y = Flipper[Instant and "Instant" or "Spring"].new(OldSizeY, { frequency = 6 }),
			})
			Window.Size = UDim2.fromOffset(OldSizeX, OldSizeY)

			if not NoPos then
				PosMotor:setGoal({
					X = Spring(OldPosX, { frequency = 6 }),
					Y = Spring(OldPosY, { frequency = 6 }),
				})
				Window.Position = UDim2.fromOffset(OldPosX, OldPosY)
			end
		end

		Creator.AddSignal(Window.Boundary:GetPropertyChangedSignal("AbsoluteSize"), function()
			Window.RefreshBoundary()
		end)

		Creator.AddSignal(Window.TitleBar.Frame.InputBegan, function(Input)
			if
				Input.UserInputType == Enum.UserInputType.MouseButton1
				or Input.UserInputType == Enum.UserInputType.Touch
			then
				Dragging = true
				MousePos = Input.Position
				StartPos = Window.Root.Position

				if Window.Maximized then
					local _, _, usableX, usableY = getBoundaryBounds()
					StartPos = UDim2.fromOffset(
						Mouse.X - (Mouse.X * ((OldSizeX - 100) / usableX)),
						Mouse.Y - (Mouse.Y * (OldSizeY / usableY))
					)
				end

				Input.Changed:Connect(function()
					if Input.UserInputState == Enum.UserInputState.End then
						Dragging = false
					end
				end)
			end
		end)

		Creator.AddSignal(Window.TitleBar.Frame.InputChanged, function(Input)
			if
				Input.UserInputType == Enum.UserInputType.MouseMovement
				or Input.UserInputType == Enum.UserInputType.Touch
			then
				DragInput = Input
			end
		end)

		Creator.AddSignal(ResizeStartFrame.InputBegan, function(Input)
			if
				Input.UserInputType == Enum.UserInputType.MouseButton1
				or Input.UserInputType == Enum.UserInputType.Touch
			then
				Resizing = true
				ResizePos = Input.Position
			end
		end)

		Creator.AddSignal(UserInputService.InputChanged, function(Input)
			if Input == DragInput and Dragging then
				local Delta = Input.Position - MousePos
				local targetPosition =
					clampToBoundary(Vector2.new(StartPos.X.Offset + Delta.X, StartPos.Y.Offset + Delta.Y), Window.Root.AbsoluteSize)
				Window.Position = UDim2.fromOffset(targetPosition.X, targetPosition.Y)
				PosMotor:setGoal({
					X = Instant(Window.Position.X.Offset),
					Y = Instant(Window.Position.Y.Offset),
				})

				if Window.Maximized then
					Window.Maximize(false, true, true)
				end
			end

			if
				(Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch)
				and Resizing
			then
				local Delta = Input.Position - ResizePos
				local StartSize = Window.Size

				local TargetSize = Vector3.new(StartSize.X.Offset, StartSize.Y.Offset, 0) + Vector3.new(1, 1, 0) * Delta
				local TargetSizeClamped =
					Vector2.new(math.clamp(TargetSize.X, 470, 2048), math.clamp(TargetSize.Y, 380, 2048))

				if Library.KeepWindowInsideFrame then
					local left, top, usableX, usableY = getBoundaryBounds()
					local windowPosition = Window.Root.AbsolutePosition
					local boundaryPosition = Window.Boundary.AbsolutePosition
					local relativeX = (windowPosition.X - boundaryPosition.X) - left
					local relativeY = (windowPosition.Y - boundaryPosition.Y) - top
					local availableX = math.max(470, usableX - relativeX)
					local availableY = math.max(380, usableY - relativeY)
					TargetSizeClamped = Vector2.new(math.min(TargetSizeClamped.X, availableX), math.min(TargetSizeClamped.Y, availableY))
				end

				SizeMotor:setGoal({
					X = Flipper.Instant.new(TargetSizeClamped.X),
					Y = Flipper.Instant.new(TargetSizeClamped.Y),
				})
			end
		end)

		Creator.AddSignal(UserInputService.InputEnded, function(Input)
			if Resizing then
				Resizing = false
				Window.Size = UDim2.fromOffset(SizeMotor:getValue().X, SizeMotor:getValue().Y)
			end
		end)

		Creator.AddSignal(Window.TabHolder.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
			Window.TabHolder.CanvasSize = UDim2.new(0, 0, 0, Window.TabHolder.UIListLayout.AbsoluteContentSize.Y)
		end)

		Creator.AddSignal(UserInputService.InputBegan, function(Input)
			if
				type(Library.MinimizeKeybind) == "table"
				and Library.MinimizeKeybind.Type == "Keybind"
				and not UserInputService:GetFocusedTextBox()
			then
				if Input.KeyCode.Name == Library.MinimizeKeybind.Value then
					Window:Minimize()
				end
			elseif Input.KeyCode == Library.MinimizeKey and not UserInputService:GetFocusedTextBox() then
				Window:Minimize()
			end
		end)

		function Window:Minimize()
			Window.Minimized = not Window.Minimized
			Window.Root.Visible = not Window.Minimized
			if not MinimizeNotif then
				MinimizeNotif = true
				local Key = Library.MinimizeKeybind and Library.MinimizeKeybind.Value or Library.MinimizeKey.Name
				Library:Notify({
					Title = "Interface",
					Content = "Press " .. Key .. " to toggle the interface.",
					Duration = 6
				})
			end
		end

		function Window:Destroy()
			if Library.UseAcrylic then
				Window.AcrylicPaint.Model:Destroy()
			end
			Window.Root:Destroy()
		end

		local DialogModule = Components.Dialog:Init(Window)
		function Window:Dialog(Config)
			local Dialog = DialogModule:Create()
			Dialog.Title.Text = Config.Title

			local Content = New("TextLabel", {
				FontFace = Font.new(Library.Font),
				Text = Config.Content,
				TextColor3 = Color3.fromRGB(240, 240, 240),
				TextSize = 14,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextYAlignment = Enum.TextYAlignment.Top,
				Size = UDim2.new(1, -40, 1, 0),
				Position = UDim2.fromOffset(20, 60),
				BackgroundTransparency = 1,
				Parent = Dialog.Root,
				ClipsDescendants = false,
				ThemeTag = {
					TextColor3 = "Text",
				},
			})

			New("UISizeConstraint", {
				MinSize = Vector2.new(300, 165),
				MaxSize = Vector2.new(620, math.huge),
				Parent = Dialog.Root,
			})

			Dialog.Root.Size = UDim2.fromOffset(Content.TextBounds.X + 40, 165)
			if Content.TextBounds.X + 40 > Window.Size.X.Offset - 120 then
				Dialog.Root.Size = UDim2.fromOffset(Window.Size.X.Offset - 120, 165)
				Content.TextWrapped = true
				Dialog.Root.Size = UDim2.fromOffset(Window.Size.X.Offset - 120, Content.TextBounds.Y + 150)
			end

			for _, Button in next, Config.Buttons do
				Dialog:Button(Button.Title, Button.Callback)
			end

			Dialog:Open()
		end

		local SidePanelModule = Components.SidePanel:Init(Window)
		function Window:SidePanel(Config)
			local Panel = SidePanelModule:Create(Config)
			Panel:Open()
			return Panel
		end
		Window.Menu = Window.SidePanel
		Window.SideMenu = Window.SidePanel

		local TabModule = Components.Tab:Init(Window)
		local TabHolderOrder = 0

		function Window:AddTab(TabConfig)
			TabHolderOrder = TabHolderOrder + 1
			local Tab = TabModule:New(TabConfig.Title, TabConfig.Icon, Window.TabHolder, false)
			Tab.Frame.LayoutOrder = TabHolderOrder
			return Tab
		end
		Window.Tab = Window.AddTab
		Window.Page = Window.AddTab
		Window.AddPage = Window.AddTab

		function Window:AddTabInHeader(TabConfig)
			return TabModule:New(TabConfig.Title, TabConfig.Icon, Window.NavigatorHolder, true)
		end
		Window.TabInHeader = Window.AddTabInHeader

		function Window:AddSection(SectionConfig)
			SectionConfig = SectionConfig or {}

			TabHolderOrder = TabHolderOrder + 1
			local Section = {
				Type = "TabSection",
				Title = SectionConfig.Title,
				Collapsible = SectionConfig.Collapsible or false,
				Opened = true,
				Tabs = {},
				_tabOrder = 0,
			}

			Section.Root = New("Frame", {
				Name = "SectionRoot",
				Size = UDim2.new(1, 0, 0, 0),
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				LayoutOrder = TabHolderOrder,
				Parent = Window.TabHolder,
			}, {
				New("UIListLayout", {
					Padding = UDim.new(0, 4),
					SortOrder = Enum.SortOrder.LayoutOrder,
				}),
			})

			local SectionIcon = SectionConfig.Icon and Library:GetIcon(SectionConfig.Icon)
			local SectionTitleOffset = SectionIcon and 22 or 4

			local SectionTitleLabel = New("TextLabel", {
				Name = "SectionTitle",
				Text = Section.Title,
				RichText = true,
				FontFace = Font.new(Library.Font, Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
				TextSize = 12,
				TextXAlignment = "Left",
				TextYAlignment = "Center",
				Size = UDim2.new(1, (Section.Collapsible and -24 or -8) - (SectionTitleOffset - 4), 1, 0),
				Position = UDim2.fromOffset(SectionTitleOffset, 0),
				BackgroundTransparency = 1,
				ThemeTag = {
					TextColor3 = "SubText",
				},
			})

			Section.Header = New("TextButton", {
				Name = "SectionHeader",
				Size = UDim2.new(1, 0, 0, 26),
				BackgroundTransparency = 1,
				AutoButtonColor = false,
				Text = "",
				LayoutOrder = 1,
				Parent = Section.Root,
			}, {
				SectionTitleLabel,
			})

			if SectionIcon then
				New("ImageLabel", {
					Name = "SectionIcon",
					Image = SectionIcon.Image,
					ImageRectOffset = SectionIcon.ImageRectOffset,
					ImageRectSize = SectionIcon.ImageRectSize,
					Size = UDim2.fromOffset(14, 14),
					AnchorPoint = Vector2.new(0, 0.5),
					Position = UDim2.new(0, 4, 0.5, 0),
					BackgroundTransparency = 1,
					Parent = Section.Header,
					ThemeTag = {
						ImageColor3 = "SubText",
					},
				})
			end

			Creator.AttachTitleDesc(Section, SectionTitleLabel, nil)

			Section.Content = New("Frame", {
				Name = "SectionContent",
				Size = UDim2.new(1, 0, 0, 0),
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				LayoutOrder = 2,
				Parent = Section.Root,
			}, {
				New("UIListLayout", {
					Padding = UDim.new(0, 4),
					SortOrder = Enum.SortOrder.LayoutOrder,
				}),
			})

			local Chevron
			if Section.Collapsible then
				local ChevronIcon = Library:GetIcon("chevron-down")
				Chevron = New("ImageLabel", {
					Name = "SectionChevron",
					Image = ChevronIcon and ChevronIcon.Image or "",
					ImageRectOffset = ChevronIcon and ChevronIcon.ImageRectOffset or Vector2.zero,
					ImageRectSize = ChevronIcon and ChevronIcon.ImageRectSize or Vector2.zero,
					Size = UDim2.fromOffset(14, 14),
					AnchorPoint = Vector2.new(1, 0.5),
					Position = UDim2.new(1, -6, 0.5, 0),
					Rotation = 0,
					BackgroundTransparency = 1,
					Parent = Section.Header,
					ThemeTag = {
						ImageColor3 = "SubText",
					},
				})
			end

			local function SectionHasSelectedTab()
				local SelectedTab = TabModule.Tabs[TabModule.SelectedTab]
				if not SelectedTab then return false end
				for _, SectionTab in ipairs(Section.Tabs) do
					if SectionTab == SelectedTab then
						return true
					end
				end
				return false
			end

			function Section:Open()
				if not Section.Collapsible then return end
				Section.Opened = true
				Section.Content.Visible = true
				TweenService:Create(
					Chevron,
					TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
					{ Rotation = 0 }
				):Play()

				if SectionHasSelectedTab() then
					Window.Selector.Visible = true
					Window.SelectorPosMotor:setGoal(Instant(TabModule:GetCurrentTabPos()))
				end
			end

			function Section:Close()
				if not Section.Collapsible then return end
				Section.Opened = false
				Section.Content.Visible = false
				TweenService:Create(
					Chevron,
					TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
					{ Rotation = -90 }
				):Play()

				if SectionHasSelectedTab() then
					Window.Selector.Visible = false
				end
			end

			function Section:Toggle()
				if Section.Opened then
					Section:Close()
				else
					Section:Open()
				end
			end

			if Section.Collapsible then
				Creator.AddSignal(Section.Header.MouseButton1Click, function()
					Section:Toggle()
				end)
			end

			function Section:AddTab(TabConfig)
				Section._tabOrder = Section._tabOrder + 1
				local Tab = TabModule:New(TabConfig.Title, TabConfig.Icon, Section.Content, false)
				Tab.Frame.LayoutOrder = Section._tabOrder
				table.insert(Section.Tabs, Tab)
				return Tab
			end
			Section.Tab = Section.AddTab
			Section.Page = Section.AddTab
			Section.AddPage = Section.AddTab

			function Section:AddTabInHeader(TabConfig)
				warn("[Fluent Reimagined] TabInHeader cannot be added to a Section, tab moved to header instead.")
				return TabModule:New(TabConfig.Title, TabConfig.Icon, Window.NavigatorHolder, true)
			end
			Section.TabInHeader = Section.AddTabInHeader

			return Section
		end
		Window.Section = Window.AddSection

		function Window:SelectTab(Tab)
			TabModule:SelectTab(1)
		end

		Creator.AddSignal(Window.TabHolder:GetPropertyChangedSignal("CanvasPosition"), function()
			LastValue = TabModule:GetCurrentTabPos() + 16
			LastTime = 0
			Window.SelectorPosMotor:setGoal(Instant(TabModule:GetCurrentTabPos()))
		end)

		Creator.AddSignal(Window.NavigatorHolder:GetPropertyChangedSignal("CanvasPosition"), function()
			TabModule:UpdateNavigatorSelector(true)
		end)

		if TabSearchBox then
			Creator.AddSignal(TabSearchBox:GetPropertyChangedSignal("Text"), function()
				TabModule:ApplyFilter(TabSearchBox.Text)
			end)
		end

		return Window
	end
end)()

