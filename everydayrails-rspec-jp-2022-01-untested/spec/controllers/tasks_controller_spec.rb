require 'rails_helper'

RSpec.describe TasksController, type: :controller do

  before do
    @user = FactoryBot.create(:user)
    @project = FactoryBot.create(:project, owner: @user)
    @task = @project.tasks.create!(name: "Test task")
  end

  describe "#show" do
    context "認可されたユーザとして" do
      it "JSON形式でレスポンスを返すこと" do
        sign_in @user
        get :show, format: :json, params: { project_id: @project.id,
                                           id: @task.id}
        expect(response.content_type).to include "application/json"
      end
    end
  end

  describe "#create" do
    context "認可されたユーザとして" do
      it "JSON形式でレスポンスすること" do
        new_task = {name: "New test task"}
        sign_in @user
        post :create, format: :json, params: { project_id: @project.id,
                                               task: new_task}
        expect(response.content_type).to include "application/json"

      end
    end

    it "新しいタスクをプロジェクトに追加すること" do
      new_task = {name: "New test task" }
      sign_in @user
      expect {
        post :create, format: :json,
             params: { project_id: @project.id,
                       task: new_task }
      }.to change(@project.tasks, :count).by(1)
    end

    it "認証を要求すること" do
      new_task = { name: "New test task" }
      #ログインしない
      expect {
        post :create, format: :json,
             params: { project_id: @project.id,
                       task: new_task }
      }.to_not change(@project.tasks, :count)
      expect(response).to_not be_successful
    end
  end

end
