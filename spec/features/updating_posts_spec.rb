feature 'update posts' do
  it 'creates post and updates post title and body from prep-populated form' do
    test_user = create_test_user
    sign_in_test_user
    test_post = Post.add(title: 'this title will change', body: 'this body will change', user_id: test_user.id)
    visit('/posts')
    expect(page).to have_content('this title will change')
    expect(page).to have_content('this body will change')

    first('.post').click_button 'Edit'
    expect(current_path).to eq "/posts/#{test_post.id}/edit"

    expect(page).to have_field('post_title', with: 'this title will change')
    expect(page).to have_field('post_body', with: 'this body will change')

    fill_in('post_title', with: 'this title has changed')
    fill_in('post_body', with: 'this body has changed')
    click_button('Submit')

    expect(page).to have_current_path('/posts')
    expect(page).to have_content('Post was updated')
    expect(page).to have_content('this title has changed')
    expect(page).to have_content('this body has changed')

    expect(page).not_to have_content('this title will change')
    expect(page).not_to have_content('this body will change')
  end
end
