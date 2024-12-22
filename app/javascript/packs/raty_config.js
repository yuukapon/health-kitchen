// raty_config.js
import Raty from 'raty-js';  // Ratyをインポート

document.addEventListener('turbolinks:load', function() {
    document.querySelectorAll('.rating-display').forEach(function(elem) {
        // 新しいRatyインスタンスを直接作成
        const newRaty = new Raty(elem);
        newRaty.init({
            starOn: '/assets/star-on.png',
            starOff: '/assets/star-off.png',
            starHalf: '/assets/star-half.png',
            score: elem.dataset.score,
            readOnly: true,
            half: true,
            number: 5
        });
    });
});