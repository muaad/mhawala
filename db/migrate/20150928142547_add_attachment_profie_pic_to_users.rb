class AddAttachmentProfiePicToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.attachment :profie_pic
    end
  end

  def self.down
    remove_attachment :users, :profie_pic
  end
end
