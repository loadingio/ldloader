(->
  ldLoader = (opt={}) ->
    <[root container]>.map (n) ~>
      if opt[n] => @[n] = if typeof(opt[n]) == \string => document.querySelector(opt[n]) else opt[n]
    if !@container => @container = if @root => @root.parentNode else document.body
    if !@root =>
      @root = document.createElement("div")
      @root.classList.add \default
      @container.appendChild @root
    @root.classList.add \ldld
    @root.classList.remove \active
    @count = 0
    @

  ldLoader.prototype = Object.create(Object.prototype) <<< do
    on: (delay=0) -> @toggle true, delay
    off: (delay=0) ->  @toggle false, delay
    toggle: (v,delay=0) ->
      if delay => return setTimeout (~> @toggle v), delay
      d = (if !(v?) => (if @root.classList.contains \active => -1 else 1) else if v => 1 else -1)
      @count += d
      if @count >= 2 or (@count == 1 and d < 0) => return
      @root.classList[if !(v?) => \toggle else if v => \add else \remove](\active )

  window.ldLoader = ldLoader
)!
