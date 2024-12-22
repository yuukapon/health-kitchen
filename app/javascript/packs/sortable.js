// SortableJSライブラリをインポート
import Sortable from 'sortablejs';

// Turbolinksでページが読み込まれた時に実行される処理を設定
document.addEventListener('turbolinks:load', () => {
  const elements = document.querySelectorAll('.sortable-list');
  elements.forEach((element) => {
    new Sortable(element, {
      handle: '.handle',
      animation: 150,
      ghostClass: 'sortable-ghost'
    });
  });
});
