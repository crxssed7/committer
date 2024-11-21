class DailyEntriesPresenter
  attr_reader :day

  def initialize(day = Time.current)
    @day = day
  end

  def entries
    @entries ||= Entry
      .includes(:repository)
      .where(start_time: day.beginning_of_day..day.end_of_day)
      .order(start_time: :asc)
  end

  def total_points = entries.sum { _1.points || 0 }.round(2)

  def slack_message
    entries.map { "#{_1.start_time_without_date}-#{_1.end_time_without_date} #{_1.description}" }.join("\n")
  end

  def ticket_times
    grouped = entries.group_by { [_1.repository, _1.ticket_number] }.transform_keys do |keys|
      repository = keys.first
      ticket_number = keys.last
      (repository && ticket_number) ? "#{repository.name}##{ticket_number}" : ""
    end

    grouped.transform_values do |entries|
      entries.sum { _1.points || 0 }.round(2)
    end
  end

  def readonly? = day.to_date != Time.current.to_date
end
