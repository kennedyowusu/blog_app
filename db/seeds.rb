# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
first_user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')


# Add 6 comments
Comment.create(post: first_post, author: second_user, text: 'Hi comment 1' )
Comment.create(post: first_post, author: second_user, text: 'Hi comment 2' )
Comment.create(post: first_post, author: second_user, text: 'Hi comment 3' )
Comment.create(post: first_post, author: second_user, text: 'Hi comment 4' )
Comment.create(post: first_post, author: second_user, text: 'Hi comment 5' )
Comment.create(post: first_post, author: second_user, text: 'Hi comment 6' )
