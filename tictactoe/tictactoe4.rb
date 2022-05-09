# Training a Neural Network to 
# Play Tic Tac Toe
#
# Bao is a game with very many
# states, so it seems not 
# possible to find a perfect
# algorithm for it. One can
# train an algorithm to play
# Bao based on observing many
# games. We consider Tic Tac
# Toe as it is a simpler 
# settting. 
#
# We generate 10,000 games 
# by having the computer play
# against itself using a 
# random choice algorithm.
# For each game, we record the
# sequence of board states
# and the result of the game.
# This gives us a training data
# set, for which a neural network
# can be trained so that given a 
# particular board state, the 
# network can output if the state
# will lead to a win, loss or 
# draw.  To turn this into an
# artificial intelligence
# informed player, given a 
# board state, one can examine 
# all next possible board states
# and choose the one most likely
# to lead to a win as informed
# by the data trained artificial
# intelligence. The board states
# will be split according to 
# whether they are for the player
# who went first or second. 
# therefore 2 neural networks 
# will be trained. For 10,000 games,
# one will have 10,000x9 board 
# states, though tic tac toe itself
# has about 8,000 board states, and 
# about 800 if symmetry considerations
# are invoked see 
# https://users.auth.gr/kehagiat/Research/GameTheory/12CombBiblio/TicTacToe.pdf
