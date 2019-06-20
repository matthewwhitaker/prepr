require 'post'

describe Post do
  describe '.all' do
    it "returns all stored posts" do
      posts = Post.all

      expect(posts).to include('post 1')
      expect(posts).to include('post 2')
      expect(posts).to include('post 3')
    end
  end
end
