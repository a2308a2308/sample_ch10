// メニュー操作

// トグルリスナーを追加してクリックをリッスンする
document.addEventListener("turbo:load", function() {
  let hamburger = document.querySelector("#hamburger");
  if (hamburger){
    hamburger.addEventListener("click", function(event) {
      event.preventDefault();
      let menu = document.querySelector("#navbar-menu");
      menu.classList.toggle("collapse");
    });
  }

  let account = document.querySelector("#account");
  if (account) {
    account.addEventListener("click", function(event) {
      event.preventDefault();
      let menu = document.querySelector("#account-dropdown-menu");
      menu.classList.toggle("active");
    });
  }
  // a2308 add
  let game = document.querySelector("#game");
  if (game) {
    game.addEventListener("click", function(event) {
      event.preventDefault();
      let menu = document.querySelector("#game-dropdown-menu");
      menu.classList.toggle("active");
    });
  }
  
});
