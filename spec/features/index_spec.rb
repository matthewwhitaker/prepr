feature 'hello' do
  scenario 'sees hello at start of app' do
    visit('/')
    expect(page).to have_content('Hello, World!')
  end
end
