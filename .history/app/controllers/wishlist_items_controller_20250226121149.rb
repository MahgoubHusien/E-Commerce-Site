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
    if current_user
      @wishlist_item = current_user.wishlist_items.find_by(product: @product)
      @wishlist_item&.destroy
      redirect_to @product, notice: "Removed from wishlist."
    else
      redirect_to new_session_path, alert: "You must be logged in to remove items from your wishlist."
    end
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end
end
