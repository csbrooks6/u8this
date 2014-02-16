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

require 'spec_helper'

describe Food do
  pending "add some examples to (or delete) #{__FILE__}"
end
