class Draft < ActiveRecord::Base
  belongs_to :proposal
  belongs_to :author
  has_many :external_links

  before_create :set_version

  alias_attribute :written_at, :created_at

  def current?
    proposal.current_draft == self
  end

  private

  def set_version
    if self.version.nil?
      self.version = proposal.drafts.select{|draft| draft.persisted? }.length + 1
    end
  end
end
