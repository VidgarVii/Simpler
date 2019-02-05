class TestsController < Simpler::Controller
  def index
    # render 'tests/list'
    render plain: 'Plain text response'
    @tests = Test.all
  end

  def create; end
end
