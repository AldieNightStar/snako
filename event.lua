local Event = {}
local Emt = {__index=Event}

function Event:connect(fn)
    table.insert(self.arr, fn)
end

function Event:emit(dat)
    local out = {}
    for _, fn in ipairs(self.arr) do
        if fn(dat) == true then table.insert(out, fn) end
    end
    self.arr = out
end

function Event:clear()
    self.arr = {}
end

function newEvent()
    return setmetatable({arr={}}, Emt) 
end