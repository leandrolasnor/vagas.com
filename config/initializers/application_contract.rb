# frozen_string_literal: true

Dry::Validation.load_extensions :monads
Dry::Validation.load_extensions :predicates_as_macros

class ApplicationContract < Dry::Validation::Contract
  import_predicates_as_macros
  config.messages.backend = :i18n
end
