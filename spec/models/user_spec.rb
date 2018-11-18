require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation tests' do
    it 'ensures user_name presence' do
      user = User.new(email: 'sample@example.com', password: 'password').save
      expect(user).to eq(false)
    end
    
    it 'ensures email presence' do
      user = User.new(user_name: 'username', password: 'password').save
      expect(user).to eq(false)
    end
    
    it 'ensures password presence' do
      user = User.new(user_name: 'username', email: 'sample@example.com').save
      expect(user).to eq(false)
    end
    
    it 'should save successfully' do 
      user = User.new(user_name: 'username', email: 'sample@example.com', password: 'password').save
      expect(user).to eq(true)
    end
  end
end