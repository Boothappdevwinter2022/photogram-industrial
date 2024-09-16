class UsersController < ApplicationController
  def show
    @user = User.find_by!(username: params.fetch(:username)) # use find_by! so that it will return an error if cannot find user instead of returning a nil
  end
end