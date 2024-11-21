class PagesController < ApplicationController
  def index
    @offset = params[:offset] || 0
    @presenter = DailyEntriesPresenter.new(Time.current + @offset.to_i.days)
  end
end
