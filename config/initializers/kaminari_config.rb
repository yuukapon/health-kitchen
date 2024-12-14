# frozen_string_literal: true

Kaminari.configure do |config|
  config.default_per_page = 5 # グリッドレイアウトに適した数
  config.window = 2            # 現在のページの前後2ページを表示
  config.outer_window = 1      # 最初と最後から1ページずつ表示
  
  # config.max_per_page = nil
  # config.left = 0
  # config.right = 0
  # config.page_method_name = :page
  # config.param_name = :page
  # config.max_pages = nil
  # config.params_on_first_page = false
end
