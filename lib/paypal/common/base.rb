module PayPal::Common::Base
  def initialize(attributes = {})
    attributes.each do |name, value|
      attr_name = underscore(name)
      if respond_to?("set_#{attr_name}") and (value.is_a?(Hash) or value.is_a?(Array))
        send("set_#{attr_name}", value)
      elsif respond_to?("#{attr_name}=")
        send("#{attr_name}=", value)
      end
    end
    after_initialize
  end

  def after_initialize
  end

  def request
    PayPal::Common::Request.new
  end

  def build_value(klass, value)
    if value.is_a?(Hash)
      klass.new(value)
    elsif value.is_a?(Array)
      value.map do |val|
        val.is_a?(Hash) ? klass.new(val) : val
      end
    else
      value
    end
  end

  def build_datetime(value)
    if value.respond_to?(:to_time)
      value.to_time
    else
      Time.parse(value.to_s)
    end
  rescue
  end

  def hash_keys
    {}
  end

  def to_hash(*args)
    ivars = args.empty? ? instance_variables : instance_variables.select { |var| args.include?(var[1..-1].to_sym) }
    Hash[
      ivars.map do |var|
        val = instance_variable_get(var)
        if val.is_a?(Array)
          val.map! { |a| a.respond_to?(:to_hash) ? a.to_hash : a }
        elsif val.respond_to?(:iso8601)
          val = val.iso8601
        else
          val = val.to_hash if val.respond_to?(:to_hash)
        end
        hash_key = hash_keys[var[1..-1].to_sym] || camelize(var[1..-1], false).to_sym
        [hash_key, val]
      end
    ]
  end

  def to_json(*args)
    MultiJson.dump(to_hash(*args))
  end

  def underscore(word)
    word.to_s.gsub(/::/, '/').
    gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    gsub(/([a-z\d])([A-Z])/,'\1_\2').
    tr("-", "_").
    downcase
  end

  def camelize(lower_case_and_underscored_word, first_letter_in_uppercase = true)
    if first_letter_in_uppercase
      lower_case_and_underscored_word.to_s.gsub(/\/(.?)/) { "::" + $1.upcase }.gsub(/(^|_)(.)/) { $2.upcase }
    else
      lower_case_and_underscored_word.to_s[0] + camelize(lower_case_and_underscored_word.to_s)[1..-1]
    end
  end
end