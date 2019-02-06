class TestsController < Simpler::Controller
  def index
    # render 'tests/list'
    # render plain: 'tests/list'
    @tests = Test.all
    status 201
  end

  def create; end

  def show
    @test = Test.find(id: params[:id])
  end
end
