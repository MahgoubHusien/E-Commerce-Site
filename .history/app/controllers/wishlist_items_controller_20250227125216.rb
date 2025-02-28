class WishlistItemsController < ApplicationController
  before_action :set_product, only: %i[ create destroy ]

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
    Rails.logger.debug "Attempting to remove wishlist item for user_id: #{current_user.id}, product_id: #{params[:product_id]}"
  
    wishlist_item = current_user.wishlist_items.find_by(id: params[:id])
  
    if wishlist_item
      Rails.logger.debug "Wishlist item found: #{wishlist_item.id}, deleting..."
      wishlist_item.destroy
      Rails.logger.debug "Wishlist item successfully deleted!"
      redirect_to user_path(current_user), notice: "Removed from wishlist."
    else
      Rails.logger.debug "Wishlist item not found!"
      redirect_to user_path(current_user), alert: "Item not found in wishlist."
    end
  end
  

  private

  def set_product
    @product = Product.find(params[:product_id])
  end
end
