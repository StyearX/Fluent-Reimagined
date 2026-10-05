local UserInputService: UserInputService = cloneref(game:GetService("UserInputService"))

ElementsTable.Viewport = (function()
	local New = Creator.New

	local Element = {}
	Element.__index = Element
	Element.__type = "Viewport"

	local function ParseAspectRatio(Ratio)
		if type(Ratio) == "number" then
			return Ratio
		end
		if type(Ratio) == "string" then
			local Width, Height = Ratio:match("(%d+):(%d+)")
			if Width and Height and tonumber(Height) ~= 0 then
				return tonumber(Width) / tonumber(Height)
			end
		end
		return nil
	end

	function Element:New(IdxOrConfig, MaybeConfig)
		local SaveIndex, Config
		if type(IdxOrConfig) == "string" then
			SaveIndex, Config = IdxOrConfig, MaybeConfig
		else
			Config = IdxOrConfig
		end
		Config = Config or {}

		local Parent = self.Container
		if not Parent then return end

		local Library = self.Library
		local ScrollFrame = self.ScrollFrame
		local IsGrouped = self.Type == "Group" or self.Type == "HStack" or self.Type == "VStack"
		local OffsetX = IsGrouped and 0 or -16
		local Radius = Config.Radius or 8

		local Viewport = {
			__type = "Viewport",
			Type = "Viewport",
			Object = nil,
			Camera = Config.Camera or Instance.new("Camera"),
			Interactive = Config.Interactive or false,
			Height = Config.Height or 200,
			Focused = Config.Focused ~= false,
			Ambient = Config.Ambient,
			LightColor = Config.LightColor,
			LightDirection = Config.LightDirection,
			Value = nil,
		}

		local IsDragging, IsPinching = false, false
		local LastMousePosition, LastPinchDistance = nil, 0
		local AspectRatio = ParseAspectRatio(Config.AspectRatio)

		local HolderFrame = New("Frame", {
			Name = "ViewportHolder",
			Size = UDim2.new(1, OffsetX, 0, Viewport.Height),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			LayoutOrder = Config.LayoutOrder or 0,
			Parent = Parent,
		}, {
			New("UICorner", { CornerRadius = UDim.new(0, Radius) }),
			New("UIStroke", {
				Transparency = 0.6,
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				ThemeTag = {
					Color = "InElementBorder",
				},
			}),
		})

		local function RecalculateAspect()
			if not AspectRatio or AspectRatio <= 0 then return end
			local Width = HolderFrame.AbsoluteSize.X
			if Width > 0 then
				HolderFrame.Size = UDim2.new(1, OffsetX, 0, math.floor(Width / AspectRatio))
			end
		end

		Creator.AddSignal(HolderFrame:GetPropertyChangedSignal("AbsoluteSize"), RecalculateAspect)
		if AspectRatio then
			task.defer(RecalculateAspect)
		end

		local Background = New("ImageLabel", {
			Name = "ViewportBackground",
			Size = UDim2.fromScale(1, 1),
			BackgroundColor3 = Config.BackgroundColor or Color3.fromRGB(15, 15, 20),
			BackgroundTransparency = Config.BackgroundTransparency or 0.1,
			BorderSizePixel = 0,
			Image = "",
			ImageTransparency = Config.ImageTransparency or 0,
			ScaleType = Config.ScaleType or Enum.ScaleType.Crop,
			Parent = HolderFrame,
		}, {
			New("UICorner", { CornerRadius = UDim.new(0, Radius) }),
		})

		if Config.Noise ~= false then
			New("ImageLabel", {
				Name = "ViewportNoise",
				Image = "rbxassetid://9968344227",
				ScaleType = Enum.ScaleType.Tile,
				TileSize = UDim2.fromOffset(128, 128),
				Size = UDim2.fromScale(1, 1),
				BackgroundTransparency = 1,
				ImageTransparency = 0.92,
				Parent = Background,
			}, {
				New("UICorner", { CornerRadius = UDim.new(0, Radius) }),
			})
		end

		local function ApplyImage(Image)
			if Image and Image ~= "" then
				Background.Image = Library:ResolveMedia(Image)
			else
				Background.Image = ""
			end
		end

		if Config.Image then
			task.spawn(ApplyImage, Config.Image)
		end

		local Canvas = New("CanvasGroup", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			Parent = HolderFrame,
		}, {
			New("UICorner", { CornerRadius = UDim.new(0, Radius) }),
		})

		local ViewportFrame = New("ViewportFrame", {
			Name = "Viewport",
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			CurrentCamera = Viewport.Camera,
			Active = Viewport.Interactive,
			Parent = Canvas,
		})

		if Viewport.Ambient then
			ViewportFrame.Ambient = Viewport.Ambient
		end
		if Viewport.LightColor then
			ViewportFrame.LightColor = Viewport.LightColor
		end
		if Viewport.LightDirection then
			ViewportFrame.LightDirection = Viewport.LightDirection
		end

		Viewport.Camera.Parent = ViewportFrame
		Viewport.Viewport = ViewportFrame

		local function GetPivot()
			if not Viewport.Object then return nil end
			local Success, Pivot = pcall(function()
				return Viewport.Object:GetPivot().Position
			end)
			return Success and Pivot or nil
		end

		local function UpdateZoomValue()
			local Pivot = GetPivot()
			if Pivot then
				Viewport.Value = (Viewport.Camera.CFrame.Position - Pivot).Magnitude
			end
		end

		local function Zoom(Amount)
			local Pivot = GetPivot()
			if not Pivot then return end
			local Camera = Viewport.Camera
			local Distance = (Camera.CFrame.Position - Pivot).Magnitude - Amount
			if Config.ZoomMin then
				Distance = math.max(Distance, Config.ZoomMin)
			end
			if Config.ZoomMax then
				Distance = math.min(Distance, Config.ZoomMax)
			end
			Distance = math.max(Distance, 0.1)
			Camera.CFrame = CFrame.lookAt(Pivot - Camera.CFrame.LookVector * Distance, Pivot)
			UpdateZoomValue()
		end

		local function IsPositionInViewport(Position)
			local FramePosition, FrameSize = ViewportFrame.AbsolutePosition, ViewportFrame.AbsoluteSize
			return Position.X >= FramePosition.X and Position.X <= FramePosition.X + FrameSize.X
				and Position.Y >= FramePosition.Y and Position.Y <= FramePosition.Y + FrameSize.Y
		end

		local function SetScrolling(Enabled)
			if ScrollFrame then
				ScrollFrame.ScrollingEnabled = Enabled
			end
		end

		Creator.AddSignal(ViewportFrame.MouseEnter, function()
			if Viewport.Interactive then
				SetScrolling(false)
			end
		end)

		Creator.AddSignal(ViewportFrame.InputEnded, function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
				SetScrolling(true)
			end
		end)

		Creator.AddSignal(ViewportFrame.InputBegan, function(Input)
			if not Viewport.Interactive then return end
			if Input.UserInputType == Enum.UserInputType.MouseButton1
				or (Input.UserInputType == Enum.UserInputType.Touch and not IsPinching) then
				IsDragging = true
				LastMousePosition = Input.Position
			end
		end)

		Creator.AddSignal(UserInputService.InputEnded, function(Input)
			if not Viewport.Interactive then return end
			if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
				IsDragging = false
			end
		end)

		Creator.AddSignal(UserInputService.InputChanged, function(Input)
			if not (Viewport.Interactive and IsDragging and not IsPinching) then return end
			if Input.UserInputType ~= Enum.UserInputType.MouseMovement and Input.UserInputType ~= Enum.UserInputType.Touch then return end
			local Pivot = GetPivot()
			if not Pivot then return end

			local Delta = Input.Position - LastMousePosition
			LastMousePosition = Input.Position

			local Camera = Viewport.Camera
			local Yaw = CFrame.fromAxisAngle(Vector3.new(0, 1, 0), -Delta.X * 0.02)
			Camera.CFrame = CFrame.new(Pivot) * Yaw * CFrame.new(-Pivot) * Camera.CFrame

			local Pitch = CFrame.fromAxisAngle(Camera.CFrame.RightVector, -Delta.Y * 0.02)
			local Pitched = CFrame.new(Pivot) * Pitch * CFrame.new(-Pivot) * Camera.CFrame
			if Pitched.UpVector.Y > 0.1 then
				Camera.CFrame = Pitched
			end
		end)

		Creator.AddSignal(ViewportFrame.InputChanged, function(Input)
			if Viewport.Interactive and Input.UserInputType == Enum.UserInputType.MouseWheel then
				Zoom(Input.Position.Z * 2)
			end
		end)

		Creator.AddSignal(UserInputService.TouchPinch, function(TouchPositions, _, _, State)
			if not Viewport.Interactive then return end
			if State == Enum.UserInputState.Begin then
				local Midpoint = (TouchPositions[1] + TouchPositions[2]) / 2
				if not IsPositionInViewport(Midpoint) then return end
				IsPinching = true
				IsDragging = false
				LastPinchDistance = (TouchPositions[1] - TouchPositions[2]).Magnitude
			elseif State == Enum.UserInputState.Change then
				if not IsPinching then return end
				local CurrentDistance = (TouchPositions[1] - TouchPositions[2]).Magnitude
				Zoom((CurrentDistance - LastPinchDistance) * 0.03)
				LastPinchDistance = CurrentDistance
			elseif State == Enum.UserInputState.End or State == Enum.UserInputState.Cancel then
				IsPinching = false
			end
		end)

		local function FocusCamera()
			local Object = Viewport.Object
			if not Object then return end

			local Size
			if Object:IsA("BasePart") then
				Size = Object.Size
			elseif Object:IsA("Model") then
				Size = select(2, Object:GetBoundingBox())
			else
				return
			end

			local Extent = math.max(Size.X, Size.Y, Size.Z)
			local Pivot = Object:GetPivot().Position
			Viewport.Camera.CFrame = CFrame.lookAt(Pivot + Vector3.new(0, Extent / 2, Extent * 2), Pivot)
			UpdateZoomValue()
		end

		function Viewport:SetObject(NewObject, Clone)
			if Clone and NewObject then
				local WasArchivable = NewObject.Archivable
				NewObject.Archivable = true
				local Copy = NewObject:Clone()
				NewObject.Archivable = WasArchivable
				NewObject = Copy
			end
			if Viewport.Object then
				Viewport.Object:Destroy()
			end
			Viewport.Object = NewObject
			if NewObject then
				NewObject.Parent = ViewportFrame
				if Viewport.Focused then
					FocusCamera()
				end
			end
		end

		function Viewport:SetModel(Model)
			Viewport:SetObject(Model, true)
		end

		function Viewport:SetHeight(NewHeight)
			Viewport.Height = NewHeight
			AspectRatio = nil
			HolderFrame.Size = UDim2.new(1, OffsetX, 0, NewHeight)
		end

		function Viewport:SetAspectRatio(Ratio)
			AspectRatio = ParseAspectRatio(Ratio)
			if AspectRatio then
				RecalculateAspect()
			else
				HolderFrame.Size = UDim2.new(1, OffsetX, 0, Viewport.Height)
			end
		end

		function Viewport:Focus()
			FocusCamera()
		end

		function Viewport:SetCamera(NewCamera)
			Viewport.Camera = NewCamera
			ViewportFrame.CurrentCamera = NewCamera
		end

		function Viewport:SetInteractive(Value)
			Viewport.Interactive = Value
			ViewportFrame.Active = Value
		end

		function Viewport:SetValue(Distance)
			if type(Distance) ~= "number" then return end
			local Pivot = GetPivot()
			if not Pivot then return end
			local Direction = Viewport.Camera.CFrame.Position - Pivot
			if Direction.Magnitude < 1e-4 then
				Direction = Vector3.new(0, 0, 1)
			end
			Viewport.Camera.CFrame = CFrame.lookAt(Pivot + Direction.Unit * Distance, Pivot)
			Viewport.Value = Distance
		end

		function Viewport:SetAmbient(Color)
			Viewport.Ambient = Color
			ViewportFrame.Ambient = Color
		end

		function Viewport:SetLightColor(Color)
			Viewport.LightColor = Color
			ViewportFrame.LightColor = Color
		end

		function Viewport:SetLightDirection(Direction)
			Viewport.LightDirection = Direction
			ViewportFrame.LightDirection = Direction
		end

		function Viewport:SetImage(Image)
			task.spawn(ApplyImage, Image)
		end

		function Viewport:SetImageTransparency(Value)
			Background.ImageTransparency = Value
		end

		function Viewport:SetBackgroundColor(Color)
			Background.BackgroundColor3 = Color
		end

		function Viewport:Destroy()
			HolderFrame:Destroy()
		end

		Viewport.Frame = HolderFrame

		if Config.Object then
			Viewport:SetObject(Config.Object, Config.Clone)
		end

		if SaveIndex and Library.Options then
			Library.Options[SaveIndex] = Viewport
		end

		return Viewport
	end

	return Element
end)()

