# == Schema Information
#
# Table name: foods
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  name       :string(255)      not null
#  ref_count  :integer          default(0), not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_foods_on_user_id_and_name  (user_id,name)
#

class Food < ActiveRecord::Base
  belongs_to :user

  validates :ref_count, numericality: { greater_than_or_equal_to: 1 }

end
