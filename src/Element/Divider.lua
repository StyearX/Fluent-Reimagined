ElementsTable.Divider = (function()
	local New = Creator.New

	local Element = {}
	Element.__index = Element
	Element.__type = "Divider"

	function Element:New(Idx, Config)
		if type(Idx) == "table" and Config == nil then
			Config = Idx
		end
		if type(Config) ~= "table" then
			Config = {}
		end

		local Parent = self.Container
		if not Parent then
			return
		end

		local Library = self.Library
		local Text = Config.Text and tostring(Config.Text) or ""
		local Height = tonumber(Config.Height) or (Text ~= "" and 26 or 14)
		local Thickness = math.max(tonumber(Config.Thickness) or 1, 1)
		local LineTransparency = tonumber(Config.Transparency) or 0.82
		local Gap = tonumber(Config.Gap) or 10

		local Divider = { Type = "Divider" }

		local Wrap = New("Frame", {
			Name = "DividerElement",
			Size = UDim2.new(1, 0, 0, Height),
			BackgroundTransparency = 1,
			LayoutOrder = Config.LayoutOrder or 0,
			Parent = Parent,
		})

		local Left = New("Frame", {
			Name = "LineLeft",
			AnchorPoint = Vector2.new(0, 0.5),
			Position = UDim2.fromScale(0, 0.5),
			Size = UDim2.new(1, 0, 0, Thickness),
			BackgroundTransparency = LineTransparency,
			BorderSizePixel = 0,
			Parent = Wrap,
			ThemeTag = {
				BackgroundColor3 = "Text",
			},
		})

		local Right = New("Frame", {
			Name = "LineRight",
			AnchorPoint = Vector2.new(1, 0.5),
			Position = UDim2.fromScale(1, 0.5),
			Size = UDim2.new(0.5, 0, 0, Thickness),
			BackgroundTransparency = LineTransparency,
			BorderSizePixel = 0,
			Visible = false,
			Parent = Wrap,
			ThemeTag = {
				BackgroundColor3 = "Text",
			},
		})

		local Label = New("TextLabel", {
			Name = "DividerText",
			FontFace = Font.new(Library.Font, Enum.FontWeight.Medium, Enum.FontStyle.Normal),
			Text = Text,
			TextSize = 12,
			AutomaticSize = Enum.AutomaticSize.X,
			Size = UDim2.fromOffset(0, 14),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			BackgroundTransparency = 1,
			Visible = Text ~= "",
			Parent = Wrap,
			ThemeTag = {
				TextColor3 = "SubText",
			},
		})

		local function Update()
			if Label.Text == "" then
				Label.Visible = false
				Right.Visible = false
				Left.Size = UDim2.new(1, 0, 0, Thickness)
				return
			end

			Label.Visible = true
			Right.Visible = true
			local Half = Label.AbsoluteSize.X / 2 + Gap
			Left.Size = UDim2.new(0.5, -Half, 0, Thickness)
			Right.Size = UDim2.new(0.5, -Half, 0, Thickness)
		end

		Creator.AddSignal(Label:GetPropertyChangedSignal("AbsoluteSize"), Update)
		Update()
		task.defer(Update)

		Divider.Frame = Wrap
		Divider.Label = Label

		function Divider:SetText(NewText)
			Label.Text = NewText and tostring(NewText) or ""
			Update()
		end

		function Divider:SetVisible(State)
			Wrap.Visible = State and true or false
		end

		function Divider:Destroy()
			Wrap:Destroy()
		end

		return Divider
	end

	return Element
end)()

