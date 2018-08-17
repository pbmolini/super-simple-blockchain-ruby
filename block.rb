require 'digest'

class Block
  attr_reader :data
  attr_reader :prev
  attr_reader :difficulty
  attr_reader :time
  attr_reader :nonce # number used once - lucky (mining) lottery number

  def initialize(data, prev, difficulty: '0000')
    @data = data
    @prev = prev
    @difficulty = difficulty
    @nonce, @time = compute_hash_with_proof_of_work(difficulty)
  end

  def hash
    Digest::SHA256.hexdigest( "#{nonce}#{time}#{difficulty}#{prev}#{data}" )
  end

  def compute_hash_with_proof_of_work(difficulty='00')
    nonce = 0
    time = (Time.now.to_f * 1000).to_i
    loop do
      hash = Digest::SHA256.hexdigest("#{nonce}#{time}#{difficulty}#{prev}#{data}")
      if hash.start_with?(difficulty)
        return [nonce, time]
      else
        nonce += 1
      end
    end
  end
end
