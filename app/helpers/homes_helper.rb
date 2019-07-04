module HomesHelper
  def role_name role
    role == 1 ? t("user.role.supervisor") : t("user.role.trainee")
  end
end
