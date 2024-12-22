import Sortable from 'sortablejs';

// 両方のイベントをリッスンして、確実に初期化されるようにする
const initializeSortable = () => {
  const elements = document.querySelectorAll('.sortable-list');
  elements.forEach((element) => {
    if (!element.dataset.sortableInitialized) {  // 二重初期化を防ぐ
      new Sortable(element, {
        handle: '.handle',
        animation: 150,
        ghostClass: 'sortable-ghost'
      });
      element.dataset.sortableInitialized = 'true';
    }
  });
};

// 通常のページロードとTurbolinksの両方に対応
document.addEventListener('DOMContentLoaded', initializeSortable);
document.addEventListener('turbolinks:load', initializeSortable);