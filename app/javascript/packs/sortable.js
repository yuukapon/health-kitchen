import Sortable from 'sortablejs';

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