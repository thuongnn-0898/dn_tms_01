require "rails_helper"

RSpec.shared_examples "when empty" do |field|
  it do
    us.save
    expect(us.errors[field].first).to eql I18n.t("errors.messages.blank")
  end
end

RSpec.describe User, type: :model do
  let(:us) {FactoryBot.create :user}
  subject {us}

  it "should be valid" do
    expect(us).to be_valid
  end

  describe "#email" do
    it{is_expected.to validate_presence_of :email }
    it{is_expected.to validate_length_of(:email).
      is_at_least(Settings.email_length_minimum)}
    it{is_expected.to validate_length_of(:email).
      is_at_most(Settings.email_length_maximum)}
    it{is_expected.to validate_uniqueness_of(:email).case_insensitive}

    context "when the email is empty" do
      before {us.email = nil}
      it_behaves_like "when empty",  :email
    end

    it "is invalid email" do
      us.email = "abcabcbac"
      is_expected.not_to be_valid
    end
  end

  describe "#fullname" do
    it{is_expected.to validate_presence_of :fullname}
    it{is_expected.to validate_length_of(:fullname).
      is_at_most(Settings.fullname_length_maximum)}

    context "when the name is empty" do
      before {us.fullname = nil}
      it_behaves_like "when empty", :fullname
    end
  end

  describe "#birthday" do
    it{is_expected.to validate_presence_of :birthday}

    context "when the birthday is larger than today" do
      before {us.birthday = DateTime.now.to_date.next_day(1)}
      it do
        us.save
        expect(us.errors[:birthday].first).to eql I18n.
          t("activerecord.errors.models.user.birthday_invalid")
      end
    end

    context "when the birthday is smaller than n year old" do
      before {us.birthday = DateTime.now.to_date.next_year(-5)}
      it do
        us.save
        expect(us.errors[:birthday].first).to eql I18n.
          t("activerecord.errors.models.user.birthday_invalid")
      end
    end
  end

  describe ".associations" do
    it "should have many course_users" do
      is_expected.to have_many(:course_users).dependent :destroy
    end

    it "should have many courses" do
      is_expected.to have_many(:courses)
    end
  end


end
