class FavoriteMailer < ActionMailer::Base
  default from: "\"Lauralee Flores\" <lauralee@lauraleeflores.com>"

  def new_comment(user, post, comment)
  	@user = user
  	@post = post
  	@comment = comment

  	# New Headers
  	headers["Message-ID"] = "<comments/#{@comment.id}@lauralee-bloccit.herokuapp.com>"
  	headers["In-Reply-To"] = "<post/#{@post.id}@lauralee-bloccit.herokuapp.com>"
  	headers["References"] = "<post/#{@post.id}@lauralee-bloccit.herokuapp.com>"

  	mail(to: user.email, subject: "New comment on #{post.title}")
  end
end
