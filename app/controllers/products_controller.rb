class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:edit, :update, :destroy, :archive, :active]
  before_action :set_product_deleted, only: [:recover]

  def index
    @products = Product.paginate(page: params[:page])
    @products = Product.send(params[:type].to_sym).paginate(page: params[:page]) if params[:type].present?
    @category = Categories::Product.all
  rescue
    redirect_to products_path
  end

  def create
    @product = ProductService.new(params: create_params, branch: current_branch)
    @product.add_product

    redirect_to @product.url, flash: @product.message
  end

  def edit
    @category = Categories::Product.all
  end

  def update
    @product = ProductService.new(product: @product, params: update_params)
    @product.update_product

    redirect_to @product.url, flash: @product.message
  end

  def archive
    @product.archived!

    redirect_to edit_product_path(@product.id), flash: { notice: 'Product set to Archive' }
  end

  def active
    @product.active!

    redirect_to edit_product_path(@product.id), flash: { notice: 'Product set to Active' }
  end

  def recover
    @product.recover!

    redirect_to edit_product_path(@product.id), flash: { notice: 'Product recovered!' }
  rescue => e
    redirect_to products_path(type: 'deleted'), flash: { alert: e }
  end

  def destroy
    @product = ProductService.new(product: @product)
    @product.delete_product

    redirect_to @product.url, flash: @product.message
  end

  private

  def create_params
    params.require(:product).permit(:product, :price, :cost, :description, :name, :category_id)
  end

  def update_params
    params.require(:product).permit(:product, :name, :description, :category_id, :price, :cost, :quantity, :image)
  end

  def set_product
    @product = Product.find_by id: params[:id]
  end

  def set_product_deleted
    @product = Product.only_deleted.find_by id: params[:id]
  end
end
