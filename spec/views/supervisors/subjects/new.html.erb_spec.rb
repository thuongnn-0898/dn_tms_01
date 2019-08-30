require "rails_helper"

RSpec.describe "supervisors/subjects/new", type: :view do

  before(:each) do
    @subject = Subject.new
  end
  it "#new" do
    render
    expect(@subject).to be_present
    expect(response).to render_template :new
    expect(response.body).to include "<h1>#{I18n.t "page.subject_create"}</h1>"
  end
end
