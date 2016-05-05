class Draft < ActiveRecord::Base
  belongs_to :proposal
  belongs_to :author
  has_many :external_links

  alias_attribute :written_at, :created_at
end
