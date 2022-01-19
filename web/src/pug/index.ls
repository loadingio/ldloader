ldld = {}
<[full default btn]>.map ->
  ldld[it] = new ldloader root: ".test.#it"
ldld.ctrl = new ldloader root: ".test.ctrl", ctrl: do
  step: (t) -> @innerText = "#{Math.round(t/100)/10}s passed."
  done: (t) -> @innerText = "Finished."

ldld.all = new ldloader root: Array.from(document.querySelectorAll(".all"))

window.show = (name) -> ldld[name]on!; ldld[name]off 2000

btn-test = document.querySelector '.btn-test'
f = (t) ->
  requestAnimationFrame f
  x = Math.round(Math.sin(t * 0.001) * 300)
  btn-test.style.left = "#{x}px"

requestAnimationFrame f

zm = new zmgr!
content = document.querySelectorAll(\#content)
ldld-z = [
  new ldloader container: content, class-name: 'ldld ldld-4', zmgr: zm, auto-z: true
  new ldloader container: content, class-name: 'ldld ldld-3', zmgr: zm, auto-z: true
  new ldloader container: content, class-name: 'ldld ldld-2', zmgr: zm, auto-z: true
  new ldloader container: content, class-name: 'ldld ldld-1', zmgr: zm, auto-z: true
]
debounce 1000
  .then -> ldld-z.3.on!  .then -> debounce 1000
  .then -> ldld-z.2.on!  .then -> debounce 1000
  .then -> ldld-z.1.on!  .then -> debounce 1000
  .then -> ldld-z.0.on!  .then -> debounce 1000
  .then -> ldld-z.3.off! .then -> debounce 1000
  .then -> ldld-z.2.off! .then -> debounce 1000
  .then -> ldld-z.1.off! .then -> debounce 1000
  .then -> ldld-z.0.off! .then -> debounce 1000
