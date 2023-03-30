FactoryBot.define do
  factory :post do
    title { Faker::Lorem.sentence }
    text { Faker::Lorem.paragraph(sentence_count: 5) }
    likes_counter { 0 }
    comments_counter { 0 }
    author { create(:user) }
  end
end
