require 'rails_helper'

RSpec.describe Note, type: :model do

  before do
    @user = User.create(first_name: "joe",
                        last_name: "Tester,",
                        email: "tester@example.com",
                        password: "dottle-nouveau-pavilion-tights-furze")

    @project = @user.projects.create(name: "Test Project")
  end

  #バリデーション用のスペック
  describe "noteのバリデーション" do
    it "ユーザー、プロジェクト、メッセージがあれば有効であること" do

      note1 = Note.new(message: "This is a sample message.",
                       user: @user,
                       project: @project)
      expect(note1).to be_valid
    end


    it "メッセージが空の時無効であること" do

      note1 = Note.new(message: nil)

      note1.valid?
      expect(note1.errors[:message]).to include("can't be blank")
    end

  end

  #文字列に関するスペック
  describe "文字列に一致するメッセージを検索する" do
    before do
      @note1 = @project.notes.create(message: "This is the first note.",
                                    user: @user)
      @note2 = @project.notes.create(message: "This is the second note.",
                                    user: @user)
      @note3 = @project.notes.create(message: "First,this is the third note.",
                                    user: @user)
    end
    context "一致するデータが見つかる時" do

      it "検索文字列に一致するメモを返すこと" do

        expect(Note.search("first")).to include(@note1, @note3)
        expect(Note.search("first")).to_not include(@note2)
      end
    end

    context "一致するデータが道からない時" do
      it "空のコレクションを返すこと" do

        expect(Note.search("message")).to be_empty
      end
    end

  end

end
