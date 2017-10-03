playerList 	= []
playerName 	= ' '
playerNumber 	= 0
playerAmount	= 0
diceListArray 	= []
diceListHash	= {}
diceAmount 	= {}
diceValue 	= 0
rolled		= []
gameover	= false
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
		player.push rand(6)
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
	playerAmount = (playerList.length)
	puts 'Please enter the name of player ' + (playerAmount.+1).to_s + ' or press enter to continue.'
	playerName = gets.chomp
	if playerName == ''
		puts "\e[H\e[2J"
		break
	end
	playerList.push playerName
	diceAmount[playerName] = 5
end
diceAmount.each do |player, amount|
	rolled = (roll amount)
	diceListHash[player] = rolled
	diceListArray.concat(rolled)
end
puts diceListArray.sort.to_s
while gameover == false
	challenged = false
	player = playerList[i]
	cup = diceListHash[player]
	puts playerList[i]
	turn player, cup
	loop do
		puts 'Please enter the value of the first bid'
		value = gets.to_i
		if value > 0 && value < 7
			puts 'Please enter the number of dice in your bid'
			amount = gets.to_i
			puts amount
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
		i = (i+1)%playerAmount
		player = playerList[i]
		cup = diceListHash[player]
		puts playerList[i]
		turn player, cup
		loop do
			puts 'The current bid is ' + currentAmount.to_s + ' ' + currentValue.to_s + '\'s'
			puts 'Please enter the value of your bid or type 0 to challenge'
			value = gets.to_i
			puts 'the current value is ' + value.to_s
			if value > 7
				puts 'That is too high, please enter a value between ' + currentValue + ' and 6'
			elsif value >  currentValue
				puts 'Please enter the amount of dice'
				amount = gets.to_i
				if amount >= currentAmount
					puts 'thank you'
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
					puts 'thank you'
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
				puts 'Player has challenged ' + currentAmount.to_s + ' ' + currentValue.to_s + '\'s.'
				challenged = true
				break
			end
			gets = whocares
		end
		if challenged == true
			break
		end
	end
		puts diceListArray.sort
		diceListHash.each do |player, rol|
			puts player + ' has ' + rol.to_s
		end
end



diceListHash.each do |player, rol|
	puts player + ' has ' + rol.to_s
end
puts diceListArray.join(', ')
