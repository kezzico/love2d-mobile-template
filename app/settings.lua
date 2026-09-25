local SETTINGS_FILE = "settings.txt"

local cached_music_volume = nil
local cached_sfx_volume = nil
local cached_game_speed = nil

local function Settings()

    local function get_setting(key)
        love.filesystem.read(SETTINGS_FILE)
        local settings = love.filesystem.read(SETTINGS_FILE) or ""

        for line in settings:gmatch("[^\r\n]+") do
            if line:match("^"..key.."=") then
                return line:sub(#key + 2)
            end
        end
    end

    local function set_setting(key, value)
        -- print("set setting "..key.."="..value)
        love.filesystem.read(SETTINGS_FILE)
        local settings = love.filesystem.read(SETTINGS_FILE) or ""

        local new_settings = ""
        local found = false
        for line in settings:gmatch("[^\r\n]+") do
            if line:match("^"..key.."=") then
                new_settings = new_settings .. key .. "=" .. value .. "\n"
                found = true
            else
                new_settings = new_settings .. line .. "\n"
            end
        end

        if not found then
            new_settings = new_settings .. key .. "=" .. value .. "\n"
        end

        love.filesystem.write(SETTINGS_FILE, new_settings)
    end


    return {
        get_music_volume = function(self)
            local volume = cached_music_volume or get_setting("music_volume") or 0.5
            cached_music_volume = tonumber(volume)
            return cached_music_volume
        end,

        set_music_volume = function(self, volume)
            set_setting("music_volume", volume)
            cached_music_volume = volume
        end,

        get_sfx_volume = function(self)
            local volume = get_setting("sfx_volume") or 0.5
            cached_sfx_volume = tonumber(volume)
            return cached_sfx_volume
        end,

        set_sfx_volume = function(self, volume)
            set_setting("sfx_volume", volume)
            cached_sfx_volume = volume
        end,

        get_game_speed = function(self)
            local speed = get_setting("game_speed") or 1
            cached_game_speed = tonumber(speed)
            return cached_game_speed
        end,

        set_game_speed = function(self, speed)
            set_setting("game_speed", speed)
            cached_game_speed = speed
        end

    }

end

return Settings