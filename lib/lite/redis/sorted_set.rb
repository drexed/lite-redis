# frozen_string_literal: true

module Lite
  module Redis
    class SortedSet < Base

      def find(key, position, opts = {})
        position -= 1
        value = client.zrange(key.to_s, position, position, **opts)
        value.first
      end

      def find_score(key, position, opts = {})
        value = client.zrangebyscore(key.to_s, position, position, **opts)
        value.first
      end

      def first(key, opts = {})
        value = client.zrange(key.to_s, 0, 0, **opts)
        value.first
      end

      def first_score(key, opts = {})
        value = client.zrangebyscore(key.to_s, 1, 1, **opts)
        value.first
      end

      def last(key, opts = {})
        value = client.zrevrange(key.to_s, 0, 0, **opts)
        value.first
      end

      def last_score(key, opts = {})
        value = client.zrevrangebyscore(key.to_s, 1, 1, **opts)
        value.first
      end

      def between(key, start, finish, opts = {})
        client.zrange(key.to_s, start - 1, finish - 1, **opts)
      end

      def between_reverse(key, start, finish, opts = {})
        client.zrevrange(key.to_s, start - 1, finish - 1, **opts)
      end

      def between_scores(key, min, max, opts = {})
        client.zrangebyscore(key.to_s, min, max, **opts)
      end

      def between_scores_reverse(key, min, max, opts = {})
        client.zrevrangebyscore(key.to_s, min, max, **opts)
      end

      def between_lex(key, min, max, opts = {})
        client.zrangebylex(key.to_s, min, max, **opts)
      end

      def between_lex_reverse(key, min, max, opts = {})
        client.zrevrangebylex(key.to_s, min, max, **opts)
      end

      def all(key, opts = {})
        client.zrange(key.to_s, 0, -1, **opts)
      end

      def all_reverse(key, opts = {})
        client.zrevrange(key.to_s, 0, -1, **opts)
      end

      def position(key, value)
        value = client.zrank(key.to_s, value)
        value += 1 unless value.nil?
        value
      end

      def position_reverse(key, value)
        value = client.zrevrank(key.to_s, value)
        value += 1 unless value.nil?
        value
      end

      def score(key, value)
        client.zscore(key.to_s, value)
      end

      def count(key)
        client.zcard(key.to_s)
      end

      def count_between(key, min, max)
        client.zcount(key.to_s, min, max)
      end

      def create(key, *args)
        client.zadd(key.to_s, args)
      end

      def create_intersection(key, keys, opts = {})
        client.zinterstore(key.to_s, keys, **opts)
      end

      def create_combination(key, keys, opts = {})
        client.zunionstore(key.to_s, keys, **opts)
      end

      def increment(key, value, count)
        client.zincrby(key.to_s, count, value)
      end

      def decrement(key, value, count)
        client.zincrby(key.to_s, -count.abs, value)
      end

      def destroy(key, at)
        client.zrem(key.to_s, at)
      end

      def destroy_between(key, start, finish)
        client.zremrangebyrank(key.to_s, start - 1, finish - 1)
      end

      def destroy_scores(key, min, max)
        client.zremrangebyscore(key.to_s, min, max)
      end

      def destroy_lex(key, min, max, opts = {})
        client.zrevrangebylex(key.to_s, max, min, **opts)
      end

      def scan(key, cursor, opts = {})
        client.zscan(key.to_s, cursor, **opts)
      end

    end
  end
end
