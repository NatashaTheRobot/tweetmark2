# == Schema Information
#
# Table name: users
#
#  id          :integer         not null, primary key
#  uid         :string(255)
#  name        :string(255)
#  screen_name :string(255)
#  image       :string(255)
#  auth_token  :string(255)
#  auth_secret :string(255)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class User < ActiveRecord::Base
  attr_accessible :auth_secret, :auth_token, :image, :name, :screen_name, :uid
  
  def self.create_with_omniauth(auth)
    create! do |user|
        user.uid = auth["uid"]
        user.name = auth["info"]["name"]
        user.screen_name = auth["info"]["nickname"]
        user.image = auth["info"]["image"]
        user.auth_token = auth["credentials"]["token"]
        user.auth_secret = auth["credentials"]["secret"]
    end
  end
end


