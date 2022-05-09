# Recursive factorial example
#
# The factorial function  
# takes a positive number
# and returns the product
# of all numbers between
# that number and one 

def factorial(n)
  if ((n==0) or (n==1))
    # If have reached end case
    # return value of 0 or 1
    return 1
  else
    # Otherwise use the definition
    # to solve an easier problem
    m = n * factorial(n-1)
    return m
  end
end
 
 puts "Please enter the non negative number you want to find the factorial for"
 num = gets.chomp.to_i
 puts "Thank you. Calculating."
 out = factorial(num)
 puts " #{num} factorial is #{out}."