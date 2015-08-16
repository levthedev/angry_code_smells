class DashboardController < ApplicationController
  def show
  end

  def client
    @client ||= Octokit::Client.new(access_token: current_user.token)
  end
end
