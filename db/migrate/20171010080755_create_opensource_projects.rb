class CreateOpensourceProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :opensource_projects do |t|
      t.string :title, null: false
      t.string :slug, null: false
      t.text :body, null: false
      t.string :summary, limit: 5000
      t.string :banner
      t.integer :user_id
      t.integer :likes_count, null: false, default: 0
      t.integer :comments_count, null: false, default: 0
      t.integer :status, null: false, default: 0
      t.datetime :published_at, null: false

      t.timestamps
    end

    add_index :opensource_projects, :slug
    add_index :opensource_projects, :status
    add_index :opensource_projects, :published_at
    add_index :opensource_projects, :user_id
  end
end
