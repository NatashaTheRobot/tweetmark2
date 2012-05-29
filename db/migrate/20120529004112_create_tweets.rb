class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :created_at
      t.string :text
      t.string :hashtags
      t.string :urls
      t.integer :user_id

      t.timestamps
    end
  end
end
