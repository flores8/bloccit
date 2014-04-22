require 'faker'
topics = []
5.times do
	topics << Topic.create(
		name: Faker::Lorem.sentence,
		description: Faker::Lorem.paragraph
		)
end
5.times do
	password = Faker::Lorem.characters(10)
	user = User.new(
		name: Faker::Name.name,
		email: Faker::Internet.email,
		password: password,
		password_confirmation: password)
	user.skip_confirmation!
	user.save

	3.times do 
		suggestion = Suggestion.create(
			user: user,
			title: Faker::Lorem.sentence,
			body: Faker::Lorem.paragraph)
		suggestion.update_attribute(:created_at, Time.now - rand(600..31536000))
	end
	
	10.times do 
		topic = topics.first
		post = Post.create(
			user: user,
			topic: topic, 
			title: Faker::Lorem.sentence,
			body: Faker::Lorem.paragraph)
		post.update_attribute(:created_at, Time.now - rand(600..31536000))

		post.update_rank
		topics.rotate!
	end
end

post_count = Post.count
User.all.each do |user|
	10.times do
		post = Post.find(rand(1..post_count))
		comment = user.comments.create(
			body: Faker::Lorem.paragraph,
			post: post)
		comment.update_attribute(:created_at, Time.now - rand(600..31536000))
	end
end

# Create an Admin User
admin = User.new(
	name: 'Admin User',
	email: 'admin@example.com',
	password: 'helloworld',
	password_confirmation: 'helloworld')
admin.skip_confirmation!
admin.save
admin.update_attribute(:role, 'admin')

# Create a Moderator
moderator = User.new(
	name: "Moderator User", 
	email: 'moderator@example.com',
	password: 'helloworld',
	password_confirmation: 'helloworld')
moderator.skip_confirmation!
moderator.save
moderator.update_attribute(:role, 'moderator')

# Create a Member
member = User.new(
	name: 'Member User',
	email: 'member@example.com',
	password: 'helloworld',
	password_confirmation: 'helloworld')
member.skip_confirmation!
member.save

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Topic.count} topics created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"