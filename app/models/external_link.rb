class ExternalLink < ActiveRecord::Base
  belongs_to :draft
  validates_presence_of :title, :draft_id
  validates :current, inclusion: [true, false]
end
