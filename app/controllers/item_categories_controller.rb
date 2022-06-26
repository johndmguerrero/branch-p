class ItemCategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: [:edit, :update, :remove_category]

  def create
    @category = Category.create(category_params)
    @categories = Categories::Item.includes(:items).all

    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: [
          turbo_stream.update("list-categories", partial: 'items/partials/category_list', locals: { categories: @categories }),
          turbo_stream.update("form-category-item", partial: 'items/partials/form_category', locals: { url: item_categories_path, action: 'create', method: :post, model: Category.new })
        ]
      }
    end
  end

  def edit
    respond_to do |format|
      format.turbo_stream { 
        render turbo_stream: turbo_stream.update("form-category-item", partial: 'items/partials/form_category', locals: { url: item_category_path(id: @category), action: 'update', method: :patch, model: @category }) }
    end
  end

  def update
    @category.update(category_params)
    @categories = Categories::Item.includes(:items).all

    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: [
          turbo_stream.update("list-categories", partial: 'items/partials/category_list', locals: { categories: @categories }),
          turbo_stream.update("form-category-item", partial: 'items/partials/form_category', locals: { url: item_categories_path, action: 'create', method: :post, model: Category.new })
        ]
      }
    end
  end

  def remove_category
    @category.destroy if @category.items.size == 0
    @categories = Categories::Item.includes(:items).all

    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: turbo_stream.update("list-categories", partial: 'items/partials/category_list', locals: { categories: @categories })
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
