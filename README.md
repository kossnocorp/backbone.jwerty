# jwerty integrated into Backbone.js events

[![Build Status](https://secure.travis-ci.org/kossnocorp/backbone.jwerty.png?branch=master)](http://travis-ci.org/kossnocorp/backbone.jwerty)

``` javascript
var InlineField = Backbone.View.extend({

  events: {
    '<esc> input':   'cancel',
    '<enter> input': 'save'
  },

  cancel: function () { /* ... */ },

  save: function () { /* ... */ }
});
```

More info coming soon.

## API

### #delegateKeyboardEvents()

Delegates keyboard events. Accept events map as first argument.

``` js
view.delegateKeyboardEvents({ '<esc> input': 'cancel', '<enter> input': 'save' });
```

## Roadmap

See [milestones](https://github.com/kossnocorp/backbone.jwerty/issues/milestones).

## Changelog

This project uses [Semantic Versioning](http://semver.org/) for release numbering.

### v0.1.0 (unreleased)

First, initial release.

## Behind the code

Initially sponsored by [Toptal](http://toptal.com/).

Idea and code by [@kossnocorp](http://koss.nocorp.me/).

Check out full list of [contributors](https://github.com/kossnocorp/backbone.jwerty/contributors).

This project is a member of the [OSS Manifesto](http://ossmanifesto.org/).

## License

The MIT License

Copyright (c) 2013 Sasha Koss

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
