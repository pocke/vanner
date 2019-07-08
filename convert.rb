# Usage:
#   1. Copy font2Letter[] type literal from https://shh.thathost.com/pub-unix/files/banner-1.3.2.tar.gz
#   2. Execute `ruby convert.rb COPYED_FILE > OUTPUT`

require 'strscan'

def process_char(sc)
  # read { 'a', {
  sc.scan(/\s+\{\s*\'(.)\',\s*\{/) or return nil
  char = sc[1]

  content = []
  while sc.scan(/\s*\"(.+)\",?/)
    content << sc[1]
  end

  sc.scan(/.+\n/)

  {char => content}
end

def indent(n)
  "\\ " + "  " * n
end


sc = StringScanner.new(ARGF.read)

data = {}

while ch = process_char(sc)
  data.merge! ch
end


# Convert to Vim script literal
puts "{"
data.each do |char, content|
  puts %Q!#{indent(1)}#{char.dump}: [!
  content.each do |line|
    puts indent(2) + line.dump + ','
  end
  puts "#{indent(1)}],"
end
puts "#{indent(0)}}"
