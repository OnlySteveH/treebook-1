require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should have_many(:user_friendships)
  should have_many(:friends)

  test "A user should enter a first name" do
    user = User.new
    assert !user.save
    assert !user.errors[:first_name].empty?
  end
  test "A user should enter a last name" do
    user = User.new
    assert !user.save
    assert !user.errors[:last_name].empty?
  end
  test "A user should enter a profile name" do
    user = User.new
    assert !user.save
    assert !user.errors[:profile_name].empty?
  end

  test "A user should have a unique profile name" do
    user = User.new
    user.profile_name ='jasonseifer'
    # user.last_name ="Seifer"
    # user.first_name ="Jason"
    # user.email ="jason@tree.com"
    # user.password ="123456"
    # user.password_confirmation ="123456"
    # Pour faire plus court, on utilise ici ce que l'on a entré dans le users.yml (fixtures)
    user.profile_name = users(:jason).profile_name

    assert !user.save
    assert !user.errors[:profile_name].empty?
  end

  test "A user should have a profile name without spaces " do
    user = User.new(first_name: 'Jason', last_name:'Seifer', email: 'jason2@tree.com')
    user.password = user.password_confirmation = '123456'

    user.profile_name ="My profile name with spaces"

    assert !user.save
    assert !user.errors[:profile_name].empty?
    assert user.errors[:profile_name].include?("Must be formatted correctly.")
  end

  test "A user can have a correctly formated profile name" do
    skip
    user = User.new(first_name: 'Jason', last_name:'Seifer', email: 'jason2@tree.com')
    user.password = user.password_confirmation = '123456'
    user.profile_name ="jasonseifer_1"
    assert user.valid?
  end

  test "that no error is raised when trying to access a friend list " do
    assert_nothing_raised do
      users(:jason).friends
    end
  end

  test "that creating friendship on a user works" do
     users(:jason).friends << users(:mike)
     users(:jason).friends.reload
     assert users(:jason).friends.include?(users(:mike))
  end

  test "that creating a friendship based on a user id and a friend id works" do
    UserFriendship.create user_id: users(:jason).id, friend_id: users(:mike).id
    assert users(:jason).friends.include?(users(:mike))

  end
end
