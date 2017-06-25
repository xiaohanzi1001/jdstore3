class ProductsController < ApplicationController
   def index
     @products = Product.all
     if params[:favorite] == "yes"
       @products = current_user.products
     end
   end

   def show
     @product = Product.find_by_friendly_id!(params[:id])
   end

   def add_to_favorite
     @product = Product.find_by_friendly_id!(params[:id])
     @product.users << current_user
     @product.save
     redirect_to :back, notice:"成功加入收藏!"
  end

  def quit_favorite
     @product = Product.find_by_friendly_id!(params[:id])
     @product.users.delete(current_user)
     @product.save
     redirect_to :back, alert: "成功取消收藏!"
  end

  def add_to_cart
     @product = Product.find_by_friendly_id!(params[:id])
     if !current_cart.products.include?(@product)
       current_cart.add_product_to_cart(@product)
       flash.now[:notice] = "你已成功将 #{@product.title} 加入购物车"
     else
       @cart = current_cart
      @cart_item = @cart.cart_items.find_by(product_id: params[:id])
       flash.now[:warning] = "你的购物车内已有此物品"
     end
    # redirect_to :back
   end
end
