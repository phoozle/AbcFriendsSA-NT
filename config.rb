###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

helpers do
  def article_pathname(article)
    article.name.parameterize + "-" + article.published.parameterize
  end
end

# News Pages
ignore "/news/template.html"
ignore "/news/articles/**"

data.news.articles.each do |article|
  pathname = article.name.parameterize + "-" + article.published.parameterize

  # Create missing article markdown pages
  article_path = "./source/news/articles/#{pathname}.md"
  File.new(article_path, "w") if !File.exist?(article_path)

  proxy "/news/#{pathname}.html",
        "/news/template.html", 
        locals: { article: article }, 
        ignore: true
end
