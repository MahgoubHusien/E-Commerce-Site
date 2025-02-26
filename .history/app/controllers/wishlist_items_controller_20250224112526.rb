class WishlistItemsController < ApplicationController
  allow_unauthenticated_access
  before_action :set_product, only: %i[ show destroy ]

  def create
    @wishlist_item = current_user.wishlist_items.build(product: @product)

    if @wishlist_item.save
      redirect_to @product, notice: "Added to wishlist!"
    else
      redirect_to @product, alert: "Already in your wishlist."
    end
  end

  def destroy
    @wishlist_item = current_user.wishlist_items.find_by(product: @product)
    @wishlist_item&.destroy
    redirect_to @product, notice: "Removed from wishlist."
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end
end
end
