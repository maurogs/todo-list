# Persists a drag & drop ordering: records are given the index of their id in the list.
module Sortable
  def self.apply(scope, ids)
    ids = Array(ids).map(&:to_i)
    records = scope.where(id: ids).index_by(&:id)

    scope.transaction do
      ids.each_with_index do |id, index|
        records[id]&.update_columns(position: index)
      end
    end
  end
end
