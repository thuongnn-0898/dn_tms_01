require "rails_helper"

RSpec.describe "supervisors/subjects/edit", type: :view do

  before(:each) do
    @subject = FactoryBot.create :subject
  end
  it "#edit" do
    render
    expect(response).to render_template :edit
    expect(rendered).to include "<input class=\"form-control\" type=\"text\" value=\"#{@subject.name}\" name=\"subject[name]\" id=\"subject_name\" />"
  end
end
