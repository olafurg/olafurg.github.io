###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###
activate :directory_indexes

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (https://middlemanapp.com/advanced/dynamic_pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

# Markdown engine
activate :syntax
set :markdown_engine, :redcarpet
set :markdown, fenced_code_blocks: true, smartypants: true, tables: true, autolink: true


###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

# Methods defined in the helpers block are available in templates
helpers do

  def gravatar_image(email, size)
    require 'digest/md5'
    email.downcase!
    hash = Digest::MD5.hexdigest(email)

    "https://gravatar.com/avatar/#{hash}?s=#{size}"
  end

end

set :css_dir, "stylesheets"

set :js_dir, "javascripts"

set :images_dir, "images"

# Build-specific configuration
configure :build do
  activate :minify_css
  activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"

  # Force import the _headers file in the build dir.
  import_file File.expand_path("_headers", config[:source]), "/_headers"
end

activate :blog do |blog|
  blog.permalink = "{year}-{month}-{title}.html"
  blog.sources = "words/articles/{year}-{month}-{day}-{title}.html"
  blog.layout = "article_layout"
  blog.tag_template = "tag.html"
  blog.paginate = true
  blog.new_article_template = File.expand_path('source/words/blog_template.erb', __dir__)
  blog.default_extension = ".md"
end
