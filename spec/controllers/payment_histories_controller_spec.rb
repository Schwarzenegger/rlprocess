require 'rails_helper'

RSpec.describe PaymentHistoriesController, type: :controller do
  let(:employee_user) { create(:user, :employee) }
  let(:admin_user) { create(:user, :admin) }
  let(:client) { create(:client) }
  let(:payment_history) { create(:payment_history, client: client) }


  describe "Actions" do
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

        get :new, format: :js, xhr: true
        expect(assigns(:resource)).to be_a_new(PaymentHistory)
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
        expect { get :edit, params: { id: payment_history.id } }.to raise_error(CanCan::AccessDenied)
      end

      it "assigns @resource" do
        sign_in_mock_user(admin_user)

        get :edit, params: { id: payment_history.id }, format: :js, xhr: true
        expect(assigns(:resource)).to eq(payment_history)
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
        b_payment_history = build(:payment_history)
        expect { post :create, params: { payment_history: b_payment_history.attributes } }.to raise_error(CanCan::AccessDenied)
        expect(assigns(:resource)).to eq(nil)
      end

      it "should create a new ActivityProfile" do
        sign_in_mock_user(admin_user)
        b_payment_history = build(:payment_history)

        post :create, params: {
          payment_history:  b_payment_history.attributes,
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
        expect { put :update, params: {id: payment_history.id, payment_history: { value: "123" } } }.to raise_error(CanCan::AccessDenied)
        expect(assigns(:resource)).to eq(nil)
      end

      it "Should udpate activity profile" do
        sign_in_mock_user(admin_user)

        n_payment_history = create(:payment_history)

        put :update, params: { id: n_payment_history.id,
          payment_history: { value: '123' } },
          format: :js
        expect(assigns(:resource).value).to eq(123.0)
        n_payment_history.reload
        expect(n_payment_history.value).to eq(123.0)

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
        expect { delete :destroy, params: { id: payment_history.id } }.to raise_error(CanCan::AccessDenied)
      end

      it "Should delete actrivity" do
        n_payment_history = create(:payment_history)

        sign_in_mock_user(admin_user)

        delete :destroy, params: { id: n_payment_history.id }

        expect(flash[:alert]).to match(I18n.t('flash.actions.destroy.notice', resource_name: I18n.t('activerecord.models.payment_history')))
      end
    end
  end
end
