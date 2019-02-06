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

      private

      def correct_path?(path)
        correct_params_count?(path) && path.match?(correct_path)
      end

      def correct_params_count?(path)
        path.split('/').size == @path.split('/').size
      end

      def correct_path
        @path.include?(':id') ? @path.gsub(':id', '[[:digit:]]') : @path
      end
    end
  end
end
