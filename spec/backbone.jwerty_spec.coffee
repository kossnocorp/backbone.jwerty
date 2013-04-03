jsdom           = require('jsdom').jsdom
global.document = jsdom()
global.window   = document.createWindow()
$ = global.$ = global.jQuery = require('jquery')

chai      = require('chai')
sinon     = require('sinon')
sinonChai = require('sinon-chai')
Backbone  = require.call({a:1, b:2}, 'backbone')
jwerty    = require('jwerty').jwerty

originalDelegateEventsSpy = sinon.spy(Backbone.View::, 'delegateEvents')

require('../src/backbone.jwerty.coffee')

chai.should()
chai.use(sinonChai)

Backbone.$ = $

describe 'Backbone jwerty integration', ->

  MIXED_EVENTS =
    '<esc>':         'cancel'
    '<enter> input': 'save'
    'click':         'click'
    'blur input':    'blur'

  afterEach ->
    originalDelegateEventsSpy.reset()

  describe '#delegateEvents()', ->

    beforeEach ->
      @view = new Backbone.View()

    it 'returns this', ->
      @view.delegateEvents({}).should.eq @view

    it 'calls original delegateEvents with filtered events', ->
      @view.delegateEvents(MIXED_EVENTS)
      originalDelegateEventsSpy.should.be.calledWithMatch \
        sinon.match('click': 'click', 'blur input': 'blur')

    it 'calls delegateKeyboardEvents with filtered keyboard events', ->
      stub = sinon.stub(@view, 'delegateKeyboardEvents')
      @view.delegateEvents(MIXED_EVENTS)
      stub.should.be.calledWithMatch \
        sinon.match('<esc>': 'cancel', '<enter> input': 'save')
      stub.restore()

  describe '#delegateKeyboardEvents()', ->

    describe 'bind to @el', ->

      beforeEach ->
        @$el  = $('<input>').appendTo('body')
        @view = new Backbone.View(el: @$el)
        @view.cancel = ->
        @view.delegateKeyboardEvents('<esc>': 'cancel')
        @spy = sinon.spy(@view, 'cancel')

      afterEach ->
        @spy.restore()

      it 'returns this', ->
        @view.delegateKeyboardEvents({}).should.eq @view

      it 'binds keyboard event to el', ->
        jwerty.fire('esc', @$el)
        @spy.should.be.called
