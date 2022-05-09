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

def getminmaxvalue(board,player,computer,human,move)
  # The minmax value is obtained by the computer
  # First all empty positions are enumerated
  # Each empty position is examined to see if 
  # it will lead to an end state (win or draw).
  # If not, an empty position is choosen 
  # and the program then checks whether any 
  # of these positions leads to an end game.
  # The process is continued for any positions 
  # that do not lead to an end game. Once a
  # end game position has been found, it is 
  # given a score, eg +10 for computer win
  # 0 for a draw and -10 for human win. To
  # prefer rapid wins, each extra move from
  # the current game state to the end game is 
  # penalized by -1. At each decision step,
  # the program will choose to maximize its
  # score subject to human minimizing its 
  # score
  #
  # count number of empty spaces
  #
  movei=-1
  movej=-1
  spaces=0
  spacei=Array.new()
  spacej=Array.new()
  score=Array.new()
  (0..2).each do |j|
    (0..2).each do |i|
      if board[i][j] == -1
        spacei[spaces]=i
        spacej[spaces]=j
        spaces+=1
      end
    end
  end
  if spaces > 0
    # Get score for each empty space 
    (0..(spaces-1)).each do |count|
      board[spacei[count]][spacej[count]] = player
      # if there is a winner, find out the score
      # otherwise fill an extra position
      winner = checkendgame(board)
      if winner == human
         score[count]=-10-move
      elsif winner == computer
         score[count]=10-move
      else
        player = (player-1)*(player-1) 
        move+=1
        score[count], tempi, tempj = getminmaxvalue(board,player,computer,human,move)   
        player = (player-1)*(player-1)
        move-=1
      end
      board[spacei[count]][spacej[count]] = -1
    end
    if player==computer
      value=-100
      # Find highest score for computer
      (0..(spaces-1)).each do |count|
        if score[count] > value
          value = score[count]
          movei = spacei[count]
          movej = spacej[count]
        end
      end
    else
      # Finding lowest score for human
      value=100
      (0..(spaces-1)).each do |count|
        if score[count] < value
          value = score[count]
          movei = spacei[count]
          movej = spacej[count]
        end
      end
    end
  else
    # if the board is full determine
    # the winner
    winner = checkendgame(board)
    if winner == human
      value = -10-move
    elsif winner == computer
      value = 10-move
    else
      value = -move
    end
    movei = -1
    movej = -1
  end
  return value, movei, movej
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
move = 0
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
  board[1][1] = computer
  move+=1
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
    puts "Kompyuta inafikiri"
    value, movei, movej = getminmaxvalue(board,player,computer,human,move)
    puts "Kompyuta imemaliza kufikiri"
    board[movei][movej] = player
    movesuccess = 1
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
