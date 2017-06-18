require 'date'
require 'byebug'

def parse(filename)
  # open file and parse by line breaks
  file = File.open(filename).readlines("\n")
  results = {}
  prev_timestamp = 0
  # remove \n from each line and split by pipes
  timestamps = file.map.with_index do|line, i|
    key_value = line.gsub("\n", "").split("|")
    current_timestamp = key_value[0].to_i
    site = key_value[1]
    time_bucket = results[current_timestamp]
    if i == 0
      prev_timestamp = current_timestamp
      results[current_timestamp] = { site => 1}
      # debugger
      results[current_timestamp] = { site => 1}
    end
    # p prev_timestamp
    if (current_timestamp < (prev_timestamp + 86400))
    #   # same day
      if time_bucket.include?(site)
        time_bucket[site] = time_bucket[site] + 1
      else
        time_bucket[site] = 1
      end
    else
      # next day
      prev_timestamp = current_timestamp
      results[prev_timestamp] = { site => 1 }
    #
    end
  end

  timestamps
  # returns array of nested hashes [timestamp, website]
end

# map website to Hash
def time_converter(string)
  # DateTime.strptime(string, '%s')
  date = Time.at(string.to_i).utc


end

# def hash_sites(array)
#   results = {}
#   array.each do |entry|
#     p entry
#   end
# end
#
# load 'weblogger.rb'
# a = parse('input.txt')
# b = convert_to_hash(a)
# hash_sites(a)
