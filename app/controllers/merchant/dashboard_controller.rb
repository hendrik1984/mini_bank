class Merchant::DashboardController < ApplicationController
    def index
        @transactions = current_user.transactions.where("transaction_type = ? OR transaction_type = ?", "pay", "refund")
    end

    def category
        @category = Category.new
    end

    def create_category
        @category = Category.new(category_params)
        
        if @category.save
            redirect_to merchant_dashboard_path, notice: "New Category #{@category.name} created!"
        else
            flash.now[:alert] = "Invalid category" # update with error in view instead flash now
            render :category, status: :unprocessable_entity
        end
    end

    def product
        @product = Product.new
    end

    def create_product
        @product = Product.new(product_params)

        if @product.save
            redirect_to merchant_dashboard_path, notice: "New Product #{@product.name} created!"
        else
            flash.now[:alert] = "Invalid product"
            render :product, status: :unprocessable_entity
        end
    end

    private

    def category_params
        params.require(:category).permit(:name, :status, :user_id)
    end

    def product_params
        params.require(:product).permit(:name, :sku, :price, :images, :quantity, :unlimited, :status, :category_id)
    end
end
