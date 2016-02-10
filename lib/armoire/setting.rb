class Armoire
  class Setting
    def initialize(setting)
      @setting = setting
    end

    def [](key)
      value = setting.fetch(key.to_s) do
        raise ConfigSettingMissing, %Q{"#{key}" is not set}
      end

      value.kind_of?(Hash) ? self.class.new(value) : value
    end

    def has_key?(key)
      setting.has_key?(key)
    end

    private
    attr_reader :setting
  end
end
