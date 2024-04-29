class Account::ActsController < Account::ApplicationController
  account_load_and_authorize_resource :act, through: :verb, through_association: :acts

  # GET /account/verbs/:verb_id/acts
  # GET /account/verbs/:verb_id/acts.json
  def index
    delegate_json_to_api
  end

  # GET /account/acts/:id
  # GET /account/acts/:id.json
  def show
    delegate_json_to_api
  end

  # GET /account/verbs/:verb_id/acts/new
  def new
  end

  # GET /account/acts/:id/edit
  def edit
  end

  # POST /account/verbs/:verb_id/acts
  # POST /account/verbs/:verb_id/acts.json
  def create
    respond_to do |format|
      if @act.save
        format.html { redirect_to [:account, @act], notice: I18n.t("acts.notifications.created") }
        format.json { render :show, status: :created, location: [:account, @act] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @act.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /account/acts/:id
  # PATCH/PUT /account/acts/:id.json
  def update
    respond_to do |format|
      if @act.update(act_params)
        format.html { redirect_to [:account, @act], notice: I18n.t("acts.notifications.updated") }
        format.json { render :show, status: :ok, location: [:account, @act] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @act.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /account/acts/:id
  # DELETE /account/acts/:id.json
  def destroy
    @act.destroy
    respond_to do |format|
      format.html { redirect_to [:account, @verb, :acts], notice: I18n.t("acts.notifications.destroyed") }
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
