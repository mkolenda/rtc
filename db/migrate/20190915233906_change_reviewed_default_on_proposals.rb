class ChangeReviewedDefaultOnProposals < ActiveRecord::Migration
  def up
    change_column :proposals, :reviewed, :boolean, default: false
  end

  def down
    change_column :proposals, :reviewed, :boolean, default: nil
  end
end
