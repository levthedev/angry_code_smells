class User < ActiveRecord::Base
  def self.find_or_create_from_oauth(oauth)
    user = User.find_or_create_by(provider: oauth.provider, uid: oauth.uid)
    user.email     = oauth.info.email
    user.nickname  = oauth.info.nickname
    user.image_url = oauth.info.image
    user.token     = oauth.credentials.token
    user.save
    user
  end

  def client
    client = Octokit::Client.new(access_token: token)
    Octokit.auto_paginate = true
    client
  end

  def repos
    Octokit.auto_paginate = true
    client.repos.map(&:name)
  end

  def pull_requests(repo)
    Octokit.auto_paginate = true
    client.pull_requests("#{nickname}/#{repo}")
  end

  def pull_request_comments(repo)
    Octokit.auto_paginate = true
    pull_requests(repo).each_with_index do |pull, index|
      pr_comments = client.pull_request_comments("#{nickname}/#{pull}", index + 1)
      pr_comments.map(&:body)
    end
  end
end
