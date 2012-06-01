class AddSiteTitleToTweet < ActiveRecord::Migration
  def change
      add_column :tweets, :site_title, :string
  end
end
