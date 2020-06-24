module AttributesByDataBag
  extend Chef::DSL::DataQuery

  module_function

  def converge_dependencies
    # Ensure the default recipe has been included to setup gems
    ::Chef.run_context.include_recipe 'attributes_by_data_bag::default'
  end

  def override(destination_attribute, data_bag, data_bag_item, fail_on_missing_data_bag: true, default_attributes: nil, ignored_keys: %w(id chef_type data_bag))
    converge_dependencies
    default_attributes ||= {}
    merged_attributes = merge_data_bag_over_hash(default_attributes.to_h, data_bag, data_bag_item, ignored_keys: ignored_keys, fail_on_missing_data_bag: fail_on_missing_data_bag)
    destination_attribute.merge! Hashly.deep_merge(destination_attribute.to_h, merged_attributes)
  end

  def merge_data_bag_over_hash(target_hash, data_bag, data_bag_item, ignored_keys: %w(id chef_type data_bag), fail_on_missing_data_bag: true)
    converge_dependencies
    data_bag = read_data_bag(data_bag, data_bag_item, ignored_keys: ignored_keys, fail_on_missing_data_bag: fail_on_missing_data_bag)
    Hashly.deep_merge(target_hash, data_bag)
  end

  def read_data_bag(data_bag, data_bag_item, ignored_keys: %w(id chef_type data_bag), fail_on_missing_data_bag: true)
    data_bag_item(data_bag, data_bag_item).to_h.reject { |k, _v| ignored_keys.include?(k) }
  rescue Net::HTTPServerException
    raise if fail_on_missing_data_bag
    {}
  end
end
