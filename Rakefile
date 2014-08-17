task default: %w[runapp]

task :runapp do
  ruby 'app.rb'
end

task :push do
  ruby 'app.rb'
  `git checkout gh-pages`
  `git merge master`
  `git push origin gh-pages`
  `git checkout master`
end
