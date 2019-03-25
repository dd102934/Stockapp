class StocksController < ApplicationController
  
  def search
    if params[:stock].blank?
      flash.now[:danger] = "空白では検索できません"
    else
      @stock = Stock.new_from_lookup(params[:stock])
      flash.now[:danger] = "株式のシンボルが間違っています" unless @stock
    end
    respond_to do |format|
      format.js { render partial: 'users/result' }
    end
  end

end