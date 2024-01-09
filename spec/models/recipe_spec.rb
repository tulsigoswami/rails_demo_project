require 'rails_helper'

class RecipeTest < ActiveSupport::TestCase
  RSpec.describe Recipe, type: :model do
    describe "Associations" do
      it{ should belong_to(:user)}
      it{should have_many(:likes)}
      it{should have_many(:comments)}
      it{should have_one_attached(:content)}
    end

    describe "validations" do
      it { should validate_presence_of(:title) }
      it { should validate_presence_of(:description) }
    end
  end
end
