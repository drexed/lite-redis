# frozen_string_literal: true

module Lite
  module Redis
    module SortedSetHelper

      def find(key, position, opts = {})
        position -= 1
        value = client.zrange(stringify_key(key), position, position, opts)
        value.first
      end

      def find_score(key, position, opts = {})
        value = client.zrangebyscore(stringify_key(key), position, position, opts)
        value.first
      end

      def first(key, opts = {})
        value = client.zrange(stringify_key(key), 0, 0, opts)
        value.first
      end

      def first_score(key, opts = {})
        value = client.zrangebyscore(stringify_key(key), 1, 1, opts)
        value.first
      end

      def last(key, opts = {})
        value = client.zrevrange(stringify_key(key), 0, 0, opts)
        value.first
      end

      def last_score(key, opts = {})
        value = client.zrevrangebyscore(stringify_key(key), 1, 1, opts)
        value.first
      end

      def between(key, start, finish, opts = {})
        client.zrange(stringify_key(key), start - 1, finish - 1, opts)
      end

      def between_reverse(key, start, finish, opts = {})
        client.zrevrange(stringify_key(key), start - 1, finish - 1, opts)
      end

      def between_scores(key, min, max, opts = {})
        client.zrangebyscore(stringify_key(key), min, max, opts)
      end

      def between_scores_reverse(key, min, max, opts = {})
        client.zrevrangebyscore(stringify_key(key), min, max, opts)
      end

      def between_lex(key, min, max, opts = {})
        client.zrangebylex(stringify_key(key), min, max, opts)
      end

      def between_lex_reverse(key, min, max, opts = {})
        client.zrevrangebylex(stringify_key(key), min, max, opts)
      end

      def all(key, opts = {})
        client.zrange(stringify_key(key), 0, -1, opts)
      end

      def all_reverse(key, opts = {})
        client.zrevrange(stringify_key(key), 0, -1, opts)
      end

      def position(key, value)
        value = client.zrank(stringify_key(key), value)
        value += 1 unless value.nil?
        value
      end

      def position_reverse(key, value)
        value = client.zrevrank(stringify_key(key), value)
        value += 1 unless value.nil?
        value
      end

      def score(key, value)
        client.zscore(stringify_key(key), value)
      end

      def count(key)
        client.zcard(stringify_key(key))
      end

      def count_between(key, min, max)
        client.zcount(stringify_key(key), min, max)
      end

      def create(key, *args)
        client.zadd(stringify_key(key), args)
      end

      def create_intersection(key, keys, opts = {})
        client.zinterstore(stringify_key(key), keys, opts)
      end

      def create_combination(key, keys, opts = {})
        client.zunionstore(stringify_key(key), keys, opts)
      end

      def increment(key, value, count)
        client.zincrby(stringify_key(key), count, value)
      end

      def decrement(key, value, count)
        client.zincrby(stringify_key(key), -count.abs, value)
      end

      def destroy(key, at)
        client.zrem(stringify_key(key), at)
      end

      def destroy_between(key, start, finish)
        client.zremrangebyrank(stringify_key(key), start - 1, finish - 1)
      end

      def destroy_scores(key, min, max)
        client.zremrangebyscore(stringify_key(key), min, max)
      end

      def destroy_lex(key, min, max, opts = {})
        client.zrevrangebylex(stringify_key(key), max, min, opts)
      end

      def scan(key, cursor, opts = {})
        client.zscan(stringify_key(key), cursor, opts)
      end

    end
  end
end
