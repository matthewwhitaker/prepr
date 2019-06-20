feature 'shows posts' do
  scenario 'shows all current posts' do
    visit('/posts')
    expect(page).to have_content('post 1')
    expect(page).to have_content('post 2')
    expect(page).to have_content('post 1')
  end
end
