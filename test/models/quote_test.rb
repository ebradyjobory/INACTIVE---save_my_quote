require 'test_helper'

class QuoteTest < ActiveSupport::TestCase
 
test "the quote has a content" do 

quote = Quote.new
assert !quote.save
assert !quote.errors[:content].empty?	
end

test "the content quote has at least two letters long" do 

quote = Quote.new
quote.content = "H"
assert !quote.save
assert !quote.errors[:content].empty?	
end

test "that a quote has a user id" do
quote = Quote.new
quote.content = "Hello"
assert !quote.save
assert !quote.errors[:user_id].empty?
end



end
