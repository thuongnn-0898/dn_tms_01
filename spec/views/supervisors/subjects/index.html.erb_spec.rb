require "rails_helper"

RSpec.describe "supervisors/subjects/index", type: :view do

  let(:subjects) {FactoryBot.create_list(:subject, 2)}
  it "#index" do
    allow(view).to receive_messages(:will_paginate => nil)
    stub_template "supervisors/subjects/_subject.html.erb" => "<%= subject.name %><br/>"
    render
    expect(response).to render_template :index
    expect(response.body).to include "<h2>#{I18n.t "page.subject_list"}</h2>"
  end
end

