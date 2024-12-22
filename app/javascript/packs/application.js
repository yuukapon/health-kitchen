// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

// 基本的なRailsの機能をインポート
import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

// 追加のインポート
import "jquery"
import "cocoon"

// スタイルシートのインポート
import "../stylesheets/application"

// Raty関連の設定
import Raty from 'raty-js'
window.raty = function(elem,opt) {
    let raty = new Raty(elem,opt)
    raty.init();
    return raty;
}
import './raty_config' 

// 機能別のJavaScriptファイルのインポート
import './sortable'

// Railsの機能を開始
Rails.start()
Turbolinks.start()
ActiveStorage.start()