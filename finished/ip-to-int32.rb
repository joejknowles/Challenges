def ip_to_int32(ip)
  ip = ip.split('.')
  ip = ip.map{|x| x.to_i}
  binary = (0..3).map do |i|
    (0..7).reverse_each.map do |p|
      bin = ip[i] / (2**p) == 1 ? 1 : 0
      ip[i] = ip[i] % (2**p)
      bin
    end
  end
  binary = binary.flatten
  bit32 = 0
  (0..31).each do |p|
    bit32 += binary[p] * ( 2 ** (31-p) )
  end
  bit32
end
print ip_to_int32("128.32.10.1")