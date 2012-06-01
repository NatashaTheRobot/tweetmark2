class ChangeDataTypeForTweetTitle < ActiveRecord::Migration
    def up
        change_table :tweets do |t|
            t.change :site_title, :text
        end
    end

    def down
        change_table :tweets do |t|
            t.change :site_title, :string 
        end
    end
end
