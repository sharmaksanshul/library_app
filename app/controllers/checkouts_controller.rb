class CheckoutsController < ApplicationController
	require "rubygems"
  require "braintree"

  def new 
    @client_token = CheckoutsService.gateway.client_token.generate
    @issue_detail = IssueDetail.find(params[:id])
    @fine = params[:fine].to_i
  end

  def show
    @transaction = CheckoutsService.gateway.transaction.find(params[:id])
    @result = CheckoutsService._create_result_hash(@transaction)
  end

  def create
    amount = params["amount"] # In production you should not take amounts directly from clients
    issue_detail = IssueDetail.find(params[:id])
    result = CheckoutsService.transaction_sale(amount, params["payment_method_nonce"])
    status = CheckoutsService.transaction_status(issue_detail, amount, result)
    if status = "success"
      redirect_to checkout_path(result.transaction.id)
    else
      flash[:error] = status
      redirect_to new_checkout_path(id: issue_detail.id, fine: amount) 
    end
  end
end
