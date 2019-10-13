local robot = require("robot")
local term = require("term")
local os = require("os")
local component = require("component")
local sides = require("sides")
local keyboard = require("keyboard")
local computer = require("computer")

function tableLength(table)
  count = 1
  while table[count] ~= nil do
    count=count+1
  end
  return count-1
end

function testLeft()
	leftPresent = false
	robot.turnLeft()
	if robot.detect() then
		leftPresent = true
	end
	robot.turnRight()
	return leftPresent
end

function move()
	swung = false
	while robot.detect() do
		robot.select(1) robot.swing()
    swung = true
  	invCount = robot.inventorySize() -- check if need to dump garbage
  	if component.inventory_controller.getStackInInternalSlot(1) ~= nil then
      robot.select(1)
      while component.inventory_controller.getStackInInternalSlot(invCount) ~= nil and (robot.compareTo(invCount) == false or component.inventory_controller.getStackInInternalSlot(invCount).size == component.inventory_controller.getStackInInternalSlot(invCount).maxSize) do
  	    if invCount == itemArray[tableLength(itemArray)][1]+1 then
  	      robot.select(4) robot.place()
  	        for x=itemArray[tableLength(itemArray)][1]+1, robot.inventorySize() do
  	          robot.select(x)
  	          while robot.drop() == false do end
  	        end
  	      robot.select(4) robot.swing()
  	      invCount = robot.inventorySize()
  	    else invCount = invCount - 1
  	    end
  	  end
      robot.select(1)
      robot.transferTo(invCount)
  	end
	end

	if computer.energy() / computer.maxEnergy() <= 0.025 then
		while computer.energy() / computer.maxEnergy() <= 0.975 do
			if component.generator.count() < 1 then -- refuel
				print("Refueling!")
				robot.select(4) robot.place() robot.select(1)
			while component.generator.count() < 64 do robot.suck(64-component.generator.count()) component.generator.insert() end
			robot.select(4) robot.swing()
			end
			print("Charging... "..computer.energy())
			os.sleep(10)
		end
		print("Charged: "..computer.energy())
	end
	
	while robot.forward() ~= true do end
  return swung
end

function moveUp()
	swung = false
	while robot.detectUp() do
		robot.select(1) robot.swingUp()
    swung = true
  	invCount = robot.inventorySize() -- check if need to dump garbage
  	if component.inventory_controller.getStackInInternalSlot(1) ~= nil then
      robot.select(1)
      while component.inventory_controller.getStackInInternalSlot(invCount) ~= nil and (robot.compareTo(invCount) == false or component.inventory_controller.getStackInInternalSlot(invCount).size == component.inventory_controller.getStackInInternalSlot(invCount).maxSize) do
  	    if invCount == itemArray[tableLength(itemArray)][1]+1 then
  	      robot.select(4) robot.placeUp()
  	        for x=itemArray[tableLength(itemArray)][1]+1, robot.inventorySize() do
  	          robot.select(x)
  	          while robot.dropUp() == false do end
  	        end
  	      robot.select(4) robot.swingUp()
  	      invCount = robot.inventorySize()
  	    else invCount = invCount - 1
  	    end
  	  end
      robot.select(1)
      robot.transferTo(invCount)
  	end
	end

	if computer.energy() / computer.maxEnergy() <= 0.025 then
		while computer.energy() / computer.maxEnergy() <= 0.975 do
			if component.generator.count() < 1 then -- refuel
				print("Refueling!")
				robot.select(4) robot.placeUp() robot.select(1)
			while component.generator.count() < 64 do robot.suckUp(64-component.generator.count()) component.generator.insert() end
			robot.select(4) robot.swingUp()
			end
			print("Charging... "..computer.energy())
			os.sleep(10)
		end
		print("Charged: "..computer.energy())
	end

	while robot.up() ~= true do end
  return swung
end

function moveDown()
	swung = false
	while robot.detectDown() do
		robot.select(1) robot.swingDown()
    swung = true
  	invCount = robot.inventorySize() -- check if need to dump garbage
  	if component.inventory_controller.getStackInInternalSlot(1) ~= nil then
      robot.select(1)
      while component.inventory_controller.getStackInInternalSlot(invCount) ~= nil and (robot.compareTo(invCount) == false or component.inventory_controller.getStackInInternalSlot(invCount).size == component.inventory_controller.getStackInInternalSlot(invCount).maxSize) do
  	    if invCount == itemArray[tableLength(itemArray)][1]+1 then
  	      robot.select(4) robot.placeDown()
  	        for x=itemArray[tableLength(itemArray)][1]+1, robot.inventorySize() do
  	          robot.select(x)
  	          while robot.dropDown() == false do end
  	        end
  	      robot.select(4) robot.swingDown()
  	      invCount = robot.inventorySize()
  	    else invCount = invCount - 1
  	    end
  	  end
      robot.select(1)
      robot.transferTo(invCount)
  	end
	end
	
	if computer.energy() / computer.maxEnergy() <= 0.025 then
		while computer.energy() / computer.maxEnergy() <= 0.975 do
			if component.generator.count() < 1 then -- refuel
				print("Refueling!")
				robot.select(4) robot.placeDown() robot.select(1)
			while component.generator.count() < 64 do robot.suckDown(64-component.generator.count()) component.generator.insert() end
			robot.select(4) robot.swingDown()
			end
			print("Charging... "..computer.energy())
			os.sleep(10)
		end
		print("Charged: "..computer.energy())
	end
	
	while robot.down() ~= true do end
  return swung
end

function moveBack()
	swung = false
	if robot.back() ~= true then
		robot.turnAround()
		swung = true
		robot.select(1)
		while robot.detect() do
			robot.swing()
			os.sleep(0.2)
    	invCount = robot.inventorySize() -- check if need to dump garbage
    	if component.inventory_controller.getStackInInternalSlot(1) ~= nil then
    		robot.select(1)
    		while component.inventory_controller.getStackInInternalSlot(invCount) ~= nil and (robot.compareTo(invCount) == false or component.inventory_controller.getStackInInternalSlot(invCount).size == component.inventory_controller.getStackInInternalSlot(invCount).maxSize) do
    			if invCount == itemArray[tableLength(itemArray)][1]+1 then
    				robot.select(4) robot.place()
    				for x=itemArray[tableLength(itemArray)][1]+1, robot.inventorySize() do
    					robot.select(x)
    					while robot.drop() == false do end
    				end
    				robot.select(4) robot.swing()
    				invCount = robot.inventorySize()
    			else
    				invCount = invCount - 1
    			end
    		end
    		robot.select(1)
    		robot.transferTo(invCount)
    	end
		end
	end

	if computer.energy() / computer.maxEnergy() <= 0.025 then
		while computer.energy() / computer.maxEnergy() <= 0.975 do
			if component.generator.count() < 1 then -- refuel
				print("Refueling!")
				robot.select(4) robot.place() robot.select(1)
			while component.generator.count() < 64 do robot.suck(64-component.generator.count()) component.generator.insert() end
			robot.select(4) robot.swing()
			end
			print("Charging... "..computer.energy())
			os.sleep(10)
		end
		print("Charged: "..computer.energy())
	end
    
	if swung == true then
		robot.turnAround()
	    while robot.back() ~= true do end
    end
	return swung
end

function dig()
  while robot.detect() do
		robot.select(1) robot.swing()
  	invCount = robot.inventorySize() -- check if need to dump garbage
  	if component.inventory_controller.getStackInInternalSlot(1) ~= nil then
      while component.inventory_controller.getStackInInternalSlot(invCount) ~= nil and (robot.compareTo(invCount) == false or component.inventory_controller.getStackInInternalSlot(invCount).size == component.inventory_controller.getStackInInternalSlot(invCount).maxSize) do
  	    if invCount == itemArray[tableLength(itemArray)][1]+1 then
  	      robot.select(4) robot.place()
  	        for x=itemArray[tableLength(itemArray)][1]+1, robot.inventorySize() do
  	          robot.select(x)
  	          while robot.drop() == false do end
  	        end
  	      robot.select(4) robot.swing()
  	      invCount = robot.inventorySize()
  	    else invCount = invCount - 1
  	    end
  	  end
      robot.select(1)
      robot.transferTo(invCount)
  	end
	end

	if computer.energy() / computer.maxEnergy() <= 0.025 then
		while computer.energy() / computer.maxEnergy() <= 0.975 do
			if component.generator.count() < 1 then -- refuel
				print("Refueling!")
				robot.select(4) robot.place() robot.select(1)
			while component.generator.count() < 64 do robot.suck(64-component.generator.count()) component.generator.insert() end
			robot.select(4) robot.swing()
			end
			term.clearLine()
			print("Charging... "..computer.energy())
			os.sleep(10)
		end
		print("Charged: "..computer.energy())
	end
end

function digDown()
	while robot.detectDown() do
		robot.select(1) robot.swingDown()
  	invCount = robot.inventorySize() -- check if need to dump garbage
  	if component.inventory_controller.getStackInInternalSlot(1) ~= nil then
      while component.inventory_controller.getStackInInternalSlot(invCount) ~= nil and (robot.compareTo(invCount) == false or component.inventory_controller.getStackInInternalSlot(invCount).size == component.inventory_controller.getStackInInternalSlot(invCount).maxSize) do
  	    if invCount == itemArray[tableLength(itemArray)][1]+1 then
  	      robot.select(4) robot.placeDown()
  	        for x=itemArray[tableLength(itemArray)][1]+1, robot.inventorySize() do
  	          robot.select(x)
  	          while robot.dropDown() == false do end
  	        end
  	      robot.select(4) robot.swingDown()
  	      invCount = robot.inventorySize()
  	    else invCount = invCount - 1
  	    end
  	  end
      robot.select(1)
      robot.transferTo(invCount)
  	end
	end

	if computer.energy() / computer.maxEnergy() <= 0.025 then
		while computer.energy() / computer.maxEnergy() <= 0.975 do
			if component.generator.count() < 1 then -- refuel
				print("Refueling!")
				robot.select(4) robot.placeDown() robot.select(1)
			while component.generator.count() < 64 do robot.suckDown(64-component.generator.count()) component.generator.insert() end
			robot.select(4) robot.swingDown()
			end
			print("Charging... "..computer.energy())
			os.sleep(10)
		end
		print("Charged: "..computer.energy())
	end
end

function digUp()
	while robot.detectUp() do
		robot.select(1) robot.swingUp()
  	invCount = robot.inventorySize() -- check if need to dump garbage
  	if component.inventory_controller.getStackInInternalSlot(1) ~= nil then
      while component.inventory_controller.getStackInInternalSlot(invCount) ~= nil and (robot.compareTo(invCount) == false or component.inventory_controller.getStackInInternalSlot(invCount).size == component.inventory_controller.getStackInInternalSlot(invCount).maxSize) do
  	    if invCount == itemArray[tableLength(itemArray)][1]+1 then
  	      robot.select(4) robot.placeUp()
  	        for x=itemArray[tableLength(itemArray)][1]+1, robot.inventorySize() do
  	          robot.select(x)
  	          while robot.dropUp() == false do end
  	        end
  	      robot.select(4) robot.swingUp()
  	      invCount = robot.inventorySize()
  	    else invCount = invCount - 1
  	    end
  	  end
      robot.select(1)
      robot.transferTo(invCount)
  	end
	end

	if computer.energy() / computer.maxEnergy() <= 0.025 then
		while computer.energy() / computer.maxEnergy() <= 0.975 do
			if component.generator.count() < 1 then -- refuel
				print("Refueling!")
				robot.select(4) robot.placeUp() robot.select(1)
			while component.generator.count() < 64 do robot.suckUp(64-component.generator.count()) component.generator.insert() end
			robot.select(4) robot.swingUp()
			end
			print("Charging... "..computer.energy())
			os.sleep(10)
		end
		print("Charged: "..computer.energy())
	end
end

function relocate(initPos, endPos) -- moves robot from given side to other side (starting facing out and ending facing out)
-- move to South
	if initPos == "N" then
		robot.turnLeft()
		move()
		robot.turnLeft()
		if move() then move() robot.turnAround() place("ladder") robot.turnAround() else move() end
		move()
		robot.turnLeft()
		if move() then move() robot.turnAround() place("ladder") robot.turnAround() else move() end
		robot.turnRight()
	end
	if initPos == "E" then
		robot.turnRight()
		if move() then move() robot.turnAround() place("ladder") robot.turnAround() else move() end
		robot.turnRight()
		move()
		robot.turnLeft()
	end
	if initPos == "S" then
		-- already here
	end
	if initPos == "W" then
		robot.turnLeft()
		move()
		robot.turnLeft()
		if move() then move() robot.turnAround() place("ladder") robot.turnAround() else move() end
		robot.turnRight()
	end
	if initPos == "NE" then
		moveBack()
		robot.turnRight()
		moveBack()
		robot.turnRight()
		if move() then move() robot.turnAround() place("ladder") robot.turnAround() else move() end
		robot.turnRight()
		move()
		robot.turnLeft()
	end
	if initPos == "SE" then
		moveBack()
		robot.turnRight()
		moveBack()
		-- we here
	end
	if initPos == "SW" then
		moveBack()
		robot.turnRight()
		moveBack()
		robot.turnLeft()
		move()
		robot.turnLeft()
		if move() then move() robot.turnAround() place("ladder") robot.turnAround() else move() end
		robot.turnRight()
	end
	if initPos == "NW" then
		moveBack()
		robot.turnRight()
		moveBack()
		robot.turnLeft()
		move()
		robot.turnLeft()
		if move() then move() robot.turnAround() place("ladder") robot.turnAround() else move() end
		move()
		robot.turnLeft()
		if move() then move() robot.turnAround() place("ladder") robot.turnAround() else move() end
		robot.turnRight()
	end
-- move from South
	if endPos == "N" then
		robot.turnLeft()
		move()
		robot.turnLeft()
		if move() then move() robot.turnAround() place("ladder") robot.turnAround() else move() end
		move()
		robot.turnLeft()
		if move() then move() robot.turnAround() place("ladder") robot.turnAround() else move() end
		robot.turnRight()
	end
	if endPos == "E" then
		robot.turnLeft()
		move()
		robot.turnLeft()
		if move() then move() robot.turnAround() place("ladder") robot.turnAround() else move() end
		robot.turnRight()
	end
	if endPos == "S" then
		-- already here
	end
	if endPos == "W" then
		robot.turnRight()
		if move() then move() robot.turnAround() place("ladder") robot.turnAround() else move() end
		robot.turnRight()
		move()
		robot.turnLeft()
	end
	if endPos == "NE" then
		robot.turnLeft()
		move()
		robot.turnLeft()
		if move() then move() robot.turnAround() place("ladder") robot.turnAround() else move() end
		robot.turnRight()
		move()
		robot.turnLeft()
		move()
	end
	if endPos == "SE" then
		-- we here
		move()
		robot.turnLeft()
		move()
	end
	if endPos == "SW" then
		robot.turnRight()
		if move() then move() robot.turnAround() place("ladder") robot.turnAround() else move() end
		robot.turnRight()
		move()
		robot.turnLeft()
		move()
		robot.turnLeft()
		move()
	end
	if endPos == "NW" then
		robot.turnLeft()
		move()
		robot.turnLeft()
		if move() then move() robot.turnAround() place("ladder") robot.turnAround() else move() end
		move()
		robot.turnLeft()
		if move() then move() robot.turnAround() place("ladder") robot.turnAround() else move() end
		robot.turnRight()
		move()
		robot.turnLeft()
		move()
	end
end

function straightJut()
	move()
	move()
	robot.turnRight()
	placeDown("plank")
	move()
	placeDown("plank")
	robot.turnLeft()
	move()
	robot.turnRight()
	move()
	placeDown("stoneBrick")
	moveBack()
	place("spruceFence")
	placeDown("plank")
	moveBack()
	placeDown("plank")
	moveBack()
	placeDown("stoneBrick")
	robot.turnRight()
	moveBack()
	place("spruceFence")
	robot.turnRight()
	placeDown("stoneBrick")
	moveBack()
	place("spruceFence")
	placeDown("stoneBrick")
	moveBack()
	placeDown("stoneBrick")
	moveBack()
	placeDown("stoneBrick")
	robot.turnLeft()
	moveBack()
	place("spruceFence")
	robot.turnLeft()
	placeUp("log")
	moveBack()
	digUp()
	place("log")
	moveBack()
	digUp()
	moveBack()
	placeUp("log")
	robot.turnRight()
	moveBack()
	place("log")
	moveUp()
	moveUp()
	move()
	move()
	placeDown("torch")
	moveBack()
	robot.turnRight()
	placeUp("sprucePlank")
	moveBack()
	place("log")
	placeUp("sprucePlank")
	moveBack()
	placeUp("sprucePlank")
	moveBack()
	placeUp("sprucePlank")
	robot.turnLeft()
	move()
	placeDown("torch")
	moveBack()
	moveBack()
	place("log")
	robot.turnRight()
	for i=1, 3 do move() end
	moveDown()
	moveDown()
end

function diagJut()
	move()
	placeDown("plank")
	move()
	placeDown("plank")
	move()
	placeDown("stoneBrick")
	robot.turnRight()
	moveBack()
	place("spruceFence")
	placeDown("stoneBrick")
	robot.turnRight()
	moveBack()
	place("spruceFence")
	robot.turnRight()
	moveBack()
	placeDown("stoneBrick")
	placeUp("torch")
	moveBack()
	place("spruceFence")
	placeUp("log")
	robot.turnRight()
	moveBack()
	place("log")
	placeDown("stoneBrick")
	moveBack()
	placeDown("plank")
	moveBack()
	placeDown("plank")
	robot.turnLeft()
	moveBack()
	robot.turnLeft()
	move()
	placeDown("stoneBrick")
	moveBack()
	place("spruceFence")
	placeDown("stoneBrick")
	moveBack()
	place("spruceFence")
	placeDown("stoneBrick")
	moveBack()
	digUp()
	robot.turnRight()
	moveBack()
	robot.turnRight()
	moveBack()
	placeUp("log")
	moveBack()
	place("log")
	placeDown("stoneBrick")
	moveUp()
	placeDown("spruceFence")
	moveUp()
	placeDown("torch")
	move()
	placeUp("sprucePlank")
	robot.turnAround()
	moveBack()
	place("log")
	robot.turnRight()
	move()
	placeUp("sprucePlank")
	robot.turnRight()
	move()
	robot.turnLeft()
	move()
	placeUp("sprucePlank")
	moveBack()
	place("log")
	moveDown()
	moveDown()
end

itemArray = {}
	-- SLOT 1 FOR PICK (ideally infinipick)
	itemArray[1] = {} itemArray[1][1] = 6 itemArray[1][2] = 2 itemArray[1][3] = 9 itemArray[1][4] = "stoneBrick" -- stone tesseract
	itemArray[2] = {} itemArray[2][1] = 17 itemArray[2][2] = 3 itemArray[2][3] = 9 itemArray[2][4] = "stoneSlab" -- misc tesseract 1
	itemArray[3] = {} itemArray[3][1] = 18 itemArray[3][2] = 3 itemArray[3][3] = 10 itemArray[3][4] = "torch" -- misc tesseract 2
	itemArray[4] = {} itemArray[4][1] = 19 itemArray[4][2] = 3 itemArray[4][3] = 11 itemArray[4][4] = "plank" -- misc tesseract 3
	itemArray[5] = {} itemArray[5][1] = 20 itemArray[5][2] = 3 itemArray[5][3] = 12 itemArray[5][4] = "plankSlab" -- misc tesseract 4
	itemArray[6] = {} itemArray[6][1] = 21 itemArray[6][2] = 3 itemArray[6][3] = 13 itemArray[6][4] = "ironDoor" -- misc tesseract 5
	itemArray[7] = {} itemArray[7][1] = 22 itemArray[7][2] = 3 itemArray[7][3] = 14 itemArray[7][4] = "ironWindow" -- misc tesseract 6 -frameless
	itemArray[8] = {} itemArray[8][1] = 23 itemArray[8][2] = 3 itemArray[8][3] = 15 itemArray[8][4] = "button" -- misc tesseract 7
	itemArray[9] = {} itemArray[9][1] = 24 itemArray[9][2] = 3 itemArray[9][3] = 16 itemArray[9][4] = "ladder" -- misc tesseract 8
	-- NB SLOT 4 FOR COAL COKE OR OTHER FUEL TELE
	itemArray[10] = {} itemArray[10][1] = 25 itemArray[10][2] = 5 itemArray[10][3] = 9 itemArray[10][4] = "log" -- misc 2 tesseract 1
	itemArray[11] = {} itemArray[11][1] = 26 itemArray[11][2] = 5 itemArray[11][3] = 10 itemArray[11][4] = "sprucePlank" -- misc 2 tesseract 2
	itemArray[12] = {} itemArray[12][1] = 27 itemArray[12][2] = 5 itemArray[12][3] = 11 itemArray[12][4] = "spruceFence" -- misc 2 tesseract 3
	itemArray[13] = {} itemArray[13][1] = 28 itemArray[13][2] = 5 itemArray[13][3] = 12 itemArray[13][4] = "trapDoor" -- misc 2 tesseract 4

function place(blockName)
	swung = false
	while robot.detect() do -- check for blockage
		robot.select(1) robot.swing()
		swung = true
  	invCount = robot.inventorySize() -- check if need to dump garbage
  	if component.inventory_controller.getStackInInternalSlot(1) ~= nil then
      while component.inventory_controller.getStackInInternalSlot(invCount) ~= nil and (robot.compareTo(invCount) == false or component.inventory_controller.getStackInInternalSlot(invCount).size == component.inventory_controller.getStackInInternalSlot(invCount).maxSize) do
  	    if invCount == itemArray[tableLength(itemArray)][1]+1 then
  	      robot.select(4) robot.place()
  	        for x=itemArray[tableLength(itemArray)][1]+1, robot.inventorySize() do
  	          robot.select(x)
  	          while robot.drop() == false do end
  	        end
  	      robot.select(4) robot.swing()
  	      invCount = robot.inventorySize()
  	    else invCount = invCount - 1
  	    end
  	  end
      robot.select(1)
      robot.transferTo(invCount)
  	end
	end

	for blocki=1, tableLength(itemArray) do -- need to restock?
		if itemArray[blocki][4] == blockName then
			if component.inventory_controller.getStackInInternalSlot(itemArray[blocki][1]) == nil then
				if blockName ~= "stoneBrick" then
					robot.select(itemArray[blocki][2])
					robot.place()
					print("Restocking "..itemArray[blocki][4]..".")
					robot.select(itemArray[blocki][1])
					component.inventory_controller.suckFromSlot(3,itemArray[blocki][3],(component.inventory_controller.getSlotMaxStackSize(3,itemArray[blocki][3])-1))
					robot.select(itemArray[blocki][2]) robot.swing() os.sleep(0.2)
				else
					if itemArray[blocki][1]<16 then
						while component.inventory_controller.getStackInInternalSlot(itemArray[blocki][1]) == nil and itemArray[blocki][1]<16 do
							itemArray[blocki][1] = itemArray[blocki][1] + 1
						end
					else
						itemArray[blocki][1] = 6
						robot.select(itemArray[blocki][2])
						robot.place()
						print("Restocking "..itemArray[blocki][4]..".")
						for stonei=itemArray[blocki][1], 16 do
							robot.select(stonei)
							component.inventory_controller.suckFromSlot(3,9,64)
							while component.inventory_controller.getSlotStackSize(3,9)<component.inventory_controller.getSlotMaxStackSize(3,9) do os.sleep(1) end
						end
						robot.select(itemArray[blocki][2]) robot.swing() os.sleep(0.2)
					end
				end
			end
			robot.select(itemArray[blocki][1])
		end
	end
	
	if blockName == "ladder" then
		if robot.place(3) == false then robot.place() end
	else
		if robot.place(0) == false then robot.place() end
	end
	
	return swung
end

function placeUp(blockName)
	swung = false
	while robot.detectUp() do -- check for blockage
		robot.select(1) robot.swingUp()
		swung = true
  	invCount = robot.inventorySize() -- check if need to dump garbage
  	if component.inventory_controller.getStackInInternalSlot(1) ~= nil then
      while component.inventory_controller.getStackInInternalSlot(invCount) ~= nil and (robot.compareTo(invCount) == false or component.inventory_controller.getStackInInternalSlot(invCount).size == component.inventory_controller.getStackInInternalSlot(invCount).maxSize) do
  	    if invCount == itemArray[tableLength(itemArray)][1]+1 then
  	      robot.select(4) robot.placeUp()
  	        for x=itemArray[tableLength(itemArray)][1]+1, robot.inventorySize() do
  	          robot.select(x)
  	          while robot.dropUp() == false do end
  	        end
  	      robot.select(4) robot.swingUp()
  	      invCount = robot.inventorySize()
  	    else invCount = invCount - 1
  	    end
  	  end
      robot.select(1)
      robot.transferTo(invCount)
  	end
	end

	for blocki=1, tableLength(itemArray) do -- need to restock?
	  if itemArray[blocki][4] == blockName then
	    if component.inventory_controller.getStackInInternalSlot(itemArray[blocki][1]) == nil then
	      if blockName ~= "stoneBrick" then
  	      robot.select(itemArray[blocki][2])
  	      robot.placeUp()
  	      print("Restocking "..itemArray[blocki][4]..".")
  	      robot.select(itemArray[blocki][1])
  	      component.inventory_controller.suckFromSlot(1,itemArray[blocki][3],(component.inventory_controller.getSlotMaxStackSize(1,itemArray[blocki][3])-1))
  	      robot.select(itemArray[blocki][2]) robot.swingUp() os.sleep(0.2)
  	    else
  	      if itemArray[blocki][1]<16 then
            while component.inventory_controller.getStackInInternalSlot(itemArray[blocki][1]) == nil and itemArray[blocki][1]<16 do
              itemArray[blocki][1] = itemArray[blocki][1] + 1
            end
  	      else
  	        itemArray[blocki][1] = 6
  	        robot.select(itemArray[blocki][2])
  	        robot.placeUp()
  	        print("Restocking "..itemArray[blocki][4]..".")
  	        for stonei=itemArray[blocki][1], 16 do
  	          robot.select(stonei)
  	          while component.inventory_controller.getSlotStackSize(1,9)<component.inventory_controller.getSlotMaxStackSize(1,9) do os.sleep(1) end
  	          component.inventory_controller.suckFromSlot(1,9,64)
  	        end
  	      robot.select(itemArray[blocki][2]) robot.swingUp() os.sleep(0.2)
  	      end
  	    end
	    end
	  robot.select(itemArray[blocki][1])
	  end
	end
	if robot.placeUp(1) == false then robot.placeUp() end
	return swung
end

function placeDown(blockName)
	swung = false
	while robot.detectDown() do -- check for blockage
		robot.select(1) robot.swingDown()
		swung = true
  	invCount = robot.inventorySize() -- check if need to dump garbage
  	if component.inventory_controller.getStackInInternalSlot(1) ~= nil then
      while component.inventory_controller.getStackInInternalSlot(invCount) ~= nil and (robot.compareTo(invCount) == false or component.inventory_controller.getStackInInternalSlot(invCount).size == component.inventory_controller.getStackInInternalSlot(invCount).maxSize) do
  	    if invCount == itemArray[tableLength(itemArray)][1]+1 then
  	      robot.select(4) robot.placeDown()
  	        for x=itemArray[tableLength(itemArray)][1]+1, robot.inventorySize() do
  	          robot.select(x)
  	          while robot.dropDown() == false do end
  	        end
  	      robot.select(4) robot.swingDown()
  	      invCount = robot.inventorySize()
  	    else invCount = invCount - 1
  	    end
  	  end
      robot.select(1)
      robot.transferTo(invCount)
  	end
	end

	for blocki=1, tableLength(itemArray) do -- need to restock?
	  if itemArray[blocki][4] == blockName then
	    if component.inventory_controller.getStackInInternalSlot(itemArray[blocki][1]) == nil then
	      if blockName ~= "stoneBrick" then
  	      robot.select(itemArray[blocki][2])
  	      robot.placeDown()
  	      print("Restocking "..itemArray[blocki][4]..".")
  	      robot.select(itemArray[blocki][1])
  	      component.inventory_controller.suckFromSlot(0,itemArray[blocki][3],(component.inventory_controller.getSlotMaxStackSize(0,itemArray[blocki][3])-1))
  	      robot.select(itemArray[blocki][2]) robot.swingDown() os.sleep(0.2)
  	    else
  	      if itemArray[blocki][1]<16 then
            while component.inventory_controller.getStackInInternalSlot(itemArray[blocki][1]) == nil and itemArray[blocki][1]<16 do
              itemArray[blocki][1] = itemArray[blocki][1] + 1
            end
  	      else
  	        itemArray[blocki][1] = 6
  	        robot.select(itemArray[blocki][2])
  	        robot.placeDown()
  	        print("Restocking "..itemArray[blocki][4]..".")
  	        for stonei=itemArray[blocki][1], 16 do
  	          robot.select(stonei)
  	          while component.inventory_controller.getSlotStackSize(0,9)<component.inventory_controller.getSlotMaxStackSize(0,9) do os.sleep(1) end
  	          component.inventory_controller.suckFromSlot(0,9,64)
  	        end
  	      robot.select(itemArray[blocki][2]) robot.swingDown() os.sleep(0.2)
  	      end
  	    end
	    end
	  robot.select(itemArray[blocki][1])
	  end
	end
	if blockName == "log" then
		if robot.placeDown(3) == false then
			if robot.placeDown(2) == false then
				robot.placeDown()
			end
		end
	elseif blockName == "torch" then
		torchI = 2
		while torchI <=5 and robot.placeDown(torchI) == false do
			torchI = torchI + 1
		end
		if torchI == 6 then
			robot.placeDown()
		end
	else
		if robot.placeDown(0) == false then
			robot.placeDown()
		end
	end
	return swung
end

function multipleOf(wallStep, wallLength, wallIncline) -- see if i is a multiple of sectionLength/abs(sectionIncline) (rounded down/up) (for height)
	if wallIncline == 0 then return false end
	multCheckI = wallLength/(math.abs(wallIncline)+1)
	multCheck = multCheckI
	while multCheck<wallLength-1 do
		if (wallStep-multCheck<1) and (wallStep-multCheck>=0) then
			return true
		end
		multCheck = multCheck + multCheckI
	end
end

function doWindow()
	robot.turnRight()
	move()
	moveUp()
	for i=1, 3 do move() end
	place("ironWindow")
	robot.turnRight()
	move()
	robot.turnLeft()
	place("ironWindow")
	robot.turnLeft()
	move()
	robot.turnLeft()
	for i=1, 3 do move() end
	moveDown()
	move()
	robot.turnRight()
end

function wallAccentTorch(wallStepIn)
  if wallStepIn == 1 then return end
  wallStep = wallStepIn - 1
  while wallStep > 16 do
    wallStep = wallStep - 16
  end
  if wallStep == 2 or wallStep == 6 or wallStep == 7 or wallStep == 10 or wallStep == 11 or wallStep == 15 then
    moveUp()
    place("stoneBrick")
    moveDown()
  end
  if wallStep == 3 or wallStep == 14 then
    moveUp()
    place("stoneBrick")
    moveDown()
    placeUp("torch")
  end
end

function diagWallAccentTorch(wallStepIn)
  if wallStepIn == 1 then return end
  wallStep = wallStepIn - 1
  while wallStep > 16 do
    wallStep = wallStep - 16
  end
  if wallStep == 2 or wallStep == 6 or wallStep == 11 or wallStep == 15 then
    moveUp()
    place("stoneBrick")
    moveDown()
  end
  if wallStep == 3 or wallStep == 14 or wallStep == 7 or wallStep == 10 then
    moveUp()
    place("stoneBrick")
    moveDown()
    placeUp("torch")
  end
end

function straightSlabs(incline) -- if multiple
	robot.turnLeft()
	move()
	if incline >= 0 then moveUp() end
	robot.turnLeft()
	placeDown("stoneSlab")
	move()
	for i=1, 2 do
		moveDown()
		placeDown("stoneBrick")
		moveUp()
		placeDown("stoneSlab")
		move()
	end
	placeDown("stoneSlab")
	robot.turnAround()
	move()
	robot.turnRight()
	move()
	for i=1, 20 do
		moveDown()
	end
	robot.turnAround()
	move()
	moveDown()
	placeDown("plank")
	moveUp()
	placeDown("plankSlab")
	robot.turnRight()
	move()
	moveDown()
	placeDown("plank")
	moveUp()
	placeDown("plankSlab")
	robot.turnRight()
	move()
	for i=1, 19 do
		moveUp()
	end
	if incline < 0 then moveUp() end
	robot.turnLeft()
	move()
end

function diagonalSlabs(incline) -- if multiple
	robot.turnAround()
	move()
	if incline >= 0 then moveUp() end
	robot.turnRight()
	move()
	robot.turnLeft()
	placeDown("stoneSlab")
	move()
	for i=1, 5 do
		moveDown()
		placeDown("stoneBrick")
		moveUp()
		placeDown("stoneSlab")
		move()
	end
	placeDown("stoneSlab")
	robot.turnAround()
	move()
	robot.turnRight()
	move()
	for i=1, 20 do
		moveDown()
	end
	robot.turnAround()
	move()
	robot.turnRight()
	for i=1, 4 do
		moveDown()
		placeDown("plank")
		moveUp()
		placeDown("plankSlab")
		move()
	end
	moveDown()
	placeDown("plank")
	moveUp()
	placeDown("plankSlab")
	robot.turnRight()
	move()
	robot.turnLeft()
	for i=1, 19 do
		moveUp()
	end
	if incline < 0 then moveUp() end
	for i=1, 2 do move() end
end

function straightLogs(wallStepIn) -- place on second side
  if wallStepIn == 1 then return end
  wallStep = wallStepIn - 1
  while wallStep > 16 do
    wallStep = wallStep - 16
  end
  if wallStep == 8 then
    placeDown("log")
	moveBack()
	placeDown("log")
	move()
	robot.turnAround()
	place("torch")
	robot.turnAround()
  end
end

function diagonalLogs(wallStepIn) -- place on opposite side!
  if wallStepIn == 1 then return end
  wallStep = wallStepIn - 1
  while wallStep > 16 do
    wallStep = wallStep - 16
  end
  if wallStep == 10 then
    robot.turnRight()
	moveBack()
	placeDown("stoneBrick")
	robot.turnAround()
	for i=1, 5 do
		moveBack()
		placeDown("log")
	end
	for i=1, 2 do
		move()
	end
	robot.turnRight()
	for i=1, 2 do
		moveBack()
		placeDown("log")
	end
	for i=1, 4 do
		move()
	end
	for i=1, 2 do
		placeDown("log")
		moveBack()
	end
	robot.turnRight()
	moveBack()
	place("torch")
	moveBack()
	robot.turnLeft()
  end
end

function internalTorch(wallStepIn)
  if wallStepIn == 1 then return end
  wallStep = wallStepIn - 1
  while wallStep > 16 do
    wallStep = wallStep - 16
  end
  if wallStep == 3 or wallStep == 14 then
    placeDown("torch")
  end
end

function diagInternalTorch(wallStepIn)
  if wallStepIn == 1 then return end
  wallStep = wallStepIn - 1
  while wallStep > 16 do
    wallStep = wallStep - 16
  end
  if wallStep == 3 or wallStep == 14 or wallStep == 7 or wallStep == 10 then
    placeDown("torch")
  end
end

function externalTorch(wallStepIn)
  if wallStepIn == 1 then return end
  wallStep = wallStepIn - 1
  while wallStep > 16 do
    wallStep = wallStep - 16
  end
  if wallStep == 3 or wallStep == 14 then
    move()
	if robot.detect() == false then
		move()
		placeDown("torch")
		moveBack()
	end
	moveBack()
  end
end

function diagExternalTorch(wallStepIn)
  if wallStepIn == 1 then return end
  wallStep = wallStepIn - 1
  while wallStep > 16 do
    wallStep = wallStep - 16
  end
  if wallStep == 3 or wallStep == 14 or wallStep == 7 or wallStep == 10 then
    move()
	if robot.detect() == false then
		move()
		placeDown("torch")
		moveBack()
	end
	moveBack()
  end
end

function externalTorchLow(wallStepIn)
  if wallStepIn == 1 then return end
  wallStep = wallStepIn - 1
  while wallStep > 16 do
    wallStep = wallStep - 16
  end
  if wallStep == 3 or wallStep == 14 then
	if robot.detect() == false then
		move()
		placeDown("torch")
		moveBack()
	end
  end
end

function diagExternalTorchLow(wallStepIn)
  if wallStepIn == 1 then return end
  wallStep = wallStepIn - 1
  while wallStep > 16 do
    wallStep = wallStep - 16
  end
  if wallStep == 3 or wallStep == 14 or wallStep == 7 or wallStep == 10 then
	if robot.detect() == false then
		move()
		placeDown("torch")
		moveBack()
	end
  end
end

function isOdd(number) -- only works for positive integers
	while number >= 0 do
		if number == 0 then
			return false
		end
		number = number - 2
	end
  	if number < 0 then
		return true
	end
end

function roundDown(number)
	rd = 0
	while number >= 1 do
		rd = rd + 1
		number = number - 1
	end
	return rd
end

function straightEscapeHatch(wallLengthIn, wallStepIn)
	if wallStepIn == 1 then return end
	realWallStep = wallStepIn - 1
	realWallLength = wallLengthIn - 2
	realChunks = realWallLength/16
	if realChunks >=16 then
		hatches = ((realChunks-8)/8)
		extraChunks = 8 * (hatches - roundDown(hatches))
		if isOdd(extraChunks) then
			extraChunks = extraChunks - 1
		end
		checki = (extraChunks/2)*16
		for i=1, roundDown(hatches) do
			checki = checki + (16*8)
			if checki+10 == realWallStep then
				moveBack()
				for i=1, 19 do moveDown() end
				robot.turnLeft()
				for i=1, 2 do move() end
				place("button")
				robot.turnRight()
				for i=1, 2 do move() end
				robot.turnRight()
				place("button")
				robot.turnRight()
				moveDown()
				dig()
				place("ironDoor")
				for i=1, 2 do moveUp() end
				move()
				move()
				robot.turnAround()
				place("stoneBrick")
				robot.turnAround()
				move()
				move()
				move()
				robot.turnAround()
				moveDown()
				dig()
				moveDown()
				dig()
				place("ironDoor")
				moveUp()
				robot.turnLeft()
				place("button")
				robot.turnRight()
				moveUp()
				for i=1, 2 do move() end
				robot.turnAround()
				place("stoneBrick")
				robot.turnAround()
				move()
				robot.turnRight()
				move()
				robot.turnLeft()
				for i=1, 2 do moveDown() end
				moveBack()
				for i=1, 2 do
					place("ladder")
					moveUp()
				end
				placeDown("button")
				for i=1, 16 do
					place("ladder")
					moveUp()
				end
				move()
				moveUp()
				place("button")
				moveUp()
				place("spruceFence")
				placeDown("trapDoor")
				robot.turnRight()
				move()
				robot.turnLeft()
				move()
			end
		end
	end
end

function diagonalEscapeHatch(wallLengthIn, wallStepIn)
	if wallStepIn == 1 then return end
	realWallStep = wallStepIn - 1
	realWallLength = wallLengthIn - 2
	realChunks = realWallLength/16
	if realChunks >=16 then
		hatches = ((realChunks-8)/8)
		extraChunks = 8 * (hatches - roundDown(hatches))
		if isOdd(extraChunks) then
			extraChunks = extraChunks - 1
		end
		checki = (extraChunks/2)*16
		for i=1, roundDown(hatches) do
			checki = checki + (16*8)
			if checki+10 == realWallStep then
				moveBack()
				for i=1, 19 do moveDown() end
				robot.turnLeft()
				for i=1, 2 do move() end
				robot.turnRight()
				for i=1, 3 do move() end
				robot.turnLeft()
				place("button")
				robot.turnAround()
				place("stoneBrick")
				moveDown()
				place("stoneBrick")
				moveDown()
				place("stoneBrick")
				moveUp()
				placeDown("stoneBrick")
				robot.turnLeft()
				move()
				robot.turnAround()
				place("ironDoor")
				moveUp()
				robot.turnLeft()
				place("button")
				robot.turnRight()
				moveUp()
				move()
				move()
				robot.turnAround()
				place("stoneBrick")
				robot.turnAround()
				for i=1, 5 do move() end
				moveDown()
				robot.turnLeft()
				place("button")
				robot.turnAround()
				place("stoneBrick")
				moveDown()
				place("stoneBrick")
				moveDown()
				place("stoneBrick")
				moveUp()
				placeDown("stoneBrick")
				robot.turnLeft()
				move()
				robot.turnAround()
				place("ironDoor")
				moveUp()
				robot.turnLeft()
				place("button")
				robot.turnRight()
				moveUp()
				for i=1, 2 do move() end
				robot.turnAround()
				place("stoneBrick")
				robot.turnAround()
				for i=1, 2 do moveDown() end
				robot.turnRight()
				move()
				robot.turnLeft()
				for i=1, 2 do move() end
				for i=1, 18 do
					place("ladder")
					moveUp()
				end
				move()
				moveUp()
				place("button")
				moveUp()
				place("spruceFence")
				placeDown("trapDoor")
				robot.turnRight()
				move()
				robot.turnLeft()
			end
		end
	end
end

-- Begin
term.clear()
print("Press space to confirm that robot is facing internal tower column, on the South side, on the right block.")
while not keyboard.isKeyDown(keyboard.keys.space) do os.sleep(0.1) end
term.clear()

-- Load Tower Information

print("Tower Data File:")
towerData = io.read()

towerArray = {}
towerNum = 0
first = true
for line in io.lines(towerData) do
	if first == false then
	wordNum = 0
	towerNum = towerNum +1
	towerArray[towerNum] = {}
	for word in string.gmatch(line, '([^,]+)') do
		wordNum = wordNum + 1
		if wordNum == 1 then towerArray[towerNum][wordNum] = tonumber(word) end -- tower North East nib X
		if wordNum == 2 then towerArray[towerNum][wordNum] = tonumber(word) end -- tower North East nib Y
		if wordNum == 3 then towerArray[towerNum][wordNum] = tonumber(word) end -- tower North East nib Z
		if wordNum == 4 then towerArray[towerNum][wordNum] = word end -- outgoing wall orientation e.g. N,NE,E,SE,S,SW,W,NW
		if wordNum == 5 then print("Tower Data is messed up. Exiting...") os.exit() end
	end
	else
		towerArray[0] = {}
		for word in string.gmatch(line, '([^,]+)') do
			towerArray[0][4] = word
		end
		first = false
	end
end

term.clear()
print("Tower Data loaded...")
print(" ")

if tableLength(towerArray) == 1 or tableLength(towerArray) == 0 then
	print ("Can't build a one tower wall! Exiting.")
	return false
end

os.sleep(1)
term.clear()

print("Robot Inventory Instructions:")
print("1 - Pickaxe (Preferably w/o Durability)")
print("2 - Stone Brick Transceiver")
print("3 - Misc. Transceiver")
print("4 - Trash/Fuel Transceiver")
print("5 - Misc. Transceiver 2")
print("6+ - No need to load!")

print(" ")
print("--- Press Enter When Ready to Begin ---")
while not keyboard.isKeyDown(keyboard.keys.enter) do os.sleep(0.1) end
term.clear()
robot.select(1)
component.inventory_controller.equip()
print("Building...")

-- Begin walling sequence

for towerIt=1, tableLength(towerArray)-1 do
	-- move up
	for i=1, 19 do moveUp() end
	-- platform
	moveBack()
	place("plank")
	robot.turnAround()
	place("stoneBrick")
	robot.turnLeft()
	moveBack()
	place("plank")
	robot.turnLeft()
	if place("plank") then place("ladder") end
	robot.turnAround()
	place("stoneBrick")
	robot.turnLeft()
	moveBack()
	place("plank")
	robot.turnLeft()
	place("plank")
	robot.turnAround()
	place("stoneBrick")
	robot.turnLeft()
	moveBack()
	place("plank")
	robot.turnRight()
	place("stoneBrick")
	robot.turnRight()
	place("stoneBrick")
	robot.turnLeft()
	moveBack()
	place("stoneBrick")
	for i=1, 3 do
		robot.turnRight()
		place("stoneBrick")
		robot.turnLeft()
		for i=1, 3 do
			moveBack()
			place("plank")
			robot.turnLeft()
			if place("plank") and i==2 then place("ladder") end
			robot.turnAround()
			place("stoneBrick")
			robot.turnLeft()
		end
		moveBack()
		place("plank")
		robot.turnRight()
		place("stoneBrick")
		robot.turnRight()
		place("stoneBrick")
		robot.turnLeft()
		moveBack()
		place("stoneBrick")
	end
	robot.turnRight()
	place("stoneBrick")
	moveUp()
	placeDown("plank")
	--platform fencing
	robot.turnLeft()
	place("spruceFence")
	robot.turnRight()
	move()
	robot.turnLeft()
	for i=1, 5 do
		place("spruceFence")
		moveBack()
	end
	place("spruceFence")
	robot.turnRight()
	for i=1, 3 do
		for i=1, 7 do
			moveBack()
			if i>1 then place("spruceFence")
			else robot.turnLeft() place("spruceFence") robot.turnRight()
			end
		end
		if i<3 then robot.turnRight() end
	end
	moveUp()
	for i=1, 2 do move() end
	robot.turnLeft()
	for i=1, 3 do move() end
	robot.turnLeft()
	moveDown()
	-- place torches around interior
	placeUp("torch")
	robot.turnLeft()
	doWindow()
	move()
	for i=1, 3 do
		robot.turnLeft()
		if move() then move() robot.turnAround() place("ladder") robot.turnAround() else move() end
		doWindow()
		placeUp("torch")
		move()
	end
	robot.turnLeft()
	if move() then move() robot.turnAround() place("ladder") robot.turnAround() else move() end
	robot.turnRight()
	-- move to position for incoming normal jut
	if towerArray[towerIt-1][4] == "S" then
		relocate("S","N")
	end
	if towerArray[towerIt-1][4] == "W" then
		relocate("S","E")
	end
	if towerArray[towerIt-1][4] == "N" then
		relocate("S","S")
	end
	if towerArray[towerIt-1][4] == "E" then
		relocate("S","W")
	end
	-- move to position for incoming diagonal jut
	if towerArray[towerIt-1][4] == "SW" then
		relocate("S","NE")
	end
	if towerArray[towerIt-1][4] == "NW" then
		relocate("S","SE")
	end
	if towerArray[towerIt-1][4] == "NE" then
		relocate("S","SW")
	end
	if towerArray[towerIt-1][4] == "SE" then
		relocate("S","NW")
	end
	-- do the incoming juts (straight and diagonal)
	if towerArray[towerIt-1][4] == "N" or towerArray[towerIt-1][4] == "E" or towerArray[towerIt-1][4] == "S" or towerArray[towerIt-1][4] == "W" then
		straightJut()
	end
	if towerArray[towerIt-1][4] == "NE" or towerArray[towerIt-1][4] == "SE" or towerArray[towerIt-1][4] == "SW" or towerArray[towerIt-1][4] == "NW" then
		diagJut()
	end
	-- move back to south side
	if towerArray[towerIt-1][4] == "N" or towerArray[towerIt-1][4] == "E" or towerArray[towerIt-1][4] == "S" or towerArray[towerIt-1][4] == "W" then
		moveBack()
		robot.turnLeft()
		for i=1, 6 do move() end
		robot.turnAround()
		if towerArray[towerIt-1][4] == "N" then
			relocate("S","S")
		end
		if towerArray[towerIt-1][4] == "E" then -- we on west side
			relocate("W","S")
		end
		if towerArray[towerIt-1][4] == "S" then -- we on north side
			relocate("N","S")
		end
		if towerArray[towerIt-1][4] == "W" then -- we on east side
			relocate("E","S")
		end
	end
	if towerArray[towerIt-1][4] == "NE" or towerArray[towerIt-1][4] == "SE" or towerArray[towerIt-1][4] == "SW" or towerArray[towerIt-1][4] == "NW" then
		robot.turnLeft()
		for i=1, 2 do move() end
		robot.turnRight()
		for i=1, 2 do move() end
		robot.turnLeft()
		for i=1, 3 do move() end
		robot.turnRight()
		move()
		robot.turnAround()
		if towerArray[towerIt-1][4] == "NE" then -- we on west
			relocate("W","S")
		end
		if towerArray[towerIt-1][4] == "SE" then -- we on north
			relocate("N","S")
		end
		if towerArray[towerIt-1][4] == "SW" then -- we on east
			relocate("E","S")
		end
		if towerArray[towerIt-1][4] == "NW" then -- we on south
			relocate("S","S")
		end
	end
	-- move to position for outgoing normal jut
	if towerArray[towerIt][4] == "N" then
		relocate("S","N")
	end
	if towerArray[towerIt][4] == "E" then
		relocate("S","E")
	end
	if towerArray[towerIt][4] == "S" then
		relocate("S","S")
	end
	if towerArray[towerIt][4] == "W" then
		relocate("S","W")
	end
	-- move to position for outgoing diagonal jut
	if towerArray[towerIt][4] == "NE" then
		relocate("S","NE")
	end
	if towerArray[towerIt][4] == "SE" then
		relocate("S","SE")
	end
	if towerArray[towerIt][4] == "SW" then
		relocate("S","SW")
	end
	if towerArray[towerIt][4] == "NW" then
		relocate("S","NW")
	end
	-- do the outgoing juts (straight and diagonal)
	if towerArray[towerIt][4] == "N" or towerArray[towerIt][4] == "E" or towerArray[towerIt][4] == "S" or towerArray[towerIt][4] == "W" then
		straightJut()
	end
	if towerArray[towerIt][4] =="NE" or towerArray[towerIt][4] == "SE" or towerArray[towerIt][4] == "SW" or towerArray[towerIt][4] == "NW" then
		diagJut()
	end
	-- Calculate wall section lengths
	if towerArray[towerIt][4] == "N" or towerArray[towerIt][4] == "S" or towerArray[towerIt][4] == "NE" or towerArray[towerIt][4] == "NW" or towerArray[towerIt][4] == "SE" or towerArray[towerIt][4] == "SW" then
		sectionLength = (math.abs(towerArray[towerIt+1][3] - towerArray[towerIt][3]) - 14)
	end
	if towerArray[towerIt][4] == "E" or towerArray[towerIt][4] == "W" then
		sectionLength = (math.abs(towerArray[towerIt+1][1] - towerArray[towerIt][1]) - 14)
	end
	
	-- Check coordinates
	if math.fmod((sectionLength+14),16) ~= 0 then
		print("Coordinates are screwed up! Exiting.")
		return
	end
	
	-- Calculate incline
	sectionIncline = towerArray[towerIt+1][2] - towerArray[towerIt][2]
	-- Place straight wall section
	if towerArray[towerIt][4] =="N" or towerArray[towerIt][4] == "E" or towerArray[towerIt][4] == "S" or towerArray[towerIt][4] == "W" then
		for sectionIt=1, sectionLength do
			if multipleOf(sectionIt, sectionLength, sectionIncline) then
				straightSlabs(sectionIncline)
				if sectionIncline < 0 then
					moveDown()
				end
				if sectionIncline > 0 then
					moveUp()
				end
			end
			place("stoneBrick")
			straightEscapeHatch(sectionLength, sectionIt)
			wallAccentTorch(sectionIt)
			digHeight = 0
			while robot.detect() == false or digHeight<21 or robot.detectDown() == false do
				moveDown()
				digHeight = digHeight + 1
				if digHeight == 1 then place("stoneBrick") end
			end
			for i=1, digHeight do
				moveUp()
				if i == digHeight - 20 then
					placeDown("stoneBrick")
					moveBack()
					placeDown("plank")
				end
				if (i == digHeight - 20 or i == digHeight - 19 or i == digHeight - 18) and sectionIt == 1 then
					robot.turnLeft()
					dig()
					robot.turnRight()
				end
				if (i == digHeight - 20 or i == digHeight - 19 or i == digHeight - 18) and sectionIt == sectionLength then
					robot.turnRight()
					dig()
					robot.turnLeft()
				end
				if i == digHeight - 4 then
					externalTorch(sectionIt)
				end
				if i == 4 and i < digHeight - 20 then
					externalTorchLow(sectionIt)
				end
				if i == 4 and i >= digHeight - 20 then
					externalTorch(sectionIt)
				end
				if i < digHeight - 20 then
					placeDown("stoneBrick")
				elseif i == digHeight then
					placeDown("stoneBrick")
				else
					place("stoneBrick")
				end
				if i == digHeight-17 then
					internalTorch(sectionIt)
				end
			end
			moveBack()
			moveBack()
			robot.turnAround()
			place("stoneBrick")
			wallAccentTorch(sectionIt)
			digHeight = 0
			while robot.detect() == false or digHeight<21 or robot.detectDown() == false do
				moveDown()
				digHeight = digHeight + 1
				if digHeight == 1 then place("stoneBrick") end
			end
			for i=1, digHeight do
				moveUp()
				if i == digHeight - 20 then
					placeDown("stoneBrick")
					moveBack()
					placeDown("plank")
				end
				if (i == digHeight - 20 or i == digHeight - 19 or i == digHeight - 18) and sectionIt == 1 then
					robot.turnRight()
					dig()
					robot.turnLeft()
				end
				if (i == digHeight - 20 or i == digHeight - 19 or i == digHeight - 18) and sectionIt == sectionLength then
					robot.turnLeft()
					dig()
					robot.turnRight()
				end
				if i == digHeight - 4 then
					externalTorch(sectionIt)
				end
				if i == 4 and i < digHeight - 20 then
					externalTorchLow(sectionIt)
				end
				if i == 4 and i >= digHeight - 20 then
					externalTorch(sectionIt)
				end
				if i < digHeight - 20 then
					placeDown("stoneBrick")
				elseif i == digHeight then
					placeDown("stoneBrick")
				else
					place("stoneBrick")
				end
				if i == digHeight-10 then
					straightLogs(sectionIt)
				end
				if i == digHeight-17 then
					internalTorch(sectionIt)
				end
			end
			if sectionIt < sectionLength then
				robot.turnLeft()
				move()
				robot.turnLeft()
				move()
				move()
			else
				robot.turnLeft()
				for i=1, 6 do move() end
				robot.turnAround()
			end
		end
		-- return to south side for next tower sequence
		if towerArray[towerIt][4] == "N" then
			relocate("S","S")
		end
		if towerArray[towerIt][4] == "E" then
			relocate("W","S")
		end
		if towerArray[towerIt][4] == "S" then
			relocate("N","S")
		end
		if towerArray[towerIt][4] == "W" then
			relocate("E","S")
		end
	end
	-- Place diagonal wall section
	if towerArray[towerIt][4] =="NE" or towerArray[towerIt][4] == "SE" or towerArray[towerIt][4] == "SW" or towerArray[towerIt][4] == "NW" then
		-- do weird pre jut
		robot.turnRight()
		move()
		robot.turnLeft()
		move()
		robot.turnRight()
		place("stoneBrick")
		digHeight = 0
			while robot.detect() == false or robot.detectDown() == false or digHeight<21 do
				moveDown()
				digHeight = digHeight + 1
				if digHeight == 1 then place("stoneBrick") end
			end
			for i=1, digHeight do
				moveUp()
				placeDown("stoneBrick")
				if (i == digHeight - 20 or i == digHeight - 19 or i == digHeight - 18) then
					robot.turnAround()
					dig()
					robot.turnAround()
				end
			end
		robot.turnRight()
		move()
		robot.turnLeft()
		move()
		place("stoneBrick")
		digHeight = 0
		while robot.detect() == false or robot.detectDown() == false or digHeight<21 do
			moveDown()
			digHeight = digHeight + 1
			if digHeight == 1 then place("stoneBrick") end
		end
		for i=1, digHeight do
			moveUp()
			if i == digHeight - 20 then
				placeDown("stoneBrick")
				moveBack()
				placeDown("plank")
				moveBack()
				placeDown("plank")
				for i=1, 18 do
					moveUp()
				end
				for i=1, 18 do
					moveDown()
				end
				move()
			end
			if (i == digHeight - 20 or i == digHeight - 19 or i == digHeight - 18) then
					robot.turnAround()
					move()
					dig()
					robot.turnAround()
					move()
			end
			if i < digHeight - 20 then
				placeDown("stoneBrick")
			elseif i == digHeight then
				placeDown("stoneBrick")
			else
				place("stoneBrick")
			end
		end
		moveBack()
		placeDown("stoneBrick")
		robot.turnRight()
		move()
		robot.turnLeft()
		for i=1, 3 do move() end
		place("stoneBrick")
		moveUp()
		place("stoneBrick")
		moveDown()
		placeUp("torch")
		digHeight = 0
		while robot.detect() == false or robot.detectDown() == false or digHeight<21 do
			moveDown()
			digHeight = digHeight + 1
			if digHeight == 1 then place("stoneBrick") end
		end
		for i=1, digHeight do
			moveUp()
			if i == digHeight - 20 then
				placeDown("stoneBrick")
				moveBack()
				placeDown("plank")
				moveBack()
				placeDown("plank")
				moveBack()
				placeDown("plank")
				for i=1, 18 do
					moveUp()
					if robot.detect() then
						dig()
					end
				end
				robot.turnAround()
				for ix=1, 18 do
					if robot.detect() then
						dig()
					end
					moveDown()
					if (ix == 18 or ix == 17 or ix == 16) then
						move()
						dig()
						moveBack()
					end
				end
				move()
				placeDown("plank")
				robot.turnAround()
				for i=1, 3 do move() end
			end
			if i == digHeight - 4 then
				move()
				if robot.detect() == false then
					move()
					placeDown("torch")
					moveBack()
				end
				moveBack()
			end
			if i == 4 and i < digHeight - 20 then
				if robot.detect() == false then
					move()
					placeDown("torch")
					moveBack()
				end
			end
			if i == 4 and i >= digHeight - 20 then
				move()
				if robot.detect() == false then
					move()
					placeDown("torch")
					moveBack()
				end
				moveBack()
			end
			if i < digHeight - 20 then
				placeDown("stoneBrick")
			elseif i == digHeight then
				placeDown("stoneBrick")
			else
				place("stoneBrick")
			end
			if i == digHeight-17 then
				placeDown("torch")
			end
		end
		for i=1, 3 do
			moveBack()
			placeDown("stoneBrick")
		end
		robot.turnRight()
		move()
		robot.turnLeft()
		for i=1, 5 do
			move()
		end
		place("stoneBrick")
		moveUp()
		place("stoneBrick")
		moveDown()
		digHeight = 0
		while robot.detect() == false or robot.detectDown() == false or digHeight<21 do
			moveDown()
			digHeight = digHeight + 1
			if digHeight == 1 then place("stoneBrick") end
		end
		for i=1, digHeight do
			moveUp()
			if i == digHeight - 20 then
				placeDown("stoneBrick")
				moveBack()
				placeDown("plank")
				moveBack()
				placeDown("plank")
				moveBack()
				placeDown("plank")
				for i=1, 18 do
					moveUp()
					if robot.detect() then
						dig()
					end
				end
				robot.turnAround()
				for i=1, 18 do
					if robot.detect() then
						dig()
					end
					moveDown()
				end
				move()
				placeDown("plank")
				robot.turnAround()
				for i=1, 3 do move() end
			end
			if i < digHeight - 20 then
				placeDown("stoneBrick")
			elseif i == digHeight then
				placeDown("stoneBrick")
			else
				place("stoneBrick")
			end
		end
		for i=1, 3 do
			moveBack()
			placeDown("stoneBrick")
		end
		moveBack()
		moveBack()
		robot.turnAround()
		digHeight = 0
		while robot.detectDown() == false or digHeight<21 or testLeft() == false do
			moveDown()
			digHeight = digHeight + 1
		end
		for i=1, digHeight do
			moveUp()
			if i == digHeight - 20 then
				placeDown("stoneBrick")
				moveBack()
				placeDown("plank")
			end
			if i < digHeight - 20 then
				placeDown("stoneBrick")
			elseif i == digHeight then
				placeDown("stoneBrick")
			else
				place("stoneBrick")
			end
		end
		robot.turnLeft()
		move()
		robot.turnLeft()
		for i=1, 6 do
			move()
		end
		-- end weird pre jut
		-- do diagonal wall
		for sectionIt=1, sectionLength do
			if multipleOf(sectionIt, sectionLength, sectionIncline) then
				diagonalSlabs(sectionIncline)
				if sectionIncline < 0 then
					moveDown()
				end
				if sectionIncline > 0 then
					moveUp()
				end
			end
			place("stoneBrick")
			diagonalEscapeHatch(sectionLength, sectionIt)
			diagWallAccentTorch(sectionIt)
			digHeight = 0
			while robot.detect() == false or robot.detectDown() == false or digHeight<21 do
				moveDown()
				digHeight = digHeight + 1
				if digHeight == 1 then place("stoneBrick") end
			end
			for i=1, digHeight do
				moveUp()
				if i == digHeight - 20 then
					placeDown("stoneBrick")
					moveBack()
					placeDown("plank")
					moveBack()
					placeDown("plank")
					moveBack()
					placeDown("plank")
					for i=1, 18 do
						moveUp()
						if robot.detect() then
							dig()
						end
					end
					robot.turnAround()
					for i=1, 18 do
						if robot.detect() then
							dig()
						end
						moveDown()
					end
					move()
					placeDown("plank")
					robot.turnAround()
					for i=1, 3 do move() end
				end
				if i == digHeight - 4 then
					diagExternalTorch(sectionIt)
				end
				if i == 4 and i < digHeight - 20 then
					diagExternalTorchLow(sectionIt)
				end
				if i == 4 and i >= digHeight - 20 then
					diagExternalTorch(sectionIt)
				end
				if i < digHeight - 20 then
					placeDown("stoneBrick")
				elseif i == digHeight then
					placeDown("stoneBrick")
				else
					place("stoneBrick")
				end
				if i == digHeight-17 then
					diagInternalTorch(sectionIt)
				end
			end
			for i=1, 3 do
				moveBack()
				placeDown("stoneBrick")
			end
			moveBack()
			moveBack()
			robot.turnAround()
			place("stoneBrick")
			diagWallAccentTorch(sectionIt)
			digHeight = 0
			while robot.detect() == false or robot.detectDown() == false or digHeight<21 do
				moveDown()
				digHeight = digHeight + 1
				if digHeight == 1 then place("stoneBrick") end
			end
			for i=1, digHeight do
				moveUp()
				if i == digHeight - 20 then
					placeDown("stoneBrick")
					moveBack()
					placeDown("plank")
				end
				if i == digHeight - 4 then
					diagExternalTorch(sectionIt)
				end
				if i == 4 and i < digHeight - 20 then
					diagExternalTorchLow(sectionIt)
				end
				if i == 4 and i >= digHeight - 20 then
					diagExternalTorch(sectionIt)
				end
				if i < digHeight - 20 then
					placeDown("stoneBrick")
				elseif i == digHeight then
					placeDown("stoneBrick")
				else
					place("stoneBrick")
				end
				if i == digHeight-10 then
					diagonalLogs(sectionIt)
				end
				if i == digHeight-17 then
					diagInternalTorch(sectionIt)
				end
			end
			if sectionIt < sectionLength then
				robot.turnLeft()
				move()
				robot.turnLeft()
				for i=1, 6 do
					move()
				end
			end
		end
		-- do weird post jut
		robot.turnAround()
        for i=1, 3 do
            move()
        end
        robot.turnRight()
        for i=1, 4 do
            move()
        end
        robot.turnRight()
		place("stoneBrick")
		digHeight = 0
			while robot.detect() == false or robot.detectDown() == false or digHeight<21 do
				moveDown()
				digHeight = digHeight + 1
				if digHeight == 1 then place("stoneBrick") end
			end
			for i=1, digHeight do
				moveUp()
				placeDown("stoneBrick")
				if (i == digHeight - 20 or i == digHeight - 19 or i == digHeight - 18) then
					robot.turnAround()
					dig()
					robot.turnAround()
				end
			end
		robot.turnRight()
		move()
		robot.turnLeft()
		move()
		place("stoneBrick")
		digHeight = 0
		while robot.detect() == false or robot.detectDown() == false or digHeight<21 do
			moveDown()
			digHeight = digHeight + 1
			if digHeight == 1 then place("stoneBrick") end
		end
		for i=1, digHeight do
			moveUp()
			if i == digHeight - 20 then
				placeDown("stoneBrick")
				moveBack()
				placeDown("plank")
				moveBack()
				placeDown("plank")
				for i=1, 18 do
					moveUp()
				end
				for i=1, 18 do
					moveDown()
				end
				move()
			end
			if (i == digHeight - 20 or i == digHeight - 19 or i == digHeight - 18) then
					robot.turnAround()
					move()
					dig()
					robot.turnAround()
					move()
			end
			if i < digHeight - 20 then
				placeDown("stoneBrick")
			elseif i == digHeight then
				placeDown("stoneBrick")
			else
				place("stoneBrick")
			end
		end
		moveBack()
		placeDown("stoneBrick")
		robot.turnRight()
		move()
		robot.turnLeft()
		for i=1, 3 do move() end
		place("stoneBrick")
		moveUp()
		place("stoneBrick")
		moveDown()
		placeUp("torch")
		digHeight = 0
		while robot.detect() == false or robot.detectDown() == false or digHeight<21 do
			moveDown()
			digHeight = digHeight + 1
			if digHeight == 1 then place("stoneBrick") end
		end
		for i=1, digHeight do
			moveUp()
			if i == digHeight - 20 then
				placeDown("stoneBrick")
				moveBack()
				placeDown("plank")
				moveBack()
				placeDown("plank")
				moveBack()
				placeDown("plank")
				for i=1, 18 do
					moveUp()
					if robot.detect() then
						dig()
					end
				end
				robot.turnAround()
				for ix=1, 18 do
					if robot.detect() then
						dig()
					end
					moveDown()
					if (ix == 18 or ix == 17 or ix == 16) then
						move()
						dig()
						moveBack()
					end
				end
				move()
				placeDown("plank")
				robot.turnAround()
				for i=1, 3 do move() end
			end
			if i == digHeight - 4 then
				move()
				if robot.detect() == false then
					move()
					placeDown("torch")
					moveBack()
				end
				moveBack()
			end
			if i == 4 and i < digHeight - 20 then
				if robot.detect() == false then
					move()
					placeDown("torch")
					moveBack()
				end
			end
			if i == 4 and i >= digHeight - 20 then
				move()
				if robot.detect() == false then
					move()
					placeDown("torch")
					moveBack()
				end
				moveBack()
			end
			if i < digHeight - 20 then
				placeDown("stoneBrick")
			elseif i == digHeight then
				placeDown("stoneBrick")
			else
				place("stoneBrick")
			end
			if i == digHeight-17 then
				placeDown("torch")
			end
		end
		for i=1, 3 do
			moveBack()
			placeDown("stoneBrick")
		end
		robot.turnRight()
		move()
		robot.turnLeft()
		for i=1, 5 do
			move()
		end
		place("stoneBrick")
		moveUp()
		place("stoneBrick")
		moveDown()
		digHeight = 0
		while robot.detect() == false or robot.detectDown() == false or digHeight<21 do
			moveDown()
			digHeight = digHeight + 1
			if digHeight == 1 then place("stoneBrick") end
		end
		for i=1, digHeight do
			moveUp()
			if i == digHeight - 20 then
				placeDown("stoneBrick")
				moveBack()
				placeDown("plank")
				moveBack()
				placeDown("plank")
				moveBack()
				placeDown("plank")
				for i=1, 18 do
					moveUp()
					if robot.detect() then
						dig()
					end
				end
				robot.turnAround()
				for i=1, 18 do
					if robot.detect() then
						dig()
					end
					moveDown()
				end
				move()
				placeDown("plank")
				robot.turnAround()
				for i=1, 3 do move() end
			end
			if i < digHeight - 20 then
				placeDown("stoneBrick")
			elseif i == digHeight then
				placeDown("stoneBrick")
			else
				place("stoneBrick")
			end
		end
		for i=1, 3 do
			moveBack()
			placeDown("stoneBrick")
		end
		moveBack()
		moveBack()
		robot.turnAround()
		digHeight = 0
		while robot.detectDown() == false or digHeight<21 or testLeft() == false do
			moveDown()
			digHeight = digHeight + 1
		end
		for i=1, digHeight do
			moveUp()
			if i == digHeight - 20 then
				placeDown("stoneBrick")
				moveBack()
				placeDown("plank")
			end
			if i < digHeight - 20 then
				placeDown("stoneBrick")
			elseif i == digHeight then
				placeDown("stoneBrick")
			else
				place("stoneBrick")
			end
		end
		-- end weird post jut
		-- return to south side for next tower sequence
		robot.turnRight()
		for i=1, 5 do
			move()
		end
		robot.turnLeft()
		for i=1, 4 do
			move()
		end
		robot.turnLeft() -- we back on side facing out
		if towerArray[towerIt][4] == "NE" then
			relocate("W","S")
		end
		if towerArray[towerIt][4] == "SE" then
			relocate("N","S")
		end
		if towerArray[towerIt][4] == "SW" then
			relocate("E","S")
		end
		if towerArray[towerIt][4] == "NW" then
			relocate("S","S")
		end
	end
	while robot.detectDown() == false do moveDown() end
	robot.turnAround()
end
computer.shutdown()
