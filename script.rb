require 'date'
require 'byebug'
require 'set'

def parse(filename)
  # open file and parse by line breaks
  file = File.open(filename).readlines("\n")
  results = {}
  # remove \n from each line and split by pipes
  file.map do|line|
    key_value = line.gsub("\n", "").split("|")
    [time_converter(key_value[0]), key_value[1]]
    # results[time_converter(key_value[0])] = key_value[1]
  end

  # results
end

def time_converter(string)
  date = Time.at(string.to_i).utc.to_date
end

def time_set(array)
  dates = array.map do |el|
    el[0]
  end

  return Set.new(dates)
end

# sort into hash by days
def sort_to_set(array, set)
  s = set
  results = {}
  # map set to hash keys
  s.each do |date|
    results[date] = {}
  end

  # results
  array.each do |entry|
    site = entry[1]
    date = entry[0]
    # debugger
    if results[date][site]
      # debugger
      results[date][site] += 1
    else
      # debugger
      results[date][site] = 1
    end
  end

  # results.sort_by { |k, v| k}
  results.map do |k, v|
    results[k] = v.sort{|a, b| b[1] <=> a[1] }
  end

  results.sort_by {|k, v| k }
end

def print_output(array)
  array.each do |el|
    month = el[0].month.to_s.rjust(2, '0')
    day = el[0].day.to_s.rjust(2, '0')
    year = el[0].year
    p "#{month}/#{day}/#{year} GMT"
    print_site(el[1])
  end
end

def print_site(array)
  array.each do |site|
    p "#{site[0]} #{site[1]}"
  end
end

# load "script.rb"
# a = parse('input.txt')
# s = time_set(a)
# r = sort_to_set(a, s)
#   print_output(r)
# print_results(r)
