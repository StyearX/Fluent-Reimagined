local InterfaceManager = {} do
	InterfaceManager.Folder = "FluentReimaginedSettings"
	InterfaceManager.Settings = {
		Theme = "Dark",
		Font = "rbxasset://fonts/families/GothamSSm.json",
		Acrylic = true,
		Transparency = 35,
		MenuKeybind = "LeftControl",
		ShowUserInfo = true,
		DisableBackground = false,
		KeepWindowInsideFrame = true,
		ActiveCustomTheme = nil,
	}

	local ThemeManager = {}

	local themePropertyKeys = {
		"Accent","AcrylicMain","AcrylicBorder","AcrylicGradient","AcrylicGradientRotation","AcrylicNoise",
		"Background","BackgroundTransparency","TitleBarLine","Tab",
		"Element","ElementBorder","InElementBorder","ElementTransparency",
		"ToggleSlider","ToggleToggled","SliderRail",
		"DropdownFrame","DropdownHolder","DropdownBorder","DropdownOption",
		"Keybind","Input","InputFocused","InputIndicator",
		"Dialog","DialogHolder","DialogHolderLine","DialogButton","DialogButtonBorder",
		"DialogBorder","DialogInput","DialogInputLine",
		"ColorpickerDialog","ColorpickerDialogBorder","ColorpickerHolder","ColorpickerHolderLine",
		"ColorpickerButton","ColorpickerButtonBorder","ColorpickerInput","ColorpickerInputLine",
		"ColorpickerInputBorder","ColorpickerInputFocused",
		"Text","SubText","Hover","HoverChange",
	}

	local colorFieldDefs = {
		{ key = "Accent", title = "Accent", description = "Primary accent color used across interactive elements." },
		{ key = "AcrylicMain", title = "Acrylic Main", description = "Base color of the acrylic window background." },
		{ key = "AcrylicBorder", title = "Acrylic Border", description = "Border color around the acrylic window." },
		{ key = "TitleBarLine", title = "Title Bar Line", description = "Divider line under the title bar." },
		{ key = "Tab", title = "Tab", description = "Tab background color." },
		{ key = "Element", title = "Element", description = "Background color of elements." },
		{ key = "ElementBorder", title = "Element Border", description = "Border color of elements." },
		{ key = "InElementBorder", title = "Inner Element Border", description = "Border color inside elements." },
		{ key = "ToggleSlider", title = "Toggle Rail", description = "Toggle rail color when off." },
		{ key = "ToggleToggled", title = "Toggle Knob", description = "Toggle knob color when on." },
		{ key = "SliderRail", title = "Slider Rail", description = "Slider rail color." },
		{ key = "DropdownFrame", title = "Dropdown Frame", description = "Dropdown frame color." },
		{ key = "DropdownHolder", title = "Dropdown Holder", description = "Dropdown list background color." },
		{ key = "DropdownBorder", title = "Dropdown Border", description = "Dropdown border color." },
		{ key = "DropdownOption", title = "Dropdown Option", description = "Dropdown option color." },
		{ key = "Keybind", title = "Keybind", description = "Keybind element color." },
		{ key = "Input", title = "Input", description = "Input field color." },
		{ key = "InputFocused", title = "Input Focused", description = "Input field color when focused." },
		{ key = "InputIndicator", title = "Input Indicator", description = "Input focus indicator color." },
		{ key = "Dialog", title = "Dialog", description = "Dialog background color." },
		{ key = "DialogHolder", title = "Dialog Holder", description = "Dialog holder background color." },
		{ key = "DialogHolderLine", title = "Dialog Holder Line", description = "Dialog holder divider line color." },
		{ key = "DialogButton", title = "Dialog Button", description = "Dialog button color." },
		{ key = "DialogButtonBorder", title = "Dialog Button Border", description = "Dialog button border color." },
		{ key = "DialogBorder", title = "Dialog Border", description = "Dialog border color." },
		{ key = "DialogInput", title = "Dialog Input", description = "Dialog input field color." },
		{ key = "DialogInputLine", title = "Dialog Input Line", description = "Dialog input focus line color." },
		{ key = "ColorpickerDialog", title = "Colorpicker Dialog", description = "Colorpicker dialog background color." },
		{ key = "ColorpickerDialogBorder", title = "Colorpicker Dialog Border", description = "Colorpicker dialog border color." },
		{ key = "ColorpickerHolder", title = "Colorpicker Holder", description = "Colorpicker holder background color." },
		{ key = "ColorpickerHolderLine", title = "Colorpicker Holder Line", description = "Colorpicker holder divider line color." },
		{ key = "ColorpickerButton", title = "Colorpicker Button", description = "Colorpicker button color." },
		{ key = "ColorpickerButtonBorder", title = "Colorpicker Button Border", description = "Colorpicker button border color." },
		{ key = "ColorpickerInput", title = "Colorpicker Input", description = "Colorpicker input field color." },
		{ key = "ColorpickerInputLine", title = "Colorpicker Input Line", description = "Colorpicker input focus line color." },
		{ key = "ColorpickerInputBorder", title = "Colorpicker Input Border", description = "Colorpicker input border color." },
		{ key = "ColorpickerInputFocused", title = "Colorpicker Input Focused", description = "Colorpicker input color when focused." },
		{ key = "Text", title = "Text", description = "Primary text color." },
		{ key = "SubText", title = "SubText", description = "Secondary text color." },
		{ key = "Hover", title = "Hover", description = "Hover highlight color." },
	}

	local function sanitizeFileName(name)
		return (name:gsub('[\\/:%*%?"<>|]', "_"))
	end

	local function color3ToHex(c)
		return string.format("%02X%02X%02X", math.floor(c.R*255), math.floor(c.G*255), math.floor(c.B*255))
	end

	local function hexToColor3(h)
		local r = tonumber(h:sub(1,2),16) or 0
		local g = tonumber(h:sub(3,4),16) or 0
		local b = tonumber(h:sub(5,6),16) or 0
		return Color3.fromRGB(r,g,b)
	end

	local function colorSeqToArray(cs)
		local arr = {}
		for _, kp in ipairs(cs.Keypoints) do
			table.insert(arr, { t = kp.Time, c = color3ToHex(kp.Value) })
		end
		return arr
	end

	local function arrayToColorSeq(arr)
		local kps = {}
		for _, entry in ipairs(arr) do
			table.insert(kps, ColorSequenceKeypoint.new(entry.t, hexToColor3(entry.c)))
		end
		return ColorSequence.new(kps)
	end

	local function generateGradientColors(themeData)
		local candidates = {
			themeData.Accent,
			themeData.AcrylicMain,
			themeData.AcrylicBorder,
			themeData.Element,
			themeData.Dialog,
		}
		local filtered = {}
		for _, c in ipairs(candidates) do
			if typeof(c) == "Color3" then
				table.insert(filtered, c)
			end
		end
		if #filtered < 2 then
			return { Color3.fromRGB(50,50,50), Color3.fromRGB(20,20,20) }
		end
		return { filtered[1], filtered[#filtered] }
	end

	function ThemeManager.serializeTheme(themeData)
		local raw = {}
		for _, key in ipairs(themePropertyKeys) do
			local val = themeData[key]
			if val == nil then
				raw[key] = nil
			elseif typeof(val) == "Color3" then
				raw[key] = { __type = "Color3", value = color3ToHex(val) }
			elseif typeof(val) == "ColorSequence" then
				raw[key] = { __type = "ColorSequence", value = colorSeqToArray(val) }
			else
				raw[key] = val
			end
		end
		local gradColors = generateGradientColors(themeData)
		local metaGrad = {}
		for _, c in ipairs(gradColors) do
			table.insert(metaGrad, color3ToHex(c))
		end
		raw.__meta = {
			Name = themeData.Name or "Custom",
			Id = themeData.Id,
			CardGradient = metaGrad,
			Author = {
				Name = LocalPlayer and LocalPlayer.Name or "Unknown",
				UserId = LocalPlayer and LocalPlayer.UserId or 0,
			},
		}
		return httpService:JSONEncode(raw)
	end

	function ThemeManager.deserializeTheme(jsonStr)
		local success, decoded = pcall(httpService.JSONDecode, httpService, jsonStr)
		if not success or type(decoded) ~= "table" then return nil end

		local themeData = {}
		for _, key in ipairs(themePropertyKeys) do
			local val = decoded[key]
			if val == nil then
			elseif type(val) == "table" and val.__type == "Color3" then
				themeData[key] = hexToColor3(val.value)
			elseif type(val) == "table" and val.__type == "ColorSequence" then
				themeData[key] = arrayToColorSeq(val.value)
			else
				themeData[key] = val
			end
		end

		if decoded.__meta then
			themeData.Name = decoded.__meta.Name or "Custom"
			themeData.Id = decoded.__meta.Id
			local gradArr = decoded.__meta.CardGradient
			if gradArr and #gradArr >= 2 then
				themeData.__cardGradient = { hexToColor3(gradArr[1]), hexToColor3(gradArr[2]) }
			end
			if type(decoded.__meta.Author) == "table" then
				themeData.Author = decoded.__meta.Author
			end
		end

		return themeData
	end

	function ThemeManager.buildFromCurrentOptions(name, optionValues)
		local themeData = {}

		for _, field in ipairs(colorFieldDefs) do
			local value = optionValues["Panel" .. field.key]
			if typeof(value) == "Color3" then
				themeData[field.key] = value
			end
		end

		local gradientValue = optionValues.PanelAcrylicGradient
		if typeof(gradientValue) == "ColorSequence" then
			themeData.AcrylicGradient = gradientValue
		end

		local acrylicGradientOption = Library.Options.PanelAcrylicGradient
		if acrylicGradientOption and typeof(acrylicGradientOption.Rotation) == "number" then
			themeData.AcrylicGradientRotation = acrylicGradientOption.Rotation
		end

		if optionValues.PanelBackground ~= nil then
			themeData.Background = optionValues.PanelBackground
		end
		if optionValues.PanelBackgroundTransparency then
			themeData.BackgroundTransparency = optionValues.PanelBackgroundTransparency / 100
		end
		if optionValues.PanelAcrylicNoise then
			themeData.AcrylicNoise = optionValues.PanelAcrylicNoise / 100
		end
		if optionValues.PanelElementTransparency then
			themeData.ElementTransparency = optionValues.PanelElementTransparency / 100
		end
		if optionValues.PanelHoverChange then
			themeData.HoverChange = optionValues.PanelHoverChange / 100
		end

		themeData.Name = name and name ~= "" and name or "Custom"
		themeData.__cardGradient = generateGradientColors(themeData)

		return themeData
	end

	local function normalizeColorValue(value)
		if typeof(value) == "Color3" then
			return value
		end

		if type(value) == "table" then
			if value.__type == "Color3" and value.value then
				return hexToColor3(value.value)
			end

			local r = value.r or value.R or value[1]
			local g = value.g or value.G or value[2]
			local b = value.b or value.B or value[3]
			if r and g and b then
				if r <= 1 and g <= 1 and b <= 1 then
					return Color3.new(r, g, b)
				end
				return Color3.fromRGB(r, g, b)
			end
		end

		if type(value) == "string" then
			local cleanHex = value:gsub("^#", ""):gsub("^0[xX]", "")
			if cleanHex:match("^%x%x%x%x%x%x$") then
				return hexToColor3(cleanHex)
			end

			local r, g, b = value:match("^%s*(%d+)%s*,%s*(%d+)%s*,%s*(%d+)%s*$")
			if r then
				return Color3.fromRGB(tonumber(r), tonumber(g), tonumber(b))
			end
		end

		return nil
	end

	local function normalizeGradientValue(value)
		if typeof(value) == "ColorSequence" then
			return value
		end

		if type(value) == "table" and value.__type == "ColorSequence" and type(value.value) == "table" then
			local keypoints = {}
			for _, entry in ipairs(value.value) do
				local entryColor = normalizeColorValue(entry.c or entry.Color or entry.value)
				local entryTime = tonumber(entry.t or entry.Time)
				if entryColor and entryTime then
					table.insert(keypoints, { Time = math.clamp(entryTime, 0, 1), Value = entryColor })
				end
			end
			table.sort(keypoints, function(a, b) return a.Time < b.Time end)

			if #keypoints >= 2 then
				keypoints[1].Time = 0
				keypoints[#keypoints].Time = 1
				local sequenceKeypoints = {}
				for _, kp in ipairs(keypoints) do
					table.insert(sequenceKeypoints, ColorSequenceKeypoint.new(kp.Time, kp.Value))
				end
				return ColorSequence.new(sequenceKeypoints)
			elseif #keypoints == 1 then
				return ColorSequence.new(keypoints[1].Value)
			end
		end

		if type(value) == "table" and value[1] and value[2] then
			local colorStart = normalizeColorValue(value[1])
			local colorEnd = normalizeColorValue(value[2])
			if colorStart and colorEnd then
				return ColorSequence.new(colorStart, colorEnd)
			end
		end

		return nil
	end

	local numericThemeKeys = {
		BackgroundTransparency = true,
		AcrylicNoise = true,
		ElementTransparency = true,
		HoverChange = true,
	}

	local rawNumericThemeKeys = {
		AcrylicGradientRotation = true,
	}

	local function finalizeThemeData(extracted)
		if not extracted then
			return nil
		end

		local themeData = {}

		local gradientThemeKeys = {
			AcrylicGradient = true,
		}

		for _, key in ipairs(themePropertyKeys) do
			local value = extracted[key]
			if value ~= nil then
				if gradientThemeKeys[key] then
					local gradient = normalizeGradientValue(value)
					if gradient then
						themeData[key] = gradient
					end
				elseif key == "Background" then
					themeData.Background = tostring(value)
				elseif rawNumericThemeKeys[key] then
					local num = tonumber(value)
					if num then
						themeData[key] = num
					end
				elseif numericThemeKeys[key] then
					local num = tonumber(value)
					if num then
						themeData[key] = num > 1 and (num / 100) or num
					end
				else
					local color = normalizeColorValue(value)
					if color then
						themeData[key] = color
					end
				end
			end
		end

		if not themeData.AcrylicGradient then
			local gradient = normalizeGradientValue({ extracted.AcrylicGradientStart, extracted.AcrylicGradientEnd })
			if gradient then
				themeData.AcrylicGradient = gradient
			end
		end

		themeData.Name = (extracted.Name and tostring(extracted.Name) ~= "") and tostring(extracted.Name) or "Imported"

		local gradientMeta = extracted.CardGradient
		if type(gradientMeta) == "table" and gradientMeta[1] and gradientMeta[2] then
			local colorA = normalizeColorValue(gradientMeta[1])
			local colorB = normalizeColorValue(gradientMeta[2])
			if colorA and colorB then
				themeData.__cardGradient = { colorA, colorB }
			end
		end

		if not themeData.__cardGradient then
			themeData.__cardGradient = generateGradientColors(themeData)
		end

		return themeData
	end

	local function parseJsonFormat(text)
		local success, decoded = pcall(httpService.JSONDecode, httpService, text)
		if not success or type(decoded) ~= "table" then
			return nil
		end

		local source = decoded.Import or decoded
		local extracted = {}

		for key, value in next, source do
			if key == "__meta" or key == "Meta" then
				if type(value) == "table" then
					extracted.Name = value.Name
					extracted.CardGradient = value.CardGradient
				end
			elseif key ~= "__type" then
				extracted[key] = value
			end
		end

		return extracted
	end

	local function parseLuaTableFormat(text)
		local body = text:gsub("^%s*Import%s*=%s*", ""):gsub("^%s*return%s+", "")

		local bracePos = body:find("{")
		if not bracePos then
			return nil
		end
		body = body:sub(bracePos)

		local patchedBody = body:gsub("([%a_][%w_]*)%s*=%s*([^,{}\n]-)%s*([,\n}])", function(matchKey, matchValue, term)
			local trimmed = matchValue:match("^%s*(.-)%s*$")
			if trimmed == "" then
				return nil
			end
			local firstChar = trimmed:sub(1, 1)
			if firstChar == "\"" or firstChar == "'" then
				return nil
			end
			if trimmed:find("(", 1, true) then
				return nil
			end
			if trimmed == "true" or trimmed == "false" or trimmed == "nil" then
				return nil
			end
			if tonumber(trimmed) then
				return nil
			end
			if not trimmed:match("^%x%x%x%x%x%x$") then
				return nil
			end
			return matchKey .. ' = "' .. trimmed .. '"' .. term
		end)

		local chunk = loadstring("return " .. patchedBody) or loadstring("return " .. body)
		if not chunk then
			return nil
		end

		local success, result = pcall(chunk)
		if not success or type(result) ~= "table" then
			return nil
		end

		local extracted = {}
		for key, value in next, result do
			if key == "Meta" then
				if type(value) == "table" then
					extracted.Name = value.Name
					extracted.CardGradient = value.CardGradient
				end
			else
				extracted[key] = value
			end
		end

		return extracted
	end

	local function parseLineFormat(text)
		local extracted = {}
		local foundAny = false

		for line in text:gmatch("[^\r\n]+") do
			local key, value = line:match("^%s*([%a_][%w_]*)%s*[:=]%s*(.-)%s*$")
			if key and value and value ~= "" then
				value = value:gsub('^"(.*)"$', "%1"):gsub("^'(.*)'$", "%1")
				extracted[key] = value
				foundAny = true
			end
		end

		if not foundAny then
			return nil
		end

		return extracted
	end

	local importFormatParsers = {
		parseJsonFormat,
		parseLuaTableFormat,
		parseLineFormat,
	}

	function ThemeManager.parseImportString(raw)
		if not raw or raw:gsub("%s", "") == "" then
			return nil
		end

		local trimmed = raw:match("^%s*(.-)%s*$")

		for _, parser in ipairs(importFormatParsers) do
			local ok, extracted = pcall(parser, trimmed)
			if ok and extracted then
				local themeData = finalizeThemeData(extracted)
				if themeData then
					return themeData
				end
			end
		end

		return nil
	end

	function InterfaceManager:SetFolder(folder)
		self.Folder = folder
		self:BuildFolderTree()
	end

	function InterfaceManager:SetLibrary(library)
		self.Library = library
	end

	function InterfaceManager:BuildFolderTree()
		local paths = {}

		local parts = self.Folder:split("/")
		for idx = 1, #parts do
			paths[#paths + 1] = table.concat(parts, "/", 1, idx)
		end

		table.insert(paths, self.Folder)
		table.insert(paths, self.Folder .. "/settings")
		table.insert(paths, self.Folder .. "/Theme")

		for i = 1, #paths do
			local str = paths[i]
			if not isfolder(str) then
				makefolder(str)
			end
		end
	end

	function InterfaceManager:GenerateThemeId(name)
		local base = sanitizeFileName(name and name ~= "" and name or "Custom")
		local n = 1
		while isfile(self.Folder .. "/Theme/" .. base .. "_" .. n .. ".theme") do
			n = n + 1
		end
		return base .. "_" .. n
	end

	function InterfaceManager:SaveCustomTheme(themeData)
		local id = themeData.Id or self:GenerateThemeId(themeData.Name)
		themeData.Id = id
		local path = self.Folder .. "/Theme/" .. sanitizeFileName(id) .. ".theme"
		local encoded = ThemeManager.serializeTheme(themeData)
		writefile(path, encoded)
	end

	function InterfaceManager:LoadCustomThemes()
		local folder = self.Folder .. "/Theme"
		if not isfolder(folder) then return {} end
		local files = listfiles(folder)
		local out = {}
		for _, file in ipairs(files) do
			if file:sub(-6) == ".theme" then
				local ok, data = pcall(readfile, file)
				if ok and data then
					local themeData = ThemeManager.deserializeTheme(data)
					if themeData then
						if not themeData.Id or themeData.Id == "" then
							local newId = self:GenerateThemeId(themeData.Name)
							themeData.Id = newId
							pcall(function()
								self:SaveCustomTheme(themeData)
								if isfile(file) then
									delfile(file)
								end
							end)
						end
						table.insert(out, themeData)
					end
				end
			end
		end
		return out
	end

	function InterfaceManager:DeleteCustomTheme(id)
		local path = self.Folder .. "/Theme/" .. sanitizeFileName(id) .. ".theme"
		if isfile(path) then
			delfile(path)
		end
	end

	function InterfaceManager:SaveSettings()
		writefile(self.Folder .. "/options.json", httpService:JSONEncode(InterfaceManager.Settings))
	end

	function InterfaceManager:LoadSettings()
		local customThemes = self:LoadCustomThemes()

		local activeCustomName = nil
		local optionsPath = self.Folder .. "/options.json"
		if isfile(optionsPath) then
			local data = readfile(optionsPath)
			local success, decoded = pcall(httpService.JSONDecode, httpService, data)
			if success then
				for i, v in next, decoded do
					InterfaceManager.Settings[i] = v
				end
				activeCustomName = decoded.ActiveCustomTheme
			end
		end

		if activeCustomName then
			local matchedById = nil
			local matchedByNameCount = 0
			local matchedByName = nil

			for _, themeData in ipairs(customThemes) do
				if themeData.Id == activeCustomName then
					matchedById = themeData
				elseif themeData.Name == activeCustomName then
					matchedByNameCount = matchedByNameCount + 1
					matchedByName = themeData
				end
			end

			local resolved = matchedById
			if not resolved and matchedByNameCount == 1 then
				resolved = matchedByName
				InterfaceManager.Settings.ActiveCustomTheme = resolved.Id
				pcall(function() self:SaveSettings() end)
			end

			if resolved then
				Library.CustomThemeData = resolved
				Library.Theme = resolved.Name
			end
		end

		return customThemes
	end

	function InterfaceManager:BuildInterfaceSection(tab)
		assert(self.Library, "Must set InterfaceManager.Library")
		local library = self.Library
		local settings = InterfaceManager.Settings

		local loadedCustomThemes = InterfaceManager:LoadSettings()

		if type(settings.Transparency) == "boolean" then
			settings.Transparency = settings.Transparency and 35 or 0
		end
		settings.Transparency = math.clamp(tonumber(settings.Transparency) or 35, 0, 100)

		if settings.ActiveCustomTheme and Library.CustomThemeData then
			library:SetTheme(Library.CustomThemeData)
		else
			library:SetTheme(settings.Theme)
		end

		settings.Font = settings.Font or Library.Font
		library:SetFont(settings.Font)

		library:ToggleUserInfo(settings.ShowUserInfo)
		library:ToggleBackground(settings.DisableBackground)

		if settings.KeepWindowInsideFrame == nil then
			settings.KeepWindowInsideFrame = true
		end
		library:ToggleKeepWindowInsideFrame(settings.KeepWindowInsideFrame)

		local section = tab:AddSection("Appearance")

		local New = Creator.New

		local themeGradients = {
			Dark = { Color3.fromRGB(95,  95,  95),  Color3.fromRGB(60,  60,  60)  },
			Darker = { Color3.fromRGB(30,  30,  30),  Color3.fromRGB(12,  12,  12)  },
			Light = { Color3.fromRGB(220, 220, 220), Color3.fromRGB(180, 180, 180) },
			Aqua = { Color3.fromRGB(60,  140, 140), Color3.fromRGB(30,  70,  70)  },
			Amethyst = { Color3.fromRGB(85,  57,  139), Color3.fromRGB(40,  25,  65)  },
			Rose = { Color3.fromRGB(190, 60,  135), Color3.fromRGB(150, 45,  65)  },
			["Crimson Noir"] = { Color3.fromRGB(197, 3, 55), Color3.fromRGB(5, 5, 18)    },
			Gold = { Color3.fromRGB(255, 198, 41),  Color3.fromRGB(160, 120, 24)  },
		}

		local pickerWrapper = New("Frame", {
			Name = "ThemePickerWrapper",
			Size = UDim2.new(1, 0, 0, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 0.89,
			BackgroundColor3 = Color3.fromRGB(130, 130, 130),
			LayoutOrder = 1,
			Parent = section.Container,
			ThemeTag = {
				BackgroundColor3 = "Element",
				BackgroundTransparency = "ElementTransparency",
			},
		}, {
			New("UICorner", { CornerRadius = UDim.new(0, 4) }),
			New("UIStroke", {
				Transparency = 0.5,
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				ThemeTag = { Color = "ElementBorder" },
			}),
		})

		New("ImageLabel", {
			Image = "rbxassetid://86350350950064",
			Size = UDim2.fromOffset(16, 16),
			Position = UDim2.fromOffset(10, 9),
			BackgroundTransparency = 1,
			ZIndex = 2,
			ThemeTag = { ImageColor3 = "Text" },
			Parent = pickerWrapper,
		})

		New("TextLabel", {
			Text = "Theme",
			FontFace = Font.new(Library.Font, Enum.FontWeight.Medium, Enum.FontStyle.Normal),
			TextSize = 13,
			TextXAlignment = Enum.TextXAlignment.Left,
			Size = UDim2.new(1, -40, 0, 14),
			Position = UDim2.fromOffset(32, 10),
			BackgroundTransparency = 1,
			ThemeTag = { TextColor3 = "Text" },
			Parent = pickerWrapper,
		})

		New("TextLabel", {
			Text = "Changes the interface theme.",
			FontFace = Font.new(Library.Font),
			TextSize = 12,
			TextXAlignment = Enum.TextXAlignment.Left,
			Size = UDim2.new(1, -40, 0, 14),
			Position = UDim2.fromOffset(32, 26),
			BackgroundTransparency = 1,
			ThemeTag = { TextColor3 = "SubText" },
			Parent = pickerWrapper,
		})

		local scrollFrame = New("ScrollingFrame", {
			Name = "ThemeCardScroll",
			Size = UDim2.new(1, -20, 0, 92),
			Position = UDim2.fromOffset(10, 46),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ScrollBarThickness = 0,
			ScrollingDirection = Enum.ScrollingDirection.X,
			CanvasSize = UDim2.fromScale(0, 0),
			AutomaticCanvasSize = Enum.AutomaticSize.X,
			Parent = pickerWrapper,
		}, {
			New("UIListLayout", {
				FillDirection = Enum.FillDirection.Horizontal,
				Padding = UDim.new(0, 8),
				SortOrder = Enum.SortOrder.LayoutOrder,
				VerticalAlignment = Enum.VerticalAlignment.Center,
			}),
			New("UIPadding", {
				PaddingTop = UDim.new(0, 4),
				PaddingBottom = UDim.new(0, 8),
				PaddingLeft = UDim.new(0, 2),
				PaddingRight = UDim.new(0, 2),
			}),
		})

		local themeCards = {}
		local customThemeCards = {}
		local currentSelectedName = settings.ActiveCustomTheme or settings.Theme

		local function setSelectedCard(selectedName)
			for themeName, cardData in pairs(themeCards) do
				local isSelected = themeName == selectedName
				cardData.stroke.Transparency = isSelected and 0.1 or 0.7
				cardData.stroke.Color = isSelected
					and Creator.GetThemeProperty("Accent")
					or Color3.fromRGB(70, 70, 70)
				cardData.checkBadge.Visible = isSelected
			end
			for themeName, cardData in pairs(customThemeCards) do
				local isSelected = themeName == selectedName
				cardData.stroke.Transparency = isSelected and 0.1 or 0.7
				cardData.stroke.Color = isSelected
					and Creator.GetThemeProperty("Accent")
					or Color3.fromRGB(70, 70, 70)
				cardData.checkBadge.Visible = isSelected
			end
		end

		local function addCustomThemeCard(themeData, layoutOrder)
			local gradColors = themeData.__cardGradient or { Color3.fromRGB(50,50,50), Color3.fromRGB(20,20,20) }
			local colorA, colorB = gradColors[1], gradColors[2]
			local themeName = themeData.Name
			local themeId = themeData.Id

			local card = New("Frame", {
				Name = "ThemeCard_Custom_" .. themeId,
				Size = UDim2.fromOffset(72, 72),
				BackgroundColor3 = colorA,
				BorderSizePixel = 0,
				LayoutOrder = layoutOrder or 9999,
				Parent = scrollFrame,
				ClipsDescendants = true,
			}, {
				New("UICorner", { CornerRadius = UDim.new(0, 8) }),
				New("UIGradient", {
					Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, colorA),
						ColorSequenceKeypoint.new(1, colorB),
					}),
					Rotation = 135,
				}),
			})

			New("TextLabel", {
				Text = themeName,
				FontFace = Font.new(Library.Font, Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
				TextSize = 9,
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextStrokeTransparency = 0.4,
				TextStrokeColor3 = Color3.fromRGB(0, 0, 0),
				TextXAlignment = Enum.TextXAlignment.Center,
				Size = UDim2.new(1, -4, 0, 14),
				Position = UDim2.new(0, 2, 1, -16),
				BackgroundTransparency = 1,
				ZIndex = 3,
				Parent = card,
			})

			local stroke = New("UIStroke", {
				Thickness = 2,
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Color = Color3.fromRGB(70, 70, 70),
				Transparency = 0.7,
				Parent = card,
			})

			local checkBadge = New("Frame", {
				Size = UDim2.fromOffset(18, 18),
				Position = UDim2.fromOffset(5, 5),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				ZIndex = 4,
				Visible = false,
				Parent = card,
			}, {
				New("UICorner", { CornerRadius = UDim.new(1, 0) }),
			})

			New("ImageLabel", {
				Size = UDim2.fromOffset(10, 10),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundTransparency = 1,
				Image = "rbxassetid://93898873302694",
				ImageColor3 = Color3.fromRGB(20, 20, 20),
				ZIndex = 5,
				Parent = checkBadge,
			})

			customThemeCards[themeId] = {
				card = card,
				stroke = stroke,
				checkBadge = checkBadge,
				themeData = themeData,
			}

			local hitBox = New("TextButton", {
				Size = UDim2.fromScale(1, 1),
				BackgroundTransparency = 1,
				Text = "",
				ZIndex = 6,
				Parent = card,
			})

			Creator.AddSignal(hitBox.MouseEnter, function()
				if currentSelectedName ~= themeId then
					stroke.Transparency = 0.4
				end
			end)
			Creator.AddSignal(hitBox.MouseLeave, function()
				if currentSelectedName ~= themeId then
					stroke.Transparency = 0.7
				end
			end)
			Creator.AddSignal(hitBox.MouseButton1Click, function()
				library:SetTheme(themeData)
				currentSelectedName = themeId
				settings.Theme = themeName
				settings.ActiveCustomTheme = themeId
				InterfaceManager:SaveSettings()
				setSelectedCard(themeId)
			end)
		end

		local themeTargetDropdown

		local themeTargetLabelToId = {}

		local function getCustomThemeNames()
			local entries = {}
			for id, cardData in pairs(customThemeCards) do
				table.insert(entries, { name = cardData.themeData.Name, id = id })
			end
			table.sort(entries, function(a, b) return a.name < b.name end)

			themeTargetLabelToId = {}
			local labels = {}
			local seen = {}
			for _, entry in ipairs(entries) do
				local label = entry.name
				if seen[entry.name] then
					seen[entry.name] = seen[entry.name] + 1
					label = entry.name .. " (" .. seen[entry.name] .. ")"
				else
					seen[entry.name] = 1
				end
				table.insert(labels, label)
				themeTargetLabelToId[label] = entry.id
			end
			return labels
		end

		local function refreshThemeTargetDropdown()
			if themeTargetDropdown then
				themeTargetDropdown:SetValues(getCustomThemeNames())
			end
		end

		local function resolveThemeName(candidateName)
			if candidateName and tostring(candidateName):match("%S") then
				return tostring(candidateName)
			end

			local nameOpt = Library.Options["PanelThemeName"]
			if nameOpt and nameOpt.Value and tostring(nameOpt.Value):match("%S") then
				return tostring(nameOpt.Value)
			end

			return nil
		end

		local function getSuggestedThemeName()
			if settings.ActiveCustomTheme then
				for _, existingTheme in ipairs(loadedCustomThemes) do
					if existingTheme.Id == settings.ActiveCustomTheme then
						return existingTheme.Name
					end
				end
			end

			return settings.Theme or "Dark"
		end

		local function persistCustomTheme(themeData, allowOverwrite, existingId)
			local finalName = themeData.Name
			local themeId = existingId or themeData.Id

			if not (allowOverwrite and themeId) then
				themeId = InterfaceManager:GenerateThemeId(finalName)
			end
			themeData.Id = themeId

			InterfaceManager:SaveCustomTheme(themeData)

			local existingCard = customThemeCards[themeId]
			local layoutOrder = existingCard and existingCard.card.LayoutOrder or (1000 + #loadedCustomThemes)
			if existingCard then
				existingCard.card:Destroy()
				customThemeCards[themeId] = nil
			end
			addCustomThemeCard(themeData, layoutOrder)

			local replaced = false
			for i, existingTheme in ipairs(loadedCustomThemes) do
				if existingTheme.Id == themeId then
					loadedCustomThemes[i] = themeData
					replaced = true
					break
				end
			end
			if not replaced then
				table.insert(loadedCustomThemes, themeData)
			end

			library:SetTheme(themeData)
			currentSelectedName = themeId
			settings.Theme = finalName
			settings.ActiveCustomTheme = themeId
			InterfaceManager:SaveSettings()
			setSelectedCard(themeId)
			refreshThemeTargetDropdown()

			return themeData
		end

		local function findExistingCustomThemeId(name)
			for id, cardData in pairs(customThemeCards) do
				if cardData.themeData.Name == name then
					return id
				end
			end
			return nil
		end

		local function confirmAndPersistTheme(themeData, successMessage)
			local existingId = findExistingCustomThemeId(themeData.Name)

			if not existingId then
				persistCustomTheme(themeData, false)
				library:Notify({ Title = "Theme", Content = "Custom", SubContent = successMessage, Duration = 5 })
				return
			end

			library.Window:Dialog({
				Title = "Theme Name Already Exists",
				Content = "A theme named '" .. themeData.Name .. "' already exists. What would you like to do?",
				Buttons = {
					{ Title = "Cancel", Callback = function() end },
					{ Title = "Duplicate", Callback = function()
						persistCustomTheme(themeData, false)
						library:Notify({ Title = "Theme", Content = "Custom", SubContent = successMessage, Duration = 5 })
					end },
					{ Title = "Overwrite", Callback = function()
						persistCustomTheme(themeData, true, existingId)
						library:Notify({ Title = "Theme", Content = "Custom", SubContent = successMessage, Duration = 5 })
					end },
				},
			})
		end

		local addThemeCard = New("Frame", {
			Name = "ThemeCard_AddCustom",
			Size = UDim2.fromOffset(72, 72),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			LayoutOrder = 0,
			Parent = scrollFrame,
			ClipsDescendants = true,
			ThemeTag = {
				BackgroundColor3 = "Element",
				BackgroundTransparency = "ElementTransparency",
			},
		}, {
			New("UICorner", { CornerRadius = UDim.new(0, 8) }),
			New("UIStroke", {
				Thickness = 1,
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Transparency = 0.5,
				ThemeTag = { Color = "DialogBorder" },
			}),
		})

		local addThemeIcon = Library:GetIcon("plus")
		local addThemeImage = New("ImageLabel", {
			Size = UDim2.fromOffset(20, 20),
			Position = UDim2.fromScale(0.5, 0.44),
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundTransparency = 1,
			ZIndex = 3,
			Parent = addThemeCard,
			ThemeTag = { ImageColor3 = "SubText" },
		})

		if type(addThemeIcon) == "table" then
			addThemeImage.Image = addThemeIcon.Image
			addThemeImage.ImageRectOffset = addThemeIcon.ImageRectOffset
			addThemeImage.ImageRectSize = addThemeIcon.ImageRectSize
		else
			addThemeImage.Image = addThemeIcon or "rbxassetid://111774323017047"
		end

		New("TextLabel", {
			Text = "Custom",
			FontFace = Font.new(Library.Font, Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
			TextSize = 9,
			TextXAlignment = Enum.TextXAlignment.Center,
			Size = UDim2.new(1, -4, 0, 14),
			Position = UDim2.new(0, 2, 1, -16),
			BackgroundTransparency = 1,
			ZIndex = 3,
			Parent = addThemeCard,
			ThemeTag = { TextColor3 = "SubText" },
		})

		local addThemeHitBox = New("TextButton", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			Text = "",
			ZIndex = 6,
			Parent = addThemeCard,
		})

		Creator.AddSignal(addThemeHitBox.MouseEnter, function()
			addThemeCard.UIStroke.Transparency = 0.2
		end)
		Creator.AddSignal(addThemeHitBox.MouseLeave, function()
			addThemeCard.UIStroke.Transparency = 0.5
		end)
		Creator.AddSignal(addThemeHitBox.MouseButton1Click, function()
			local Panel
			local suggestedName = getSuggestedThemeName()

			Panel = library.Window:SidePanel({
				Title = "Custom Theme",
				Description = "Create or import a custom theme.",
				Side = "Right",
				Width = 320,
				Buttons = {
					{ Title = "Cancel", CloseOnClick = true, Callback = function() end },
					{ Title = "Import", CloseOnClick = false, Callback = function()
						Panel:PromptImport({
							Title = "Paste theme code",
							Placeholder = '{"Accent":{"__type":"Color3","value":"#FFFFFF"},"__meta":{"Name":"Theme"}}',
							Callback = function(rawText)
								if not rawText or rawText:gsub("%s", "") == "" then
									library:Notify({ Title = "Theme", Content = "Import", SubContent = "The pasted text is empty.", Duration = 4 })
									return
								end

									local parsed = ThemeManager.parseImportString(rawText)
								if not parsed then
									library:Notify({ Title = "Theme", Content = "Import", SubContent = "Invalid theme format.", Duration = 4 })
									return
								end

								local themeName = resolveThemeName(parsed.Name)
								if not themeName then
									library:Notify({ Title = "Theme", Content = "Import", SubContent = "This theme has no name. Type one in Theme Name first.", Duration = 6 })
									return
								end
								parsed.Name = themeName

								if Library.Options["PanelThemeName"] then
									Library.Options["PanelThemeName"]:SetValue(themeName)
								end

								for _, field in ipairs(colorFieldDefs) do
									local optionKey = "Panel" .. field.key
									if parsed[field.key] ~= nil and Library.Options[optionKey] then
										Library.Options[optionKey]:SetValueRGB(parsed[field.key])
									end
								end

								if parsed.AcrylicGradient and Library.Options["PanelAcrylicGradient"] then
									Library.Options["PanelAcrylicGradient"]:SetValueSequence(parsed.AcrylicGradient)
								end
								if parsed.AcrylicGradientRotation and Library.Options["PanelAcrylicGradient"] then
									Library.Options["PanelAcrylicGradient"]:SetRotation(parsed.AcrylicGradientRotation)
								end

								if parsed.Background ~= nil and Library.Options["PanelBackground"] then
									Library.Options["PanelBackground"]:SetValue(parsed.Background)
								end
								if parsed.BackgroundTransparency and Library.Options["PanelBackgroundTransparency"] then
									Library.Options["PanelBackgroundTransparency"]:SetValue(math.floor(parsed.BackgroundTransparency * 100))
								end
								if parsed.AcrylicNoise and Library.Options["PanelAcrylicNoise"] then
									Library.Options["PanelAcrylicNoise"]:SetValue(math.floor(parsed.AcrylicNoise * 100))
								end
								if parsed.ElementTransparency and Library.Options["PanelElementTransparency"] then
									Library.Options["PanelElementTransparency"]:SetValue(math.floor(parsed.ElementTransparency * 100))
								end
								if parsed.HoverChange and Library.Options["PanelHoverChange"] then
									Library.Options["PanelHoverChange"]:SetValue(math.floor(parsed.HoverChange * 100))
								end

								confirmAndPersistTheme(parsed, "Theme '" .. parsed.Name .. "' imported and saved.")
							end,
						})
					end },
					{ Title = "Confirm", CloseOnClick = true, Callback = function()
						local nameOpt = Library.Options["PanelThemeName"]
						local themeName = resolveThemeName(nameOpt and nameOpt.Value)
						if not themeName then
							library:Notify({ Title = "Theme", Content = "Custom", SubContent = "Enter a theme name first.", Duration = 5 })
							return
						end

						local optionValues = {}
						for key, option in pairs(Library.Options) do
							if key:sub(1, 5) == "Panel" then
								optionValues[key] = option.Value
							end
						end

						local finalTheme = ThemeManager.buildFromCurrentOptions(themeName, optionValues)
						confirmAndPersistTheme(finalTheme, "Theme '" .. finalTheme.Name .. "' saved.")
					end },
				},
			})

			Panel:AddInput("PanelThemeName", {
				Title = "Theme Name",
				Description = "Name of the custom theme.",
				Default = suggestedName,
				Placeholder = suggestedName,
				Finished = true,
				Callback = function() end,
			})

			for _, field in ipairs(colorFieldDefs) do
				Panel:AddColorpicker("Panel" .. field.key, {
					Title = field.title,
					Description = field.description,
					Default = Creator.GetThemeProperty(field.key),
					Callback = function() end,
				})
				if field.key == "AcrylicBorder" then
					Panel:AddGradientPicker("PanelAcrylicGradient", {
						Title = "Acrylic Gradient",
						Description = "Start and end color of the acrylic background gradient. Rotation controls its direction.",
						Default = Creator.GetThemeProperty("AcrylicGradient"),
						Rotation = Creator.GetThemeProperty("AcrylicGradientRotation"),
						Callback = function() end,
					})
				end
			end

			Panel:AddInput("PanelBackground", {
				Title = "Background Image",
				Description = "Background image asset or URL. Leave empty for none.",
				Placeholder = "rbxassetid://0",
				Finished = true,
				Default = Creator.GetThemeProperty("Background"),
				Callback = function() end,
			})

			Panel:AddSlider("PanelBackgroundTransparency", {
				Title = "Background Transparency",
				Description = "Transparency of the background image (0-100).",
				Min = 0,
				Max = 100,
				Default = math.floor((Creator.GetThemeProperty("BackgroundTransparency") or 0) * 100),
				Rounding = 0,
				Callback = function() end,
			})

			Panel:AddSlider("PanelAcrylicNoise", {
				Title = "Acrylic Noise",
				Description = "Noise intensity of the acrylic background (0-100).",
				Min = 0,
				Max = 100,
				Default = math.floor((Creator.GetThemeProperty("AcrylicNoise") or 0) * 100),
				Rounding = 0,
				Callback = function() end,
			})

			Panel:AddSlider("PanelElementTransparency", {
				Title = "Element Transparency",
				Description = "Transparency of element backgrounds (0-100).",
				Min = 0,
				Max = 100,
				Default = math.floor((Creator.GetThemeProperty("ElementTransparency") or 0.87) * 100),
				Rounding = 0,
				Callback = function() end,
			})

			Panel:AddSlider("PanelHoverChange", {
				Title = "Hover Intensity",
				Description = "Strength of the hover effect (0-100).",
				Min = 0,
				Max = 100,
				Default = math.floor((Creator.GetThemeProperty("HoverChange") or 0.07) * 100),
				Rounding = 0,
				Callback = function() end,
			})

			Panel:AddButton({
				Title = "Copy Theme Data",
				Description = "Copies this theme so it can be pasted into Import, or shared with others.",
				Icon = "copy",
				Callback = function()
					local nameOpt = Library.Options["PanelThemeName"]
					local shareName = resolveThemeName(nameOpt and nameOpt.Value)
					if not shareName then
						library:Notify({ Title = "Theme", Content = "Copy", SubContent = "Enter a theme name first.", Duration = 5 })
						return
					end

					local optionValues = {}
					for key, option in pairs(Library.Options) do
						if key:sub(1, 5) == "Panel" then
							optionValues[key] = option.Value
						end
					end

					local shareTheme = ThemeManager.buildFromCurrentOptions(shareName, optionValues)
					local exportString = ThemeManager.serializeTheme(shareTheme)

					if setclipboard then
						setclipboard(exportString)
						library:Notify({ Title = "Theme", Content = "Copy", SubContent = "Theme data copied. Paste it into Import to share.", Duration = 5 })
					else
						library:Notify({ Title = "Theme", Content = "Copy", SubContent = "Your executor does not support setclipboard.", Duration = 5 })
					end
				end,
			})

			themeTargetDropdown = Panel:AddDropdown("PanelCustomThemeTarget", {
				Title = "Custom Theme",
				Description = "Pick an existing custom theme to delete or overwrite.",
				Values = getCustomThemeNames(),
				Multi = false,
				AllowNull = true,
				Callback = function() end,
			})

			Panel:AddButton({
				Title = "Delete Custom Theme",
				Description = "Deletes the custom theme selected in the dropdown above.",
				Icon = "trash-2",
				Callback = function()
					local targetOpt = Library.Options["PanelCustomThemeTarget"]
					local targetLabel = targetOpt and targetOpt.Value
					if not targetLabel or targetLabel == "" then
						library:Notify({ Title = "Theme", Content = "Delete", SubContent = "Select a custom theme to delete first.", Duration = 5 })
						return
					end

					local targetId = themeTargetLabelToId[targetLabel]
					if not targetId or not customThemeCards[targetId] then
						library:Notify({ Title = "Theme", Content = "Delete", SubContent = "Could not find that custom theme.", Duration = 5 })
						return
					end

					local targetName = customThemeCards[targetId].themeData.Name

					library.Window:Dialog({
						Title = "Delete Theme?",
						Content = "This permanently deletes '" .. targetName .. "'. This can't be undone.",
						Buttons = {
							{ Title = "Cancel", Callback = function() end },
							{ Title = "Delete", Callback = function()
								InterfaceManager:DeleteCustomTheme(targetId)

								local existingCard = customThemeCards[targetId]
								if existingCard then
									existingCard.card:Destroy()
									customThemeCards[targetId] = nil
								end

								for i, existingTheme in ipairs(loadedCustomThemes) do
									if existingTheme.Id == targetId then
										table.remove(loadedCustomThemes, i)
										break
									end
								end

								if settings.ActiveCustomTheme == targetId then
									settings.ActiveCustomTheme = nil
									settings.Theme = "Dark"
									Library.CustomThemeData = nil
									library:SetTheme("Dark")
									currentSelectedName = "Dark"
									InterfaceManager:SaveSettings()
									setSelectedCard("Dark")
								end

								refreshThemeTargetDropdown()
								targetOpt:SetValue(nil)

								library:Notify({ Title = "Theme", Content = "Delete", SubContent = "Theme '" .. targetName .. "' deleted.", Duration = 5 })
							end },
						},
					})
				end,
			})

			Panel:AddButton({
				Title = "Overwrite Selected Theme",
				Description = "Replaces the selected custom theme with the values currently set in this panel.",
				Icon = "save",
				Callback = function()
					local targetOpt = Library.Options["PanelCustomThemeTarget"]
					local targetLabel = targetOpt and targetOpt.Value
					if not targetLabel or targetLabel == "" then
						library:Notify({ Title = "Theme", Content = "Overwrite", SubContent = "Select a custom theme to overwrite first.", Duration = 5 })
						return
					end

					local targetId = themeTargetLabelToId[targetLabel]
					if not targetId or not customThemeCards[targetId] then
						library:Notify({ Title = "Theme", Content = "Overwrite", SubContent = "Could not find that custom theme.", Duration = 5 })
						return
					end

					local targetName = customThemeCards[targetId].themeData.Name

					library.Window:Dialog({
						Title = "Overwrite Theme?",
						Content = "This replaces '" .. targetName .. "' with the values currently set in this panel. This can't be undone.",
						Buttons = {
							{ Title = "Cancel", Callback = function() end },
							{ Title = "Overwrite", Callback = function()
								local optionValues = {}
								for key, option in pairs(Library.Options) do
									if key:sub(1, 5) == "Panel" then
										optionValues[key] = option.Value
									end
								end

								local overwrittenTheme = ThemeManager.buildFromCurrentOptions(targetName, optionValues)
								persistCustomTheme(overwrittenTheme, true, targetId)

								library:Notify({ Title = "Theme", Content = "Overwrite", SubContent = "Theme '" .. targetName .. "' updated.", Duration = 5 })
							end },
						},
					})
				end,
			})
		end)

		for idx, themeName in ipairs(library.Themes) do
			local colors = themeGradients[themeName] or { Color3.fromRGB(50, 50, 50), Color3.fromRGB(20, 20, 20) }
			local colorA, colorB = colors[1], colors[2]

			local card = New("Frame", {
				Name = "ThemeCard_" .. themeName,
				Size = UDim2.fromOffset(72, 72),
				BackgroundColor3 = colorA,
				BorderSizePixel = 0,
				LayoutOrder = idx,
				Parent = scrollFrame,
				ClipsDescendants = true,
			}, {
				New("UICorner", { CornerRadius = UDim.new(0, 8) }),
				New("UIGradient", {
					Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, colorA),
						ColorSequenceKeypoint.new(1, colorB),
					}),
					Rotation = 135,
				}),
			})

			New("TextLabel", {
				Text = themeName,
				FontFace = Font.new(Library.Font, Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
				TextSize = 9,
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextStrokeTransparency = 0.4,
				TextStrokeColor3 = Color3.fromRGB(0, 0, 0),
				TextXAlignment = Enum.TextXAlignment.Center,
				Size = UDim2.new(1, -4, 0, 14),
				Position = UDim2.new(0, 2, 1, -16),
				BackgroundTransparency = 1,
				ZIndex = 3,
				Parent = card,
			})

			local stroke = New("UIStroke", {
				Thickness = 2,
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Color = Color3.fromRGB(70, 70, 70),
				Transparency = 0.7,
				Parent = card,
			})

			local checkBadge = New("Frame", {
				Size = UDim2.fromOffset(18, 18),
				Position = UDim2.fromOffset(5, 5),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				ZIndex = 4,
				Visible = false,
				Parent = card,
			}, {
				New("UICorner", { CornerRadius = UDim.new(1, 0) }),
			})

			New("ImageLabel", {
				Size = UDim2.fromOffset(10, 10),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundTransparency = 1,
				Image = "rbxassetid://93898873302694",
				ImageColor3 = Color3.fromRGB(20, 20, 20),
				ZIndex = 5,
				Parent = checkBadge,
			})

			themeCards[themeName] = {
				card = card,
				stroke = stroke,
				checkBadge = checkBadge,
			}

			local hitBox = New("TextButton", {
				Size = UDim2.fromScale(1, 1),
				BackgroundTransparency = 1,
				Text = "",
				ZIndex = 6,
				Parent = card,
			})

			Creator.AddSignal(hitBox.MouseEnter, function()
				if currentSelectedName ~= themeName then
					stroke.Transparency = 0.4
				end
			end)
			Creator.AddSignal(hitBox.MouseLeave, function()
				if currentSelectedName ~= themeName then
					stroke.Transparency = 0.7
				end
			end)
			Creator.AddSignal(hitBox.MouseButton1Click, function()
				library:SetTheme(themeName)
				currentSelectedName = themeName
				settings.Theme = themeName
				settings.ActiveCustomTheme = nil
				InterfaceManager:SaveSettings()
				setSelectedCard(themeName)
			end)
		end

		for cIdx, themeData in ipairs(loadedCustomThemes) do
			addCustomThemeCard(themeData, 1000 + cIdx)
		end

		setSelectedCard(currentSelectedName)

		local themePickerProxy = {
			Type = "Dropdown",
			Value = currentSelectedName,
		}
		function themePickerProxy:SetValue(value)
			if table.find(library.Themes, value) then
				library:SetTheme(value)
				currentSelectedName = value
				settings.Theme = value
				settings.ActiveCustomTheme = nil
				InterfaceManager:SaveSettings()
				setSelectedCard(value)
				self.Value = value
			end
		end
		Library.Options["InterfaceTheme"] = themePickerProxy

		section:AddToggle("KeepWindowInsideFrameToggle", {
			Title = "Keep Window Inside Frame",
			Description = "Prevents the window from being dragged or resized outside its parent frame.",
			Default = settings.KeepWindowInsideFrame,
			LayoutOrder = 6,
			Icon = "rbxassetid://81973586053257",
			Callback = function(value)
				library:ToggleKeepWindowInsideFrame(value)
				settings.KeepWindowInsideFrame = value
				InterfaceManager:SaveSettings()
			end,
		})

		local uiFonts = {
			{ name = "Gotham", asset = "rbxasset://fonts/families/GothamSSm.json", weight = Enum.FontWeight.Medium, label = "Ab" },
			{ name = "Jura", asset = "rbxasset://fonts/families/Jura.json", weight = Enum.FontWeight.SemiBold, label = "Cd" },
			{ name = "Ubuntu", asset = "rbxasset://fonts/families/Ubuntu.json", weight = Enum.FontWeight.Medium, label = "Ef" },
			{ name = "Sarpanch", asset = "rbxasset://fonts/families/Sarpanch.json", weight = Enum.FontWeight.Regular, label = "Gh" },
			{ name = "Nunito", asset = "rbxasset://fonts/families/Nunito.json", weight = Enum.FontWeight.SemiBold, label = "Ij" },
			{ name = "Oswald", asset = "rbxasset://fonts/families/Oswald.json", weight = Enum.FontWeight.Medium, label = "Kl" },
			{ name = "Balthazar", asset = "rbxasset://fonts/families/Balthazar.json", weight = Enum.FontWeight.Regular, label = "Mn" },
			{ name = "Arimo", asset = "rbxasset://fonts/families/Arimo.json", weight = Enum.FontWeight.Medium, label = "Op" },
			{ name = "Builder Sans", asset = "rbxasset://fonts/families/BuilderSans.json", weight = Enum.FontWeight.SemiBold, label = "Qr" },
			{ name = "Silkscreen", asset = "rbxassetid://12187371840", weight = Enum.FontWeight.Regular, label = "St" },
		}

		local fontWrapper = New("Frame", {
			Name = "FontPickerWrapper",
			Size = UDim2.new(1, 0, 0, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 0.89,
			BackgroundColor3 = Color3.fromRGB(130, 130, 130),
			LayoutOrder = 7,
			Parent = section.Container,
			ThemeTag = {
				BackgroundColor3 = "Element",
				BackgroundTransparency = "ElementTransparency",
			},
		}, {
			New("UICorner", { CornerRadius = UDim.new(0, 4) }),
			New("UIStroke", {
				Transparency = 0.5,
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				ThemeTag = { Color = "ElementBorder" },
			}),
		})

		New("ImageLabel", {
			Image = "rbxassetid://133543553793564",
			Size = UDim2.fromOffset(16, 16),
			Position = UDim2.fromOffset(10, 9),
			BackgroundTransparency = 1,
			ZIndex = 2,
			ThemeTag = { ImageColor3 = "Text" },
			Parent = fontWrapper,
		})

		New("TextLabel", {
			Text = "UI Font",
			FontFace = Font.new(Library.Font, Enum.FontWeight.Medium, Enum.FontStyle.Normal),
			TextSize = 13,
			TextXAlignment = Enum.TextXAlignment.Left,
			Size = UDim2.new(1, -40, 0, 14),
			Position = UDim2.fromOffset(32, 10),
			BackgroundTransparency = 1,
			ThemeTag = { TextColor3 = "Text" },
			Parent = fontWrapper,
		})

		New("TextLabel", {
			Text = "Changes the font used across all UI.",
			FontFace = Font.new(Library.Font),
			TextSize = 12,
			TextXAlignment = Enum.TextXAlignment.Left,
			Size = UDim2.new(1, -40, 0, 14),
			Position = UDim2.fromOffset(32, 26),
			BackgroundTransparency = 1,
			ThemeTag = { TextColor3 = "SubText" },
			Parent = fontWrapper,
		})

		local fontScrollFrame = New("ScrollingFrame", {
			Name = "FontCardScroll",
			Size = UDim2.new(1, -20, 0, 92),
			Position = UDim2.fromOffset(10, 46),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ScrollBarThickness = 0,
			ScrollingDirection = Enum.ScrollingDirection.X,
			CanvasSize = UDim2.fromScale(0, 0),
			AutomaticCanvasSize = Enum.AutomaticSize.X,
			Parent = fontWrapper,
		}, {
			New("UIListLayout", {
				FillDirection = Enum.FillDirection.Horizontal,
				Padding = UDim.new(0, 8),
				SortOrder = Enum.SortOrder.LayoutOrder,
				VerticalAlignment = Enum.VerticalAlignment.Center,
			}),
			New("UIPadding", {
				PaddingTop = UDim.new(0, 4),
				PaddingBottom = UDim.new(0, 8),
				PaddingLeft = UDim.new(0, 2),
				PaddingRight = UDim.new(0, 2),
			}),
		})

		local fontCards = {}

		local function setSelectedFont(selectedAsset)
			for asset, cardData in pairs(fontCards) do
				local isSelected = asset == selectedAsset
				cardData.stroke.Transparency = isSelected and 0.1 or 0.7
				cardData.stroke.Color = isSelected
					and Creator.GetThemeProperty("Accent")
					or Color3.fromRGB(70, 70, 70)
				cardData.checkBadge.Visible = isSelected
			end
		end

		for idx, fontData in ipairs(uiFonts) do
			local fontCard = New("Frame", {
				Name = "FontCard_" .. fontData.name,
				Size = UDim2.fromOffset(72, 72),
				BackgroundTransparency = 0.89,
				BackgroundColor3 = Color3.fromRGB(130, 130, 130),
				BorderSizePixel = 0,
				LayoutOrder = idx,
				Parent = fontScrollFrame,
				ClipsDescendants = true,
				ThemeTag = {
					BackgroundColor3 = "Element",
					BackgroundTransparency = "ElementTransparency",
				},
			}, {
				New("UICorner", { CornerRadius = UDim.new(0, 8) }),
			})

			New("TextLabel", {
				Text = fontData.label,
				FontFace = Font.new(fontData.asset, fontData.weight, Enum.FontStyle.Normal),
				IgnoreFontUpdate = true,
				TextSize = 26,
				TextColor3 = Color3.fromRGB(240, 240, 240),
				TextXAlignment = Enum.TextXAlignment.Center,
				TextYAlignment = Enum.TextYAlignment.Center,
				Size = UDim2.new(1, 0, 0, 44),
				Position = UDim2.fromOffset(0, 6),
				BackgroundTransparency = 1,
				ZIndex = 2,
				ThemeTag = { TextColor3 = "Text" },
				Parent = fontCard,
			})

			New("TextLabel", {
				Text = fontData.name,
				FontFace = Font.new(fontData.asset, Enum.FontWeight.Regular, Enum.FontStyle.Normal),
				IgnoreFontUpdate = true,
				TextSize = 9,
				TextColor3 = Color3.fromRGB(200, 200, 200),
				TextXAlignment = Enum.TextXAlignment.Center,
				Size = UDim2.new(1, -4, 0, 14),
				Position = UDim2.new(0, 2, 1, -16),
				BackgroundTransparency = 1,
				ZIndex = 2,
				ThemeTag = { TextColor3 = "SubText" },
				Parent = fontCard,
			})

			local fontStroke = New("UIStroke", {
				Thickness = 2,
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Color = Color3.fromRGB(70, 70, 70),
				Transparency = 0.7,
				Parent = fontCard,
			})

			local fontCheckBadge = New("Frame", {
				Size = UDim2.fromOffset(18, 18),
				Position = UDim2.fromOffset(5, 5),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				ZIndex = 4,
				Visible = false,
				Parent = fontCard,
			}, {
				New("UICorner", { CornerRadius = UDim.new(1, 0) }),
			})

			New("ImageLabel", {
				Size = UDim2.fromOffset(10, 10),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundTransparency = 1,
				Image = "rbxassetid://93898873302694",
				ImageColor3 = Color3.fromRGB(20, 20, 20),
				ZIndex = 5,
				Parent = fontCheckBadge,
			})

			fontCards[fontData.asset] = {
				card = fontCard,
				stroke = fontStroke,
				checkBadge = fontCheckBadge,
			}

			local fontHitBox = New("TextButton", {
				Size = UDim2.fromScale(1, 1),
				BackgroundTransparency = 1,
				Text = "",
				ZIndex = 6,
				Parent = fontCard,
			})

			Creator.AddSignal(fontHitBox.MouseEnter, function()
				if settings.Font ~= fontData.asset then
					fontStroke.Transparency = 0.4
				end
			end)
			Creator.AddSignal(fontHitBox.MouseLeave, function()
				if settings.Font ~= fontData.asset then
					fontStroke.Transparency = 0.7
				end
			end)
			Creator.AddSignal(fontHitBox.MouseButton1Click, function()
				library:SetFont(fontData.asset)
				settings.Font = fontData.asset
				InterfaceManager:SaveSettings()
				setSelectedFont(fontData.asset)
			end)
		end

		settings.Font = settings.Font or Library.Font
		setSelectedFont(settings.Font)

		Creator.OnThemeChanged(function()
			setSelectedCard(settings.Theme)
			setSelectedFont(settings.Font)
		end)

		if library.UseAcrylic then
			section:AddToggle("AcrylicToggle", {
				Title = "Acrylic",
				Description = "The blurred background requires graphic quality 8+",
				Default = settings.Acrylic,
				LayoutOrder = 2,
				Icon = "rbxassetid://81973586053257",
				Callback = function(value)
					library:ToggleAcrylic(value)
					settings.Acrylic = value
					InterfaceManager:SaveSettings()
				end,
			})
		end

		section:AddSlider("TransparencySlider", {
			Title = "Transparency",
			Description = "Adjusts the interface transparency.",
			Default = settings.Transparency,
			Min = 0,
			Max = 100,
			Rounding = 0,
			LayoutOrder = 3,
			Icon = "rbxassetid://100033680381365",
			Callback = function(value)
				library:SetTransparency(value / 100)
				settings.Transparency = value
				InterfaceManager:SaveSettings()
			end,
		})

		local menuKeybind = section:AddKeybind("MenuKeybind", { Title = "Minimize Bind", Default = settings.MenuKeybind, LayoutOrder = 4, Icon = "rbxassetid://121474456068237" })
		menuKeybind:OnChanged(function()
			settings.MenuKeybind = menuKeybind.Value
			InterfaceManager:SaveSettings()
		end)
		library.MinimizeKeybind = menuKeybind

		section:AddToggle("ShowUserInfoToggle", {
			Title = "Show User Info",
			Description = "Toggles the avatar and username block in the sidebar.",
			Default = settings.ShowUserInfo,
			LayoutOrder = 5,
			Icon = "rbxassetid://136220511671311",
			Callback = function(value)
				library:ToggleUserInfo(value)
				settings.ShowUserInfo = value
				InterfaceManager:SaveSettings()
			end,
		})

		section:AddToggle("DisableBackgroundToggle", {
			Title = "Disable Background",
			Description = "Hides the window background image.",
			Default = settings.DisableBackground,
			LayoutOrder = 8,
			Icon = "rbxassetid://81934811700938",
			Callback = function(value)
				library:ToggleBackground(value)
				settings.DisableBackground = value
				InterfaceManager:SaveSettings()
			end,
		})
	end
end

