module Supervisors::TraineesHelper
  def display_gender gender
    if gender.male?
      "fa-male"
    elsif gender.female?
      "fa-female"
    else
      "fa-male"
    end
  end
end
