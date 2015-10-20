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
end
