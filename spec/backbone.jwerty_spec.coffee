jsdom           = require('jsdom').jsdom
global.document = jsdom()
global.window   = document.createWindow()
$ = global.$ = global.jQuery = require('jquery')

chai      = require('chai')
sinon     = require('sinon')
sinonChai = require('sinon-chai')
Backbone  = require('backbone')
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

      it 'returns this', ->
        @view.delegateKeyboardEvents({}).should.eq @view

      it 'binds keyboard event to el', ->
        @view.cancel = sinon.spy()
        @view.save   = sinon.spy()
        @view.delegateKeyboardEvents('<esc>': 'cancel', '<enter>': 'save')
        jwerty.fire('esc', @$el)
        jwerty.fire('enter', @$el)
        @view.cancel.should.be.calledOnce
        @view.save.should.be.calledOnce

      it 'uses @events if argument is not passed', ->
        klass = class extends Backbone.View
          events:
            '<esc>':   'cancel'
            '<enter>': 'save'
        view = new klass(el: @$el)
        view.cancel = sinon.spy()
        view.save   = sinon.spy()
        jwerty.fire('esc', @$el)
        jwerty.fire('enter', @$el)
        view.cancel.should.be.calledOnce
        view.save.should.be.calledOnce

    describe 'bind to selector', ->

      it 'binds keyboard event to selector', ->
        @$el  = $('<div><input></div>').appendTo('body')
        view = new Backbone.View(el: @$el)
        view.cancel = ->
        view.delegateKeyboardEvents('<esc> input': 'cancel')
        spy = sinon.spy(view, 'cancel')
        jwerty.fire('esc', @$el.find('input'))
        spy.should.be.called
        spy.restore()

  describe '#undelegateEvents()', ->

    it 'unbinds keyboard events binded to @el', ->
      @$el  = $('<input>').appendTo('body')
      view = new Backbone.View(el: @$el)
      view.cancel = ->
      view.delegateKeyboardEvents('<esc>': 'cancel')
      view.undelegateEvents()
      spy = sinon.spy(view, 'cancel')
      jwerty.fire('esc', @$el)
      spy.should.not.be.called
      spy.restore()

    it 'unbinds keyboard events delegated to selector', ->
      @$el  = $('<div><input></div>').appendTo('body')
      view = new Backbone.View(el: @$el)
      view.cancel = ->
      view.delegateKeyboardEvents('<esc> input': 'cancel')
      spy = sinon.spy(view, 'cancel')
      view.undelegateEvents()
      jwerty.fire('esc', @$el.find('input'))
      spy.should.not.be.called
      spy.restore()

