ForestLiana::ApplicationController.class_eval do
  def authenticate_user_from_jwt
    # This is a public live-demo project. That's why we bypass the Forest
    # Liana authentication method here.

    # TODO: Get rid of this dirty hack and implement a real authentication for the livedemo
    @rendering_id = 23065
  end
end
