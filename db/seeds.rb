# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
simpleuser=User.create(username:"user1",email:"user1@gmail.com",password:"1234",password_confirmation:"1234")
course1=Course.create(title:"HTML5 & CSS3")
course2=Course.create(title:"Intro To Javascript")
course3=Course.create(title:"Intro To Ruby")
chapter1_for_course1=Chapter.create(title:"Selectors",course_id:course1.id)
chapter1_for_course2=Chapter.create(title:"Loops in Javascript",course_id:course2.id)
chapter1_for_course3=Chapter.create(title:"Loops in Ruby",course_id:course3.id)
