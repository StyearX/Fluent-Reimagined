ElementsTable.VStack = (function()
	local New = Creator.New

	local Element = {}
	Element.__index = Element
	Element.__type = "VStack"

	function Element:New(Config)
		Config = Config or {}
		local Parent = self.Container
		if not Parent then
			return
		end

		local Gap = Config.Gap or 6

		local OuterWrap = New("Frame", {
			Size = UDim2.new(1, 0, 0, 0),
			BackgroundTransparency = 1,
			AutomaticSize = Enum.AutomaticSize.Y,
			BorderSizePixel = 0,
			ClipsDescendants = false,
			LayoutOrder = Config.LayoutOrder or 0,
			Parent = Parent,
		})

		New("UIListLayout", {
			FillDirection = Enum.FillDirection.Vertical,
			HorizontalAlignment = Enum.HorizontalAlignment.Left,
			VerticalAlignment = Enum.VerticalAlignment.Top,
			Padding = UDim.new(0, 4),
			SortOrder = Enum.SortOrder.LayoutOrder,
			Parent = OuterWrap,
		})

		local TitleLabel = New("TextLabel", {
			Name = "VStackTitle",
			FontFace = Font.new(Library.Font, Enum.FontWeight.Medium, Enum.FontStyle.Normal),
			Text = Config.Title or "",
			TextSize = 13,
			TextXAlignment = Enum.TextXAlignment.Left,
			Size = UDim2.new(1, 0, 0, 14),
			BackgroundTransparency = 1,
			Visible = Config.Title ~= nil and Config.Title ~= "",
			LayoutOrder = -2,
			Parent = OuterWrap,
			ThemeTag = {
				TextColor3 = "Text",
			},
		})

		local DescLabel = New("TextLabel", {
			Name = "VStackDesc",
			FontFace = Font.new(Library.Font),
			Text = Config.Description or "",
			TextSize = 12,
			TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Left,
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, 14),
			Visible = Config.Description ~= nil and Config.Description ~= "",
			LayoutOrder = -1,
			Parent = OuterWrap,
			ThemeTag = {
				TextColor3 = "SubText",
			},
		})

		local ContentHolder = New("Frame", {
			Name = "VStackContent",
			Size = UDim2.new(1, 0, 0, 0),
			BackgroundTransparency = 1,
			AutomaticSize = Enum.AutomaticSize.Y,
			BorderSizePixel = 0,
			ClipsDescendants = false,
			LayoutOrder = 0,
			Parent = OuterWrap,
		})

		New("UIListLayout", {
			FillDirection = Enum.FillDirection.Vertical,
			HorizontalAlignment = Enum.HorizontalAlignment.Left,
			VerticalAlignment = Enum.VerticalAlignment.Top,
			Padding = UDim.new(0, Gap),
			SortOrder = Enum.SortOrder.LayoutOrder,
			Parent = ContentHolder,
		})

		local VStack = setmetatable({
			Frame = OuterWrap,
			Container = ContentHolder,
			Type = "VStack",
			ScrollFrame = self.ScrollFrame,
			Library = self.Library,
			_elementCount = 0,
			TitleLabel = TitleLabel,
			DescLabel = DescLabel,
		}, Elements)

		Creator.AttachTitleDesc(VStack, TitleLabel, DescLabel)

		return VStack
	end

	return Element
end)()

