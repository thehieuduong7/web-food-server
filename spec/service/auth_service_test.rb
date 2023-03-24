require 'rails_helper'

RSpec.describe UsersService do
  let!(:user_service) {UsersService.new}
  describe '#hash password' do
    it 'input valid password' do
      password = '123QWEasd'
      hash = user_service.hash_bcrypt(password)
      expect(hash).not_to eq(password)
      expect(user_service.equal_hash?(hash, password)).to eq(true)
    end
    it 'input special character' do
      password = '123@!#sad'
      hash = user_service.hash_bcrypt(password)
      expect(hash).not_to eq(password)
      expect(user_service.equal_hash?(hash, password)).to eq(true)
    end
    it 'input nil' do
      password = nil
      hash = user_service.hash_bcrypt(password)
      expect(hash).not_to eq(password)
      expect(user_service.equal_hash?(hash, password)).to eq(true)
    end
  end
end
