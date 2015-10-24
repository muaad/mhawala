# == Schema Information
#
# Table name: users
#
#  id                       :integer          not null, primary key
#  email                    :string           default(""), not null
#  encrypted_password       :string           default(""), not null
#  reset_password_token     :string
#  reset_password_sent_at   :datetime
#  remember_created_at      :datetime
#  sign_in_count            :integer          default(0), not null
#  current_sign_in_at       :datetime
#  last_sign_in_at          :datetime
#  current_sign_in_ip       :string
#  last_sign_in_ip          :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  name                     :string
#  profile_pic_file_name    :string
#  profile_pic_content_type :string
#  profile_pic_file_size    :integer
#  profile_pic_updated_at   :datetime
#  phone_number             :string
#  is_admin                 :boolean          default(FALSE)
#  is_support               :boolean          default(FALSE)
#  user_type                :string
#  agent_id                 :integer
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :profile_pic, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/missing.jpg"
  # validates_attachment_content_type :profile_pic, content_type: /\Aimage\/.*\Z/

  has_many :payments

  def last_location
  	payments = Payment.where("sender_id = ? OR recipient_id = ?", id, id)
  	location = ""
  	location = payments.last.sent_from || payments.last.sent_to if !payments.blank?
  end

  def amount_sent
    Payment.where(sender: self).sum(:amount)
  end

  def amount_received
    Payment.where(recipient: self).sum(:amount)
  end

  def remittances_recorded
    remittances = 0.0
    if user_type == "Staff"
      remittances = Payment.where(recorded_by: self).sum(:amount)
    end
    remittances
  end

  def withdrawals_recorded
    withdrawals = 0.0
    if user_type == "Staff"
      withdrawals = Payment.where(withdrawn_by: self).sum(:amount)
    end
    withdrawals
  end
end
