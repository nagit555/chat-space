require 'rails_helper'

describe MessagesController, type: :controller do

  let(:group)   { create(:group) }
  let(:user)    { create(:user) }
  let(:message) { create(:message) }

  describe 'GET #index' do
    context "logged in" do
      before do
        login user
        get :index, params: { group_id: group.id }
      end

      it "assigns correctly @group" do
        expect(assigns(:group)).to eq group
      end

      it "assigns correctly @message" do
        expect(assigns(:message)).to be_a_new(Message)
      end

      it "assigns correctly @messages" do
        expect(assigns(:messages)).to eq group.messages.includes(user)
      end

      it "renders the :index template" do
        expect(response).to render_template :index
      end
    end

    context "not logged in" do
      before do
        get :index, params: { group_id: group.id }
      end

      it "redirect to sign in page" do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'POST #create' do
    context 'logged in and succeed in post' do
      before do
        login(user)
      end

      it "is succeeded in save a message" do
        expect{post :create, params: { message: attributes_for(:message), group_id: group.id }}.to change(Message, :count).by(1)
      end

      it "is redirect to messages#index" do
        post :create, params: { message: attributes_for(:message), group_id: group.id }
        expect(response).to redirect_to(group_messages_path(group.id))
      end
    end

    context 'logged in and fail to post' do
      before do
        login(user)
      end

      it "is failed to save a message" do
        expect{post :create, params: { message: attributes_for(:message, { body: nil, image: nil }), group_id: group.id }}.to change(Message, :count).by(0)
      end

      it "is redirect to messages#index" do
        post :create, params: { message: attributes_for(:message, { body: nil, image: nil }), group_id: group.id }
        expect(response).to redirect_to(group_messages_path(group.id))
      end
    end

    context 'not logged in' do
      before do
        post :create, params: { message: attributes_for(:message), group_id: group.id }
      end

      it "is redirect to sign_in path" do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
