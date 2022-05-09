#!/usr/bin/ruby
#
# A Ruby Bao ya Kiswahili Implementaion
#
# Command line version for two players on the same computer

def boardtochar(board)
  boards=Array.new(6){Array.new(8)}
  for i in 0..7 do
    for j in 0..5 do
      if board[j][i] < 10
        boards[j][i] = " "+(board[j][i]).to_s
      else
        boards[j][i] = (board[j][i]).to_s
      end
    end
  end
  return boards
end

def printboard(board)
  # The board is represented as a
  # two dimensional array
  #                  Player North
  #                        0,0
  #  |  1,0 | 1,1 | 1,2 | 1,3 | 1,4 | 1,5 | 1,6 | 1,7 |
  #  | &2,0 |%2,1 | 2,2 |#2,3 | 2,4 | 2,5 |%2,6 |&2,7 |
  #  |------|-----|-----|-----|-----|-----|-----|-----|
  #  | &3,0 |%3,1 | 3,2 | 3,3 |#3,4 | 3,5 |%3,6 |&3,7 |
  #  |  4,0 | 4,1 | 4,2 | 4,3 | 4,4 | 4,5 | 4,6 | 4,7 |
  #                        5,0
  #                     Player South

  boards=boardtochar(board)

  puts ("                Mchezaji North  ")
  puts ("                       #{boards[0][0]} ")
  puts (" | #{boards[1][0]} | #{boards[1][1]} | #{boards[1][2]} | #{boards[1][3]} | #{boards[1][4]} | #{boards[1][5]} | #{boards[1][6]} | #{boards[1][7]} |")
  puts (" |&#{boards[2][0]} |%#{boards[2][1]} | #{boards[2][2]} |##{boards[2][3]} | #{boards[2][4]} | #{boards[2][5]} |%#{boards[2][6]} |&#{boards[2][7]} |")
  puts (" |----|----|----|----|----|----|----|----| ")
  puts (" |&#{boards[3][0]} |%#{boards[3][1]} | #{boards[3][2]} | #{boards[3][3]} |##{boards[3][4]} | #{boards[3][5]} |%#{boards[3][6]} |&#{boards[3][7]} |")
  puts (" | #{boards[4][0]} | #{boards[4][1]} | #{boards[4][2]} | #{boards[4][3]} | #{boards[4][4]} | #{boards[4][5]} | #{boards[4][6]} | #{boards[4][7]} |")
  puts ("                          #{boards[5][0]} ")
  puts ("                    Mchezaji South ")
  puts (" |-0--|-1--|-2--|-3--|-4--|-5--|-6--|-7--| ")
end

def getkunamuamove(board,player)

  # Check if entered numbers are reasonable
  # then check if there are any points where
  # capture can be done, if so make sure one
  # of these is choosen
  invalidchoice = -1
  begin
    validchoices=Array.new()
    count=0
    puts ("Mchezaji ni #{player}, chaguo shimo ")
    puts ("kutoka x=0 hadhi x=7")
    # Display valid choices
    puts ("Unaweza kuchagua kutoka ")
    if (player=="North") 
      #Check if can capture
      for i in 0 ..6 do
        if ((board[2][i]!=0) and (board[3][i]!=0))
          print " #{i}"
          validchoices[count]=i
          count+=1
        end
      end
      # if cannot capture, check other choices
      if validchoices.length == 0
        for i in 0..6 do
          if (board[2][i]!=0)
            print " #{i}"
            validchoices[count]=i
            count+=1
          end
        end
      end
    else
      # Player South
      # Check if can capture
      for i in 0..6 do
        if ((board[3][i]!=0) and (board[2][i]!=0))
          print " #{i}"
          validchoices[count]=i
          count+=1
        end
      end
      # If cannot capture, check other valid choices
      for i in 0..6 do
        if board[3][i]!=0
          print " #{i}"
          validchoices[count]=i
          count+=1
        end
      end
    end
    print "\n"
    puts("#{validchoices}")
    x = gets.chomp.to_i
    if validchoices.include? x
      # a valid choice
      invalidchoice=0
    else
      # invalid choice
      puts ("Umechagua vibaya, jaribu tena!")
    end
  end while invalidchoice == -1

  return x
end

def makekunamuamove(board,player,x)

  # Check if can capture
  if player=="South"
    if board[2][x]!=0
      # can capture
      capture=board[2][x]
      board[2][x]=0
      seeds=capture+1+board[3][x]
      board[3][x]=0
      # remove seed from store
      board[6][0]-=1
      # determine if can make a choice
      # of where to sow from
      # Check if kichwa or kimbi
      if [0,1,6,7].include? x
        # if so, indicate where to sow from
        #
        if x==0 or x==1
          sow=0
        else
          sow=7
        end
        board=sowkunamua(board,player,seeds,sow)
      else
        # ask if wants to sow from left or right
        sow==-1
        do
          puts("Unataka kuanza kupanda kutoka 0 au 7?")
          sow=gets.chomp.to_i
          if ((sow==0) or (sow==7))
            board=sowkunamua(board,player,seeds,sow)
          else
            puts("Tafadhali andika 0 au 7 tu!")
          end
        end while ((sow!=0) or (sow!=7))
      end
    else
      # cannot capture
      board[3][x]+=1
      board[5][0]-=1
    end
    #player is North
  else
    if board[3][x]!=0
      # can capture
      capture=board[3][x]
      board[3][x]=0
      seeds=capture+1+board[2][x]
      board[2][x]=0
      # determine if can make a choice
      # of where to sow from
      # check if kichwa or kimbi
      if [0,1,6,7].include? x
        # if so, indicate where to sow from
        if x==0 or x==1
          sow=0
        else
          sow=1
        end
        board=sowkunamua(board,player,seeds,sow)
      else
        # ask if wants to sow from left or right
        sow==-1
        do
          puts("Unataka kuanza kupanda kutoka 0 au 7?")
          sow=gets.chomp.to_i
          if ((sow==0) or (sow==7))
            board=sowkunamua(board,player,seeds,sow)
          else
            puts("Tafadhali andika 0 au 7 tu!")
          end
        end while ((sow!=0) or (sow!=7))
      end
    else
      # cannot capture
      board[2][x]+=1
      board[0][0]-=1
    end
  end
  # Change player
  if player=="South"
    player="North"
  else
    player="South"
  end
  return board, player
end

def sowkunamua(board,player,seeds,sow)
  #                  Player North
  #                        0,0
  #  |  1,0 | 1,1 | 1,2 | 1,3 | 1,4 | 1,5 | 1,6 | 1,7 |
  #  | &2,0 |%2,1 | 2,2 |#2,3 | 2,4 | 2,5 |%2,6 |&2,7 |
  #  |------|-----|-----|-----|-----|-----|-----|-----|
  #  | &3,0 |%3,1 | 3,2 | 3,3 |#3,4 | 3,5 |%3,6 |&3,7 |
  #  |  4,0 | 4,1 | 4,2 | 4,3 | 4,4 | 4,5 | 4,6 | 4,7 |
  #                        5,0
  #                     Player South

  if ((player="North") and (sow==0))
    # Sow in clockwise direction to top row
    # Check if can capture
    # Check if can endelea
    
  elsif ((player="North") and (sow==7))
    # Sow in anticlockwise direction to top row
    # Check if can capture
    # Check if can Endelea
  elsif ((player="South") and (sow==0))
    # Sow in clockwise direction to top row
    # Check if can capture
    # Check if can Endelea
  elsif ((player="South") and (sow==7))
    # Sow in anticlockwise direction to top row
    # Check if can capture
    # Check if can Endelea
  end
  return board
end


# Main program
#
# Setup inital board
# The board is represented as a
# two dimensional array
#                  Player North
#                        0,0
#  |  1,0 | 1,1 | 1,2 | 1,3 | 1,4 | 1,5 | 1,6 | 1,7 |
#  | &2,0 |%2,1 | 2,2 |#2,3 | 2,4 | 2,5 |%2,6 |&2,7 |
#  |------|-----|-----|-----|-----|-----|-----|-----|
#  | &3,0 |%3,1 | 3,2 | 3,3 |#3,4 | 3,5 |%3,6 |&3,7 |
#  |  4,0 | 4,1 | 4,2 | 4,3 | 4,4 | 4,5 | 4,6 | 4,7 |
#                        5,0
#                     Player South
#        0  1  2  3  4  5  6  7
board=[[22, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0],
        [0, 2, 2, 6, 0, 0, 0, 0],
        [0, 0, 0, 0, 6, 2, 2, 0],
        [0, 0, 0, 0, 0, 0, 0, 0], 
       [22, 0, 0, 0, 0, 0, 0, 0]]

# Variable to keep track of winner and whether game has ended
endgame=-1
endkunamua=-1
# Starting player
player="South"

# First Game Loop Kunamua
begin

  puts "Bao "
  printboard(board)
  x = getkunamuamove(board,player)
  board, player = makekunamuamove(board,player,x)
  #move +=1
  #if ((board[0][0]==0) and (board[0][5]==0)) 
    endkunamua=1
  #end
end while endkunamua ==-1

# Main Game Loop Mtaji
#printboard(board)
