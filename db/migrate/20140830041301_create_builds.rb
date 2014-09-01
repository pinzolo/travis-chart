class CreateBuilds < ActiveRecord::Migration
  def change
    create_table :builds do |t|
      t.timestamps

      t.integer :repository_id
      t.integer :commit_id
      t.string :number
      t.integer :pull_request_id
      t.string :state
      t.datetime :started_at
      t.datetime :finished_at
      t.integer :duration
    end

    add_index :builds, [:repository_id, :number]
    add_index :builds, :pull_request_id
  end
end
