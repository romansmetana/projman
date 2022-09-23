# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'Petr' }
    surname { 'Cech' }
    email { 'chelsi@gmail.com' }
    password { 'password' }
  end
end
