require "rails_helper"

RSpec.shared_examples "have status and redirect_to" do
  it do
    expect(response).to have_http_status(302)
    expect(response).to redirect_to supervisors_subjects_path
  end
end

RSpec.shared_examples "when create/update subject success" do
  it do
    expect(flash[:success]).to eql I18n.t("messages.save_success")
  end
end

RSpec.shared_examples "when destroy subject success" do
  it do
    expect(flash[:warning]).to eql I18n.t("messages.destroy_success")
  end
end

RSpec.describe Supervisors::SubjectsController, type: :controller do

  context ".Subject" do
    describe "#index" do
      before { get :index }
      it "return list subject" do
        expect(response).to have_http_status(200)
      end

      it "assigns @subject" do
        subject = FactoryBot.create :subject
        expect(assigns(:subjects)).to include subject
      end

      it "render template subject" do
        expect(response).to render_template :index
      end
    end

    describe "#new" do
      it "return view new" do
        get :new
        expect(response).to render_template :new
      end

      it "assigns @subject new" do
        get :new
        expect(assigns(:subject)).to be_a_new(Subject)
      end
    end


    describe "#create" do
      let(:subject) {assigns(:subject)}
      context "when valid" do
        before(:each) do
          post :create, params: {
            subject: {name: "Nguyen Ngoc Thuong", description: "description",
             tasks_attributes: [name: "abc", subject_id: 1]}
          }
        end
        it "should task persisted" do
          expect(subject.tasks.first).to be_persisted
        end

        it "should save subject" do
          expect(Task.all).to include subject.tasks.first
        end

        it "should have saved the same subject_id for subject" do
          expect(subject.tasks.first.subject_id).to eq subject.id
        end

        context "save success subject" do
          it_behaves_like "when create/update subject success"
          it_behaves_like "have status and redirect_to"
        end
      end

      context "when invalid" do
        before(:each) do
          post :create, params: {
            subject: {name: "shortname", description: "description",
             tasks_attributes: [name: "abc", subject_id: 1]}
          }
        end
        it "save fail subject" do
          expect(subject.errors).to be_truthy
          expect(response).to render_template :new
        end
      end

    end

    describe "#update" do
      before(:each) do
        @subject = FactoryBot.create :subject
      end
      describe "#edit" do
        it "return view edit" do
          get :edit, params: {id: @subject.id}
          expect(response).to render_template :edit
        end
      end

      describe "#update" do
        context "when valid" do
          before(:each) do
            @subject = FactoryBot.create :subject
            put :update, params: {id: @subject.id, subject: {name: "New name more than 10words"}}
          end
          it "update subject" do
            expect(assigns(:subject)).to eq(@subject)
          end

          context "update success subject" do
            it_behaves_like "when create/update subject success"
            it_behaves_like "have status and redirect_to"
          end
        end

        context "when invalid" do
          before(:each) do
            @subject = FactoryBot.create :subject
            put :update, params: {id: @subject.id, subject: {name: "error"} }
          end
          it "save fail subject" do
            expect(@subject.errors).to be_truthy
            expect(response).to render_template :edit
          end
        end
      end
    end

    describe "#destroy" do
      context "valid" do
        before(:each) do
          @subject = FactoryBot.create(:subject)
          delete :destroy, params: {id: @subject}
        end
        context "delete success" do
          it_behaves_like "when destroy subject success"
          it_behaves_like "have status and redirect_to"
        end
      end

      context "invalid" do
        before(:each) do
          @subject = FactoryBot.create :subject
          delete :destroy, params: {id: @subject.id - 1}
        end
        context "not found" do
          it_behaves_like "have status and redirect_to"
        end

        # it "delete error" do
        #   delete :destroy, params: {id: subject.id}
        #   expect(flash[:warning]).to eql(I18n.t("messages.destroy_error"))
        # end
      end
    end
  end
end
