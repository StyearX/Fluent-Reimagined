ElementsTable.Space = (function()
	local New = Creator.New

	local Element = {}
	Element.__index = Element
	Element.__type = "Space"

	local function ParseHeight(Height)
		local Parsed = tonumber(Height)
		if Parsed and Parsed >= 0 then
			return Parsed
		end
		return 8
	end

	function Element:New(Config)
		Config = Config or {}
		local Parent = self.Container
		if not Parent then
			return
		end

		local Height = ParseHeight(Config.Height)

		local Wrap = New("Frame", {
			Name = "SpaceElement",
			Size = UDim2.new(1, 0, 0, Height),
			BackgroundTransparency = 1,
			LayoutOrder = Config.LayoutOrder or 0,
			Parent = Parent,
		})

		local Space = { Frame = Wrap, Type = "Space" }

		function Space:SetHeight(NewHeight)
			Height = ParseHeight(NewHeight)
			Wrap.Size = UDim2.new(1, 0, 0, Height)
		end

		function Space:Destroy()
			Wrap:Destroy()
		end

		return Space
	end

	return Element
end)()

