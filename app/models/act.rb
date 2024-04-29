class Act < ApplicationRecord
  # 🚅 add concerns above.

  # 🚅 add attribute accessors above.

  belongs_to :defining_verb, class_name: "Verb"
  belongs_to :calling_verb, class_name: "Noun"
  # 🚅 add belongs_to associations above.

  # 🚅 add has_many associations above.

  # 🚅 add has_one associations above.

  # 🚅 add scopes above.

  # validates :calling_verb, scope: true
  # 🚅 add validations above.

  # 🚅 add callbacks above.

  # 🚅 add delegations above.

  def valid_calling_verbs
    verb.valid_nouns
  end

  # 🚅 add methods above.
end
