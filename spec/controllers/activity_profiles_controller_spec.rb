require 'rails_helper'

RSpec.describe ActivityProfilesController, type: :controller do
  let(:employee_user) { create(:user, :employee) }
  let(:admin_user) { create(:user, :admin) }
  let(:activity_profile) { create(:activity_profile) }

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
        expect(assigns(:resource)).to be_a_new(ActivityProfile)
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
        expect { get :edit, params: { id: activity_profile.id } }.to raise_error(CanCan::AccessDenied)
      end

      it "should raise ActionController::UnknownFormat for html" do
        sign_in_mock_user(admin_user)

        expect{get :edit, params: { id: activity_profile.id } }.to raise_error(ActionController::UnknownFormat)
      end

      it "assigns @resource" do
        sign_in_mock_user(admin_user)

        get :edit, params: { id: activity_profile.id }, format: :js, xhr: true
        expect(assigns(:resource)).to eq(activity_profile)
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
        expect { post :create, params: { activity_profile: { name: "Name Test" } } }.to raise_error(CanCan::AccessDenied)
        expect(assigns(:resource)).to eq(nil)
      end

      it "should create a new ActivityProfile" do
        sign_in_mock_user(admin_user)

        post :create, params: {
          activity_profile:  {
            name: "Test Name",
          },
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
        expect { put :update, params: {id: activity_profile.id, activity_profile: { name: "Name Test" } } }.to raise_error(CanCan::AccessDenied)
        expect(assigns(:resource)).to eq(nil)
      end

      it "Should udpate activity profile" do
        sign_in_mock_user(admin_user)

        n_activity_profile = create(:activity_profile)

        put :update, params: { id: n_activity_profile.id,
          activity_profile: { name: 'New Name' } },
          format: :js
        expect(assigns(:resource).name).to eq('New Name')
        n_activity_profile.reload
        expect(n_activity_profile.name).to eq('New Name')

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
        expect { delete :destroy, params: { id: activity_profile.id } }.to raise_error(CanCan::AccessDenied)
      end

      it "Should delete actrivity" do
        custom_activity_profile = create(:activity_profile)

        sign_in_mock_user(admin_user)

        delete :destroy, params: { id: custom_activity_profile.id }

        expect(flash[:alert]).to match(I18n.t('flash.actions.destroy.notice', resource_name: I18n.t('activerecord.models.activity_profile')))
      end
    end

  end
end
