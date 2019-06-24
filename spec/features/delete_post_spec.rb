feature 'Deleting a post' do
  scenario 'A user can delete a post' do
    create_test_user
    sign_in_test_user
    create_test_post
    expect(page).to have_content('test title!')
    expect(page).to have_content('Testing 1 2... this thing on?')

    first('.post').click_button 'Delete'

    expect(page).to have_current_path('/posts')
    expect(page).to have_content('Post has been deleted')
    expect(page).not_to have_content('test title!')
    expect(page).not_to have_content('Testing 1 2... this thing on?')
  end
end
