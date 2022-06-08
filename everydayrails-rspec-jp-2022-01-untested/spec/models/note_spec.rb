require 'rails_helper'

RSpec.describe Note, type: :model do

  before do
    @user = FactoryBot.create(:user)

    @project = FactoryBot.create(:project)
  end

  it "ファクトリで関連するデータを生成する" do
    note = FactoryBot.create(:note)
    puts "This note's project is #{note.project.inspect}"
    puts "This note's user is #{note.user.inspect}"
  end

  #バリデーション用のスペック
  describe "noteのバリデーション" do
    it "ユーザー、プロジェクト、メッセージがあれば有効であること" do

      note1 = FactoryBot.build(:note)
      expect(note1).to be_valid
    end


    it "メッセージが空の時無効であること" do

      note1 = FactoryBot.build(:note, message: nil)

      note1.valid?
      expect(note1.errors[:message]).to include("can't be blank")
    end

  end

  #文字列に関するスペック
  describe "文字列に一致するメッセージを検索する" do
    before do
      @note1 = FactoryBot.create(:note_first1)
      @note2 = FactoryBot.create(:note)
      @note3 = FactoryBot.create(:note_first2)
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
