Components.Element = (function()
	local New = Creator.New

	local Spring = Flipper.Spring.new

	return function(Title, Desc, Parent, Hover, ElementLayoutOrder, ElementIcon, Marquee)
		local Element = {}

		local ResolvedIcon = ElementIcon
		if type(ResolvedIcon) == "string" and ResolvedIcon ~= ""
			and not ResolvedIcon:match("^rbxassetid://")
			and not ResolvedIcon:match("^rbxasset://")
			and not ResolvedIcon:match("^http") then
			ResolvedIcon = Library:GetIcon(ResolvedIcon)
		end

		local IconImage, IconRectOffset, IconRectSize
		if type(ResolvedIcon) == "table" then
			IconImage = ResolvedIcon.Image
			IconRectOffset = ResolvedIcon.ImageRectOffset
			IconRectSize = ResolvedIcon.ImageRectSize
		elseif type(ResolvedIcon) == "string" and ResolvedIcon ~= "" then
			IconImage = ResolvedIcon
		end

		local iconOffset = IconImage and 26 or 0

		Element.TitleLabel = New("TextLabel", {
			Name = "ElementTitle",
			FontFace = Font.new(Library.Font, Enum.FontWeight.Medium, Enum.FontStyle.Normal),
			Text = Title,
			TextColor3 = Color3.fromRGB(240, 240, 240),
			TextSize = 13,
			TextXAlignment = Enum.TextXAlignment.Left,
			Size = UDim2.new(1, 0, 0, 14),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			ThemeTag = {
				TextColor3 = "Text",
			},
		})

		Element.DescLabel = New("TextLabel", {
			FontFace = Font.new(Library.Font),
			Text = Desc,
			TextColor3 = Color3.fromRGB(200, 200, 200),
			TextSize = 12,
			TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Left,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, 14),
			ThemeTag = {
				TextColor3 = "SubText",
			},
		})

		if Marquee ~= false then
			Creator.Marquee(Element.TitleLabel, "Text")
			Creator.Marquee(Element.DescLabel, "SubText")
		else
			Element.TitleLabel.TextTruncate = Enum.TextTruncate.AtEnd
		end

		Element.LabelHolder = New("Frame", {
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			Position = UDim2.fromOffset(10 + iconOffset, 0),
			Size = UDim2.new(1, -28 - iconOffset, 0, 0),
		}, {
			New("UIListLayout", {
				SortOrder = Enum.SortOrder.LayoutOrder,
				VerticalAlignment = Enum.VerticalAlignment.Center,
			}),
			New("UIPadding", {
				PaddingBottom = UDim.new(0, 13),
				PaddingTop = UDim.new(0, 13),
			}),
			Element.TitleLabel,
			Element.DescLabel,
		})

		if IconImage then
			Element.IconLabel = New("ImageLabel", {
				Image = IconImage,
				ImageRectOffset = IconRectOffset,
				ImageRectSize = IconRectSize,
				Size = UDim2.fromOffset(16, 16),
				Position = UDim2.new(0, 10, 0.5, -8),
				BackgroundTransparency = 1,
				ZIndex = 2,
				ThemeTag = { ImageColor3 = "Text" },
			})
		end

		Element.Border = New("UIStroke", {
			Transparency = 0.5,
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			Color = Color3.fromRGB(0, 0, 0),
			ThemeTag = {
				Color = "ElementBorder",
			},
		})

		local frameChildren = {
			New("UICorner", {
				CornerRadius = UDim.new(0, 4),
			}),
			Element.Border,
			Element.LabelHolder,
		}
		if Element.IconLabel then
			table.insert(frameChildren, Element.IconLabel)
		end

		Element.Frame = New("TextButton", {
			Name = "ElementFrame",
			Size = UDim2.new(1, 0, 0, 0),
			BackgroundTransparency = 0.89,
			BackgroundColor3 = Color3.fromRGB(130, 130, 130),
			Parent = Parent,
			AutomaticSize = Enum.AutomaticSize.Y,
			Text = "",
			LayoutOrder = ElementLayoutOrder or 0,
			ThemeTag = {
				BackgroundColor3 = "Element",
				BackgroundTransparency = "ElementTransparency",
			},
		}, frameChildren)

		Creator.AttachTitleDesc(Element, Element.TitleLabel, Element.DescLabel)

		function Element:Destroy()
			Element.Frame:Destroy()
		end

		Element:SetTitle(Title)
		Element:SetDesc(Desc)

		if Hover then
			local Motor, SetTransparency = Creator.SpringMotor(
				Creator.GetThemeProperty("ElementTransparency"),
				Element.Frame,
				"BackgroundTransparency",
				false,
				true
			)

			Creator.AddSignal(Element.Frame.MouseEnter, function()
				SetTransparency(Creator.GetThemeProperty("ElementTransparency") - Creator.GetThemeProperty("HoverChange"))
			end)
			Creator.AddSignal(Element.Frame.MouseLeave, function()
				SetTransparency(Creator.GetThemeProperty("ElementTransparency"))
			end)
			Creator.AddSignal(Element.Frame.MouseButton1Down, function()
				SetTransparency(Creator.GetThemeProperty("ElementTransparency") + Creator.GetThemeProperty("HoverChange"))
			end)
			Creator.AddSignal(Element.Frame.MouseButton1Up, function()
				SetTransparency(Creator.GetThemeProperty("ElementTransparency") - Creator.GetThemeProperty("HoverChange"))
			end)
		end

		return Element
	end
end)()

