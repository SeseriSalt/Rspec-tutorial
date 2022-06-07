require 'rails_helper'


RSpec.describe Project, type: :model do

  before do
    @user = User.create(first_name: "joe",
                       last_name: "Tester",
                       email: "joetester@example.com",
                       password: "dottle-nouveau-pavilion-tights-furze",
                       )

  end

  describe "名前のバリデーション" do
    context "名前、詳細、日付を入力した時" do
      it "有効な状態であること" do
        project = @user.projects.build(name: "New Project",
                                       description: "This is a new project.",
                                       )
        expect(project).to be_valid
      end
    end

    context "名前が空の時" do
      it "無効な状態であること" do
        project = @user.projects.build(name: nil)

        project.valid?
        expect(project.errors[:name]).to include("can't be blank")
      end
    end

    context "名前が重複するとき" do
      it "ユーザ単位では重複したプロジェクト名を許可しないこと" do

        @user.projects.create(name: "Test Project")

        new_project = @user.projects.build(name: "Test Project")

        new_project.valid?
        expect(new_project.errors[:name]).to include("has already been taken")
      end

      it "二人のユーザが同じ名前を使うことは許可すること" do

        @user.projects.create(name: "Test Project")

        other_user = User.create(first_name: "jane",
                                 last_name: "Tester",
                                 email: "janetester@example.com",
                                 password: "dottle-nouveau-pavilion-tights-furze",
                                 )
        other_project = other_user.projects.build(name: "Test Project")


        expect(other_project).to be_valid
      end
    end

  end

end
