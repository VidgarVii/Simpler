require 'logger'

class AppLogger
  def initialize(app)
    @app    = app
    @logger = Logger.new(Simpler.root.join('log/app.log'))
  end

  def call(env)
    status, headers, response = @app.call(env)
    @logger.info(make_log(env, status, headers))
    [status, headers, response]
  end

  private

  def make_log(env, status, headers)
    {
      Request: "#{env['REQUEST_METHOD']} #{env['REQUEST_PATH']}",
      Handler: "#{env['simpler.controller'].class}##{env['simpler.action']}",
      Parameters: env['simpler.params'],
      Response: "#{status} [#{headers['Content-Type']}] #{env['simpler.template_path']}"
    }
  end
end
