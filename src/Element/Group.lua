ElementsTable.Group = (function()
	local New = Creator.New

	local Element = {}
	Element.__index = Element
	Element.__type = "Group"

	function Element:New(Config)
		Config = Config or {}
		local Parent = self.Container
		if not Parent then
			return
		end

		local Gap = Config.Gap or 6
		local Columns = math.max(Config.Columns or 2, 1)

		local OuterWrap = New("Frame", {
			Size = UDim2.new(1, 0, 0, 0),
			BackgroundTransparency = 1,
			AutomaticSize = Enum.AutomaticSize.Y,
			BorderSizePixel = 0,
			LayoutOrder = Config.LayoutOrder or 0,
			Parent = Parent,
		})

		New("UIPadding", {
			PaddingTop = UDim.new(0, 2),
			PaddingBottom = UDim.new(0, 2),
			Parent = OuterWrap,
		})

		local InnerWrap = New("Frame", {
			Size = UDim2.new(1, 0, 0, 0),
			BackgroundTransparency = 1,
			AutomaticSize = Enum.AutomaticSize.Y,
			BorderSizePixel = 0,
			Parent = OuterWrap,
		})

		local TotalGap = Gap * (Columns - 1)
		local ColumnScale = 1 / Columns
		local ColumnOffset = -math.floor(TotalGap / Columns + 0.5)

		New("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			HorizontalAlignment = Enum.HorizontalAlignment.Left,
			VerticalAlignment = Enum.VerticalAlignment.Top,
			Padding = UDim.new(0, Gap),
			SortOrder = Enum.SortOrder.LayoutOrder,
			Parent = InnerWrap,
		})

		local Group = {
			Frame = OuterWrap,
			Container = OuterWrap,
			Type = "Group",
			ScrollFrame = self.ScrollFrame,
			Library = self.Library,
			Elements = {},
		}

		function Group:AddElement()
			local ElementFrame = New("Frame", {
				Size = UDim2.new(ColumnScale, ColumnOffset, 0, 0),
				BackgroundTransparency = 1,
				AutomaticSize = Enum.AutomaticSize.Y,
				BorderSizePixel = 0,
				Parent = InnerWrap,
			})

			New("UIListLayout", {
				Padding = UDim.new(0, 5),
				SortOrder = Enum.SortOrder.LayoutOrder,
				Parent = ElementFrame,
			})

			local ColumnGroup = setmetatable({
				Container = ElementFrame,
				Type = Group.Type,
				ScrollFrame = Group.ScrollFrame,
				Library = Group.Library,
			}, Elements)

			table.insert(Group.Elements, { Frame = ElementFrame, Group = ColumnGroup })
			return ColumnGroup
		end

		function Group:Destroy()
			OuterWrap:Destroy()
		end

		return Group
	end

	return Element
end)()

