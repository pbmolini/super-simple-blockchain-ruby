require 'pp'
require './helpers'
require './block'
difficulty = '0000'
blockchain = []
b0 = Block.new('Helloween 0', INITIAL_HASH, difficulty: difficulty)
blockchain << b0
(1..4).each do |i|
  b_i = Block.new("Helloween #{i}", blockchain[i-1].hash, difficulty: difficulty)
  blockchain << b_i
end
pp blockchain if check_integrity(blockchain)
