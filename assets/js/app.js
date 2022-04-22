import "../css/app.css"
import "phoenix_html"

import custDef from "./word-count";

custDef();

const tb = document.getElementById("textbox");
const wc = document.querySelector("word-count");

tb.addEventListener('change', (e) => {
  wc.innerText = e.target.value;
})