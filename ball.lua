Ball = {}
Ball.__index = Ball

function Ball:create(x, y)
    local ball = {}
    setmetatable(ball, Ball)
    ball.x = x
    ball.y = y
	ball.r = 10
	ball.hpt = 4

	math.randomseed(1000)
    ball.vy = math.random(math.sqrt(ball.hpt)-1, math.sqrt(ball.hpt))
    ball.vx = math.sqrt(ball.hpt*ball.hpt -  ball.vy* ball.vy)
    return ball
end

function Ball:draw()
	love.graphics.circle("fill", self.x, self.y, self.r)
end

function Ball:update()
    if self.x > width - self.r or self.x < self.r then
		self.hpt = self.hpt + 0.3
		self.vy = math.random(self.hpt/4, self.hpt/2)
		self.vx = math.sqrt(self.hpt*self.hpt -  self.vy * self.vy)
		if self.x > width - self.r then
			self.vx = -self.vx
		end
		self.x = width/2
        self.y = height/2
       
	end
    if self.y > height - self.r or self.y < self.r then
		self.vy = -self.vy
	end

	self.x = self.x + self.vx
	self.y = self.y + self.vy
end

function Ball:collision(player, d)
	if math.abs(self.x + (self.r*d) - player.x) < math.abs(self.vx) and self.y >= player.y - self.r and self.y <= player.y + player.length + self.r then
		dir = math.abs(player.v)/player.v
		k = 1 - math.abs(player.y + player.length/2 - self.y)/player.length
		self.vx = -self.vx - k
		self.vy = -self.vy*dir - 1+k
	end
end
