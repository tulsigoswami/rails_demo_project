require 'rails_helper'

class RecipeTest < ActiveSupport::TestCase
  RSpec.describe Recipe, type: :model do
    describe "associations" do
      it{ should belong_to(:user)}

      it{should have_many(:likes)}

      it{should have_many(:comments)}

      it{should have_one_attached(:content)}
    end

    describe "validations" do
      it { should validate_presence_of(:title) }
    end
  end
end
