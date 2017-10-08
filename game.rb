lastPlayer	= ''
playerList 	= []
playerName 	= ' '
playerNumber 	= 0
playerAmount	= 0
dicenumber	= 0
diceListArray 	= []
diceListHash	= {}
diceAmount 	= {}
diceValue 	= 0
finalDice	= 0
rolled		= []
game		= true
challenged 	= false
value		= 0
currentValue	= 1
currentAmount	= 0
round		= 0
turn		= 0
i 		= 0
whocares	= ''
def roll diceAmount 
	player = []
	diceAmount.times do
		player.push rand(6).+ 1
	end
	player.sort
end
def turn player, dice
	puts 'It is now ' + player + '\'s turn'
	puts 'Please press enter to continue'
	gets
	puts "\e[H\e[2J"
	puts 'Hello ' + player + ' you have rolled ' + dice.to_s + '.'
end

puts 'Welcome to Lier\'s Dice'
while playerAmount <4
	puts 'Please enter the name of player ' + (playerAmount.+1).to_s + ' or press enter to continue.'
	playerName = gets.chomp
	if playerName == ''
		puts "\e[H\e[2J"
		break
	end
	playerList.push playerName
	puts 'Please enter the number of dice for ' + playerName
	dicenumber = gets.to_i
	diceAmount[playerName] = dicenumber
	playerAmount = (playerList.length)
end
while game
	diceListArray = []
	diceAmount.each do |player, amount|
		rolled = (roll amount)
		diceListHash[player] = rolled
		diceListArray.concat(rolled)
	end
	player = playerList[i]
	firstPlayerNumber = i
	cup = diceListHash[player]
	puts 'Round ' + round.to_s + ' start!'
	round = round+1
	turn player, cup
	loop do
		puts 'Please enter the value of the first bid'
		value = gets.to_i
		if value > 0 && value < 7
			puts 'Please enter the number of dice in your bid'
			amount = gets.to_i
			if amount > 0
				puts 'thank you'
				currentValue = value
				currentAmount = amount
				whocares = gets
				puts "\e[H\e[2J"
				break
			else
				puts 'That is not a legitimate bid'
			end
		end
	end
	loop do
		lastPlayer = player
		i = (i+1)%playerAmount
		player = playerList[i]
		cup = diceListHash[player]
		puts playerList[i]
		turn player, cup
		loop do
			puts 'The current bid is ' + currentAmount.to_s + ' ' + currentValue.to_s + '\'s'
			puts 'Please enter the value of your bid or press enter to challenge' 
			value = gets.to_i
			if value > 7
				puts 'That is too high, please enter a value between ' + currentValue + ' and 6'
			elsif value >  currentValue
				puts 'Please enter the amount of dice'
				amount = gets.to_i
				if amount >= currentAmount
					currentValue = value
					currentAmount = amount
					whocares = gets
					puts "\e[H\e[2J"
					break
				else
					puts "\e[H\e[2J"
					puts 'That is not a legitimate bid'
				end
			elsif value >= currentValue
				puts 'Please enter the amount of dice'
				amount = gets.to_i
				if amount > currentAmount
					currentValue = value
					currentAmount = amount
					whocares = gets
					puts "\e[H\e[2J"
					break
				else
					puts "\e[H\e[2J"
					puts 'That is not a legitimate bid'
				end
			elsif value == 0
				challenged = true
				break
			end
			gets = whocares
		end
		if challenged == true
			puts "\e[H\e[2J"
			puts player + ' has challenged ' + lastPlayer
			whocares = gets
			diceListHash.each do |playir, rol|
				puts playir + ' has ' + rol.to_s
			end
			finalDice = diceListArray.count(currentValue) 
			if currentValue != 1
				finalDice = finalDice + diceListArray.count(0)
			end
			puts 'The last bid is ' + currentAmount.to_s + ' ' + currentValue.to_s + '\'s'
			puts 'There are ' + finalDice.to_s + ' ' + currentValue.to_s + '\'s'
			puts 'finalDice is ' + finalDice.to_s + 'currentAmount is' + currentAmount.to_s
			if finalDice < currentAmount
				puts player +' has won the challenge.'
				diceAmount[lastPlayer] = diceAmount[lastPlayer] - 1
				i = (i - 1)%playerAmount
				if diceAmount[lastPlayer] == 0
					puts lastPlayer + ' is out'
					playerList.delete(player)
					playerAmount = (playerAmount) - 1
				end
			else
				puts player + ' has lost the challenge.'
				diceAmount[player] = (diceAmount[player]) - 1
				puts diceAmount[player]
				if diceAmount[player] == 0
					puts player + ' is out'
					playerList.delete(player)
					playerAmount = playerAmount - 1
					i = i%playerAmount
				end
			end
			if playerAmount == 1
				puts playerList.to_s + ' has won.'
				game = false
			end
			challenged = false
			break
		end
	end
end
