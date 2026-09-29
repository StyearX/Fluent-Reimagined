--[[
Loadstring returns 3 values in this order: Library, SaveManager, InterfaceManager
The variable names are free, this script uses FluentReimagined for the Library
SaveManager and InterfaceManager addons do not work if their return values are not captured here
]]
local FluentReimagined, SaveManager, InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/StyearX/Fluent-Reimagined/refs/heads/main/dist/Main.lua"))()

--[[
Members that are always called through the Library variable (FluentReimagined here)
FluentReimagined:CreateWindow
FluentReimagined:Notify
FluentReimagined:SetTheme
FluentReimagined:GetIcon
FluentReimagined:Destroy
FluentReimagined.Options
FluentReimagined.Version
FluentReimagined.Theme
Theme options: Dark, Darker, Light, Aqua, Amethyst, Rose, Crimson Noir, Gold
]]
local Window = FluentReimagined:CreateWindow({
	Title = "Title btw  " .. FluentReimagined.Version,
	SubTitle = "Subtitle (UI by StyearX)",
	TabWidth = 130,
	Size = UDim2.fromOffset(580, 580),
	Acrylic = true,
	Theme = "Dark",
	MinimizeKey = Enum.KeyCode.LeftControl,
	Search = true,
   NewVisual = true,
	UserInfo = {
		Position = "Bottom",
		Icon = "rbxthumb://type=AvatarHeadShot&id=1&w=420&h=420",
		Title = "Custom Title",
		Subtitle = "Custom Subtitle",
	},
})

--[[
Structure format
Window:AddSection (alias Section) groups tabs, Icon is optional and shown before the title, Collapsible adds :Open :Close :Toggle
Window:AddTab and Section:AddTab share the same aliases (Tab, AddPage, Page)
AddTabInHeader (alias TabInHeader) on Window shows the tab in the title bar
AddTabInHeader on a Section warns and moves the tab to the title bar
]]
local Sections = {
	General = Window:AddSection({ Title = "General", Icon = "layers" }),
	Api = Window:AddSection({ Title = "Window API", Icon = "terminal", Collapsible = true }),
	Icons = Window:AddSection({ Title = "Icons", Icon = "palette", Collapsible = true }),
}

--[[
Usage:
Provider/IconName
Provider/Variant/IconName
Provider/Variant/Size/IconName (material only)
If no provider is set, lucide is used as the fallback

Providers:
lucide
solar
gravity
hero
feather
sfsymbols
geist
tabler
phosphor
bootstrap
craft
prime
pixelart
fluent
mynaui
weui
material
]]

local Tabs = {
	Layout = Sections.General:AddTab({ Title = "Layout", Icon = "layout-grid" }),
	Core = Sections.General:AddTab({ Title = "Core", Icon = "component" }),
	Method = Sections.General:AddTab({ Title = "Method", Icon = "book-open" }),
	Api = Sections.Api:AddTab({ Title = "Window API", Icon = "terminal" }),
	NoIconTab = Sections.Api:AddTab({ Title = "No Icon Tab" }),
	Icons = Sections.Icons:AddTab({ Title = "Icons", Icon = "palette" }),
	Settings = Window:AddTabInHeader({ Title = "Settings", Icon = "settings" }),
	NoIconHeader = Window:AddTabInHeader({ Title = "No Icon Header" }),
}

Window:SelectTab(1)

local Options = FluentReimagined.Options

do
	Tabs.Layout:AddParagraph({
		Title = "VStack & HStack",
		Content = "Every element and its variants arranged with AddHStack and AddVStack."
	})

	local RootHStack = Tabs.Layout:AddHStack({ Gap = 10 })

	local LeftVStack = RootHStack:AddVStack({ Gap = 6 })

	LeftVStack:AddButton({
		Title = "Button",
		Callback = function()
			print("Stack button pressed")
		end
	})

	LeftVStack:AddToggle("StackToggle", { Title = "Toggle", Default = false })

	LeftVStack:AddSlider("StackSlider", {
		Title = "Slider",
		Min = 0,
		Max = 100,
		Default = 50,
		Rounding = 0,
	})

	LeftVStack:AddDropdown("StackDropdown", {
		Title = "Dropdown",
		Values = { "1", "2", "3" },
		Default = 1,
	})

	LeftVStack:AddDropdown("StackDropdownSearch", {
		Title = "Dropdown With Search",
		Search = true,
		Values = { "1", "2", "3", "4", "5" },
		Default = 1,
	})

	LeftVStack:AddDropdown("StackDropdownMulti", {
		Title = "Dropdown With Multi",
		Multi = true,
		Values = { "1", "2", "3" },
		Default = { "1" },
	})

	LeftVStack:AddDropdown("StackDropdownSearchMulti", {
		Title = "Dropdown With Search And Multi",
		Search = true,
		Multi = true,
		Values = { "1", "2", "3", "4", "5" },
		Default = { "1", "3" },
	})

	local RightVStack = RootHStack:AddVStack({ Gap = 6 })

	RightVStack:AddColorpicker("StackColorpicker", {
		Title = "Color Picker",
		Default = Color3.fromRGB(96, 205, 255),
	})

	RightVStack:AddColorpicker("StackColorpickerTransparency", {
		Title = "Color Picker With Transparency",
		Transparency = 0,
		Default = Color3.fromRGB(96, 205, 255),
	})

	RightVStack:AddGradientPicker("StackGradientPicker", {
		Title = "Gradient Picker",
		Default = ColorSequence.new(Color3.fromRGB(255, 0, 128), Color3.fromRGB(0, 128, 255)),
		Rotation = 90,
	})

	RightVStack:AddKeybind("StackKeybindHold", {
		Title = "Keybind Hold",
		Mode = "Hold",
		Default = "Q",
	})

	RightVStack:AddKeybind("StackKeybindToggle", {
		Title = "Keybind Toggle",
		Mode = "Toggle",
		Default = "F",
	})

	RightVStack:AddInput("StackInput", {
		Title = "Input",
		Placeholder = "Type here",
	})

	RightVStack:AddImage({
		Image = "rbxassetid://105249527747322",
		AspectRatio = "16:9",
		Radius = 8,
	})

	Tabs.Layout:AddParagraph({
		Title = "Group",
		Content = "Every element and its variants arranged with AddGroup."
	})

	local LayoutGroup = Tabs.Layout:AddGroup({ Columns = 2, Gap = 10 })

	local GroupLeft = LayoutGroup:AddElement()

	GroupLeft:AddButton({
		Title = "Button",
		Callback = function()
			print("Group button pressed")
		end
	})

	GroupLeft:AddToggle("GroupToggle", { Title = "Toggle", Default = false })

	GroupLeft:AddSlider("GroupSlider", {
		Title = "Slider",
		Min = 0,
		Max = 100,
		Default = 50,
		Rounding = 0,
	})

	GroupLeft:AddDropdown("GroupDropdown", {
		Title = "Dropdown",
		Values = { "A", "B", "C" },
		Default = 1,
	})

	GroupLeft:AddDropdown("GroupDropdownSearch", {
		Title = "Dropdown With Search",
		Search = true,
		Values = { "A", "B", "C", "D", "E" },
		Default = 1,
	})

	GroupLeft:AddDropdown("GroupDropdownMulti", {
		Title = "Dropdown With Multi",
		Multi = true,
		Values = { "A", "B", "C" },
		Default = { "B" },
	})

	GroupLeft:AddDropdown("GroupDropdownSearchMulti", {
		Title = "Dropdown With Search And Multi",
		Search = true,
		Multi = true,
		Values = { "A", "B", "C", "D", "E" },
		Default = { "A", "D" },
	})

	local GroupRight = LayoutGroup:AddElement()

	GroupRight:AddColorpicker("GroupColorpicker", {
		Title = "Color Picker",
		Default = Color3.fromRGB(255, 140, 90),
	})

	GroupRight:AddColorpicker("GroupColorpickerTransparency", {
		Title = "Color Picker With Transparency",
		Transparency = 0,
		Default = Color3.fromRGB(255, 140, 90),
	})

	GroupRight:AddGradientPicker("GroupGradientPicker", {
		Title = "Gradient Picker",
		Default = ColorSequence.new(Color3.fromRGB(255, 170, 0), Color3.fromRGB(140, 0, 255)),
		Rotation = 45,
	})

	GroupRight:AddKeybind("GroupKeybindHold", {
		Title = "Keybind Hold",
		Mode = "Hold",
		Default = "E",
	})

	GroupRight:AddKeybind("GroupKeybindToggle", {
		Title = "Keybind Toggle",
		Mode = "Toggle",
		Default = "R",
	})

	GroupRight:AddInput("GroupInput", {
		Title = "Input",
		Placeholder = "Search...",
	})

	GroupRight:AddImage({
		Image = "rbxassetid://116875029841325",
		AspectRatio = "1:1",
		Radius = 8,
	})
end

do
	--[[
	Element format
	Every element has two names, without Add and with Add (Button and AddButton are the same call)
	Elements with extra aliases
	Toggle = Switch, AddSwitch
	Space = EmptyFrame, AddEmptyFrame
	Elements that store a value take an Index as first argument and are read with Options.Index.Value
	Toggle, Slider, Dropdown, Colorpicker, GradientPicker, Keybind, Input
	Marquee (Boolean) on elements with Title and Description scrolls text that is too long, default true (Paragraph default false)
	Elements without a value only take the config table
	Button, Paragraph, Image, Space
	]]
	Tabs.Core:AddParagraph({
		Title = "Button",
		Content = "Runs a callback when clicked."
	})

	Tabs.Core:AddButton({
		Title = "Button", -- required
		Description = "Very important button", -- optional
		Callback = function()
			print("Core button pressed")
		end
	})

	Tabs.Core:AddButton({
		Title = "Button With A Very Long Title That Does Not Fit In The Element",
		Description = "Marquee is true by default, set Marquee = false to disable the scrolling text",
		Marquee = false, -- Boolean, default true
		Callback = function()
			print("Marquee disabled button pressed")
		end
	})

	Tabs.Core:AddParagraph({
		Title = "Toggle",
		Content = "A binary switch between on and off."
	})

	local CoreToggle = Tabs.Core:AddToggle("CoreToggle", { Title = "Toggle", Default = false })

	CoreToggle:OnChanged(function()
		print("Toggle changed:", Options.CoreToggle.Value)
	end)

	Tabs.Core:AddParagraph({
		Title = "Slider",
		Content = "Drags between a minimum and maximum numeric value."
	})

	local CoreSlider = Tabs.Core:AddSlider("CoreSlider", {
		Title = "Slider", -- required
		Min = 0, -- required
		Max = 100, -- required
		Default = 50,
		Rounding = 0, -- required
		Callback = function(Value)
			print("Slider changed:", Value)
		end
	})

	Tabs.Core:AddParagraph({
		Title = "Dropdown",
		Content = "Selects one value from a list."
	})

	local CoreDropdown = Tabs.Core:AddDropdown("CoreDropdown", {
		Title = "Dropdown", -- required
		Values = { "1", "2", "3" }, -- required
		Default = 1, -- index of the value
	})

	Tabs.Core:AddParagraph({
		Title = "Dropdown With Search",
		Content = "Filters the value list through a search box."
	})

	local CoreDropdownSearch = Tabs.Core:AddDropdown("CoreDropdownSearch", {
		Title = "Dropdown With Search",
		Search = true, -- adds a search box
		Values = { "1", "2", "3", "4", "5", "6", "7" },
		Default = 1,
	})

	Tabs.Core:AddParagraph({
		Title = "Dropdown With Multi",
		Content = "Selects more than one value at once."
	})

	local CoreDropdownMulti = Tabs.Core:AddDropdown("CoreDropdownMulti", {
		Title = "Dropdown With Multi",
		Multi = true, -- allows more than one value
		Values = { "1", "2", "3", "4" },
		Default = { "1", "3" }, -- table when Multi is true
	})

	Tabs.Core:AddParagraph({
		Title = "Dropdown With Search And Multi",
		Content = "Combines the search box with multi-select."
	})

	local CoreDropdownSearchMulti = Tabs.Core:AddDropdown("CoreDropdownSearchMulti", {
		Title = "Dropdown With Search And Multi",
		Search = true,
		Multi = true,
		Values = { "1", "2", "3", "4", "5", "6", "7" },
		Default = { "2", "5" },
	})

	Tabs.Core:AddParagraph({
		Title = "Color Picker",
		Content = "Opens a dialog to pick an RGB color."
	})

	local CoreColorpicker = Tabs.Core:AddColorpicker("CoreColorpicker", {
		Title = "Color Picker", -- required
		Default = Color3.fromRGB(96, 205, 255), -- required
	})

	Tabs.Core:AddParagraph({
		Title = "Color Picker With Transparency",
		Content = "Same dialog, with an added transparency slider."
	})

	local CoreColorpickerTransparency = Tabs.Core:AddColorpicker("CoreColorpickerTransparency", {
		Title = "Color Picker With Transparency",
		Transparency = 0, -- adds the transparency slider
		Default = Color3.fromRGB(96, 205, 255),
	})

	Tabs.Core:AddParagraph({
		Title = "Gradient Picker",
		Content = "Picks a start and end color, plus rotation, to build a ColorSequence."
	})

	local CoreGradientPicker = Tabs.Core:AddGradientPicker("CoreGradientPicker", {
		Title = "Gradient Picker", -- required
		Default = ColorSequence.new(Color3.fromRGB(255, 0, 128), Color3.fromRGB(0, 128, 255)), -- required
		Rotation = 90,
	})

	Tabs.Core:AddParagraph({
		Title = "Keybind Hold",
		Content = "Value is true only while the bound key is held down."
	})

	local CoreKeybindHold = Tabs.Core:AddKeybind("CoreKeybindHold", {
		Title = "Keybind Hold", -- required
		Mode = "Hold", -- Hold or Toggle
		Default = "Q", -- required
	})

	Tabs.Core:AddParagraph({
		Title = "Keybind Toggle",
		Content = "Value flips between true and false on every press."
	})

	local CoreKeybindToggle = Tabs.Core:AddKeybind("CoreKeybindToggle", {
		Title = "Keybind Toggle",
		Mode = "Toggle",
		Default = "F",
	})

	Tabs.Core:AddParagraph({
		Title = "Input",
		Content = "A single line text box."
	})

	local CoreInput = Tabs.Core:AddInput("CoreInput", {
		Title = "Input", -- required
		Default = "Default",
		Placeholder = "Placeholder",
		Numeric = false, -- numbers only
		Finished = false, -- callback only fires when Enter is pressed
	})

	Tabs.Core:AddParagraph({
		Title = "Image",
		Content = "Shows a single image with automatic aspect ratio scaling."
	})

	local CoreImage = Tabs.Core:AddImage({
		Image = "rbxassetid://105249527747322", -- required
		AspectRatio = "16:9",
		Radius = 10,
	})

	Tabs.Core:AddParagraph({
		Title = "Space",
		Content = "An invisible spacer with a fixed height."
	})

	Tabs.Core:AddSpace({ Height = 24 }) -- Height required

	Tabs.Core:AddButton({ Title = "Button Below The Space" })
end

do
	Tabs.Method:AddParagraph({
		Title = "About This Tab",
		Content = "Reference for every element method available in this Fluent Reimagined UI. Every :Add<Element> method also works without the Add prefix (for example :AddButton and :Button are the same call), and some elements have extra alternate names on top of that (Tab also has :Page, Space also has :EmptyFrame). Elements that store a value (Toggle, Slider, Dropdown, Color Picker, Gradient Picker, Keybind, Input) need a unique Flag as their first argument so SaveManager can save and load them, and so InterfaceManager and SaveManager can manage them through FluentReimagined.Options."
	})

	Tabs.Method:AddParagraph({
		Title = "Button",
		Content = "A clickable element that runs a callback and does not store a value.\nMethod:\n:AddButton\n:Button\n-----\nSpecial Property:\nNone\n-----\nGlobal Property:\n:Callback -- Function\n:Icon -- String\n:Title (Required) -- String\n:Description -- String\n:Marquee -- Boolean (default true)\n-----"
	})

	Tabs.Method:AddParagraph({
		Title = "Toggle",
		Content = "A binary switch between on and off, stored as a boolean.\nMethod:\n:AddToggle\n:Toggle\n:AddSwitch\n:Switch\n-----\nSpecial Property:\n:Default -- Boolean\n-----\nGlobal Property:\n:Callback -- Function\n:Icon -- String\n:Title (Required) -- String\n:Description -- String\n:Marquee -- Boolean (default true)\n-----"
	})

	Tabs.Method:AddParagraph({
		Title = "Slider",
		Content = "Drags a numeric value between a minimum and maximum.\nMethod:\n:AddSlider\n:Slider\n-----\nSpecial Property:\n:Min (Required) -- Number\n:Max (Required) -- Number\n:Rounding (Required) -- Number\n:Default -- Number\n:Suffix -- String\n-----\nGlobal Property:\n:Callback -- Function\n:Icon -- String\n:Title (Required) -- String\n:Description -- String\n:Marquee -- Boolean (default true)\n-----"
	})

	Tabs.Method:AddParagraph({
		Title = "Dropdown",
		Content = "Selects one or more values from a list, with optional search filtering.\nMethod:\n:AddDropdown\n:Dropdown\n-----\nSpecial Property:\n:Values (Required) -- Table\n:Default -- Number, or Table when Multi is true\n:Multi -- Boolean\n:Search -- Boolean\n:AllowNull -- Boolean\n-----\nGlobal Property:\n:Callback -- Function\n:Icon -- String\n:Title (Required) -- String\n:Description -- String\n:Marquee -- Boolean (default true)\n-----"
	})

	Tabs.Method:AddParagraph({
		Title = "Color Picker",
		Content = "Opens a dialog to pick a Color3, optionally with a transparency slider.\nMethod:\n:AddColorpicker\n:Colorpicker\n-----\nSpecial Property:\n:Default (Required) -- Color3\n:Transparency -- Number\n-----\nGlobal Property:\n:Callback -- Function\n:Icon -- String\n:Title (Required) -- String\n:Description -- String\n:Marquee -- Boolean (default true)\n-----"
	})

	Tabs.Method:AddParagraph({
		Title = "Gradient Picker",
		Content = "Picks a start and end color, plus rotation, and returns a ColorSequence.\nMethod:\n:AddGradientPicker\n:GradientPicker\n-----\nSpecial Property:\n:Default (Required) -- ColorSequence\n:Rotation -- Number\n-----\nGlobal Property:\n:Callback -- Function\n:Icon -- String\n:Title (Required) -- String\n:Description -- String\n:Marquee -- Boolean (default true)\n-----"
	})

	Tabs.Method:AddParagraph({
		Title = "Keybind",
		Content = "Binds an action to a key or mouse button, in Hold or Toggle mode.\nMethod:\n:AddKeybind\n:Keybind\n-----\nSpecial Property:\n:Default (Required) -- String\n:Mode -- String (\"Hold\" or \"Toggle\")\n:ChangedCallback -- Function\n-----\nGlobal Property:\n:Callback -- Function\n:Icon -- String\n:Title (Required) -- String\n:Description -- String\n:Marquee -- Boolean (default true)\n-----"
	})

	Tabs.Method:AddParagraph({
		Title = "Input",
		Content = "A single line text box.\nMethod:\n:AddInput\n:Input\n-----\nSpecial Property:\n:Default -- String\n:Placeholder -- String\n:Numeric -- Boolean\n:Finished -- Boolean\n:MaxLength -- Number\n-----\nGlobal Property:\n:Callback -- Function\n:Icon -- String\n:Title (Required) -- String\n:Description -- String\n:Marquee -- Boolean (default true)\n-----"
	})

	Tabs.Method:AddParagraph({
		Title = "Image",
		Content = "Shows a single image with automatic aspect ratio scaling. Does not store a value.\nMethod:\n:AddImage\n:Image\n-----\nSpecial Property:\n:Image (Required) -- String\n:AspectRatio -- String (default \"16:9\")\n:Radius -- Number\n-----\nGlobal Property:\nNone\n-----"
	})

	Tabs.Method:AddParagraph({
		Title = "Paragraph",
		Content = "A static block of text used for headers and explanations. Does not store a value.\nMethod:\n:AddParagraph\n:Paragraph\n-----\nSpecial Property:\n:Content -- String\n-----\nGlobal Property:\n:Icon -- String\n:Title (Required) -- String\n:Marquee -- Boolean (default false)\n-----"
	})

	Tabs.Method:AddParagraph({
		Title = "Space",
		Content = "An invisible spacer used to add gaps between elements. Does not store a value.\nMethod:\n:AddSpace\n:Space\n:AddEmptyFrame\n:EmptyFrame\n-----\nSpecial Property:\n:Height (Required) -- String or Number\n-----\nGlobal Property:\nNone\n-----"
	})

	Tabs.Method:AddParagraph({
		Title = "Group",
		Content = "Arranges elements side by side in equal columns, each column built with :AddElement.\nMethod:\n:AddGroup\n:Group\n-----\nSpecial Property:\n:Columns -- Number\n:Gap -- Number\n-----\nGlobal Property:\n:Title -- String\n:Description -- String\n-----"
	})

	Tabs.Method:AddParagraph({
		Title = "HStack",
		Content = "Lays views out side by side. Add elements directly for one view per column, or call :AddVStack for a column that stacks multiple elements.\nMethod:\n:AddHStack\n:HStack\n-----\nSpecial Property:\n:Gap -- Number\n-----\nGlobal Property:\n:Title -- String\n:Description -- String\n-----"
	})

	Tabs.Method:AddParagraph({
		Title = "VStack",
		Content = "Stacks elements vertically in a single column, and can also live directly inside an HStack.\nMethod:\n:AddVStack\n:VStack\n-----\nSpecial Property:\n:Gap -- Number\n-----\nGlobal Property:\n:Title -- String\n:Description -- String\n-----"
	})

	Tabs.Method:AddParagraph({
		Title = "Section",
		Content = "Groups tabs together under a shared header, optionally collapsible.\nMethod:\n:AddSection\n:Section\n-----\nSpecial Property:\n:Title (Required) -- String\n:Icon -- String\n:Collapsible -- Boolean\n-----\nGlobal Property:\nNone\n-----"
	})

	Tabs.Method:AddParagraph({
		Title = "Tab",
		Content = "A page of elements, added either on the Window or inside a Section.\nMethod:\n:AddTab\n:Tab\n:AddPage\n:Page\n-----\nSpecial Property:\nNone\n-----\nGlobal Property:\n:Icon -- String\n:Title (Required) -- String\n-----"
	})

	Tabs.Method:AddParagraph({
		Title = "Tab In Header",
		Content = "A tab rendered in the title bar navigator instead of the side list. Calling this on a Section moves the tab to the header instead and warns in the console.\nMethod:\n:AddTabInHeader\n:TabInHeader\n-----\nSpecial Property:\nNone\n-----\nGlobal Property:\n:Icon -- String\n:Title (Required) -- String\n-----"
	})

	Tabs.Method:AddParagraph({
		Title = "Notify",
		Content = "Shows a notification in the bottom right corner of the screen.\nMethod:\nFluentReimagined:Notify\n-----\nSpecial Property:\n:Content (Required) -- String\n:SubContent -- String\n:Duration -- Number\n-----\nGlobal Property:\n:Icon -- String\n:Title (Required) -- String\n-----"
	})

	Tabs.Method:AddParagraph({
		Title = "Dialog",
		Content = "Shows a blocking dialog box with custom buttons.\nMethod:\nWindow:Dialog\n-----\nSpecial Property:\n:Content (Required) -- String\n:Buttons -- Table\n-----\nGlobal Property:\n:Title (Required) -- String\n-----"
	})

	Tabs.Method:AddParagraph({
		Title = "Side Panel",
		Content = "A dialog-style panel docked beside the window. Supports Button, Toggle, Slider, Dropdown, Colorpicker, GradientPicker and Input.\nMethod:\nWindow:SidePanel\nWindow:Menu\nWindow:SideMenu\n-----\nSpecial Property:\n:Side -- String (\"Left\" or \"Right\")\n:Width -- Number\n:Buttons -- Table\n-----\nGlobal Property:\n:Title -- String\n:Description -- String\n-----"
	})
end

do
	Tabs.Api:AddParagraph({
		Title = "Notify",
		Content = "FluentReimagined:Notify accepts Title, Content, SubContent, Icon and Duration. Duration is optional; without it the notification stays until closed."
	})

	Tabs.Api:AddButton({
		Title = "Notify (Full Properties)",
		Description = "Title, Content, SubContent, Icon and Duration all set",
		Callback = function()
			FluentReimagined:Notify({
				Title = "Notification",
				Content = "This is a notification",
				SubContent = "SubContent",
				Icon = "bell",
				Duration = 6,
			})
		end
	})

	Tabs.Api:AddButton({
		Title = "Notify (Minimal)",
		Description = "Only Title and Content set",
		Callback = function()
			FluentReimagined:Notify({
				Title = "Notification",
				Content = "This is a minimal notification",
			})
		end
	})

	Tabs.Api:AddParagraph({
		Title = "Dialog",
		Content = "Window:Dialog blocks the window with a message and any number of Buttons."
	})

	Tabs.Api:AddButton({
		Title = "Open Dialog",
		Description = "Confirm / Cancel dialog",
		Callback = function()
			Window:Dialog({
				Title = "Title",
				Content = "This is a dialog",
				Buttons = {
					{
						Title = "Confirm",
						Callback = function()
							print("Confirmed the dialog.")
						end
					},
					{
						Title = "Cancel",
						Callback = function()
							print("Cancelled the dialog.")
						end
					}
				}
			})
		end
	})

	Tabs.Api:AddParagraph({
		Title = "Side Panel",
		Content = "Window:SidePanel opens a docked panel with footer Buttons. Only Button, Toggle, Slider, Dropdown, Colorpicker, GradientPicker and Input are supported inside it."
	})

	Tabs.Api:AddButton({
		Title = "Open Side Panel",
		Description = "Right-docked panel with every element the Side Panel supports",
		Callback = function()
			local Panel
			Panel = Window:SidePanel({
				Title = "Side Panel",
				Description = "Click outside to close.",
				Side = "Right",
				Width = 300,
				Buttons = {
					{
						Title = "Cancel",
						CloseOnClick = true,
						Callback = function()
							print("Cancelled")
						end,
					},
					{
						Title = "Confirm",
						CloseOnClick = true,
						Callback = function()
							print("Confirmed")
						end,
					},
				},
			})

			Panel:AddButton({
				Title = "Button",
				Callback = function()
					print("Panel button pressed")
				end,
			})

			Panel:AddToggle("PanelToggle", {
				Title = "Toggle",
				Default = false,
			})

			Panel:AddSlider("PanelSlider", {
				Title = "Slider",
				Min = 0,
				Max = 100,
				Default = 50,
				Rounding = 0,
			})

			Panel:AddDropdown("PanelDropdown", {
				Title = "Dropdown",
				Values = { "1", "2", "3" },
				Default = 1,
			})

			Panel:AddColorpicker("PanelColorpicker", {
				Title = "Colorpicker",
				Default = Color3.fromRGB(96, 205, 255),
			})

			Panel:AddGradientPicker("PanelGradientPicker", {
				Title = "Gradient Picker",
				Default = ColorSequence.new(Color3.fromRGB(255, 0, 128), Color3.fromRGB(0, 128, 255)),
			})

			Panel:AddInput("PanelInput", {
				Title = "Input",
				Placeholder = "Type here",
			})
		end,
	})

	Tabs.Api:AddParagraph({
		Title = "Section",
		Content = "Window:AddSection groups tabs under a header. With Collapsible set, :Open, :Close and :Toggle control whether the section is expanded."
	})

	Tabs.Api:AddButton({
		Title = "Close Window API Section",
		Description = "Calls :Close() on this tab's own Section",
		Callback = function()
			Sections.Api:Close()
		end
	})

	Tabs.Api:AddButton({
		Title = "Open Window API Section",
		Description = "Calls :Open() on this tab's own Section",
		Callback = function()
			Sections.Api:Open()
		end
	})

	Tabs.Api:AddButton({
		Title = "Toggle Window API Section",
		Description = "Calls :Toggle() on this tab's own Section",
		Callback = function()
			Sections.Api:Toggle()
		end
	})

	Tabs.Api:AddParagraph({
		Title = "SelectTab",
		Content = "Window:SelectTab jumps to a tab by its index in creation order."
	})

	Tabs.Api:AddButton({
		Title = "Jump To Layout Tab",
		Description = "Calls Window:SelectTab(1)",
		Callback = function()
			Window:SelectTab(1)
		end
	})

	Tabs.Api:AddParagraph({
		Title = "Global SetTitle / SetDesc",
		Content = "SetTitle and SetDesc work anywhere something has a title: Window, Tab, Section and elements."
	})

	Tabs.Api:AddButton({
		Title = "Rename Everything",
		Description = "Calls :SetTitle / :SetSubTitle on the Window, this Tab, and the General Section",
		Callback = function()
			Window:SetTitle("Renamed Window")
			Window:SetSubTitle("Renamed via :SetSubTitle")
			Tabs.Api:SetTitle("Renamed Tab")
			Sections.General:SetTitle("Renamed Section")
		end
	})
end

do
	Tabs.NoIconTab:AddParagraph({
		Title = "Section Tabs",
		Content = "This tab was added with Sections.Api:AddTab instead of Window:AddTab, and has no Icon field set."
	})

	Tabs.NoIconTab:AddButton({
		Title = "Try Add TabInHeader Into Section",
		Description = "Calls ApiSection:AddTabInHeader, which warns and moves the tab to the header instead",
		Callback = function()
			Sections.Api:AddTabInHeader({ Title = "Moved To Header" })
		end
	})

	Tabs.NoIconHeader:AddParagraph({
		Title = "No Icon Header",
		Content = "This TabInHeader (Window:AddTabInHeader) has no Icon field set."
	})
end

do
	local packs = {
		-- Lucide: flat string, standard naming
		{ name = "lucide",    icons = { "home", "search", "settings", "bell", "heart", "star", "user", "folder", "file", "trash-2", "edit", "download", "upload", "share", "lock", "unlock", "eye", "eye-off", "check", "x" } },
		-- Solar: flat string, semua icon punya suffix style (-bold, -linear, -outline, dll)
		{ name = "solar",     icons = { "home-bold", "magnifer-bold", "settings-bold", "bell-bold", "heart-bold", "star-bold", "user-bold", "folder-bold", "file-bold", "trash-bin-trash-bold", "pen-new-round-bold", "download-bold", "upload-bold", "share-bold", "lock-bold", "lock-unlocked-bold", "eye-bold", "eye-closed-bold", "check-circle-bold", "close-circle-bold" } },
		-- Tabler: spritesheet, standard naming
		{ name = "tabler",    icons = { "home", "search", "settings", "bell", "heart", "star", "user", "folder", "file", "trash", "edit", "download", "upload", "share", "lock", "lock-open", "eye", "eye-off", "check", "x" } },
		-- Phosphor: spritesheet, naming unik
		{ name = "phosphor",  icons = { "house", "magnifying-glass", "gear", "bell", "heart", "star", "user", "folder", "file", "trash", "pencil", "download-simple", "upload-simple", "share", "lock", "lock-open", "eye", "eye-slash", "check", "x" } },
		-- Bootstrap: spritesheet, naming unik
		{ name = "bootstrap", icons = { "house", "search", "gear", "bell", "heart", "star", "person", "folder", "file-earmark", "trash", "pencil", "download", "upload", "share", "lock", "unlock", "eye", "eye-slash", "check-circle", "x-circle" } },
		-- Hero: flat string, naming unik
		{ name = "hero",      icons = { "home", "magnifying-glass", "cog-6-tooth", "bell", "heart", "star", "user", "folder", "document", "trash", "pencil", "arrow-down-tray", "arrow-up-tray", "share", "lock-closed", "lock-open", "eye", "eye-slash", "check-circle", "x-circle" } },
		-- Feather: flat string, standard naming
		{ name = "feather",   icons = { "home", "search", "settings", "bell", "heart", "star", "user", "folder", "file", "trash-2", "edit", "download", "upload", "share", "lock", "unlock", "eye", "eye-off", "check-circle", "x-circle" } },
		-- Material: sprite-sheet, style variants (default/outlined/round/sharp/twotone), sizes (18/24/36/48)
		{ name = "material",  icons = { "home", "search", "settings", "notifications", "favorite", "star", "person", "folder", "description", "delete", "edit", "download", "upload", "share", "lock", "lock open", "visibility", "visibility off", "check circle", "cancel" } },
		-- Geist: spritesheet, naming spesifik Vercel/Geist
		{ name = "geist",     icons = { "bell-off", "book-open", "check-circle", "check-square", "eye-off", "file-text", "folder-open", "folder-plus", "heart-fill", "lock-closed", "lock-open", "preview-eye", "settings-gear", "settings-slider", "star-fill", "user-check", "user-cross", "user-plus", "arrow-up", "arrow-down" } },
		-- Craft: spritesheet, semua icon pakai suffix -stroke
		{ name = "craft",     icons = { "home-01-stroke", "search-stroke", "cog-settings-01-stroke", "notification-stroke", "heart-react-stroke", "star-rate-stroke", "profile-01-stroke", "folder-stroke", "file-stroke", "delete-bin-01-stroke", "edit-pen-01-stroke", "download-01-stroke", "upload-01-stroke", "share-01-stroke", "lock-01-stroke", "lock-password-stroke", "eye-view-stroke", "eye-close-stroke", "check-stroke", "cancel-forbidden-stroke" } },
		-- Gravity: flat string, naming campuran
		{ name = "gravity",   icons = { "house", "magnifier", "sliders", "bell", "heart", "star", "person", "folder", "file", "trash-bin", "pencil", "arrow-down-to-line", "arrow-up-from-line", "lock", "lock-open", "eye", "eye-slash", "check", "xmark", "circle-check" } },
		-- SFSymbols: flat string, naming Apple SF Symbols
		{ name = "sfsymbols", icons = { "house", "magnifyingglass", "gear", "bell", "heart", "star", "person", "folder", "doc", "trash", "pencil", "arrow.down", "arrow.up", "square.and.arrow.up", "lock", "lock.open", "eye", "eye.slash", "checkmark.circle", "xmark.circle" } },
		-- Prime: spritesheet
		{ name = "prime",     icons = { "home", "search", "cog", "bell", "heart", "star", "user", "folder", "file", "trash", "pencil", "download", "upload", "share", "lock", "lock-open", "eye", "eye-slash", "check-circle", "times-circle" } },
		-- PixelArt: spritesheet, naming unik
		{ name = "pixelart",  icons = { "home", "search", "settings-2", "bell", "heart", "star", "user", "folder", "file", "trash", "eye", "download", "upload", "share", "lock", "unlock", "eye-off", "check", "x", "check-double" } },
	}

	local variantPacks = {
		-- Fluent: spritesheet variant, naming unik
		{ name = "fluent",  variants = { "filled", "outlined" }, icons = { "home-add", "book-search", "content-settings", "alert-on", "heart-pulse", "book-star", "person-add", "folder-open", "document-edit", "delete-off", "circle-edit", "arrow-download", "arrow-upload", "channel-share", "lock-closed", "lock-open", "eye-show", "eye-hide", "checkmark-circle", "dismiss-circle" } },
		-- MynaUI: spritesheet variant, bare word + kebab keys
		{ name = "mynaui", variants = { "solid", "regular" },   icons = { "home", "search", "cog", "bell", "heart", "star", "user", "folder", "file", "trash", "edit", "download", "upload", "share", "lock", "lock-open", "eye", "eye-off", "check-circle", "x-circle" } },
		-- WeUI: spritesheet variant, bare word keys
		{ name = "weui",   variants = { "filled", "outlined" }, icons = { "home", "search", "setting", "like", "star", "folder", "download", "upload", "share", "lock", "close", "done", "delete", "back", "camera", "add", "info", "error", "comment", "more" } },
		-- Material: multi-part sprite-sheet, 5 style variants × 4 sizes
		{ name = "material", variants = { "default", "outlined", "round", "sharp", "twotone" }, icons = { "home", "search", "settings", "notifications", "favorite", "star", "person", "folder", "description", "delete", "edit", "download", "upload", "share", "lock", "lock open", "visibility", "visibility off", "check circle", "cancel" } },
	}

	Tabs.Icons:AddParagraph({
		Title = "Icon Packs",
		Content = "All available icon packs. Use Icon = \"packname/iconname\" in any element.\nFor variant packs: \"packname/variant/iconname\" or \"packname/iconname\" to use the default variant.\nFor material: \"material/iconname\", \"material/variant/iconname\", or \"material/variant/size/iconname\" (variants: default, outlined, round, sharp, twotone — sizes: 18, 24, 36, 48)."
	})

	for _, pack in ipairs(packs) do
		Tabs.Icons:AddParagraph({
			Title = pack.name,
			Content = "Icon = \"" .. pack.name .. "/iconname\""
		})

		for _, icon in ipairs(pack.icons) do
			Tabs.Icons:AddButton({
				Title = icon,
				Icon = pack.name .. "/" .. icon,
			})
		end
	end

	Tabs.Icons:AddParagraph({
		Title = "Variant Packs",
		Content = "Packs with multiple style variants."
	})

	for _, pack in ipairs(variantPacks) do
		for _, variant in ipairs(pack.variants) do
			Tabs.Icons:AddParagraph({
				Title = pack.name .. " / " .. variant,
				Content = "Icon = \"" .. pack.name .. "/" .. variant .. "/iconname\""
			})

			for _, icon in ipairs(pack.icons) do
				Tabs.Icons:AddButton({
					Title = icon,
					Icon = pack.name .. "/" .. variant .. "/" .. icon,
				})
			end
		end
	end
end


--[[
Addon setup order
SetLibrary must be called first on both, it gives them the Library and its Options
Then set the folders, then build the sections on a Tab
LoadAutoloadConfig goes last so every element already exists when the saved values are applied
]]
SaveManager:SetLibrary(FluentReimagined)
InterfaceManager:SetLibrary(FluentReimagined)

SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})

InterfaceManager:SetFolder("FluentReimaginedScriptHub")
SaveManager:SetFolder("FluentReimaginedScriptHub/specific-game")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

Window:SelectTab(1)

FluentReimagined:Notify({ -- Notify is called from the Library variable, not from Window
	Title = "Fluent Reimagined",
	Content = "The script has been loaded.",
	Duration = 8
})

SaveManager:LoadAutoloadConfig()
