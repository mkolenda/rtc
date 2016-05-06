class ExternalLink < ActiveRecord::Base
  belongs_to :draft

  delegate :current?, to: :draft
  alias :current :current?
end
