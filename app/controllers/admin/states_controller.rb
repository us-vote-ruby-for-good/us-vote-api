class Admin::StatesController < ApplicationController
  before_action :set_admin_state, only: [:show, :edit, :update, :destroy]

  # GET /admin/states
  # GET /admin/states.json
  def index
    @admin_states = Admin::State.all
  end

  # GET /admin/states/1
  # GET /admin/states/1.json
  def show
  end

  # GET /admin/states/new
  def new
    @admin_state = Admin::State.new
  end

  # GET /admin/states/1/edit
  def edit
  end

  # POST /admin/states
  # POST /admin/states.json
  def create
    @admin_state = Admin::State.new(admin_state_params)

    respond_to do |format|
      if @admin_state.save
        format.html { redirect_to @admin_state, notice: 'State was successfully created.' }
        format.json { render :show, status: :created, location: @admin_state }
      else
        format.html { render :new }
        format.json { render json: @admin_state.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/states/1
  # PATCH/PUT /admin/states/1.json
  def update
    respond_to do |format|
      if @admin_state.update(admin_state_params)
        format.html { redirect_to @admin_state, notice: 'State was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_state }
      else
        format.html { render :edit }
        format.json { render json: @admin_state.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/states/1
  # DELETE /admin/states/1.json
  def destroy
    @admin_state.destroy
    respond_to do |format|
      format.html { redirect_to admin_states_url, notice: 'State was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_state
      @admin_state = Admin::State.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_state_params
      params.require(:admin_state).permit(:name, :code, :drupal_id)
    end
end
