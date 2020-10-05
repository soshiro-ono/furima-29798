function calculation() {
  const price = document.getElementById("item-price")
  const pricetax = document.getElementById("add-tax-price")
  const pricegain = document.getElementById("profit")

  price.addEventListener("input",function(){
    money = document.getElementById("item-price").value
    pricetax.innerHTML = Math.floor(money * 0.1)
    pricegain.innerHTML = Math.floor(money * 0.9)
  })
  // pricetax.addEventListener("oninput",function(){
  //   pricetax.innerHTML = price * 0.1
  // })
  // pricegain.addEventListener("oninput",function(){
  //   pricegain.innerHTML = price - pricetax
  // })


}
window.addEventListener('load',calculation)
// 関数の名前の付け方のコツを聞く


