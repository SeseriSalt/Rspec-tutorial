require 'rails_helper'

RSpec.describe "Tasks", type: :system do

  scenario "int:ユーザがタスクを追加する" do
    user = FactoryBot.create(:user)
    project = FactoryBot.create(:project,
                                name: "Rspec tutorial", owner: user)
    # task = project.tasks.create!(name: "Finish RSpec tutorial")

    visit root_path
    click_link "Sign in"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    expect{
      click_link "Rspec tutorial"
      expect(page).to have_current_path "/projects/#{project.id}"
      click_link "Add Task"
      expect(page).to have_current_path "/projects/#{project.id}/tasks/new"

      fill_in "Name", with: "New test task"
      click_button "Create Task"

      expect(page).to have_current_path "/projects/#{project.id}"
      expect(page).to have_content "Task was successfully created."
      expect(page).to have_content "New test task"
    }.to change(project.tasks, :count).by(1)



  end


  scenario "int:ユーザがタスクの状態を切り替える", js: true do
    user = FactoryBot.create(:user)
    project = FactoryBot.create(:project,
                                name: "Rspec tutorial", owner: user)
    task = project.tasks.create!(name: "Finish RSpec tutorial")

    visit root_path
    click_link "Sign in"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    click_link "Rspec tutorial"
    check "Finish RSpec tutorial"

    expect(page).to have_css "label#task_#{task.id}.completed"
    expect(task.reload).to be_completed
    # take_screenshot
    uncheck "Finish RSpec tutorial"

    expect(page).to_not have_css "label#task_#{task.id}.completed"
    expect(task.reload).to_not be_completed


  end
end
