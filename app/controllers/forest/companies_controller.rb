class Forest::CompaniesController < ForestLiana::ApplicationController
  def mark_as_live
    render status: 400, json: { error: 'You can only read data on this public demo application.' }
  end

  def upload_legal_docs
    render status: 400, json: { error: 'You can only read data on this public demo application.' }
  end
end
