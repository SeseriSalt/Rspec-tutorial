require 'rails_helper'

RSpec.describe User, type: :model do
  it "姓、名、メール、パスワードがあれば有効な状態であること" do
    user = User.new(first_name: "Aaron",
                    last_name: "Sumner",
                    email: "tester@example.com",
                    password: "dottle-nouveau-pavilion-tights-furze")
    expect(user).to be_valid
  end

  it "姓がなければ無効な状態であること" do
    user = User.new(first_name: nil)
    user.valid?
    expect(user.errors[:first_name]).to include("can't be blank")
  end

  it "名がなければ無効な状態であること" do
    user = User.new(last_name: nil)
    user.valid?
    expect(user.errors[:last_name]).to include("can't be blank")
  end

  it "メールアドレスがなければ無効な状態であること" do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it "重複したメールアドレスなら無効な状態であること" do
    User.create(first_name: "joe",
                last_name: "Tester,",
                email: "tester@example.com",
                password: "dottle-nouveau-pavilion-tights-furze")

    user = User.new(first_name: "jane",
                last_name: "Tester,",
                email: "tester@example.com",
                password: "dottle-nouveau-pavilion-tights-furze")
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end
  it "ユーザのフルネームを文字列として返すこと" do
    user = User.new(first_name: "Aaron",
                    last_name: "Sumner",
                    email: "tester@example.com")
    expect(user.name).to eq "Aaron Sumner"
  end

end
