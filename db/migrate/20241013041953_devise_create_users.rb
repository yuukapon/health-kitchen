# frozen_string_literal: true
class DeviseCreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      ## ユーザー基本情報
      t.string :name, null: false      # 'ユーザー名'
      t.string :email, null: false, default: "", limit: 255      #'メールアドレス'
      t.string :encrypted_password, null: false, default: ""      #暗号化されたパスワード'
      t.text :introduction, limit: 250       # '自己紹介文'
      t.boolean :is_active, null: false, default: true      #'アカウント有効状態'

      ## Recoverable（パスワードリセット）
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable（ログイン記憶）
      t.datetime :remember_created_at

      # t.integer  :sign_in_count, default: 0, null: false
      # t.datetime :current_sign_in_at
      # t.datetime :last_sign_in_at
      # t.string   :current_sign_in_ip
      # t.string   :last_sign_in_ip

      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email

      # t.integer  :failed_attempts, default: 0, null: false
      # t.string   :unlock_token
      # t.datetime :locked_at

      t.timestamps null: false
    end

    ## インデックス
    add_index :users, :email, unique: true
    add_index :users, :reset_password_token, unique: true
    # add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true
  end
end