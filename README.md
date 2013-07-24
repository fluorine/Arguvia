Arguvia v0.1.0
==============
This gem contains a function-like argument parser
for command-line applications.

This is an example of a command-line application
that uses function-like arguments:

	dictionary.rb words(10) open-file(words.txt) Singular


Description
-----------
Arguvia gem allows any Ruby application to use function-like
arguments for its command-line interface.

This gem contains the `Arguvia` class, which parses the given
list of arguments to map them to class members and indeternal
Ruby values.


Using the Arguvia class
-----------------------
Let's take the introductory example to show how
the `Arguvia` class works:

	dictionary.rb words(10) open-file(words.txt) Singular

The `dictionary.rb` hypothetic script uses function-like
command-line arguments through the `arguvia` gem.

The `Arguvia` class generates the class members for
the given command-line arguments.

	require 'arguvia'
	x = Arguvia.new     # It equals to 'Arguvia.new(ARGV)'
	x.words             # => 10
	x.open_file         # => "words.txt"
	x.singular          # => true
	x.undefined         # => false

`Arguvia` class uses the dynamic and metaprogramming
features of Ruby to generate an object, which members maps
the given arguments.

Examples of valid arguments
----------------------------------
|Argument   |Identifier | Value  |
|:---------:|:---------:|:------:|
|foo        |`x.foo`    |true    |
|--etc      |`x._etc `  |true    |
|-h         |`x._h`     |true    |
|           |`x.baz`    |nil     |
|func(1)    |`x.func`   |1       |
|dir(etc)   |`x.dir`    |"etc"   |
|xs(1, 2, 3)|`x.xs`     |[1,2,3] |
|pair(a, 7) |`x.pair`   |["a", 7]|

To do
-----
- Support for special symbols.
- Support for literal strings (allow internal spaces)