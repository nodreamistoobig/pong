require("player")
require("ball")

function love.load()
	width = love.graphics.getWidth()
	height = love.graphics.getHeight()

	player = Player:create(width-40, height-60, 40)
	rival = Player:create(40, height-60, 40)
	ball = Ball:create(width/2, height/2)

	gameStatus = "greeting"
	
end

function love.update()
	if (gameStatus == "on") then
		player:draw()
		rival:draw()

		if player.y+player.length < height and love.keyboard.isDown("down") then
			player.v = math.abs(player.v)
			player.y = player.y + player.v
		end

		if player.y>0 and love.keyboard.isDown("up") then
			player.v = - math.abs(player.v)
			player.y = player.y + player.v
		end
	
		ball:update()

		rival:goal(player, ball, -1)
		player:goal(rival, ball, 1)

		ball:collision(player, 1)
		ball:collision(rival, -1)

		rival:catch(ball)

		love.graphics.print(rival.score, 140, 40)
		love.graphics.print(player.score, width-140, 40)

		if rival.score == 9 then
			gameStatus = "rivalWon"
		end
		if player.score == 9 then
			gameStatus = "playerWon"
		end
	end

	if love.keyboard.isDown("space") and gameStatus == "greeting" then
		gameStatus = "on"
	end

end

function love.draw()
	love.graphics.setColor(0, 1, 0, 1)
	if gameStatus == "greeting" then
		love.graphics.print("Press space to start", 350, height/2)
	end
	if gameStatus == "on" then
		player:draw()
		rival:draw()
		ball:draw()
		love.graphics.print(rival.score, 140, 40)
		love.graphics.print(player.score, width-140, 40)
	end
	if gameStatus == "rivalWon" then
		love.graphics.print("You lose", 400, height/2)
	end
	if gameStatus == "playerWon" then
		love.graphics.print("You won", 400, height/2)
	end
end