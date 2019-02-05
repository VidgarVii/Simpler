module Simpler
  class Router
    class Route
      attr_reader :controller, :action

      def initialize(method, path, controller)
        @method = method
        @path = path
        @controller = controller
      end
    end
  end
end
