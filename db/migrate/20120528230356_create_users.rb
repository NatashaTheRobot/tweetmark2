class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :uid
      t.string :name
      t.string :screen_name
      t.string :image
      t.string :auth_token
      t.string :auth_secret

      t.timestamps
    end
  end
end
