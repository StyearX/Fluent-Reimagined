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

