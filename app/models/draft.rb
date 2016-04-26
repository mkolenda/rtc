class Draft < ActiveRecord::Base
  belongs_to :proposal
  belongs_to :author
  has_many :external_links
end