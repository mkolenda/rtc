class RemoveCurrentDraftColumnFromProposals < ActiveRecord::Migration
  def change
    remove_column :proposals, :current_draft, :integer
  end
end
