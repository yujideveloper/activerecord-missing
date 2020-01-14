# frozen_string_literal: true

require "activerecord/missing/version"
require "active_support/lazy_load_hooks"

ActiveSupport.on_load(:active_record) do
  require "activerecord/missing/relation/query_methods"
end
