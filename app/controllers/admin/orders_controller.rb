class Admin::OrdersController < ApplicationController
  layout "admin"

  before_action :authenticate_user!
  before_action :admin_required

  def index
    @orders = Order.order("id DESC")

    colors = ['rgba(255, 99, 132, 0.2)',
              'rgba(54, 162, 235, 0.2)',
              'rgba(255, 206, 86, 0.2)',
              'rgba(75, 192, 192, 0.2)',
              'rgba(153, 102, 255, 0.2)',
              'rgba(255, 159, 64, 0.2)'
              ]
              # ticket_names = @event.tickets.map { |t| t.name }
              dates = (@orders.order("id ASC").first.created_at.to_date..Date.today).to_a


      @data1 = {
        labels: dates,
        datasets: [{
          label: "# of Dates",
          # data: @product.tickets.map{ |t| t.registrations.count },
          data: dates.map{ |d|
              @orders.where( "created_at >= ? AND created_at <= ?", d.beginning_of_day, d.end_of_day).count},
          backgroundColor: colors,
          borderWidth: 1
        }]
    }
  end

  def show
   @order = Order.find(params[:id])
   @product_lists = @order.product_lists
 end

 def ship
    @order = Order.find(params[:id])
    @order.ship!
    OrderMailer.notify_ship(@order).deliver!
    redirect_to :back
  end

  def shipped
    @order = Order.find(params[:id])
    @order.deliver!
    redirect_to :back
  end

  def cancel
    @order = Order.find(params[:id])
    @order.cancel_order!
    OrderMailer.notify_cancel(@order).deliver!
    redirect_to :back
  end

  def return
    @order = Order.find(params[:id])
    @order.return_good!
    redirect_to :back
  end
end
