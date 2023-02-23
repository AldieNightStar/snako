-- Joysticks
function love.gamepadpressed(joystick, button)
    -- Curently no sense which joystick
    -- We use buttons from all of them (FIXME)
    -- button could be: dpleft, dpright, dpup, dpdown, a, b
    local k = joymap[button]
    if k ~= nil then control:emit(k) end
end

-- keyboard
function love.keypressed(key, scancode, isrepeat)
    -- We map 'space' and 'return' key as 'a' and 'b'
    if key == 'space'      then key = 'a'
    elseif key == 'return' then key = 'b' end
    control:emit(key)
 end