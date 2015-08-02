module Api
  class ElectionsController < BaseController
    respond_to :json
    serialization_scope nil # TODO: why is this necessary?

    def index
      @elections = state.elections.active
      respond_with(
        @elections,
        each_serializer: ElectionSerializer
      )
    end

    private
    def state
      @state ||= State.find_by_code(params[:state_id])
    end
  end
end