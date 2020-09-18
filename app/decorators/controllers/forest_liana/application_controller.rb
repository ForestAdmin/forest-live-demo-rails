ForestLiana::ApplicationController.class_eval do
  def authenticate_user_from_jwt
    # This is a public live-demo project. That's why we bypass the Forest
    # Liana authentication method here.

    #Use the following for production.
    #Use one of your own user in your database
    # belonging to the project you set up as the live demo
    @jwt_decoded_token = {
       id: "2960",
       email: "erlich@aviato.com",
       first_name: "Erlich",
       last_name: "Bachman",
       team: "Operations",
       rendering_id: "23065",
    }
    @rendering_id = @jwt_decoded_token[:rendering_id]
  end
end
