class Entry < ApplicationRecord
  belongs_to :repository, optional: true

  validates_presence_of :start_time, :description
  validates :ticket_number, presence: true, if: -> { repository.present? }
  validates_absence_of :ticket_number, if: -> { repository.blank? }

  def points
    return unless end_time.present?

    ((end_time - start_time) / 3600).round(2)
  end

  def ticket_url
    return if repository.blank? || ticket_number.blank?
    "https://github.com/commitdigital/#{repository.name}/issues/#{ticket_number}"
  end

  def start_time_without_date = time_without_date(start_time)

  def end_time_without_date = time_without_date(end_time)

  private

  def time_without_date(time)
    return time&.strftime("%H:%M")
  end
end
