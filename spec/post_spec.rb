require 'post'

describe Post do
  describe '.all' do
    it 'adds posts and returns all stored posts' do
      Post.add(body: 'here is the first post', title: 'post title 1')
      Post.add(body: 'here is the second', title: 'post title 2')
      Post.add(body: 'and here is the third', title: 'post title 3')
      posts = Post.all
      expect(posts[0].title).to eq('post title 1')
      expect(posts[0].body).to eq('here is the first post')
      expect(posts[1].title).to eq('post title 2')
      expect(posts[1].body).to eq('here is the second')
      expect(posts[2].title).to eq('post title 3')
      expect(posts[2].body).to eq('and here is the third')
    end
  end

  describe '.add' do
    it 'creates a new post and checks returned data' do
      test_post = Post.add(body: 'this is a test', title: 'this is the title of the test post')
      expect(test_post).to be_a Post
      expect(test_post.title).to eq('this is the title of the test post')
      expect(test_post.body).to eq('this is a test')
    end
  end

  describe '.delete' do
    it "adds a new post, then deletes it" do
      test_post = Post.add(body: 'this will be deleted', title: 'delete this')
      Post.delete(id: test_post.id)
      expect(Post.all).not_to include('this will be deleted')
      expect(Post.all).not_to include('delete this')
    end
  end

  describe '.update' do
    it "adds a new post, then updates it" do
      test_post = Post.add(body: 'this will be updated', title: 'update this')
      Post.update(id: test_post.id, title: 'this is the new title', body: 'this is the new body')
      expect(Post.all[0].title).not_to eq('this will be updated')
      expect(Post.all[0].body).not_to eq('update this')
      expect(Post.all[0].title).to eq('this is the new title')
      expect(Post.all[0].body).to eq('this is the new body')
    end
  end

  describe '.find' do
    it "adds a new post, then finds it" do
      test_post = Post.add(body: 'this will be updated', title: 'update this')
      found_post = Post.find(id: test_post.id)
      expect(found_post.id).to eq(test_post.id)
      expect(found_post.title).to eq(test_post.title)
      expect(found_post.body).to eq(test_post.body)
    end
  end
end
