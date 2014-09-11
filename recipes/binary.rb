cache_dir = Chef::Config[:file_cache_path]
download_dest = File.join(cache_dir, node['wkhtmltopdf']['archive'])
wkhtmltopdf_version = Chef::Version.new(node['wkhtmltopdf']['version'])

remote_file download_dest do
  source node['wkhtmltopdf']['mirror_url']
  mode '0644'
  action :create_if_missing
end

execute 'extract_wkhtmltopdf' do
  cwd cache_dir
  command "tar -xJf #{download_dest}"
  creates File.join(cache_dir, 'wkhtmltox')
end

package 'wkhtmltox' do
  source "#{download_dest}"
  action :install
end
