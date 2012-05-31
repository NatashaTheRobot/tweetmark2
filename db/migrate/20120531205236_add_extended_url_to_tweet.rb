class AddExtendedUrlToTweet < ActiveRecord::Migration
  def change
      add_column :tweets, :extended_url, :string
  end
end
