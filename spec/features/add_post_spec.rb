feature 'add post' do
  scenario 'user adds new post' do
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
end
