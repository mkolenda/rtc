FactoryGirl.define do
  factory :proposal, :class => Proposal do
    author   Author.find_or_create_by(name: "Test Author")
    sequence(:title) { |n| "Test Title {n}" }
    body     "Test Body"
    reviewed true
  end
end
