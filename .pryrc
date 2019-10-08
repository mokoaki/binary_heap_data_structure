# frozen_string_literal: true

if defined?(Pry)
  Pry.commands.alias_command('ll', 'ls')
end

if defined?(PryByebug)
  Pry.commands.alias_command('s', 'step')
  Pry.commands.alias_command('n', 'next')
  Pry.commands.alias_command('f', 'finish')
  Pry.commands.alias_command('c', 'continue')

  Pry::Commands.command(/\A\z/, 'repeat last command') do
    _pry_.run_command Pry.history.to_a.last
  end
end
