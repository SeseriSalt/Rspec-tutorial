RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: :system, js: true) do
    driven_by :selenium_chrome_headless
  end


end
#ボタンが現れるまで待つ時間（デフォルトで2秒）
Capybara.default_max_wait_time = 2