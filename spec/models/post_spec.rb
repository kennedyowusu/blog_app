require 'rails_helper'
include Shoulda::Matchers::ActiveModel

RSpec.describe Post, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_most(250) }
    it { is_expected.to validate_presence_of(:text) }
    it { is_expected.to validate_length_of(:text).is_at_least(10) }
    it { is_expected.to validate_numericality_of(:comments_counter).is_greater_than_or_equal_to(0) }
    it { is_expected.to validate_numericality_of(:likes_counter).is_greater_than_or_equal_to(0) }
  end


end
