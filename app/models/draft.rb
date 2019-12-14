class Draft < ActiveRecord::Base
  belongs_to :proposal, inverse_of: :drafts
  belongs_to :author
  has_many :external_links

  validates_presence_of :proposal_id
  validates_presence_of :author_id
  validates_presence_of :version
  validates_presence_of :written_at
  validates_presence_of :state

  def expire_external_links
    external_links&.update_all(current: false)
  end
end
