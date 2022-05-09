#!/usr/bin/ruby
#
# A Ruby Tic Tac Toe Implementaion
#
# Command line version for two players on the same computer

def print_board(board)
  (0..2).each do |j|
    (0..2).each do |i|
     if board[i][j] == 0 
       print "O "
     elsif board[i][j] == 1
       print "X "
     else
        print "_ "
     end
   end
   print "\n"
end

  return
end

def getmove(board,player)
  if player == 1
    mover = "X"
  else
    mover = "O"
  end
  puts " Player #{mover} should indicate the co-ordinates of their next move"
  puts " x first, y second"
  puts "[ (0,0) (1,0) (2,0) ]"
  puts "[ (0,1) (1,1) (2,1) ]"
  puts "[ (0,2) (1,2) (2,2) ]"
  puts "Get x coordinate"
  x = gets.chomp.to_i
  puts "Get y coordinate"
  y = gets.chomp.to_i

  if board[x][y] == -1
    board[x][y] = player
    return 0
  else
    puts "Invalid move"
    return 1
  end
end

def checkendgame(board)
  endgame=-1
  # Left to right, top to bottom diagonal
  if ((board[0][0]==board[1][1]) and (board[0][0]==board[2][2]) and (board[0][0]!=-1))
 endgame=board[0][0]
 end
 # Right to left, top to bottom diagonal
  if ((board[0][2]==board[1][1]) and (board[0][2]==board[2][0]) and (board[0][2]!=-1))
 endgame=board[0][2]
 end
  # Rows
  (0..2).each do |j|
    if ((board[0][j]==board[1][j]) and (board[0][j]==board[2][j]) and (board[0][j]!=-1))
      endgame=board[0][j]
    end
  end
  # Columns
  (0..2).each do |i|
    if ((board[i][0]==board[i][1]) and (board[i][0]==board[i][2]) and (board[i][0]!=-1))
      endgame=board[i][0]
    end
  end
  return endgame
end

# Main program
#
# Setup inital board
# -1 empty space
# 0 player O
# 1 player X
board=[[-1,-1,-1],
       [-1,-1,-1],
       [-1,-1,-1]]

# Variable to keep track of winner and whether game has ended
endgame=-1 

# Main Game Loop
#
move =0
begin

  puts "Board "
  print_board(board)
  player = move%2
  movesuccess = 1
  begin
    movesuccess =  getmove(board,player)
  end while movesuccess == 1
  endgame = checkendgame(board)
  if ((move == 8) and endgame == -1)
  endgame = 2
  end
  move +=1

end while endgame ==-1

# Show the final configuration
#
print_board(board)

if endgame == 0
  puts "Mshindi ni O"
elsif endgame == 1
  puts "Mshindi ni X"
else
  puts "Hakuna mshindi."
end
puts "Asante kwa kucheza!"