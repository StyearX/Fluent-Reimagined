local Creator = {
	Registry = {},
	FontRegistry = {},
	FontChangedCallbacks = {},
	Signals = {},
	TransparencyMotors = {},
	DropdownTransparencyFrames = {},
	ThemeChangedCallbacks = {},
	DefaultProperties = {
		ScreenGui = {
			ResetOnSpawn = false,
			ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		},
		Frame = {
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderColor3 = Color3.new(0, 0, 0),
			BorderSizePixel = 0,
		},
		ScrollingFrame = {
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderColor3 = Color3.new(0, 0, 0),
			ScrollBarImageColor3 = Color3.new(0, 0, 0),
		},
		TextLabel = {
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderColor3 = Color3.new(0, 0, 0),
			Font = Enum.Font.SourceSans,
			Text = "",
			TextColor3 = Color3.new(0, 0, 0),
			BackgroundTransparency = 1,
			TextSize = 14,
		},
		TextButton = {
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderColor3 = Color3.new(0, 0, 0),
			AutoButtonColor = false,
			Font = Enum.Font.SourceSans,
			Text = "",
			TextColor3 = Color3.new(0, 0, 0),
			TextSize = 14,
		},
		TextBox = {
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderColor3 = Color3.new(0, 0, 0),
			ClearTextOnFocus = false,
			Font = Enum.Font.SourceSans,
			Text = "",
			TextColor3 = Color3.new(0, 0, 0),
			TextSize = 14,
		},
		ImageLabel = {
			BackgroundTransparency = 1,
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderColor3 = Color3.new(0, 0, 0),
			BorderSizePixel = 0,
		},
		ImageButton = {
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderColor3 = Color3.new(0, 0, 0),
			AutoButtonColor = false,
		},
		CanvasGroup = {
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderColor3 = Color3.new(0, 0, 0),
			BorderSizePixel = 0,
		},
	},
}

local function ApplyCustomProps(Object, Props)
	if Props.ThemeTag then
		Creator.AddThemeObject(Object, Props.ThemeTag)
	end
end

function Creator.AddSignal(Signal, Function)
	table.insert(Creator.Signals, Signal:Connect(Function))
end

function Creator.Disconnect()
	for Idx = #Creator.Signals, 1, -1 do
		local Connection = table.remove(Creator.Signals, Idx)
		Connection:Disconnect()
	end
end

function Creator.GetThemeProperty(Property)
	if Library.CustomThemeData and Library.CustomThemeData[Property] ~= nil then
		return Library.CustomThemeData[Property]
	end
	if Themes[Library.Theme] and Themes[Library.Theme][Property] ~= nil then
		return Themes[Library.Theme][Property]
	end
	return Themes["Dark"][Property]
end

function Creator.GetKnobColor()
	local Color = Creator.GetThemeProperty("ToggleToggled")
	return Color3.new(1 - Color.R, 1 - Color.G, 1 - Color.B)
end

function Creator.UpdateTheme()
	for Instance, Object in next, Creator.Registry do
		for Property, ColorIdx in next, Object.Properties do
			Instance[Property] = Creator.GetThemeProperty(ColorIdx)
		end
	end

	for _, Motor in next, Creator.TransparencyMotors do
		Motor:setGoal(Flipper.Instant.new(Creator.GetThemeProperty("ElementTransparency")))
	end

	for _, Callback in next, Creator.ThemeChangedCallbacks do
		Callback()
	end
end

function Creator.OnThemeChanged(Callback)
	table.insert(Creator.ThemeChangedCallbacks, Callback)
	return Callback
end

function Creator.AddThemeObject(Object, Properties)
	Creator.RegistryCount = (Creator.RegistryCount or 0) + 1

	local Data = {
		Object = Object,
		Properties = Properties,
		Idx = Creator.RegistryCount,
	}

	Creator.Registry[Object] = Data

	for Property, ColorIdx in next, Properties do
		Object[Property] = Creator.GetThemeProperty(ColorIdx)
	end

	return Object
end

function Creator.OverrideTag(Object, Properties)
	Creator.Registry[Object].Properties = Properties
	Creator.UpdateTheme()
end

function Creator.RegisterFontObject(object, weight, style)
	table.insert(Creator.FontRegistry, {
		object = object,
		weight = weight or Enum.FontWeight.Regular,
		style = style  or Enum.FontStyle.Normal,
	})
end

function Creator.UpdateFont()
	for _, entry in ipairs(Creator.FontRegistry) do
		pcall(function()
			entry.object.FontFace = Font.new(Library.Font, entry.weight, entry.style)
		end)
	end
	for _, Callback in next, Creator.FontChangedCallbacks do
		Callback(Library.Font)
	end
end

local fontTextTypes = { TextLabel = true, TextButton = true, TextBox = true }

function Creator.New(Name, Properties, Children)
	local Object = Instance.new(Name)

	for Name, Value in next, Creator.DefaultProperties[Name] or {} do
		Object[Name] = Value
	end

	local fontWeight = Enum.FontWeight.Regular
	local fontStyle = Enum.FontStyle.Normal

	for Name, Value in next, Properties or {} do
		if Name ~= "ThemeTag" and Name ~= "IgnoreFontUpdate" then
			Object[Name] = Value
		end
		if Name == "FontFace" and typeof(Value) == "Font" then
			fontWeight = Value.Weight
			fontStyle = Value.Style
		end
	end

	if fontTextTypes[Name] and not (Properties and Properties.IgnoreFontUpdate) then
		Creator.RegisterFontObject(Object, fontWeight, fontStyle)
	end

	for _, Child in next, Children or {} do
		Child.Parent = Object
	end

	ApplyCustomProps(Object, Properties)
	return Object
end

function Creator.RegisterDropdownTransparency(Instance)
	table.insert(Creator.DropdownTransparencyFrames, Instance)
	Instance.BackgroundTransparency = Library.Transparency
end

function Creator.AttachTitleDesc(Target, TitleLabel, DescLabel)
	function Target:SetTitle(Set)
		Set = Set or ""
		TitleLabel.Text = Set
		TitleLabel.Visible = Set ~= ""
	end

	if DescLabel then
		function Target:SetDesc(Set)
			Set = Set or ""
			DescLabel.Text = Set
			DescLabel.Visible = Set ~= ""
		end
	end
end

Creator.Marquees = {}

local MarqueePause = 1.2
local MarqueeSpeed = 40

local function UpdateMarquees(Delta)
	for Index = #Creator.Marquees, 1, -1 do
		local Entry = Creator.Marquees[Index]
		if not Entry.Label.Parent then
			table.remove(Creator.Marquees, Index)
		elseif Entry.Label.Visible and Entry.Label.AbsoluteSize.X > 0 then
			local Overflow = Entry.Child.TextBounds.X - Entry.Label.AbsoluteSize.X
			local Offset = 0

			if Overflow > 1 then
				Entry.Time = Entry.Time + Delta
				local Duration = Overflow / MarqueeSpeed
				local Cycle = MarqueePause * 2 + Duration * 2
				local Time = Entry.Time % Cycle

				if Time < MarqueePause then
					Offset = 0
				elseif Time < MarqueePause + Duration then
					Offset = -Overflow * (Time - MarqueePause) / Duration
				elseif Time < MarqueePause * 2 + Duration then
					Offset = -Overflow
				else
					Offset = -Overflow * (1 - (Time - MarqueePause * 2 - Duration) / Duration)
				end
			else
				Entry.Time = 0
			end

			Offset = math.floor(Offset + 0.5)
			if Offset ~= Entry.Offset then
				Entry.Offset = Offset
				Entry.Child.Position = UDim2.fromOffset(Offset, 0)
			end
		end
	end
end

function Creator.Marquee(Label, ColorTag)
	if not Creator.MarqueeStarted then
		Creator.MarqueeStarted = true
		Creator.AddSignal(RunService.Heartbeat, UpdateMarquees)
	end

	Label.ClipsDescendants = true
	Label.TextTransparency = 1
	Label.TextWrapped = false

	local Child = Creator.New("TextLabel", {
		Name = "MarqueeText",
		Text = Label.Text,
		FontFace = Label.FontFace,
		TextSize = Label.TextSize,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
		Size = UDim2.new(0, 0, 1, 0),
		AutomaticSize = Enum.AutomaticSize.X,
		BackgroundTransparency = 1,
		Parent = Label,
		ThemeTag = {
			TextColor3 = ColorTag,
		},
	})

	Creator.AddSignal(Label:GetPropertyChangedSignal("Text"), function()
		Child.Text = Label.Text
	end)

	table.insert(Creator.Marquees, { Label = Label, Child = Child, Time = 0, Offset = 0 })
end

function Creator.Adaptive(ElementFrame, Slot, Threshold, StartInline, Apply)
	local Inline = StartInline

	local function Place(Value)
		Inline = Value
		local LabelSize = Inline and UDim2.new(1, -Slot, 0, 14) or UDim2.new(1, 0, 0, 14)
		ElementFrame.TitleLabel.Size = LabelSize
		ElementFrame.DescLabel.Size = LabelSize
		Apply(Inline)
	end

	local function Update()
		local Width = ElementFrame.Frame.AbsoluteSize.X
		if Width <= 0 then return end
		local Want
		if Inline then
			Want = Width >= Threshold - 20
		else
			Want = Width >= Threshold + 20
		end
		if Want ~= Inline then
			Place(Want)
		end
	end

	Place(Inline)
	if StartInline then return end
	Creator.AddSignal(ElementFrame.Frame:GetPropertyChangedSignal("AbsoluteSize"), Update)
	task.defer(Update)
end

function Creator.SpringMotor(Initial, Instance, Prop, IgnoreDialogCheck, ResetOnThemeChange)
	IgnoreDialogCheck = IgnoreDialogCheck or false
	ResetOnThemeChange = ResetOnThemeChange or false
	local Motor = Flipper.SingleMotor.new(Initial)
	Motor:onStep(function(value)
		Instance[Prop] = value
	end)

	if ResetOnThemeChange then
		table.insert(Creator.TransparencyMotors, Motor)
	end

	local function SetValue(Value, Ignore)
		Ignore = Ignore or false
		if not IgnoreDialogCheck then
			if not Ignore then
				if Prop == "BackgroundTransparency" and Library.DialogOpen then
					return
				end
			end
		end
		Motor:setGoal(Flipper.Spring.new(Value, { frequency = 8 }))
	end

	return Motor, SetValue
end

