class Account::OperandsController < Account::ApplicationController
  account_load_and_authorize_resource :operand, through: :act, through_association: :operands

  # GET /account/acts/:act_id/operands
  # GET /account/acts/:act_id/operands.json
  def index
    delegate_json_to_api
  end

  # GET /account/operands/:id
  # GET /account/operands/:id.json
  def show
    delegate_json_to_api
  end

  # GET /account/acts/:act_id/operands/new
  def new
  end

  # GET /account/operands/:id/edit
  def edit
  end

  # POST /account/acts/:act_id/operands
  # POST /account/acts/:act_id/operands.json
  def create
    respond_to do |format|
      if @operand.save
        format.html { redirect_to [:account, @operand], notice: I18n.t("operands.notifications.created") }
        format.json { render :show, status: :created, location: [:account, @operand] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @operand.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /account/operands/:id
  # PATCH/PUT /account/operands/:id.json
  def update
    respond_to do |format|
      if @operand.update(operand_params)
        format.html { redirect_to [:account, @operand], notice: I18n.t("operands.notifications.updated") }
        format.json { render :show, status: :ok, location: [:account, @operand] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @operand.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /account/operands/:id
  # DELETE /account/operands/:id.json
  def destroy
    @operand.destroy
    respond_to do |format|
      format.html { redirect_to [:account, @act, :operands], notice: I18n.t("operands.notifications.destroyed") }
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
