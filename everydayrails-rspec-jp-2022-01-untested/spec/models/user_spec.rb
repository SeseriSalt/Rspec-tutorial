require 'rails_helper'

RSpec.describe User, type: :model do
  it "姓、名、メール、パスワードがあれば有効な状態であること" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  # it "姓がなければ無効な状態であること" do
  #   user = FactoryBot.build(:user, first_name: nil)
  #   user.valid?
  #   expect(user.errors[:first_name]).to include("can't be blank")
  # end
  # リファクタリング

  it { is_expected.to validate_presence_of :first_name }

  # it "名がなければ無効な状態であること" do
  #   user = FactoryBot.build(:user, last_name: nil)
  #   user.valid?
  # expect(user.errors[:last_name]).to include("can't be blank")
  # end

  it { is_expected.to validate_presence_of :last_name }

  # it "メールアドレスがなければ無効な状態であること" do
  #   user = FactoryBot.build(:user, email: nil)
  #   user.valid?
  #   expect(user.errors[:email]).to include("can't be blank")
  # end
  it { is_expected.to validate_presence_of :email }

  # it "重複したメールアドレスなら無効な状態であること" do
  #
  #   FactoryBot.create(:user, email: "tester@example.com")
  #   user = FactoryBot.build(:user, email: "tester@example.com")
  #
  #   user.valid?
  #   expect(user.errors[:email]).to include("has already been taken")
  # end

  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }

  it "ユーザのフルネームを文字列として返すこと" do
    user = FactoryBot.build(:user, last_name: "Jhon", first_name: "Doe")
    expect(user.name).to eq "Doe Jhon"
  end

end
