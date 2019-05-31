class CheckoutsController < ApplicationController
	require "rubygems"
  require "braintree"

  TRANSACTION_SUCCESS_STATUSES = [
    Braintree::Transaction::Status::Authorizing,
    Braintree::Transaction::Status::Authorized,
    Braintree::Transaction::Status::Settled,
    Braintree::Transaction::Status::SettlementConfirmed,
    Braintree::Transaction::Status::SettlementPending,
    Braintree::Transaction::Status::Settling,
    Braintree::Transaction::Status::SubmittedForSettlement,
  ]

  def new
  
    @client_token = gateway.client_token.generate
    @issue_detail = IssueDetail.find(params[:issue_detail_id])
    @fine = params[:fine].to_i
  end

  def show
    @transaction = gateway.transaction.find(params[:id])
    @result = _create_result_hash(@transaction)
  end

  def create
    amount = params["amount"] # In production you should not take amounts directly from clients
    nonce = params["payment_method_nonce"]
    @issue_detail = IssueDetail.find(params[:id])

    result = gateway.transaction.sale(
      amount: amount,
      payment_method_nonce: nonce,
      :options => {
        :submit_for_settlement => true
      }
    )

    if result.success? || result.transaction
      @issue_detail.update_attributes(fine:amount, transaction_id:result.transaction.id, act_recieved_date:Date.today )
      redirect_to checkout_path(result.transaction.id)
    else
      error_messages = result.errors.map { |error| "Error: #{error.code}: #{error.message}" }
      flash[:error] = error_messages
      redirect_to new_checkout_path(issue_detail_id: @issue_detail.id, fine: amount)
      # redirect_to checkout_path(result.transaction.id)
    end
  end

  def _create_result_hash(transaction)
    status = transaction.status

    if TRANSACTION_SUCCESS_STATUSES.include? status
      result_hash = {
        :header => "Sweet Success!",
        :icon => "success",
        :message => "Your test transaction has been successfully processed. See the Braintree API response and try again."
      }
    else
      result_hash = {
        :header => "Transaction Failed",
        :icon => "fail",
        :message => "Your test transaction has a status of #{status}. See the Braintree API response and try again."
      }
    end
  end

  def gateway
    env = ENV["BT_ENVIRONMENT"]

    @gateway ||= Braintree::Gateway.new(
      :environment => :sandbox,
      :merchant_id => '2824qnfh4tzsqpm9',
      :public_key => '6tt949hw4x2bt7jc',
      :private_key => 'f2f6b1c495ce73091223cd9a1ef18875',
    )
  end
end
