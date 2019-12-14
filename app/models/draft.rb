class Draft < ActiveRecord::Base
  belongs_to :proposal
  belongs_to :author
  has_many :external_links

  validates_presence_of :proposal_id
  validates_presence_of :author_id
  validates_presence_of :version
  validates_presence_of :written_at
  validates_presence_of :state
end
