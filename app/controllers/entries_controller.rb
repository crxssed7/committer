class EntriesController < ApplicationController
  before_action :set_entry, only: [:update, :destroy]

  def create
    @entry = Entry.new(entry_params)
    # @entry.start_time = extract_time_for(:start_time)
    # @entry.end_time = extract_time_for(:end_time)

    @entry.save
    redirect_to root_path
  end

  def update
    # TODO: Errors?
    @entry.update(entry_params)
    redirect_to root_path
  end

  def destroy
    @entry.destroy
    redirect_to root_path
  end

  private

  def entry_params
    params.require(:entry).permit(:start_time, :end_time, :description, :ticket_number, :repository_id)
  end

  def set_entry
    @entry = Entry.find(params[:id])
  end

  def extract_time_for(param)
    original_time = @entry.send(param)
    if entry_params[param]
      original_date = original_time&.to_date || Time.current.to_date
      updated_time = entry_params[param]
      return Time.zone.parse("#{original_date} #{updated_time}")
    end
    original_time
  end
end
