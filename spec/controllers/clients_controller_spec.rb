require 'rails_helper'

RSpec.describe ClientsController, type: :controller do
  let(:employee_user) { create(:user, :employee) }
  let(:admin_user) { create(:user, :admin) }
  let(:client) { create(:client) }

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

      it "assigns @resource" do
        sign_in_mock_user(admin_user)

        get :new
        expect(assigns(:resource)).to be_a_new(Client)
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
        expect { get :edit, params: { id: client.id } }.to raise_error(CanCan::AccessDenied)
      end

      it "assigns @resource" do
        sign_in_mock_user(admin_user)

        get :edit, params: { id: client.id }
        expect(assigns(:resource)).to eq(client)
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
        b_client = build(:client)
        expect { post :create, params: { client: b_client.attributes } }.to raise_error(CanCan::AccessDenied)
        expect(assigns(:resource)).to eq(nil)
      end

      it "should create a new ActivityProfile" do
        sign_in_mock_user(admin_user)
        b_client = build(:client)

        post :create, params: {
          client:  b_client.attributes,
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
        expect { put :update, params: {id: client.id, client: { social_name: "Name Test" } } }.to raise_error(CanCan::AccessDenied)
        expect(assigns(:resource)).to eq(nil)
      end

      it "Should udpate activity profile" do
        sign_in_mock_user(admin_user)

        n_client = create(:client)

        put :update, params: { id: n_client.id,
          client: { social_name: 'New Social Name' } }
        expect(assigns(:resource).social_name).to eq('New Social Name')
        n_client.reload
        expect(n_client.social_name).to eq('New Social Name')

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
        expect { delete :destroy, params: { id: client.id } }.to raise_error(CanCan::AccessDenied)
      end

      it "Should delete actrivity" do
        custom_client = create(:client)

        sign_in_mock_user(admin_user)

        delete :destroy, params: { id: custom_client.id }

        expect(flash[:alert]).to match(I18n.t('flash.actions.destroy.notice', resource_name: I18n.t('activerecord.models.client')))
      end
    end

  end
end
