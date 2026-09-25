local settings = (require 'app.settings')()

local function Music()
    local self = { }
    
    local music = nil
    local music_state = "stop"
    local fade_out_music = nil
    local fade_timer = 0
    local fade_time = 0

    self.set_music_volume = function(self, volume)
        if music ~= nil then
            print("[audio] setting volume", volume, music)
            music:setVolume(volume)
        end
    end

    self.play_music = function(self, track, loop)
        print("[audio] play music", track)
        if music ~= nil and music ~= track and track ~= nil then
            print("[audio] pausing -- track matches, no track, or music already playing")
            music:pause()
        end

        if track ~= nil then
            print("[audio] switching track to", track)
            music = track
        end

        if loop ~= nil then
            print("[audio] set looping", loop)
            music:setLooping(loop)
        end

        if music ~= nil then
            local v = settings:get_music_volume()
            print("[audio] setting volume", v)
            music:setVolume(v)
            
            print("[audio] playing music", music)
            love.audio.play(music)
        end
    end

    self.pause_music = function()
        if music ~= nil then
            print("[audio] pause", music)
            music:pause()
        end
    end

    self.stop_music = function(self, time)
        if time ~= nil and time > 0 then
            print("[audio] stop -- fade out", time)
            fade_out_music = music
            music = nil

            fade_timer = time
            fade_time = time
        else
            print("[audio] stop -- no fade out")
            music:pause()
        end
    end

    self.update = function(self, dt)
        if fade_out_music ~= nil then
            if fade_timer > 0 then
                fade_timer = fade_timer - dt
                local volume = settings:get_music_volume() * ( fade_timer / fade_time )
                fade_out_music:setVolume(volume)
            else
                print("[audio] stop -- fade out finish", fade_out_music)
                fade_out_music:pause()
                fade_out_music = nil
            end
        end

    end
    
    return self
end

return Music