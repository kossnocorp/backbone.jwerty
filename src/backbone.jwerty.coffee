$        = window.jQuery or require?('jquery')
Backbone = window.Backbone or require?('backbone')
jwerty   = window.jwerty   or require?('jwerty').jwerty

KEYBOARD_RULE = /^<(.+)>($|\s.+$)/

originalDelegateEvents = Backbone.View::delegateEvents

Backbone.View::delegateEvents = (events) ->
  filteredEvents = {}
  keyboardEvents = {}

  for rule, callbackName of events
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
    [__, keys, selector] = rule.split(KEYBOARD_RULE)
    callback             = (args...) => @[callbackName](args...)
    eventName            = 'keydown.delegateEvents' + @cid

    if selector == ''
      @$el.bind(eventName, jwerty.event(keys, callback))

  @
