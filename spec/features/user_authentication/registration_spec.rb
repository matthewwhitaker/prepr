feature 'user registration' do
  scenario 'user can sign up' do
    visit('/users/new')
    fill_in('email', with: 'tester@testing.com')
    fill_in('username', with: 'tester')
    fill_in('password', with: 'thisisatest')
    click_button('Submit')
    expect(page).to have_content('Welcome, tester!')
  end
end
