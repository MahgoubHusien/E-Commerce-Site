class WishlistItemsController < ApplicationController
  allow_unauthenticated_access

  before_action :set_product, only: %i[ show edit update destroy ]
end
