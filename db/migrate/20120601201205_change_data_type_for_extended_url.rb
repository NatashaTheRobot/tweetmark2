class ChangeDataTypeForExtendedUrl < ActiveRecord::Migration
  def up
      change_table :tweets do |t|
        t.change :extended_url, :text
      end
  end

  def down
      change_table :tweets do |t|
         t.change :extended_url, :string 
      end
  end
end
