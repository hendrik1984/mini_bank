class TransactionsController < ApplicationController
  before_action :require_login

  def index
    @transactions = Transaction.where("user_id = ? OR recipient_id = ?", current_user.id, current_user.id).order(created_at: :desc).limit(20)
  end

  def new
    @transaction = Transaction.new
  end

  def confirmation_transfer
    @transaction = current_user.transactions.build(transaction_params)

    if current_user.username == params[:transaction][:recipient_username]
      flash.now[:alert] = "Please check your recipient username"
      return render :new, status: :unprocessable_entity
    end

    @recipient = User.find_by(username: params[:transaction][:recipient_username])
    
    if @recipient.nil?
      flash.now[:alert] = "Recipient not found."
      return render :new, status: :unprocessable_entity
    end
    
    @transaction.recipient = @recipient

    render :confirmation_transfer
  end

  def create
    @transaction = current_user.transactions.build(transaction_params)

    if @transaction.transaction_type == "transfer"
      recipient = User.find_by(id: params[:transaction][:recipient_id])
      @transaction.recipient = recipient
    end
    
    if @transaction.save
      redirect_to transactions_path, notice: "Transaction successful!"
    else
      flash.now[:alert] = "Transaction failed!"
      @users = User.where.not(id: current_user.id)
      render :new, status: :unprocessable_entity
    end
  end

  

  private
  def transaction_params
    params.require(:transaction).permit(:transaction_type, :amount, :recipient_id, :recipient_username)
  end

end
