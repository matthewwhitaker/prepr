require 'post'

describe Post do
  before(:each) do
    prepare_test_database()
  end
  
  describe '.all' do
    it 'adds posts and returns all stored posts' do
      test_user = create_test_user()
      Post.add(body: 'here is the first post', title: 'post title 1', user_id: test_user.id)
      Post.add(body: 'here is the second', title: 'post title 2', user_id: test_user.id)
      Post.add(body: 'and here is the third', title: 'post title 3', user_id: test_user.id)
      posts = Post.all
      expect(posts[0].title).to eq('post title 1')
      expect(posts[0].body).to eq('here is the first post')
      expect(posts[0].user_id).to eq(test_user.id)
      expect(posts[1].title).to eq('post title 2')
      expect(posts[1].body).to eq('here is the second')
      expect(posts[1].user_id).to eq(test_user.id)
      expect(posts[2].title).to eq('post title 3')
      expect(posts[2].body).to eq('and here is the third')
      expect(posts[2].user_id).to eq(test_user.id)
    end
  end

  describe '.add' do
    it 'creates a new post and checks returned data' do
      test_user = create_test_user()
      test_post = Post.add(body: 'this is a test', title: 'this is the title of the test post', user_id: test_user.id)
      expect(test_post).to be_a Post
      expect(test_post.title).to eq('this is the title of the test post')
      expect(test_post.body).to eq('this is a test')
    end
  end

  describe '.delete' do
    it "adds a new post, then deletes it" do
      test_user = create_test_user()
      test_post = Post.add(body: 'this will be deleted', title: 'delete this', user_id: test_user.id)
      Post.delete(id: test_post.id)
      expect(Post.all).not_to include('this will be deleted')
      expect(Post.all).not_to include('delete this')
    end
  end

  describe '.update' do
    it "adds a new post, then updates it" do
      test_user = create_test_user()
      test_post = Post.add(body: 'this will be updated', title: 'update this', user_id: test_user.id)
      Post.update(id: test_post.id, title: 'this is the new title', body: 'this is the new body')
      updated_post = Post.find(id: test_post.id)
      expect(updated_post.title).not_to eq('this will be updated')
      expect(updated_post.body).not_to eq('update this')
      expect(updated_post.title).to eq('this is the new title')
      expect(updated_post.body).to eq('this is the new body')
    end
  end

  describe '.find' do
    it "adds a new post, then finds it" do
      test_user = create_test_user()
      test_post = Post.add(body: 'this will be updated', title: 'update this', user_id: test_user.id)
      found_post = Post.find(id: test_post.id)

      expect(found_post).to be_a Post
      expect(found_post.id).to eq(test_post.id)
      expect(found_post.title).to eq(test_post.title)
      expect(found_post.body).to eq(test_post.body)
      expect(found_post.user_id).to eq(test_post.user_id)
    end
  end
end
