ElementsTable.Paragraph = (function()
	local Paragraph = {}
	Paragraph.__index = Paragraph
	Paragraph.__type = "Paragraph"

	function Paragraph:New(Config)
		assert(Config.Title, "Paragraph - Missing Title")
		Config.Content = Config.Content or ""

		local ParagraphFrame = Components.Element(Config.Title, Config.Content, Paragraph.Container, false, Config.LayoutOrder, Config.Icon, Config.Marquee == true)
		ParagraphFrame.Frame.BackgroundTransparency = 0.92
		ParagraphFrame.Border.Transparency = 0.6

		local Para = ParagraphFrame
		Para.SetTitle = ParagraphFrame.SetTitle
		Para.SetDesc = ParagraphFrame.SetDesc
		Para.SetContent = ParagraphFrame.SetDesc

		return Para
	end

	return Paragraph
end)()

