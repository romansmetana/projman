# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

user = User.create(
    name: 'Roman',
    surname: 'Smetana',
    email: 'roman@gmail.com',
    password: 'password'
)

project = Project.create(
    title: 'To-do list',
    position: 1,
    user_id: user.id
)

tag = Tag.create(
    title: 'test',
    user_id: user.id
)

task = Task.create(
    title: 'Make to-do list',
    description: 'You need to created todo model',
    is_done: false,
    user_id: user.id,
    project_id: project.id

)

TaskTag.create(
    task_id: task.id,
    tag_id: tag.id
)