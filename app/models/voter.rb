# == Schema Information
#
# Table name: voters
#
#  id                  :integer          not null, primary key
#  first_name          :string(255)
#  last_name           :string(255)
#  middle_name         :string(255)
#  vk_id               :integer
#  district            :string(255)
#  email               :string(255)
#  mobile              :string(255)
#  skype               :string(255)
#  age                 :integer
#  sex                 :integer
#  can_write           :boolean
#  created_at          :datetime
#  updated_at          :datetime
#  status_id           :integer
#  conversation_status :integer          default(0)
#  image_url           :string(255)
#  social_weight       :integer
#  bdate               :datetime
#  last_seen           :datetime
#

class Voter < ActiveRecord::Base

	has_many :educations
	has_many :schools, through: :educations

	has_one :conversation

	belongs_to :status, class_name: "VoterStatus", foreign_key: :status_id

	#
	# => Дистрикт стринговый, потому что тупанул в миграциях
	# => @todo перед продом исправить тип дистрикта
	#
	def self.ready_to_talk district = ['0','1','2'], sex = [1,2]
		where('district in (?) and sex in (?) and conversation_status = ? and can_write = ?', district.to_a, sex.to_a, 0, true)
	end

	def name
		"#{first_name} #{last_name}"
	end

end
