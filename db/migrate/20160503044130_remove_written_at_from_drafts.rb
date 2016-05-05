class RemoveWrittenAtFromDrafts < ActiveRecord::Migration
  def change
    remove_column :drafts, :written_at, :datetime
  end
end
