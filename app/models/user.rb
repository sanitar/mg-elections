class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:vkontakte]

  belongs_to :role

 def self.find_for_vkontakte_oauth access_token
    if user = User.where(:url => access_token.info.urls.Vkontakte).first
      user
    else 
      User.create!(:provider => access_token.provider,
       :url => access_token.info.urls.Vkontakte,
       :first_name => access_token.info.first_name,
       :last_name => access_token.info.last_name,
       :email => "#{access_token.uid}@elections.dev",
       :password => Devise.friendly_token[0,20],
       :role_id => 1)
    end
  end
end
