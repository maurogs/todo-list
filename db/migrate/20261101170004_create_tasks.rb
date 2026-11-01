class CreateTasks < ActiveRecord::Migration[8.1]
  def change
    create_table :tasks do |t|
      t.references :list, null: false, foreign_key: true
      t.string :title, null: false
      t.text :notes
      t.date :due_on
      t.integer :priority, null: false, default: 0
      t.datetime :completed_at
      t.integer :position, null: false, default: 0

      t.timestamps
    end
    add_index :tasks, [ :list_id, :position ]
    add_index :tasks, :due_on
  end
end
