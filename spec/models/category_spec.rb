require 'rails_helper'

RSpec.describe Category, type: :model do

  context 'validation tests' do
    it 'ensures category_name presence' do
      category = Category.new().save
      expect(category).to eq(false)
    end
    
    context 'uniqueness tests' do
      it 'ensures category_name is unique' do
        category = Category.new(category_name: 'sports').save
        expect(category).to eq(true)
      end
    end
  end
end
