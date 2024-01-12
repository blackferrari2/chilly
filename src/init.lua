local Chilly = {}
Chilly.__index = Chilly

-------------

type self = {
    isFree: boolean,
    timeout: number,
    tick: number,
}

export type Chilly = typeof(setmetatable({} :: self, Chilly))

-------------

function Chilly.new(): Chilly
    local self = {
        isFree = true,
        timeout = 0,
        tick = 0,
    }

    setmetatable(self, Chilly)

    return self
end

function Chilly.stopwatch(self: Chilly, seconds: number)
    self.timeout = seconds
    self.tick = tick()
end

function Chilly.cancelStopwatch(self: Chilly)
    self.timeout = 0
    self.tick = 0
end

function Chilly.lock(self: Chilly)
    self.isFree = false
end

function Chilly.unlock(self: Chilly)
    self.isFree = true
end

function Chilly.can(self: Chilly)
    local timeElapsed = tick() - self.tick

    if timeElapsed <= self.timeout then
        return false
    end

    return self.isFree
end

-------------

return Chilly