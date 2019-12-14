class RemoveCurrentDraftFromProposals < ActiveRecord::Migration
  def change
    remove_column :proposals, :current_draft, :integer
    remove_column :proposals, :current_draft_id, :integer
  end
end
