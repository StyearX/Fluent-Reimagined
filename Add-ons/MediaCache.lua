local MediaCache = {
	DefaultFolder = "FluentReimaginedCache",
	Folder = nil,
}

function MediaCache:GetFolder()
	return self.Folder or self.DefaultFolder
end

function MediaCache:SetFolder(Folder)
	self.Folder = Folder
	self:EnsureFolder()
end

function MediaCache:EnsureFolder()
	local Path = ""
	for Part in self:GetFolder():gmatch("[^/]+") do
		Path = Path == "" and Part or (Path .. "/" .. Part)
		if not isfolder(Path) then
			makefolder(Path)
		end
	end
end

function MediaCache:Download(Url, Extension)
	local Success, Result = pcall(function()
		self:EnsureFolder()

		local Hash = 0
		for Index = 1, #Url do
			Hash = (Hash * 31 + string.byte(Url, Index)) % 1000000007
		end

		local Path = self:GetFolder() .. "/" .. tostring(Hash) .. Extension
		if isfile(Path) and #readfile(Path) == 0 then
			delfile(Path)
		end
		if not isfile(Path) then
			writefile(Path, game:HttpGet(Url))
		end

		return Path
	end)

	if Success then
		return Result
	end

	warn("[MediaCache] Failed to download: " .. Url)
	return nil
end

Library.MediaCache = MediaCache

local backgroundImageCache = {}

function Library:CacheFile(Url, Extension)
	return MediaCache:Download(Url, Extension)
end

function Library:ResolveMedia(Input)
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

	if isfile and getcustomasset then
		local Ok, Exists = pcall(isfile, Input)
		if Ok and Exists then
			local Loaded, Asset = pcall(getcustomasset, Input)
			if Loaded and Asset then
				return Asset
			end
			return "rbxasset://" .. Input
		end
	end

	if Input:match("^https?://") then
		if backgroundImageCache[Input] then
			return backgroundImageCache[Input]
		end

		local success, result = pcall(function()
			return getcustomasset(Library:CacheFile(Input, ".png"))
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


