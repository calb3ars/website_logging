# open file and parse by line breaks
file = File.open('input.txt').readlines("\n")

# remove \n from each line and split by pipes
file.map do |line|
  line.gsub("\n", "").split("|")
end
