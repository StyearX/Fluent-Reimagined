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

