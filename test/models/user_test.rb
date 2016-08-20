require 'test_helper'

class UserTest < ActiveSupport::TestCase

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
    # Pour faire plus court, on utilise ici ce que l'on a entrer dans le users.yml (fixtures)
    user.profile_name = users(:jason).profile_name

    assert !user.save
    assert !user.errors[:profile_name].empty?
  end

  test "A user should have a profile name without spaces " do
    user = User.new
    user.profile_name ="My profile name with spaces"

    assert !user.save
    assert !user.errors[:profile_name].empty?
    assert user.errors[:profile_name].include?("Must be formated correctly.")
  end
end
