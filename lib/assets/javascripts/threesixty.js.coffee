$ = jQuery

# Constant equivalent to 360°
Math.TAU ||= Math.PI * 2

$.fn.threeSixty = (options) ->
  return this unless @length
  @each ->
    $(this).data
      threeSixty: new $.fn.threeSixty.ThreeSixty(this, options)

$.fn.threeSixty.defaults =
  size: 100
  # Rings (canvas)
  loadRingColor:       "#ccc"
  playRingColor:       "#000"
  backgroundRingColor: "#eee"
  # CSS for player
  initializedCssClass: "ts-initialized"
  playingCssClass:     "ts-playing"
  pausedCssClass:      "ts-paused"
  bufferingCssClass:   "ts-buffering"
  draggingCssClass:    "ts-dragging"
  # In/out Animation
  animationDuration: 500
  animationEasing:   'swing'
  # Events
  eventNamespace: "threesixty"

class $.fn.threeSixty.ThreeSixty
  constructor: (el, options = {}) ->
    @$el     = $ el
    @options = $.extend({}, $.fn.threeSixty.defaults, options, @$el.data())
    # Dimensions
    @size             = @options.size
    @radius           = @size * 0.4
    @ringWidth        = @size * 0.175
    @currentRadius    = 1
    @currentRingWidth = 1
    # Internal elements
    @$canvas = null # 360° seek bar (canvas)
    @$button = null # Play/Pause button (center)
    @$timer  = null # Timer (coterminous to $button, total ellapsed seconds)
    @$seeker = null # 360° seek bar (invisible click area)
    @ctx     = null
    # Sound
    @sound       = null
    @hasBuffered = false

    @init()

  init: ->
    @$el.addClass('ts-player')
      # Add player internal components
      .append($(document.createElement('div')).addClass('ts-player-inner')
        .append(@$canvas = $(document.createElement('canvas')).addClass('ts-canvas').attr(width: @size, height: @size))
        .append(@$button = $(document.createElement('a')).addClass('ts-button'))
        .append(@$timer  = $(document.createElement('div')).addClass('ts-timer').text("0"))
        .append(@$seeker = $(document.createElement('div')).addClass('ts-seeker')))
      # Hide fake el
      .addClass(@options.initializedCssClass)
      # Enable event for seeker
      .on('mousedown', '.ts-seeker', $.proxy(@handleMouseDown, @))
      # Enable event for play/pause
      .on('click',     '.ts-button', $.proxy(@handleClick, @))

    @ctx = @$canvas.get(0).getContext('2d')

  initSound: ->
    return if @sound?
    soundUrl = @options.url || @$el.next('a').attr('href')
    @sound = soundManager.createSound
      autoLoad: false
      autoPlay: false
      url: soundUrl
      onplay: => @fanIn() if @hasBuffered
      onstop: => @fanOut()
      onpause: => @togglePlaying off
      onresume: => @togglePlaying on
      onfinish: => @fanOut()
      onbufferchange: =>
        if @sound.isBuffering
          @$el.addClass(@options.bufferingCssClass)
        else
          @hasBuffered = true
          @$el.removeClass(@options.bufferingCssClass)
          @fanIn()
      whileloading: => @draw()
      whileplaying: => @draw()

  fanIn: ->
    @togglePlaying on
    @animate 1, @radius, 1, @ringWidth

  fanOut: ->
    @animate @radius, 1, @ringWidth, 1, =>
      @$el.removeClass(@options.playingCssClass)

  animate: (fromRadius, toRadius, fromRingWidth, toRingWidth, complete) ->
    @currentRadius    = fromRadius
    @currentRingWidth = fromRingWidth
    $(document.createElement('div'))
      .prop(dummy: 0)
      .animate { dummy: 1 },
        duration: @options.animationDuration
        easing: @options.animationEasing
        step: (currentStep) =>
          @currentRadius    = fromRadius    + ((toRadius - fromRadius)       * currentStep)
          @currentRingWidth = fromRingWidth + ((toRingWidth - fromRingWidth) * currentStep)
          @draw()
        complete: =>
          complete() if complete

  drawSolidArc: (color, percent) ->
    innerRadius = @currentRadius - @currentRingWidth
    radians     = percent * Math.TAU
    @ctx.beginPath()
    @ctx.arc(0, 0, @currentRadius, 0, radians, false)
    @ctx.lineTo(innerRadius * Math.cos(radians), innerRadius * Math.sin(radians))
    @ctx.arc(0, 0, innerRadius, radians, 0, true)
    @ctx.closePath()
    @ctx.fillStyle = color
    @ctx.fill()

  draw: ->
    # Refresh timer
    position = parseInt(@sound.position / 1000, 10).toString()
    position = 0 if isNaN(position)
    @$timer.text(position)

    # Refresh rings (canvas)
    @ctx.save() # begin
    # Clean slate
    @ctx.clearRect(0, 0, @size, @size)
    # Move (0,0) to the center
    @ctx.translate(@size / 2, @size / 2)
    # Move starting angle to the top
    @ctx.rotate(-Math.TAU / 4)
    # background ring
    @drawSolidArc(@options.backgroundRingColor, 1)
    # loaded ring
    loaded = if @sound?.bytesTotal? then (@sound.bytesLoaded / @sound.bytesTotal) else 1
    @drawSolidArc(@options.loadRingColor, loaded)
    # played ring
    played = if @sound?.durationEstimate? then (@sound.position / @sound.durationEstimate) else 0
    @drawSolidArc(@options.playRingColor, played)
    @ctx.restore() # end

  togglePlaying: (playing) ->
    if playing
      @$el.removeClass(@options.pausedCssClass).addClass(@options.playingCssClass)
    else
      @$el.removeClass(@options.playingCssClass).addClass(@options.pausedCssClass)

  handleClick: (e) ->
    # Accept only left clicks
    return true if e.which isnt 1

    e.preventDefault()

    @initSound()
    @sound.togglePause()
    @draw()

  getCanvasCenter: ->
    {left, top} = @$canvas.offset()
    x: left + @size / 2
    y: top  + @size / 2

  handleMouseDown: (e) ->
    # Accept only left clicks
    return true if e.which isnt 1

    e.preventDefault()

    @$el.addClass(@options.draggingCssClass)
    data = @getCanvasCenter()
    data.mousedown = e
    $(document)
      .on("mousemove.#{@eventNamespace}", null, data, $.proxy(@handleMouseMove, @))
      .on("mouseup.#{@eventNamespace}", $.proxy(@handleMouseUp, @))
      .trigger("mousemove.#{@eventNamespace}")

  handleMouseMove: (e) ->
    deltaX = (e.pageX ? e.data.mousedown.pageX) - e.data.x
    deltaY = (e.pageY ? e.data.mousedown.pageY) - e.data.y
    radians = Math.PI - Math.atan2(deltaX, deltaY)
    @sound.setPosition @sound.durationEstimate * (radians / Math.TAU)

  handleMouseUp: (e) ->
    $(document).off(".#{@eventNamespace}")
    @$el.removeClass(@options.draggingCssClass)
