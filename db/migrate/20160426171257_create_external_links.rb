class CreateExternalLinks < ActiveRecord::Migration
  def change
    create_table :external_links, :force => true do |t|
      t.integer :draft_id, null: false
      t.string :title, null: false
      t.boolean :current, null: false

      t.timestamps null: false
    end
  end
end
