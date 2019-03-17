# TODO refactor this
module IdentifiedSearch
  extend ActiveSupport::Concern

  class_methods do
    # @param [String] query - search string
    # @param [*Array] ordered_name_fields - list of fields for search
    # @param [Object] options:
    #   limit - max count of results
    #   separator - string for separation query string for hierarchical search
    def identified_search(query, *ordered_name_fields, **options)
      limit = options[:limit] || 15

      query_data = build_query_data(query, ordered_name_fields, options)
      query_str = query_data[:query_str]
      query_params = query_data[:query_params]

      ordering_fields = build_ordering_data(ordered_name_fields)

      relation = self.where(query_str, query_params)
                     .order(*ordering_fields)
                     .limit(limit)

      relation = yield(relation) if block_given?

      relation.map(&:for_identified_search)
    end

    def collection_for_identified_search(obj_id)
      if obj_id.present?
        where(id: obj_id).map(&:as_identified_select)
      else
        []
      end
    end

    private

    def build_query_data(query, fields, options)
      if options[:separator]
        build_hierarchical_query_data(query, fields, options[:separator])
      else
        build_simple_query_data(query, fields)
      end
    end

    def build_simple_query_data(query, fields)
      search_param = query.to_s.strip
      query_str_array = []
      query_params = {}

      if search_param.to_i.to_s == search_param
        query_str_array << "#{self.table_name}.id = :id"
        query_params[:id] = search_param.to_i
      end

      fields.each do |field_name|
        query_str_array << "#{field_name} ILIKE :search"
      end

      query_params[:search] = "%#{search_param}%"

      { query_str: query_str_array.join(' OR '), query_params: query_params }
    end

    def build_hierarchical_query_data(query, fields, separator)
      search_params = query.split(separator).map(&:strip).compact
      return build_simple_query_data(search_params.first, fields) if search_params.length == 1

      query_str_array = []
      query_params = {}

      fields.each_with_index do |field_name, index|
        search_param = search_params[index]
        next if search_params.blank?

        param_name = "search#{index}"
        query_str_array << "#{field_name} ILIKE :#{param_name}"
        query_params[param_name.to_sym] = "%#{search_param}%"
      end

      { query_str: query_str_array.join(' AND '), query_params: query_params }
    end

    def build_ordering_data(ordered_name_fields)
      ([:id] + ordered_name_fields).map do |field|
        field.is_a?(Symbol) ? "#{table_name}.#{field} ASC" : "#{field} ASC"
      end
    end
  end

  def id_string
    "[#{id}] #{to_s}"
  end

  def for_identified_search
    { id: self.id, text: self.id_string }
  end

  def for_identified_select
    [as_identified_select]
  end

  def as_identified_select
    [self.id_string, self.id]
  end
end
