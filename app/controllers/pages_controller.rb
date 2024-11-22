class PagesController < ApplicationController
  def index
    @date = try_parse_date
    @presenter = DailyEntriesPresenter.new(@date)
  end

  private

  def try_parse_date
    Date.parse(params[:date])
  rescue
    Date.current
  end
end
