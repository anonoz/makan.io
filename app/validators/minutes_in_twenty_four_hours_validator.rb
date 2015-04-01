class MinutesInTwentyFourHoursValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value % 100 / 60 == 0
      record.errors[attribute] << "minutes can't be more than 59"
    end
  end
end
