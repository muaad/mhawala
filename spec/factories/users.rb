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

FactoryGirl.define do
  factory :user do
    name "Test User"
    email "test@example.com"
    password "please123"
  end
end
