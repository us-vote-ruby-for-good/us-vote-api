class Admin::StatesController < Admin::BaseController
  before_action :set_state, only: [:show, :edit]

  # GET /admin/states
  # GET /admin/states.json
  def index
    @states = State.all
  end

  def show
    @state = set_state
  end
 
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_state
      @state = State.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def state_params
      params.require(:state).permit(:name, :code, :drupal_id)
    end
end
