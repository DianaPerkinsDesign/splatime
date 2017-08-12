class Event < ApplicationRecord
  validate :ends_at_is_after_starts_at
  def ends_at_is_after_starts_at
    if starts_at > ends_at
      errors.add(:ends_at, "must be after starts at")
    end
  end

  scope :active, -> { where("ends_at > ?", Time.now) }

	def going_on_now?
		starts_at < Time.now && ends_at > Time.now
	end

  def happening_class
    if going_on_now?
      "happening"
    else
      "not_happening"
    end
  end

  def start_or_end_string
    if going_on_now?
      "End"
    else
      "Start"
    end
  end

	def time_until
		if going_on_now?
			time_left = ends_at - Time.now
    else
      time_left = starts_at - Time.now
    end
    time_in_days_and_hours(time_left)
	end

  def time_in_days_and_hours(time_left)
    days_left = (time_left / (60 * 60 * 24)).floor
    hours_left = ((time_left - days_left.days.to_i) / (60 * 60)).floor
    time_string = ""
    time_string += "#{days_left} days, " if days_left > 0
    time_string += "#{hours_left} hours"
    time_string
  end
end
