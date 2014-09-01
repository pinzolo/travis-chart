class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.timestamps

      t.integer :build_id
      t.integer :log_id
      t.string :number
      t.string :state
      t.datetime :started_at
      t.datetime :finished_at
      t.integer :duration
      t.string :queue
      t.string :rvm
      t.string :env
    end
    add_index :jobs, [:build_id, :number]
  end
end
