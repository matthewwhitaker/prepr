feature 'login' do
  scenario 'user can log into an existing account' do
    create_test_user()
    test_user_sign_in()

    expect(page).to have_current_path('/posts')
    expect(page).to have_content('Welcome, tester!')
  end

  scenario 'error message when logging in with incorrect email' do
    User.create(email: 'tester@testing.com', username: 'tester', password: 'thisisatest')

    visit('/sessions/new')
    fill_in('email', with: 'incorrect@incorrect.com')
    fill_in('password', with: 'thisisatest')
    click_button('Submit')

    expect(page).to have_current_path('/sessions/new')
    expect(page).to have_content('incorrect email/password combination.')
  end

  scenario 'error message when logging in with incorrect password' do
    User.create(email: 'tester@testing.com', username: 'tester', password: 'thisisatest')

    visit('/sessions/new')
    fill_in('email', with: 'tester@testing.com')
    fill_in('password', with: 'incorrect1234')
    click_button('Submit')

    expect(page).to have_current_path('/sessions/new')
    expect(page).to have_content('incorrect email/password combination.')
  end

  scenario 'user can log out at the end of their session' do
    User.create(email: 'tester@testing.com', username: 'tester', password: 'thisisatest')

    visit('/sessions/new')
    fill_in('email', with: 'tester@testing.com')
    fill_in('password', with: 'thisisatest')
    click_button('Submit')

    click_button('Sign out')

    expect(page).not_to have_content('Welcome, tester!')
    expect(page).to have_content('You have been successfully signed out.')
  end

end
