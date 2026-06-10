local ImageView = require 'app.gui.image_view'
local TextView = require 'app.gui.text_view'
local ScrollView = require 'app.gui.scroll_view'
local View = require 'app.gui.view'
local StackView = require 'app.gui.stack_view'
local ShelfView = require 'app.gui.shelf_view'
local Button = require 'app.gui.button'
local GameView = require 'app.game_view'
local generateMaze = require 'app.game_logic.maze_generator'

local function MainMenu() 
  local game_state = {
    maze = generateMaze(24, 24),
    pause = true
  }

  local view = View {
    StackView {
      heights = { "150px", nil, "88px", "44px" },
      gap = 11,
      
      TextView("MAZE RAT!", { 
        color = hexToColor(0xFFFFFF),
        size = 32, align = "top" }),
        
      GameView(game_state),

      View {
        padding = { 0, 11 },
        ShelfView {
          gap = 11,
          widths = { "40%", nil },
          Button("PLAY", function()
            game_state.pause = false
          end),
          Button("RANDOM", function()
            game_state.maze = generateMaze(24, 24)
          end)          
        },
      },

      TextView("© 4thelols 2026 ", { 
        size = 12.0, 
        align = "middle", 
        color = hexToColor(0xFFFFFF) 
      }),
    }
  }

  return {
    activate = function(self)
      -- when pushed/popped to
    end,

    suspend = function(self)
      -- when navigating away
    end,

    update = function(self, dt)
      -- only called if subscribing to updateables on draw
    end,

    draw = function(self, w, h)
      love.graphics.setShader(shader)
      view:draw(w, h)
      love.graphics.setShader()

      -- table.insert(updateables, self)
    end
  }
end

return MainMenu