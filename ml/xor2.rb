require 'numo/narray'
require 'chainer'

class XOR < Chainer::Chain
  L = Chainer::Links::Connection::Linear
  R = Chainer::Functions::Activation::Relu

  def initialize(n_units, n_out)
    super()
    init_scope do
      @l1 = L.new(nil, out_size: n_units)
      @l2 = L.new(nil, out_size: n_out)
    end
  end

  def call(x)
    h1 = R.relu(@l1.(x))
    @l2.(h1)
  end
end

device = Chainer::Device.create(Integer( -1))
Chainer::Device.change_default(device)
xm = device.xm

lossfun = -> (x, t) { Chainer::Functions::Loss::SoftmaxCrossEntropy.new(ignore_label: nil).(x, t) }

model = Chainer::Links::Model::Classifier.new(XOR.new(2, 1), lossfun)
optimizer = Chainer::Optimizers::Adam.new
optimizer.setup(model)

input=[[0,0],[0,1],[1,1],[0,1]]
output=[0,1,0,1]

input = xm::SFloat.cast(input)
output = xm::SFloat.cast(output)

input_train = input
output_train = output

puts("Training")

1000.times{|i|
  print(",") if i%100 == 0
  input = Chainer::Variable.new(input_train)
  output = Chainer::Variable.new(output_train)
  model.cleargrads()
  loss = model.(input,output)
  loss.backward()
  optimzer.update()
}

puts

# Test
input_t = Chainer::Variable.new(input_test)
output_t = model.fwd(input_t)

puts("Test input")
puts input_t
puts("Test output")
puts output_t
