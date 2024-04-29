class Avo::Resources::Act < Avo::BaseResource
  self.includes = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :defining_verb, as: :belongs_to
    field :calling_verb, as: :belongs_to
  end
end
