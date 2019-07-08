# frozen_string_literal: true

module Lite
  module Redis
    module GeoHelper

      def create(key, *member)
        client.geoadd(stringify_key(key), *member)
      end

      def hash(key, member)
        client.geohash(stringify_key(key), member)
      end

      def position(key, member)
        client.geopos(stringify_key(key), member)
      end

      def distance(key, member1, member2, unit = 'm')
        client.geodist(stringify_key(key), member1, member2, stringify_key(unit))
      end

      def radius(*args, **geoptions)
        client.georadius(*args, **geoptions)
      end

      def radius_member(*args, **geoptions)
        client.georadiusbymember(*args, **geoptions)
      end

    end
  end
end
