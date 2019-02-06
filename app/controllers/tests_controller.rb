class TestsController < Simpler::Controller
  def index
    # render 'tests/list'
    @tests = Test.all
    status 201
    # headers['Content-Type'] = 'text/plain'
  end

  def create; end

  def show
    @test = Test.find(id: params[:id])
  end
end
