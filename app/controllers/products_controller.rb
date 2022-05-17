class ProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    @products = Product.includes(:category).paginate(page: params[:page])
    @category = Categories::Product.all
  end

  def create
    @product = ProductService.new(params: create_params, branch: current_branch)
    @product.add_product

    redirect_to @product.url, flash: @product.message
  end

  private

  def create_params
    params.require(:product).permit(:product, :price, :cost, :description, :name, :category_id)
  end
end
