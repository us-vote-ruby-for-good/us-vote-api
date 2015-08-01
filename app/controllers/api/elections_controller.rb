module Api
  class ElectionsController < BaseController
    respond_to :json

    def index
      @elections = state.elections.active
      respond_with @elections, serializer: ElectionSerializer
    end

    private
    def state
      @state ||= State.find_by_code(params[:state_id])
    end
  end
end