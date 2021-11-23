Player = {}
Player.__index = Player

function Player:create(x, y, length)
    local player = {}
    setmetatable(player, Player)
    player.x = x
    player.y = y
    player.length = length
    player.v = 5
    player.score = 0
    player.catching = false
    local pos = 0
    local dist = 0
    return player
end

function Player:draw()
	love.graphics.line(self.x, self.y, self.x, self.y + self.length)
end
function Player:catch(ball)
    if self.catching == false and ball.vx < 0 then
        self.catching = true
        dest_y = ball.y - ball.vy * (ball.x - self.x) / ball.vx
        if dest_y < 0 then
            dest_y = - dest_y
        elseif (dest_y > height) then
            dest_y = 2*height - dest_y
        end

        math.randomseed(1000)
        pos = math.random(0, self.length)
    end

    if self.catching == true and ball.vx < 0 then
        dist = dest_y - self.y
        if (math.abs(dist) > pos) then
             self.y = self.y + self.v*math.abs(dist)/dist
        end

        if self.y < 0 then 
            self.y = 0 
        elseif self.y + self.length > height then
            self.y = height - self.length
        end
    end

    if self.catching == true and ball.vx > 0 then
        self.catching = false
    end
end

function Player:goal(r, ball, dir)
    if ((ball.x > width - ball.r  and dir>0) or (ball.x < ball.r and dir<0)) then
        r.score = r.score + 1
    end
end


