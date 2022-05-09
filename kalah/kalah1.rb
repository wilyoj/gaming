#!/usr/bin/ruby
#
# A Ruby Kalah Implementaion
#
# Command line version for two players on the same computer

def boardtochar(board)
  boards=Array.new()
  (0..13).each do |i|
    if board[i] < 10
      boards[i] = " "+board[i].to_s
    else
      boards[i] = board[i].to_s
    end
  end
  return boards
end

def printboard(board)
  # The board is represented as a
  # one dimensional array
  #        Player A
  #  | 5 | 4 | 3 | 2 | 1 | 0 |
  # 6|---|---|---|---|---|---|13
  #  | 7 | 8 | 9 | 10| 11| 12|
  #        Player B
  boards = boardtochar(board)

  puts ("          Mchezaji A ")
  puts ("A | #{boards[5]} | #{boards[4]} | #{boards[3]} | #{boards[2]} | #{boards[1]} | #{boards[0]} |")
  puts ("#{boards[6]}|----|----|----|----|----|----|#{boards[13]} ")
  puts ("  | #{boards[7]} | #{boards[8]} | #{boards[9]} | #{boards[10]} | #{boards[11]} | #{boards[12]} |B")
  puts ("          Mchezaji B ")
end

def getmove(board,player)
   inputerror=1
   seeds=0
   # Get a valid input move
   begin 
     puts ("Chagua mfuko mchezaji #{player}")
     if player == "A"
       puts ("  |  5 |  4 |  3 |  2 |  1 |  0 |")
     else
       puts ("  |  0 |  1 |  2 |  3 |  4 |  5 |")
     end
     x = gets.chomp.to_i
     if ((x >= 0) and (x <=5))
       if ((player=="A") and (board[x]>0))
         inputerror=0
         seeds=board[x]
         board[x]=0
       elsif ((player=="B") and (board[7+x]>0))
         inputerror=0
         seeds=board[7+x]
         board[7+x]=0
       else
         puts("Tafadhali chagua shimo ina mbegu")
       end
     else
       puts("Tafadhli, andika nambari kutoka 0 hadhi 5")
     end
   end while inputerror==1

   # Place seeds in holes
   hole=0
   (0..(seeds-1)).each do |i|
     if player == "A"
       hole=x+i+1
       if hole==13
         hole+=1
       end
       hole=hole%14
     else
       hole=x+i+7+1
       if hole == 6
         hole+=1
       end
       hole=hole%14
     end
     board[hole]+=1
   end
   # Determine next player and check
   # if a capture has occurred
   oppositehole = 12-hole
   if ((hole!=6) and (player=="A"))
     player="B"
     if ((board[hole]==1) and (hole<=6))
       board[6]+=board[oppositehole]
       board[6]+=1
       board[oppositehole]=0
       board[hole]=0
     end
   elsif ((hole!=13) and (player=="B"))
     player="A"
     if ((board[hole]==1) and (hole>=7))
       board[13]+=board[oppositehole]
       board[13]+=1
       board[oppositehole]=0
       board[hole]=0
     end
   end
   return board, player
end

def checkendgame(board)

  result=-1
  azeros=0
  bzeros=0
  # count number of empty pockets for each player
  (0..5).each do |i|
    if board[i]==0
      azeros+=1
    end
    if board[i+7]==0
      bzeros+=1
    end
  end
  # If one player has empty pockets, 
  # put remaining seeds in other players store
  # then determine if there is a winner or if 
  # it is a draw
  if ((azeros == 6) or (bzeros == 6))
    if azeros == 6
      (7..12).each do |i|
        board[13]+=board[i]
        board[i]=0
      end
    else
      (0..5).each do |i|
        board[6]+=board[i]
        board[i]=0
      end
    end
    if board[7] > board [13]
      # A wins
      result = 0
    elsif board[13] > board[7]
      # B wins
      result = 1
    else
      # draw
      result = 2
    end
  end
  return board, result
end

# Main program
#
# Setup inital board
# The board is represented as a
# one dimensional array
#        Player A
#  | 5 | 4 | 3 | 2 | 1 | 0 |
# 6|---|---|---|---|---|---|13
#  | 7 | 8 | 9 | 10| 11| 12|
#        Player B
#      0 1 2 3 4 5 6 7 8 9 10 11 12 13
board=[4,4,4,4,4,4,0,4,4,4, 4, 4, 4,0]

# Variable to keep track of winner and whether game has ended
endgame=-1

# Starting player
player="A"

# Main Game Loop
move = 0
begin

  puts "Bao "
  printboard(board)
  board,player =  getmove(board,player)
  board, endgame = checkendgame(board)
  move +=1

end while endgame ==-1

# Show the final configuration
printboard(board)

if endgame == 0
  puts "Mshindi ni A"
elsif endgame == 1
  puts "Mshindi ni B"
else
  puts "Hakuna mshindi."
end
puts "Asante kwa kucheza!"

