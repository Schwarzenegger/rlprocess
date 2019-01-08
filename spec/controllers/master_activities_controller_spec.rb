require 'rails_helper'

RSpec.describe MasterActivitiesController, type: :controller do
  let(:employee_user) { create(:user, :employee) }
  let(:admin_user) { create(:user, :admin) }
  let(:master_activity) { create(:master_activity) }

  describe "Actions" do
    describe "GET Index" do
      it "Should redirect if user is not logged" do
        get :index

        expect(response).to be_redirect
        expect(response).to redirect_to(new_user_session_path)
      end

      it "should raise cancan error if user has no permission" do
        sign_in_mock_user(employee_user)
        expect { get :index }.to raise_error(CanCan::AccessDenied)
      end

      it "should render the index template" do
        sign_in_mock_user(admin_user)

        get :index

        expect(response).to render_template("index")
      end
    end

    describe "GET New" do
      it "Should redirect if user is not logged" do
        get :new

        expect(response).to be_redirect
        expect(response).to redirect_to(new_user_session_path)
      end

      it "should raise cancan error if user has no permission" do
        sign_in_mock_user(employee_user)
        expect { get :new }.to raise_error(CanCan::AccessDenied)
      end

      it "should raise ActionController::UnknownFormat for html" do
        sign_in_mock_user(admin_user)


        expect{get :new}.to raise_error(ActionController::UnknownFormat)
      end

      it "assigns @resource" do
        sign_in_mock_user(admin_user)

        get :new, format: :js, xhr: true
        expect(assigns(:resource)).to be_a_new(MasterActivity)
      end
    end

    describe "GET Edit" do
      it "Should redirect if user is not logged" do
        get :edit, params: { id: 1 }

        expect(response).to be_redirect
        expect(response).to redirect_to(new_user_session_path)
      end

      it "should raise cancan error if user has no permission" do
        sign_in_mock_user(employee_user)
        expect { get :edit, params: { id: master_activity.id } }.to raise_error(CanCan::AccessDenied)
      end

      it "should raise ActionController::UnknownFormat for html" do
        sign_in_mock_user(admin_user)

        expect{get :edit, params: { id: master_activity.id } }.to raise_error(ActionController::UnknownFormat)
      end

      it "assigns @resource" do
        sign_in_mock_user(admin_user)

        get :edit, params: { id: master_activity.id }, format: :js, xhr: true
        expect(assigns(:resource)).to eq(master_activity)
      end
    end

    describe "POST Create" do
      it "Should redirect if user is not logged" do
        post :create

        expect(response).to be_redirect
        expect(response).to redirect_to(new_user_session_path)
      end

      it "should raise cancan error if user has no permission" do
        sign_in_mock_user(employee_user)
        b_activity = build(:master_activity)
        expect { post :create, params: { master_activity: b_activity.attributes } }.to raise_error(CanCan::AccessDenied)
        expect(assigns(:resource)).to eq(nil)
      end

      it "should create a new ActivityProfile" do
        sign_in_mock_user(admin_user)
        b_activity = build(:master_activity)

        post :create, params: {
          master_activity:  b_activity.attributes,
          format: :js
        }

        expect(assigns(:resource).persisted?).to eq(true)
      end
    end

    describe "PUT Update" do
      it "Should redirect if user is not logged" do
        put :update, params: { id: 1 }

        expect(response).to be_redirect
        expect(response).to redirect_to(new_user_session_path)
      end

      it "should raise cancan error if user has no permission" do
        sign_in_mock_user(employee_user)
        expect { put :update, params: {id: master_activity.id, master_activity: { name: "Name Test" } } }.to raise_error(CanCan::AccessDenied)
        expect(assigns(:resource)).to eq(nil)
      end

      it "Should udpate activity profile" do
        sign_in_mock_user(admin_user)

        n_master_activity = create(:master_activity)

        put :update, params: { id: n_master_activity.id,
          master_activity: { name: 'New Name' } },
          format: :js
        expect(assigns(:resource).name).to eq('New Name')
        n_master_activity.reload
        expect(n_master_activity.name).to eq('New Name')

      end
    end

    describe "DELETE Destroy" do
      it "Should redirect if user is not logged" do
        delete :destroy, params: { id: 1 }

        expect(response).to be_redirect
        expect(response).to redirect_to(new_user_session_path)
      end

      it "should raise cancan error if user has no permission" do
        sign_in_mock_user(employee_user)
        expect { delete :destroy, params: { id: master_activity.id } }.to raise_error(CanCan::AccessDenied)
      end

      it "Should delete actrivity" do
        custom_master_activity = create(:master_activity)

        sign_in_mock_user(admin_user)

        delete :destroy, params: { id: custom_master_activity.id }

        expect(flash[:alert]).to match(I18n.t('flash.actions.destroy.notice', resource_name: I18n.t('activerecord.models.master_activity')))
      end
    end

  end
end
