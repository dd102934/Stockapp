class UserStocksController < ApplicationController
  def create
    stock = Stock.find_by_ticker(params[:stock_ticker])
    if stock.blank?
      stock = Stock.new_from_lookup(params[:stock_ticker])
      stock.save
    end
    @user_stock = UserStock.create(user: current_user, stock: stock)
    flash[:success] = "株式 #{@user_stock.stock.name} はポートフォリオに加わりました"
    redirect_to my_portfolio_path
  end
  
  def destroy
    stock = Stock.find(params[:id])
    @user_stock = UserStock.where(user_id: current_user.id, stock_id: stock.id).first
    @user_stock.destroy
    flash[:notice] = "株式がポートフォリオから削除されました"
    redirect_to my_portfolio_path
  end
end
