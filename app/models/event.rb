class Event < ApplicationRecord
  include ActionView::Helpers::DateHelper

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
      time_ago_in_words(ends_at)
    else
      time_ago_in_words(starts_at)
    end
	end

end
