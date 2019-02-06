require_relative 'view'

module Simpler
  class Controller
    attr_reader :name, :params
    attr_accessor :headers

    def initialize(env)
      @name     = extract_name
      @request  = Rack::Request.new(env)
      @response = Rack::Response.new
      @headers  = @response.headers
      @params = {}
    end

    def make_response(action)
      @request.env['simpler.action']     = action
      @request.env['simpler.controller'] = self
      @request.env['simpler.params'] = @request.params

      set_params
      set_default_headers
      send(action)
      write_response

      @response.finish
    end

    private

    def set_params
      @params[:id] = @request.env['PATH_INFO'].split('/')[2]
    end

    def status(value)
      @response.status = value
    end

    def render(template)
      @request.env['simpler.template'] = template
    end

    def extract_name
      self.class.name.match('(?<name>.+)Controller')[:name].downcase
    end

    def set_default_headers
      @response['Content-Type'] = 'text/html'
    end

    def write_response
      body = if @request.env['simpler.template'].is_a?(Hash) && @request.env['simpler.template'].key?(:plain)
               @request.env['simpler.template'][:plain]
             else
               render_body
             end

      @response.write(body)
    end

    def render_body
      View.new(@request.env).render(binding)
    end
  end
end
