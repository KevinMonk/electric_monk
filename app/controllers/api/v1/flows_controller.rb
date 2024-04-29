# Api::V1::ApplicationController is in the starter repository and isn't
# needed for this package's unit tests, but our CI tests will try to load this
# class because eager loading is set to `true` when CI=true.
# We wrap this class in an `if` statement to circumvent this issue.
if defined?(Api::V1::ApplicationController)
  class Api::V1::FlowsController < Api::V1::ApplicationController
    account_load_and_authorize_resource :flow, through: :act, through_association: :flows

    # GET /api/v1/acts/:act_id/flows
    def index
    end

    # GET /api/v1/flows/:id
    def show
    end

    # POST /api/v1/acts/:act_id/flows
    def create
      if @flow.save
        render :show, status: :created, location: [:api, :v1, @flow]
      else
        render json: @flow.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /api/v1/flows/:id
    def update
      if @flow.update(flow_params)
        render :show
      else
        render json: @flow.errors, status: :unprocessable_entity
      end
    end

    # DELETE /api/v1/flows/:id
    def destroy
      @flow.destroy
    end

    private

    module StrongParameters
      # Only allow a list of trusted parameters through.
      def flow_params
        strong_params = params.require(:flow).permit(
          *permitted_fields,
          :name,
          :description,
          :to_act_id,
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
  class Api::V1::FlowsController
  end
end
