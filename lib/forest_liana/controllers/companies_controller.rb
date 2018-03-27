if ForestLiana::UserSpace.const_defined?('CompanyController')
  ForestLiana::UserSpace::CompanyController.class_eval do
    alias_method :default_destroy, :destroy

    def destroy
      teams = forest_user.dig('data', 'data', 'teams')
      if teams.include?('Management')
        default_destroy
      else
        render status: 403, plain: 'Sorry, you\'re now allowed to delete a company. Ask someone in the Management team.'
      end
    end
  end
end
