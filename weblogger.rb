require 'date'
require 'byebug'

def parse(filename)
  # open file and parse by line breaks
  file = File.open(filename).readlines("\n")
  results = {}
  # remove \n from each line and split by pipes
  file.each do|line|
    key_value = line.gsub("\n", "").split("|")
    timestamp_day = time_converter(key_value[0]).day
    timestamp = time_converter(key_value[0])
    date = "#{timestamp.month}/#{timestamp.day}/#{timestamp.year} GMT"
    # p date
    site = key_value[1]
    if results[timestamp_day]
      time_bucket = results[timestamp_day]
      # debugger
      if time_bucket.keys.include?(site)
        time_bucket[site] += 1
      else
        time_bucket[site] = 1
      end
    else
      results[timestamp_day] = { site => 1}
      results[timestamp_day] = { date => 0}
    end

  end

  results.sort_by{|key, value| key}
  # returns array of nested hashes [timestamp, website]
end

# map website to Hash
def time_converter(string)
  # need to convert to UTC first before converting to date
  date = Time.at(string.to_i).utc.to_date
end

def sort_by_freq(array)
  # debugger
  array.each do |day|
    # debugger
    day_label = day[1].keys.first
    puts day[1].keys.first
    sites = day[1].sort_by{|key, value| value}.reverse
    sites.each do |site|
      puts site
    end
  end
end
#
# load 'weblogger.rb'
# a = parse('input.txt')
# b = convert_to_hash(a)
# hash_sites(a)
