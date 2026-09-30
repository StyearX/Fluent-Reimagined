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

