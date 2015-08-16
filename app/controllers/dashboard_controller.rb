class DashboardController < ApplicationController
  def show
    @feed = client.user_events(current_user.nickname)
  end

  def client
    @client ||= Octokit::Client.new(access_token: current_user.token)
  end
end
