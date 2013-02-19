class PushesController < ApplicationController

  def create
    payload = JSON.parse(params[:payload])
    @push = Push.new(payload)
    # we don't use validation
    # more of an audit trail so we want to save everything
    if @push.save(validate: false)
      render json: @push, status: :created, location: @push
    else
      render json: @push.errors, status: :unprocessable_entity
    end
  end

  def index
    push = Push.last
    repo = push.repository
    # Repo Name, Branch name,
    render json: {repo: repo['name'], head_commit: push.head_commit['id']}, status: :ok
  end
end
