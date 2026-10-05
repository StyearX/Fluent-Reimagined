local AssetService: AssetService = cloneref(game:GetService("AssetService"))
local RunService: RunService = cloneref(game:GetService("RunService"))

local backgroundAnimation
local backgroundLabels = {}
local backgroundToken = 0
local backgroundEditable
local backgroundKey
local backgroundReady = false
local backgroundDecoded = setmetatable({}, { __mode = "k" })

local Base64Alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
local Base64Lookup = table.create(128, 0)

for Index = 1, #Base64Alphabet do
	Base64Lookup[string.byte(Base64Alphabet, Index)] = Index - 1
end

local function DecodeBase64(Text)
	local Bytes = buffer.create(math.floor(#Text / 4) * 3)
	local Size = 0

	for Index = 1, #Text - 3, 4 do
		local A, B, C, D = string.byte(Text, Index, Index + 3)
		local Value = Base64Lookup[A] * 262144 + Base64Lookup[B] * 4096 + Base64Lookup[C] * 64 + Base64Lookup[D]
		buffer.writeu8(Bytes, Size, math.floor(Value / 65536))
		buffer.writeu8(Bytes, Size + 1, math.floor(Value / 256) % 256)
		buffer.writeu8(Bytes, Size + 2, Value % 256)
		Size = Size + 3
	end

	return Bytes, Size
end

local function DecodePaletteFrame(Text, Pixels, Palette, Previous)
	local Bytes, Size = DecodeBase64(Text)
	if Size == 0 then
		return nil
	end

	local Flag = buffer.readu8(Bytes, 0)
	local Output = buffer.create(Pixels * 4)

	if Flag == 1 then
		for Pixel = 0, Pixels - 1 do
			if Pixel + 1 >= Size then break end
			buffer.writeu32(Output, Pixel * 4, Palette[buffer.readu8(Bytes, Pixel + 1)])
		end
	elseif Flag == 2 and Previous then
		buffer.copy(Output, 0, Previous)
		local Pixel = 0
		local Read = 1

		while Pixel < Pixels and Read < Size do
			local Operation = buffer.readu8(Bytes, Read)
			Read = Read + 1

			if Operation < 128 then
				Pixel = Pixel + Operation + 1
			else
				for _ = 1, Operation - 127 do
					if Pixel < Pixels and Read < Size then
						buffer.writeu32(Output, Pixel * 4, Palette[buffer.readu8(Bytes, Read)])
					end
					Read = Read + 1
					Pixel = Pixel + 1
				end
			end
		end
	else
		return nil
	end

	return Output
end

local function DecodeFrame(Text, Pixels)
	local Bytes, Size = DecodeBase64(Text)

	if Size == 0 or buffer.readu8(Bytes, 0) ~= 1 then
		return nil
	end

	local Output = buffer.create(Pixels * 4)
	local Read = 1
	local Pixel = 0

	while Pixel < Pixels and Read + 2 < Size do
		local X = buffer.readu8(Bytes, Read)
		local Y = buffer.readu8(Bytes, Read + 1)
		local Z = buffer.readu8(Bytes, Read + 2)
		Read = Read + 3

		local Offset = Pixel * 4
		buffer.writeu8(Output, Offset, math.floor(X / 16) * 17)
		buffer.writeu8(Output, Offset + 1, (X % 16) * 17)
		buffer.writeu8(Output, Offset + 2, math.floor(Y / 16) * 17)
		buffer.writeu8(Output, Offset + 3, 255)
		Pixel = Pixel + 1

		if Pixel < Pixels then
			Offset = Pixel * 4
			buffer.writeu8(Output, Offset, (Y % 16) * 17)
			buffer.writeu8(Output, Offset + 1, math.floor(Z / 16) * 17)
			buffer.writeu8(Output, Offset + 2, (Z % 16) * 17)
			buffer.writeu8(Output, Offset + 3, 255)
			Pixel = Pixel + 1
		end
	end

	return Output
end

local function StopBackgroundAnimation()
	backgroundToken = backgroundToken + 1
	if backgroundAnimation then
		backgroundAnimation:Disconnect()
		backgroundAnimation = nil
	end
	if backgroundEditable then
		pcall(function()
			backgroundEditable:Destroy()
		end)
		backgroundEditable = nil
	end
	for _, Label in ipairs(backgroundLabels) do
		Label:Destroy()
	end
	backgroundLabels = {}
	backgroundKey = nil
	backgroundReady = false
end

function Library:UpdateBackground()
	if not Library.Window or not Library.Window.BackgroundImage then
		return
	end

	local backgroundImage = Library.Window.BackgroundImage
	local Background = Creator.GetThemeProperty("Background")
	local Transparency = Creator.GetThemeProperty("BackgroundTransparency")

	if Library.DisableBackground then
		StopBackgroundAnimation()
		backgroundImage.ImageTransparency = 1
		return
	end

	if backgroundKey ~= nil and backgroundKey == Background then
		if type(Background) == "table" then
			if backgroundReady then
				for _, Label in ipairs(backgroundLabels) do
					Label.ImageTransparency = Transparency
				end
			end
		else
			backgroundImage.ImageTransparency = Transparency
		end
		return
	end

	StopBackgroundAnimation()
	backgroundKey = Background

	if type(Background) ~= "table" then
		backgroundImage.ImageTransparency = Transparency
		backgroundImage.ImageRectOffset = Vector2.zero
		backgroundImage.ImageRectSize = Vector2.zero
		backgroundImage.Image = Library:ResolveMedia(Background)
		return
	end

	local Token = backgroundToken
	backgroundImage.Image = ""
	backgroundImage.ImageTransparency = 1

	local function Play(Decoded)
		local Created, Editable = pcall(function()
			return AssetService:CreateEditableImage({ Size = Vector2.new(Decoded.Width, Decoded.Height) })
		end)
		if not Created or not Editable then
			warn("[Background] EditableImage is not available in this environment")
			return
		end

		if Token ~= backgroundToken then
			Editable:Destroy()
			return
		end

		backgroundEditable = Editable

		local Buffers = Decoded.Buffers
		local Size = Vector2.new(Decoded.Width, Decoded.Height)
		Editable:WritePixelsBuffer(Vector2.zero, Size, Buffers[1])

		local FrameLabel = New("ImageLabel", {
			Name = "BackgroundFrames",
			ImageTransparency = Creator.GetThemeProperty("BackgroundTransparency"),
			ScaleType = Enum.ScaleType.Crop,
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			Parent = backgroundImage,
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 8),
			}),
		})

		backgroundLabels[1] = FrameLabel
		FrameLabel.ImageContent = Content.fromObject(Editable)
		backgroundReady = true

		local Index = 1
		local Elapsed = 0
		local Step = 1 / Decoded.FPS

		backgroundAnimation = RunService.Heartbeat:Connect(function(Delta)
			Elapsed = Elapsed + Delta
			if Elapsed < Step then return end
			Elapsed = Elapsed % Step
			Index = Index % #Buffers + 1
			if Buffers[Index] then
				Editable:WritePixelsBuffer(Vector2.zero, Size, Buffers[Index])
			end
		end)
	end

	local Cached = backgroundDecoded[Background]
	if Cached then
		Play(Cached)
		return
	end

	local FrameSource = Background.Source

	if not FrameSource and not (type(Background.Frames) == "table" and type(Background.Frames[1]) == "string") then
		warn("[Background] Unknown background table, use Source or Frames")
		return
	end

	task.spawn(function()
		local Data = Background

		if FrameSource then
			local Loaded, Result = pcall(function()
				local Path = FrameSource
				if Path:match("^https?://") then
					Path = Library:CacheFile(Path, ".lua")
				end
				return loadstring(readfile(Path))()
			end)
			if not Loaded or type(Result) ~= "table" then
				warn("[Background] Frame file could not be loaded: " .. tostring(FrameSource))
				return
			end
			Data = Result
		end

		local Frames = Data.Frames
		local Width = Background.Width or Data.Width
		local Height = Background.Height or Data.Height
		local FPS = Background.FPS or Data.FPS or 15

		if type(Frames) ~= "table" or #Frames == 0 or not Width or not Height then
			warn("[Background] Frame data needs Frames, Width and Height")
			return
		end

		local Pixels = Width * Height
		local PaletteData = Background.Palette or Data.Palette
		local Palette

		if PaletteData then
			Palette = table.create(256, 0)
			for Index = 0, 255 do
				Palette[Index] = (PaletteData[Index * 3 + 1] or 0)
					+ (PaletteData[Index * 3 + 2] or 0) * 256
					+ (PaletteData[Index * 3 + 3] or 0) * 65536
					+ 255 * 16777216
			end
		end

		local Buffers = {}
		local SliceStart = os.clock()

		for Index = 1, #Frames do
			if Token ~= backgroundToken then return end

			if Palette then
				Buffers[Index] = DecodePaletteFrame(Frames[Index], Pixels, Palette, Buffers[Index - 1])
			else
				Buffers[Index] = DecodeFrame(Frames[Index], Pixels)
			end

			if FrameSource then
				Frames[Index] = false
			end

			if os.clock() - SliceStart > 0.003 then
				task.wait()
				SliceStart = os.clock()
			end
		end

		if Token ~= backgroundToken then return end

		local Decoded = { Buffers = Buffers, Width = Width, Height = Height, FPS = FPS }
		backgroundDecoded[Background] = Decoded
		Play(Decoded)
	end)
end

function Library:ToggleBackground(Value)
	Library.DisableBackground = Value
	Library:UpdateBackground()
end

Creator.OnThemeChanged(function()
	Library:UpdateBackground()
end)

