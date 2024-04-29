# Api::V1::ApplicationController is in the starter repository and isn't
# needed for this package's unit tests, but our CI tests will try to load this
# class because eager loading is set to `true` when CI=true.
# We wrap this class in an `if` statement to circumvent this issue.
if defined?(Api::V1::ApplicationController)
  class Api::V1::OperandsController < Api::V1::ApplicationController
    account_load_and_authorize_resource :operand, through: :act, through_association: :operands

    # GET /api/v1/acts/:act_id/operands
    def index
    end

    # GET /api/v1/operands/:id
    def show
    end

    # POST /api/v1/acts/:act_id/operands
    def create
      if @operand.save
        render :show, status: :created, location: [:api, :v1, @operand]
      else
        render json: @operand.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /api/v1/operands/:id
    def update
      if @operand.update(operand_params)
        render :show
      else
        render json: @operand.errors, status: :unprocessable_entity
      end
    end

    # DELETE /api/v1/operands/:id
    def destroy
      @operand.destroy
    end

    private

    module StrongParameters
      # Only allow a list of trusted parameters through.
      def operand_params
        strong_params = params.require(:operand).permit(
          *permitted_fields,
          :name,
          :description,
          # 🚅 super scaffolding will insert new fields above this line.
          *permitted_arrays,
          # 🚅 super scaffolding will insert new arrays above this line.
        )

        process_params(strong_params)

        strong_params
      end
    end

    include StrongParameters
  end
else
  class Api::V1::OperandsController
  end
end
