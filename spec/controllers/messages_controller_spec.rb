require 'rails_helper'

describe MessagesController, type: :controller do

  let(:group) { create(:group) }
  let(:user)  { create(:user) }

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

  # describe 'GET #edit' do
  #   it "assigns the requested tweet to @tweet" do
  #     tweet = create(:tweet)
  #     get :edit, params: { id: tweet }
  #     expect(assigns(:tweet)).to eq tweet
  #   end

  #   it "renders the :edit template" do
  #     tweet = create(:tweet)
  #     get :edit, params: { id: tweet }
  #     expect(response).to render_template :edit
  #   end
  # end

  # describe 'GET #index' do
  #   it "populates an array of tweets ordered by created_at DESC" do
  #     tweets = create_list(:tweet, 3)     # tweetリソースを複数作成
  #     get :index
  #     expect(assigns(:tweets)).to match(tweets.sort{ |a, b| b.created_at <=> a.created_at })
  #   end

  #   it "renders the :index template" do
  #     get :index
  #     expect(response).to render_template :index
  #   end
  # end
end
