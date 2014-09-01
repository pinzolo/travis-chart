class CreateRepositories < ActiveRecord::Migration
  def change
    create_table :repositories do |t|
      t.timestamps

      t.string :slug
      t.boolean :private
      t.text :description
      t.string :github_language
    end
    add_index :repositories, :slug
  end
end
