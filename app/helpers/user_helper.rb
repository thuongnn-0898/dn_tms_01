module UserHelper
  def age dob
    now = Date.today
    now.year - dob.year - (now.strftime("%m%d") < dob.strftime("%m%d") ? 1 : 0)
  end
end
