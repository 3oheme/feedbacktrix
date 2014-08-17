task default: ['render_html']

task :render_html do
  puts ' --- Rendering html file...'
  ruby 'app.rb'
end

task :push do
  Rake::Task[:render_html].invoke
  Rake::Task[:push_to_github_pages].invoke
end

task :push_to_github_pages do
	puts ' --- Pushing to github-pages'
	`git checkout gh-pages`
	`git merge master`
	`git push origin gh-pages`
	`git checkout master`
	puts ' --- Pushing to github-pages successful'
end