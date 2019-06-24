# frozen_string_literal: true

feature 'add post' do
  scenario 'user adds new post' do
    create_test_user
    sign_in_test_user
    create_test_post
    expect(page).to have_content('Testing 1 2... this thing on?')
    expect(page).to have_content('test title!')
    expect(page).to have_current_path('/posts')
  end

  scenario 'user cannot see post button unless signed in' do
    visit('/posts')
    expect(page).not_to have_button('Add new post')
  end

  scenario 'user cannot reach post route unless signed in' do
    visit('/posts/new')
    expect(page).to have_current_path('/sessions/new')
    expect(page).to have_content('Please log in or sign up.')
  end

  scenario 'post shows username of who made it' do
    create_test_user
    sign_in_test_user
    create_test_post
    expect(page).to have_content('Testing 1 2... this thing on?')
    expect(page).to have_content('test title!')
    expect(page).to have_content('Posted by tester')
    expect(page).to have_current_path('/posts')
  end
end
