# In this file we define the methods to help filter out candidates
# This way, we keep these methods separated from other potential parts of the program

def find(id)
  @candidates.each do |candidate|
    return candidate if candidate[:id] == id
  end
  nil
end

def experienced?(candidate)
  candidate[:years_of_experience] >= 2
end

# More methods will go below
def qualified_candidates(candidates)
  candidates.select do |candidate|
    criteria(candidate)
  end
end

def criteria(candidate)
  experienced?(candidate) && candidate[:github_points] >= 100 &&
  (candidate[:languages].include?('Ruby') || candidate[:languages].include?('Python')) &&
  candidate[:age] > 17 &&
  (Date.today - candidate[:date_applied]).to_i <= 15 
end

def ordered_by_qualifications(candidates)
  # p candidates
  candidates.sort! do |c1, c2| 
    c2[:years_of_experience] == c1[:years_of_experience] ? 
    c2[:github_points] <=> c1[:github_points] :
    c2[:years_of_experience] <=> c1[:years_of_experience]
  end
end