require 'rails_helper'

RSpec.describe ActivitiesController, type: :controller do
  let(:employee_user) { create(:user, :employee) }
  let(:admin_user) { create(:user, :admin) }
  let(:activity_profile) { create(:activity_profile) }

  describe "Actions" do
    describe "PUT Update" do
      it "Should redirect if user is not logged" do
        put :update, params: { id: 1 }

        expect(response).to be_redirect
        expect(response).to redirect_to(new_user_session_path)
      end

      it "Should change activity from todo to doing" do
        new_activity = create(:activity, status: "todo")
        sign_in_mock_user(employee_user)
        put :update, params: {id: new_activity.id, destination: "inprogress" }
        expect(assigns(:resource).status).to eq("doing")
      end

      it "Should change activity from doing to done" do
        new_activity = create(:activity, status: "doing")
        sign_in_mock_user(employee_user)
        put :update, params: {id: new_activity.id, destination: "completed" }
        expect(assigns(:resource).status).to eq("done")
      end
    end

    describe "GET Show" do
      it "Should redirect if user is not logged" do
        get :show, params: { id: 1 }

        expect(response).to be_redirect
        expect(response).to redirect_to(new_user_session_path)
      end

      it "should assign the right activity on show" do
        new_activity = create(:activity, status: "doing")
        sign_in_mock_user(employee_user)
        get :show, params: {id: new_activity.id}, format: :js, xhr: true
        expect(assigns(:resource)).to eq(new_activity)
      end
    end

    describe "PUT mark_option" do
      it "Should redirect if user is not logged" do
        put :mark_option, params: { id: 1 }

        expect(response).to be_redirect
        expect(response).to redirect_to(new_user_session_path)
      end

      it "should mark/unmark a option" do
        new_acl = create(:activity_check_list)
        expect(new_acl.done).to eq false
        sign_in_mock_user(employee_user)
        put :mark_option, params: { optionId: new_acl.id, checked: true }, format: :js, xhr: true
        new_acl.reload
        expect(new_acl.done).to eq true
        put :mark_option, params: { optionId: new_acl.id, checked: false }, format: :js, xhr: true
        new_acl.reload
        expect(new_acl.done).to eq false
      end
    end

    describe "PUT start" do
      it "Should redirect if user is not logged" do
        put :start, params: { id: 1 }

        expect(response).to be_redirect
        expect(response).to redirect_to(new_user_session_path)
      end

      it "should start activity" do
        new_activity = create(:activity, status: "todo")
        sign_in_mock_user(employee_user)
        put :start, params: { id: new_activity.id }, format: :js, xhr: true
        expect(assigns(:resource).status).to eq("doing")
      end
    end

    describe "PUT finish" do
      it "Should redirect if user is not logged" do
        put :finish, params: { id: 1 }

        expect(response).to be_redirect
        expect(response).to redirect_to(new_user_session_path)
      end

      it "should finish activity" do
        new_activity = create(:activity, status: "doing")
        sign_in_mock_user(employee_user)
        put :finish, params: { id: new_activity.id }, format: :js, xhr: true
        expect(assigns(:resource).status).to eq("done")
      end
    end

    describe "PUT restart" do
      it "Should redirect if user is not logged" do
        put :restart, params: { id: 1 }

        expect(response).to be_redirect
        expect(response).to redirect_to(new_user_session_path)
      end

      it "should restart activity" do
        new_activity = create(:activity, status: "doing")
        sign_in_mock_user(employee_user)
        put :restart, params: { id: new_activity.id }, format: :js, xhr: true
        expect(assigns(:resource).status).to eq("todo")
      end
    end

    describe "PUT archive" do
      it "Should redirect if user is not logged" do
        put :archive, params: { id: 1 }

        expect(response).to be_redirect
        expect(response).to redirect_to(new_user_session_path)
      end

      it "should archive activity" do
        new_activity = create(:activity, status: "doing")
        sign_in_mock_user(employee_user)
        put :archive, params: { id: new_activity.id }, format: :js, xhr: true
        expect(assigns(:resource).status).to eq("archived")
      end
    end
  end

end
