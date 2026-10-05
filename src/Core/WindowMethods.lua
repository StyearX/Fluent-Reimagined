function Library:SetFont(fontAsset)
	Library.Font = fontAsset
	Creator.UpdateFont()
end

function Library:Destroy()
	if Library.Window then
		Library.Unloaded = true
		if Library.UseAcrylic then
			Library.Window.AcrylicPaint.Model:Destroy()
		end
		Creator.Disconnect()
		Library.GUI:Destroy()
	end
end

function Library:ToggleAcrylic(Value)
	if Library.Window then
		if Library.UseAcrylic then
			Library.Acrylic = Value
			Library.Window.AcrylicPaint.Model.Transparency = Value and 0.98 or 1
			if Value then
				Acrylic.Enable()
			else
				Acrylic.Disable()
			end
		end
	end
end

function Library:SetTransparency(Value)
	if type(Value) == "boolean" then
		Value = Value and 0.35 or 0
	end
	Value = math.clamp(tonumber(Value) or 0, 0, 1)
	Library.Transparency = Value
	if Library.Window then
		Library.Window.AcrylicPaint.Frame.Background.BackgroundTransparency = Value
	end
end

function Library:ToggleTransparency(Value)
	Library:SetTransparency(Value)
end

function Library:ToggleUserInfo(Value)
	if Library.Window and Library.Window.UserInfoFrame then
		Library.Window.UserInfoFrame.Visible = Value
	end
end

function Library:ToggleKeepWindowInsideFrame(Value)
	Library.KeepWindowInsideFrame = Value
end

function Library:SetBoundaryMargin(Value)
	Library.BoundaryMargin = Value or 0
	if Library.Window and Library.Window.RefreshBoundary then
		Library.Window.RefreshBoundary()
	end
end

function Library:SetBoundaryInset(Inset)
	Inset = Inset or {}
	Library.BoundaryInset = {
		Top = Inset.Top or 0,
		Bottom = Inset.Bottom or 0,
		Left = Inset.Left or 0,
		Right = Inset.Right or 0,
	}
	if Library.Window and Library.Window.RefreshBoundary then
		Library.Window.RefreshBoundary()
	end
end

