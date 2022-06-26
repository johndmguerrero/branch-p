class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:edit, :update, :archive, :active, :destroy]

  def index
    @items = Products::Item.paginate(page: params[:page])
    @categories = Categories::Item.all
  end

  def create
    @item = ItemService.new(params: create_params, branch: current_branch)
    @item.add_item

    redirect_to @item.url, flash: @item.message
  end

  def edit
    @categories = Categories::Item.all
  end

  def update
    @item = ItemService.new(item: @item, params: update_params)
    @item.update_item

    redirect_to @item.url, flash: @item.message
  end

  def archive
    @item.archived!

    redirect_to edit_item_path(@item.id), flash: { notice: 'Item set to Archive' }
  end

  def active
    @item.active!

    redirect_to edit_item_path(@item.id), flash: { notice: 'Item set to Active' }
  end

  def destroy
    @item = ItemService.new(item: @item)
    @item.delete_item

    redirect_to @item.url, flash: @item.message
  end

  private

  def set_item
    @item = Products::Item.find_by id: params[:id]
  end

  def update_params
    params.require(:products_item).permit(:product, :name, :description, :category_id, :quantity, :image)
  end

  def create_params
    params.require(:product).permit(:product, :type, :description, :name, :category_id)
  end
end
