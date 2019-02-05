module Simpler
  class Controller
    def initialize(env)
      @request = Rack::Request.new(env)
      @response = Rack::Response.new
    end

    def make_response(action)
      [
        200,
        { 'Content-Type' => 'text/plain', 'X-Simpler-Action' => action },
        ["Hello World\n"]
      ]
    end
  end
end
