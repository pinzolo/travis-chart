class CreatePullRequests < ActiveRecord::Migration
  def change
    create_table :pull_requests do |t|
      t.timestamps

      t.string :number
      t.string :title
    end
  end
end
