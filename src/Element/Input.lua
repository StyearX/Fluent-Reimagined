ElementsTable.Input = (function()
	local New = Creator.New
	local AddSignal = Creator.AddSignal

	local Element = {}
	Element.__index = Element
	Element.__type = "Input"

	function Element:New(Idx, Config)
		local Library = self.Library
		assert(Config.Title, "Input - Missing Title")
		Config.Callback = Config.Callback or function() end

		local Input = {
			Value = Config.Default or "",
			Numeric = Config.Numeric or false,
			Finished = Config.Finished or false,
			Callback = Config.Callback or function(Value) end,
			Type = "Input",
		}

		local IsGrouped = self.Type == "Group" or self.Type == "HStack" or self.Type == "VStack"

		local InputFrame = Components.Element(Config.Title, Config.Description, self.Container, false, Config.LayoutOrder, Config.Icon, Config.Marquee)

		local InputRow = New("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, 34),
			LayoutOrder = 2,
			Visible = IsGrouped,
			Parent = InputFrame.LabelHolder,
		})

		Input.SetTitle = InputFrame.SetTitle
		Input.SetDesc = InputFrame.SetDesc

		local Textbox = Components.Textbox(IsGrouped and InputRow or InputFrame.Frame, true)
		Creator.Adaptive(InputFrame, 170, 340, not IsGrouped, function(Inline)
			Textbox.Frame.Parent = Inline and InputFrame.Frame or InputRow
			Textbox.Frame.Position = Inline and UDim2.new(1, -10, 0.5, 0) or UDim2.new(0, 0, 0.5, 0)
			Textbox.Frame.AnchorPoint = Inline and Vector2.new(1, 0.5) or Vector2.new(0, 0.5)
			Textbox.Frame.Size = Inline and UDim2.fromOffset(160, 30) or UDim2.new(1, 0, 0, 30)
			InputRow.Visible = not Inline
		end)
		Textbox.Input.Text = Config.Default or ""
		Textbox.Input.PlaceholderText = Config.Placeholder or ""

		local Box = Textbox.Input

		function Input:SetValue(Text)
			if Config.MaxLength and #Text > Config.MaxLength then
				Text = Text:sub(1, Config.MaxLength)
			end

			if Input.Numeric then
				if (not tonumber(Text)) and Text:len() > 0 then
					Text = Input.Value
				end
			end

			Input.Value = Text
			Box.Text = Text

			Library:SafeCallback(Input.Callback, Input.Value)
			Library:SafeCallback(Input.Changed, Input.Value)
		end

		if Input.Finished then
			AddSignal(Box.FocusLost, function(enter)
				if not enter then
					return
				end
				Input:SetValue(Box.Text)
			end)
		else
			AddSignal(Box:GetPropertyChangedSignal("Text"), function()
				Input:SetValue(Box.Text)
			end)
		end

		function Input:OnChanged(Func)
			Input.Changed = Func
			Func(Input.Value)
		end

		function Input:Destroy()
			InputFrame:Destroy()
			Library.Options[Idx] = nil
		end

		Library.Options[Idx] = Input
		return Input
	end

	return Element
end)()

