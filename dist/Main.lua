-- hello world 
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local Camera = Workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()
local ProtectGui = protectgui or (syn and syn.protect_gui) or function() end

local Themes = {
	Names = {
		"Dark",
		"Darker",
		"Light",
		"Aqua",
		"Amethyst",
		"Rose",
		"Crimson Noir",
		"Gold",
	},

	Dark = {
	Name = "Dark",
	Accent = Color3.fromRGB(96, 205, 255),

	AcrylicMain = Color3.fromRGB(60, 60, 60),
	AcrylicBorder = Color3.fromRGB(90, 90, 90),
	AcrylicGradient = ColorSequence.new(Color3.fromRGB(40, 40, 40), Color3.fromRGB(40, 40, 40)),
	AcrylicGradientRotation = 90,
	AcrylicNoise = 0.9,
	Background = "",
	BackgroundTransparency = 0,

	TitleBarLine = Color3.fromRGB(75, 75, 75),
	Tab = Color3.fromRGB(120, 120, 120),

	Element = Color3.fromRGB(120, 120, 120),
	ElementBorder = Color3.fromRGB(35, 35, 35),
	InElementBorder = Color3.fromRGB(90, 90, 90),
	ElementTransparency = 0.87,

	ToggleSlider = Color3.fromRGB(120, 120, 120),
	ToggleToggled = Color3.fromRGB(0, 0, 0),

	SliderRail = Color3.fromRGB(120, 120, 120),

	DropdownFrame = Color3.fromRGB(160, 160, 160),
	DropdownHolder = Color3.fromRGB(45, 45, 45),
	DropdownBorder = Color3.fromRGB(35, 35, 35),
	DropdownOption = Color3.fromRGB(120, 120, 120),

	Keybind = Color3.fromRGB(120, 120, 120),

	Input = Color3.fromRGB(160, 160, 160),
	InputFocused = Color3.fromRGB(10, 10, 10),
	InputIndicator = Color3.fromRGB(150, 150, 150),

	Dialog = Color3.fromRGB(45, 45, 45),
	DialogHolder = Color3.fromRGB(35, 35, 35),
	DialogHolderLine = Color3.fromRGB(30, 30, 30),
	DialogButton = Color3.fromRGB(45, 45, 45),
	DialogButtonBorder = Color3.fromRGB(80, 80, 80),
	DialogBorder = Color3.fromRGB(70, 70, 70),
	DialogInput = Color3.fromRGB(55, 55, 55),
	DialogInputLine = Color3.fromRGB(160, 160, 160),

	ColorpickerDialog = Color3.fromRGB(45, 45, 45),
	ColorpickerDialogBorder = Color3.fromRGB(70, 70, 70),
	ColorpickerHolder = Color3.fromRGB(35, 35, 35),
	ColorpickerHolderLine = Color3.fromRGB(30, 30, 30),
	ColorpickerButton = Color3.fromRGB(45, 45, 45),
	ColorpickerButtonBorder = Color3.fromRGB(80, 80, 80),
	ColorpickerInput = Color3.fromRGB(55, 55, 55),
	ColorpickerInputLine = Color3.fromRGB(160, 160, 160),
	ColorpickerInputBorder = Color3.fromRGB(80, 80, 80),
	ColorpickerInputFocused = Color3.fromRGB(35, 35, 35),

	Text = Color3.fromRGB(240, 240, 240),
	SubText = Color3.fromRGB(170, 170, 170),
	Hover = Color3.fromRGB(120, 120, 120),
	HoverChange = 0.07,
},

	Darker = {
	Name = "Darker",
	Accent = Color3.fromRGB(72, 138, 182),

	AcrylicMain = Color3.fromRGB(30, 30, 30),
	AcrylicBorder = Color3.fromRGB(60, 60, 60),
	AcrylicGradient = ColorSequence.new(Color3.fromRGB(25, 25, 25), Color3.fromRGB(15, 15, 15)),
	AcrylicGradientRotation = 90,
	AcrylicNoise = 0.94,
	Background = "",
	BackgroundTransparency = 0,

	TitleBarLine = Color3.fromRGB(65, 65, 65),
	Tab = Color3.fromRGB(100, 100, 100),

	Element = Color3.fromRGB(70, 70, 70),
	ElementBorder = Color3.fromRGB(25, 25, 25),
	InElementBorder = Color3.fromRGB(55, 55, 55),
	ElementTransparency = 0.82,

	DropdownFrame = Color3.fromRGB(120, 120, 120),
	DropdownHolder = Color3.fromRGB(35, 35, 35),
	DropdownBorder = Color3.fromRGB(25, 25, 25),

	Dialog = Color3.fromRGB(35, 35, 35),
	DialogHolder = Color3.fromRGB(25, 25, 25),
	DialogHolderLine = Color3.fromRGB(20, 20, 20),
	DialogButton = Color3.fromRGB(35, 35, 35),
	DialogButtonBorder = Color3.fromRGB(55, 55, 55),
	DialogBorder = Color3.fromRGB(50, 50, 50),
	DialogInput = Color3.fromRGB(45, 45, 45),
	DialogInputLine = Color3.fromRGB(120, 120, 120),

	ColorpickerDialog = Color3.fromRGB(35, 35, 35),
	ColorpickerDialogBorder = Color3.fromRGB(50, 50, 50),
	ColorpickerHolder = Color3.fromRGB(25, 25, 25),
	ColorpickerHolderLine = Color3.fromRGB(20, 20, 20),
	ColorpickerButton = Color3.fromRGB(35, 35, 35),
	ColorpickerButtonBorder = Color3.fromRGB(55, 55, 55),
	ColorpickerInput = Color3.fromRGB(45, 45, 45),
	ColorpickerInputLine = Color3.fromRGB(120, 120, 120),
	ColorpickerInputBorder = Color3.fromRGB(55, 55, 55),
	ColorpickerInputFocused = Color3.fromRGB(25, 25, 25),
},

	Light = {
	Name = "Light",
	Accent = Color3.fromRGB(0, 103, 192),

	AcrylicMain = Color3.fromRGB(200, 200, 200),
	AcrylicBorder = Color3.fromRGB(120, 120, 120),
	AcrylicGradient = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(255, 255, 255)),
	AcrylicGradientRotation = 90,
	AcrylicNoise = 0.96,
	Background = "",
	BackgroundTransparency = 0,

	TitleBarLine = Color3.fromRGB(160, 160, 160),
	Tab = Color3.fromRGB(90, 90, 90),

	Element = Color3.fromRGB(255, 255, 255),
	ElementBorder = Color3.fromRGB(180, 180, 180),
	InElementBorder = Color3.fromRGB(150, 150, 150),
	ElementTransparency = 0.65,

	ToggleSlider = Color3.fromRGB(40, 40, 40),
	ToggleToggled = Color3.fromRGB(255, 255, 255),

	SliderRail = Color3.fromRGB(40, 40, 40),

	DropdownFrame = Color3.fromRGB(200, 200, 200),
	DropdownHolder = Color3.fromRGB(240, 240, 240),
	DropdownBorder = Color3.fromRGB(200, 200, 200),
	DropdownOption = Color3.fromRGB(150, 150, 150),

	Keybind = Color3.fromRGB(120, 120, 120),

	Input = Color3.fromRGB(200, 200, 200),
	InputFocused = Color3.fromRGB(100, 100, 100),
	InputIndicator = Color3.fromRGB(80, 80, 80),

	Dialog = Color3.fromRGB(255, 255, 255),
	DialogHolder = Color3.fromRGB(240, 240, 240),
	DialogHolderLine = Color3.fromRGB(228, 228, 228),
	DialogButton = Color3.fromRGB(255, 255, 255),
	DialogButtonBorder = Color3.fromRGB(190, 190, 190),
	DialogBorder = Color3.fromRGB(140, 140, 140),
	DialogInput = Color3.fromRGB(250, 250, 250),
	DialogInputLine = Color3.fromRGB(160, 160, 160),

	ColorpickerDialog = Color3.fromRGB(255, 255, 255),
	ColorpickerDialogBorder = Color3.fromRGB(140, 140, 140),
	ColorpickerHolder = Color3.fromRGB(240, 240, 240),
	ColorpickerHolderLine = Color3.fromRGB(228, 228, 228),
	ColorpickerButton = Color3.fromRGB(255, 255, 255),
	ColorpickerButtonBorder = Color3.fromRGB(190, 190, 190),
	ColorpickerInput = Color3.fromRGB(250, 250, 250),
	ColorpickerInputLine = Color3.fromRGB(160, 160, 160),
	ColorpickerInputBorder = Color3.fromRGB(190, 190, 190),
	ColorpickerInputFocused = Color3.fromRGB(240, 240, 240),

	Text = Color3.fromRGB(0, 0, 0),
	SubText = Color3.fromRGB(40, 40, 40),
	Hover = Color3.fromRGB(50, 50, 50),
	HoverChange = 0.16,
},

	Aqua = {
	Name = "Aqua",
	Accent = Color3.fromRGB(60, 165, 165),

	AcrylicMain = Color3.fromRGB(20, 20, 20),
	AcrylicBorder = Color3.fromRGB(50, 100, 100),
	AcrylicGradient = ColorSequence.new(Color3.fromRGB(60, 140, 140), Color3.fromRGB(40, 80, 80)),
	AcrylicGradientRotation = 90,
	AcrylicNoise = 0.92,
	Background = "",
	BackgroundTransparency = 0,

	TitleBarLine = Color3.fromRGB(60, 120, 120),
	Tab = Color3.fromRGB(140, 180, 180),

	Element = Color3.fromRGB(110, 160, 160),
	ElementBorder = Color3.fromRGB(40, 70, 70),
	InElementBorder = Color3.fromRGB(80, 110, 110),
	ElementTransparency = 0.84,

	ToggleSlider = Color3.fromRGB(110, 160, 160),
	ToggleToggled = Color3.fromRGB(0, 0, 0),

	SliderRail = Color3.fromRGB(110, 160, 160),

	DropdownFrame = Color3.fromRGB(160, 200, 200),
	DropdownHolder = Color3.fromRGB(40, 80, 80),
	DropdownBorder = Color3.fromRGB(40, 65, 65),
	DropdownOption = Color3.fromRGB(110, 160, 160),

	Keybind = Color3.fromRGB(110, 160, 160),

	Input = Color3.fromRGB(110, 160, 160),
	InputFocused = Color3.fromRGB(20, 10, 30),
	InputIndicator = Color3.fromRGB(130, 170, 170),

	Dialog = Color3.fromRGB(40, 80, 80),
	DialogHolder = Color3.fromRGB(30, 60, 60),
	DialogHolderLine = Color3.fromRGB(25, 50, 50),
	DialogButton = Color3.fromRGB(40, 80, 80),
	DialogButtonBorder = Color3.fromRGB(80, 110, 110),
	DialogBorder = Color3.fromRGB(50, 100, 100),
	DialogInput = Color3.fromRGB(45, 90, 90),
	DialogInputLine = Color3.fromRGB(130, 170, 170),

	ColorpickerDialog = Color3.fromRGB(40, 80, 80),
	ColorpickerDialogBorder = Color3.fromRGB(50, 100, 100),
	ColorpickerHolder = Color3.fromRGB(30, 60, 60),
	ColorpickerHolderLine = Color3.fromRGB(25, 50, 50),
	ColorpickerButton = Color3.fromRGB(40, 80, 80),
	ColorpickerButtonBorder = Color3.fromRGB(80, 110, 110),
	ColorpickerInput = Color3.fromRGB(45, 90, 90),
	ColorpickerInputLine = Color3.fromRGB(130, 170, 170),
	ColorpickerInputBorder = Color3.fromRGB(80, 110, 110),
	ColorpickerInputFocused = Color3.fromRGB(30, 60, 60),

	Text = Color3.fromRGB(240, 240, 240),
	SubText = Color3.fromRGB(170, 170, 170),
	Hover = Color3.fromRGB(110, 160, 160),
	HoverChange = 0.04,
},

	Amethyst = {
	Name = "Amethyst",
	Accent = Color3.fromRGB(97, 62, 167),

	AcrylicMain = Color3.fromRGB(20, 20, 20),
	AcrylicBorder = Color3.fromRGB(110, 90, 130),
	AcrylicGradient = ColorSequence.new(Color3.fromRGB(85, 57, 139), Color3.fromRGB(40, 25, 65)),
	AcrylicGradientRotation = 90,
	AcrylicNoise = 0.92,
	Background = "",
	BackgroundTransparency = 0,

	TitleBarLine = Color3.fromRGB(95, 75, 110),
	Tab = Color3.fromRGB(160, 140, 180),

	Element = Color3.fromRGB(140, 120, 160),
	ElementBorder = Color3.fromRGB(60, 50, 70),
	InElementBorder = Color3.fromRGB(100, 90, 110),
	ElementTransparency = 0.87,

	ToggleSlider = Color3.fromRGB(140, 120, 160),
	ToggleToggled = Color3.fromRGB(0, 0, 0),

	SliderRail = Color3.fromRGB(140, 120, 160),

	DropdownFrame = Color3.fromRGB(170, 160, 200),
	DropdownHolder = Color3.fromRGB(60, 45, 80),
	DropdownBorder = Color3.fromRGB(50, 40, 65),
	DropdownOption = Color3.fromRGB(140, 120, 160),

	Keybind = Color3.fromRGB(140, 120, 160),

	Input = Color3.fromRGB(140, 120, 160),
	InputFocused = Color3.fromRGB(20, 10, 30),
	InputIndicator = Color3.fromRGB(170, 150, 190),

	Dialog = Color3.fromRGB(60, 45, 80),
	DialogHolder = Color3.fromRGB(45, 30, 65),
	DialogHolderLine = Color3.fromRGB(40, 25, 60),
	DialogButton = Color3.fromRGB(60, 45, 80),
	DialogButtonBorder = Color3.fromRGB(95, 80, 110),
	DialogBorder = Color3.fromRGB(85, 70, 100),
	DialogInput = Color3.fromRGB(70, 55, 85),
	DialogInputLine = Color3.fromRGB(175, 160, 190),

	ColorpickerDialog = Color3.fromRGB(60, 45, 80),
	ColorpickerDialogBorder = Color3.fromRGB(85, 70, 100),
	ColorpickerHolder = Color3.fromRGB(45, 30, 65),
	ColorpickerHolderLine = Color3.fromRGB(40, 25, 60),
	ColorpickerButton = Color3.fromRGB(60, 45, 80),
	ColorpickerButtonBorder = Color3.fromRGB(95, 80, 110),
	ColorpickerInput = Color3.fromRGB(70, 55, 85),
	ColorpickerInputLine = Color3.fromRGB(175, 160, 190),
	ColorpickerInputBorder = Color3.fromRGB(95, 80, 110),
	ColorpickerInputFocused = Color3.fromRGB(45, 30, 65),

	Text = Color3.fromRGB(240, 240, 240),
	SubText = Color3.fromRGB(170, 170, 170),
	Hover = Color3.fromRGB(140, 120, 160),
	HoverChange = 0.04,
},

	Rose = {
	Name = "Rose",
	Accent = Color3.fromRGB(180, 55, 90),

	AcrylicMain = Color3.fromRGB(40, 40, 40),
	AcrylicBorder = Color3.fromRGB(130, 90, 110),
	AcrylicGradient = ColorSequence.new(Color3.fromRGB(190, 60, 135), Color3.fromRGB(165, 50, 70)),
	AcrylicGradientRotation = 90,
	AcrylicNoise = 0.92,
	Background = "",
	BackgroundTransparency = 0,

	TitleBarLine = Color3.fromRGB(140, 85, 105),
	Tab = Color3.fromRGB(180, 140, 160),

	Element = Color3.fromRGB(200, 120, 170),
	ElementBorder = Color3.fromRGB(110, 70, 85),
	InElementBorder = Color3.fromRGB(120, 90, 90),
	ElementTransparency = 0.86,

	ToggleSlider = Color3.fromRGB(200, 120, 170),
	ToggleToggled = Color3.fromRGB(0, 0, 0),

	SliderRail = Color3.fromRGB(200, 120, 170),

	DropdownFrame = Color3.fromRGB(200, 160, 180),
	DropdownHolder = Color3.fromRGB(120, 50, 75),
	DropdownBorder = Color3.fromRGB(90, 40, 55),
	DropdownOption = Color3.fromRGB(200, 120, 170),

	Keybind = Color3.fromRGB(200, 120, 170),

	Input = Color3.fromRGB(200, 120, 170),
	InputFocused = Color3.fromRGB(20, 10, 30),
	InputIndicator = Color3.fromRGB(170, 150, 190),

	Dialog = Color3.fromRGB(120, 50, 75),
	DialogHolder = Color3.fromRGB(95, 40, 60),
	DialogHolderLine = Color3.fromRGB(90, 35, 55),
	DialogButton = Color3.fromRGB(120, 50, 75),
	DialogButtonBorder = Color3.fromRGB(155, 90, 115),
	DialogBorder = Color3.fromRGB(100, 70, 90),
	DialogInput = Color3.fromRGB(135, 55, 80),
	DialogInputLine = Color3.fromRGB(190, 160, 180),

	ColorpickerDialog = Color3.fromRGB(120, 50, 75),
	ColorpickerDialogBorder = Color3.fromRGB(100, 70, 90),
	ColorpickerHolder = Color3.fromRGB(95, 40, 60),
	ColorpickerHolderLine = Color3.fromRGB(90, 35, 55),
	ColorpickerButton = Color3.fromRGB(120, 50, 75),
	ColorpickerButtonBorder = Color3.fromRGB(155, 90, 115),
	ColorpickerInput = Color3.fromRGB(135, 55, 80),
	ColorpickerInputLine = Color3.fromRGB(190, 160, 180),
	ColorpickerInputBorder = Color3.fromRGB(155, 90, 115),
	ColorpickerInputFocused = Color3.fromRGB(95, 40, 60),

	Text = Color3.fromRGB(240, 240, 240),
	SubText = Color3.fromRGB(170, 170, 170),
	Hover = Color3.fromRGB(200, 120, 170),
	HoverChange = 0.04,
},

	["Crimson Noir"] = {
	Name = "Crimson Noir",
	Accent = Color3.fromRGB(197, 3, 55),

	AcrylicMain = Color3.fromRGB(10, 6, 10),
	AcrylicBorder = Color3.fromRGB(90, 12, 35),
	AcrylicGradient = ColorSequence.new(Color3.fromRGB(197, 3, 55), Color3.fromRGB(2, 6, 14)),
	AcrylicGradientRotation = 90,
	AcrylicNoise = 0.93,
	Background = "",
	BackgroundTransparency = 0,

	TitleBarLine = Color3.fromRGB(80, 12, 35),
	Tab = Color3.fromRGB(110, 18, 45),

	Element = Color3.fromRGB(130, 12, 40),
	ElementBorder = Color3.fromRGB(35, 6, 15),
	InElementBorder = Color3.fromRGB(90, 15, 32),
	ElementTransparency = 0.87,

	ToggleSlider = Color3.fromRGB(130, 12, 40),
	ToggleToggled = Color3.fromRGB(2, 6, 14),

	SliderRail = Color3.fromRGB(130, 12, 40),

	DropdownFrame = Color3.fromRGB(150, 18, 48),
	DropdownHolder = Color3.fromRGB(10, 6, 10),
	DropdownBorder = Color3.fromRGB(6, 4, 8),
	DropdownOption = Color3.fromRGB(130, 12, 40),

	Keybind = Color3.fromRGB(130, 12, 40),

	Input = Color3.fromRGB(150, 18, 48),
	InputFocused = Color3.fromRGB(6, 4, 9),
	InputIndicator = Color3.fromRGB(190, 25, 60),

	Dialog = Color3.fromRGB(40, 5, 14),
	DialogHolder = Color3.fromRGB(28, 4, 10),
	DialogHolderLine = Color3.fromRGB(20, 3, 7),
	DialogButton = Color3.fromRGB(0, 0, 0),
	DialogButtonBorder = Color3.fromRGB(120, 3, 38),
	DialogBorder = Color3.fromRGB(110, 3, 35),
	DialogInput = Color3.fromRGB(20, 8, 13),
	DialogInputLine = Color3.fromRGB(230, 30, 70),

	ColorpickerDialog = Color3.fromRGB(40, 5, 14),
	ColorpickerDialogBorder = Color3.fromRGB(110, 3, 35),
	ColorpickerHolder = Color3.fromRGB(28, 4, 10),
	ColorpickerHolderLine = Color3.fromRGB(20, 3, 7),
	ColorpickerButton = Color3.fromRGB(0, 0, 0),
	ColorpickerButtonBorder = Color3.fromRGB(110, 3, 35),
	ColorpickerInput = Color3.fromRGB(20, 8, 13),
	ColorpickerInputLine = Color3.fromRGB(230, 30, 70),
	ColorpickerInputBorder = Color3.fromRGB(110, 3, 35),
	ColorpickerInputFocused = Color3.fromRGB(20, 8, 13),

	Text = Color3.fromRGB(245, 235, 237),
	SubText = Color3.fromRGB(190, 130, 145),
	Hover = Color3.fromRGB(110, 18, 45),
	HoverChange = 0.07,
},

	Gold = {
	Name = "Gold",
	Accent = Color3.fromRGB(255, 198, 41),

	AcrylicMain = Color3.fromRGB(58, 43, 8),
	AcrylicBorder = Color3.fromRGB(130, 98, 22),
	AcrylicGradient = ColorSequence.new(Color3.fromRGB(120, 90, 18), Color3.fromRGB(55, 40, 8)),
	AcrylicGradientRotation = 90,
	AcrylicNoise = 0.93,
	Background = "",
	BackgroundTransparency = 0,

	TitleBarLine = Color3.fromRGB(125, 94, 20),
	Tab = Color3.fromRGB(160, 122, 38),

	Element = Color3.fromRGB(140, 106, 28),
	ElementBorder = Color3.fromRGB(85, 63, 12),
	InElementBorder = Color3.fromRGB(115, 88, 20),
	ElementTransparency = 0.87,

	ToggleSlider = Color3.fromRGB(140, 106, 28),
	ToggleToggled = Color3.fromRGB(255, 255, 255),

	SliderRail = Color3.fromRGB(140, 106, 28),

	DropdownFrame = Color3.fromRGB(190, 148, 48),
	DropdownHolder = Color3.fromRGB(62, 46, 10),
	DropdownBorder = Color3.fromRGB(52, 39, 8),
	DropdownOption = Color3.fromRGB(140, 106, 28),

	Keybind = Color3.fromRGB(140, 106, 28),

	Input = Color3.fromRGB(190, 148, 48),
	InputFocused = Color3.fromRGB(48, 35, 8),
	InputIndicator = Color3.fromRGB(215, 172, 55),

	Dialog = Color3.fromRGB(68, 51, 13),
	DialogHolder = Color3.fromRGB(52, 39, 9),
	DialogHolderLine = Color3.fromRGB(42, 31, 7),
	DialogButton = Color3.fromRGB(68, 51, 13),
	DialogButtonBorder = Color3.fromRGB(105, 79, 19),
	DialogBorder = Color3.fromRGB(125, 94, 20),
	DialogInput = Color3.fromRGB(78, 58, 15),
	DialogInputLine = Color3.fromRGB(230, 188, 62),

	ColorpickerDialog = Color3.fromRGB(68, 51, 13),
	ColorpickerDialogBorder = Color3.fromRGB(125, 94, 20),
	ColorpickerHolder = Color3.fromRGB(52, 39, 9),
	ColorpickerHolderLine = Color3.fromRGB(42, 31, 7),
	ColorpickerButton = Color3.fromRGB(68, 51, 13),
	ColorpickerButtonBorder = Color3.fromRGB(105, 79, 19),
	ColorpickerInput = Color3.fromRGB(78, 58, 15),
	ColorpickerInputLine = Color3.fromRGB(230, 188, 62),
	ColorpickerInputBorder = Color3.fromRGB(105, 79, 19),
	ColorpickerInputFocused = Color3.fromRGB(52, 39, 9),

	Text = Color3.fromRGB(255, 248, 225),
	SubText = Color3.fromRGB(215, 185, 115),
	Hover = Color3.fromRGB(160, 122, 38),
	HoverChange = 0.07,
},
}

local Elements

local Library = {
	Version = "1.0.0",

	OpenFrames = {},
	Options = {},
	Themes = Themes.Names,

	Window = nil,
	WindowFrame = nil,
	Unloaded = false,

	Theme = "Light",
	Font = "rbxasset://fonts/families/GothamSSm.json",
	DialogOpen = false,
	UseAcrylic = false,
	Acrylic = false,
	Transparency = 0.35,
	MinimizeKeybind = nil,
	MinimizeKey = Enum.KeyCode.LeftControl,
	DisableBackground = false,
	KeepWindowInsideFrame = true,
	BoundaryMargin = 8,
	BoundaryInset = { Top = 0, Bottom = 0, Left = 0, Right = 0 },
	CustomThemeData = nil,
}

local function isMotor(value)
	local motorType = tostring(value):match("^Motor%((.+)%)$")

	if motorType then
		return true, motorType
	else
		return false
	end
end

local Connection = {}
Connection.__index = Connection

function Connection.new(signal, handler)
	return setmetatable({
		signal = signal,
		connected = true,
		_handler = handler,
	}, Connection)
end

function Connection:disconnect()
	if self.connected then
		self.connected = false

		for index, connection in pairs(self.signal._connections) do
			if connection == self then
				table.remove(self.signal._connections, index)
				return
			end
		end
	end
end

local Signal = {}
Signal.__index = Signal

function Signal.new()
	return setmetatable({
		_connections = {},
		_threads = {},
	}, Signal)
end

function Signal:fire(...)
	for _, connection in pairs(self._connections) do
		connection._handler(...)
	end

	for _, thread in pairs(self._threads) do
		coroutine.resume(thread, ...)
	end

	self._threads = {}
end

function Signal:connect(handler)
	local connection = Connection.new(self, handler)
	table.insert(self._connections, connection)
	return connection
end

function Signal:wait()
	table.insert(self._threads, coroutine.running())
	return coroutine.yield()
end

local Linear = {}
Linear.__index = Linear

function Linear.new(targetValue, options)
	assert(targetValue, "Missing argument #1: targetValue")

	options = options or {}

	return setmetatable({
		_targetValue = targetValue,
		_velocity = options.velocity or 1,
	}, Linear)
end

function Linear:step(state, dt)
	local position = state.value
	local velocity = self._velocity
	local goal = self._targetValue

	local dPos = dt * velocity

	local complete = dPos >= math.abs(goal - position)
	position = position + dPos * (goal > position and 1 or -1)
	if complete then
		position = self._targetValue
		velocity = 0
	end

	return {
		complete = complete,
		value = position,
		velocity = velocity,
	}
end

local Instant = {}
Instant.__index = Instant

function Instant.new(targetValue)
	return setmetatable({
		_targetValue = targetValue,
	}, Instant)
end

function Instant:step()
	return {
		complete = true,
		value = self._targetValue,
	}
end

local VELOCITY_THRESHOLD = 0.001
local POSITION_THRESHOLD = 0.001

local EPS = 0.0001

local Spring = {}
Spring.__index = Spring

function Spring.new(targetValue, options)
	assert(targetValue, "Missing argument #1: targetValue")
	options = options or {}

	return setmetatable({
		_targetValue = targetValue,
		_frequency = options.frequency or 4,
		_dampingRatio = options.dampingRatio or 1,
	}, Spring)
end

function Spring:step(state, dt)

	local d = self._dampingRatio
	local f = self._frequency * 2 * math.pi
	local g = self._targetValue
	local p0 = state.value
	local v0 = state.velocity or 0

	local offset = p0 - g
	local decay = math.exp(-d * f * dt)

	local p1, v1

	if d == 1 then
		p1 = (offset * (1 + f * dt) + v0 * dt) * decay + g
		v1 = (v0 * (1 - f * dt) - offset * (f * f * dt)) * decay
	elseif d < 1 then
		local c = math.sqrt(1 - d * d)

		local i = math.cos(f * c * dt)
		local j = math.sin(f * c * dt)

		local z
		if c > EPS then
			z = j / c
		else
			local a = dt * f
			z = a + ((a * a) * (c * c) * (c * c) / 20 - c * c) * (a * a * a) / 6
		end

		local y
		if f * c > EPS then
			y = j / (f * c)
		else
			local b = f * c
			y = dt + ((dt * dt) * (b * b) * (b * b) / 20 - b * b) * (dt * dt * dt) / 6
		end

		p1 = (offset * (i + d * z) + v0 * y) * decay + g
		v1 = (v0 * (i - z * d) - offset * (z * f)) * decay
	else
		local c = math.sqrt(d * d - 1)

		local r1 = -f * (d - c)
		local r2 = -f * (d + c)

		local co2 = (v0 - offset * r1) / (2 * f * c)
		local co1 = offset - co2

		local e1 = co1 * math.exp(r1 * dt)
		local e2 = co2 * math.exp(r2 * dt)

		p1 = e1 + e2 + g
		v1 = e1 * r1 + e2 * r2
	end

	local complete = math.abs(v1) < VELOCITY_THRESHOLD and math.abs(p1 - g) < POSITION_THRESHOLD

	return {
		complete = complete,
		value = complete and g or p1,
		velocity = v1,
	}
end

local RunService = game:GetService("RunService")

local noop = function() end

local BaseMotor = {}
BaseMotor.__index = BaseMotor

function BaseMotor.new()
	return setmetatable({
		_onStep = Signal.new(),
		_onStart = Signal.new(),
		_onComplete = Signal.new(),
	}, BaseMotor)
end

function BaseMotor:onStep(handler)
	return self._onStep:connect(handler)
end

function BaseMotor:onStart(handler)
	return self._onStart:connect(handler)
end

function BaseMotor:onComplete(handler)
	return self._onComplete:connect(handler)
end

function BaseMotor:start()
	if not self._connection then
		self._connection = RunService.RenderStepped:Connect(function(deltaTime)
			self:step(deltaTime)
		end)
	end
end

function BaseMotor:stop()
	if self._connection then
		self._connection:Disconnect()
		self._connection = nil
	end
end

BaseMotor.destroy = BaseMotor.stop

BaseMotor.step = noop
BaseMotor.getValue = noop
BaseMotor.setGoal = noop

function BaseMotor:__tostring()
	return "Motor"
end

local SingleMotor = setmetatable({}, BaseMotor)
SingleMotor.__index = SingleMotor

function SingleMotor.new(initialValue, useImplicitConnections)
	assert(initialValue, "Missing argument #1: initialValue")
	assert(typeof(initialValue) == "number", "initialValue must be a number!")

	local self = setmetatable(BaseMotor.new(), SingleMotor)

	if useImplicitConnections ~= nil then
		self._useImplicitConnections = useImplicitConnections
	else
		self._useImplicitConnections = true
	end

	self._goal = nil
	self._state = {
		complete = true,
		value = initialValue,
	}

	return self
end

function SingleMotor:step(deltaTime)
	if self._state.complete then
		return true
	end

	local newState = self._goal:step(self._state, deltaTime)

	self._state = newState
	self._onStep:fire(newState.value)

	if newState.complete then
		if self._useImplicitConnections then
			self:stop()
		end

		self._onComplete:fire()
	end

	return newState.complete
end

function SingleMotor:getValue()
	return self._state.value
end

function SingleMotor:setGoal(goal)
	self._state.complete = false
	self._goal = goal

	self._onStart:fire()

	if self._useImplicitConnections then
		self:start()
	end
end

function SingleMotor:__tostring()
	return "Motor(Single)"
end

local GroupMotor = setmetatable({}, BaseMotor)
GroupMotor.__index = GroupMotor

local function toMotor(value)
	if isMotor(value) then
		return value
	end

	local valueType = typeof(value)

	if valueType == "number" then
		return SingleMotor.new(value, false)
	elseif valueType == "table" then
		return GroupMotor.new(value, false)
	end

	error(("Unable to convert %q to motor; type %s is unsupported"):format(value, valueType), 2)
end

function GroupMotor.new(initialValues, useImplicitConnections)
	assert(initialValues, "Missing argument #1: initialValues")
	assert(typeof(initialValues) == "table", "initialValues must be a table!")
	assert(
		not initialValues.step,
		'initialValues contains disallowed property "step". Did you mean to put a table of values here?'
	)

	local self = setmetatable(BaseMotor.new(), GroupMotor)

	if useImplicitConnections ~= nil then
		self._useImplicitConnections = useImplicitConnections
	else
		self._useImplicitConnections = true
	end

	self._complete = true
	self._motors = {}

	for key, value in pairs(initialValues) do
		self._motors[key] = toMotor(value)
	end

	return self
end

function GroupMotor:step(deltaTime)
	if self._complete then
		return true
	end

	local allMotorsComplete = true

	for _, motor in pairs(self._motors) do
		local complete = motor:step(deltaTime)
		if not complete then

			allMotorsComplete = false
		end
	end

	self._onStep:fire(self:getValue())

	if allMotorsComplete then
		if self._useImplicitConnections then
			self:stop()
		end

		self._complete = true
		self._onComplete:fire()
	end

	return allMotorsComplete
end

function GroupMotor:setGoal(goals)
	assert(not goals.step, 'goals contains disallowed property "step". Did you mean to put a table of goals here?')

	self._complete = false
	self._onStart:fire()

	for key, goal in pairs(goals) do
		local motor = assert(self._motors[key], ("Unknown motor for key %s"):format(key))
		motor:setGoal(goal)
	end

	if self._useImplicitConnections then
		self:start()
	end
end

function GroupMotor:getValue()
	local values = {}

	for key, motor in pairs(self._motors) do
		values[key] = motor:getValue()
	end

	return values
end

function GroupMotor:__tostring()
	return "Motor(Group)"
end

local Flipper = {
	SingleMotor = SingleMotor,
	GroupMotor = GroupMotor,

	Instant = Instant,
	Linear = Linear,
	Spring = Spring,

	isMotor = isMotor,
}

local Creator = {
	Registry = {},
	FontRegistry = {},
	FontChangedCallbacks = {},
	Signals = {},
	TransparencyMotors = {},
	DropdownTransparencyFrames = {},
	ThemeChangedCallbacks = {},
	DefaultProperties = {
		ScreenGui = {
			ResetOnSpawn = false,
			ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		},
		Frame = {
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderColor3 = Color3.new(0, 0, 0),
			BorderSizePixel = 0,
		},
		ScrollingFrame = {
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderColor3 = Color3.new(0, 0, 0),
			ScrollBarImageColor3 = Color3.new(0, 0, 0),
		},
		TextLabel = {
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderColor3 = Color3.new(0, 0, 0),
			Font = Enum.Font.SourceSans,
			Text = "",
			TextColor3 = Color3.new(0, 0, 0),
			BackgroundTransparency = 1,
			TextSize = 14,
		},
		TextButton = {
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderColor3 = Color3.new(0, 0, 0),
			AutoButtonColor = false,
			Font = Enum.Font.SourceSans,
			Text = "",
			TextColor3 = Color3.new(0, 0, 0),
			TextSize = 14,
		},
		TextBox = {
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderColor3 = Color3.new(0, 0, 0),
			ClearTextOnFocus = false,
			Font = Enum.Font.SourceSans,
			Text = "",
			TextColor3 = Color3.new(0, 0, 0),
			TextSize = 14,
		},
		ImageLabel = {
			BackgroundTransparency = 1,
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderColor3 = Color3.new(0, 0, 0),
			BorderSizePixel = 0,
		},
		ImageButton = {
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderColor3 = Color3.new(0, 0, 0),
			AutoButtonColor = false,
		},
		CanvasGroup = {
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderColor3 = Color3.new(0, 0, 0),
			BorderSizePixel = 0,
		},
	},
}

local function ApplyCustomProps(Object, Props)
	if Props.ThemeTag then
		Creator.AddThemeObject(Object, Props.ThemeTag)
	end
end

function Creator.AddSignal(Signal, Function)
	table.insert(Creator.Signals, Signal:Connect(Function))
end

function Creator.Disconnect()
	for Idx = #Creator.Signals, 1, -1 do
		local Connection = table.remove(Creator.Signals, Idx)
		Connection:Disconnect()
	end
end

function Creator.GetThemeProperty(Property)
	if Library.CustomThemeData and Library.CustomThemeData[Property] ~= nil then
		return Library.CustomThemeData[Property]
	end
	if Themes[Library.Theme] and Themes[Library.Theme][Property] ~= nil then
		return Themes[Library.Theme][Property]
	end
	return Themes["Dark"][Property]
end

function Creator.GetKnobColor()
	local Color = Creator.GetThemeProperty("ToggleToggled")
	return Color3.new(1 - Color.R, 1 - Color.G, 1 - Color.B)
end

function Creator.UpdateTheme()
	for Instance, Object in next, Creator.Registry do
		for Property, ColorIdx in next, Object.Properties do
			Instance[Property] = Creator.GetThemeProperty(ColorIdx)
		end
	end

	for _, Motor in next, Creator.TransparencyMotors do
		Motor:setGoal(Flipper.Instant.new(Creator.GetThemeProperty("ElementTransparency")))
	end

	for _, Callback in next, Creator.ThemeChangedCallbacks do
		Callback()
	end
end

function Creator.OnThemeChanged(Callback)
	table.insert(Creator.ThemeChangedCallbacks, Callback)
	return Callback
end

function Creator.AddThemeObject(Object, Properties)
	Creator.RegistryCount = (Creator.RegistryCount or 0) + 1

	local Data = {
		Object = Object,
		Properties = Properties,
		Idx = Creator.RegistryCount,
	}

	Creator.Registry[Object] = Data

	for Property, ColorIdx in next, Properties do
		Object[Property] = Creator.GetThemeProperty(ColorIdx)
	end

	return Object
end

function Creator.OverrideTag(Object, Properties)
	Creator.Registry[Object].Properties = Properties
	Creator.UpdateTheme()
end

function Creator.RegisterFontObject(object, weight, style)
	table.insert(Creator.FontRegistry, {
		object = object,
		weight = weight or Enum.FontWeight.Regular,
		style = style  or Enum.FontStyle.Normal,
	})
end

function Creator.UpdateFont()
	for _, entry in ipairs(Creator.FontRegistry) do
		pcall(function()
			entry.object.FontFace = Font.new(Library.Font, entry.weight, entry.style)
		end)
	end
	for _, Callback in next, Creator.FontChangedCallbacks do
		Callback(Library.Font)
	end
end

local fontTextTypes = { TextLabel = true, TextButton = true, TextBox = true }

function Creator.New(Name, Properties, Children)
	local Object = Instance.new(Name)

	for Name, Value in next, Creator.DefaultProperties[Name] or {} do
		Object[Name] = Value
	end

	local fontWeight = Enum.FontWeight.Regular
	local fontStyle = Enum.FontStyle.Normal

	for Name, Value in next, Properties or {} do
		if Name ~= "ThemeTag" and Name ~= "IgnoreFontUpdate" then
			Object[Name] = Value
		end
		if Name == "FontFace" and typeof(Value) == "Font" then
			fontWeight = Value.Weight
			fontStyle = Value.Style
		end
	end

	if fontTextTypes[Name] and not (Properties and Properties.IgnoreFontUpdate) then
		Creator.RegisterFontObject(Object, fontWeight, fontStyle)
	end

	for _, Child in next, Children or {} do
		Child.Parent = Object
	end

	ApplyCustomProps(Object, Properties)
	return Object
end

function Creator.RegisterDropdownTransparency(Instance)
	table.insert(Creator.DropdownTransparencyFrames, Instance)
	Instance.BackgroundTransparency = Library.Transparency
end

function Creator.AttachTitleDesc(Target, TitleLabel, DescLabel)
	function Target:SetTitle(Set)
		Set = Set or ""
		TitleLabel.Text = Set
		TitleLabel.Visible = Set ~= ""
	end

	if DescLabel then
		function Target:SetDesc(Set)
			Set = Set or ""
			DescLabel.Text = Set
			DescLabel.Visible = Set ~= ""
		end
	end
end

Creator.Marquees = {}

local MarqueePause = 1.2
local MarqueeSpeed = 40

local function UpdateMarquees(Delta)
	for Index = #Creator.Marquees, 1, -1 do
		local Entry = Creator.Marquees[Index]
		if not Entry.Label.Parent then
			table.remove(Creator.Marquees, Index)
		elseif Entry.Label.Visible and Entry.Label.AbsoluteSize.X > 0 then
			local Overflow = Entry.Child.TextBounds.X - Entry.Label.AbsoluteSize.X
			local Offset = 0

			if Overflow > 1 then
				Entry.Time = Entry.Time + Delta
				local Duration = Overflow / MarqueeSpeed
				local Cycle = MarqueePause * 2 + Duration * 2
				local Time = Entry.Time % Cycle

				if Time < MarqueePause then
					Offset = 0
				elseif Time < MarqueePause + Duration then
					Offset = -Overflow * (Time - MarqueePause) / Duration
				elseif Time < MarqueePause * 2 + Duration then
					Offset = -Overflow
				else
					Offset = -Overflow * (1 - (Time - MarqueePause * 2 - Duration) / Duration)
				end
			else
				Entry.Time = 0
			end

			Offset = math.floor(Offset + 0.5)
			if Offset ~= Entry.Offset then
				Entry.Offset = Offset
				Entry.Child.Position = UDim2.fromOffset(Offset, 0)
			end
		end
	end
end

function Creator.Marquee(Label, ColorTag)
	if not Creator.MarqueeStarted then
		Creator.MarqueeStarted = true
		Creator.AddSignal(RunService.Heartbeat, UpdateMarquees)
	end

	Label.ClipsDescendants = true
	Label.TextTransparency = 1
	Label.TextWrapped = false

	local Child = Creator.New("TextLabel", {
		Name = "MarqueeText",
		Text = Label.Text,
		FontFace = Label.FontFace,
		TextSize = Label.TextSize,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
		Size = UDim2.new(0, 0, 1, 0),
		AutomaticSize = Enum.AutomaticSize.X,
		BackgroundTransparency = 1,
		Parent = Label,
		ThemeTag = {
			TextColor3 = ColorTag,
		},
	})

	Creator.AddSignal(Label:GetPropertyChangedSignal("Text"), function()
		Child.Text = Label.Text
	end)

	table.insert(Creator.Marquees, { Label = Label, Child = Child, Time = 0, Offset = 0 })
end

function Creator.Adaptive(ElementFrame, Slot, Threshold, StartInline, Apply)
	local Inline = StartInline

	local function Place(Value)
		Inline = Value
		local LabelSize = Inline and UDim2.new(1, -Slot, 0, 14) or UDim2.new(1, 0, 0, 14)
		ElementFrame.TitleLabel.Size = LabelSize
		ElementFrame.DescLabel.Size = LabelSize
		Apply(Inline)
	end

	local function Update()
		local Width = ElementFrame.Frame.AbsoluteSize.X
		if Width <= 0 then return end
		local Want
		if Inline then
			Want = Width >= Threshold - 20
		else
			Want = Width >= Threshold + 20
		end
		if Want ~= Inline then
			Place(Want)
		end
	end

	Place(Inline)
	if StartInline then return end
	Creator.AddSignal(ElementFrame.Frame:GetPropertyChangedSignal("AbsoluteSize"), Update)
	task.defer(Update)
end

function Creator.SpringMotor(Initial, Instance, Prop, IgnoreDialogCheck, ResetOnThemeChange)
	IgnoreDialogCheck = IgnoreDialogCheck or false
	ResetOnThemeChange = ResetOnThemeChange or false
	local Motor = Flipper.SingleMotor.new(Initial)
	Motor:onStep(function(value)
		Instance[Prop] = value
	end)

	if ResetOnThemeChange then
		table.insert(Creator.TransparencyMotors, Motor)
	end

	local function SetValue(Value, Ignore)
		Ignore = Ignore or false
		if not IgnoreDialogCheck then
			if not Ignore then
				if Prop == "BackgroundTransparency" and Library.DialogOpen then
					return
				end
			end
		end
		Motor:setGoal(Flipper.Spring.new(Value, { frequency = 8 }))
	end

	return Motor, SetValue
end

local New = Creator.New

local GUI = New("ScreenGui", {
	Parent = RunService:IsStudio() and LocalPlayer.PlayerGui or CoreGui,
})
ProtectGui(GUI)
Library.GUI = GUI

function Library:SafeCallback(Function, ...)
	if not Function then
		return
	end

	local Success, Event = pcall(Function, ...)
	if not Success then
		local _, i = Event:find(":%d+: ")

		if not i then
			return Library:Notify({
				Title = "Interface",
				Content = "Callback error",
				SubContent = Event,
				Duration = 5,
			})
		end

		return Library:Notify({
			Title = "Interface",
			Content = "Callback error",
			SubContent = Event:sub(i + 1),
			Duration = 5,
		})
	end
end

function Library:Round(Number, Factor)
	if Factor == 0 then
		return math.floor(Number)
	end
	Number = tostring(Number)
	return Number:find("%.") and tonumber(Number:sub(1, Number:find("%.") + Factor)) or Number
end

local function viewportPointToWorld(location, distance)
	local unitRay = game:GetService("Workspace").CurrentCamera:ScreenPointToRay(location.X, location.Y)
	return unitRay.Origin + unitRay.Direction * distance
end

local function createAcrylic()
	local Part = Creator.New("Part", {
		Name = "Body",
		Color = Color3.new(0, 0, 0),
		Material = Enum.Material.Glass,
		Size = Vector3.new(1, 1, 0),
		Anchored = true,
      CanCollide = false,
      CanQuery = false,
      CanTouch = false,
      Locked = true,
      Transparency = 0.98,
	}, {
		Creator.New("SpecialMesh", {
			MeshType = Enum.MeshType.Brick,
			Offset = Vector3.new(0, 0, -0.000001),
		}),
	})

	return Part
end

local BlurFolder = Instance.new("Folder", game:GetService("Workspace").CurrentCamera)

local function createAcrylicBlur(distance)
	local cleanups = {}

	distance = distance or 0.001
	local positions = {
		topLeft = Vector2.new(),
		topRight = Vector2.new(),
		bottomRight = Vector2.new(),
	}
	local model = createAcrylic()
	model.Parent = BlurFolder

	local function updatePositions(size, position)
		positions.topLeft = position
		positions.topRight = position + Vector2.new(size.X, 0)
		positions.bottomRight = position + size
	end

	local function render()
		local res = game:GetService("Workspace").CurrentCamera
		if res then
			res = res.CFrame
		end
		local cond = res
		if not cond then
			cond = CFrame.new()
		end

		local camera = cond
		local topLeft = positions.topLeft
		local topRight = positions.topRight
		local bottomRight = positions.bottomRight

		local topLeft3D = viewportPointToWorld(topLeft, distance)
		local topRight3D = viewportPointToWorld(topRight, distance)
		local bottomRight3D = viewportPointToWorld(bottomRight, distance)

		local width = (topRight3D - topLeft3D).Magnitude
		local height = (topRight3D - bottomRight3D).Magnitude

		model.CFrame =
			CFrame.fromMatrix((topLeft3D + bottomRight3D) / 2, camera.XVector, camera.YVector, camera.ZVector)
		model.Mesh.Scale = Vector3.new(width, height, 0)
	end

	local function onChange(rbx)
		local size = rbx.AbsoluteSize
		local position = rbx.AbsolutePosition

		updatePositions(size, position)
		task.spawn(render)
	end

	local function renderOnChange()
		local camera = game:GetService("Workspace").CurrentCamera
		if not camera then
			return
		end

		table.insert(cleanups, camera:GetPropertyChangedSignal("CFrame"):Connect(render))
		table.insert(cleanups, camera:GetPropertyChangedSignal("ViewportSize"):Connect(render))
		table.insert(cleanups, camera:GetPropertyChangedSignal("FieldOfView"):Connect(render))
		task.spawn(render)
	end

	model.Destroying:Connect(function()
		for _, item in cleanups do
			pcall(function()
				item:Disconnect()
			end)
		end
	end)

	renderOnChange()

	return onChange, model
end

local AcrylicBlur = function(distance)
	local Blur = {}
	local onChange, model = createAcrylicBlur(distance)

	local comp = Creator.New("Frame", {
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
	})

	Creator.AddSignal(comp:GetPropertyChangedSignal("AbsolutePosition"), function()
		onChange(comp)
	end)

	Creator.AddSignal(comp:GetPropertyChangedSignal("AbsoluteSize"), function()
		onChange(comp)
	end)

	Blur.AddParent = function(Parent)
		Creator.AddSignal(Parent:GetPropertyChangedSignal("Visible"), function()
			Blur.SetVisibility(Parent.Visible)
		end)
	end

	Blur.SetVisibility = function(Value)
		model.Transparency = Value and 0.98 or 1
	end

	Blur.Frame = comp
	Blur.Model = model

	return Blur
end

local New = Creator.New

local AcrylicPaint = function(props)
	local AcrylicPaint = {}

	AcrylicPaint.Frame = New("Frame", {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 0.9,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
	}, {
		New("ImageLabel", {
			Image = "rbxassetid://8992230677",
			ScaleType = "Slice",
			SliceCenter = Rect.new(Vector2.new(99, 99), Vector2.new(99, 99)),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Size = UDim2.new(1, 120, 1, 116),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			BackgroundTransparency = 1,
			ImageColor3 = Color3.fromRGB(0, 0, 0),
			ImageTransparency = 0.7,
		}),

		New("UICorner", {
			CornerRadius = UDim.new(0, 8),
		}),

		New("Frame", {
			BackgroundTransparency = 0.45,
			Size = UDim2.fromScale(1, 1),
			Name = "Background",
			ThemeTag = {
				BackgroundColor3 = "AcrylicMain",
			},
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 8),
			}),
		}),

		New("Frame", {
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 0.4,
			Size = UDim2.fromScale(1, 1),
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 8),
			}),

			New("UIGradient", {
				ThemeTag = {
					Color = "AcrylicGradient",
					Rotation = "AcrylicGradientRotation",
				},
			}),
		}),

		New("ImageLabel", {
			Image = "rbxassetid://9968344105",
			ImageTransparency = 0.98,
			ScaleType = Enum.ScaleType.Tile,
			TileSize = UDim2.new(0, 128, 0, 128),
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 8),
			}),
		}),

		New("ImageLabel", {
			Image = "rbxassetid://9968344227",
			ImageTransparency = 0.9,
			ScaleType = Enum.ScaleType.Tile,
			TileSize = UDim2.new(0, 128, 0, 128),
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			ThemeTag = {
				ImageTransparency = "AcrylicNoise",
			},
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 8),
			}),
		}),

		New("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1),
			ZIndex = 2,
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 8),
			}),
			New("UIStroke", {
				Transparency = 0.5,
				Thickness = 1,
				ThemeTag = {
					Color = "AcrylicBorder",
				},
			}),
		}),
	})

	local Blur

	if Library.UseAcrylic then
		Blur = AcrylicBlur()
		Blur.Frame.Parent = AcrylicPaint.Frame
		AcrylicPaint.Model = Blur.Model
		AcrylicPaint.AddParent = Blur.AddParent
		AcrylicPaint.SetVisibility = Blur.SetVisibility
	end

	return AcrylicPaint
end

local Acrylic = {
	AcrylicBlur = AcrylicBlur,
	CreateAcrylic = createAcrylic,
	AcrylicPaint = AcrylicPaint,
}

function Acrylic.init()
	local baseEffect = Instance.new("DepthOfFieldEffect")
	baseEffect.FarIntensity = 0
	baseEffect.InFocusRadius = 0.1
	baseEffect.NearIntensity = 1

	local depthOfFieldDefaults = {}

	function Acrylic.Enable()
		for _, effect in pairs(depthOfFieldDefaults) do
			effect.Enabled = false
		end
		baseEffect.Parent = Lighting
	end

	function Acrylic.Disable()
		for _, effect in pairs(depthOfFieldDefaults) do
			effect.Enabled = effect.enabled
		end
		baseEffect.Parent = nil
	end

	local function registerDefaults()
		local function register(object)
			if object:IsA("DepthOfFieldEffect") then
				depthOfFieldDefaults[object] = { enabled = object.Enabled }
			end
		end

		for _, child in pairs(Lighting:GetChildren()) do
			register(child)
		end

		if Workspace.CurrentCamera then
			for _, child in pairs(Workspace.CurrentCamera:GetChildren()) do
				register(child)
			end
		end
	end

	registerDefaults()
	Acrylic.Enable()
end

local Components = {
	Assets = {
	Close = "rbxassetid://9886659671",
	Min = "rbxassetid://9886659276",
	Max = "rbxassetid://9886659406",
	Restore = "rbxassetid://9886659001",
},
	AssetsNew = {
	Close = "rbxassetid://110786993356448",
	Min = "rbxassetid://118026365011536",
	Max = "rbxassetid://73085922906397",
	Restore = "rbxassetid://116269596042539",
},
}

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

Components.Button = (function()
	local New = Creator.New

	local Spring = Flipper.Spring.new

	return function(Theme, Parent, DialogCheck)
		DialogCheck = DialogCheck or false
		local Button = {}

		Button.Title = New("TextLabel", {
			FontFace = Font.new(Library.Font),
			TextColor3 = Color3.fromRGB(200, 200, 200),
			TextSize = 14,
			TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Center,
			TextYAlignment = Enum.TextYAlignment.Center,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1),
			ThemeTag = {
				TextColor3 = "Text",
			},
		})

		Button.HoverFrame = New("Frame", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			ThemeTag = {
				BackgroundColor3 = "Hover",
			},
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 4),
			}),
		})

		Button.Frame = New("TextButton", {
			Size = UDim2.new(0, 0, 0, 32),
			Parent = Parent,
			ThemeTag = {
				BackgroundColor3 = "DialogButton",
			},
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 4),
			}),
			New("UIStroke", {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Transparency = 0.65,
				ThemeTag = {
					Color = "DialogButtonBorder",
				},
			}),
			Button.HoverFrame,
			Button.Title,
		})

		local Motor, SetTransparency = Creator.SpringMotor(1, Button.HoverFrame, "BackgroundTransparency", DialogCheck)
		Creator.AddSignal(Button.Frame.MouseEnter, function()
			SetTransparency(0.97)
		end)
		Creator.AddSignal(Button.Frame.MouseLeave, function()
			SetTransparency(1)
		end)
		Creator.AddSignal(Button.Frame.MouseButton1Down, function()
			SetTransparency(1)
		end)
		Creator.AddSignal(Button.Frame.MouseButton1Up, function()
			SetTransparency(0.97)
		end)

		return Button
	end
end)()

Components.Textbox = (function()
	local TextService = game:GetService("TextService")
	local New = Creator.New

	return function(Parent, Acrylic, TagSet)
		Acrylic = Acrylic or false
		TagSet = TagSet or {
			Input = "DialogInput",
			InputLine = "DialogInputLine",
			InputBorder = "DialogButtonBorder",
			InputFocused = "DialogHolder",
		}
		local Textbox = {}

		Textbox.Input = New("TextBox", {
			FontFace = Font.new(Library.Font),
			TextColor3 = Color3.fromRGB(200, 200, 200),
			TextSize = 14,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Center,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1),
			Position = UDim2.fromOffset(10, 0),
			ThemeTag = {
				TextColor3 = "Text",
				PlaceholderColor3 = "SubText",
			},
		})

		Textbox.Container = New("Frame", {
			BackgroundTransparency = 1,
			ClipsDescendants = true,
			Position = UDim2.new(0, 6, 0, 0),
			Size = UDim2.new(1, -12, 1, 0),
		}, {
			Textbox.Input,
		})

		Textbox.Indicator = New("Frame", {
			Size = UDim2.new(1, -4, 0, 1),
			Position = UDim2.new(0, 2, 1, 0),
			AnchorPoint = Vector2.new(0, 1),
			BackgroundTransparency = Acrylic and 0.5 or 0,
			ThemeTag = {
				BackgroundColor3 = Acrylic and "InputIndicator" or TagSet.InputLine,
			},
		})

		Textbox.Frame = New("Frame", {
			Size = UDim2.new(0, 0, 0, 30),
			BackgroundTransparency = Acrylic and 0.9 or 0,
			Parent = Parent,
			ThemeTag = {
				BackgroundColor3 = Acrylic and "Input" or TagSet.Input,
			},
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 4),
			}),
			New("UIStroke", {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Transparency = Acrylic and 0.5 or 0.65,
				ThemeTag = {
					Color = Acrylic and "InElementBorder" or TagSet.InputBorder,
				},
			}),
			Textbox.Indicator,
			Textbox.Container,
		})

		local function Update()
			local PADDING = 2
			local Reveal = Textbox.Container.AbsoluteSize.X

			if not Textbox.Input:IsFocused() or Textbox.Input.TextBounds.X <= Reveal - 2 * PADDING then
				Textbox.Input.Position = UDim2.new(0, PADDING, 0, 0)
			else
				local Cursor = Textbox.Input.CursorPosition
				if Cursor ~= -1 then
					local subtext = string.sub(Textbox.Input.Text, 1, Cursor - 1)
					local width = TextService:GetTextSize(
						subtext,
						Textbox.Input.TextSize,
						Textbox.Input.Font,
						Vector2.new(math.huge, math.huge)
					).X

					local CurrentCursorPos = Textbox.Input.Position.X.Offset + width
					if CurrentCursorPos < PADDING then
						Textbox.Input.Position = UDim2.fromOffset(PADDING - width, 0)
					elseif CurrentCursorPos > Reveal - PADDING - 1 then
						Textbox.Input.Position = UDim2.fromOffset(Reveal - width - PADDING - 1, 0)
					end
				end
			end
		end

		task.spawn(Update)

		Creator.AddSignal(Textbox.Input:GetPropertyChangedSignal("Text"), Update)
		Creator.AddSignal(Textbox.Input:GetPropertyChangedSignal("CursorPosition"), Update)

		Creator.AddSignal(Textbox.Input.Focused, function()
			Update()
			Textbox.Indicator.Size = UDim2.new(1, -2, 0, 2)
			Textbox.Indicator.Position = UDim2.new(0, 1, 1, 0)
			Textbox.Indicator.BackgroundTransparency = 0
			Creator.OverrideTag(Textbox.Frame, { BackgroundColor3 = Acrylic and "InputFocused" or TagSet.InputFocused })
			Creator.OverrideTag(Textbox.Indicator, { BackgroundColor3 = "Accent" })
		end)

		Creator.AddSignal(Textbox.Input.FocusLost, function()
			Update()
			Textbox.Indicator.Size = UDim2.new(1, -4, 0, 1)
			Textbox.Indicator.Position = UDim2.new(0, 2, 1, 0)
			Textbox.Indicator.BackgroundTransparency = 0.5
			Creator.OverrideTag(Textbox.Frame, { BackgroundColor3 = Acrylic and "Input" or TagSet.Input })
			Creator.OverrideTag(Textbox.Indicator, { BackgroundColor3 = Acrylic and "InputIndicator" or TagSet.InputLine })
		end)

		return Textbox
	end
end)()

Components.Section = (function()
	local New = Creator.New

	return function(Title, Parent)
		local Section = {}

		Section.Layout = New("UIListLayout", {
			Padding = UDim.new(0, 5),
			SortOrder = Enum.SortOrder.LayoutOrder,
		})

		Section.Container = New("Frame", {
			Size = UDim2.new(1, 0, 0, 26),
			Position = UDim2.fromOffset(0, 24),
			BackgroundTransparency = 1,
		}, {
			Section.Layout,
		})

		Section.TitleLabel = New("TextLabel", {
			RichText = true,
			Text = Title,
			TextTransparency = 0,
			FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
			TextSize = 18,
			TextXAlignment = "Left",
			TextYAlignment = "Center",
			Size = UDim2.new(1, -16, 0, 18),
			Position = UDim2.fromOffset(0, 2),
			ThemeTag = {
				TextColor3 = "Text",
			},
		})

		Section.Root = New("Frame", {
			Name = "SectionRoot",
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, 26),
			LayoutOrder = 0,
			Parent = Parent,
		}, {
			Section.TitleLabel,
			Section.Container,
		})

		Creator.AttachTitleDesc(Section, Section.TitleLabel, nil)

		Creator.AddSignal(Section.Layout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
			Section.Container.Size = UDim2.new(1, 0, 0, Section.Layout.AbsoluteContentSize.Y)
			Section.Root.Size = UDim2.new(1, 0, 0, Section.Layout.AbsoluteContentSize.Y + 25)
		end)
		return Section
	end
end)()

Components.TitleBar = (function()
	local New = Creator.New
	local AddSignal = Creator.AddSignal

	return function(Config)
		local Assets = Library.NewVisual and Components.AssetsNew or Components.Assets
		local TitleBar = {}

		local function BarButton(Icon, Pos, Parent, Callback)
			local Button = {
				Callback = Callback or function() end,
			}

			Button.Frame = New("TextButton", {
				Size = UDim2.new(0, 34, 1, -8),
				AnchorPoint = Vector2.new(1, 0),
				BackgroundTransparency = 1,
				Parent = Parent,
				Position = Pos,
				Text = "",
				ThemeTag = {
					BackgroundColor3 = "Text",
				},
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(0, 7),
				}),
				New("ImageLabel", {
					Image = Icon,
					Size = UDim2.fromOffset(16, 16),
					Position = UDim2.fromScale(0.5, 0.5),
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundTransparency = 1,
					Name = "Icon",
					ThemeTag = {
						ImageColor3 = "Text",
					},
				}),
			})

			local Motor, SetTransparency = Creator.SpringMotor(1, Button.Frame, "BackgroundTransparency")

			AddSignal(Button.Frame.MouseEnter, function()
				SetTransparency(0.94)
			end)
			AddSignal(Button.Frame.MouseLeave, function()
				SetTransparency(1, true)
			end)
			AddSignal(Button.Frame.MouseButton1Down, function()
				SetTransparency(0.96)
			end)
			AddSignal(Button.Frame.MouseButton1Up, function()
				SetTransparency(0.94)
			end)
			AddSignal(Button.Frame.MouseButton1Click, Button.Callback)

			Button.SetCallback = function(Func)
				Button.Callback = Func
			end

			return Button
		end

		local WindowTitleLabel = New("TextLabel", {
			RichText = true,
			Text = Config.Title,
			FontFace = Font.new(Library.Font, Enum.FontWeight.Regular, Enum.FontStyle.Normal),
			TextSize = 12,
			TextXAlignment = "Left",
			TextYAlignment = "Center",
			Size = UDim2.new(0, 0, 0, 14),
			AutomaticSize = Enum.AutomaticSize.X,
			BackgroundTransparency = 1,
			ThemeTag = {
				TextColor3 = "Text",
			},
		})

		local WindowSubTitleLabel = New("TextLabel", {
			RichText = true,
			Text = Config.SubTitle,
			TextTransparency = 0.4,
			FontFace = Font.new(Library.Font, Enum.FontWeight.Regular, Enum.FontStyle.Normal),
			TextSize = 12,
			TextXAlignment = "Left",
			TextYAlignment = "Center",
			Size = UDim2.new(0, 0, 0, 14),
			AutomaticSize = Enum.AutomaticSize.X,
			BackgroundTransparency = 1,
			ThemeTag = {
				TextColor3 = "Text",
			},
		})

		TitleBar.TitleLabel = WindowTitleLabel
		TitleBar.SubTitleLabel = WindowSubTitleLabel
		Creator.AttachTitleDesc(TitleBar, WindowTitleLabel, WindowSubTitleLabel)
		TitleBar.SetSubTitle = TitleBar.SetDesc

		TitleBar.Frame = New("Frame", {
			Size = UDim2.new(1, 0, 0, 42),
			BackgroundTransparency = 1,
			Parent = Config.Parent,
		}, {
			New("Frame", {
				Size = UDim2.new(1, -16, 1, 0),
				Position = UDim2.new(0, 16, 0, 0),
				BackgroundTransparency = 1,
			}, {
				New("UIListLayout", {
					Padding = UDim.new(0, 1),
					FillDirection = Enum.FillDirection.Vertical,
					VerticalAlignment = Enum.VerticalAlignment.Center,
					SortOrder = Enum.SortOrder.LayoutOrder,
				}),
				WindowTitleLabel,
				WindowSubTitleLabel,
			}),
			New("Frame", {
				BackgroundTransparency = 0.5,
				Size = UDim2.new(1, 0, 0, 1),
				Position = UDim2.new(0, 0, 1, 0),
				ThemeTag = {
					BackgroundColor3 = "TitleBarLine",
				},
			}),
		})

		TitleBar.CloseButton = BarButton(Assets.Close, UDim2.new(1, -4, 0, 4), TitleBar.Frame, function()
			Library.Window:Dialog({
				Title = "Close",
				Content = "Are you sure you want to unload the interface?",
				Buttons = {
					{
						Title = "Yes",
						Callback = function()
							Library:Destroy()
						end,
					},
					{
						Title = "No",
					},
				},
			})
		end)
		TitleBar.MaxButton = BarButton(Assets.Max, UDim2.new(1, -40, 0, 4), TitleBar.Frame, function()
			Config.Window.Maximize(not Config.Window.Maximized)
		end)
		TitleBar.MinButton = BarButton(Assets.Min, UDim2.new(1, -80, 0, 4), TitleBar.Frame, function()
			Library.Window:Minimize()
		end)

		return TitleBar
	end
end)()

Components.Notification = (function()
	local Spring = Flipper.Spring.new
	local Instant = Flipper.Instant.new
	local New = Creator.New

	local Notification = {}

	function Notification:Init(GUI)
		Notification.Holder = New("Frame", {
			Position = UDim2.new(1, -30, 1, -30),
			Size = UDim2.new(0, 310, 1, -30),
			AnchorPoint = Vector2.new(1, 1),
			BackgroundTransparency = 1,
			Parent = GUI,
		}, {
			New("UIListLayout", {
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
				VerticalAlignment = Enum.VerticalAlignment.Bottom,
				Padding = UDim.new(0, 20),
			}),
		})
	end

	function Notification:New(Config)
		Config.Title = Config.Title or "Title"
		Config.Content = Config.Content or "Content"
		Config.SubContent = Config.SubContent or ""
		Config.Duration = Config.Duration or nil
		Config.Buttons = Config.Buttons or {}
		local NewNotification = {
			Closed = false,
		}

		NewNotification.AcrylicPaint = Acrylic.AcrylicPaint()

		local ResolvedIcon = Config.Icon
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

		local IconOffset = IconImage and 26 or 0

		NewNotification.Title = New("TextLabel", {
			Text = Config.Title,
			RichText = true,
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextTransparency = 0,
			FontFace = Font.new(Library.Font),
			TextSize = 13,
			TextXAlignment = "Left",
			TextYAlignment = "Center",
			Size = UDim2.new(1, 0, 0, 12),
			TextWrapped = true,
			BackgroundTransparency = 1,
			LayoutOrder = 1,
			ThemeTag = {
				TextColor3 = "Text",
			},
		})

		NewNotification.ContentLabel = New("TextLabel", {
			FontFace = Font.new(Library.Font),
			Text = Config.Content,
			TextColor3 = Color3.fromRGB(240, 240, 240),
			TextSize = 14,
			TextXAlignment = Enum.TextXAlignment.Left,
			AutomaticSize = Enum.AutomaticSize.Y,
			Size = UDim2.new(1, 0, 0, 14),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			TextWrapped = true,
			ThemeTag = {
				TextColor3 = "Text",
			},
		})

		NewNotification.SubContentLabel = New("TextLabel", {
			FontFace = Font.new(Library.Font),
			Text = Config.SubContent,
			TextColor3 = Color3.fromRGB(240, 240, 240),
			TextSize = 14,
			TextXAlignment = Enum.TextXAlignment.Left,
			AutomaticSize = Enum.AutomaticSize.Y,
			Size = UDim2.new(1, 0, 0, 14),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			TextWrapped = true,
			ThemeTag = {
				TextColor3 = "SubText",
			},
		})

		NewNotification.LabelHolder = New("Frame", {
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, 0),
			LayoutOrder = 2,
		}, {
			New("UIListLayout", {
				SortOrder = Enum.SortOrder.LayoutOrder,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				Padding = UDim.new(0, 3),
			}),
			NewNotification.ContentLabel,
			NewNotification.SubContentLabel,
		})

		NewNotification.TextHolder = New("Frame", {
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			Position = UDim2.fromOffset(14 + IconOffset, 17),
			Size = UDim2.new(1, -28 - IconOffset, 0, 0),
		}, {
			New("UIListLayout", {
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 11),
			}),
			NewNotification.Title,
			NewNotification.LabelHolder,
		})

		if IconImage then
			NewNotification.IconLabel = New("ImageLabel", {
				Image = IconImage,
				ImageRectOffset = IconRectOffset,
				ImageRectSize = IconRectSize,
				Size = UDim2.fromOffset(20, 20),
				Position = UDim2.fromOffset(14, 17),
				BackgroundTransparency = 1,
				ZIndex = 2,
				ThemeTag = {
					ImageColor3 = "Text",
				},
			})

			local function UpdateIconPosition()
				local TextHeight = NewNotification.TextHolder.AbsoluteSize.Y
				NewNotification.IconLabel.Position = UDim2.fromOffset(14, 17 + (TextHeight / 2) - 10)
			end

			Creator.AddSignal(NewNotification.TextHolder:GetPropertyChangedSignal("AbsoluteSize"), UpdateIconPosition)
			task.defer(UpdateIconPosition)
		end

		NewNotification.CloseButton = New("TextButton", {
			Text = "",
			Position = UDim2.new(1, -14, 0, 13),
			Size = UDim2.fromOffset(20, 20),
			AnchorPoint = Vector2.new(1, 0),
			BackgroundTransparency = 1,
		}, {
			New("ImageLabel", {
				Image = (Library.NewVisual and Components.AssetsNew or Components.Assets).Close,
				Size = UDim2.fromOffset(16, 16),
				Position = UDim2.fromScale(0.5, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundTransparency = 1,
				ThemeTag = {
					ImageColor3 = "Text",
				},
			}),
		})

		local RootChildren = {
			NewNotification.AcrylicPaint.Frame,
			NewNotification.CloseButton,
			NewNotification.TextHolder,
		}
		if NewNotification.IconLabel then
			table.insert(RootChildren, NewNotification.IconLabel)
		end

		NewNotification.Root = New("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, 0),
			Position = UDim2.fromScale(1, 0),
		}, RootChildren)

		if Config.Content == "" then
			NewNotification.ContentLabel.Visible = false
		end

		if Config.SubContent == "" then
			NewNotification.SubContentLabel.Visible = false
		end

		NewNotification.Holder = New("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, 200),
			Parent = Notification.Holder,
		}, {
			NewNotification.Root,
		})

		local RootMotor = Flipper.GroupMotor.new({
			Scale = 1,
			Offset = 60,
		})

		RootMotor:onStep(function(Values)
			NewNotification.Root.Position = UDim2.new(Values.Scale, Values.Offset, 0, 0)
		end)

		Creator.AddSignal(NewNotification.CloseButton.MouseButton1Click, function()
			NewNotification:Close()
		end)

		function NewNotification:Open()
			local ContentSize = NewNotification.LabelHolder.AbsoluteSize.Y
			NewNotification.Holder.Size = UDim2.new(1, 0, 0, 58 + ContentSize)

			RootMotor:setGoal({
				Scale = Spring(0, { frequency = 5 }),
				Offset = Spring(0, { frequency = 5 }),
			})
		end

		function NewNotification:Close()
			if not NewNotification.Closed then
				NewNotification.Closed = true
				task.spawn(function()
					RootMotor:setGoal({
						Scale = Spring(1, { frequency = 5 }),
						Offset = Spring(60, { frequency = 5 }),
					})
					task.wait(0.4)
					if Library.UseAcrylic then
						NewNotification.AcrylicPaint.Model:Destroy()
					end
					NewNotification.Holder:Destroy()
				end)
			end
		end

		NewNotification:Open()
		if Config.Duration then
			task.delay(Config.Duration, function()
				NewNotification:Close()
			end)
		end
		return NewNotification
	end

	return Notification
end)()

Components.Dialog = (function()
	local Spring = Flipper.Spring.new
	local Instant = Flipper.Instant.new
	local New = Creator.New

	local Dialog = {
		Window = nil,
	}

	function Dialog:Init(Window)
		Dialog.Window = Window
		return Dialog
	end

	function Dialog:Create()
		local NewDialog = {
			Buttons = 0,
		}

		NewDialog.TintFrame = New("TextButton", {
			Text = "",
			Size = UDim2.fromScale(1, 1),
			BackgroundColor3 = Color3.fromRGB(0, 0, 0),
			BackgroundTransparency = 1,
			Parent = Dialog.Window.Root,
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 8),
			}),
		})

		local TintMotor, TintTransparency = Creator.SpringMotor(1, NewDialog.TintFrame, "BackgroundTransparency", true)

		NewDialog.ButtonHolder = New("Frame", {
			Size = UDim2.new(1, -40, 1, -40),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			BackgroundTransparency = 1,
		}, {
			New("UIListLayout", {
				Padding = UDim.new(0, 10),
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
			}),
		})

		NewDialog.HolderLine = New("Frame", {
			Size = UDim2.new(1, 0, 0, 1),
			ThemeTag = {
				BackgroundColor3 = "DialogHolderLine",
			},
		})

		NewDialog.ButtonHolderFrame = New("Frame", {
			Size = UDim2.new(1, 0, 0, 70),
			Position = UDim2.new(0, 0, 1, -70),
			ThemeTag = {
				BackgroundColor3 = "DialogHolder",
			},
		}, {
			NewDialog.HolderLine,
			NewDialog.ButtonHolder,
		})

		NewDialog.Title = New("TextLabel", {
			FontFace = Font.new(Library.Font, Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
			Text = "Dialog",
			TextColor3 = Color3.fromRGB(240, 240, 240),
			TextSize = 22,
			TextXAlignment = Enum.TextXAlignment.Left,
			Size = UDim2.new(1, 0, 0, 22),
			Position = UDim2.fromOffset(20, 25),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			ThemeTag = {
				TextColor3 = "Text",
			},
		})

		NewDialog.Scale = New("UIScale", {
			Scale = 1,
		})

		local ScaleMotor, Scale = Creator.SpringMotor(1.1, NewDialog.Scale, "Scale")

		NewDialog.Root = New("CanvasGroup", {
			Size = UDim2.fromOffset(300, 165),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			GroupTransparency = 1,
			Parent = NewDialog.TintFrame,
			ThemeTag = {
				BackgroundColor3 = "Dialog",
			},
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 8),
			}),
			New("UIStroke", {
				Transparency = 0.5,
				ThemeTag = {
					Color = "DialogBorder",
				},
			}),
			NewDialog.Scale,
			NewDialog.Title,
			NewDialog.ButtonHolderFrame,
		})

		local RootMotor, RootTransparency = Creator.SpringMotor(1, NewDialog.Root, "GroupTransparency")

		function NewDialog:Open()
			Library.DialogOpen = true
			NewDialog.Scale.Scale = 1.1
			TintTransparency(0.75)
			RootTransparency(0)
			Scale(1)
		end

		function NewDialog:Close()
			Library.DialogOpen = false
			TintTransparency(1)
			RootTransparency(1)
			Scale(1.1)
			NewDialog.Root.UIStroke:Destroy()
			task.wait(0.15)
			NewDialog.TintFrame:Destroy()
		end

		function NewDialog:Button(Title, Callback)
			NewDialog.Buttons = NewDialog.Buttons + 1
			Title = Title or "Button"
			Callback = Callback or function() end

			local Button = Components.Button("", NewDialog.ButtonHolder, true)
			Button.Title.Text = Title

			for _, Btn in next, NewDialog.ButtonHolder:GetChildren() do
				if Btn:IsA("TextButton") then
					Btn.Size =
						UDim2.new(1 / NewDialog.Buttons, -(((NewDialog.Buttons - 1) * 10) / NewDialog.Buttons), 0, 32)
				end
			end

			Creator.AddSignal(Button.Frame.MouseButton1Click, function()
				Library:SafeCallback(Callback)
				pcall(function()
					NewDialog:Close()
				end)
			end)

			return Button
		end

		return NewDialog
	end

	return Dialog
end)()

Components.SidePanel = (function()
	local Spring = Flipper.Spring.new
	local New = Creator.New

	local SidePanel = {
		Window = nil,
	}

	function SidePanel:Init(Window)
		SidePanel.Window = Window
		return SidePanel
	end

	function SidePanel:Create(Config)
		Config = Config or {}
		local Side = Config.Side == "Left" and "Left" or "Right"
		local PanelWidth = Config.Width or 300
		local AnchorX = Side == "Right" and 1 or 0

		local NewPanel = {
			Buttons = 0,
			Rows = 0,
			Side = Side,
		}

		setmetatable(NewPanel, Elements)

		NewPanel.TintFrame = New("TextButton", {
			Text = "",
			Size = UDim2.fromScale(1, 1),
			BackgroundColor3 = Color3.fromRGB(0, 0, 0),
			BackgroundTransparency = 1,
			Parent = SidePanel.Window.Root,
		})

		local TintMotor, TintTransparency = Creator.SpringMotor(1, NewPanel.TintFrame, "BackgroundTransparency", true)

		NewPanel.Title = New("TextLabel", {
			FontFace = Font.new(Library.Font, Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
			Text = Config.Title or "Panel",
			TextColor3 = Color3.fromRGB(240, 240, 240),
			TextSize = 18,
			TextXAlignment = Enum.TextXAlignment.Left,
			Size = UDim2.new(1, -40, 0, 20),
			Position = UDim2.fromOffset(20, 18),
			BackgroundTransparency = 1,
			ThemeTag = {
				TextColor3 = "Text",
			},
		})

		NewPanel.Description = New("TextLabel", {
			FontFace = Font.new(Library.Font),
			Text = Config.Description or "",
			Visible = Config.Description ~= nil and Config.Description ~= "",
			TextColor3 = Color3.fromRGB(200, 200, 200),
			TextSize = 13,
			TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Left,
			Size = UDim2.new(1, -40, 0, 16),
			Position = UDim2.fromOffset(20, 42),
			BackgroundTransparency = 1,
			ThemeTag = {
				TextColor3 = "SubText",
			},
		})

		NewPanel.RowHolder = New("ScrollingFrame", {
			Size = UDim2.new(1, -20, 1, -140),
			Position = UDim2.fromOffset(10, 68),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ScrollBarThickness = 3,
			ScrollBarImageTransparency = 0.4,
			CanvasSize = UDim2.fromScale(0, 0),
			AutomaticCanvasSize = Enum.AutomaticSize.Y,
			ScrollingDirection = Enum.ScrollingDirection.Y,
			ClipsDescendants = true,
		}, {
			New("UIListLayout", {
				Padding = UDim.new(0, 8),
				SortOrder = Enum.SortOrder.LayoutOrder,
			}),
			New("UIPadding", {
				PaddingTop = UDim.new(0, 4),
				PaddingBottom = UDim.new(0, 8),
				PaddingLeft = UDim.new(0, 4),
				PaddingRight = UDim.new(0, 4),
			}),
		})

		NewPanel.Container = NewPanel.RowHolder
		NewPanel.Type = "Group"
		NewPanel.ScrollFrame = NewPanel.RowHolder
		NewPanel.Library = Library

		NewPanel.HolderLine = New("Frame", {
			Size = UDim2.new(1, 0, 0, 1),
			ThemeTag = {
				BackgroundColor3 = "DialogHolderLine",
			},
		})

		NewPanel.ButtonHolder = New("Frame", {
			Size = UDim2.new(1, -20, 0, 32),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundTransparency = 1,
		}, {
			New("UIListLayout", {
				Padding = UDim.new(0, 10),
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
			}),
		})

		NewPanel.ButtonHolderFrame = New("Frame", {
			Size = UDim2.new(1, 0, 0, 64),
			Position = UDim2.new(0, 0, 1, -64),
			ThemeTag = {
				BackgroundColor3 = "DialogHolder",
			},
		}, {
			NewPanel.HolderLine,
			NewPanel.ButtonHolder,
		})

		NewPanel.SlideOffset = Side == "Right" and (PanelWidth + 24) or -(PanelWidth + 24)
		local SlideMotor = Flipper.SingleMotor.new(NewPanel.SlideOffset)

		NewPanel.Root = New("CanvasGroup", {
			Size = UDim2.new(0, PanelWidth, 1, -20),
			AnchorPoint = Vector2.new(AnchorX, 0.5),
			Position = UDim2.new(AnchorX, NewPanel.SlideOffset, 0.5, 0),
			GroupTransparency = 1,
			Parent = NewPanel.TintFrame,
			ThemeTag = {
				BackgroundColor3 = "Dialog",
			},
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 8),
			}),
			New("UIStroke", {
				Transparency = 0.5,
				ThemeTag = {
					Color = "DialogBorder",
				},
			}),
			NewPanel.Title,
			NewPanel.Description,
			NewPanel.RowHolder,
			NewPanel.ButtonHolderFrame,
		})

		SlideMotor:onStep(function(Value)
			NewPanel.Root.Position = UDim2.new(AnchorX, Value, 0.5, 0)
		end)

		local RootMotor, RootTransparency = Creator.SpringMotor(1, NewPanel.Root, "GroupTransparency")

		function NewPanel:Open()
			Library.DialogOpen = true
			TintTransparency(0.75)
			RootTransparency(0)
			SlideMotor:setGoal(Spring(0, { frequency = 5 }))
		end

		Creator.AddSignal(NewPanel.TintFrame.MouseButton1Click, function()
			pcall(function()
				NewPanel:Close()
			end)
		end)

		function NewPanel:Close()
			Library.DialogOpen = false
			TintTransparency(1)
			RootTransparency(1)
			SlideMotor:setGoal(Spring(NewPanel.SlideOffset, { frequency = 5 }))
			pcall(function()
				NewPanel.Root.UIStroke:Destroy()
			end)
			task.wait(0.2)
			NewPanel.TintFrame:Destroy()
		end

		function NewPanel:Button(Title, Callback)
			NewPanel.Buttons = NewPanel.Buttons + 1
			Title = Title or "Button"
			Callback = Callback or function() end

			local Button = Components.Button("", NewPanel.ButtonHolder, true)
			Button.Title.Text = Title
			Button.Frame.LayoutOrder = NewPanel.Buttons

			for _, Btn in next, NewPanel.ButtonHolder:GetChildren() do
				if Btn:IsA("TextButton") then
					Btn.Size = UDim2.new(1 / NewPanel.Buttons, -(((NewPanel.Buttons - 1) * 10) / NewPanel.Buttons), 0, 32)
				end
			end

			Creator.AddSignal(Button.Frame.MouseButton1Click, function()
				Library:SafeCallback(Callback)
			end)

			return Button
		end

		function NewPanel:AddInput(IdxOrConfig, RowConfig)
			local Idx
			if type(IdxOrConfig) == "table" then
				RowConfig = IdxOrConfig
			else
				Idx = IdxOrConfig
			end
			RowConfig = RowConfig or {}
			NewPanel.Rows = NewPanel.Rows + 1

			local Row = Components.Element(
				RowConfig.Title,
				RowConfig.Description,
				NewPanel.RowHolder,
				false,
				NewPanel.Rows,
				RowConfig.Icon,
				RowConfig.Marquee == true
			)

			local Textbox = Components.Textbox(Row.Frame, true)
			Textbox.Frame.Position = UDim2.new(1, -10, 0.5, 0)
			Textbox.Frame.AnchorPoint = Vector2.new(1, 0.5)
			Textbox.Frame.Size = UDim2.fromOffset(140, 30)
			Textbox.Input.Text = RowConfig.Default or ""
			Textbox.Input.PlaceholderText = RowConfig.Placeholder or ""

			local RowInput = {
				Value = RowConfig.Default or "",
				Frame = Row.Frame,
				Type = "Input",
				SetTitle = Row.SetTitle,
				SetDesc = Row.SetDesc,
			}

			local function Commit()
				RowInput.Value = Textbox.Input.Text
				Library:SafeCallback(RowConfig.Callback, RowInput.Value)
			end

			if RowConfig.Finished then
				Creator.AddSignal(Textbox.Input.FocusLost, function(EnterPressed)
					Commit()
				end)
			else
				Creator.AddSignal(Textbox.Input:GetPropertyChangedSignal("Text"), Commit)
			end

			function RowInput:SetValue(Text)
				Textbox.Input.Text = Text
				RowInput.Value = Text
			end

			function RowInput:Destroy()
				if Idx then
					Library.Options[Idx] = nil
				end
			end

			if Idx then
				Library.Options[Idx] = RowInput
			end

			return RowInput
		end

		function NewPanel:AddButton(IdxOrConfig, RowConfig)
			if type(IdxOrConfig) == "table" then
				RowConfig = IdxOrConfig
			end
			RowConfig = RowConfig or {}
			NewPanel.Rows = NewPanel.Rows + 1

			local Row = Components.Element(
				RowConfig.Title,
				RowConfig.Description,
				NewPanel.RowHolder,
				true,
				NewPanel.Rows,
				RowConfig.Icon,
				RowConfig.Marquee == true
			)

			New("ImageLabel", {
				Image = "rbxassetid://10709791437",
				Size = UDim2.fromOffset(16, 16),
				AnchorPoint = Vector2.new(1, 0.5),
				Position = UDim2.new(1, -10, 0.5, 0),
				BackgroundTransparency = 1,
				Parent = Row.Frame,
				ThemeTag = {
					ImageColor3 = "Text",
				},
			})

			Creator.AddSignal(Row.Frame.MouseButton1Click, function()
				Library:SafeCallback(RowConfig.Callback)
			end)

			return {
				Frame = Row.Frame,
				Type = "Button",
				SetTitle = Row.SetTitle,
				SetDesc = Row.SetDesc,
			}
		end

		function NewPanel:AddToggle(Idx, RowConfig)
			RowConfig = RowConfig or {}
			NewPanel.Rows = NewPanel.Rows + 1
			RowConfig.LayoutOrder = NewPanel.Rows
			return Elements.AddToggle(NewPanel, Idx, RowConfig)
		end

		function NewPanel:AddSlider(Idx, RowConfig)
			RowConfig = RowConfig or {}
			NewPanel.Rows = NewPanel.Rows + 1
			RowConfig.LayoutOrder = NewPanel.Rows
			return Elements.AddSlider(NewPanel, Idx, RowConfig)
		end

		function NewPanel:AddColorpicker(Idx, RowConfig)
			RowConfig = RowConfig or {}
			NewPanel.Rows = NewPanel.Rows + 1
			RowConfig.LayoutOrder = NewPanel.Rows
			return Elements.AddColorpicker(NewPanel, Idx, RowConfig)
		end

		function NewPanel:AddDropdown(Idx, RowConfig)
			RowConfig = RowConfig or {}
			NewPanel.Rows = NewPanel.Rows + 1
			RowConfig.LayoutOrder = NewPanel.Rows
			return Elements.AddDropdown(NewPanel, Idx, RowConfig)
		end

		function NewPanel:AddGradientPicker(Idx, RowConfig)
			RowConfig = RowConfig or {}
			NewPanel.Rows = NewPanel.Rows + 1
			RowConfig.LayoutOrder = NewPanel.Rows
			return Elements.AddGradientPicker(NewPanel, Idx, RowConfig)
		end

		function NewPanel:PromptImport(ImportConfig)
			ImportConfig = ImportConfig or {}

			local ImportDialog = Components.Dialog:Create()
			ImportDialog.Title.Text = ImportConfig.Title or "Import"
			ImportDialog.Root.Size = UDim2.fromOffset(320, 190)

			local ImportBox = Components.Textbox(nil, false)
			ImportBox.Frame.Parent = ImportDialog.Root
			ImportBox.Frame.Position = UDim2.fromOffset(20, 60)
			ImportBox.Frame.Size = UDim2.new(1, -40, 0, 32)
			ImportBox.Input.Text = ImportConfig.Default or ""
			ImportBox.Input.PlaceholderText = ImportConfig.Placeholder or "Paste import string here"

			ImportDialog:Button("Cancel", function()
				Library:SafeCallback(ImportConfig.OnCancel)
			end)

			ImportDialog:Button("Confirm", function()
				Library:SafeCallback(ImportConfig.Callback, ImportBox.Input.Text)
			end)

			ImportDialog:Open()
			return ImportDialog
		end

		if Config.Buttons and #Config.Buttons > 0 then
			for _, BtnCfg in ipairs(Config.Buttons) do
				NewPanel:Button(BtnCfg.Title or "Button", function()
					Library:SafeCallback(BtnCfg.Callback)
					if BtnCfg.CloseOnClick ~= false then
						pcall(function() NewPanel:Close() end)
					end
				end)
			end
		end

		return NewPanel
	end

	return SidePanel
end)()

Components.Tab = (function()
	local New = Creator.New
	local Spring = Flipper.Spring.new
	local Instant = Flipper.Instant.new
	local TextService = game:GetService("TextService")

	local function GetHeaderTextWidth(Text)
		return TextService:GetTextSize(
			Text,
			12,
			Enum.Font.GothamMedium,
			Vector2.new(math.huge, math.huge)
		).X
	end

	local function CreateHeaderChip(TabModule, TabIndex, Title, IconImage, IconRectOffset, IconRectSize)
		local Window = TabModule.Window
		local HasIcon = IconImage ~= nil
		local CollapsedWidth = HasIcon and 36 or 26
		local ExpandedWidth = CollapsedWidth + GetHeaderTextWidth(Title) + (HasIcon and 10 or 8)

		local Chip = {
			Selected = false,
			Hovering = false,
		}

		Chip.Frame = New("Frame", {
			Size = UDim2.fromOffset(CollapsedWidth, 28),
			BackgroundTransparency = 1,
			LayoutOrder = TabIndex,
			ClipsDescendants = true,
			Parent = Window.NavigatorHolder,
			ThemeTag = {
				BackgroundColor3 = "Tab",
			},
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 6),
			}),
		})

		if HasIcon then
			Chip.Icon = New("ImageLabel", {
				Size = UDim2.fromOffset(16, 16),
				Position = UDim2.new(0, 10, 0.5, 0),
				AnchorPoint = Vector2.new(0, 0.5),
				BackgroundTransparency = 1,
				Image = IconImage,
				ImageRectOffset = IconRectOffset,
				ImageRectSize = IconRectSize,
				Parent = Chip.Frame,
				ThemeTag = {
					ImageColor3 = "Text",
				},
			})
		else
			Chip.Icon = New("TextLabel", {
				Size = UDim2.fromOffset(16, 16),
				Position = UDim2.new(0, 5, 0.5, 0),
				AnchorPoint = Vector2.new(0, 0.5),
				BackgroundTransparency = 1,
				Text = string.upper(string.sub(Title, 1, 1)),
				RichText = true,
				FontFace = Font.new(Library.Font, Enum.FontWeight.Bold, Enum.FontStyle.Normal),
				TextSize = 13,
				TextXAlignment = "Center",
				TextYAlignment = "Center",
				Parent = Chip.Frame,
				ThemeTag = {
					TextColor3 = "Text",
				},
			})
		end

		local LabelOffset = HasIcon and 32 or 24

		Chip.Label = New("TextLabel", {
			Text = Title,
			RichText = true,
			TextTransparency = 1,
			FontFace = Font.new(Library.Font, Enum.FontWeight.Medium, Enum.FontStyle.Normal),
			TextSize = 12,
			TextXAlignment = "Left",
			TextYAlignment = "Center",
			BackgroundTransparency = 1,
			Size = UDim2.new(1, -(LabelOffset + 6), 1, 0),
			Position = UDim2.fromOffset(LabelOffset, 0),
			Parent = Chip.Frame,
			ThemeTag = {
				TextColor3 = "Text",
			},
		})

		Chip.HitBox = New("TextButton", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			Text = "",
			Parent = Chip.Frame,
		})

		local WidthMotor = Flipper.SingleMotor.new(CollapsedWidth)
		WidthMotor:onStep(function(Value)
			Chip.Frame.Size = UDim2.fromOffset(Value, 28)
		end)

		local BackgroundMotor, SetBackgroundTransparency = Creator.SpringMotor(1, Chip.Frame, "BackgroundTransparency")
		local LabelMotor, SetLabelTransparency = Creator.SpringMotor(1, Chip.Label, "TextTransparency")

		local SetInitialTransparency
		local LabelPosMotor
		if not HasIcon then
			local InitialMotor
			InitialMotor, SetInitialTransparency = Creator.SpringMotor(0, Chip.Icon, "TextTransparency")
			LabelPosMotor = Flipper.SingleMotor.new(LabelOffset)
			LabelPosMotor:onStep(function(Value)
				Chip.Label.Position = UDim2.fromOffset(Value, 0)
				Chip.Label.Size = UDim2.new(1, -(Value + 6), 1, 0)
			end)
		end

		local function SetExpanded(Expanded)
			WidthMotor:setGoal(Spring(Expanded and ExpandedWidth or CollapsedWidth, { frequency = 7 }))
			SetLabelTransparency(Expanded and 0 or 1)
			if SetInitialTransparency then
				SetInitialTransparency(Expanded and 1 or 0)
				LabelPosMotor:setGoal(Spring(Expanded and 8 or LabelOffset, { frequency = 7 }))
			end
		end

		Creator.AddSignal(Chip.HitBox.MouseEnter, function()
			Chip.Hovering = true
			if not Chip.Selected then
				SetBackgroundTransparency(0.94)
				SetExpanded(true)
			end
		end)

		Creator.AddSignal(Chip.HitBox.MouseLeave, function()
			Chip.Hovering = false
			if not Chip.Selected then
				SetBackgroundTransparency(1, true)
				SetExpanded(false)
			end
		end)

		Creator.AddSignal(Chip.HitBox.MouseButton1Click, function()
			TabModule:SelectTab(TabIndex)
		end)

		Creator.AddSignal(Chip.Frame:GetPropertyChangedSignal("AbsoluteSize"), function()
			if Chip.Selected then
				TabModule:UpdateNavigatorSelector(true)
			end
		end)

		Creator.AddSignal(Chip.Frame:GetPropertyChangedSignal("AbsolutePosition"), function()
			if Chip.Selected then
				TabModule:UpdateNavigatorSelector(true)
			end
		end)

		function Chip.SetTransparency(Value, Ignore)
			Chip.Selected = Value < 1
			SetBackgroundTransparency(Value, Ignore)
			if Chip.Selected then
				SetExpanded(true)
			elseif not Chip.Hovering then
				SetExpanded(false)
			end
		end

		function Chip.SetTitle(Set)
			Set = Set or ""
			Chip.Label.Text = Set
			if not HasIcon then
				Chip.Icon.Text = string.upper(string.sub(Set, 1, 1))
			end
			ExpandedWidth = CollapsedWidth + GetHeaderTextWidth(Set) + (HasIcon and 10 or 8)
			if Chip.Selected or Chip.Hovering then
				SetExpanded(true)
			end
		end

		return Chip
	end

	local TabModule = {
		Window = nil,
		Tabs = {},
		Containers = {},
		SelectedTab = 0,
		TabCount = 0,
		SearchQuery = "",
	}

	function TabModule:Init(Window)
		TabModule.Window = Window
		return TabModule
	end

	function TabModule:GetCurrentTabPos()
		local TabHolderPos = TabModule.Window.TabHolder.AbsolutePosition.Y
		local TabPos = TabModule.Tabs[TabModule.SelectedTab].Frame.AbsolutePosition.Y

		return TabPos - TabHolderPos
	end

	function TabModule:UpdateNavigatorSelector(UseInstant)
		local Window = TabModule.Window
		if not Window.NavigatorHolder then
			return
		end

		local Tab = TabModule.Tabs[TabModule.SelectedTab]
		if not (Tab and Tab.HeaderChip) then
			return
		end

		Window.NavigatorSelector.Visible = true

		local ChipFrame = Tab.HeaderChip.Frame
		local X = ChipFrame.AbsolutePosition.X - Window.NavigatorHolder.AbsolutePosition.X
		local Width = ChipFrame.AbsoluteSize.X

		local MotorType = UseInstant and Instant or Spring
		Window.NavigatorSelectorMotor:setGoal({
			X = MotorType(X, { frequency = 10 }),
			Width = MotorType(Width, { frequency = 10 }),
		})
	end

	function TabModule:ApplyFilter(Query)
		TabModule.SearchQuery = Query or ""
		local Container = TabModule.Containers[TabModule.SelectedTab]
		if not Container then return end

		local NormalizedQuery = TabModule.SearchQuery:lower()

		for _, Descendant in next, Container:GetDescendants() do
			if Descendant.Name == "ElementTitle" then
				local ElementFrame = Descendant.Parent and Descendant.Parent.Parent
				if ElementFrame then
					ElementFrame.Visible = NormalizedQuery == ""
						or string.find(Descendant.Text:lower(), NormalizedQuery, 1, true) ~= nil
				end
			end
		end

		for _, Descendant in next, Container:GetDescendants() do
			if Descendant.Name == "SectionRoot" then
				local Visible = NormalizedQuery == ""
				if not Visible then
					for _, Inner in next, Descendant:GetDescendants() do
						if Inner.Name == "ElementFrame" and Inner.Visible then
							Visible = true
							break
						end
					end
				end
				Descendant.Visible = Visible
			end
		end
	end

	function TabModule:New(Title, Icon, Parent, IsHeaderTab)
		local Window = TabModule.Window
		local Elements = Library.Elements

		TabModule.TabCount = TabModule.TabCount + 1
		local TabIndex = TabModule.TabCount

		local Tab = {
			Selected = false,
			Name = Title,
			Type = "Tab",
			IsHeaderTab = IsHeaderTab or false,
			_layoutOrder = 0,
		}

		if Icon == "" or Icon == nil then
			Icon = nil
		else
			Icon = Library:GetIcon(Icon)
		end

		local IconImage = Icon
		local IconRectOffset, IconRectSize
		if type(Icon) == "table" then
			IconImage = Icon.Image
			IconRectOffset = Icon.ImageRectOffset
			IconRectSize = Icon.ImageRectSize
		end

		if Tab.IsHeaderTab then
			Tab.HeaderChip = CreateHeaderChip(TabModule, TabIndex, Title, IconImage, IconRectOffset, IconRectSize)
			Tab.SetTransparency = Tab.HeaderChip.SetTransparency

			function Tab:SetTitle(Set)
				Set = Set or ""
				Tab.Name = Set
				Tab.HeaderChip.SetTitle(Set)
			end
		else
			Tab.TitleLabel = New("TextLabel", {
				AnchorPoint = Vector2.new(0, 0.5),
				Position = Icon and UDim2.new(0, 30, 0.5, 0) or UDim2.new(0, 12, 0.5, 0),
				Text = Title,
				RichText = true,
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextTransparency = 0,
				FontFace = Font.new(Library.Font, Enum.FontWeight.Regular, Enum.FontStyle.Normal),
				TextSize = 12,
				TextXAlignment = "Left",
				TextYAlignment = "Center",
				Size = UDim2.new(1, -12, 1, 0),
				BackgroundTransparency = 1,
				ThemeTag = {
					TextColor3 = "Text",
				},
			})

			Tab.Frame = New("TextButton", {
				Size = UDim2.new(1, 0, 0, 34),
				BackgroundTransparency = 1,
				Parent = Parent,
				LayoutOrder = TabIndex,
				ThemeTag = {
					BackgroundColor3 = "Tab",
				},
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(0, 6),
				}),
				Tab.TitleLabel,
				New("ImageLabel", {
					AnchorPoint = Vector2.new(0, 0.5),
					Size = UDim2.fromOffset(16, 16),
					Position = UDim2.new(0, 8, 0.5, 0),
					BackgroundTransparency = 1,
					Image = IconImage,
					ImageRectOffset = IconRectOffset,
					ImageRectSize = IconRectSize,
					ThemeTag = {
						ImageColor3 = "Text",
					},
				}),
			})

			Creator.AttachTitleDesc(Tab, Tab.TitleLabel, nil)
			local BaseSetTitle = Tab.SetTitle
			function Tab:SetTitle(Set)
				Tab.Name = Set or ""
				BaseSetTitle(Tab, Set)
			end

			Tab.Motor, Tab.SetTransparency = Creator.SpringMotor(1, Tab.Frame, "BackgroundTransparency")

			Creator.AddSignal(Tab.Frame.MouseEnter, function()
				Tab.SetTransparency(Tab.Selected and 0.85 or 0.89)
			end)
			Creator.AddSignal(Tab.Frame.MouseLeave, function()
				Tab.SetTransparency(Tab.Selected and 0.89 or 1)
			end)
			Creator.AddSignal(Tab.Frame.MouseButton1Down, function()
				Tab.SetTransparency(0.92)
			end)
			Creator.AddSignal(Tab.Frame.MouseButton1Up, function()
				Tab.SetTransparency(Tab.Selected and 0.85 or 0.89)
			end)
			Creator.AddSignal(Tab.Frame.MouseButton1Click, function()
				TabModule:SelectTab(TabIndex)
			end)
		end

		local ContainerLayout = New("UIListLayout", {
			Padding = UDim.new(0, 5),
			SortOrder = Enum.SortOrder.LayoutOrder,
		})

		Tab.ContainerFrame = New("ScrollingFrame", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			Parent = Window.ContainerHolder,
			Visible = false,
			BottomImage = "rbxassetid://6889812791",
			MidImage = "rbxassetid://6889812721",
			TopImage = "rbxassetid://6276641225",
			ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255),
			ScrollBarImageTransparency = 0.95,
			ScrollBarThickness = 3,
			BorderSizePixel = 0,
			CanvasSize = UDim2.fromScale(0, 0),
			ScrollingDirection = Enum.ScrollingDirection.Y,
		}, {
			ContainerLayout,
			New("UIPadding", {
				PaddingRight = UDim.new(0, 10),
				PaddingLeft = UDim.new(0, 1),
				PaddingTop = UDim.new(0, 1),
				PaddingBottom = UDim.new(0, 1),
			}),
		})

		Creator.AddSignal(ContainerLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
			Tab.ContainerFrame.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y + 2)
		end)

		TabModule.Containers[TabIndex] = Tab.ContainerFrame
		TabModule.Tabs[TabIndex] = Tab

		Tab.Container = Tab.ContainerFrame
		Tab.ScrollFrame = Tab.Container

		function Tab:AddSection(SectionTitle)
			local Section = { Type = "Section", _layoutOrder = 0 }

			Tab._layoutOrder = (Tab._layoutOrder or 0) + 1
			local SectionFrame = Components.Section(SectionTitle, Tab.Container)
			SectionFrame.Root.LayoutOrder = Tab._layoutOrder

			Section.Container = SectionFrame.Container
			Section.ScrollFrame = Tab.Container
			Creator.AttachTitleDesc(Section, SectionFrame.TitleLabel, nil)

			setmetatable(Section, Elements)
			return Section
		end
		Tab.Section = Tab.AddSection

		setmetatable(Tab, Elements)
		return Tab
	end

	function TabModule:SelectTab(Tab)
		local Window = TabModule.Window

		TabModule.SelectedTab = Tab

		for _, TabObject in next, TabModule.Tabs do
			TabObject.SetTransparency(1)
			TabObject.Selected = false
		end
		TabModule.Tabs[Tab].SetTransparency(0.89)
		TabModule.Tabs[Tab].Selected = true

		Window.TabDisplay.Text = TabModule.Tabs[Tab].Name

		if TabModule.Tabs[Tab].IsHeaderTab then
			Window.Selector.Visible = false
			TabModule:UpdateNavigatorSelector()
		else
			Window.NavigatorSelector.Visible = false
			Window.Selector.Visible = true
			Window.SelectorPosMotor:setGoal(Spring(TabModule:GetCurrentTabPos(), { frequency = 6 }))
		end

		task.spawn(function()
			Window.ContainerHolder.Parent = Window.ContainerAnim

			Window.ContainerPosMotor:setGoal(Spring(15, { frequency = 10 }))
			Window.ContainerBackMotor:setGoal(Spring(1, { frequency = 10 }))
			task.wait(0.12)
			for _, Container in next, TabModule.Containers do
				Container.Visible = false
			end
			TabModule.Containers[Tab].Visible = true
			TabModule:ApplyFilter(TabModule.SearchQuery)
			Window.ContainerPosMotor:setGoal(Spring(0, { frequency = 5 }))
			Window.ContainerBackMotor:setGoal(Spring(0, { frequency = 8 }))
			task.wait(0.12)
			Window.ContainerHolder.Parent = Window.ContainerCanvas
		end)
	end

	return TabModule
end)()

Components.Window = (function()

	local Spring = Flipper.Spring.new
	local Instant = Flipper.Instant.new
	local New = Creator.New

	return function(Config)

		local Window = {
			Minimized = false,
			Maximized = false,
			Size = Config.Size,
			CurrentPos = 0,
			TabWidth = 0,
			Position = UDim2.fromOffset(
				Camera.ViewportSize.X / 2 - Config.Size.X.Offset / 2,
				Camera.ViewportSize.Y / 2 - Config.Size.Y.Offset / 2
			),
		}

		local Dragging, DragInput, MousePos, StartPos = false
		local Resizing, ResizePos = false
		local MinimizeNotif = false

		Window.AcrylicPaint = Acrylic.AcrylicPaint()
		Window.TabWidth = Config.TabWidth

		local UserInfoConfig = Config.UserInfo
		if UserInfoConfig == true then
			UserInfoConfig = {}
		elseif not UserInfoConfig then
			UserInfoConfig = nil
		end

		local UserInfoHeight = 58
		local UserInfoSpacing = 8
		local UserInfoPosition = UserInfoConfig and (UserInfoConfig.Position or "Bottom") or nil

		local TabHolderTopOffset = Config.Search and 36 or 0
		if UserInfoConfig and UserInfoPosition == "Top" then
			TabHolderTopOffset = TabHolderTopOffset + UserInfoHeight + UserInfoSpacing
		end

		local TabHolderBottomOffset = 0
		if UserInfoConfig and UserInfoPosition ~= "Top" then
			TabHolderBottomOffset = UserInfoHeight + UserInfoSpacing
		end

		local Selector = New("Frame", {
			Size = UDim2.fromOffset(4, 0),
			BackgroundColor3 = Color3.fromRGB(76, 194, 255),
			Position = UDim2.fromOffset(0, 17 + TabHolderTopOffset),
			AnchorPoint = Vector2.new(0, 0.5),
			ThemeTag = {
				BackgroundColor3 = "Accent",
			},
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 2),
			}),
		})
		Window.Selector = Selector

		local ResizeStartFrame = New("Frame", {
			Size = UDim2.fromOffset(20, 20),
			BackgroundTransparency = 1,
			Position = UDim2.new(1, -20, 1, -20),
		})

		Window.TabHolder = New("ScrollingFrame", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			BottomImage = "rbxassetid://0",
			MidImage = "rbxassetid://0",
			TopImage = "rbxassetid://0",
			ScrollBarThickness = 0,
			BorderSizePixel = 0,
			CanvasSize = UDim2.fromScale(0, 0),
			ScrollingDirection = Enum.ScrollingDirection.Y,
		}, {
			New("UIListLayout", {
				Padding = UDim.new(0, 4),
				SortOrder = Enum.SortOrder.LayoutOrder,
			}),
		})

		local TabSearchBox, TabSearchHolder
		if Config.Search then
			local TabSearchIcon = New("ImageLabel", {
				Image = "rbxassetid://10734943674",
				Size = UDim2.fromOffset(14, 14),
				AnchorPoint = Vector2.new(0, 0.5),
				Position = UDim2.new(0, 8, 0.5, 0),
				BackgroundTransparency = 1,
				ThemeTag = {
					ImageColor3 = "SubText",
				},
			})

			TabSearchBox = New("TextBox", {
				FontFace = Font.new(Library.Font, Enum.FontWeight.Regular, Enum.FontStyle.Normal),
				PlaceholderText = "Search....",
				Text = "",
				ClearTextOnFocus = false,
				TextColor3 = Color3.fromRGB(240, 240, 240),
				TextSize = 13,
				TextXAlignment = Enum.TextXAlignment.Left,
				Size = UDim2.new(1, -32, 1, 0),
				Position = UDim2.new(0, 28, 0, 0),
				BackgroundTransparency = 1,
				ThemeTag = {
					TextColor3 = "Text",
					PlaceholderColor3 = "SubText",
				},
			})

			TabSearchHolder = New("Frame", {
				Size = UDim2.new(1, 0, 0, 30),
				Position = UDim2.fromOffset(0, 0),
				BackgroundTransparency = 0.9,
				ThemeTag = {
					BackgroundColor3 = "DropdownFrame",
				},
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(0, 5),
				}),
				New("UIStroke", {
					Transparency = 0.5,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					ThemeTag = {
						Color = "InElementBorder",
					},
				}),
				TabSearchIcon,
				TabSearchBox,
			})

		end

		Window.TabHolder.Position = UDim2.fromOffset(0, TabHolderTopOffset)
		Window.TabHolder.Size = UDim2.new(1, 0, 1, -TabHolderTopOffset - TabHolderBottomOffset)

		local UserInfoFrame
		if UserInfoConfig then
			local UserInfoIcon = UserInfoConfig.Icon
				or ("rbxthumb://type=AvatarHeadShot&id=" .. LocalPlayer.UserId .. "&w=420&h=420")
			local UserInfoTitle = UserInfoConfig.Title or LocalPlayer.DisplayName
			local UserInfoSubtitle = UserInfoConfig.Subtitle

			local UserInfoIconSize = 38
			local UserInfoTitleHeight = 18
			local UserInfoSubtitleHeight = 14
			local UserInfoTextGap = 2
			local UserInfoCenterY = UserInfoHeight / 2

			local UserInfoTitleY
			local UserInfoSubtitleY

			if UserInfoSubtitle then
				local UserInfoBlockHeight = UserInfoTitleHeight + UserInfoTextGap + UserInfoSubtitleHeight
				local UserInfoBlockTop = UserInfoCenterY - UserInfoBlockHeight / 2
				UserInfoTitleY = UserInfoBlockTop
				UserInfoSubtitleY = UserInfoBlockTop + UserInfoTitleHeight + UserInfoTextGap
			else
				UserInfoTitleY = UserInfoCenterY - UserInfoTitleHeight / 2
			end

			local UserInfoIconImage = New("ImageLabel", {
				Name = "Icon",
				Size = UDim2.fromOffset(UserInfoIconSize, UserInfoIconSize),
				Position = UDim2.fromOffset(9, (UserInfoHeight - UserInfoIconSize) / 2),
				BackgroundTransparency = 1,
				Image = UserInfoIcon,
				ScaleType = Enum.ScaleType.Crop,
			}, {
				New("UICorner", { CornerRadius = UDim.new(1, 0) }),
			})

			local UserInfoTitleLabel = New("TextLabel", {
				Name = "Title",
				Text = UserInfoTitle,
				FontFace = Font.new(Library.Font, Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
				TextSize = 14,
				TextTruncate = Enum.TextTruncate.AtEnd,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextYAlignment = Enum.TextYAlignment.Center,
				Size = UDim2.new(1, -60, 0, UserInfoTitleHeight),
				Position = UDim2.fromOffset(9 + UserInfoIconSize + 9, UserInfoTitleY),
				BackgroundTransparency = 1,
				ThemeTag = {
					TextColor3 = "Text",
				},
			})

			local UserInfoChildren = { UserInfoIconImage, UserInfoTitleLabel }

			if UserInfoSubtitle then
				table.insert(UserInfoChildren, New("TextLabel", {
					Name = "Subtitle",
					Text = UserInfoSubtitle,
					FontFace = Font.new(Library.Font, Enum.FontWeight.Regular, Enum.FontStyle.Normal),
					TextSize = 12,
					TextTruncate = Enum.TextTruncate.AtEnd,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextYAlignment = Enum.TextYAlignment.Center,
					Size = UDim2.new(1, -60, 0, UserInfoSubtitleHeight),
					Position = UDim2.fromOffset(9 + UserInfoIconSize + 9, UserInfoSubtitleY),
					BackgroundTransparency = 1,
					ThemeTag = {
						TextColor3 = "SubText",
					},
				}))
			end

			UserInfoFrame = New("Frame", {
				Name = "UserInfo",
				Size = UDim2.new(1, 0, 0, UserInfoHeight),
				Position = UserInfoPosition == "Top"
					and UDim2.fromOffset(0, Config.Search and 36 or 0)
					or UDim2.new(0, 0, 1, -UserInfoHeight),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
			}, UserInfoChildren)
		end

		local TabFrameChildren = { Window.TabHolder, Selector }
		if TabSearchHolder then
			table.insert(TabFrameChildren, 1, TabSearchHolder)
		end
		if UserInfoFrame then
			table.insert(TabFrameChildren, UserInfoFrame)
		end

		Window.UserInfoFrame = UserInfoFrame

		Window.BackgroundImage = New("ImageLabel", {
			Name = "Background",
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			ScaleType = Enum.ScaleType.Crop,
			ImageTransparency = 0,
			ThemeTag = {
				Image = "Background",
			},
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 8),
			}),
		})

		local TabFrame = New("Frame", {
			Size = UDim2.new(0, Window.TabWidth, 1, -66),
			Position = UDim2.new(0, 12, 0, 54),
			BackgroundTransparency = 1,
			ClipsDescendants = true,
		}, TabFrameChildren)

		Window.TabDisplay = New("TextLabel", {
			RichText = true,
			Text = "",
			TextTransparency = 0,
			FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
			TextSize = 28,
			TextXAlignment = "Left",
			TextYAlignment = "Center",
			Size = UDim2.new(1, -16, 0, 28),
			Position = UDim2.fromOffset(Window.TabWidth + 26, 56),
			BackgroundTransparency = 1,
			ThemeTag = {
				TextColor3 = "Text",
			},
		})

		Window.ContainerHolder = New("Frame", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
		})

		Window.ContainerAnim = New("CanvasGroup", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
		})

		Window.ContainerCanvas = New("Frame", {
			Size = UDim2.new(1, -Window.TabWidth - 32, 1, -102),
			Position = UDim2.fromOffset(Window.TabWidth + 26, 90),
			BackgroundTransparency = 1,
		}, {
			Window.ContainerAnim,
			Window.ContainerHolder
		})

		Window.Boundary = New("Frame", {
			Name = "Boundary",
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1),
			ClipsDescendants = false,
			Parent = Config.Parent,
		})

		Window.Root = New("Frame", {
			BackgroundTransparency = 1,
			Size = Window.Size,
			Position = Window.Position,
			Parent = Window.Boundary,
		}, {
			Window.BackgroundImage,
			Window.AcrylicPaint.Frame,
			Window.TabDisplay,
			Window.ContainerCanvas,
			TabFrame,
			ResizeStartFrame,
		})

		Window.TitleBar = Components.TitleBar({
			Title = Config.Title,
			SubTitle = Config.SubTitle,
			Parent = Window.Root,
			Window = Window,
		})

		function Window:SetTitle(Set)
			Window.TitleBar:SetTitle(Set)
		end

		function Window:SetSubTitle(Set)
			Window.TitleBar:SetSubTitle(Set)
		end
		Window.SetDesc = Window.SetSubTitle

		Window.NavigatorSelectorMotor = Flipper.GroupMotor.new({ X = 0, Width = 0 })

		Window.NavigatorSelector = New("Frame", {
			Size = UDim2.fromOffset(0, 2),
			AnchorPoint = Vector2.new(0, 1),
			Position = UDim2.new(0, 0, 1, 0),
			BackgroundTransparency = 0,
			Visible = false,
			ThemeTag = {
				BackgroundColor3 = "Accent",
			},
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(1, 0),
			}),
		})

		Window.NavigatorSelectorMotor:onStep(function(Values)
			Window.NavigatorSelector.Position = UDim2.new(0, Values.X, 1, 0)
			Window.NavigatorSelector.Size = UDim2.fromOffset(Values.Width, 2)
		end)

		local NavigatorListLayout = New("UIListLayout", {
			Padding = UDim.new(0, 4),
			FillDirection = Enum.FillDirection.Horizontal,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			SortOrder = Enum.SortOrder.LayoutOrder,
		})

		Window.NavigatorHolder = New("ScrollingFrame", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ScrollBarThickness = 0,
			ScrollingDirection = Enum.ScrollingDirection.X,
			CanvasSize = UDim2.fromScale(0, 0),
			AutomaticCanvasSize = Enum.AutomaticSize.X,
		}, {
			NavigatorListLayout,
		})

		local function UpdateNavigatorAlignment()
			local Fits = NavigatorListLayout.AbsoluteContentSize.X <= Window.NavigatorHolder.AbsoluteSize.X
			NavigatorListLayout.HorizontalAlignment = Fits and Enum.HorizontalAlignment.Center or Enum.HorizontalAlignment.Left
		end

		Creator.AddSignal(NavigatorListLayout:GetPropertyChangedSignal("AbsoluteContentSize"), UpdateNavigatorAlignment)
		Creator.AddSignal(Window.NavigatorHolder:GetPropertyChangedSignal("AbsoluteSize"), UpdateNavigatorAlignment)

		Window.NavigatorFrame = New("Frame", {
			Size = UDim2.new(1, -280, 1, -10),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			BackgroundTransparency = 1,
			ClipsDescendants = true,
			Parent = Window.TitleBar.Frame,
		}, {
			Window.NavigatorHolder,
			Window.NavigatorSelector,
		})

		if Library.UseAcrylic then
			Window.AcrylicPaint.AddParent(Window.Root)
		end

		local SizeMotor = Flipper.GroupMotor.new({
			X = Window.Size.X.Offset,
			Y = Window.Size.Y.Offset,
		})

		local PosMotor = Flipper.GroupMotor.new({
			X = Window.Position.X.Offset,
			Y = Window.Position.Y.Offset,
		})

		Window.SelectorPosMotor = Flipper.SingleMotor.new(17)
		Window.SelectorSizeMotor = Flipper.SingleMotor.new(0)
		Window.ContainerBackMotor = Flipper.SingleMotor.new(0)
		Window.ContainerPosMotor = Flipper.SingleMotor.new(94)

		SizeMotor:onStep(function(values)
			Window.Root.Size = UDim2.new(0, values.X, 0, values.Y)
		end)

		PosMotor:onStep(function(values)
			Window.Root.Position = UDim2.new(0, values.X, 0, values.Y)
		end)

		local LastValue = 0
		local LastTime = 0
		Window.SelectorPosMotor:onStep(function(Value)
			Selector.Position = UDim2.new(0, 0, 0, Value + 17 + TabHolderTopOffset)
			local Now = tick()
			local DeltaTime = Now - LastTime

			if LastValue ~= nil then
				Window.SelectorSizeMotor:setGoal(Spring((math.abs(Value - LastValue) / (DeltaTime * 60)) + 16))
				LastValue = Value
			end
			LastTime = Now
		end)

		Window.SelectorSizeMotor:onStep(function(Value)
			Selector.Size = UDim2.new(0, 4, 0, Value)
		end)

		Window.ContainerBackMotor:onStep(function(Value)
			Window.ContainerAnim.GroupTransparency = Value
		end)

		Window.ContainerPosMotor:onStep(function(Value)
			Window.ContainerAnim.Position = UDim2.fromOffset(0, Value)
		end)

		local OldSizeX
		local OldSizeY
		local OldPosX
		local OldPosY
		local function getBoundaryBounds()
			local inset = Library.BoundaryInset or {}
			local margin = Library.BoundaryMargin or 0
			local left = (inset.Left or 0) + margin
			local top = (inset.Top or 0) + margin
			local right = (inset.Right or 0) + margin
			local bottom = (inset.Bottom or 0) + margin
			local size = Window.Boundary.AbsoluteSize
			local usableX = math.max(0, size.X - left - right)
			local usableY = math.max(0, size.Y - top - bottom)
			return left, top, usableX, usableY
		end

		local function clampToBoundary(targetPosition, windowSize)
			if not Library.KeepWindowInsideFrame then
				return targetPosition
			end
			local left, top, usableX, usableY = getBoundaryBounds()
			local maxX = math.max(left, left + usableX - windowSize.X)
			local maxY = math.max(top, top + usableY - windowSize.Y)
			return Vector2.new(math.clamp(targetPosition.X, left, maxX), math.clamp(targetPosition.Y, top, maxY))
		end

		local function fitToBoundary(Instant)
			local left, top, usableX, usableY = getBoundaryBounds()
			SizeMotor:setGoal({
				X = Flipper[Instant and "Instant" or "Spring"].new(usableX, { frequency = 6 }),
				Y = Flipper[Instant and "Instant" or "Spring"].new(usableY, { frequency = 6 }),
			})
			Window.Size = UDim2.fromOffset(usableX, usableY)
			PosMotor:setGoal({
				X = Flipper[Instant and "Instant" or "Spring"].new(left, { frequency = 6 }),
				Y = Flipper[Instant and "Instant" or "Spring"].new(top, { frequency = 6 }),
			})
			Window.Position = UDim2.fromOffset(left, top)
		end

		Window.RefreshBoundary = function()
			if Window.Maximized then
				fitToBoundary(true)
			end
		end

		Window.Maximize = function(Value, NoPos, Instant)
			if Window.Maximized == Value then
				return
			end

			Window.Maximized = Value
			local WindowAssets = Library.NewVisual and Components.AssetsNew or Components.Assets
			Window.TitleBar.MaxButton.Frame.Icon.Image = Value and WindowAssets.Restore or WindowAssets.Max

			if Value then
				OldSizeX = Window.Size.X.Offset
				OldSizeY = Window.Size.Y.Offset
				OldPosX = Window.Position.X.Offset
				OldPosY = Window.Position.Y.Offset
			end

			if Value then
				fitToBoundary(Instant)
				return
			end

			SizeMotor:setGoal({
				X = Flipper[Instant and "Instant" or "Spring"].new(OldSizeX, { frequency = 6 }),
				Y = Flipper[Instant and "Instant" or "Spring"].new(OldSizeY, { frequency = 6 }),
			})
			Window.Size = UDim2.fromOffset(OldSizeX, OldSizeY)

			if not NoPos then
				PosMotor:setGoal({
					X = Spring(OldPosX, { frequency = 6 }),
					Y = Spring(OldPosY, { frequency = 6 }),
				})
				Window.Position = UDim2.fromOffset(OldPosX, OldPosY)
			end
		end

		Creator.AddSignal(Window.Boundary:GetPropertyChangedSignal("AbsoluteSize"), function()
			Window.RefreshBoundary()
		end)

		Creator.AddSignal(Window.TitleBar.Frame.InputBegan, function(Input)
			if
				Input.UserInputType == Enum.UserInputType.MouseButton1
				or Input.UserInputType == Enum.UserInputType.Touch
			then
				Dragging = true
				MousePos = Input.Position
				StartPos = Window.Root.Position

				if Window.Maximized then
					local _, _, usableX, usableY = getBoundaryBounds()
					StartPos = UDim2.fromOffset(
						Mouse.X - (Mouse.X * ((OldSizeX - 100) / usableX)),
						Mouse.Y - (Mouse.Y * (OldSizeY / usableY))
					)
				end

				Input.Changed:Connect(function()
					if Input.UserInputState == Enum.UserInputState.End then
						Dragging = false
					end
				end)
			end
		end)

		Creator.AddSignal(Window.TitleBar.Frame.InputChanged, function(Input)
			if
				Input.UserInputType == Enum.UserInputType.MouseMovement
				or Input.UserInputType == Enum.UserInputType.Touch
			then
				DragInput = Input
			end
		end)

		Creator.AddSignal(ResizeStartFrame.InputBegan, function(Input)
			if
				Input.UserInputType == Enum.UserInputType.MouseButton1
				or Input.UserInputType == Enum.UserInputType.Touch
			then
				Resizing = true
				ResizePos = Input.Position
			end
		end)

		Creator.AddSignal(UserInputService.InputChanged, function(Input)
			if Input == DragInput and Dragging then
				local Delta = Input.Position - MousePos
				local targetPosition =
					clampToBoundary(Vector2.new(StartPos.X.Offset + Delta.X, StartPos.Y.Offset + Delta.Y), Window.Root.AbsoluteSize)
				Window.Position = UDim2.fromOffset(targetPosition.X, targetPosition.Y)
				PosMotor:setGoal({
					X = Instant(Window.Position.X.Offset),
					Y = Instant(Window.Position.Y.Offset),
				})

				if Window.Maximized then
					Window.Maximize(false, true, true)
				end
			end

			if
				(Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch)
				and Resizing
			then
				local Delta = Input.Position - ResizePos
				local StartSize = Window.Size

				local TargetSize = Vector3.new(StartSize.X.Offset, StartSize.Y.Offset, 0) + Vector3.new(1, 1, 0) * Delta
				local TargetSizeClamped =
					Vector2.new(math.clamp(TargetSize.X, 470, 2048), math.clamp(TargetSize.Y, 380, 2048))

				if Library.KeepWindowInsideFrame then
					local left, top, usableX, usableY = getBoundaryBounds()
					local windowPosition = Window.Root.AbsolutePosition
					local boundaryPosition = Window.Boundary.AbsolutePosition
					local relativeX = (windowPosition.X - boundaryPosition.X) - left
					local relativeY = (windowPosition.Y - boundaryPosition.Y) - top
					local availableX = math.max(470, usableX - relativeX)
					local availableY = math.max(380, usableY - relativeY)
					TargetSizeClamped = Vector2.new(math.min(TargetSizeClamped.X, availableX), math.min(TargetSizeClamped.Y, availableY))
				end

				SizeMotor:setGoal({
					X = Flipper.Instant.new(TargetSizeClamped.X),
					Y = Flipper.Instant.new(TargetSizeClamped.Y),
				})
			end
		end)

		Creator.AddSignal(UserInputService.InputEnded, function(Input)
			if Resizing then
				Resizing = false
				Window.Size = UDim2.fromOffset(SizeMotor:getValue().X, SizeMotor:getValue().Y)
			end
		end)

		Creator.AddSignal(Window.TabHolder.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
			Window.TabHolder.CanvasSize = UDim2.new(0, 0, 0, Window.TabHolder.UIListLayout.AbsoluteContentSize.Y)
		end)

		Creator.AddSignal(UserInputService.InputBegan, function(Input)
			if
				type(Library.MinimizeKeybind) == "table"
				and Library.MinimizeKeybind.Type == "Keybind"
				and not UserInputService:GetFocusedTextBox()
			then
				if Input.KeyCode.Name == Library.MinimizeKeybind.Value then
					Window:Minimize()
				end
			elseif Input.KeyCode == Library.MinimizeKey and not UserInputService:GetFocusedTextBox() then
				Window:Minimize()
			end
		end)

		function Window:Minimize()
			Window.Minimized = not Window.Minimized
			Window.Root.Visible = not Window.Minimized
			if not MinimizeNotif then
				MinimizeNotif = true
				local Key = Library.MinimizeKeybind and Library.MinimizeKeybind.Value or Library.MinimizeKey.Name
				Library:Notify({
					Title = "Interface",
					Content = "Press " .. Key .. " to toggle the interface.",
					Duration = 6
				})
			end
		end

		function Window:Destroy()
			if Library.UseAcrylic then
				Window.AcrylicPaint.Model:Destroy()
			end
			Window.Root:Destroy()
		end

		local DialogModule = Components.Dialog:Init(Window)
		function Window:Dialog(Config)
			local Dialog = DialogModule:Create()
			Dialog.Title.Text = Config.Title

			local Content = New("TextLabel", {
				FontFace = Font.new(Library.Font),
				Text = Config.Content,
				TextColor3 = Color3.fromRGB(240, 240, 240),
				TextSize = 14,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextYAlignment = Enum.TextYAlignment.Top,
				Size = UDim2.new(1, -40, 1, 0),
				Position = UDim2.fromOffset(20, 60),
				BackgroundTransparency = 1,
				Parent = Dialog.Root,
				ClipsDescendants = false,
				ThemeTag = {
					TextColor3 = "Text",
				},
			})

			New("UISizeConstraint", {
				MinSize = Vector2.new(300, 165),
				MaxSize = Vector2.new(620, math.huge),
				Parent = Dialog.Root,
			})

			Dialog.Root.Size = UDim2.fromOffset(Content.TextBounds.X + 40, 165)
			if Content.TextBounds.X + 40 > Window.Size.X.Offset - 120 then
				Dialog.Root.Size = UDim2.fromOffset(Window.Size.X.Offset - 120, 165)
				Content.TextWrapped = true
				Dialog.Root.Size = UDim2.fromOffset(Window.Size.X.Offset - 120, Content.TextBounds.Y + 150)
			end

			for _, Button in next, Config.Buttons do
				Dialog:Button(Button.Title, Button.Callback)
			end

			Dialog:Open()
		end

		local SidePanelModule = Components.SidePanel:Init(Window)
		function Window:SidePanel(Config)
			local Panel = SidePanelModule:Create(Config)
			Panel:Open()
			return Panel
		end
		Window.Menu = Window.SidePanel
		Window.SideMenu = Window.SidePanel

		local TabModule = Components.Tab:Init(Window)
		local TabHolderOrder = 0

		function Window:AddTab(TabConfig)
			TabHolderOrder = TabHolderOrder + 1
			local Tab = TabModule:New(TabConfig.Title, TabConfig.Icon, Window.TabHolder, false)
			Tab.Frame.LayoutOrder = TabHolderOrder
			return Tab
		end
		Window.Tab = Window.AddTab
		Window.Page = Window.AddTab
		Window.AddPage = Window.AddTab

		function Window:AddTabInHeader(TabConfig)
			return TabModule:New(TabConfig.Title, TabConfig.Icon, Window.NavigatorHolder, true)
		end
		Window.TabInHeader = Window.AddTabInHeader

		function Window:AddSection(SectionConfig)
			SectionConfig = SectionConfig or {}

			TabHolderOrder = TabHolderOrder + 1
			local Section = {
				Type = "TabSection",
				Title = SectionConfig.Title,
				Collapsible = SectionConfig.Collapsible or false,
				Opened = true,
				Tabs = {},
				_tabOrder = 0,
			}

			Section.Root = New("Frame", {
				Name = "SectionRoot",
				Size = UDim2.new(1, 0, 0, 0),
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				LayoutOrder = TabHolderOrder,
				Parent = Window.TabHolder,
			}, {
				New("UIListLayout", {
					Padding = UDim.new(0, 4),
					SortOrder = Enum.SortOrder.LayoutOrder,
				}),
			})

			local SectionIcon = SectionConfig.Icon and Library:GetIcon(SectionConfig.Icon)
			local SectionTitleOffset = SectionIcon and 22 or 4

			local SectionTitleLabel = New("TextLabel", {
				Name = "SectionTitle",
				Text = Section.Title,
				RichText = true,
				FontFace = Font.new(Library.Font, Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
				TextSize = 12,
				TextXAlignment = "Left",
				TextYAlignment = "Center",
				Size = UDim2.new(1, (Section.Collapsible and -24 or -8) - (SectionTitleOffset - 4), 1, 0),
				Position = UDim2.fromOffset(SectionTitleOffset, 0),
				BackgroundTransparency = 1,
				ThemeTag = {
					TextColor3 = "SubText",
				},
			})

			Section.Header = New("TextButton", {
				Name = "SectionHeader",
				Size = UDim2.new(1, 0, 0, 26),
				BackgroundTransparency = 1,
				AutoButtonColor = false,
				Text = "",
				LayoutOrder = 1,
				Parent = Section.Root,
			}, {
				SectionTitleLabel,
			})

			if SectionIcon then
				New("ImageLabel", {
					Name = "SectionIcon",
					Image = SectionIcon.Image,
					ImageRectOffset = SectionIcon.ImageRectOffset,
					ImageRectSize = SectionIcon.ImageRectSize,
					Size = UDim2.fromOffset(14, 14),
					AnchorPoint = Vector2.new(0, 0.5),
					Position = UDim2.new(0, 4, 0.5, 0),
					BackgroundTransparency = 1,
					Parent = Section.Header,
					ThemeTag = {
						ImageColor3 = "SubText",
					},
				})
			end

			Creator.AttachTitleDesc(Section, SectionTitleLabel, nil)

			Section.Content = New("Frame", {
				Name = "SectionContent",
				Size = UDim2.new(1, 0, 0, 0),
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				LayoutOrder = 2,
				Parent = Section.Root,
			}, {
				New("UIListLayout", {
					Padding = UDim.new(0, 4),
					SortOrder = Enum.SortOrder.LayoutOrder,
				}),
			})

			local Chevron
			if Section.Collapsible then
				local ChevronIcon = Library:GetIcon("chevron-down")
				Chevron = New("ImageLabel", {
					Name = "SectionChevron",
					Image = ChevronIcon and ChevronIcon.Image or "",
					ImageRectOffset = ChevronIcon and ChevronIcon.ImageRectOffset or Vector2.zero,
					ImageRectSize = ChevronIcon and ChevronIcon.ImageRectSize or Vector2.zero,
					Size = UDim2.fromOffset(14, 14),
					AnchorPoint = Vector2.new(1, 0.5),
					Position = UDim2.new(1, -6, 0.5, 0),
					Rotation = 0,
					BackgroundTransparency = 1,
					Parent = Section.Header,
					ThemeTag = {
						ImageColor3 = "SubText",
					},
				})
			end

			local function SectionHasSelectedTab()
				local SelectedTab = TabModule.Tabs[TabModule.SelectedTab]
				if not SelectedTab then return false end
				for _, SectionTab in ipairs(Section.Tabs) do
					if SectionTab == SelectedTab then
						return true
					end
				end
				return false
			end

			function Section:Open()
				if not Section.Collapsible then return end
				Section.Opened = true
				Section.Content.Visible = true
				TweenService:Create(
					Chevron,
					TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
					{ Rotation = 0 }
				):Play()

				if SectionHasSelectedTab() then
					Window.Selector.Visible = true
					Window.SelectorPosMotor:setGoal(Instant(TabModule:GetCurrentTabPos()))
				end
			end

			function Section:Close()
				if not Section.Collapsible then return end
				Section.Opened = false
				Section.Content.Visible = false
				TweenService:Create(
					Chevron,
					TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
					{ Rotation = -90 }
				):Play()

				if SectionHasSelectedTab() then
					Window.Selector.Visible = false
				end
			end

			function Section:Toggle()
				if Section.Opened then
					Section:Close()
				else
					Section:Open()
				end
			end

			if Section.Collapsible then
				Creator.AddSignal(Section.Header.MouseButton1Click, function()
					Section:Toggle()
				end)
			end

			function Section:AddTab(TabConfig)
				Section._tabOrder = Section._tabOrder + 1
				local Tab = TabModule:New(TabConfig.Title, TabConfig.Icon, Section.Content, false)
				Tab.Frame.LayoutOrder = Section._tabOrder
				table.insert(Section.Tabs, Tab)
				return Tab
			end
			Section.Tab = Section.AddTab
			Section.Page = Section.AddTab
			Section.AddPage = Section.AddTab

			function Section:AddTabInHeader(TabConfig)
				warn("[Fluent Reimagined] TabInHeader cannot be added to a Section, tab moved to header instead.")
				return TabModule:New(TabConfig.Title, TabConfig.Icon, Window.NavigatorHolder, true)
			end
			Section.TabInHeader = Section.AddTabInHeader

			return Section
		end
		Window.Section = Window.AddSection

		function Window:SelectTab(Tab)
			TabModule:SelectTab(1)
		end

		Creator.AddSignal(Window.TabHolder:GetPropertyChangedSignal("CanvasPosition"), function()
			LastValue = TabModule:GetCurrentTabPos() + 16
			LastTime = 0
			Window.SelectorPosMotor:setGoal(Instant(TabModule:GetCurrentTabPos()))
		end)

		Creator.AddSignal(Window.NavigatorHolder:GetPropertyChangedSignal("CanvasPosition"), function()
			TabModule:UpdateNavigatorSelector(true)
		end)

		if TabSearchBox then
			Creator.AddSignal(TabSearchBox:GetPropertyChangedSignal("Text"), function()
				TabModule:ApplyFilter(TabSearchBox.Text)
			end)
		end

		return Window
	end
end)()

local ElementsTable = {}
local AddSignal = Creator.AddSignal

ElementsTable.Button = (function()
	local New = Creator.New

	local Element = {}
	Element.__index = Element
	Element.__type = "Button"

	function Element:New(Config)
		assert(Config.Title, "Button - Missing Title")
		Config.Callback = Config.Callback or function() end

		local IsGrouped = self.Type == "Group" or self.Type == "HStack" or self.Type == "VStack"

		local ButtonFrame = Components.Element(Config.Title, Config.Description, self.Container, true, Config.LayoutOrder, Config.Icon, Config.Marquee)

		ButtonFrame.TitleLabel.Size = UDim2.new(1, -34, 0, 14)
		ButtonFrame.DescLabel.Size = UDim2.new(1, -34, 0, 14)

		local ButtonIco = New("ImageLabel", {
			Image = "rbxassetid://10709791437",
			Size = UDim2.fromOffset(16, 16),
			AnchorPoint = Vector2.new(1, 0.5),
			Position = UDim2.new(1, -10, 0.5, 0),
			BackgroundTransparency = 1,
			Parent = ButtonFrame.Frame,
			ThemeTag = {
				ImageColor3 = "Text",
			},
		})

		Creator.AddSignal(ButtonFrame.Frame.MouseButton1Click, function()
			self.Library:SafeCallback(Config.Callback)
		end)

		local Button = ButtonFrame
		Button.SetTitle = ButtonFrame.SetTitle
		Button.SetDesc = ButtonFrame.SetDesc

		return Button
	end

	return Element
end)()

ElementsTable.Colorpicker = (function()
	local TouchInputService = game:GetService("TouchInputService")

	local RenderStepped = RunService.RenderStepped
	local Mouse = LocalPlayer:GetMouse()

	local New = Creator.New

	local Element = {}
	Element.__index = Element
	Element.__type = "Colorpicker"

	function Element:New(Idx, Config)
		local Library = self.Library
		assert(Config.Title, "Colorpicker - Missing Title")
		assert(Config.Default, "AddColorPicker: Missing default value.")

		local Colorpicker = {
			Value = Config.Default,
			Transparency = Config.Transparency or 0,
			Type = "Colorpicker",
			Title = type(Config.Title) == "string" and Config.Title or "Colorpicker",
			Callback = Config.Callback or function(Color) end,
		}

		function Colorpicker:SetHSVFromRGB(Color)
			local H, S, V = Color3.toHSV(Color)
			Colorpicker.Hue = H
			Colorpicker.Sat = S
			Colorpicker.Vib = V
		end

		Colorpicker:SetHSVFromRGB(Colorpicker.Value)

		local IsGrouped = self.Type == "Group" or self.Type == "HStack" or self.Type == "VStack"

		local ColorpickerFrame = Components.Element(Config.Title, Config.Description, self.Container, true, Config.LayoutOrder, Config.Icon, Config.Marquee)

		ColorpickerFrame.TitleLabel.Size = UDim2.new(1, -44, 0, 14)
		ColorpickerFrame.DescLabel.Size = UDim2.new(1, -44, 0, 14)

		Colorpicker.SetTitle = ColorpickerFrame.SetTitle
		Colorpicker.SetDesc = ColorpickerFrame.SetDesc

		local DisplayFrameColor = New("Frame", {
			Size = UDim2.fromScale(1, 1),
			BackgroundColor3 = Colorpicker.Value,
			Parent = ColorpickerFrame.Frame,
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 4),
			}),
		})

		local DisplayFrame = New("ImageLabel", {
			Size = UDim2.fromOffset(26, 26),
			Position = UDim2.new(1, -10, 0.5, 0),
			AnchorPoint = Vector2.new(1, 0.5),
			Parent = ColorpickerFrame.Frame,
			Image = "http://www.roblox.com/asset/?id=14204231522",
			ImageTransparency = 0.45,
			ScaleType = Enum.ScaleType.Tile,
			TileSize = UDim2.fromOffset(40, 40),
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 4),
			}),
			DisplayFrameColor,
		})

		local ColorpickerTextboxTags = {
			Input = "ColorpickerInput",
			InputLine = "ColorpickerInputLine",
			InputBorder = "ColorpickerInputBorder",
			InputFocused = "ColorpickerInputFocused",
		}

		local function CreateColorDialog()
			local Dialog = Components.Dialog:Create()
			Dialog.Title.Text = Colorpicker.Title
			Dialog.Root.Size = UDim2.fromOffset(460, 370)

			Creator.OverrideTag(Dialog.Root, { BackgroundColor3 = "ColorpickerDialog" })
			Creator.OverrideTag(Dialog.Root.UIStroke, { Color = "ColorpickerDialogBorder" })
			Creator.OverrideTag(Dialog.ButtonHolderFrame, { BackgroundColor3 = "ColorpickerHolder" })
			Creator.OverrideTag(Dialog.HolderLine, { BackgroundColor3 = "ColorpickerHolderLine" })

			local Hue, Sat, Vib = Colorpicker.Hue, Colorpicker.Sat, Colorpicker.Vib
			local Transparency = Colorpicker.Transparency

			local function CreateInput()
				local Box = Components.Textbox(nil, false, ColorpickerTextboxTags)
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
				local Value = Color3.fromHSV(Hue, Sat, Vib)
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
				Position = UDim2.fromOffset(20, 55),
				Image = "rbxassetid://4155801252",
				BackgroundColor3 = Colorpicker.Value,
				BackgroundTransparency = 0,
				Parent = Dialog.Root,
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(0, 4),
				}),
				SatCursor,
			})

			local OldColorFrame = New("Frame", {
				BackgroundColor3 = Colorpicker.Value,
				Size = UDim2.fromScale(1, 1),
				BackgroundTransparency = Colorpicker.Transparency,
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(0, 4),
				}),
			})

			local OldColorFrameChecker = New("ImageLabel", {
				Image = "http://www.roblox.com/asset/?id=14204231522",
				ImageTransparency = 0.45,
				ScaleType = Enum.ScaleType.Tile,
				TileSize = UDim2.fromOffset(40, 40),
				BackgroundTransparency = 1,
				Position = UDim2.fromOffset(124, 260),
				Size = UDim2.fromOffset(96, 24),
				Parent = Dialog.Root,
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(0, 4),
				}),
				New("UIStroke", {
					Thickness = 2,
					Transparency = 0.75,
				}),
				OldColorFrame,
			})

			local DialogDisplayFrame = New("Frame", {
				BackgroundColor3 = Colorpicker.Value,
				Size = UDim2.fromScale(1, 1),
				BackgroundTransparency = 0,
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(0, 4),
				}),
			})

			local DialogDisplayFrameChecker = New("ImageLabel", {
				Image = "http://www.roblox.com/asset/?id=14204231522",
				ImageTransparency = 0.45,
				ScaleType = Enum.ScaleType.Tile,
				TileSize = UDim2.fromOffset(40, 40),
				BackgroundTransparency = 1,
				Position = UDim2.fromOffset(20, 260),
				Size = UDim2.fromOffset(96, 24),
				Parent = Dialog.Root,
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(0, 4),
				}),
				New("UIStroke", {
					Thickness = 2,
					Transparency = 0.75,
				}),
				DialogDisplayFrame,
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
				Position = UDim2.fromOffset(230, 55),
				Parent = Dialog.Root,
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(1, 0),
				}),
				HueSliderGradient,
				HueDragHolder,
			})

			local HexInput = CreateInput()
			HexInput.Frame.Position = UDim2.fromOffset(Config.Transparency and 280 or 260, 55)
			CreateInputLabel("Hex", UDim2.fromOffset(Config.Transparency and 380 or 360, 55))

			local RedInput = CreateInput()
			RedInput.Frame.Position = UDim2.fromOffset(Config.Transparency and 280 or 260, 95)
			CreateInputLabel("Red", UDim2.fromOffset(Config.Transparency and 380 or 360, 95))

			local GreenInput = CreateInput()
			GreenInput.Frame.Position = UDim2.fromOffset(Config.Transparency and 280 or 260, 135)
			CreateInputLabel("Green", UDim2.fromOffset(Config.Transparency and 380 or 360, 135))

			local BlueInput = CreateInput()
			BlueInput.Frame.Position = UDim2.fromOffset(Config.Transparency and 280 or 260, 175)
			CreateInputLabel("Blue", UDim2.fromOffset(Config.Transparency and 380 or 360, 175))

			local AlphaInput
			if Config.Transparency then
				AlphaInput = CreateInput()
				AlphaInput.Frame.Position = UDim2.fromOffset(280, 215)
				CreateInputLabel("Alpha", UDim2.fromOffset(380, 215))
			end

			local TransparencySlider, TransparencyDrag, TransparencyColor
			if Config.Transparency then
				local TransparencyDragHolder = New("Frame", {
					Size = UDim2.new(1, 0, 1, -10),
					Position = UDim2.fromOffset(0, 5),
					BackgroundTransparency = 1,
				})

				TransparencyDrag = New("ImageLabel", {
					Size = UDim2.fromOffset(14, 14),
					Image = "http://www.roblox.com/asset/?id=12266946128",
					ImageColor3 = Creator.GetKnobColor(),
					Parent = TransparencyDragHolder,
				})

				Creator.OnThemeChanged(function()
					TransparencyDrag.ImageColor3 = Creator.GetKnobColor()
				end)

				TransparencyColor = New("Frame", {
					Size = UDim2.fromScale(1, 1),
				}, {
					New("UIGradient", {
						Transparency = NumberSequence.new({
							NumberSequenceKeypoint.new(0, 0),
							NumberSequenceKeypoint.new(1, 1),
						}),
						Rotation = 270,
					}),
					New("UICorner", {
						CornerRadius = UDim.new(1, 0),
					}),
				})

				TransparencySlider = New("Frame", {
					Size = UDim2.fromOffset(12, 200),
					Position = UDim2.fromOffset(250, 55),
					Parent = Dialog.Root,
					BackgroundTransparency = 1,
				}, {
					New("UICorner", {
						CornerRadius = UDim.new(1, 0),
					}),
					New("ImageLabel", {
						Image = "http://www.roblox.com/asset/?id=14204231522",
						ImageTransparency = 0.45,
						ScaleType = Enum.ScaleType.Tile,
						TileSize = UDim2.fromOffset(40, 40),
						BackgroundTransparency = 1,
						Size = UDim2.fromScale(1, 1),
					}, {
						New("UICorner", {
							CornerRadius = UDim.new(1, 0),
						}),
					}),
					TransparencyColor,
					TransparencyDragHolder,
				})
			end

			local function Display()
				SatVibMap.BackgroundColor3 = Color3.fromHSV(Hue, 1, 1)
				HueDrag.Position = UDim2.new(0, -1, Hue, -6)
				SatCursor.Position = UDim2.new(Sat, 0, 1 - Vib, 0)
				DialogDisplayFrame.BackgroundColor3 = Color3.fromHSV(Hue, Sat, Vib)

				HexInput.Input.Text = "#" .. Color3.fromHSV(Hue, Sat, Vib):ToHex()
				RedInput.Input.Text = GetRGB()["R"]
				GreenInput.Input.Text = GetRGB()["G"]
				BlueInput.Input.Text = GetRGB()["B"]

				if Config.Transparency then
					TransparencyColor.BackgroundColor3 = Color3.fromHSV(Hue, Sat, Vib)
					DialogDisplayFrame.BackgroundTransparency = Transparency
					TransparencyDrag.Position = UDim2.new(0, -1, 1 - Transparency, -6)
					AlphaInput.Input.Text = Library:Round((1 - Transparency) * 100, 0) .. "%"
				end
			end

			Creator.AddSignal(HexInput.Input.FocusLost, function(Enter)
				if Enter then
					local Success, Result = pcall(Color3.fromHex, HexInput.Input.Text)
					if Success and typeof(Result) == "Color3" then
						Hue, Sat, Vib = Color3.toHSV(Result)
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
							Hue, Sat, Vib = Color3.toHSV(Result)
						end
					end
				end
				Display()
			end)

			Creator.AddSignal(GreenInput.Input.FocusLost, function(Enter)
				if Enter then
					local CurrentColor = GetRGB()
					local Success, Result =
						pcall(Color3.fromRGB, CurrentColor["R"], GreenInput.Input.Text, CurrentColor["B"])
					if Success and typeof(Result) == "Color3" then
						if tonumber(GreenInput.Input.Text) <= 255 then
							Hue, Sat, Vib = Color3.toHSV(Result)
						end
					end
				end
				Display()
			end)

			Creator.AddSignal(BlueInput.Input.FocusLost, function(Enter)
				if Enter then
					local CurrentColor = GetRGB()
					local Success, Result =
						pcall(Color3.fromRGB, CurrentColor["R"], CurrentColor["G"], BlueInput.Input.Text)
					if Success and typeof(Result) == "Color3" then
						if tonumber(BlueInput.Input.Text) <= 255 then
							Hue, Sat, Vib = Color3.toHSV(Result)
						end
					end
				end
				Display()
			end)

			if Config.Transparency then
				Creator.AddSignal(AlphaInput.Input.FocusLost, function(Enter)
					if Enter then
						pcall(function()
							local Value = tonumber(AlphaInput.Input.Text)
							if Value >= 0 and Value <= 100 then
								Transparency = 1 - Value * 0.01
							end
						end)
					end
					Display()
				end)
			end

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

						Sat = (MouseX - MinX) / (MaxX - MinX)
						Vib = 1 - ((MouseY - MinY) / (MaxY - MinY))
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

						Hue = ((MouseY - MinY) / (MaxY - MinY))
						Display()

						RenderStepped:Wait()
					end
				end
			end)

			if Config.Transparency then
				Creator.AddSignal(TransparencySlider.InputBegan, function(Input)
					if
						Input.UserInputType == Enum.UserInputType.MouseButton1
						or Input.UserInputType == Enum.UserInputType.Touch
					then
						while UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
							local MinY = TransparencySlider.AbsolutePosition.Y
							local MaxY = MinY + TransparencySlider.AbsoluteSize.Y
							local MouseY = math.clamp(Mouse.Y, MinY, MaxY)

							Transparency = 1 - ((MouseY - MinY) / (MaxY - MinY))
							Display()

							RenderStepped:Wait()
						end
					end
				end)
			end

			Display()

			local DoneButton = Dialog:Button("Done", function()
				Colorpicker:SetValue({ Hue, Sat, Vib }, Transparency)
			end)
			local CancelButton = Dialog:Button("Cancel")

			for _, Btn in next, { DoneButton, CancelButton } do
				Creator.OverrideTag(Btn.Frame, { BackgroundColor3 = "ColorpickerButton" })
				Creator.OverrideTag(Btn.Frame.UIStroke, { Color = "ColorpickerButtonBorder" })
			end

			Dialog:Open()
		end

		function Colorpicker:Display()
			Colorpicker.Value = Color3.fromHSV(Colorpicker.Hue, Colorpicker.Sat, Colorpicker.Vib)

			DisplayFrameColor.BackgroundColor3 = Colorpicker.Value
			DisplayFrameColor.BackgroundTransparency = Colorpicker.Transparency

			Element.Library:SafeCallback(Colorpicker.Callback, Colorpicker.Value)
			Element.Library:SafeCallback(Colorpicker.Changed, Colorpicker.Value)
		end

		function Colorpicker:SetValue(HSV, Transparency)
			local Color = Color3.fromHSV(HSV[1], HSV[2], HSV[3])

			Colorpicker.Transparency = Transparency or 0
			Colorpicker:SetHSVFromRGB(Color)
			Colorpicker:Display()
		end

		function Colorpicker:SetValueRGB(Color, Transparency)
			Colorpicker.Transparency = Transparency or 0
			Colorpicker:SetHSVFromRGB(Color)
			Colorpicker:Display()
		end

		function Colorpicker:OnChanged(Func)
			Colorpicker.Changed = Func
			Func(Colorpicker.Value)
		end

		function Colorpicker:Destroy()
			ColorpickerFrame:Destroy()
			Library.Options[Idx] = nil
		end

		Creator.AddSignal(ColorpickerFrame.Frame.MouseButton1Click, function()
			CreateColorDialog()
		end)

		Colorpicker:Display()

		Library.Options[Idx] = Colorpicker
		return Colorpicker
	end

	return Element
end)()

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

ElementsTable.Dropdown = (function()
	local New = Creator.New

	local Element = {}
	Element.__index = Element
	Element.__type = "Dropdown"

	function Element:New(Idx, Config)
		local Library = self.Library

		local Dropdown = {
			Values = Config.Values,
			Value = Config.Default,
			Multi = Config.Multi,
			Buttons = {},
			Opened = false,
			Type = "Dropdown",
			Callback = Config.Callback or function() end,
		}

		local IsGrouped = self.Type == "Group" or self.Type == "HStack" or self.Type == "VStack"

		local DropdownFrame = Components.Element(Config.Title, Config.Description, self.Container, false, Config.LayoutOrder, Config.Icon, Config.Marquee)

		local DropdownRow = New("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, 34),
			LayoutOrder = 2,
			Visible = IsGrouped,
			Parent = DropdownFrame.LabelHolder,
		})

		Dropdown.SetTitle = DropdownFrame.SetTitle
		Dropdown.SetDesc = DropdownFrame.SetDesc

		local DropdownDisplay = New("TextLabel", {
			FontFace = Font.new(Library.Font, Enum.FontWeight.Regular, Enum.FontStyle.Normal),
			Text = "Value",
			TextColor3 = Color3.fromRGB(240, 240, 240),
			TextSize = 13,
			TextXAlignment = Enum.TextXAlignment.Left,
			Size = UDim2.new(1, -30, 0, 14),
			Position = UDim2.new(0, 8, 0.5, 0),
			AnchorPoint = Vector2.new(0, 0.5),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			TextTruncate = Enum.TextTruncate.AtEnd,
			ThemeTag = {
				TextColor3 = "Text",
			},
		})

		local DropdownIco = New("ImageLabel", {
			Image = "rbxassetid://10709790948",
			Size = UDim2.fromOffset(16, 16),
			AnchorPoint = Vector2.new(1, 0.5),
			Position = UDim2.new(1, -8, 0.5, 0),
			BackgroundTransparency = 1,
			ThemeTag = {
				ImageColor3 = "SubText",
			},
		})

		local DropdownInner = New("TextButton", {
			Size = IsGrouped and UDim2.new(1, 0, 0, 30) or UDim2.fromOffset(160, 30),
			Position = IsGrouped and UDim2.new(0, 0, 0.5, 0) or UDim2.new(1, -10, 0.5, 0),
			AnchorPoint = IsGrouped and Vector2.new(0, 0.5) or Vector2.new(1, 0.5),
			BackgroundTransparency = 0.9,
			Parent = IsGrouped and DropdownRow or DropdownFrame.Frame,
			ThemeTag = {
				BackgroundColor3 = "DropdownFrame",
			},
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 5),
			}),
			New("UIStroke", {
				Transparency = 0.5,
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				ThemeTag = {
					Color = "InElementBorder",
				},
			}),
			DropdownIco,
			DropdownDisplay,
		})

		Creator.Adaptive(DropdownFrame, 170, 340, not IsGrouped, function(Inline)
			DropdownInner.Parent = Inline and DropdownFrame.Frame or DropdownRow
			DropdownInner.Size = Inline and UDim2.fromOffset(160, 30) or UDim2.new(1, 0, 0, 30)
			DropdownInner.Position = Inline and UDim2.new(1, -10, 0.5, 0) or UDim2.new(0, 0, 0.5, 0)
			DropdownInner.AnchorPoint = Inline and Vector2.new(1, 0.5) or Vector2.new(0, 0.5)
			DropdownRow.Visible = not Inline
		end)

		local DropdownListLayout = New("UIListLayout", {
			Padding = UDim.new(0, 3),
		})

		local DropdownScrollFrame = New("ScrollingFrame", {
			Size = UDim2.new(1, -8, 1, -10),
			Position = UDim2.fromOffset(5, 5),
			BackgroundTransparency = 1,
			BottomImage = "rbxassetid://6889812791",
			MidImage = "rbxassetid://6889812721",
			TopImage = "rbxassetid://6276641225",
			ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255),
			ScrollBarImageTransparency = 0.95,
			ScrollBarThickness = 3,
			BorderSizePixel = 0,
			CanvasSize = UDim2.fromScale(0, 0),
			ScrollingDirection = Enum.ScrollingDirection.Y,
		}, {
			DropdownListLayout,
			New("UIPadding", {
				PaddingRight = UDim.new(0, 4),
			}),
		})

		local DropdownSearchBox, DropdownSearchHolder
		if Config.Search then
			local DropdownSearchIcon = New("ImageLabel", {
				Image = "rbxassetid://10734943674",
				Size = UDim2.fromOffset(14, 14),
				AnchorPoint = Vector2.new(0, 0.5),
				Position = UDim2.new(0, 8, 0.5, 0),
				BackgroundTransparency = 1,
				ThemeTag = {
					ImageColor3 = "SubText",
				},
			})

			DropdownSearchBox = New("TextBox", {
				FontFace = Font.new(Library.Font, Enum.FontWeight.Regular, Enum.FontStyle.Normal),
				PlaceholderText = "Search....",
				Text = "",
				ClearTextOnFocus = false,
				TextColor3 = Color3.fromRGB(240, 240, 240),
				TextSize = 13,
				TextXAlignment = Enum.TextXAlignment.Left,
				Size = UDim2.new(1, -32, 1, 0),
				Position = UDim2.new(0, 28, 0, 0),
				BackgroundTransparency = 1,
				ZIndex = 24,
				ThemeTag = {
					TextColor3 = "Text",
					PlaceholderColor3 = "SubText",
				},
			})

			DropdownSearchHolder = New("Frame", {
				Size = UDim2.new(1, -10, 0, 28),
				Position = UDim2.fromOffset(5, 5),
				BackgroundTransparency = 0.9,
				ZIndex = 24,
				ThemeTag = {
					BackgroundColor3 = "DropdownFrame",
				},
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(0, 5),
				}),
				DropdownSearchIcon,
				DropdownSearchBox,
			})

			DropdownScrollFrame.Position = UDim2.fromOffset(5, 38)
			DropdownScrollFrame.Size = UDim2.new(1, -5, 1, -43)
		end

		local DropdownHolderChildren = {
			DropdownScrollFrame,
			New("UICorner", {
				CornerRadius = UDim.new(0, 7),
			}),
			New("UIStroke", {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				ThemeTag = {
					Color = "DropdownBorder",
				},
			}),
			New("ImageLabel", {
				BackgroundTransparency = 1,
				Image = "http://www.roblox.com/asset/?id=5554236805",
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = Rect.new(23, 23, 277, 277),
				Size = UDim2.fromScale(1, 1) + UDim2.fromOffset(30, 30),
				Position = UDim2.fromOffset(-15, -15),
				ImageColor3 = Color3.fromRGB(0, 0, 0),
				ImageTransparency = 0.1,
			}),
		}
		if DropdownSearchHolder then
			table.insert(DropdownHolderChildren, DropdownSearchHolder)
		end

		local DropdownHolderFrame = New("Frame", {
			Size = UDim2.fromScale(1, 1),
			ThemeTag = {
				BackgroundColor3 = "DropdownHolder",
			},
		}, DropdownHolderChildren)

		Creator.RegisterDropdownTransparency(DropdownHolderFrame)

		local DropdownHolderCanvas = New("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.fromOffset(170, 300),
			Parent = self.Library.GUI,
			Visible = false,
		}, {
			DropdownHolderFrame,
			New("UISizeConstraint", {
				MinSize = Vector2.new(170, 0),
			}),
		})
		table.insert(Library.OpenFrames, DropdownHolderCanvas)

		local function RecalculateListPosition()
			local Add = 0
			if Camera.ViewportSize.Y - DropdownInner.AbsolutePosition.Y < DropdownHolderCanvas.AbsoluteSize.Y - 5 then
				Add = DropdownHolderCanvas.AbsoluteSize.Y
					- 5
					- (Camera.ViewportSize.Y - DropdownInner.AbsolutePosition.Y)
					+ 40
			end
			DropdownHolderCanvas.Position =
				UDim2.fromOffset(DropdownInner.AbsolutePosition.X - 1, DropdownInner.AbsolutePosition.Y - 5 - Add)
		end

		local ListSizeX = 0
		local function CountVisibleOptions()
			local Count = 0
			for _, Option in next, DropdownScrollFrame:GetChildren() do
				if Option:IsA("TextButton") and Option.Visible then
					Count = Count + 1
				end
			end
			return Count
		end

		local function RecalculateListSize()
			if CountVisibleOptions() > 10 then
				DropdownHolderCanvas.Size = UDim2.fromOffset(ListSizeX, 392)
			else
				DropdownHolderCanvas.Size = UDim2.fromOffset(ListSizeX, DropdownListLayout.AbsoluteContentSize.Y + 120)
			end
		end

		local function RecalculateCanvasSize()
			DropdownScrollFrame.CanvasSize = UDim2.fromOffset(0, DropdownListLayout.AbsoluteContentSize.Y)
		end

		RecalculateListPosition()
		RecalculateListSize()

		Creator.AddSignal(DropdownListLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
			RecalculateCanvasSize()
			RecalculateListSize()
		end)

		Creator.AddSignal(DropdownInner:GetPropertyChangedSignal("AbsolutePosition"), RecalculateListPosition)

		Creator.AddSignal(DropdownInner.MouseButton1Click, function()
			Dropdown:Open()
		end)

		Creator.AddSignal(UserInputService.InputBegan, function(Input)
			if
				Input.UserInputType == Enum.UserInputType.MouseButton1
				or Input.UserInputType == Enum.UserInputType.Touch
			then
				local AbsPos, AbsSize = DropdownHolderFrame.AbsolutePosition, DropdownHolderFrame.AbsoluteSize
				if
					Mouse.X < AbsPos.X
					or Mouse.X > AbsPos.X + AbsSize.X
					or Mouse.Y < (AbsPos.Y - 20 - 1)
					or Mouse.Y > AbsPos.Y + AbsSize.Y
				then
					Dropdown:Close()
				end
			end
		end)

		function Dropdown:FilterOptions(Query)
			Query = (Query or ""):lower()
			for _, Option in next, DropdownScrollFrame:GetChildren() do
				if Option:IsA("TextButton") then
					local Label = Option:FindFirstChild("ButtonLabel")
					Option.Visible = Label == nil
						or Query == ""
						or string.find(Label.Text:lower(), Query, 1, true) ~= nil
				end
			end
			RecalculateCanvasSize()
			RecalculateListSize()
		end

		local ScrollFrame = self.ScrollFrame
		function Dropdown:Open()
			Dropdown.Opened = true
			ScrollFrame.ScrollingEnabled = false
			DropdownHolderCanvas.Visible = true
			if DropdownSearchBox then
				DropdownSearchBox.Text = ""
				Dropdown:FilterOptions("")
			end
			TweenService:Create(
				DropdownHolderFrame,
				TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
				{ Size = UDim2.fromScale(1, 1) }
			):Play()
		end

		function Dropdown:Close()
			Dropdown.Opened = false
			ScrollFrame.ScrollingEnabled = true
			DropdownHolderFrame.Size = UDim2.fromScale(1, 0.6)
			DropdownHolderCanvas.Visible = false
		end

		if DropdownSearchBox then
			Creator.AddSignal(DropdownSearchBox:GetPropertyChangedSignal("Text"), function()
				Dropdown:FilterOptions(DropdownSearchBox.Text)
			end)
		end

		function Dropdown:Display()
			local Values = Dropdown.Values
			local Str = ""

			if Config.Multi then
				for Idx, Value in next, Values do
					if Dropdown.Value[Value] then
						Str = Str .. Value .. ", "
					end
				end
				Str = Str:sub(1, #Str - 2)
			else
				Str = Dropdown.Value or ""
			end

			DropdownDisplay.Text = (Str == "" and "--" or Str)
		end

		function Dropdown:GetActiveValues()
			if Config.Multi then
				local T = {}

				for Value, Bool in next, Dropdown.Value do
					table.insert(T, Value)
				end

				return T
			else
				return Dropdown.Value and 1 or 0
			end
		end

		function Dropdown:BuildDropdownList()
			local rawValues = Dropdown.Values
			local Buttons = {}

			for _, child in next, DropdownScrollFrame:GetChildren() do
				if not child:IsA("UIListLayout") then
					child:Destroy()
				end
			end

			local letters, numbers = {}, {}
			for _, v in ipairs(rawValues) do
				local first = tostring(v):sub(1, 1)
				if first:match("%d") then
					table.insert(numbers, v)
				else
					table.insert(letters, v)
				end
			end
			table.sort(letters, function(a, b)
				return tostring(a):lower() < tostring(b):lower()
			end)
			table.sort(numbers, function(a, b)
				return tonumber(tostring(a):match("^%d+")) < tonumber(tostring(b):match("^%d+"))
			end)
			local Values = {}
			for _, v in ipairs(letters) do table.insert(Values, v) end
			for _, v in ipairs(numbers) do table.insert(Values, v) end

			local Count = 0

			for Idx, Value in next, Values do
				local Table = {}

				Count = Count + 1

				local ButtonSelector = New("Frame", {
					Size = UDim2.fromOffset(4, 6),
					BackgroundColor3 = Color3.fromRGB(76, 194, 255),
					BackgroundTransparency = 1,
					Position = UDim2.new(0, -1, 0.5, 0),
					AnchorPoint = Vector2.new(0, 0.5),
					ThemeTag = {
						BackgroundColor3 = "Accent",
					},
				}, {
					New("UICorner", {
						CornerRadius = UDim.new(0, 2),
					}),
				})

				local ButtonLabel = New("TextLabel", {
					FontFace = Font.new(Library.Font),
					Text = Value,
					TextColor3 = Color3.fromRGB(200, 200, 200),
					TextSize = 13,
					TextXAlignment = Enum.TextXAlignment.Left,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundTransparency = 1,
					Size = UDim2.fromScale(1, 1),
					Position = UDim2.fromOffset(10, 0),
					Name = "ButtonLabel",
					ThemeTag = {
						TextColor3 = "Text",
					},
				})

				local Button = New("TextButton", {
					Size = UDim2.new(1, -5, 0, 32),
					BackgroundTransparency = 1,
					ZIndex = 23,
					Text = "",
					Parent = DropdownScrollFrame,
					ThemeTag = {
						BackgroundColor3 = "DropdownOption",
					},
				}, {
					ButtonSelector,
					ButtonLabel,
					New("UICorner", {
						CornerRadius = UDim.new(0, 6),
					}),
				})

				local Selected

				if Config.Multi then
					Selected = Dropdown.Value[Value]
				else
					Selected = Dropdown.Value == Value
				end

				local BackMotor, SetBackTransparency = Creator.SpringMotor(1, Button, "BackgroundTransparency", true)
				local SelMotor, SetSelTransparency = Creator.SpringMotor(1, ButtonSelector, "BackgroundTransparency", true)
				local SelectorSizeMotor = Flipper.SingleMotor.new(6)

				SelectorSizeMotor:onStep(function(value)
					ButtonSelector.Size = UDim2.new(0, 4, 0, value)
				end)

				Creator.AddSignal(Button.MouseEnter, function()
					SetBackTransparency(Selected and 0.85 or 0.89)
				end)
				Creator.AddSignal(Button.MouseLeave, function()
					SetBackTransparency(Selected and 0.89 or 1)
				end)
				Creator.AddSignal(Button.MouseButton1Down, function()
					SetBackTransparency(0.92)
				end)
				Creator.AddSignal(Button.MouseButton1Up, function()
					SetBackTransparency(Selected and 0.85 or 0.89)
				end)

				function Table:UpdateButton()
					if Config.Multi then
						Selected = Dropdown.Value[Value]
						if Selected then
							SetBackTransparency(0.89)
						end
					else
						Selected = Dropdown.Value == Value
						SetBackTransparency(Selected and 0.89 or 1)
					end

					SelectorSizeMotor:setGoal(Flipper.Spring.new(Selected and 14 or 6, { frequency = 6 }))
					SetSelTransparency(Selected and 0 or 1)
				end

				ButtonLabel.InputBegan:Connect(function(Input)
					if
						Input.UserInputType == Enum.UserInputType.MouseButton1
						or Input.UserInputType == Enum.UserInputType.Touch
					then
						local Try = not Selected

						if Dropdown:GetActiveValues() == 1 and not Try and not Config.AllowNull then
						else
							if Config.Multi then
								Selected = Try
								Dropdown.Value[Value] = Selected and true or nil
							else
								Selected = Try
								Dropdown.Value = Selected and Value or nil

								for _, OtherButton in next, Buttons do
									OtherButton:UpdateButton()
								end
							end

							Table:UpdateButton()
							Dropdown:Display()

							Library:SafeCallback(Dropdown.Callback, Dropdown.Value)
							Library:SafeCallback(Dropdown.Changed, Dropdown.Value)
						end
					end
				end)

				Table:UpdateButton()
				Dropdown:Display()

				Buttons[Button] = Table
			end

			ListSizeX = 0
			for Button, Table in next, Buttons do
				if Button.ButtonLabel then
					if Button.ButtonLabel.TextBounds.X > ListSizeX then
						ListSizeX = Button.ButtonLabel.TextBounds.X
					end
				end
			end
			ListSizeX = ListSizeX + 30

			RecalculateCanvasSize()
			RecalculateListSize()

			if DropdownSearchBox then
				Dropdown:FilterOptions(DropdownSearchBox.Text)
			end
		end

		function Dropdown:SetValues(NewValues)
			if NewValues then
				Dropdown.Values = NewValues
			end

			Dropdown:BuildDropdownList()
		end

		function Dropdown:OnChanged(Func)
			Dropdown.Changed = Func
			Func(Dropdown.Value)
		end

		function Dropdown:SetValue(Val)
			if Dropdown.Multi then
				local nTable = {}

				for Value, Bool in next, Val do
					if table.find(Dropdown.Values, Value) then
						nTable[Value] = true
					end
				end

				Dropdown.Value = nTable
			else
				if not Val then
					Dropdown.Value = nil
				elseif table.find(Dropdown.Values, Val) then
					Dropdown.Value = Val
				end
			end

			Dropdown:BuildDropdownList()

			Library:SafeCallback(Dropdown.Callback, Dropdown.Value)
			Library:SafeCallback(Dropdown.Changed, Dropdown.Value)
		end

		function Dropdown:Destroy()
			DropdownFrame:Destroy()
			Library.Options[Idx] = nil
		end

		Dropdown:BuildDropdownList()
		Dropdown:Display()

		local Defaults = {}

		if type(Config.Default) == "string" then
			local Idx = table.find(Dropdown.Values, Config.Default)
			if Idx then
				table.insert(Defaults, Idx)
			end
		elseif type(Config.Default) == "table" then
			for _, Value in next, Config.Default do
				local Idx = table.find(Dropdown.Values, Value)
				if Idx then
					table.insert(Defaults, Idx)
				end
			end
		elseif type(Config.Default) == "number" and Dropdown.Values[Config.Default] ~= nil then
			table.insert(Defaults, Config.Default)
		end

		if next(Defaults) then
			for i = 1, #Defaults do
				local Index = Defaults[i]
				if Config.Multi then
					Dropdown.Value[Dropdown.Values[Index]] = true
				else
					Dropdown.Value = Dropdown.Values[Index]
				end

				if not Config.Multi then
					break
				end
			end

			Dropdown:BuildDropdownList()
			Dropdown:Display()
		end

		Library.Options[Idx] = Dropdown
		return Dropdown
	end

	return Element
end)()

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

ElementsTable.Keybind = (function()
	local New = Creator.New

	local Element = {}
	Element.__index = Element
	Element.__type = "Keybind"

	function Element:New(Idx, Config)
		local Library = self.Library
		assert(Config.Title, "KeyBind - Missing Title")
		assert(Config.Default, "KeyBind - Missing default value.")

		local Keybind = {
			Value = Config.Default,
			Toggled = false,
			Mode = Config.Mode or "Toggle",
			Type = "Keybind",
			Callback = Config.Callback or function(Value) end,
			ChangedCallback = Config.ChangedCallback or function(New) end,
		}

		local Picking = false

		local IsGrouped = self.Type == "Group" or self.Type == "HStack" or self.Type == "VStack"

		local KeybindFrame = Components.Element(Config.Title, Config.Description, self.Container, true, Config.LayoutOrder, Config.Icon, Config.Marquee)

		KeybindFrame.TitleLabel.Size = UDim2.new(1, -70, 0, 14)
		KeybindFrame.DescLabel.Size = UDim2.new(1, -70, 0, 14)

		Keybind.SetTitle = KeybindFrame.SetTitle
		Keybind.SetDesc = KeybindFrame.SetDesc

		local KeybindDisplayLabel = New("TextLabel", {
			FontFace = Font.new(Library.Font, Enum.FontWeight.Regular, Enum.FontStyle.Normal),
			Text = Config.Default,
			TextColor3 = Color3.fromRGB(240, 240, 240),
			TextSize = 13,
			TextXAlignment = Enum.TextXAlignment.Center,
			Size = UDim2.new(0, 0, 0, 14),
			Position = UDim2.new(0, 0, 0.5, 0),
			AnchorPoint = Vector2.new(0, 0.5),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			AutomaticSize = Enum.AutomaticSize.X,
			BackgroundTransparency = 1,
			ThemeTag = {
				TextColor3 = "Text",
			},
		})

		local KeybindDisplayFrame = New("TextButton", {
			Size = UDim2.fromOffset(0, 30),
			Position = UDim2.new(1, -10, 0.5, 0),
			AnchorPoint = Vector2.new(1, 0.5),
			BackgroundTransparency = 0.9,
			Parent = KeybindFrame.Frame,
			AutomaticSize = Enum.AutomaticSize.X,
			ThemeTag = {
				BackgroundColor3 = "Keybind",
			},
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 5),
			}),
			New("UIPadding", {
				PaddingLeft = UDim.new(0, 8),
				PaddingRight = UDim.new(0, 8),
			}),
			New("UIStroke", {
				Transparency = 0.5,
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				ThemeTag = {
					Color = "InElementBorder",
				},
			}),
			KeybindDisplayLabel,
		})

		function Keybind:GetState()
			if UserInputService:GetFocusedTextBox() and Keybind.Mode ~= "Always" then
				return false
			end

			if Keybind.Mode == "Always" then
				return true
			elseif Keybind.Mode == "Hold" then
				if Keybind.Value == "None" then
					return false
				end

				local Key = Keybind.Value

				if Key == "MouseLeft" or Key == "MouseRight" then
					return Key == "MouseLeft" and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
						or Key == "MouseRight"
							and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)
				else
					return UserInputService:IsKeyDown(Enum.KeyCode[Keybind.Value])
				end
			else
				return Keybind.Toggled
			end
		end

		function Keybind:SetValue(Key, Mode)
			Key = Key or Keybind.Key
			Mode = Mode or Keybind.Mode

			KeybindDisplayLabel.Text = Key
			Keybind.Value = Key
			Keybind.Mode = Mode
		end

		function Keybind:OnClick(Callback)
			Keybind.Clicked = Callback
		end

		function Keybind:OnChanged(Callback)
			Keybind.Changed = Callback
			Callback(Keybind.Value)
		end

		function Keybind:DoClick()
			Library:SafeCallback(Keybind.Callback, Keybind.Toggled)
			Library:SafeCallback(Keybind.Clicked, Keybind.Toggled)
		end

		function Keybind:Destroy()
			KeybindFrame:Destroy()
			Library.Options[Idx] = nil
		end

		Creator.AddSignal(KeybindDisplayFrame.InputBegan, function(Input)
			if
				Input.UserInputType == Enum.UserInputType.MouseButton1
				or Input.UserInputType == Enum.UserInputType.Touch
			then
				Picking = true
				KeybindDisplayLabel.Text = "..."

				wait(0.2)

				local Event
				Event = UserInputService.InputBegan:Connect(function(Input)
					local Key

					if Input.UserInputType == Enum.UserInputType.Keyboard then
						Key = Input.KeyCode.Name
					elseif Input.UserInputType == Enum.UserInputType.MouseButton1 then
						Key = "MouseLeft"
					elseif Input.UserInputType == Enum.UserInputType.MouseButton2 then
						Key = "MouseRight"
					end

					local EndedEvent
					EndedEvent = UserInputService.InputEnded:Connect(function(Input)
						if
							Input.KeyCode.Name == Key
							or Key == "MouseLeft" and Input.UserInputType == Enum.UserInputType.MouseButton1
							or Key == "MouseRight" and Input.UserInputType == Enum.UserInputType.MouseButton2
						then
							Picking = false

							KeybindDisplayLabel.Text = Key
							Keybind.Value = Key

							Library:SafeCallback(Keybind.ChangedCallback, Input.KeyCode or Input.UserInputType)
							Library:SafeCallback(Keybind.Changed, Input.KeyCode or Input.UserInputType)

							Event:Disconnect()
							EndedEvent:Disconnect()
						end
					end)
				end)
			end
		end)

		Creator.AddSignal(UserInputService.InputBegan, function(Input)
			if not Picking and not UserInputService:GetFocusedTextBox() then
				if Keybind.Mode == "Toggle" then
					local Key = Keybind.Value

					if Key == "MouseLeft" or Key == "MouseRight" then
						if
							Key == "MouseLeft" and Input.UserInputType == Enum.UserInputType.MouseButton1
							or Key == "MouseRight" and Input.UserInputType == Enum.UserInputType.MouseButton2
						then
							Keybind.Toggled = not Keybind.Toggled
							Keybind:DoClick()
						end
					elseif Input.UserInputType == Enum.UserInputType.Keyboard then
						if Input.KeyCode.Name == Key then
							Keybind.Toggled = not Keybind.Toggled
							Keybind:DoClick()
						end
					end
				end
			end
		end)

		Library.Options[Idx] = Keybind
		return Keybind
	end

	return Element
end)()

ElementsTable.Paragraph = (function()
	local Paragraph = {}
	Paragraph.__index = Paragraph
	Paragraph.__type = "Paragraph"

	function Paragraph:New(Config)
		assert(Config.Title, "Paragraph - Missing Title")
		Config.Content = Config.Content or ""

		local ParagraphFrame = Components.Element(Config.Title, Config.Content, Paragraph.Container, false, Config.LayoutOrder, Config.Icon, Config.Marquee == true)
		ParagraphFrame.Frame.BackgroundTransparency = 0.92
		ParagraphFrame.Border.Transparency = 0.6

		local Para = ParagraphFrame
		Para.SetTitle = ParagraphFrame.SetTitle
		Para.SetDesc = ParagraphFrame.SetDesc
		Para.SetContent = ParagraphFrame.SetDesc

		return Para
	end

	return Paragraph
end)()

ElementsTable.Slider = (function()
	local New = Creator.New

	local Element = {}
	Element.__index = Element
	Element.__type = "Slider"

	function Element:New(Idx, Config)
		local Library = self.Library
		assert(Config.Title, "Slider - Missing Title.")
		assert(Config.Default, "Slider - Missing default value.")
		assert(Config.Min, "Slider - Missing minimum value.")
		assert(Config.Max, "Slider - Missing maximum value.")
		assert(Config.Rounding, "Slider - Missing rounding value.")

		local Slider = {
			Value = nil,
			Min = Config.Min,
			Max = Config.Max,
			Rounding = Config.Rounding,
			Callback = Config.Callback or function(Value) end,
			Type = "Slider",
		}

		local Dragging = false
		local IsGrouped = self.Type == "Group" or self.Type == "HStack" or self.Type == "VStack"

		local SliderFrame = Components.Element(Config.Title, Config.Description, self.Container, false, Config.LayoutOrder, Config.Icon, Config.Marquee)

		local SliderDot, SliderRail, SliderFill, SliderDisplay, SliderInner, SliderRow, SliderHit, SliderValueTooltip, SliderConstraint
		local ShowTooltip, HideTooltip

		SliderRow = New("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, 20),
			LayoutOrder = 2,
			Visible = IsGrouped,
			Parent = SliderFrame.LabelHolder,
		})

		if Library.NewVisual then

			SliderValueTooltip = New("CanvasGroup", {
				AnchorPoint = Vector2.new(0.5, 1),
				Position = UDim2.new(0, 0, 0, -6),
				Size = UDim2.fromOffset(48, 22),
				BackgroundTransparency = 0,
				GroupTransparency = 1,
				Visible = true,
				ZIndex = 10,
				ThemeTag = {
					BackgroundColor3 = "Element",
				},
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
				New("TextLabel", {
					Name = "ValueLabel",
					FontFace = Font.new(Library.Font, Enum.FontWeight.Medium, Enum.FontStyle.Normal),
					Text = "0",
					TextSize = 11,
					TextXAlignment = Enum.TextXAlignment.Center,
					BackgroundTransparency = 1,
					Size = UDim2.fromScale(1, 1),
					ZIndex = 10,
					ThemeTag = {
						TextColor3 = "Text",
					},
				}),
			})

			SliderDot = New("Frame", {
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.new(0, 0, 0.5, 0),
				Size = UDim2.fromOffset(3, 18),
				ZIndex = 5,
				ThemeTag = {
					BackgroundColor3 = "Accent",
				},
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(0, 2),
				}),
				New("UIStroke", {
					Thickness = 1.5,
					Transparency = 0.3,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					ThemeTag = {
						Color = "AcrylicBorder",
					},
				}),
				SliderValueTooltip,
			})

			SliderRail = New("Frame", {
				BackgroundTransparency = 1,
				Position = UDim2.fromOffset(0, 0),
				Size = UDim2.fromScale(1, 1),
			}, {
				SliderDot,
			})

			SliderFill = New("Frame", {
				Size = UDim2.new(0, 0, 1, 0),
				ThemeTag = {
					BackgroundColor3 = "Accent",
				},
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(1, 0),
				}),
			})

			SliderInner = New("Frame", {
				Size = IsGrouped and UDim2.new(1, -40, 0, 4) or UDim2.new(1, 0, 0, 4),
				AnchorPoint = Vector2.new(1, 0.5),
				Position = IsGrouped and UDim2.new(1, -8, 0.5, 0) or UDim2.new(1, -10, 0.5, 0),
				BackgroundTransparency = 0.4,
				Parent = IsGrouped and SliderRow or SliderFrame.Frame,
				ThemeTag = {
					BackgroundColor3 = "SliderRail",
				},
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(1, 0),
				}),
			})

			SliderDisplay = New("TextLabel", {
				FontFace = Font.new(Library.Font),
				Text = "Value",
				TextSize = 12,
				TextWrapped = true,
				TextXAlignment = Enum.TextXAlignment.Right,
				BackgroundTransparency = 1,
				Size = UDim2.new(0, 100, 0, 14),
				Position = UDim2.new(0, -4, 0.5, 0),
				AnchorPoint = Vector2.new(1, 0.5),
				Visible = IsGrouped,
				Parent = SliderInner,
				ThemeTag = {
					TextColor3 = "SubText",
				},
			})

			SliderConstraint = New("UISizeConstraint", {
				MaxSize = IsGrouped and Vector2.new(math.huge, math.huge) or Vector2.new(150, math.huge),
				Parent = SliderInner,
			})

			SliderFill.Parent = SliderInner
			SliderRail.Parent = SliderInner

			SliderHit = New("Frame", {
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.fromScale(0.5, 0.5),
				Size = UDim2.new(1, 12, 0, 24),
				BackgroundTransparency = 1,
				ZIndex = 2,
				Parent = SliderInner,
			})

			local TooltipTween

			local function SetTooltipVisible(Visible)
				if TooltipTween then
					TooltipTween:Cancel()
				end
				TooltipTween = TweenService:Create(
					SliderValueTooltip,
					TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{ GroupTransparency = Visible and 0 or 1 }
				)
				TooltipTween:Play()
			end

			ShowTooltip = function()
				SetTooltipVisible(true)
			end

			HideTooltip = function()
				SetTooltipVisible(false)
			end
		else
			SliderDot = New("ImageLabel", {
				AnchorPoint = Vector2.new(0, 0.5),
				Position = UDim2.new(0, -7, 0.5, 0),
				Size = UDim2.fromOffset(14, 14),
				Image = "http://www.roblox.com/asset/?id=12266946128",
				ThemeTag = {
					ImageColor3 = "Accent",
				},
			})

			SliderRail = New("Frame", {
				BackgroundTransparency = 1,
				Position = UDim2.fromOffset(7, 0),
				Size = UDim2.new(1, -14, 1, 0),
			}, {
				SliderDot,
			})

			SliderFill = New("Frame", {
				Size = UDim2.new(0, 0, 1, 0),
				ThemeTag = {
					BackgroundColor3 = "Accent",
				},
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(1, 0),
				}),
			})

			SliderDisplay = New("TextLabel", {
				FontFace = Font.new(Library.Font),
				Text = "Value",
				TextSize = 12,
				TextWrapped = true,
				TextXAlignment = Enum.TextXAlignment.Right,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				Size = UDim2.new(0, 100, 0, 14),
				Position = UDim2.new(0, -4, 0.5, 0),
				AnchorPoint = Vector2.new(1, 0.5),
				ThemeTag = {
					TextColor3 = "SubText",
				},
			})

			SliderConstraint = New("UISizeConstraint", {
				MaxSize = IsGrouped and Vector2.new(math.huge, math.huge) or Vector2.new(150, math.huge),
			})

			SliderInner = New("Frame", {
				Size = IsGrouped and UDim2.new(1, -40, 0, 4) or UDim2.new(1, 0, 0, 4),
				AnchorPoint = Vector2.new(1, 0.5),
				Position = IsGrouped and UDim2.new(1, -8, 0.5, 0) or UDim2.new(1, -10, 0.5, 0),
				BackgroundTransparency = 0.4,
				Parent = IsGrouped and SliderRow or SliderFrame.Frame,
				ThemeTag = {
					BackgroundColor3 = "SliderRail",
				},
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(1, 0),
				}),
				SliderConstraint,
				SliderDisplay,
				SliderFill,
				SliderRail,
			})
		end

		Creator.Adaptive(SliderFrame, 170, 340, not IsGrouped, function(Inline)
			SliderRow.Visible = not Inline
			SliderInner.Parent = Inline and SliderFrame.Frame or SliderRow
			SliderInner.Size = Inline and UDim2.new(1, 0, 0, 4) or UDim2.new(1, -40, 0, 4)
			SliderInner.Position = Inline and UDim2.new(1, -10, 0.5, 0) or UDim2.new(1, -8, 0.5, 0)
			SliderConstraint.MaxSize = Inline and Vector2.new(150, math.huge) or Vector2.new(math.huge, math.huge)
			if Library.NewVisual then
				SliderDisplay.Visible = not Inline
			end
		end)

		Slider.SetTitle = SliderFrame.SetTitle
		Slider.SetDesc = SliderFrame.SetDesc

		local function BeginDrag(Input)
			if
				Input.UserInputType == Enum.UserInputType.MouseButton1
				or Input.UserInputType == Enum.UserInputType.Touch
			then
				Dragging = true
				if ShowTooltip then
					ShowTooltip()
				end
				local SizeScale =
					math.clamp((Input.Position.X - SliderRail.AbsolutePosition.X) / SliderRail.AbsoluteSize.X, 0, 1)
				Slider:SetValue(Slider.Min + ((Slider.Max - Slider.Min) * SizeScale))
			end
		end

		Creator.AddSignal(SliderDot.InputBegan, function(Input)
			if
				Input.UserInputType == Enum.UserInputType.MouseButton1
				or Input.UserInputType == Enum.UserInputType.Touch
			then
				Dragging = true
				if ShowTooltip then
					ShowTooltip()
				end
			end
		end)

		Creator.AddSignal(SliderRail.InputBegan, BeginDrag)

		if SliderHit then
			Creator.AddSignal(SliderHit.InputBegan, BeginDrag)
		end

		Creator.AddSignal(UserInputService.InputEnded, function(Input)
			if
				Input.UserInputType == Enum.UserInputType.MouseButton1
				or Input.UserInputType == Enum.UserInputType.Touch
			then
				Dragging = false
				if HideTooltip then
					HideTooltip()
				end
			end
		end)

		Creator.AddSignal(UserInputService.InputChanged, function(Input)
			if
				Dragging
				and (
					Input.UserInputType == Enum.UserInputType.MouseMovement
					or Input.UserInputType == Enum.UserInputType.Touch
				)
			then
				local SizeScale =
					math.clamp((Input.Position.X - SliderRail.AbsolutePosition.X) / SliderRail.AbsoluteSize.X, 0, 1)
				Slider:SetValue(Slider.Min + ((Slider.Max - Slider.Min) * SizeScale))
			end
		end)

		function Slider:OnChanged(Func)
			Slider.Changed = Func
			Func(Slider.Value)
		end

		function Slider:SetValue(Value)
			self.Value = Library:Round(math.clamp(Value, Slider.Min, Slider.Max), Slider.Rounding)
			local Scale = (self.Value - Slider.Min) / (Slider.Max - Slider.Min)
			if SliderValueTooltip then
				SliderDot.Position = UDim2.new(Scale, 0, 0.5, 0)
				SliderValueTooltip.ValueLabel.Text = tostring(self.Value)
			else
				SliderDot.Position = UDim2.new(Scale, -7, 0.5, 0)
			end
			SliderFill.Size = UDim2.fromScale(Scale, 1)
			if SliderDisplay then
				SliderDisplay.Text = tostring(self.Value)
			end

			Library:SafeCallback(Slider.Callback, self.Value)
			Library:SafeCallback(Slider.Changed, self.Value)
		end

		function Slider:Destroy()
			SliderFrame:Destroy()
			Library.Options[Idx] = nil
		end

		Slider:SetValue(Config.Default)

		Library.Options[Idx] = Slider
		return Slider
	end

	return Element
end)()


ElementsTable.Toggle = (function()
	local New = Creator.New

	local Element = {}
	Element.__index = Element
	Element.__type = "Toggle"

	function Element:New(Idx, Config)
		local Library = self.Library
		assert(Config.Title, "Toggle - Missing Title")

		local Toggle = {
			Value = Config.Default or false,
			Callback = Config.Callback or function(Value) end,
			Type = "Toggle",
		}

		local IsGrouped = self.Type == "Group" or self.Type == "HStack" or self.Type == "VStack"

		local ToggleFrame = Components.Element(Config.Title, Config.Description, self.Container, true, Config.LayoutOrder, Config.Icon, Config.Marquee)
		ToggleFrame.DescLabel.Size = UDim2.new(1, -54, 0, 14)
		ToggleFrame.TitleLabel.Size = UDim2.new(1, -54, 0, 14)

		Toggle.SetTitle = ToggleFrame.SetTitle
		Toggle.SetDesc = ToggleFrame.SetDesc

		local ToggleCircle = New("ImageLabel", {
			AnchorPoint = Vector2.new(0, 0.5),
			Size = UDim2.fromOffset(14, 14),
			Position = UDim2.new(0, 2, 0.5, 0),
			Image = "http://www.roblox.com/asset/?id=12266946128",
			ImageTransparency = 0.5,
			ThemeTag = {
				ImageColor3 = "ToggleSlider",
			},
		})

		local ToggleBorder = New("UIStroke", {
			Transparency = 0.5,
			ThemeTag = {
				Color = "ToggleSlider",
			},
		})

		local ToggleSlider = New("Frame", {
			Size = UDim2.fromOffset(36, 18),
			AnchorPoint = Vector2.new(1, 0.5),
			Position = UDim2.new(1, -10, 0.5, 0),
			Parent = ToggleFrame.Frame,
			BackgroundTransparency = 1,
			ThemeTag = {
				BackgroundColor3 = "Accent",
			},
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 9),
			}),
			ToggleBorder,
			ToggleCircle,
		})

		function Toggle:OnChanged(Func)
			Toggle.Changed = Func
			Func(Toggle.Value)
		end

		local ToggleCircleIcon
		if Library.NewVisual then
			ToggleCircleIcon = New("ImageLabel", {
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.fromScale(0.5, 0.5),
				Size = UDim2.fromOffset(8, 8),
				BackgroundTransparency = 1,
				Image = "rbxassetid://110786993356448",
				ImageColor3 = Color3.new(1, 1, 1),
				ZIndex = 2,
				Parent = ToggleCircle,
			})
		end

		local function UpdateToggleIconColor()
			if not ToggleCircleIcon then return end
			local KnobColor = Creator.GetThemeProperty(Toggle.Value and "ToggleToggled" or "ToggleSlider")
			ToggleCircleIcon.ImageColor3 = Color3.new(1 - KnobColor.R, 1 - KnobColor.G, 1 - KnobColor.B)
		end

		if Library.NewVisual then
			Creator.OnThemeChanged(UpdateToggleIconColor)
		end

		function Toggle:SetValue(Value)
			Value = not not Value
			Toggle.Value = Value

			Creator.OverrideTag(ToggleBorder, { Color = Toggle.Value and "Accent" or "ToggleSlider" })
			Creator.OverrideTag(ToggleCircle, { ImageColor3 = Toggle.Value and "ToggleToggled" or "ToggleSlider" })
			if Library.NewVisual then
				ToggleCircleIcon.Image = Toggle.Value and "rbxassetid://93898873302694" or "rbxassetid://110786993356448"
				UpdateToggleIconColor()
			end
			TweenService:Create(
				ToggleCircle,
				TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
				{ Position = UDim2.new(0, Toggle.Value and 19 or 2, 0.5, 0) }
			):Play()
			TweenService:Create(
				ToggleSlider,
				TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
				{ BackgroundTransparency = Toggle.Value and 0 or 1 }
			):Play()
			ToggleCircle.ImageTransparency = Toggle.Value and 0 or 0.5

			Library:SafeCallback(Toggle.Callback, Toggle.Value)
			Library:SafeCallback(Toggle.Changed, Toggle.Value)
		end

		function Toggle:Destroy()
			ToggleFrame:Destroy()
			Library.Options[Idx] = nil
		end

		Creator.AddSignal(ToggleFrame.Frame.MouseButton1Click, function()
			Toggle:SetValue(not Toggle.Value)
		end)

		Toggle:SetValue(Toggle.Value)

		Library.Options[Idx] = Toggle
		return Toggle
	end

	return Element
end)()

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

		local ImageLabel = New("ImageLabel", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			Image = ResolveImage(Config.Image or ""),
			ScaleType = Enum.ScaleType.Fit,
			Parent = Wrap,
		}, {
			New("UICorner", { CornerRadius = UDim.new(0, Radius) }),
		})

		local Image = { Frame = Wrap, Type = "Image" }

		function Image:SetImage(Source)
			ImageLabel.Image = ResolveImage(Source)
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

local IconCache = {}

local IconURLsFlat = {
	lucide = "https://raw.githubusercontent.com/StyearX/Icons/refs/heads/main/lucide/dist/Icons.lua",
	solar = "https://raw.githubusercontent.com/StyearX/Icons/refs/heads/main/solar/dist/Icons.lua",
	gravity = "https://raw.githubusercontent.com/StyearX/Icons/refs/heads/main/gravity/dist/Icons.lua",
	hero = "https://raw.githubusercontent.com/StyearX/Icons/refs/heads/main/hero/dist/Icons.lua",
	feather = "https://raw.githubusercontent.com/StyearX/Icons/refs/heads/main/Feather/dist/Icons.lua",
	sfsymbols = "https://raw.githubusercontent.com/StyearX/Icons/refs/heads/main/sfsymbols/dist/Icons.lua",
	geist = "https://raw.githubusercontent.com/StyearX/Icons/refs/heads/main/geist/dist/Icons.lua",
}

local IconURLsSprite = {
	tabler = "https://raw.githubusercontent.com/StyearX/Icons/refs/heads/main/Tabler/dist/Icons.lua",
	phosphor = "https://raw.githubusercontent.com/StyearX/Icons/refs/heads/main/Phosphor/dist/Icons.lua",
	bootstrap = "https://raw.githubusercontent.com/StyearX/Icons/refs/heads/main/Bootstrap/dist/Icons.lua",
	craft = "https://raw.githubusercontent.com/StyearX/Icons/refs/heads/main/craft/dist/Icons.lua",
	prime = "https://raw.githubusercontent.com/StyearX/Icons/refs/heads/main/prime/dist/Icons.lua",
	pixelart = "https://raw.githubusercontent.com/StyearX/Icons/refs/heads/main/PixelArtsIcons/dist/Icons.lua",
}

local MaterialBase = "https://raw.githubusercontent.com/StyearX/Icons/refs/heads/main/Material/dist/"

local function MakeMaterialUrls(style, counts)
	local urls = {}
	for _, size in next, { "18", "24", "36", "48" } do
		urls[size] = {}
		for i = 1, counts do
			table.insert(urls[size], MaterialBase .. style .. size .. "Part" .. i .. ".lua")
		end
	end
	return urls
end

local MaterialVariantUrls = {
	default  = MakeMaterialUrls("Default",  4),
	outlined = MakeMaterialUrls("Outlined", 2),
	round    = MakeMaterialUrls("Round",    2),
	sharp    = MakeMaterialUrls("Sharp",    2),
	twotone  = MakeMaterialUrls("Twotone",  2),
}

local IconVariants = {
	fluent = { DefaultVariant = "filled",  filled = "https://raw.githubusercontent.com/StyearX/Icons/refs/heads/main/Fluent/dist/Variant/Filled/Icons.lua",  outlined = "https://raw.githubusercontent.com/StyearX/Icons/refs/heads/main/Fluent/dist/Variant/Outlined/Icons.lua" },
	mynaui = { DefaultVariant = "solid",   solid = "https://raw.githubusercontent.com/StyearX/Icons/refs/heads/main/MynaUi/dist/Variant/Solid/Icons.lua",   regular = "https://raw.githubusercontent.com/StyearX/Icons/refs/heads/main/MynaUi/dist/Variant/Regular/Icons.lua" },
	weui = { DefaultVariant = "filled",  filled = "https://raw.githubusercontent.com/StyearX/Icons/refs/heads/main/WeUi/dist/Variant/Filled/Icons.lua",    outlined = "https://raw.githubusercontent.com/StyearX/Icons/refs/heads/main/WeUi/dist/Variant/Outlined/Icons.lua" },
}
IconVariants.material = setmetatable({ DefaultVariant = "default" }, {
	__index = function(_, key)
		local k = key:lower():gsub("[ -]", "")
		if k == "twotone" or k == "two tone" then k = "twotone" end
		return MaterialVariantUrls[k]
	end,
})

local function LoadOnePart(url)
	local ok, raw = pcall(game.HttpGet, game, url, true)
	if not ok or not raw then return nil end
	local chunk = loadstring(raw)
	if not chunk then return nil end
	local ok2, result = pcall(chunk)
	if not ok2 or type(result) ~= "table" then return nil end
	return result
end

local function LoadIconSource(cacheKey, url)
	if IconCache[cacheKey] then return IconCache[cacheKey] end

	if type(url) == "table" then
		local merged = {}
		for _, partUrl in next, url do
			local result = LoadOnePart(partUrl)
			if result then
				for k, v in next, result do
					merged[k] = v
				end
			end
		end
		IconCache[cacheKey] = merged
		return merged
	end

	local raw = game:HttpGet(url, true)
	local patched = raw:gsub("\n(%s*)([%a][%w%-_]*)%s*=%s*%{", function(indent, key)
		if key == "return" or key == "Icons" or key == "Spritesheets" then
			return "\n" .. indent .. key .. " = {"
		end
		return "\n" .. indent .. '["' .. key .. '"] = {'
	end)
	local ok, result = pcall(loadstring(patched))
	if not ok then
		warn("[Icons] Failed to load '" .. cacheKey .. "': " .. tostring(result))
		return nil
	end
	if result and result.Icons then
		IconCache[cacheKey] = { _sprites = result.Spritesheets or {}, _icons = result.Icons }
	else
		IconCache[cacheKey] = result
	end
	return IconCache[cacheKey]
end

local function ResolveSpritesheetEntry(entry, sprites)
	local sheetId = sprites[tostring(entry.Image)] or sprites[entry.Image] or tostring(entry.Image or "")
	local offset = entry.ImageRectOffset or entry.ImageRectPosition or Vector2.new(0, 0)
	local size = entry.ImageRectSize or Vector2.new(0, 0)
	return { Image = sheetId, ImageRectOffset = offset, ImageRectSize = size }
end

local function ToPascalKebab(s)
	return (s:gsub("(%a)([^%-_]*)", function(first, rest)
		return first:upper() .. rest
	end))
end

local function LookupInSource(src, iconName)
	if src._icons then
		local entry = src._icons[iconName]
		if not entry then return nil end
		return ResolveSpritesheetEntry(entry, src._sprites)
	end
	local val = src[iconName]
	if val == nil then val = src[ToPascalKebab(iconName)] end
	if type(val) == "table" and val.Image then
		return {
			Image = tostring(val.Image),
			ImageRectOffset = val.ImageRectOffset or Vector2.new(0, 0),
			ImageRectSize = val.ImageRectSize or Vector2.new(0, 0),
		}
	end
	if type(val) == "string" then
		return { Image = val, ImageRectOffset = Vector2.new(0, 0), ImageRectSize = Vector2.new(0, 0) }
	end
	return nil
end

local NotificationModule = Components.Notification
NotificationModule:Init(GUI)

function Library:GetIcon(Name)
	if Name == nil or Name == "" then return nil end

	if type(Name) == "string" and (Name:match("^rbxassetid://") or Name:match("^rbxasset://")) then
		return { Image = Name, ImageRectOffset = Vector2.zero, ImageRectSize = Vector2.zero }
	end

	local segments = {}
	for seg in Name:gmatch("[^/]+") do
		table.insert(segments, seg)
	end

	if #segments == 0 then return nil end

	local pack = segments[1]:lower()

	if #segments >= 3 then
		local variantInfo = IconVariants[pack]
		if variantInfo then
			local rawVariant = segments[2]:lower()
			local iconName = table.concat(segments, "/", 3)
			local urlOrTable = variantInfo[rawVariant]
			if not urlOrTable then return nil end
			if type(urlOrTable) == "table" and not urlOrTable[1] then
				local sizeKey = segments[3]:gsub("[^%d]", "")
				if sizeKey ~= "" and #segments >= 4 then
					local parts = urlOrTable[sizeKey]
					if not parts then return nil end
					local iName = table.concat(segments, "/", 4)
					local cacheKey = pack .. ":" .. rawVariant .. ":" .. sizeKey
					local src = LoadIconSource(cacheKey, parts)
					if not src then return nil end
					return LookupInSource(src, iName)
				end
				local parts = urlOrTable["18"]
				if not parts then return nil end
				local cacheKey = pack .. ":" .. rawVariant .. ":18"
				local src = LoadIconSource(cacheKey, parts)
				if not src then return nil end
				return LookupInSource(src, iconName)
			end
			local cacheKey = pack .. ":" .. rawVariant
			local src = LoadIconSource(cacheKey, urlOrTable)
			if not src then return nil end
			return LookupInSource(src, iconName)
		end
	end

	if #segments >= 2 then
		local iconName = table.concat(segments, "/", 2)
		local variantInfo = IconVariants[pack]
		if variantInfo then
			local defVariant = variantInfo.DefaultVariant
			local urlOrTable = variantInfo[defVariant]
			if type(urlOrTable) == "table" and not urlOrTable[1] then
				local parts = urlOrTable["18"]
				if not parts then return nil end
				local cacheKey = pack .. ":" .. defVariant .. ":18"
				local src = LoadIconSource(cacheKey, parts)
				if not src then return nil end
				return LookupInSource(src, iconName)
			end
			local cacheKey = pack .. ":" .. defVariant
			local src = LoadIconSource(cacheKey, urlOrTable)
			if not src then return nil end
			return LookupInSource(src, iconName)
		end

		local flatUrl = IconURLsFlat[pack]
		if flatUrl then
			local src = LoadIconSource(pack, flatUrl)
			if not src then return nil end
			return LookupInSource(src, iconName)
		end

		local spriteUrl = IconURLsSprite[pack]
		if spriteUrl then
			local src = LoadIconSource(pack, spriteUrl)
			if not src then return nil end
			return LookupInSource(src, iconName)
		end

		return nil
	end

	local src = LoadIconSource("lucide", IconURLsFlat.lucide)
	if not src then return nil end
	local val = src[Name] or src["lucide-" .. Name]
	if type(val) == "string" then
		return { Image = val, ImageRectOffset = Vector2.new(0, 0), ImageRectSize = Vector2.new(0, 0) }
	end
	return nil
end

Elements = {}
Elements.__index = Elements
Elements.__namecall = function(Table, Key, ...)
	return Elements[Key](...)
end

for _, ElementComponent in pairs(ElementsTable) do
	local AddMethod = function(self, Idx, Config)
		ElementComponent.Container = self.Container
		ElementComponent.Type = self.Type
		ElementComponent.ScrollFrame = self.ScrollFrame
		ElementComponent.Library = Library

		local resolvedConfig = Config
		if resolvedConfig == nil and type(Idx) == "table" then
			resolvedConfig = Idx
		end

		if type(resolvedConfig) == "table" and not resolvedConfig.LayoutOrder then
			self._layoutOrder = (self._layoutOrder or 0) + 1
			resolvedConfig.LayoutOrder = self._layoutOrder
		end

		return ElementComponent:New(Idx, Config)
	end

	Elements["Add" .. ElementComponent.__type] = AddMethod
	Elements[ElementComponent.__type] = AddMethod
end

Elements.Switch = Elements.Toggle
Elements.AddSwitch = Elements.AddToggle
Elements.EmptyFrame = Elements.Space
Elements.AddEmptyFrame = Elements.AddSpace

Library.Elements = Elements

function Library:CreateWindow(Config)
	assert(Config.Title, "Window - Missing Title")

	if Library.Window then
		print("You cannot create more than one window.")
		return
	end

	Library.MinimizeKey = Config.MinimizeKey or Enum.KeyCode.LeftControl
	Library.UseAcrylic = Config.Acrylic or false
	Library.Acrylic = Config.Acrylic or false
	Library.Theme = Config.Theme or "Dark"
	if Config.Acrylic then
		Acrylic.init()
	end

	Library.NewVisual = Config.NewVisual == true

	local Window = Components.Window({
		Parent = GUI,
		Size = Config.Size,
		Title = Config.Title,
		SubTitle = Config.SubTitle,
		TabWidth = Config.TabWidth,
		Search = Config.Search,
		UserInfo = Config.UserInfo,
		NewVisual = Library.NewVisual,
	})

	Library.Window = Window
	Library:SetTheme(Config.Theme)

	return Window
end

function Library:SetTheme(Value)
	if not Library.Window then return end
	if type(Value) == "table" then
		Library.Theme = Value.Name or "Custom"
		Library.CustomThemeData = Value
		Creator.UpdateTheme()
	elseif table.find(Library.Themes, Value) then
		Library.Theme = Value
		Library.CustomThemeData = nil
		Creator.UpdateTheme()
	end
end

function Library:SetFont(fontAsset)
	Library.Font = fontAsset
	Creator.UpdateFont()
end

function Library:Destroy()
	if Library.Window then
		Library.Unloaded = true
		if Library.UseAcrylic then
			Library.Window.AcrylicPaint.Model:Destroy()
		end
		Creator.Disconnect()
		Library.GUI:Destroy()
	end
end

function Library:ToggleAcrylic(Value)
	if Library.Window then
		if Library.UseAcrylic then
			Library.Acrylic = Value
			Library.Window.AcrylicPaint.Model.Transparency = Value and 0.98 or 1
			if Value then
				Acrylic.Enable()
			else
				Acrylic.Disable()
			end
		end
	end
end

function Library:SetTransparency(Value)
	if type(Value) == "boolean" then
		Value = Value and 0.35 or 0
	end
	Value = math.clamp(tonumber(Value) or 0, 0, 1)
	Library.Transparency = Value
	if Library.Window then
		Library.Window.AcrylicPaint.Frame.Background.BackgroundTransparency = Value
	end
	for _, DropdownFrame in next, Creator.DropdownTransparencyFrames do
		DropdownFrame.BackgroundTransparency = Value
	end
end

function Library:ToggleTransparency(Value)
	Library:SetTransparency(Value)
end

function Library:ToggleUserInfo(Value)
	if Library.Window and Library.Window.UserInfoFrame then
		Library.Window.UserInfoFrame.Visible = Value
	end
end

function Library:ToggleKeepWindowInsideFrame(Value)
	Library.KeepWindowInsideFrame = Value
end

function Library:SetBoundaryMargin(Value)
	Library.BoundaryMargin = Value or 0
	if Library.Window and Library.Window.RefreshBoundary then
		Library.Window.RefreshBoundary()
	end
end

function Library:SetBoundaryInset(Inset)
	Inset = Inset or {}
	Library.BoundaryInset = {
		Top = Inset.Top or 0,
		Bottom = Inset.Bottom or 0,
		Left = Inset.Left or 0,
		Right = Inset.Right or 0,
	}
	if Library.Window and Library.Window.RefreshBoundary then
		Library.Window.RefreshBoundary()
	end
end

local backgroundImageCache = {}
local backgroundCacheFolder = "FluentReimaginedBackgroundCache"

local function hashBackgroundUrl(Url)
	local hash = 0
	for i = 1, #Url do
		hash = (hash * 31 + string.byte(Url, i)) % 1000000007
	end
	return tostring(hash)
end

function Library:ResolveBackgroundImage(Input)
	if not Input or Input == "" then
		return ""
	end

	if
		Input:match("^rbxassetid://")
		or Input:match("^rbxasset://")
		or Input:match("^https?://www%.roblox%.com/asset")
	then
		return Input
	end

	if tonumber(Input) then
		return "rbxassetid://" .. Input
	end

	if Input:match("^https?://") then
		if backgroundImageCache[Input] then
			return backgroundImageCache[Input]
		end

		local success, result = pcall(function()
			if not isfolder(backgroundCacheFolder) then
				makefolder(backgroundCacheFolder)
			end

			local fileName = backgroundCacheFolder .. "/" .. hashBackgroundUrl(Input) .. ".png"
			if not isfile(fileName) then
				writefile(fileName, game:HttpGet(Input))
			end

			return getcustomasset(fileName)
		end)

		if success and result then
			backgroundImageCache[Input] = result
			return result
		end

		warn("[Background] Failed to load image from URL: " .. Input)
		return ""
	end

	return Input
end

function Library:UpdateBackground()
	if not Library.Window or not Library.Window.BackgroundImage then
		return
	end

	local backgroundImage = Library.Window.BackgroundImage

	if Library.DisableBackground then
		backgroundImage.ImageTransparency = 1
		return
	end

	backgroundImage.Image = Library:ResolveBackgroundImage(Creator.GetThemeProperty("Background"))
	backgroundImage.ImageTransparency = Creator.GetThemeProperty("BackgroundTransparency")
end

function Library:ToggleBackground(Value)
	Library.DisableBackground = Value
	Library:UpdateBackground()
end

Creator.OnThemeChanged(function()
	Library:UpdateBackground()
end)

function Library:Notify(Config)
	return NotificationModule:New(Config)
end

local httpService = game:GetService("HttpService")

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

local SaveManager = {} do
	SaveManager.Folder = "FluentReimaginedSettings"
	SaveManager.Ignore = {}
	SaveManager.Parser = {
		Toggle = {
			Save = function(idx, object)
				return { type = "Toggle", idx = idx, value = object.Value }
			end,
			Load = function(idx, data)
				if SaveManager.Options[idx] then
					SaveManager.Options[idx]:SetValue(data.value)
				end
			end,
		},
		Slider = {
			Save = function(idx, object)
				return { type = "Slider", idx = idx, value = tostring(object.Value) }
			end,
			Load = function(idx, data)
				if SaveManager.Options[idx] then
					SaveManager.Options[idx]:SetValue(data.value)
				end
			end,
		},
		Dropdown = {
			Save = function(idx, object)
				return { type = "Dropdown", idx = idx, value = object.Value, mutli = object.Multi }
			end,
			Load = function(idx, data)
				if SaveManager.Options[idx] then
					SaveManager.Options[idx]:SetValue(data.value)
				end
			end,
		},
		Colorpicker = {
			Save = function(idx, object)
				return { type = "Colorpicker", idx = idx, value = object.Value:ToHex(), transparency = object.Transparency }
			end,
			Load = function(idx, data)
				if SaveManager.Options[idx] then
					SaveManager.Options[idx]:SetValueRGB(Color3.fromHex(data.value), data.transparency)
				end
			end,
		},
		Keybind = {
			Save = function(idx, object)
				return { type = "Keybind", idx = idx, mode = object.Mode, key = object.Value }
			end,
			Load = function(idx, data)
				if SaveManager.Options[idx] then
					SaveManager.Options[idx]:SetValue(data.key, data.mode)
				end
			end,
		},
		Input = {
			Save = function(idx, object)
				return { type = "Input", idx = idx, text = object.Value }
			end,
			Load = function(idx, data)
				if SaveManager.Options[idx] and type(data.text) == "string" then
					SaveManager.Options[idx]:SetValue(data.text)
				end
			end,
		},
	}

	function SaveManager:SetIgnoreIndexes(list)
		for _, key in next, list do
			self.Ignore[key] = true
		end
	end

	function SaveManager:SetFolder(folder)
		self.Folder = folder
		self:BuildFolderTree()
	end

	function SaveManager:Save(name)
		if not name then
			return false, "no config file is selected"
		end

		local fullPath = self.Folder .. "/settings/" .. name .. ".json"

		local data = { objects = {} }

		for idx, option in next, SaveManager.Options do
			if not self.Parser[option.Type] then continue end
			if self.Ignore[idx] then continue end

			table.insert(data.objects, self.Parser[option.Type].Save(idx, option))
		end

		local success, encoded = pcall(httpService.JSONEncode, httpService, data)
		if not success then
			return false, "failed to encode data"
		end

		writefile(fullPath, encoded)
		return true
	end

	function SaveManager:Load(name)
		if not name then
			return false, "no config file is selected"
		end

		local file = self.Folder .. "/settings/" .. name .. ".json"
		if not isfile(file) then return false, "invalid file" end

		local success, decoded = pcall(httpService.JSONDecode, httpService, readfile(file))
		if not success then return false, "decode error" end

		for _, option in next, decoded.objects do
			if self.Parser[option.type] then
				task.spawn(function() self.Parser[option.type].Load(option.idx, option) end)
			end
		end

		return true
	end

	function SaveManager:Delete(name)
		if not name then
			return false, "no config file is selected"
		end

		local file = self.Folder .. "/settings/" .. name .. ".json"
		if not isfile(file) then
			return false, "invalid file"
		end

		delfile(file)
		return true
	end

	function SaveManager:IgnoreThemeSettings()
		self:SetIgnoreIndexes({
			"InterfaceTheme",
			"AcrylicToggle",
			"TransparencySlider",
			"MenuKeybind",
			"ShowUserInfoToggle",
			"DisableBackgroundToggle",
			"PanelThemeName",
			"PanelAccent",
			"PanelAcrylicMain",
			"PanelAcrylicBorder",
			"PanelAcrylicGradient",
			"PanelAcrylicNoise",
			"PanelBackground",
			"PanelBackgroundTransparency",
			"PanelTitleBarLine",
			"PanelTab",
			"PanelElement",
			"PanelElementBorder",
			"PanelInElementBorder",
			"PanelElementTransparency",
			"PanelToggleSlider",
			"PanelToggleToggled",
			"PanelSliderRail",
			"PanelDropdownFrame",
			"PanelDropdownHolder",
			"PanelDropdownBorder",
			"PanelDropdownOption",
			"PanelKeybind",
			"PanelInput",
			"PanelInputFocused",
			"PanelInputIndicator",
			"PanelDialog",
			"PanelDialogHolder",
			"PanelDialogHolderLine",
			"PanelDialogButton",
			"PanelDialogButtonBorder",
			"PanelDialogBorder",
			"PanelDialogInput",
			"PanelDialogInputLine",
			"PanelColorpickerDialog",
			"PanelColorpickerDialogBorder",
			"PanelColorpickerHolder",
			"PanelColorpickerHolderLine",
			"PanelColorpickerButton",
			"PanelColorpickerButtonBorder",
			"PanelColorpickerInput",
			"PanelColorpickerInputLine",
			"PanelColorpickerInputBorder",
			"PanelColorpickerInputFocused",
			"PanelText",
			"PanelSubText",
			"PanelHover",
			"PanelHoverChange",
			"PanelCustomThemeTarget",
		})
	end

	function SaveManager:BuildFolderTree()
		local paths = { self.Folder, self.Folder .. "/settings" }

		for i = 1, #paths do
			local str = paths[i]
			if not isfolder(str) then
				makefolder(str)
			end
		end
	end

	function SaveManager:RefreshConfigList()
		local list = listfiles(self.Folder .. "/settings")

		local out = {}
		for i = 1, #list do
			local file = list[i]
			if file:sub(-5) == ".json" then
				local pos = file:find(".json", 1, true)
				local start = pos

				local char = file:sub(pos, pos)
				while char ~= "/" and char ~= "\\" and char ~= "" do
					pos = pos - 1
					char = file:sub(pos, pos)
				end

				if char == "/" or char == "\\" then
					local name = file:sub(pos + 1, start - 1)
					if name ~= "options" then
						table.insert(out, name)
					end
				end
			end
		end

		return out
	end

	function SaveManager:SetLibrary(library)
		self.Library = library
		self.Options = library.Options
	end

	function SaveManager:LoadAutoloadConfig()
		if isfile(self.Folder .. "/settings/autoload.txt") then
			local name = readfile(self.Folder .. "/settings/autoload.txt")

			local success, err = self:Load(name)
			if not success then
				return self.Library:Notify({
					Title = "Interface",
					Content = "Config loader",
					SubContent = "Failed to load autoload config: " .. err,
					Duration = 7,
				})
			end

			self.Library:Notify({
				Title = "Interface",
				Content = "Config loader",
				SubContent = string.format("Auto loaded config %q", name),
				Duration = 7,
			})
		end
	end

	function SaveManager:BuildConfigSection(tab)
		assert(self.Library, "Must set SaveManager.Library")

		local section = tab:AddSection("Configuration")

		section:AddInput("SaveManager_ConfigName", { Title = "Config name", Icon = "text-cursor-input" })
		section:AddDropdown("SaveManager_ConfigList", { Title = "Config list", Values = self:RefreshConfigList(), AllowNull = true, Icon = "folder-open" })

		section:AddButton({
			Title = "Create config",
			Icon = "save",
			Callback = function()
				local name = SaveManager.Options.SaveManager_ConfigName.Value

				if name:gsub(" ", "") == "" then
					return self.Library:Notify({
						Title = "Interface",
						Content = "Config loader",
						SubContent = "Invalid config name (empty)",
						Duration = 7,
					})
				end

				local success, err = self:Save(name)
				if not success then
					return self.Library:Notify({
						Title = "Interface",
						Content = "Config loader",
						SubContent = "Failed to save config: " .. err,
						Duration = 7,
					})
				end

				self.Library:Notify({
					Title = "Interface",
					Content = "Config loader",
					SubContent = string.format("Created config %q", name),
					Duration = 7,
				})

				SaveManager.Options.SaveManager_ConfigList:SetValues(self:RefreshConfigList())
				SaveManager.Options.SaveManager_ConfigList:SetValue(nil)
			end,
		})

		section:AddButton({
			Title = "Load config",
			Icon = "download",
			Callback = function()
				local name = SaveManager.Options.SaveManager_ConfigList.Value

				local success, err = self:Load(name)
				if not success then
					return self.Library:Notify({
						Title = "Interface",
						Content = "Config loader",
						SubContent = "Failed to load config: " .. err,
						Duration = 7,
					})
				end

				self.Library:Notify({
					Title = "Interface",
					Content = "Config loader",
					SubContent = string.format("Loaded config %q", name),
					Duration = 7,
				})
			end,
		})

		section:AddButton({
			Title = "Overwrite config",
			Icon = "save-all",
			Callback = function()
				local name = SaveManager.Options.SaveManager_ConfigList.Value
				if not name then
					return self.Library:Notify({
						Title = "Interface",
						Content = "Config loader",
						SubContent = "No config selected",
						Duration = 7,
					})
				end

				self.Library.Window:Dialog({
					Title = "Overwrite Config?",
					Content = "This replaces the saved config " .. string.format("%q", name) .. " with your current settings. This can't be undone.",
					Buttons = {
						{ Title = "Cancel", Callback = function() end },
						{ Title = "Overwrite", Callback = function()
							local success, err = self:Save(name)
							if not success then
								return self.Library:Notify({
									Title = "Interface",
									Content = "Config loader",
									SubContent = "Failed to overwrite config: " .. err,
									Duration = 7,
								})
							end

							self.Library:Notify({
								Title = "Interface",
								Content = "Config loader",
								SubContent = string.format("Overwrote config %q", name),
								Duration = 7,
							})
						end },
					},
				})
			end,
		})

		section:AddButton({
			Title = "Delete config",
			Icon = "trash-2",
			Callback = function()
				local name = SaveManager.Options.SaveManager_ConfigList.Value
				if not name then
					return self.Library:Notify({
						Title = "Interface",
						Content = "Config loader",
						SubContent = "No config selected",
						Duration = 7,
					})
				end

				self.Library.Window:Dialog({
					Title = "Delete Config?",
					Content = "This permanently deletes the config " .. string.format("%q", name) .. ". This can't be undone.",
					Buttons = {
						{ Title = "Cancel", Callback = function() end },
						{ Title = "Delete", Callback = function()
							local success, err = self:Delete(name)
							if not success then
								return self.Library:Notify({
									Title = "Interface",
									Content = "Config loader",
									SubContent = "Failed to delete config: " .. err,
									Duration = 7,
								})
							end

							self.Library:Notify({
								Title = "Interface",
								Content = "Config loader",
								SubContent = string.format("Deleted config %q", name),
								Duration = 7,
							})

							SaveManager.Options.SaveManager_ConfigList:SetValues(self:RefreshConfigList())
							SaveManager.Options.SaveManager_ConfigList:SetValue(nil)
						end },
					},
				})
			end,
		})

		section:AddButton({
			Title = "Refresh list",
			Icon = "refresh-cw",
			Callback = function()
				SaveManager.Options.SaveManager_ConfigList:SetValues(self:RefreshConfigList())
				SaveManager.Options.SaveManager_ConfigList:SetValue(nil)
			end,
		})

		local autoloadButton
		autoloadButton = section:AddButton({
			Title = "Set as autoload",
			Description = "Current autoload config: none",
			Icon = "pin",
			Callback = function()
				local name = SaveManager.Options.SaveManager_ConfigList.Value
				writefile(self.Folder .. "/settings/autoload.txt", name)
				autoloadButton:SetDesc("Current autoload config: " .. name)
				self.Library:Notify({
					Title = "Interface",
					Content = "Config loader",
					SubContent = string.format("Set %q to auto load", name),
					Duration = 7,
				})
			end,
		})

		if isfile(self.Folder .. "/settings/autoload.txt") then
			local name = readfile(self.Folder .. "/settings/autoload.txt")
			autoloadButton:SetDesc("Current autoload config: " .. name)
		end

		SaveManager:SetIgnoreIndexes({ "SaveManager_ConfigList", "SaveManager_ConfigName" })
	end

	SaveManager:BuildFolderTree()
end

if getgenv then
	getgenv().FluentReimagined = Library
end

local Extension = {}

Extension.Creator = Creator
Extension.Flipper = Flipper
Extension.Components = Components
Extension.Library = Library
Extension.New = Creator.New

Extension._CustomThemeTags = {}
Extension._MiddlewareCallbacks = {}
Extension._ExtensionRegistry = {}
Extension._WindowHooks = {}
Extension._TabHooks = {}

function Extension:RegisterElement(ElementDef)
	assert(type(ElementDef) == "table", "RegisterElement: expected table")
	assert(type(ElementDef.__type) == "string", "RegisterElement: missing __type")
	assert(type(ElementDef.New) == "function", "RegisterElement: missing New function")

	local TypeName = ElementDef.__type

	local AddMethod = function(Self, Idx, Config)
		local Def = setmetatable({}, { __index = ElementDef })
		Def.Container = Self.Container
		Def.Type = Self.Type
		Def.ScrollFrame = Self.ScrollFrame
		Def.Library = Library
		Def.Extension = Extension

		local ResolvedConfig = Config
		if ResolvedConfig == nil and type(Idx) == "table" then
			ResolvedConfig = Idx
		end

		if type(ResolvedConfig) == "table" and not ResolvedConfig.LayoutOrder then
			Self._layoutOrder = (Self._layoutOrder or 0) + 1
			ResolvedConfig.LayoutOrder = Self._layoutOrder
		end

		for _, Middleware in next, Extension._MiddlewareCallbacks do
			if Middleware.Type == TypeName or Middleware.Type == "*" then
				ResolvedConfig = Middleware.Fn(ResolvedConfig, Def) or ResolvedConfig
			end
		end

		local Result = Def:New(Idx, ResolvedConfig)

		if Result and type(Result) == "table" then
			Result._extensionType = TypeName
		end

		return Result
	end

	Elements["Add" .. TypeName] = AddMethod
	Elements[TypeName] = AddMethod

	Extension._ExtensionRegistry[TypeName] = ElementDef
end

local OriginalGetThemeProperty = Creator.GetThemeProperty
Creator.GetThemeProperty = function(Property)
	if Extension._CustomThemeTags[Property] ~= nil then
		local CustomData = Library.CustomThemeData
		if CustomData and CustomData[Property] ~= nil then
			return CustomData[Property]
		end
		return Extension._CustomThemeTags[Property]
	end
	return OriginalGetThemeProperty(Property)
end

function Extension:DefineThemeTag(TagName, DefaultValue)
	assert(type(TagName) == "string", "DefineThemeTag: TagName must be string")
	assert(DefaultValue ~= nil, "DefineThemeTag: DefaultValue required")
	Extension._CustomThemeTags[TagName] = DefaultValue
end

function Extension:SetCustomThemeValue(TagName, Value)
	assert(Extension._CustomThemeTags[TagName] ~= nil, "SetCustomThemeValue: '" .. TagName .. "' not defined — call DefineThemeTag first")
	Extension._CustomThemeTags[TagName] = Value
	task.defer(Creator.UpdateTheme)
end

function Extension:GetThemeValue(TagName)
	return Creator.GetThemeProperty(TagName)
end

function Extension:ApplyThemeTag(Object, Tag)
	return Creator.AddThemeObject(Object, Tag)
end

function Extension:OverrideThemeTag(Object, Tag)
	Creator.OverrideTag(Object, Tag)
end

function Extension:RegisterElementMiddleware(ElementType, Fn)
	assert(type(ElementType) == "string", "RegisterElementMiddleware: ElementType must be string")
	assert(type(Fn) == "function", "RegisterElementMiddleware: Fn must be function")
	table.insert(Extension._MiddlewareCallbacks, { Type = ElementType, Fn = Fn })
end

function Extension:RegisterSaveParser(TypeName, Parser)
	assert(type(TypeName) == "string", "RegisterSaveParser: TypeName must be string")
	assert(type(Parser.Save) == "function", "RegisterSaveParser: missing Save")
	assert(type(Parser.Load) == "function", "RegisterSaveParser: missing Load")
	SaveManager.Parser[TypeName] = Parser
end

function Extension:RegisterOption(Idx, Object)
	assert(type(Idx) == "string", "RegisterOption: Idx must be string")
	assert(type(Object) == "table", "RegisterOption: Object must be table")
	assert(type(Object.Type) == "string", "RegisterOption: Object must have .Type")
	Library.Options[Idx] = Object
end

function Extension:IsThemeChanged(Callback)
	return Creator.OnThemeChanged(Callback)
end

function Extension:IsFontChanged(Callback)
	table.insert(Creator.FontChangedCallbacks, Callback)
end

function Extension:RegisterFontObject(Object, Weight, Style)
	Creator.RegisterFontObject(Object, Weight, Style)
end

function Extension:Dialog(Config)
	assert(Library.Window, "Dialog: Window not created yet")
	Library.Window:Dialog(Config)
end

function Extension:SidePanel(Config)
	assert(Library.Window, "SidePanel: Window not created yet")
	return Library.Window:SidePanel(Config)
end

function Extension:IsWindowCreated(Callback)
	if Library.Window then
		Callback(Library.Window)
	else
		table.insert(Extension._WindowHooks, Callback)
	end
end

function Extension:IsTabSelected(Callback)
	table.insert(Extension._TabHooks, Callback)
end

function Extension:SpringMotor(Initial, Object, Property)
	return Creator.SpringMotor(Initial, Object, Property)
end

function Extension:SingleMotor(Initial)
	return Flipper.SingleMotor.new(Initial)
end

function Extension:GroupMotor(Initial)
	return Flipper.GroupMotor.new(Initial)
end

function Extension:Spring(Goal, Config)
	return Flipper.Spring.new(Goal, Config)
end

function Extension:Immediate(Goal)
	return Flipper.Immediate.new(Goal)
end

function Extension:GetRegisteredElements()
	local List = {}
	for TypeName in next, Extension._ExtensionRegistry do
		table.insert(List, TypeName)
	end
	return List
end

local OriginalCreateWindow = Library.CreateWindow
function Library:CreateWindow(Config)
	local Window = OriginalCreateWindow(self, Config)
	for _, Hook in next, Extension._WindowHooks do
		pcall(Hook, Window)
	end
	Extension._WindowHooks = {}

	local OriginalSelectTab = Window.SelectTab
	function Window:SelectTab(Tab)
		local Result = OriginalSelectTab(self, Tab)
		for _, Hook in next, Extension._TabHooks do
			pcall(Hook, Tab, Window)
		end
		return Result
	end

	return Window
end

Library.Extension = Extension

if getgenv then
	getgenv().FluentReimaginedExtension = Extension
end

return Library, SaveManager, InterfaceManager
