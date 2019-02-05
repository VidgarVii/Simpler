class TestsController < Simpler::Controller
  def index
    # render 'tests/list'
    @tests = Test.all
    status 201
  end

  def create; end
end
