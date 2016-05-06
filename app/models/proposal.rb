class Proposal < ActiveRecord::Base

  has_many :drafts
  belongs_to :author
  belongs_to :current_draft, class_name: 'Draft'

  def create_draft!(attributes, author_id)
    if self.drafts.empty?
      return create_first_draft!(attributes, author_id)
    end

    draft = self.drafts.build(attributes)
    draft.author_id = author_id
    draft.version = self.current_draft.version + 1
    self.save!
    self.update_attribute(:current_draft_id, draft.id)
    draft
  end

  private

  def create_first_draft!(attributes, author_id)
    draft = self.drafts.build(attributes)
    draft.author_id = author_id
    draft.state ||= 'New'
    draft.version = 1
    self.save!
    self.update_attribute(:current_draft_id, draft.id)
    draft
  end
end
