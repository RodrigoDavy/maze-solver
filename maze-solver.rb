filename = "maze.txt"

def create_maze(filename) #Creates maze matrix based on the filename variable
	maze = []
	n = 0

	File.open(filename).each do |line|
		next if line.include? "#"

		valid_row = false
		row = []
		temp = line.split(" ")

		temp.each do |word|
			if word=="0"
				row += [0]
				valid_row = true
			elsif word=="1"
				row += [1]
				valid_row = true
			end
		end

		if valid_row
			maze[n] = row
			n += 1
		end
	end

	return maze
end

def print_maze(maze)
	maze.each { |i|
		print "["
		i.each { |j|
			print "#{j} "
		}
	print "]\n"
	}
	puts ""
end

def can_move(pos,maze,visited)

	#Check if position exists within the maze matrix
	return false unless (pos[0]>=0 && pos[0]<maze.length && pos[1]>=0 && pos[1]<maze[0].length)

	#Check if position has already been visited before
	return false if visited[pos[0]][pos[1]] || (maze[pos[0]][pos[1]] == 1)

	return true
end

def next_pos(pos,maze,visited)

	return false unless can_move(pos,maze,visited)
	
	visited[pos[0]][pos[1]] = true

	#Checks if position corresponds to the exit, which is the bottom right corner of the matrix
	if pos == [maze.length - 1, maze[0].length - 1]
		maze[pos[0]][pos[1]] = "."
		return true 
	end
	
	new_pos = [pos[0]+1,pos[1]] #down

	if next_pos(new_pos,maze,visited)
		maze[pos[0]][pos[1]] = "."
		return true 
	end
	
	new_pos = [pos[0],pos[1]+1] #right

	if next_pos(new_pos,maze,visited)
		maze[pos[0]][pos[1]] = "."
		return true 
	end

	new_pos = [pos[0],pos[1]-1] #left

	if next_pos(new_pos,maze,visited)
		maze[pos[0]][pos[1]] = "."
		return true 
	end

	new_pos = [pos[0]-1,pos[1]] #up

	if next_pos(new_pos,maze,visited)
		maze[pos[0]][pos[1]] = "."
		return true 
	end
end

maze = create_maze(filename)

visited = Array.new(maze.length) { Array.new(maze[0].length,false) }

pos = [0,0]

print "\n   El laberinto\n"
print "------------------\n"
print_maze(maze)

if next_pos(pos,maze,visited)
	print "¡Existe un camino hacia el fín de este laberinto!\n\n"

	print_maze(maze)
else
	puts "No existe un camino hacia el fín de este laberinto."
end
