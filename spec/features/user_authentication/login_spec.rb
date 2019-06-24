feature 'login' do
  scenario 'user can log into an existing account' do
    create_test_user
    sign_in_test_user

    expect(page).to have_current_path('/posts')
    expect(page).to have_content('You have been successfully signed in.')
  end

  scenario 'error message when logging in with incorrect email' do
    create_test_user

    visit('/')
    click_button('Sign in')
    fill_in('email', with: 'incorrect@incorrect.com')
    fill_in('password', with: 'thisisatest')
    click_button('Submit')

    expect(page).to have_current_path('/sessions/new')
    expect(page).to have_content('incorrect email/password combination.')
  end

  scenario 'error message when logging in with incorrect password' do
    create_test_user

    visit('/sessions/new')
    fill_in('email', with: 'tester@testing.com')
    fill_in('password', with: 'incorrect1234')
    click_button('Submit')

    expect(page).to have_current_path('/sessions/new')
    expect(page).to have_content('incorrect email/password combination.')
  end

  scenario 'user can log out at the end of their session' do
    create_test_user
    sign_in_test_user

    click_button('Sign out')

    expect(page).to have_current_path('/posts')
    expect(page).to have_content('You have been successfully signed out.')
  end
end
