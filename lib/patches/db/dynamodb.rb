class Aws::DynamoDB::Client
  alias_method :query_without_profiling, :query

  def query(*args, &blk)
    return query_without_profiling(*args, &blk) unless SqlPatches.should_measure?

    result, _record = SqlPatches.record_sql(args[0].inspect) do
      query_without_profiling(*args, &blk)
    end

    return result
  end
end
