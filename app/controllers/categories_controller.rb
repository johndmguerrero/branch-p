class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: [:edit, :update, :remove_category]

  def create
    @category = Category.create(category_params)
    @categories = Categories::Product.includes(:products).all

    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: [
          turbo_stream.update("list-categories", partial: 'products/partials/category_list', locals: { categories: @categories }),
          turbo_stream.update("form-category-product", partial: 'products/partials/form_category', locals: { url: categories_path, action: 'create', method: :post, model: Category.new })
        ]
      }
    end
  end

  def edit
    respond_to do |format|
      format.turbo_stream { 
        render turbo_stream: turbo_stream.update("form-category-product", partial: 'products/partials/form_category', locals: { url: category_path(id: @category), action: 'update', method: :patch, model: @category }) }
    end
  end

  def update
    @category.update(category_params)
    @categories = Categories::Product.includes(:products).all

    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: [
          turbo_stream.update("list-categories", partial: 'products/partials/category_list', locals: { categories: @categories }),
          turbo_stream.update("form-category-product", partial: 'products/partials/form_category', locals: { url: categories_path, action: 'create', method: :post, model: Category.new })
        ]
      }
    end
  end

  def remove_category
    @category.destroy if @category.products.size == 0
    @categories = Categories::Product.includes(:products).all

    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: turbo_stream.update("list-categories", partial: 'products/partials/category_list', locals: { categories: @categories })
      }
    end
  end

  private

  def set_category
    @category = Category.find_by id: params[:id]
  end

  def category_params
    params.require(:category).permit(:name, :description, :type)
  end
end
