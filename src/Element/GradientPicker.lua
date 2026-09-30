ElementsTable.GradientPicker = (function()
	local RenderStepped = RunService.RenderStepped
	local Mouse = LocalPlayer:GetMouse()

	local New = Creator.New

	local Element = {}
	Element.__index = Element
	Element.__type = "GradientPicker"

	local function hsvToColor3(Hsv)
		return Color3.fromHSV(Hsv.Hue, Hsv.Sat, Hsv.Vib)
	end

	local function color3ToHsv(Color)
		local H, S, V = Color3.toHSV(Color)
		return { Hue = H, Sat = S, Vib = V }
	end

	function Element:New(Idx, Config)
		local Library = self.Library
		assert(Config.Title, "GradientPicker - Missing Title")
		assert(Config.Default, "AddGradientPicker: Missing default value.")

		local GradientPicker = {
			Value = Config.Default,
			Rotation = tonumber(Config.Rotation) or 0,
			Type = "GradientPicker",
			Title = type(Config.Title) == "string" and Config.Title or "Gradient Picker",
			Callback = Config.Callback or function(Sequence) end,
		}

		local function KeypointsFromSequence(Sequence)
			local Keypoints = Sequence.Keypoints
			return color3ToHsv(Keypoints[1].Value), color3ToHsv(Keypoints[#Keypoints].Value)
		end

		GradientPicker.StartHSV, GradientPicker.EndHSV = KeypointsFromSequence(GradientPicker.Value)

		local IsGrouped = self.Type == "Group" or self.Type == "HStack" or self.Type == "VStack"

		local GradientPickerFrame = Components.Element(Config.Title, Config.Description, self.Container, true, Config.LayoutOrder, Config.Icon, Config.Marquee)

		GradientPickerFrame.TitleLabel.Size = UDim2.new(1, -44, 0, 14)
		GradientPickerFrame.DescLabel.Size = UDim2.new(1, -44, 0, 14)

		GradientPicker.SetTitle = GradientPickerFrame.SetTitle
		GradientPicker.SetDesc = GradientPickerFrame.SetDesc

		local DisplayFrameGradient = New("UIGradient", {
			Color = GradientPicker.Value,
			Rotation = GradientPicker.Rotation,
		})

		local DisplayFrame = New("Frame", {
			Size = UDim2.fromOffset(26, 26),
			Position = UDim2.new(1, -10, 0.5, 0),
			AnchorPoint = Vector2.new(1, 0.5),
			Parent = GradientPickerFrame.Frame,
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 4),
			}),
			New("UIStroke", {
				Thickness = 1,
				Transparency = 0.5,
				ThemeTag = {
					Color = "InElementBorder",
				},
			}),
			DisplayFrameGradient,
		})

		local GradientPickerTextboxTags = {
			Input = "ColorpickerInput",
			InputLine = "ColorpickerInputLine",
			InputBorder = "ColorpickerInputBorder",
			InputFocused = "ColorpickerInputFocused",
		}

		local function CreateGradientDialog()
			local Dialog = Components.Dialog:Create()
			Dialog.Title.Text = GradientPicker.Title
			Dialog.Root.Size = UDim2.fromOffset(460, 420)

			Creator.OverrideTag(Dialog.Root, { BackgroundColor3 = "ColorpickerDialog" })
			Creator.OverrideTag(Dialog.Root.UIStroke, { Color = "ColorpickerDialogBorder" })
			Creator.OverrideTag(Dialog.ButtonHolderFrame, { BackgroundColor3 = "ColorpickerHolder" })
			Creator.OverrideTag(Dialog.HolderLine, { BackgroundColor3 = "ColorpickerHolderLine" })

			local Slots = {
				Start = { Hue = GradientPicker.StartHSV.Hue, Sat = GradientPicker.StartHSV.Sat, Vib = GradientPicker.StartHSV.Vib },
				["End"] = { Hue = GradientPicker.EndHSV.Hue, Sat = GradientPicker.EndHSV.Sat, Vib = GradientPicker.EndHSV.Vib },
			}
			local ActiveSlot = "Start"

			local function Active()
				return Slots[ActiveSlot]
			end

			local function CreateInput()
				local Box = Components.Textbox(nil, false, GradientPickerTextboxTags)
				Box.Frame.Parent = Dialog.Root
				Box.Frame.Size = UDim2.new(0, 90, 0, 32)

				return Box
			end

			local function CreateInputLabel(Text, Pos)
				return New("TextLabel", {
					FontFace = Font.new(Library.Font, Enum.FontWeight.Medium, Enum.FontStyle.Normal),
					Text = Text,
					TextColor3 = Color3.fromRGB(240, 240, 240),
					TextSize = 13,
					TextXAlignment = Enum.TextXAlignment.Left,
					Size = UDim2.new(1, 0, 0, 32),
					Position = Pos,
					BackgroundTransparency = 1,
					Parent = Dialog.Root,
					ThemeTag = {
						TextColor3 = "Text",
					},
				})
			end

			local function GetRGB()
				local Value = hsvToColor3(Active())
				return { R = math.floor(Value.r * 255), G = math.floor(Value.g * 255), B = math.floor(Value.b * 255) }
			end

			local SatCursor = New("ImageLabel", {
				Size = UDim2.new(0, 18, 0, 18),
				ScaleType = Enum.ScaleType.Fit,
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundTransparency = 1,
				Image = "http://www.roblox.com/asset/?id=4805639000",
			})

			local SatVibMap = New("ImageLabel", {
				Size = UDim2.fromOffset(200, 200),
				Position = UDim2.fromOffset(20, 95),
				Image = "rbxassetid://4155801252",
				BackgroundTransparency = 0,
				Parent = Dialog.Root,
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(0, 4),
				}),
				SatCursor,
			})

			local SequenceTable = {}
			for Color = 0, 1, 0.1 do
				table.insert(SequenceTable, ColorSequenceKeypoint.new(Color, Color3.fromHSV(Color, 1, 1)))
			end

			local HueSliderGradient = New("UIGradient", {
				Color = ColorSequence.new(SequenceTable),
				Rotation = 90,
			})

			local HueDragHolder = New("Frame", {
				Size = UDim2.new(1, 0, 1, -10),
				Position = UDim2.fromOffset(0, 5),
				BackgroundTransparency = 1,
			})

			local HueDrag = New("ImageLabel", {
				Size = UDim2.fromOffset(14, 14),
				Image = "http://www.roblox.com/asset/?id=12266946128",
				ImageColor3 = Creator.GetKnobColor(),
				Parent = HueDragHolder,
			})

			Creator.OnThemeChanged(function()
				HueDrag.ImageColor3 = Creator.GetKnobColor()
			end)

			local HueSlider = New("Frame", {
				Size = UDim2.fromOffset(12, 200),
				Position = UDim2.fromOffset(230, 95),
				Parent = Dialog.Root,
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(1, 0),
				}),
				HueSliderGradient,
				HueDragHolder,
			})

			local HexInput = CreateInput()
			HexInput.Frame.Position = UDim2.fromOffset(260, 95)
			CreateInputLabel("Hex", UDim2.fromOffset(360, 95))

			local RedInput = CreateInput()
			RedInput.Frame.Position = UDim2.fromOffset(260, 135)
			CreateInputLabel("Red", UDim2.fromOffset(360, 135))

			local GreenInput = CreateInput()
			GreenInput.Frame.Position = UDim2.fromOffset(260, 175)
			CreateInputLabel("Green", UDim2.fromOffset(360, 175))

			local BlueInput = CreateInput()
			BlueInput.Frame.Position = UDim2.fromOffset(260, 215)
			CreateInputLabel("Blue", UDim2.fromOffset(360, 215))

			local RotationInput = CreateInput()
			RotationInput.Frame.Position = UDim2.fromOffset(260, 255)
			CreateInputLabel("Rotation", UDim2.fromOffset(360, 255))

			local function CreateSlotSwatch(Label, X)
				local SwatchColor = New("Frame", {
					Size = UDim2.fromScale(1, 1),
				}, {
					New("UICorner", {
						CornerRadius = UDim.new(0, 4),
					}),
				})

				local SwatchLabel = New("TextLabel", {
					FontFace = Font.new(Library.Font, Enum.FontWeight.Medium, Enum.FontStyle.Normal),
					Text = Label,
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextStrokeColor3 = Color3.fromRGB(0, 0, 0),
					TextStrokeTransparency = 0,
					TextSize = 12,
					TextXAlignment = Enum.TextXAlignment.Center,
					TextYAlignment = Enum.TextYAlignment.Center,
					Size = UDim2.fromScale(1, 1),
					Position = UDim2.fromScale(0, 0),
					BackgroundTransparency = 1,
					ZIndex = 2,
				})

				local Stroke = New("UIStroke", {
					Thickness = 2,
					Transparency = 0,
					ThemeTag = {
						Color = "Accent",
					},
				})

				local Swatch = New("TextButton", {
					Text = "",
					Size = UDim2.fromOffset(90, 30),
					Position = UDim2.fromOffset(X, 305),
					Parent = Dialog.Root,
					BackgroundTransparency = 1,
				}, {
					New("UICorner", {
						CornerRadius = UDim.new(0, 4),
					}),
					Stroke,
					SwatchColor,
					SwatchLabel,
				})

				return Swatch, SwatchColor, Stroke
			end

			local StartSwatch, StartSwatchColor, StartSwatchStroke = CreateSlotSwatch("Start", 20)
			local EndSwatch, EndSwatchColor, EndSwatchStroke = CreateSlotSwatch("End", 350)

			local GradientPreviewGradient = New("UIGradient", {
				Rotation = GradientPicker.Rotation,
			})

			New("Frame", {
				Size = UDim2.fromOffset(410, 24),
				Position = UDim2.fromOffset(20, 55),
				Parent = Dialog.Root,
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(0, 4),
				}),
				New("UIStroke", {
					Thickness = 1,
					Transparency = 0.5,
					ThemeTag = {
						Color = "InElementBorder",
					},
				}),
				GradientPreviewGradient,
			})

			local function Display()
				local Hsv = Active()
				SatVibMap.BackgroundColor3 = Color3.fromHSV(Hsv.Hue, 1, 1)
				HueDrag.Position = UDim2.new(0, -1, Hsv.Hue, -6)
				SatCursor.Position = UDim2.new(Hsv.Sat, 0, 1 - Hsv.Vib, 0)

				HexInput.Input.Text = "#" .. hsvToColor3(Hsv):ToHex()
				RedInput.Input.Text = GetRGB()["R"]
				GreenInput.Input.Text = GetRGB()["G"]
				BlueInput.Input.Text = GetRGB()["B"]
				RotationInput.Input.Text = tostring(math.floor(GradientPicker.Rotation))

				local StartColor = hsvToColor3(Slots.Start)
				local EndColor = hsvToColor3(Slots["End"])

				StartSwatchColor.BackgroundColor3 = StartColor
				EndSwatchColor.BackgroundColor3 = EndColor
				StartSwatchStroke.Transparency = ActiveSlot == "Start" and 0 or 0.85
				EndSwatchStroke.Transparency = ActiveSlot == "End" and 0 or 0.85

				GradientPreviewGradient.Color = ColorSequence.new(StartColor, EndColor)
				GradientPreviewGradient.Rotation = GradientPicker.Rotation
			end

			Creator.AddSignal(StartSwatch.MouseButton1Click, function()
				ActiveSlot = "Start"
				Display()
			end)
			Creator.AddSignal(EndSwatch.MouseButton1Click, function()
				ActiveSlot = "End"
				Display()
			end)

			Creator.AddSignal(HexInput.Input.FocusLost, function(Enter)
				if Enter then
					local Success, Result = pcall(Color3.fromHex, HexInput.Input.Text)
					if Success and typeof(Result) == "Color3" then
						local Hsv = Active()
						Hsv.Hue, Hsv.Sat, Hsv.Vib = Color3.toHSV(Result)
					end
				end
				Display()
			end)

			Creator.AddSignal(RedInput.Input.FocusLost, function(Enter)
				if Enter then
					local CurrentColor = GetRGB()
					local Success, Result = pcall(Color3.fromRGB, RedInput.Input.Text, CurrentColor["G"], CurrentColor["B"])
					if Success and typeof(Result) == "Color3" then
						if tonumber(RedInput.Input.Text) <= 255 then
							local Hsv = Active()
							Hsv.Hue, Hsv.Sat, Hsv.Vib = Color3.toHSV(Result)
						end
					end
				end
				Display()
			end)

			Creator.AddSignal(GreenInput.Input.FocusLost, function(Enter)
				if Enter then
					local CurrentColor = GetRGB()
					local Success, Result = pcall(Color3.fromRGB, CurrentColor["R"], GreenInput.Input.Text, CurrentColor["B"])
					if Success and typeof(Result) == "Color3" then
						if tonumber(GreenInput.Input.Text) <= 255 then
							local Hsv = Active()
							Hsv.Hue, Hsv.Sat, Hsv.Vib = Color3.toHSV(Result)
						end
					end
				end
				Display()
			end)

			Creator.AddSignal(BlueInput.Input.FocusLost, function(Enter)
				if Enter then
					local CurrentColor = GetRGB()
					local Success, Result = pcall(Color3.fromRGB, CurrentColor["R"], CurrentColor["G"], BlueInput.Input.Text)
					if Success and typeof(Result) == "Color3" then
						if tonumber(BlueInput.Input.Text) <= 255 then
							local Hsv = Active()
							Hsv.Hue, Hsv.Sat, Hsv.Vib = Color3.toHSV(Result)
						end
					end
				end
				Display()
			end)

			Creator.AddSignal(RotationInput.Input.FocusLost, function(Enter)
				if Enter then
					local Value = tonumber(RotationInput.Input.Text)
					if Value then
						GradientPicker.Rotation = math.clamp(Value, 0, 360)
					end
				end
				Display()
			end)

			Creator.AddSignal(SatVibMap.InputBegan, function(Input)
				if
					Input.UserInputType == Enum.UserInputType.MouseButton1
					or Input.UserInputType == Enum.UserInputType.Touch
				then
					while UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
						local MinX = SatVibMap.AbsolutePosition.X
						local MaxX = MinX + SatVibMap.AbsoluteSize.X
						local MouseX = math.clamp(Mouse.X, MinX, MaxX)

						local MinY = SatVibMap.AbsolutePosition.Y
						local MaxY = MinY + SatVibMap.AbsoluteSize.Y
						local MouseY = math.clamp(Mouse.Y, MinY, MaxY)

						local Hsv = Active()
						Hsv.Sat = (MouseX - MinX) / (MaxX - MinX)
						Hsv.Vib = 1 - ((MouseY - MinY) / (MaxY - MinY))
						Display()

						RenderStepped:Wait()
					end
				end
			end)

			Creator.AddSignal(HueSlider.InputBegan, function(Input)
				if
					Input.UserInputType == Enum.UserInputType.MouseButton1
					or Input.UserInputType == Enum.UserInputType.Touch
				then
					while UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
						local MinY = HueSlider.AbsolutePosition.Y
						local MaxY = MinY + HueSlider.AbsoluteSize.Y
						local MouseY = math.clamp(Mouse.Y, MinY, MaxY)

						local Hsv = Active()
						Hsv.Hue = ((MouseY - MinY) / (MaxY - MinY))
						Display()

						RenderStepped:Wait()
					end
				end
			end)

			Display()

			local DoneButton = Dialog:Button("Done", function()
				GradientPicker:SetHSV(Slots.Start, Slots["End"])
			end)
			local CancelButton = Dialog:Button("Cancel")

			for _, Btn in next, { DoneButton, CancelButton } do
				Creator.OverrideTag(Btn.Frame, { BackgroundColor3 = "ColorpickerButton" })
				Creator.OverrideTag(Btn.Frame.UIStroke, { Color = "ColorpickerButtonBorder" })
			end

			Dialog:Open()
		end

		function GradientPicker:Display()
			GradientPicker.Value = ColorSequence.new(hsvToColor3(GradientPicker.StartHSV), hsvToColor3(GradientPicker.EndHSV))

			DisplayFrameGradient.Color = GradientPicker.Value
			DisplayFrameGradient.Rotation = GradientPicker.Rotation

			Element.Library:SafeCallback(GradientPicker.Callback, GradientPicker.Value, GradientPicker.Rotation)
			Element.Library:SafeCallback(GradientPicker.Changed, GradientPicker.Value, GradientPicker.Rotation)
		end

		function GradientPicker:SetHSV(StartHSV, EndHSV)
			GradientPicker.StartHSV = { Hue = StartHSV.Hue, Sat = StartHSV.Sat, Vib = StartHSV.Vib }
			GradientPicker.EndHSV = { Hue = EndHSV.Hue, Sat = EndHSV.Sat, Vib = EndHSV.Vib }
			GradientPicker:Display()
		end

		function GradientPicker:SetRotation(Rotation)
			GradientPicker.Rotation = math.clamp(tonumber(Rotation) or 0, 0, 360)
			GradientPicker:Display()
		end

		function GradientPicker:SetValueSequence(Sequence)
			GradientPicker.StartHSV, GradientPicker.EndHSV = KeypointsFromSequence(Sequence)
			GradientPicker:Display()
		end

		function GradientPicker:OnChanged(Func)
			GradientPicker.Changed = Func
			Func(GradientPicker.Value)
		end

		function GradientPicker:Destroy()
			GradientPickerFrame:Destroy()
			Library.Options[Idx] = nil
		end

		Creator.AddSignal(GradientPickerFrame.Frame.MouseButton1Click, function()
			CreateGradientDialog()
		end)

		GradientPicker:Display()

		Library.Options[Idx] = GradientPicker
		return GradientPicker
	end

	return Element
end)()

