feature 'Visiting homepage' do
  scenario 'redirects from index to posts' do
    visit('/')
    expect(page).to have_current_path('/posts')
  end
end
