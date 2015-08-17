class UsersController < ApplicationController
  def show
    @user = current_user
  end

  def update
    if current_user.update_attributes(twitter: params[:user][:twitter])
      redirect_to user_path(current_user)
    end
  end

  private

  def client
    @client ||= Octokit::Client.new(access_token: current_user.token)
  end

  def repos
    @client.repos.map(&:name)
  end

  def pull_requests(repo)
    @client.pull_requests("/#{current_user.nickname}/#{repo}")
  end

  def pull_request_comments(repo)
    pull_requests(repo).each_with_index do |pull, index|
      @client.pull_request_comments("#{current_user.nickname}/#{pull}", index + 1).map(&:body)
    end
  end
end
