require 'rails_helper'
describe Message do
  describe '#create' do
    describe 'success' do
      it "is valid with body" do
        user = create(:user)
        group = create(:group)
        message = build(:message, image: nil, user_id: user.id, group_id: group.id)
        message.valid?
        expect(message).to be_valid
      end

      it "is valid with image" do
        user = create(:user)
        group = create(:group)
        message = build(:message, body: "", user_id: user.id, group_id: group.id)
        message.valid?
        expect(message).to be_valid
      end

      it "is valid with body and image" do
        user = create(:user)
        group = create(:group)
        message = build(:message, user_id: user.id, group_id: group.id)
        message.valid?
        expect(message).to be_valid
      end
    end

    describe 'failure' do
      it "is invalid without body and image" do
        message = build(:message, body: "", image: "")
        message.valid?
        expect(message.errors[:body][0]).to include("入力してください")
      end

      it "is invalid without group_id" do
        message = build(:message, group_id: nil)
        message.valid?
        expect(message.errors[:group][0]).to include("入力してください")
      end

      it "is invalid without user_id" do
        message = build(:message, user_id: nil)
        message.valid?
        expect(message.errors[:user][0]).to include("入力してください")
      end
    end
  end
end
