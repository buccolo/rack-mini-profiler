class Aws::DynamoDB::Client
  alias_method :query_without_profiling, :query

  def query(*args, &blk)
    return query_without_profiling(*args, &blk) unless SqlPatches.should_measure?

    result, _record = SqlPatches.record_sql(JSON.pretty_generate(args[0])) do
      query_without_profiling(*args, &blk)
    end

    return result
  end
end
