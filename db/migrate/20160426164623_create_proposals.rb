class CreateProposals < ActiveRecord::Migration
  def change
    create_table :proposals, :force => true do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.boolean :reviewed, null: false
      t.integer :author_id, null: false
      t.integer :current_draft_id
      t.integer :current_draft


      t.timestamps null: false
    end
  end
end
