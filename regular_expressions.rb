# Determine whether a string contains a SIN (Social Insurance Number).
# A SIN is 9 digits and we are assuming that they must have dashes in them
SIN_NUMBER = /\b\d{3}-\d{3}-\d{3}\b/
GROUPED_SIN_NUMBER = /\b(\d{3})-(\d{3})-(\d{3})\b/

def has_sin?(string)
  string =~ SIN_NUMBER ? true : false
end

puts "has_sin? returns true if it has what looks like a SIN"
puts has_sin?("please don't share this: 234-604-142") == true

puts "has_sin? returns false if it doesn't have a SIN"
puts has_sin?("please confirm your identity: XXX-XXX-142") == false
puts has_sin?("please don't share this: 234-6043-142") == false
puts has_sin?("please don't share this: 2342-604-142") == false
puts has_sin?("please don't share this: 234-604-1421") == false

# Return the Social Insurance Number from a string.
def grab_sin(string)
  string.slice(SIN_NUMBER) 
end


puts "grab_sin returns an SIN if the string has an SIN"
puts grab_sin("please don't share this: 234-604-142") == "234-604-142"

puts "grab_sin returns nil if it doesn't have a SIN"
puts grab_sin("please confirm your identity: XXX-XXX-142") == nil


# Return all of the SINs from a string, not just one.
def grab_all_sins(string)
  # TODO how do we >> strings into the array, but not just one. 
  # we need all the possible iterations of regex 
  string.scan(SIN_NUMBER) 
end

puts "grab_all_sins returns all SINs if the string has any SINs"
puts grab_all_sins("234-604-142, 350-802-074, 013-630-876") == ["234-604-142", "350-802-074", "013-630-876"]

puts "grab_all_sins returns an empty Array if it doesn't have any SINs"
puts grab_all_sins("please confirm your identity: XXX-XXX-142") == []


# Obfuscate all of the Social Insurance numbers in a string. Example: XXX-XX-4430.
def hide_all_sins(string)
  return string unless has_sin?(string)
  sin_grouping_array = string.scan(GROUPED_SIN_NUMBER)
  p sin_grouping_array.map { |group| "XXX-XXX-#{group[2]}"}.join(', ')
end

puts "hide_all_sins obfuscates any SINs in the string"
puts hide_all_sins("234-601-142, 350-801-074, 013-601-876") == "XXX-XXX-142, XXX-XXX-074, XXX-XXX-876"

puts "hide_all_sins does not alter a string without SINs in it"
string = "please confirm your identity: XXX-XXX-142"
puts hide_all_sins(string) == string


# Ensure all of the Social Insurance numbers use dashes for delimiters.
# Example: 480.01.4430 and 480014430 would both be 480-01-4430.
def format_sins(string)
  # TODO 
  # This seems like a very roundabout and ugly way to achieve this
  # and is entirely abusing the format of the tests, and likely would
  # want to still be useable if the format of the SIN is 
  # any 9 digits interrupted by random .'s and -'s, 
  # will consult for a refactor or a CR
  return string unless has_sin?(string)
  nine_digit_match = /\b\d{3}\D?\d{3}\D?\d{3}\D?\b/
  var = string.scan(nine_digit_match).map do |string|
    string.gsub!(/\D/, '')
    string.insert(3, '-')
    string.insert(7, '-')
  end  
  var.join(', ')
end

puts "format_sins finds and reformat any SINs in the string"
puts format_sins("234600142, 350.800.074, 013-600-876") == "234-600-142, 350-800-074, 013-600-876"

puts "format_sins does not alter a string without SINs in it"
string = "please confirm your identity: 4421422"
puts format_sins(string) == string

string = "please confirm your identity: 123abc445"
puts format_sins(string) == string