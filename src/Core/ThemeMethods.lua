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

local OriginalThemes = {}

for _, ThemeName in ipairs(Themes.Names) do
	OriginalThemes[ThemeName] = Themes[ThemeName]
end

Library.ThemeOverrides = {}
Library.PendingOverrides = {}

function Library:OverrideTheme(Name, Data)
	local Original = OriginalThemes[Name]
	if not Original then
		Library.PendingOverrides[Name] = Data
		return nil
	end

	local Theme = {}
	for Key, Value in next, Original do
		Theme[Key] = Value
	end
	for Key, Value in next, Data do
		Theme[Key] = Value
	end
	Theme.Name = Name

	Themes[Name] = Theme
	Library.ThemeOverrides[Name] = true

	if Library.Window and Library.Theme == Name and not Library.CustomThemeData then
		Creator.UpdateTheme()
	end
	if Library.OnThemeAdded then
		Library.OnThemeAdded(Name)
	end

	return Theme
end

function Library:ResetTheme(Name)
	local Original = OriginalThemes[Name]
	Library.PendingOverrides[Name] = nil
	if not Original then
		return nil
	end

	Themes[Name] = Original
	Library.ThemeOverrides[Name] = nil

	if Library.Window and Library.Theme == Name and not Library.CustomThemeData then
		Creator.UpdateTheme()
	end
	if Library.OnThemeAdded then
		Library.OnThemeAdded(Name)
	end

	return Original
end

function Library:AddTheme(Data)
	assert(type(Data) == "table" and type(Data.Name) == "string", "AddTheme - Missing Name")
	assert(Data.Name ~= "Names", "AddTheme - Invalid Name")

	local Theme = {}
	for Key, Value in next, Themes[Data.Base or "Dark"] or Themes.Dark do
		Theme[Key] = Value
	end
	for Key, Value in next, Data do
		Theme[Key] = Value
	end

	Themes[Data.Name] = Theme
	OriginalThemes[Data.Name] = Theme
	Library.ThemeOverrides[Data.Name] = nil

	if not table.find(Themes.Names, Data.Name) then
		table.insert(Themes.Names, Data.Name)
	end

	local Pending = Library.PendingOverrides[Data.Name]
	if Pending then
		Library.PendingOverrides[Data.Name] = nil
		Library:OverrideTheme(Data.Name, Pending)
		return Themes[Data.Name]
	end

	if Library.Window and Library.Theme == Data.Name and not Library.CustomThemeData then
		Creator.UpdateTheme()
	end

	if Library.OnThemeAdded then
		Library.OnThemeAdded(Data.Name)
	end

	return Theme
end

