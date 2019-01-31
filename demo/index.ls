ldld = {}
<[full default btn]>.map ->
  ldld[it] = new ldLoader root: ".test.#it"
ldld.ctrl = new ldLoader root: ".test.ctrl", ctrl: do
  step: (t) -> @innerText = "#{Math.round(t/100)/10}s passed."
  done: (t) -> @innerText = "Finished."

show = (name) -> ldld[name]on!; ldld[name]off 2000

btn-test = document.querySelector '.btn-test'
f = (t) ->
  requestAnimationFrame f
  x = Math.round(Math.sin(t * 0.001) * 300)
  btn-test.style.left = "#{x}px"


requestAnimationFrame f
