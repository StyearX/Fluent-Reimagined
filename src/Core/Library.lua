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

