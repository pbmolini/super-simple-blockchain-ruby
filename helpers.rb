INITIAL_HASH = '0000000000000000000000000000000000000000000000000000000000000000'
  def check_integrity(blockchain)
    blockchain.each_with_index.map do |block, i|
      block.prev == (i == 0 ? INITIAL_HASH : blockchain[i-1].hash) &&
      block.hash == sha256("#{block.nonce}#{block.time}#{block.difficulty}#{block.prev}#{block.data}") &&
      block.hash.start_with?(block.difficulty)
    end.all? &&
    (1..(blockchain.count-1)).map do |i|
      blockchain[i].time > blockchain[i-1].time
    end.all?
  end

  def sha256( data )
    Digest::SHA256.hexdigest( data )
  end
