require 'user'

describe User do
  describe '.create' do
    it 'takes params and creates a user object' do
      test_user = User.create(email: 'tester@testing.com', username: 'tester', password: 'thisisatest')
      expect(test_user).to be_a User
      expect(test_user.email).to eq('tester@testing.com')
      expect(test_user.username).to eq('tester')
    end

    it 'hashes the password given by the user' do
      expect(BCrypt::Password).to receive(:create).with('thisisatest')
      User.create(email: 'tester@testing.com', username: 'tester', password: 'thisisatest')
    end
  end

  describe '.find' do
    it 'stores a user in the database then can retrieve them' do
      test_user = User.create(email: 'tester@testing.com', username: 'tester', password: 'thisisatest')
      found_user = User.find(id: test_user.id)

      expect(test_user.id).to eq(found_user.id)
      expect(test_user.email).to eq(found_user.email)
    end

    it 'returns null if no user_id in session' do
      expect(User.find(id: nil)).to eq(nil)
    end
  end

  describe '.authenticate' do
    it 'confirms a user with correct details is valid' do
      test_user = User.create(email: 'tester@testing.com', username: 'tester', password: 'thisisatest')
      authenticated_user = User.authenticate(email: 'tester@testing.com', password: 'thisisatest')
      expect(authenticated_user.id).to eq(test_user.id)
    end

    it 'rejects a user with unrecognised email' do
      test_user = User.create(email: 'tester@testing.com', username: 'tester', password: 'thisisatest')
      expect(User.authenticate(email: 'blah@blah.com', password: 'thisisatest')).to be_nil
    end

    it 'rejects a user with wrong password' do
      test_user = User.create(email: 'tester@testing.com', username: 'tester', password: 'thisisatest')
      expect(User.authenticate(email: 'tester@testing.com', password: 'incorrect1234')).to be_nil
    end
  end
end
