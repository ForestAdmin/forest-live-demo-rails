class Forest::AdminsController < ForestLiana::ApplicationController
  def whoami
    first_name = forest_user['data']['data']['first_name']
    last_name = forest_user['data']['data']['last_name']

    render json: { success: "You are #{first_name} #{last_name}." }
  end
end

