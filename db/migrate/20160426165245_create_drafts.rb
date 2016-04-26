class CreateDrafts < ActiveRecord::Migration
  def change
    create_table :drafts, :force => true do |t|
      t.integer :proposal_id, null: false
      t.integer :author_id, null: false
      t.integer :version, null: false
      t.datetime :written_at, null: false
      t.string :state, null: false

      t.timestamps null: false
    end
  end
end
