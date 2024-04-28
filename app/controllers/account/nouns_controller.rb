class Account::NounsController < Account::ApplicationController
  account_load_and_authorize_resource :noun, through: :team, through_association: :nouns

  # GET /account/teams/:team_id/nouns
  # GET /account/teams/:team_id/nouns.json
  def index
    delegate_json_to_api
  end

  # GET /account/nouns/:id
  # GET /account/nouns/:id.json
  def show
    delegate_json_to_api
  end

  # GET /account/teams/:team_id/nouns/new
  def new
  end

  # GET /account/nouns/:id/edit
  def edit
  end

  # POST /account/teams/:team_id/nouns
  # POST /account/teams/:team_id/nouns.json
  def create
    respond_to do |format|
      if @noun.save
        format.html { redirect_to [:account, @noun], notice: I18n.t("nouns.notifications.created") }
        format.json { render :show, status: :created, location: [:account, @noun] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @noun.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /account/nouns/:id
  # PATCH/PUT /account/nouns/:id.json
  def update
    respond_to do |format|
      if @noun.update(noun_params)
        format.html { redirect_to [:account, @noun], notice: I18n.t("nouns.notifications.updated") }
        format.json { render :show, status: :ok, location: [:account, @noun] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @noun.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /account/nouns/:id
  # DELETE /account/nouns/:id.json
  def destroy
    @noun.destroy
    respond_to do |format|
      format.html { redirect_to [:account, @team, :nouns], notice: I18n.t("nouns.notifications.destroyed") }
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
