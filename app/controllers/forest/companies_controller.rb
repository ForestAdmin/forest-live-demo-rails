class Forest::CompaniesController < ForestLiana::ApplicationController
  def mark_as_live
    render json: { success: 'You can only read data on this public demo application.' }
  end

  def upload_legal_docs
    render json: { success: 'You can only read data on this public demo application.' }
  end
end
