ElementsTable.HStack = (function()
	local New = Creator.New

	local Element = {}
	Element.__index = Element
	Element.__type = "HStack"

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

		New("UIPadding", {
			PaddingTop = UDim.new(0, 2),
			PaddingBottom = UDim.new(0, 2),
			Parent = OuterWrap,
		})

		local InnerRow = New("Frame", {
			Size = UDim2.new(1, 0, 0, 0),
			BackgroundTransparency = 1,
			AutomaticSize = Enum.AutomaticSize.Y,
			BorderSizePixel = 0,
			ClipsDescendants = false,
			Parent = OuterWrap,
		})

		New("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			HorizontalAlignment = Enum.HorizontalAlignment.Left,
			VerticalAlignment = Enum.VerticalAlignment.Top,
			Padding = UDim.new(0, Gap),
			SortOrder = Enum.SortOrder.LayoutOrder,
			Parent = InnerRow,
		})

		local Columns = {}

		local function RecalcColumns()
			local Count = #Columns
			if Count == 0 then
				return
			end
			local Slots = math.max(Count, 2)
			local TotalGap = Gap * (Slots - 1)
			local ColumnScale = 1 / Slots
			local ColumnOffset = -math.floor(TotalGap / Slots + 0.5)

			for _, Column in ipairs(Columns) do
				Column.Size = UDim2.new(ColumnScale, ColumnOffset, 0, 0)
			end
		end

		local HStack = {
			Frame = OuterWrap,
			Container = OuterWrap,
			Type = "HStack",
			ScrollFrame = self.ScrollFrame,
			Library = self.Library,
			_elementCount = 0,
		}

		function HStack:AddVStack(Config2)
			Config2 = Config2 or {}
			local ColumnGap = Config2.Gap or Gap

			local ColumnFrame = New("Frame", {
				Size = UDim2.new(0.5, 0, 0, 0),
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				ClipsDescendants = false,
				Parent = InnerRow,
			})

			New("UIListLayout", {
				FillDirection = Enum.FillDirection.Vertical,
				HorizontalAlignment = Enum.HorizontalAlignment.Left,
				VerticalAlignment = Enum.VerticalAlignment.Top,
				Padding = UDim.new(0, ColumnGap),
				SortOrder = Enum.SortOrder.LayoutOrder,
				Parent = ColumnFrame,
			})

			table.insert(Columns, ColumnFrame)
			RecalcColumns()

			local ColumnGroup = setmetatable({
				Frame = ColumnFrame,
				Container = ColumnFrame,
				Type = "VStack",
				ScrollFrame = HStack.ScrollFrame,
				Library = HStack.Library,
				_elementCount = 0,
			}, Elements)

			return ColumnGroup
		end
		HStack.AddVerticalGroup = HStack.AddVStack

		setmetatable(HStack, {
			__index = function(_, Key)
				local Generic = Elements[Key]
				if type(Generic) == "function" then
					return function(Caller, ...)
						local Column = Caller:AddVStack()
						return Generic(Column, ...)
					end
				end
				return Generic
			end,
		})

		return HStack
	end

	return Element
end)()

