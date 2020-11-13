# attributes_by_data_bag Cookbook

[![Cookbook Version](https://img.shields.io/badge/cookbook-0.1.3-green.svg)](https://supermarket.chef.io/cookbooks/attributes_by_data_bag)

Provides methods for overriding node attributes using values from a data bag.

Examples:

```ruby
  destination_attribute = node.override['cookbook_name']['some_sub_attribute']
  default_attributes = node['cookbook_name']['defaults']
  AttributesByDataBag.override(destination_attribute, 'product_name', "data_bag_item name", default_attributes: default_attributes)
```

```ruby
  destination_attribute = node.override['chef-client']['config']
  default_attributes = node['chef-client']['defaults']['config']
  AttributesByDataBag.override(destination_attribute, 'chef-client', "config", default_attributes: default_attributes)
```

```ruby
  AttributesByDataBag.override(node.override['chef-client']['config'], 'chef-client', "config")
```

## Contents

- [Methods](#methods)

  - [AttributesByDataBag.override](#AttributesByDataBag.override)
    * Overrides attributes at the specified VividMash (Native chef node attribute class - use the desired precedence level)
  - [AttributesByDataBag.merge_data_bag_over_hash](#AttributesByDataBag.merge_data_bag_over_hash)
    * Does a deep merge of a data bag over the provided hash.
  - [AttributesByDataBag.read_data_bag](#AttributesByDataBag.read_data_bag)
    * Reads a data bag and optionally return an empty hash if the data bag does not exist.

- [Recipes](#recipes)

  - [default](#default)
  - [gems](#gems)

- [License and Author](#license-and-author)

## Requirements

### Platforms

- Windows Server 2012 (R2)+
- Centos

### Chef

- Chef 13+

### Cookbooks

- no cookbook dependencies

## Methods
___
### AttributesByDataBag.override ###
    Description: Overrides attributes at the specified node attribute.
### Required parameters ###
- `destination_attribute` - VividMash, The node attribute to merge data bag values over including the precedence level. IE: `node.override['foo']`
- `data_bag` - String, The name of the data bag where the data_bag_item can be found.
- `data_bag_item` - String, The name of the data bag item containing the data to be merged.
### Named Parameters: ###
- `fail_on_missing_data_bag` - true/false, Optionally bubbles up the exception if a data bag or data bag item does not exist. default: `true`
- `default_attributes` - VividMash, Hash, or nil. A list of default attributes that data bag will be merged over before merging over the destination attribute.
- `ignored_keys`: Array, A list of keys in the data bag that should not be merged. default: `%w(id chef_type data_bag)`

Examples:
```ruby
  destination_attribute = node.override['chef-client']['config']
  default_attributes = node['chef-client']['defaults']['config']
  AttributesByDataBag.override(destination_attribute, 'chef-client', "config", default_attributes: default_attributes)
```

```ruby
  AttributesByDataBag.override(node.override['chef-client']['config'], 'chef-client', "config")
```

___
### AttributesByDataBag.merge_data_bag_over_hash ###
    Description: Merges the contents of a data bag over an existing Hash.
### Required parameters ###
- `target_hash` - Hash, Deep merge the data bag specified over this Hash.
- `data_bag` - String, The name of the data bag where the data_bag_item can be found.
- `data_bag_item` - String, The name of the data bag item containing the data to be merged.
### Named Parameters: ###
- `fail_on_missing_data_bag` - true/false, Optionally bubbles up the exception if a data bag or data bag item does not exist. default: `true`
- `ignored_keys`: Array, A list of keys in the data bag at the root level that should not be merged. default: `%w(id chef_type data_bag)`

Examples:
```ruby
  existing_hash = { 'foo' => 1 }
  merged_hash = AttributesByDataBag.merge_data_bag_over_hash(existing_hash, 'some_data_bag', "some_data_bag_item")
```

___
### AttributesByDataBag.read_data_bag ###
    Description: Reads a data bag, optionally allowing for missing data bags and excluding root level keys.
### Required parameters ###
- `data_bag` - String, The name of the data bag where the data_bag_item can be found.
- `data_bag_item` - String, The name of the data bag item containing the data to be merged.
### Named Parameters: ###
- `fail_on_missing_data_bag` - true/false, Optionally bubbles up the exception if a data bag or data bag item does not exist. default: `true`
- `ignored_keys`: Array, A list of keys in the data bag that should be rejected from the data bag when read. default: `%w(id chef_type data_bag)`

Examples:
```ruby
  my_data_bag = AttributesByDataBag.read_data_bag('foo', 'bar')
```

```ruby
  my_data_bag = AttributesByDataBag.read_data_bag('foo', 'bar', ignored_keys: %w(some_irrelevant_key), fail_on_missing_data_bag: false)
```

## Recipes

### default

`Includes the gems recipe to install required gems`

### gems

`Installs required gems`

## License and Author

- Author:: Alex Munoz ([amunoz951@gmail.com](mailto:amunoz951@gmail.com))

```text
Copyright 2020-2020, Alex Munoz.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
