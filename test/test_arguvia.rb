require 'arguvia'
require 'test/unit'

class TestArguvia < Test::Unit::TestCase
  def setup
    # Simple boolean arguments
    @simple_strs = ["hola", "mundo", "vi-va", "--foo", "rivendel"]
    @simple_args = Arguvia.new(@simple_strs)

    # Function-like arguments
    @func_strs = ["hola(mundo)", "integer(12)", "float(12.345)",
                  "multi(1, 2, 3)", "ma-ny(a, ab, cde)"]
    @func_res  = {hola: "mundo", integer: 12,
                  float: 12.345, multi: [1, 2, 3],
                  ma_ny: ["a", "ab", "cde"]}
    @func_args = Arguvia.new(@func_strs)

    # Complex arguments
    @complex_strs = ["hola-mundo(saludo, despedida)", "--help",
                     "numbers(1, 1.23, -1, -3.245)",
                     "--file(/usr/hi/hola.txt)", "--PATH(ruby.exe)"]
    @complex_res  = {hola_mundo: ["saludo", "despedida"], _help: true,
                     numbers: [1, 1.23, -1, -3.245], _file: "/usr/hi/hola.txt",
                     _path: "ruby.exe"}
    @complex_args = Arguvia.new(@complex_strs)
  end

  #
  # Test simple arguments's method respond_to?
  #

  def test_false_respond_to
    false_strs = ["a", "bar", "gaga", "etc", "demons"]
    false_strs.each do |item|
      assert_equal(@simple_args.respond_to?(item.to_sym), false)
    end
  end

  def test_true_respond_to
    @simple_strs.each do |item|
      assert(@simple_args.respond_to? item.gsub(/-+/, "_").to_sym)
    end
  end

  #
  # Test simple arguments's generated members
  #
  def test_simple_arguvia_members
    @simple_strs.each do |name|
      assert(eval("@simple_args.#{name.gsub(/-+/, "_")}"))
    end
  end

  #
  # Test function-like argumens
  #
  def test_function_like_arguments
    @func_res.each do |key, value|
      assert_equal(eval("@func_args.#{key}"), value)
    end
  end

  #
  # Test complex function-like argumens
  #
  def test_complex_arguments
    @complex_res.each do |key, value|
      assert_equal(eval("@complex_args.#{key}"), value)
    end
  end
end
