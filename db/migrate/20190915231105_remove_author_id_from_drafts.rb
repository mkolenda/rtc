class RemoveAuthorIdFromDrafts < ActiveRecord::Migration
  def change
    remove_column :drafts, :author_id, :integer
  end
end
