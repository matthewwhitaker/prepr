feature 'user registration happy paths' do
  scenario 'user can sign up' do
    visit('/users/new')
    fill_in('email', with: 'tester@testing.com')
    fill_in('username', with: 'tester')
    fill_in('password', with: 'thisisatest')
    click_button('Submit')
    expect(page).to have_current_path('/posts')
    expect(page).to have_content('Welcome, tester!')
  end
end

feature 'user registration unhappy paths' do
  scenario 'user cannot sign up with blank fields' do
    visit('/users/new')
    fill_in('username', with: 'tester')
    fill_in('password', with: 'thisisatest')
    click_button('Submit')
    expect(page).to have_current_path('/users/new')
    expect(page).to have_content('Please fill out all fields.')
  end

  scenario 'user cannot sign up with blank fields' do
    visit('/users/new')
    fill_in('email', with: 'tester@testing.com')
    fill_in('password', with: 'thisisatest')
    click_button('Submit')
    expect(page).to have_current_path('/users/new')
    expect(page).to have_content('Please fill out all fields.')
  end

  scenario 'user cannot sign up with blank fields' do
    visit('/users/new')
    fill_in('email', with: 'tester@testing.com')
    fill_in('username', with: 'tester')
    click_button('Submit')
    expect(page).to have_current_path('/users/new')
    expect(page).to have_content('Please fill out all fields.')
  end

  scenario 'user cannot sign up with blank fields' do
    visit('/users/new')
    fill_in('password', with: 'thisisatest')
    click_button('Submit')
    expect(page).to have_current_path('/users/new')
    expect(page).to have_content('Please fill out all fields.')
  end

  scenario 'user cannot sign up with blank fields' do
    visit('/users/new')
    fill_in('email', with: 'tester@testing.com')
    click_button('Submit')
    expect(page).to have_current_path('/users/new')
    expect(page).to have_content('Please fill out all fields.')
  end

  scenario 'user cannot sign up with blank fields' do
    visit('/users/new')
    fill_in('username', with: 'tester')
    click_button('Submit')
    expect(page).to have_current_path('/users/new')
    expect(page).to have_content('Please fill out all fields.')
  end

  scenario 'user cannot sign up with blank fields' do
    visit('/users/new')
    click_button('Submit')
    expect(page).to have_current_path('/users/new')
    expect(page).to have_content('Please fill out all fields.')
  end
end
