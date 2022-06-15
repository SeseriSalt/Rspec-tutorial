require 'rails_helper'


RSpec.describe Project, type: :model do

  # before do
  #   user = FactoryBot.create(:user)
  # end
  let(:user) { FactoryBot.create(:user) }

  describe "名前のバリデーション" do
    context "名前、詳細、日付を入力した時" do
      it "有効な状態であること" do
        project = FactoryBot.build(:project)
        expect(project).to be_valid
      end
    end

    context "名前が空の時" do
      # it "無効な状態であること" do
      #   project = FactoryBot.build(:project, name: nil)
      #
      #   project.valid?
      #   expect(project.errors[:name]).to include("can't be blank")
      # end
      it { is_expected.to validate_presence_of :name }
    end

    context "名前が重複するとき" do
      # it "ユーザ単位では重複したプロジェクト名を許可しないこと" do
      #
      #   project = FactoryBot.create(:project, name: "New Project", owner: user)
      #   new_project = FactoryBot.build(:project, name: "New Project", owner: user)
      #
      #   new_project.valid?
      #   expect(new_project.errors[:name]).to include("has already been taken")
      # end

      # it "二人のユーザが同じ名前を使うことは許可すること" do
      #
      #   user2 = FactoryBot.create(:user)
      #   project = FactoryBot.create(:project, name: "New Project", owner: user)
      #   other_project = FactoryBot.build(:project, name: "New Project", owner: user2)
      #
      #   expect(other_project).to be_valid
      # end
      # 全部これ１つにまとまっちゃった
      it { is_expected.to validate_uniqueness_of(:name).scoped_to(:user_id) }
    end

    describe "遅延ステータス" do

      it "締切日が過ぎていれば遅延していること" do
        project = FactoryBot.create(:project_due_yesterday)
        expect(project).to be_late
      end

      it "締切日が今日ならスケジュール通りであること" do
        project = FactoryBot.create(:project_due_today)
        expect(project).to_not be_late
      end

      it "締切日が未来ならスケジュール通りであること" do
        project = FactoryBot.create(:project_due_tomorrow)
        expect(project).to_not be_late
      end
    end

    it "たくさんのメモがついていること" do
      project = FactoryBot.create(:project, :with_notes)
      expect(project.notes.length).to eq 5
    end

  end

end
