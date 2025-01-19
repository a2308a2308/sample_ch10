// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "custom/menu"

document.addEventListener("click", () => {
  const alert = document.querySelector(".alert");
  if (alert) {
    alert.remove();
  }
});

// 1秒後に「正解です」のメッセージを消す処理
document.addEventListener("DOMContentLoaded", () => {
  const alert = document.querySelector(".alert");
  if (alert) {
    setTimeout(() => {
      alert.remove();
    }, 1000); // 1秒後に削除
  }
});