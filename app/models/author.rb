class Author < ActiveRecord::Base
  has_many :proposals
end