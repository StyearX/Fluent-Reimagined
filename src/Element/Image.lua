ElementsTable.Image = (function()
	local New = Creator.New

	local Element = {}
	Element.__index = Element
	Element.__type = "Image"

	local function ResolveImage(Source)
		if type(Source) ~= "string" or Source == "" then
			return ""
		end
		if Source:match("^rbxassetid://") or Source:match("^rbxasset://") then
			return Source
		end
		if Source:match("^%d+$") then
			return "rbxassetid://" .. Source
		end
		return Source
	end

	local function ParseAspectRatio(Ratio)
		if type(Ratio) == "number" then
			return Ratio
		end
		local Width, Height = tostring(Ratio):match("(%d+):(%d+)")
		if Width and Height and tonumber(Height) ~= 0 then
			return tonumber(Width) / tonumber(Height)
		end
		return 16 / 9
	end

	function Element:New(Config)
		Config = Config or {}
		local Parent = self.Container
		if not Parent then
			return
		end

		local Radius = Config.Radius or 8
		local AspectRatio = ParseAspectRatio(Config.AspectRatio or "16:9")
		local IsGrouped = self.Type == "Group" or self.Type == "HStack" or self.Type == "VStack"
		local OffsetX = IsGrouped and 0 or -16

		local Wrap = New("Frame", {
			Size = UDim2.new(1, OffsetX, 0, 150),
			BackgroundTransparency = 1,
			ClipsDescendants = true,
			LayoutOrder = Config.LayoutOrder or 0,
			Parent = Parent,
		})

		local function RecalcAspectRatio()
			local Width = Wrap.AbsoluteSize.X
			if Width > 0 and AspectRatio and AspectRatio > 0 then
				Wrap.Size = UDim2.new(1, OffsetX, 0, math.floor(Width / AspectRatio))
			end
		end

		Creator.AddSignal(Wrap:GetPropertyChangedSignal("AbsoluteSize"), RecalcAspectRatio)
		task.defer(RecalcAspectRatio)

		local Library = self.Library

		local ImageLabel = New("ImageLabel", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			Image = "",
			ScaleType = Enum.ScaleType.Fit,
			Parent = Wrap,
		}, {
			New("UICorner", { CornerRadius = UDim.new(0, Radius) }),
		})

		local function ApplyImage(Source)
			local Resolved = ResolveImage(Source)
			if Resolved:match("^rbxasset") then
				ImageLabel.Image = Resolved
			else
				ImageLabel.Image = Library:ResolveMedia(Resolved)
			end
		end

		task.spawn(ApplyImage, Config.Image or "")

		local Image = { Frame = Wrap, Type = "Image" }

		function Image:SetImage(Source)
			task.spawn(ApplyImage, Source)
		end

		function Image:SetAspectRatio(Ratio)
			AspectRatio = ParseAspectRatio(Ratio)
			RecalcAspectRatio()
		end

		function Image:Destroy()
			Wrap:Destroy()
		end

		return Image
	end

	return Element
end)()

