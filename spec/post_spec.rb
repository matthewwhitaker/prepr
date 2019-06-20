require 'post'

describe Post do
  describe '.all' do
    it "returns all stored posts" do
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
    it 'creates a new post' do
      test_post = Post.add(body: 'this is a test', title: 'this is the title of the test post')
      expect(test_post.title).to eq('this is the title of the test post')
      expect(test_post.body).to eq('this is a test')
    end
  end
end
