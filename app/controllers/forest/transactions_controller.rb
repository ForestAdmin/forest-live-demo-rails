class Forest::TransactionsController < ForestLiana::ApplicationController

  def approve_transaction
    id_transaction = params.dig('data','attributes')["ids"].first.to_i
    Transaction.update(id_transaction, status: 'validated')
    render json: { success: 'Transaction status has been validated' }
  end
end

