require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  RSpec.describe 'Recipe' do
   context 'before creation' do
    it 'can not have  comments before creation'do
    expect {Recipe.comments.create!}.to raise_error[ActiveRecord::RecordInvalid]
    end
   end
  end
end
