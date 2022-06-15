require 'rails_helper'

RSpec.describe Note, type: :model do

    let(:user) { FactoryBot.create(:user) }
    let(:project) { FactoryBot.create(:project, owner: user) }

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
    #リファクタリング
    # before do
    #   @note1 = FactoryBot.create(:note_first1)
    #   @note2 = FactoryBot.create(:note)
    #   @note3 = FactoryBot.create(:note_first2)
    # end
    #ブロックを即座に読み込む→遅延読み込みではない
    let!(:note1) { FactoryBot.create(:note_first1) }
    let!(:note2) { FactoryBot.create(:note) }
    let!(:note3) { FactoryBot.create(:note_first2) }

    context "一致するデータが見つかる時" do

      it "検索文字列に一致するメモを返すこと" do
        skip "スキップしてみる"
        expect(Note.search("first")).to include(note1, note3)
        expect(Note.search("first")).to_not include(note2)
      end
    end

    context "一致するデータが道からない時" do
      it "空のコレクションを返すこと" do

        expect(Note.search("message")).to be_empty
        expect(Note.count).to eq 3
      end
    end

  end

  #モックの使用
    it "名前の取得をメモを作成したユーザーに委譲すること" do
      user = instance_double("User", name: "Fake User")
      note = Note.new
      allow(note).to receive(:user).and_return(user)
      expect(note.user.name).to eq "Fake User"
      # expect(note.user.first_name).to eq "Fake"  だめ
    end
end
