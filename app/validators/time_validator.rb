class TimeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if options.key?(:later_than)
      comparing = options[:later_than].call(record)
      if value && comparing && value < comparing
        record.errors[attribute] << "must be later than compared time"
      end
    end
  end

end
