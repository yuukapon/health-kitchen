// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "jquery"
import "../stylesheets/application"
import "cocoon"
import './sortable'

// raty-jsのインポート
import Raty from 'raty-js'

// グローバルにratyを定義
window.raty = function(elem,opt) {
    let raty = new Raty(elem,opt)
    raty.init();
    return raty;
}

// Turbolinksロード時に星評価を再初期化
document.addEventListener('turbolinks:load', () => {
    const event = document.createEvent('Event');
    event.initEvent('DOMContentLoaded', true, true);
    document.dispatchEvent(event);
});

Rails.start()
Turbolinks.start()
ActiveStorage.start()