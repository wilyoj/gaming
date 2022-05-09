# Train a neural network to simulate the xor function
#
# The xor function takes in two inputs, each of which 
# can either be 1 or 0. If both inputs are the same, 
# it outputs 0, if they are different it outputs 1
#
# This imlementation requires the ruby-dnn
# https://github.com/unagiootoro/ruby-dnn
# The source of this program is
# https://github.com/unagiootoro/ruby-dnn/blob/master/examples/xor_example.rb
# Though a few comment lines have been added
#
require "dnn"

include DNN::Models
include DNN::Layers
include DNN::Optimizers
include DNN::Losses

x = Numo::SFloat[[0, 0], [1, 0], [0, 1], [1, 1]]
y = Numo::SFloat[[0], [1], [1], [0]]

model = Sequential.new

model << InputLayer.new(2)
model << Dense.new(16)
model << ReLU.new
model << Dense.new(1)

model.setup(SGD.new, SigmoidCrossEntropy.new)

model.train(x,y, 20000, batch_size: 4, verbose: false)

p model.predict(x)