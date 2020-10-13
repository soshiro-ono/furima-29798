const pay = () => {
  Payjp.setPublicKey("pk_test_c14af9e90a5053a47099d067");
  const form = document.getElementById("charge-form");
  form.addEventListener("submit", (e) => {
    e.preventDefault();

    const formResult = document.getElementById("charge-form");
    const formData = new FormData(formResult);

    const card = {
      // この引数はなぜ"order[number]"とかにならない？ビューのform_withでモデルを指定指定なかららしいがよくわからない。ここはなぜ文字列？
      number: formData.get("number"),
      cvc: formData.get("cvc"),
      exp_month: formData.get("exp_month"),
      exp_year: `20${formData.get("exp_year")}`,
    };

    Payjp.createToken(card, (status, response) => {
      console.log(response)
      if (status == 200) {
        const token = response.id;
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} name='token' type="hidden"> `;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
      }

      document.getElementById("card-number").removeAttribute("name");
      document.getElementById("card-cvc").removeAttribute("name");
      document.getElementById("card-exp-month").removeAttribute("name");
      document.getElementById("card-exp-year").removeAttribute("name");
      // これはカードの情報をサーバーサイドに送らないようにするための記述。サーバーにはトークンの情報だけを送る

      document.getElementById("charge-form").submit();
    });
  });
};
window.addEventListener("load", pay);