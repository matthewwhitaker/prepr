feature 'Visiting homepage' do
  scenario 'redirects from index to posts' do
    visit('/')
    expect(page).to have_current_path('/posts')
  end

  scenario 'navbar renders correctly when signed in' do
    create_test_user
    sign_in_test_user
    page.find_link(class: 'navbar-brand')
    page.find_button('Add new post')
    page.find_button('Sign out')
    expect(page).not_to have_button('Sign in')
    expect(page).not_to have_button('Sign up')
  end

  scenario 'navbar renders correctly when signed out' do
    visit('/')
    page.find_link(class: 'navbar-brand')
    page.find_button('Sign in')
    page.find_button('Sign up')
    expect(page).not_to have_button('Add new post')
    expect(page).not_to have_button('Sign out')
  end
end
