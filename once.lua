local Once = {}
local OnceMT = {__index=Once}

function Once:validate(seconds)
    if self.time == nil then
        self.time = love.timer.getTime() + seconds
        return true
    end
    if love.timer.getTime() < self.time then return false end
    self.time = love.timer.getTime() + seconds
    return true
end

function Once:reset() self.time = nil end
function once() return setmetatable({}, OnceMT) end