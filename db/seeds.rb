AnimalSearch.create_index! force: true

Animal.destroy_all
Owner.destroy_all

10.times do |i|
  d = Dog.create!(name: FFaker::Name.first_name)
  c = Cat.create!(name: FFaker::Name.last_name)
  rand(4).times do
    Owner.create!(name: FFaker::Name.name, animal: d)
    Owner.create!(name: FFaker::Name.name, animal: c)
  end
end

QA.create_index! force: true

Question.destroy_all
Answer.destroy_all

10.times do |i|
  q = Question.create!(title: "Question #{i+1}",
                        text: FFaker::HipsterIpsum.sentence,
                        author: FFaker::Name.name)
  rand(4).times do
    Answer.create!(text: "Q#{i+1}: #{FFaker::Lorem.sentence}",
                   author: FFaker::Name.name,
                   question: q)
  end
end


