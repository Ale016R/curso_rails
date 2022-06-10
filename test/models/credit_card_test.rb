# frozen_string_literal: true

# == Schema Information
#
# Table name: credit_cards
#
#  id         :bigint           not null, primary key
#  no_card    :string(255)
#  owner      :string(255)
#  provider   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'test_helper'

class CreditCardTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
