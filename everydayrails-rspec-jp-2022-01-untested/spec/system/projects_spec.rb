require 'rails_helper'

#support/kapybaraで設定したのでコメントアウト
RSpec.describe "Projects", type: :system do
#   before do
#     driven_by(:rack_test)
#   end
#
#     #サポートモジュールでまとめた
    include LoginSupport

  scenario "int:ユーザは新しいプロジェクトを作成する" do
    user = FactoryBot.create(:user)

    #モジュールで作ったメソッド
    # sign_in_as user

    #Deviseのヘルパーでも同じことができる
    # visitでどこからワークフローを開始するか明示する
    sign_in user
    visit root_path

    expect {
      click_link "New Project"
      fill_in "Name", with: "Test Project"
      fill_in "Description", with: "Trying out Capybara"
      click_button "Create Project"

    }.to change(user.projects, :count).by(1)

    aggregate_failures do
      expect(page).to have_content "Project was successfully created."
      expect(page).to have_content "Test Project"
      expect(page).to have_content "Owner: #{user.name}"
    end
  end

  # scenario "ゲストがプロジェクトを追加する " do
  #   visit projects_path
  #   save_and_open_page
  #   click_link "New Project"
  # end
end
