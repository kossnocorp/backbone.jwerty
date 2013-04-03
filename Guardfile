class MochaRunner
  MOCHA_BIN = './node_modules/mocha/bin/mocha'
  FLAGS     = '--compilers coffee:coffee-script -R spec -c'
  ALL_PATH  = './spec/*_spec.coffee'

  def self.run!(m)
    system cmd(path(m))
  end

  def self.cmd(path)
    [MOCHA_BIN, path, FLAGS].join(' ')
  end

  def self.path(m)
    if m[1] == 'spec'
      m[0]
    else
      "spec/#{m[2]}_spec.coffee"
    end
  end
end

guard 'shell', all_on_start: true do
  watch(%r{^(src|spec)\/(.*)\.coffee$}) do |m|
    MochaRunner.run!(m)
  end
end
