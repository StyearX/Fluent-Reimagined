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

