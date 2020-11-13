#
# Cookbook:: attributes_by_data_bag
# Recipe:: dependencies
#
# Description:: Installs all gems required by this cookbook. This recipe is called by the default recipe.
#               The default recipe should be included before calling any attributes_by_data_bag cookbook resources.
#

required_gems = {
  'hashly' => '0.1.3',
}
required_gems.each do |gem_name, gem_version|
  chef_gem gem_name do
    version gem_version
    compile_time true
    action :install
  end
end

require 'hashly'
