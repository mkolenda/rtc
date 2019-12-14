class Proposal < ActiveRecord::Base
  has_many :drafts, inverse_of: :proposal
  belongs_to :author
  has_one :current_draft, ->{order(version: :desc)}, class_name: Draft.name

  validates_presence_of :title, :body, :author_id
  validates :reviewed, inclusion: [true, false]

  def build_draft(attributes, author)
    draft = self.drafts.build(attributes)
    draft.proposal_id = self.id
    draft.written_at = Time.now
    draft.author = author
    draft.version = current_draft&.version&.next || 1
  end

  def expire_current_draft_external_links
    current_draft.expire_external_links
  end
end
