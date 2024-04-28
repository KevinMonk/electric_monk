class Account::FlowsController < Account::ApplicationController
  account_load_and_authorize_resource :flow, through: :team, through_association: :flows

  # GET /account/teams/:team_id/flows
  # GET /account/teams/:team_id/flows.json
  def index
    delegate_json_to_api
  end

  # GET /account/flows/:id
  # GET /account/flows/:id.json
  def show
    delegate_json_to_api
  end

  # GET /account/teams/:team_id/flows/new
  def new
  end

  # GET /account/flows/:id/edit
  def edit
  end

  # POST /account/teams/:team_id/flows
  # POST /account/teams/:team_id/flows.json
  def create
    respond_to do |format|
      if @flow.save
        format.html { redirect_to [:account, @flow], notice: I18n.t("flows.notifications.created") }
        format.json { render :show, status: :created, location: [:account, @flow] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @flow.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /account/flows/:id
  # PATCH/PUT /account/flows/:id.json
  def update
    respond_to do |format|
      if @flow.update(flow_params)
        format.html { redirect_to [:account, @flow], notice: I18n.t("flows.notifications.updated") }
        format.json { render :show, status: :ok, location: [:account, @flow] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @flow.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /account/flows/:id
  # DELETE /account/flows/:id.json
  def destroy
    @flow.destroy
    respond_to do |format|
      format.html { redirect_to [:account, @team, :flows], notice: I18n.t("flows.notifications.destroyed") }
      format.json { head :no_content }
    end
  end

  private

  if defined?(Api::V1::ApplicationController)
    include strong_parameters_from_api
  end

  def process_params(strong_params)
    # 🚅 super scaffolding will insert processing for new fields above this line.
  end
end
