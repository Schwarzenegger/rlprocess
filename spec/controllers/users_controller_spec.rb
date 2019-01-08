require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:employee_user) { create(:user, :employee) }
  let(:admin_user) { create(:user, :admin) }
  let(:common_user) { create(:user) }

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
        expect(assigns(:resource)).to be_a_new(User)
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
        expect { get :edit, params: { id: common_user.id } }.to raise_error(CanCan::AccessDenied)
      end

      it "should raise ActionController::UnknownFormat for html" do
        sign_in_mock_user(admin_user)

        expect{get :edit, params: { id: common_user.id } }.to raise_error(ActionController::UnknownFormat)
      end

      it "assigns @resource" do
        sign_in_mock_user(admin_user)

        get :edit, params: { id: common_user.id }, format: :js, xhr: true
        expect(assigns(:resource)).to eq(common_user)
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
        b_user = build(:user)
        expect { post :create, params: { user: b_user.attributes } }.to raise_error(CanCan::AccessDenied)
        expect(assigns(:resource)).to eq(nil)
      end

      it "should create a new ActivityProfile" do
        sign_in_mock_user(admin_user)
        b_user_attributes = build(:user).attributes
        b_user_attributes[:password] =  "password"
        post :create, params: {
          user:  b_user_attributes,
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
        expect { put :update, params: {id: common_user.id, user: { name: "Name Test" } } }.to raise_error(CanCan::AccessDenied)
        expect(assigns(:resource)).to eq(nil)
      end

      it "Should udpate activity profile" do
        sign_in_mock_user(admin_user)

        n_user = create(:user)

        put :update, params: { id: n_user.id,
          user: { name: 'New Name' } },
          format: :js
        expect(assigns(:resource).name).to eq('New Name')
        n_user.reload
        expect(n_user.name).to eq('New Name')

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
        expect { delete :destroy, params: { id: common_user.id } }.to raise_error(CanCan::AccessDenied)
      end

      it "Should delete actrivity" do
        custom_user = create(:user)

        sign_in_mock_user(admin_user)

        delete :destroy, params: { id: custom_user.id }

        expect(flash[:alert]).to match(I18n.t('flash.actions.destroy.notice', resource_name: I18n.t('activerecord.models.user')))
      end
    end
  end
end
