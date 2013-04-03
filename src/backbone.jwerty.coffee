$        = window.jQuery or require?('jquery')
Backbone = window.Backbone or require?('backbone')
jwerty   = window.jwerty   or require?('jwerty').jwerty

KEYBOARD_RULE = /^<(.+)>($|\s.+$)/

originalDelegateEvents = Backbone.View::delegateEvents

Backbone.View::delegateEvents = (events) ->
  filteredEvents = {}
  keyboardEvents = {}

  for rule, callbackName of (events || @events)
    list = if KEYBOARD_RULE.test(rule)
             keyboardEvents
           else
             filteredEvents

    list[rule] = callbackName

  originalDelegateEvents.call(@, filteredEvents)
  @delegateKeyboardEvents(keyboardEvents)

  @

Backbone.View::delegateKeyboardEvents = (events) ->
  for rule, callbackName of events
    do (rule, callbackName) =>
      [__, keys, selector] = rule.split(KEYBOARD_RULE)
      eventName            = 'keydown.delegateEvents' + @cid
      callback             = (args...) => @[callbackName](args...)
      jwertyEvent          = jwerty.event(keys, callback)

      if selector == ''
        @$el.bind(eventName, jwertyEvent)
      else
        @$el.delegate(selector, eventName, jwertyEvent)

  @
