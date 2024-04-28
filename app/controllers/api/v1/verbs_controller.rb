# Api::V1::ApplicationController is in the starter repository and isn't
# needed for this package's unit tests, but our CI tests will try to load this
# class because eager loading is set to `true` when CI=true.
# We wrap this class in an `if` statement to circumvent this issue.
if defined?(Api::V1::ApplicationController)
  class Api::V1::VerbsController < Api::V1::ApplicationController
    account_load_and_authorize_resource :verb, through: :team, through_association: :verbs

    # GET /api/v1/teams/:team_id/verbs
    def index
    end

    # GET /api/v1/verbs/:id
    def show
    end

    # POST /api/v1/teams/:team_id/verbs
    def create
      if @verb.save
        render :show, status: :created, location: [:api, :v1, @verb]
      else
        render json: @verb.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /api/v1/verbs/:id
    def update
      if @verb.update(verb_params)
        render :show
      else
        render json: @verb.errors, status: :unprocessable_entity
      end
    end

    # DELETE /api/v1/verbs/:id
    def destroy
      @verb.destroy
    end

    private

    module StrongParameters
      # Only allow a list of trusted parameters through.
      def verb_params
        strong_params = params.require(:verb).permit(
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
  class Api::V1::VerbsController
  end
end
