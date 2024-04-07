require 'jekyll-watch'

module Jekyll
  module Watcher
    extend self
    alias_method :original_listen_ignore_paths, :listen_ignore_paths
    # Override the listen_ignore_paths method
    def listen_ignore_paths(options)
	original_listen_ignore_paths(options) + [%r!.*\.TMP!i]
    end
  end
end

