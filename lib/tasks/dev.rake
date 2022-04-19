task sample_data: :environment do
  p "Creating sample data"

  # clear out the tables before generating sample data:
  if Rails.env.development?
    Like.destroy_all
    Comment.destroy_all
    Photo.destroy_all
    FollowRequest.destroy_all
    User.destroy_all
  end

  #create random users in the users table
  12.times do
    name = Faker::Name.first_name.downcase
    u = User.create(
      email: "#{name}@example.com",
      username: name,
      password: "password",
      private: [true, false].sample
    )

    # p u.errors.full_messages
  end

  p "#{User.count} users have been created"

  # create random following requests
  users = User.all

  users.each do |first_user|
    users.each do |second_user|
      if rand < 0.75
        first_user.sent_follow_requests.create(
          recipient: second_user,
          status: FollowRequest.statuses.keys.sample # this is the same as ["pending", "accepted", "rejected"].sample
        )
      end

      if rand < 0.75
        second_user.sent_follow_requests.create(
          recipient: first_user,
          status: FollowRequest.statuses.keys.sample # this is the same as ["pending", "accepted", "rejected"].sample
        )
      end
    end
  end

  p "#{FollowRequest.count} follow requests have been created"

  users.each do |user|
    rand(15).times do
      photo = user.own_photos.create(
        caption: Faker::Quote.jack_handey,
        image: "https://robohash.org/#{rand(9999)}"
      )

      user.followers.each do |follower|
        if rand < 0.5
          photo.fans << follower # shovel operator here creates a record in the joined table (likes table)
        end
    
        if rand < 0.25
          photo.comments.create(
            body: Faker::Quote.jack_handey,
            author: follower
          )
        end
      end
    end
  end
  p "#{Photo.count} photos have been created"
  p "#{Like.count} likes have been created"
  p "#{Comment.count} comments have been created"
end