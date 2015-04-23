module Edward
  module Value
    extend ActiveSupport::Concern

    module ClassMethods
      #
      # [counter description]
      # @param name [type] [description]
      # @param options={} [type] [description]
      # @param block [description]
      #
      # @return [type] [description]
      def value(name, options={})
        define_method(name) do
          Edward.ssdb.with do |conn|
            conn.get("#{self.class.to_s.pluralize.downcase}:#{self.id}:#{name}") || options[:default]
          end
        end

        define_method("#{name}=") do |v|
          Edward.ssdb.with do |conn|
            conn.set("#{self.class.to_s.pluralize.downcase}:#{self.id}:#{name}", v)
          end
        end
      end
    end
  end
end
