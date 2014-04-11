require 'faker'

24.times do
	p = Post.create(title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph)
	3.times do 
		p.comments.create(body: Faker::Lorem.paragraph)
	end
end

puts "Seed finished"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"