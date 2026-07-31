local styles = require "app.styles"
local View = require("app.gui.view")

local function TextView(text_state_or_text, style)
  local self = { }
  -- style is cloned to prevent weird side effects --
  style = table.clone(style) or { }

  -- local text_state = style or { text = "" }
  local text_state = { text = "" }

  if type(text_state_or_text) == "string" or type(text_state_or_text) == "number" then
    text_state.text = text_state_or_text
  elseif text_state_or_text ~= nil then
    text_state = text_state_or_text
    text_state.text = text_state.text or ""
  end

  -- text_state.color = style.color or text_state.color or hexToColor(0xFFFFFF)
  -- text_state.font = style.font or text_state.font or cache.font({"assets/fonts/joystix.ttf", 120})
  -- text_state.size = style.size or text_state.size or 30.0
  -- text_state.align = style.align or text_state.align or "center"
  -- text_state.justify = style.justify or text_state.justify or "center"

  self.draw = function(self, w, h)
      local font_scale = (text_state.size or style.size or 30.0) / 60.0
      local font = text_state.font or style.font or cache.font({"assets/fonts/joystix.ttf"})
        
      local maxWidth, wrappedtext = font:getWrap( text_state.text, w / font_scale )
      local textWidth = maxWidth
      local textHeight = font:getHeight(text_state.text) * #wrappedtext

      local align = text_state.align or style.align or "center" -- top, center, bottom
      local justify = text_state.justify or style.justify or "center" -- left, center, right
      local text_color = text_state.color or style.color or styles.colors.text

      love.graphics.push("all")

      if DEBUG then
        love.graphics.setColor(0, 1, 0, 0.5)
        love.graphics.rectangle("fill", 0, 0, w, h)
      end

      -- using a large font and scaling it down to get better visual quality
      love.graphics.scale(font_scale, font_scale)
      love.graphics.setColor(text_color)
      love.graphics.setFont(font)

      if align == "center" then
        love.graphics.translate(0, -textHeight * 0.5 + h / font_scale * 0.5)
      elseif align == "bottom" then
        love.graphics.translate(0, h / font_scale - textHeight)
      end
      
      love.graphics.printf(text_state.text, 0, 0, w / font_scale, justify)

      love.graphics.pop()
    end

    return View(text_state, { self })
end

return TextView