class Proposal < ActiveRecord::Base

  has_many :drafts
  belongs_to :author
  has_one :current_draft, class_name: 'Draft'
  accepts_nested_attributes_for :drafts

  validates :title, presence: true
  validates :body, presence: true
  validates :author, presence: true

  def create_draft!(attributes, author)
    if self.drafts.empty?
      return create_first_draft!(attributes, author)
    end

    if self.current_draft.external_links.any?
      self.current_draft.external_links.each do |link|
        link.update_attribute(:current, false)
      end
    end

    draft = self.drafts.build(attributes)
    draft.proposal_id = self.id
    draft.written_at = Time.now
    draft.author_id = author
    draft.version = self.current_draft.version + 1
    self.save!
    self.update_attribute(:current_draft_id, draft.id)
    draft
  end

  private

  def create_first_draft!(attributes, author)
    draft = self.drafts.build(attributes)
    draft.written_at = Time.now
    draft.author_id = author
    draft.state ||= 'New'
    draft.version = 1
    self.save!
    self.update_attribute(:current_draft_id, draft.id)
    draft
  end
end
