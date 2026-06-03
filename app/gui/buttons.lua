local Clickable = require 'app.gui.clickable'
local TextView = require 'app.gui.text_view'

local function PrimaryButton(title, onclick)
  return Clickable(onclick, {
    View({ 
      padding = 20, 
      backgroundColor = hexToColor(0xFF0000) 
    }, { 
      TextView(title, { align = "center", size = 12, color = hexToColor(0xFFFFFF) }), }),
  })
end

local function SecondaryButton(title, onclick)
  return Clickable(onclick, {
    View({ 
      padding = 20, 
      backgroundColor = hexToColor(0x0000FF),
      TextView(title, { align = "center", size = 12, color = hexToColor(0xFFFFFF) }), 
    })
  })
end

local function BackButton()
	local go_back = function() navigator:pop()  end

	return Clickable(go_back, { 
		TextView("<", { size = 18, color = hexToColor(0xFFFFFF) })
	})
end

local function CloseButton()
	local reset = function() navigator:reset()  end

	return Clickable(reset, { 
		TextView("x", { size = 15, color = hexToColor(0xFFFFFF) })
	})
end

local function PlusButton(onclick)
	return Clickable(onclick, { 
		TextView("+", { size = 15, color = hexToColor(0xFFFFFF) })
	})
end

return {
  Plus = PlusButton,
  Close = CloseButton,
  Back = BackButton,
  Primary = PrimaryButton,
  Secondary = SecondaryButton
}