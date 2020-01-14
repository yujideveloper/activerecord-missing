# frozen_string_literal: true

require "active_record"
require "active_record/relation"
require "active_record/relation/query_methods"

module ActiveRecord
  module QueryMethods
    class WhereChain
      def missing(*args)
        args.each do |arg|
          reflection = @scope.klass._reflect_on_association(arg)
          opts = { reflection.table_name => { reflection.association_primary_key => nil } }
          @scope.left_outer_joins!(arg)
          @scope.where!(opts)
        end

        @scope
      end
    end
  end
end
