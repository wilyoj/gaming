#!/usr/bin/ruby
#
# A Ruby Tic Tac Toe Implementaion
#
# Graphical user interface version for 
# two players on the same computer

require 'gosu'

class TicTacToe < Gosu::Window
  attr_reader :move, :board, :finish, :msg
 
  def initialize
    super 480, 480
    self.caption = "Tic Tac Toe"
    @font = Gosu::Font.new(20)
    # Setup inital board
    # -1 empty space
    # 0 player O
    # 1 player X
    @board=[[-1,-1,-1],
            [-1,-1,-1],
            [-1,-1,-1]]
    @move=0
    @finish=-1
    @msg="Cheza tic tac toe! \n Finya na kibonye cha \n kulia cha kipanya kuweka X au O. \n Finya M kuzima au kuanza muziki."
    @music = Gosu::Song.new("./maua_mazuri.ogg")
  end

  def needs_cursor?
    true
  end
  
  def checkendgame
    endgame=-1
    # Left to right, top to bottom diagonal
    if ((@board[0][0]==@board[1][1]) and (@board[0][0]==@board[2][2]) and (@board[0][0]!=-1))
      endgame=@board[0][0]
    end
    # Right to left, top to bottom diagonal
    if ((@board[0][2]==@board[1][1]) and (@board[0][2]==@board[2][0]) and (@board[0][2]!=-1))
      endgame=@board[0][2]
    end
    # Rows
    (0..2).each do |j|
      if ((@board[0][j]==@board[1][j]) and (@board[0][j]==@board[2][j]) and (@board[0][j]!=-1))
        endgame=@board[0][j]
      end
    end
    # Columns
    (0..2).each do |i|
      if ((@board[i][0]==@board[i][1]) and (@board[i][0]==@board[i][2]) and (@board[i][0]!=-1))
      endgame=@board[i][0]
      end
    end
    return endgame
  end

  def print_board
    (0..2).each do |j|
      (0..2).each do |i|
        if @board[i][j] == 0
          @font.draw_text("0", i*width/3+width/6, j*height/3+height/6, 1, 2, 2, Gosu::Color::RED)
        elsif @board[i][j] == 1
          @font.draw_text("X", i*width/3+width/6, j*height/3+height/6, 1, 2, 2, Gosu::Color::GREEN)
        else
          @font.draw_text("_", i*width/3+width/6, j*height/3+height/6, 1, 2, 2, Gosu::Color::WHITE)
        end
      end
    end
    @font.draw_text(@msg, width/8, height/3, 2, 1, 1, Gosu::Color::AQUA)
    return
  end

  def print_endmessage
    if @finish == 2
      @msg="Hakuna mshindi, finya Esc kutoka"
    elsif @finish == 1
      @msg="X ameshinda, finya Esc kutoka"
    elsif @finish == 0
      @msg="O ameshinda, finya Esc kutoka"
    end
  end

  def button_down(id)
    case id
    when Gosu::KbEscape
      close
    when Gosu::KbM
      if @music.playing? then
        @music.stop
      else
        @music.play(true)
      end
    when Gosu::MsLeft
      x = mouse_x/(width/3)
      y = mouse_y/(height/3)
      player = @move%2
      # clear instructions
      if @finish == -1
        @msg = ""
      end
      # check if a valid move, if so update board
      # then check if game has ended
      if ((@board[x][y] == -1) and (@finish == -1))
        @board[x][y] = player
        @move+=1
        @finish = checkendgame
        if @move == 9 and @finish == -1
          @finish = 2
        end
        player=@move%2
        stop = 0
        if @finish == -1
          begin
            x = ((10000*rand).floor)%3
            y = ((10000*rand).floor)%3
            if @board[x][y] == -1
              @board[x][y] = player
              stop = 1
            end
          end while (stop !=1)
          @move+=1
          @finish = checkendgame
          if @move ==9 and @finish == -1
            @finish =2
          end
        end
      end
      if @finish != -1
        print_endmessage
      end
    end
  end
   
  def update
    # ...
  end
  
  def draw
    print_board
  end

end

TicTacToe.new.show
