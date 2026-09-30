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

