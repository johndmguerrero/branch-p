class InventoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_inventory, only: [ :edit, :update, :complete, :cancel, :void]

  def index
    @products = Product.all.where.not(type: "Products::Package")
    @inventories = Inventory.includes(:inventory_items).paginate(page: params[:page])
  end

  def create
    @service = InventoryService.new(params: create_params, user: current_user, branch: current_branch)
    @service.add_inventory

    redirect_to @service.url, flash: @service.message
  end

  def edit
    @inventory_items = @inventory.inventory_items

  end

  def update

  end

  def complete
    @service = InventoryService.new(inventory: @inventory)
    @service.approve_inventory

    redirect_to @service.url, flash: @service.message
  end

  def void
    @service = InventoryService.new(inventory: @inventory, params: params[:message])
    @service.void_inventory

    redirect_to @service.url, flash: @service.message
  end

  def cancel
    @service = InventoryService.new(inventory: @inventory)
    @service.cancel_inventory

    redirect_to @service.url, flash: @service.message
  end

  private

  def set_inventory
    @inventory = Inventory.includes(:user, inventory_items: [:product]).find_by id: params[:id]
  end

  def create_params
    params.require(:inventory).permit(
      :branch_id,
      :type,
      :origin,
      :remarks,
      inventory_items_attributes: [
        :id,
        :product_id,
        :quantity,
        :damaged,
        :undelivered
      ]
    )
  end
end
