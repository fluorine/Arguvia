class Arguvia
  def initialize(args = ARGV)
    @args = {}

    # Add bindings
    args.each do |arg|
      case arg
      when /^([\w\-]+)$/
        @args[__parse_key(arg)] = true
      when /^([\w\-]+)\((.*)\)$/
        @args[__parse_key($1)] = __parse_value($2)
      else
        raise ArgumentError
      end
    end
  end

  # Generate ghost methods, if requiered
  def method_missing(name, *args)
    super unless args.length == 0
    @args[name]
  end

  # Add ghost methods to list of methods
  def methods
    super + @args.keys
  end

  # Add responding methods
  def respond_to?(name)
    return true if @args.keys.include? name
    super(name)
  end

  #
  # Internal methods
  #

  private

  # Parse key type
  def __parse_key(str)
    return str.gsub(/-+/, "_").downcase.to_sym
  end

  # Parse value type
  def __parse_value(str)
    case str
    when /,/
      # Split and evaluate recursively
      # if multiple arguments.
      str.split(/,/).map do |item|
        __parse_value(item.strip)
      end
    when /-?\d+\.\d+/
      str.to_f
    when /-?\d+/
      str.to_i
    else
      str
    end
  end
end

args = ["hola", "viva-Cristo(Dios, Jesus, 3.14)", "YHWH", "length(-76.99)", "points(-5)"]
a = Arguvia.new(args)

p a.methods
p a.hola
p a.yhwh
p a.viva_cristo
p a.length
p a.points
p "respond to :hola -> " + a.respond_to?(:hola).to_s