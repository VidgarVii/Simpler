module Simpler
  class Controller
    def initialize(env)
      @request = Rack::Request.new(env)
      @response = Rack::Response.new
    end

    def make_response(_action)
      [
        200,
        { 'Content-Type' => 'text/plain' },
        ["Hello World\n"]
      ]
    end
  end
end
