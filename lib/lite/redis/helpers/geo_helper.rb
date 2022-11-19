# frozen_string_literal: true

module Lite
  module Redis
    module GeoHelper

      def create(key, *member)
        client.geoadd(key.to_s, *member)
      end

      def hash(key, member)
        client.geohash(key.to_s, member)
      end

      def position(key, member)
        client.geopos(key.to_s, member)
      end

      def distance(key, member1, member2, unit = "m")
        client.geodist(key.to_s, member1, member2, unit.to_s)
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
