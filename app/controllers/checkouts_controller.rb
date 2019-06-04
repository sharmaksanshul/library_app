class CheckoutsController < ApplicationController
	require "rubygems"
  require "braintree"

  def new 
    @client_token = CheckoutsService.gateway.client_token.generate
    @issue_detail = IssueDetail.find(params[:issue_detail_id])
    @fine = params[:fine].to_i
  end

  def show
    @transaction =CheckoutsService.gateway.transaction.find(params[:id])
    @result = CheckoutsService._create_result_hash(@transaction)
  end

  def create
    amount = params["amount"] # In production you should not take amounts directly from clients
    nonce = params["payment_method_nonce"]
    @issue_detail = IssueDetail.find(params[:id])

    result = CheckoutsService.transaction_sale(amount, nonce)

    if result.success? || result.transaction
      @issue_detail.update_attributes(fine:amount, transaction_id:result.transaction.id, act_recieved_date:Date.today )
      redirect_to checkout_path(result.transaction.id)
    else
      error_messages = result.errors.map { |error| "Error: #{error.code}: #{error.message}" }
      flash[:error] = error_messages
      redirect_to new_checkout_path(issue_detail_id: @issue_detail.id, fine: amount)      
    end
  end
end
