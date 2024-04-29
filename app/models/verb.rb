class Verb < ApplicationRecord
  # 🚅 add concerns above.

  # 🚅 add attribute accessors above.

  belongs_to :team
  # 🚅 add belongs_to associations above.

  has_many :defining_acts, dependent: :destroy, class_name: "Act", foreign_key: "defining_verb_id"
  has_many :calling_acts, dependent: :destroy, class_name: "Act", foreign_key: "calling_verb_id"
  has_many :calling_verbs, through: :calling_acts, source: :calling_verb
  has_many :defining_verbs, through: :defining_acts, source: :defining_verb
  # 🚅 add has_many associations above.

  has_rich_text :description
  # 🚅 add has_one associations above.

  # 🚅 add scopes above.

  validates :name, presence: true
  # 🚅 add validations above.

  # 🚅 add callbacks above.

  # 🚅 add delegations above.

  # 🚅 add methods above.
end
