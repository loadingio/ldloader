(->
  ldLoader = (opt={}) ->
    @opt = {active-class: \running, base-z: 10000, auto-z: true, class-name: '', atomic: false} <<< opt
    <[root container]>.map (n) ~>
      if opt[n] => @[n] = if typeof(opt[n]) == \string => document.querySelector(opt[n]) else opt[n]
    if !@container => @container = if @root => @root.parentNode else document.body
    if !@root =>
      @root = document.createElement("div")
      @container.appendChild @root
    @root.classList.add.apply @root.classList, (@opt.class-name or '').split(' ').filter(->it)
    @root.classList.remove opt.active-class
    @ <<< running: false, count: 0
    @

  ldLoader.prototype = Object.create(Object.prototype) <<< do
    on: (delay=0) -> @toggle true, delay
    off: (delay=0, force = false) -> @toggle false, delay, force
    render: ->
      if !(@running and @opt.ctrl and @opt.ctrl.step) => return @render.runid = -1
      @render.runid = runid = Math.random!
      @render.start = 0
      if @opt.ctrl.init => @opt.ctrl.init.call @root
      _ = (t) ~>
        if !@render.start => @render.start = t
        @opt.ctrl.step.call @root, (t - @render.start)
        if @render.runid == runid => requestAnimationFrame -> _ it
        else if @opt.ctrl.done => @opt.ctrl.done.call @root, (t - @render.start)
      ret = requestAnimationFrame -> _ it
    toggle: (v, delay=0, force = false) ->
      d = (if !(v?) => (if @root.classList.contains @opt.active-class => -1 else 1) else if v => 1 else -1)
      if delay => return new Promise (res, rej) ~>
        if d => @toggle(v)then ~> setTimeout (~> res!), delay # if is on : resolve after on
        else => setTimeout (~> @toggle(v)then ~> res!), delay # if is off: off after resolve
      new Promise (res, rej) ~>
        @count += d
        if !force and !@opt.atomic and ( @count >= 2 or (@count == 1 and d < 0)) => return res!
        @root.classList[if d > 0 => \add else \remove](@opt.active-class)
        @running = running = @root.classList.contains(@opt.active-class)
        if !@opt.auto-z => return res!
        if running =>
          @root.style.zIndex = @z = z = (ldLoader.zstack[* - 1] or 0) + @opt.base-z
          ldLoader.zstack.push z
        else
          if (idx = ldLoader.zstack.indexOf(@z)) < 0 => return res!
          @root.style.zIndex = ""
          ldLoader.zstack.splice(idx, 1)
        if @opt.ctrl => @render!
        res!

  ldLoader <<< do
    zstack: []

  window.ldLoader = ldLoader
)!
