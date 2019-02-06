module Simpler
  class Router
    class Route
      attr_reader :controller, :action

      def initialize(method, path, controller, action)
        @method     = method
        @path       = path
        @controller = controller
        @action     = action
      end

      def match?(method, path)
        @method == method && correct_path?(path)
      end

      def params(env)
        request = Rack::Request.new(env)
        request.env['simpler.params'] = request.params
        request.env['simpler.params'].merge!(make_params(env['PATH_INFO'], @path))

        request.env['simpler.params']
      end

      private

      def make_params(env_info, path)
        path = path.split('/')
        path.delete_at(0)
        env_info = env_info.split('/')
        env_info.delete_at(0)
        result = {}

        path.zip(env_info) do |key, value|
          key = key.delete(':').to_sym
          result[key] = value
        end

        result
      end

      def correct_path?(path)
        correct_params_count?(path) && path.match?(path_regexp)
      end

      def correct_params_count?(path)
        path.split('/').size == @path.split('/').size
      end

      def path_regexp
        @path.include?(':id') ? @path.gsub(':id', '[[:alnum:]]') : @path
      end
    end
  end
end
