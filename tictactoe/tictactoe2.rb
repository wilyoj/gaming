#!/usr/bin/ruby
#
# A Ruby Tic Tac Toe Implementaion
#
# Command line version for one player, playing 
# against the computer

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

def getcomputermove(board,player)
  # Naive player, random choice
  if player == 1
    mover = "X"
  else
    mover = "O"
  end
  stop = 0
  begin
    x = ((10000*rand).floor)%3
    y = ((10000*rand).floor)%3
    if board[x][y] == -1
      board[x][y] = player
      stop = 1
    end
  end while (stop !=1)
return 0
end

def gethumanmove(board,player)
  if player == 1
    mover = "X"
  else
    mover = "O"
  end
  puts " Wewe ni mchezaji #{mover}, ni zamu yako sasa "
  puts " x kwanza, y pili"
  puts "[ (0,0) (1,0) (2,0) ]"
  puts "[ (0,1) (1,1) (2,1) ]"
  puts "[ (0,2) (1,2) (2,2) ]"
  puts "Andika x"
  x = 3
  begin
    x = gets.chomp.to_i
    if ((x!=0) and (x!=1) and (x!=2))
      puts "Tafadhali, andika 0,1 au 2."
    end
  end while ((x!= 0) and (x!=1) and (x!=2)) 
  puts "Andika y"
  begin
    y = gets.chomp.to_i
    if ((y!=0) and (y!=1) and (y!=2))
      puts "Tafadhali, andika 0,1 au 2."
    end
  end while ((y!=0) and (y!=1) and (y!=2))

  if board[x][y] == -1
    board[x][y] = player
    return 0
  else
    puts "Haiwezekana"
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
# Variable to indicate if human starts first
start = "O"
begin 
  puts "Unataka kuanza (N - ndio, H - hapana )?"
  start = gets.chomp.to_s
  if ((start != "N") and (start !="H"))
    puts "Tafadhali andika N kuanza au H kompyuta ianze"
  end
end while ((start !="N") and (start !="H"))

if (start=="N")
  computer=1
  human=0
else
  computer=0
  human=1
end

begin

  puts "Bao"
  print_board(board)
  player = move%2
  if player == human
    movesuccess = 1
    begin
      movesuccess =  gethumanmove(board,player)
    end while movesuccess == 1
  else
    movesuccess =  getcomputermove(board,player)
  end
  endgame = checkendgame(board)
  if ((move == 8) and (endgame == -1))
    endgame = 2
  end
  move +=1

end while endgame ==-1

# Show the final configuration
#
print_board(board)

if (endgame == human)
  puts "Umeshinda"
elsif (endgame == computer)
  puts "Umeshindwa"
else
  puts "Hakuna mshindi."
end
puts "Asante kwa kucheza! Cheza tena!"
