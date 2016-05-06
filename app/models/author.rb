class Author < ActiveRecord::Base
  has_many :proposals
  has_many :drafts
end
