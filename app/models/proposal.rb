class Proposal < ActiveRecord::Base
  has_many :drafts
  belongs_to :author
  has_one :current_draft, class_name: 'Draft'
  accepts_nested_attributes_for :drafts

  validates :title, presence: true
  validates :body, presence: true
  validates :author, presence: true

  def create_draft!(attributes, author=nil)
    if self.current_draft && self.current_draft.external_links.present?
      self.current_draft.external_links.update_all(:current, false)
    end

    draft = self.drafts.build(attributes)
    draft.proposal_id = self.id
    draft.written_at = Time.now
    draft.state ||= 'New'
    draft.author_id = self.author.try(:id) || author.try(:id)
    draft.version = self.current_draft.version + 1
    self.save!
    self.update_attribute(:current_draft_id, draft.id)
    draft
  end
end