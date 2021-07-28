
Post.delete_all
Comment.delete_all


75.times do 
    created_at = Faker::Date.backward(days: 365 * 2)
    p = Post.create(
        title: Faker::Hipster.unique.sentence,
        body: Faker::Hipster.paragraph_by_chars(characters: 256, supplemental: false),
        created_at: created_at,
        updated_at: created_at
    )
    if p.valid? 
        p.comments = rand(0..15).times.map do 
          Comment.new(body: Faker::TvShows::DrWho.quote)
        end
    end
end

post = Post.all 
comment = Comment.all

puts Cowsay.say("Generated #{post.count} posts", :frogs)
puts Cowsay.say("Generated #{comment.count} comments", :turkey)