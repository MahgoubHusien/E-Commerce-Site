class WishlistItemsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]
end
