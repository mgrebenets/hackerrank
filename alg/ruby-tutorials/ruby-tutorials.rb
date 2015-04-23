# Ruby Tutorial - Hello World!!
print "Hello HackerRank!!"

# Ruby Tutorial - Everything is an object!
print self

# Ruby Tutorial - Object Methods
number.even?

# Ruby Tutorials - Object method parameters
a.range? b, c
a.range?(b, c)

# Ruby tutorial - Control structures - each
def scoring(array)
    # iterate through each of the element in array using *each* and call update_score on it
    array.each do |a|
        a.update_score
    end
end

# Ruby tutorial - Control Structure - unless
def scoring(array)
    # update_score of every user in the array unless the user is admin
    array.each do |user|
        user.update_score unless user.is_admin?
    end
end

# Ruby Tutorial - Control Structure - infinite loop
loop do
    coder.practice
    break if coder.oh_one?
end

# Ruby Tutorial - Control Structure - Until
coder.practice until coder.oh_one?

# Ruby Control Structure - Case (Bonus Question)
def identify_class(obj)
    # write your case control structure here
    case obj
    when Hacker
        puts "It's a Hacker!"
    when Submission
        puts "It's a Submission!"
    when TestCase
        puts "It's a TestCase!"
    when Contest
        puts "It's a Contest!"
    else
        puts "It's an unknown model"
    end
end
