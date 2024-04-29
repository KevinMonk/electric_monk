class Account::VerbsController < Account::ApplicationController
  account_load_and_authorize_resource :verb, through: :team, through_association: :verbs

  # GET /account/teams/:team_id/verbs
  # GET /account/teams/:team_id/verbs.json
  def index
    delegate_json_to_api
  end

  # GET /account/verbs/:id
  # GET /account/verbs/:id.json
  def show
    delegate_json_to_api
  end

  # GET /account/teams/:team_id/verbs/new
  def new
  end

  # GET /account/verbs/:id/edit
  def edit
  end

  # POST /account/teams/:team_id/verbs
  # POST /account/teams/:team_id/verbs.json
  def create
    respond_to do |format|
      if @verb.save
        format.html { redirect_to [:account, @verb], notice: I18n.t("verbs.notifications.created") }
        format.json { render :show, status: :created, location: [:account, @verb] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @verb.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /account/verbs/:id
  # PATCH/PUT /account/verbs/:id.json
  def update
    respond_to do |format|
      if @verb.update(verb_params)
        format.html { redirect_to [:account, @verb], notice: I18n.t("verbs.notifications.updated") }
        format.json { render :show, status: :ok, location: [:account, @verb] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @verb.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /account/verbs/:id
  # DELETE /account/verbs/:id.json
  def destroy
    @verb.destroy
    respond_to do |format|
      format.html { redirect_to [:account, @team, :verbs], notice: I18n.t("verbs.notifications.destroyed") }
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
