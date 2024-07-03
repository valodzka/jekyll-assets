# Frozen-string-literal: true
# Copyright: 2012 - 2020 - ISC License
# Author: Jordon Bedwell
# Encoding: utf-8

module Jekyll
  module Assets
    module Patches
      module CachedEnvironment
        include Utils

        # --
        attr_reader :manifest
        attr_reader :asset_config
        attr_reader :jekyll

        # --
        # @param [Env] env the environment.
        # Patches initialize so we can give access to `#jekyll`.
        # @return [self]
        # --
        def initialize(env)
          super

          @manifest = env.manifest
          @asset_config = env.asset_config
          @jekyll = env.jekyll
        end

        # --
        # @note this is used internally.
        # Wraps around #super and adds environment.
        # @return [Sprockets::Asset]
        # --
        def find_asset(*args, **options)
          super(*args, **options).tap do |m|
            m&.environment = self
          end
        end
        
        def find_asset!(*args, **options)
          super(*args, **options).tap do |m|
            m&.environment = self
          end
        end

      end
    end
  end
end

# --
module Sprockets
  class CachedEnvironment
    prepend Jekyll::Assets::Patches::CachedEnvironment
  end
end
