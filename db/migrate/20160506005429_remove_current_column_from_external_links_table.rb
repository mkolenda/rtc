class RemoveCurrentColumnFromExternalLinksTable < ActiveRecord::Migration
  def change
    remove_column :external_links, :current, :boolean
  end
end
