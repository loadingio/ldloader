(->
  ldLoader = (opt={}) ->
    @opt = {active-class: \running, base-z: 10000, auto-z: true, class-name: '', atomic: true} <<< opt
    <[root container]>.map (n) ~> if opt[n] =>
      @[n] = (if Array.isArray(opt[n]) => opt[n] else [opt[n]]).map ->
        if typeof(it) == \string => document.querySelector(it) else it
    if !@container => @container = if @root => @root.map(-> it.parentNode) else [document.body]
    if !@root => @root = @container.map ->
        node = document.createElement("div")
        it.appendChild node
        return node
    @root.map ~> it.classList.add.apply it.classList, (@opt.class-name or '').split(' ').filter(->it)
    @root.map ~> it.classList.remove opt.active-class
    @ <<< running: false, count: 0
    @

  ldLoader.prototype = Object.create(Object.prototype) <<< do
    on: (delay=0) -> @toggle true, delay
    off: (delay=0, force = false) -> @toggle false, delay, force
    render: ->
      if !(@running and @opt.ctrl and @opt.ctrl.step) => return @render.runid = -1
      @render.runid = runid = Math.random!
      @render.start = 0
      if @opt.ctrl.init => @root.map ~> @opt.ctrl.init.call it
      _ = (t) ~>
        if !@render.start => @render.start = t
        @root.map ~> @opt.ctrl.step.call it, (t - @render.start)
        if @render.runid == runid => requestAnimationFrame -> _ it
        else if @opt.ctrl.done => @root.map ~> @opt.ctrl.done.call it, (t - @render.start)
      ret = requestAnimationFrame -> _ it
    toggle: (v, delay=0, force = false) ->
      d = (if !(v?) => (if @root.0.classList.contains @opt.active-class => -1 else 1) else if v => 1 else -1)
      if delay => return new Promise (res, rej) ~>
        if d > 0 => @toggle(v)then ~> setTimeout (~> res!), delay # if is on : resolve after on
        else => setTimeout (~> @toggle(v)then ~> res!), delay # if is off: off after resolve
      new Promise (res, rej) ~>
        @count += d
        if !force and !@opt.atomic and ( @count >= 2 or (@count == 1 and d < 0)) => return res!
        @root.map ~> it.classList[if d > 0 => \add else \remove](@opt.active-class)
        @running = running = @root.0.classList.contains(@opt.active-class)
        if !@opt.auto-z => return res!
        if running =>
          @z = z = (ldLoader.zstack[* - 1] or 0) + @opt.base-z
          @root.map ~> it.style.zIndex = z
          ldLoader.zstack.push z
        else
          if (idx = ldLoader.zstack.indexOf(@z)) < 0 => return res!
          @root.map ~> it.style.zIndex = ""
          ldLoader.zstack.splice(idx, 1)
        if @opt.ctrl => @render!
        res!

  ldLoader <<< do
    zstack: []

  window.ldLoader = ldLoader
)!
