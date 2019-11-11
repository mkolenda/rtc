class AddDefaultValueToReviewedOnProposal < ActiveRecord::Migration
  def change
    change_column_default :proposals, :reviewed, false
  end
end
