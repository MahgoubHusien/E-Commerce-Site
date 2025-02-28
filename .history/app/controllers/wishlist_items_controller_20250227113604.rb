class WishlistItemsController < ApplicationController
  before_action :set_product, only: %i[ create,  ]

  def index
    @wishlist_products = current_user.wishlist_products
  end

  def create
    puts "Current user: #{current_user.inspect}"
    if current_user
      @wishlist_item = current_user.wishlist_items.find_or_initialize_by(product: @product)

      if @wishlist_item.new_record? && @wishlist_item.save
        redirect_to @product, notice: "Added to wishlist!"
      else
        redirect_to @product, alert: "Already in your wishlist."
      end
    else
      redirect_to new_session_path, alert: "You must be logged in to add items to your wishlist."
    end
  end

  def destroy
    Rails.logger.debug "Params received: #{params.inspect}"
    wishlist_item = current_user.wishlist_items.find_by(product_id: params[:product_id])
  
    if wishlist_item
      wishlist_item.destroy
      Rails.logger.debug "Deleted wishlist item: #{wishlist_item.inspect}"
      redirect_to user_path(current_user), notice: "Removed from wishlist."
    else
      Rails.logger.debug "Wishlist item not found"
      redirect_to user_path(current_user), alert: "Item not found in wishlist."
    end
  end
  

  private

  def set_product
    @product = Product.find(params[:product_id])
  end
end
