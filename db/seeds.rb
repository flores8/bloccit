require 'faker'

5.times do
	password = Faker::Lorem.characters(10)
	user = User.new(
		name: Faker::Name.name,
		email: Faker::Internet.email,
		password: password,
		password_confirmation: password)
	user.skip_confirmation!
	user.save

	5.times do 
		post = Post.create(
			user: user, 
			title: Faker::Lorem.sentence,
			body: Faker::Lorem.paragraph)
		post.update_attribute(:created_at, Time.now - rand(600..31536000))
	end
end

user = User.first
user.skip_reconfirmation!
user.update_attributes(email: 'lauralee@majorfinder.com', password: 'helloworld', password_confirmation: 'helloworld')

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"