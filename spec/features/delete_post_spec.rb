feature 'Deleting a post' do
  scenario 'A user can delete a post' do
    test_user = create_test_user()
    test_user_sign_in()
    Post.add(title: 'testing', body: 'still testing', user_id: test_user.id)
    visit('/posts')
    expect(page).to have_content('testing')
    expect(page).to have_content('still testing')

    first('.post').click_button 'Delete'

    expect(page).to have_current_path('/posts')
    expect(page).to have_content('Post was deleted')
    expect(page).not_to have_content('testing')
    expect(page).not_to have_content('still testing')
  end
end
