# frozen_string_literal: true

def create_test_user
  User.create(email: 'tester@testing.com', username: 'tester', password: 'thisisatest')
end

def sign_in_test_user
  visit('/sessions/new')
  fill_in('email', with: 'tester@testing.com')
  fill_in('password', with: 'thisisatest')
  click_button('Submit')
end

def create_test_post
  visit('/posts/new')
  fill_in('post_title', with: 'test title!')
  fill_in('post_body', with: 'Testing 1 2... this thing on?')
  click_button('Submit')
end
