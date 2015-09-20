
def valid_luhn?(s)
  digits = s.chars.reverse

  doubled = []
  # reverse chars, double every second
  digits.each_with_index do |n, i|
    doubled << (i.odd? ? (n.to_i*2).to_s : n)
  end
  # sum
  result = doubled.join.chars.inject(0) {|a,v| a+v.to_i}
  
  result % 10 == 0
end

def mask(line)
  # shortcut if nothing to do
  return line if line.length < 14

  # result_line is where the masked line is accumulated
  result_line = line.dup
  
  (0...(line.length-13)).each do |b|
    (14..line.length).each do |e|
      line_b_e = line[b,e]
      
      # remove the ' ', '-'
      s = line_b_e.gsub /[ -]/, ''

      # must be 14,16 digits
      if s =~ /\A\d{14,16}\z/ && valid_luhn?(s)
        # gsub the original line, copy into the result_line
        result_line[b,e] = line[b,e].gsub /\d/, 'X'
      end
    end
  end
  result_line
end

lines = ARGF.readlines

# File.open('./luhn_test.txt', "w+"){|f|f.write(lines.each {|l| f << l})}

lines.each do |line|
  res =  mask(line.chomp)
  puts res
end
