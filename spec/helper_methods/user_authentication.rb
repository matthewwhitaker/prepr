def create_test_user
  User.create(email: 'tester@testing.com', username: 'tester', password: 'thisisatest')
end

def test_user_sign_in
  visit('/sessions/new')
  fill_in('email', with: 'tester@testing.com')
  fill_in('password', with: 'thisisatest')
  click_button('Submit')
end
