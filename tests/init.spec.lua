return function()
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local module = require(ReplicatedStorage.Packages.Chilly)

    it(":can() should pass if no changes were made", function()
        local cooldown = module.new()

        expect(cooldown:can()).to.equal(true)
    end)

    describe("stopwatch", function()
        it("should prevent :can() from passing", function()
            local cooldown = module.new()

            cooldown:stopwatch(5)

            expect(cooldown:can()).to.equal(false)
        end)

        it("should be able to be cancelled out", function()
            local cooldown = module.new()

            cooldown:stopwatch(99999999999999)
            cooldown:cancelStopwatch()

            expect(cooldown:can()).to.equal(true)
        end)

        it("should expire after the time passed", function()
            local cooldown = module.new()
            local time = 0.2

            cooldown:stopwatch(time)

            -- some leeway
            task.wait(time + 0.1)

            expect(cooldown:can()).to.equal(true)
        end)
    end)

    describe("locking", function()  
        it("should prevent :can() from passing", function()
            local cooldown = module.new()

            cooldown:lock()

            expect(cooldown:can()).to.equal(false)
        end)

        it("should be able to be cancelled out", function()
            local cooldown = module.new()

            cooldown:lock()
            cooldown:unlock()

            expect(cooldown:can()).to.equal(true)
        end)
    end)

    describe("overlaps", function() 
        it(":can() should not pass if the stopwatch expired but the cooldown is locked", function()
            local cooldown = module.new()
            local time = 0.2
    
            cooldown:stopwatch(time)
            cooldown:lock()
    
            -- some leeway
            task.wait(time + 0.1)
    
            expect(cooldown:can()).to.equal(false)
        end)
    end)
end