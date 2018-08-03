Dir.glob('tasks/**/*.rake').each(&method(:import))

task :default => [:lint, 'test:spec']
