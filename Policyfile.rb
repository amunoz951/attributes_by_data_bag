name 'kitchen_attributes_by_data_bag'

default_source :supermarket, 'https://supermarket.chef.io'

run_list 'attributes_by_data_bag_test::default'

# which cookbooks to use
cookbook 'attributes_by_data_bag', path: '.'
cookbook 'attributes_by_data_bag_test', path: 'test/cookbooks/attributes_by_data_bag_test'
