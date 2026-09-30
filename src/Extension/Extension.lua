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

