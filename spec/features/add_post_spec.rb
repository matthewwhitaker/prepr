feature 'add post' do
  scenario 'user adds new post' do
    User.create(email: 'tester@testing.com', username: 'tester', password: 'thisisatest')

    visit('/sessions/new')
    fill_in('email', with: 'tester@testing.com')
    fill_in('password', with: 'thisisatest')
    click_button('Submit')

    visit('/posts/new')
    fill_in('post_body', with: 'Testing 1 2... this thing on?')
    fill_in('post_title', with: 'test title!')
    click_button('Submit')
    expect(page).to have_content('Testing 1 2... this thing on?')
    expect(page).to have_content('test title!')
    expect(page).to have_current_path('/posts')
  end

  # scenario 'user cannot submit blank title in a post' do
  #   visit('/posts/new')
  #   # fill_in('post_title', with: '')
  #   click_button('Submit')
  #   expect(page).to have_current_path('/posts/new')
  # end

  scenario 'user cannot see post button unless signed in' do
    visit('/posts')
    expect(page).not_to have_button("Add new post")
  end

  scenario 'user cannot reach post route unless signed in' do
    visit('/posts/new')
    expect(page).to have_current_path('/sessions/new')
    expect(page).to have_content('Please log in or sign up to create a new post.')
  end

  scenario 'post shows username of who made it' do
    User.create(email: 'tester@testing.com', username: 'tester', password: 'thisisatest')

    visit('/sessions/new')
    fill_in('email', with: 'tester@testing.com')
    fill_in('password', with: 'thisisatest')
    click_button('Submit')

    visit('/posts/new')
    fill_in('post_body', with: 'Testing 1 2... this thing on?')
    fill_in('post_title', with: 'test title!')
    click_button('Submit')
    expect(page).to have_content('Testing 1 2... this thing on?')
    expect(page).to have_content('test title!')
    expect(page).to have_content('Posted by tester')
    expect(page).to have_current_path('/posts')
  end
end
