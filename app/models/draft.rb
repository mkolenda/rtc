class Draft < ActiveRecord::Base
  belongs_to :proposal
  belongs_to :author
  has_many :external_links

  delegate :author, to: :proposal

  before_validation :set_version, :set_written_at, :set_state

  private

  def set_version
    self.version ||= 1
  end

  def set_written_at
    self.written_at = Time.now
  end

  def set_state
    self.state ||= 'New'
  end
end