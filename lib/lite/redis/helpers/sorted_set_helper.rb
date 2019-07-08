# frozen_string_literal: true

module Lite
  module Redis
    module SortedSetHelper

      def find(key, position, opts = {})
        position -= 1
        value = client.zrange(normalize_key(key), position, position, opts)
        value.first
      end

      def find_score(key, position, opts = {})
        value = client.zrangebyscore(normalize_key(key), position, position, opts)
        value.first
      end

      def first(key, opts = {})
        value = client.zrange(normalize_key(key), 0, 0, opts)
        value.first
      end

      def first_score(key, opts = {})
        value = client.zrangebyscore(normalize_key(key), 1, 1, opts)
        value.first
      end

      def last(key, opts = {})
        value = client.zrevrange(normalize_key(key), 0, 0, opts)
        value.first
      end

      def last_score(key, opts = {})
        value = client.zrevrangebyscore(normalize_key(key), 1, 1, opts)
        value.first
      end

      def between(key, start, finish, opts = {})
        client.zrange(normalize_key(key), start - 1, finish - 1, opts)
      end

      def between_reverse(key, start, finish, opts = {})
        client.zrevrange(normalize_key(key), start - 1, finish - 1, opts)
      end

      def between_scores(key, min, max, opts = {})
        client.zrangebyscore(normalize_key(key), min, max, opts)
      end

      def between_scores_reverse(key, min, max, opts = {})
        client.zrevrangebyscore(normalize_key(key), min, max, opts)
      end

      def between_lex(key, min, max, opts = {})
        client.zrangebylex(normalize_key(key), min, max, opts)
      end

      def between_lex_reverse(key, min, max, opts = {})
        client.zrevrangebylex(normalize_key(key), min, max, opts)
      end

      def all(key, opts = {})
        client.zrange(normalize_key(key), 0, -1, opts)
      end

      def all_reverse(key, opts = {})
        client.zrevrange(normalize_key(key), 0, -1, opts)
      end

      def position(key, value)
        value = client.zrank(normalize_key(key), value)
        value += 1 unless value.nil?
        value
      end

      def position_reverse(key, value)
        value = client.zrevrank(normalize_key(key), value)
        value += 1 unless value.nil?
        value
      end

      def score(key, value)
        client.zscore(normalize_key(key), value)
      end

      def count(key)
        client.zcard(normalize_key(key))
      end

      def count_between(key, min, max)
        client.zcount(normalize_key(key), min, max)
      end

      def create(key, *args)
        client.zadd(normalize_key(key), args)
      end

      def create_intersection(key, keys, opts = {})
        client.zinterstore(normalize_key(key), keys, opts)
      end

      def create_combination(key, keys, opts = {})
        client.zunionstore(normalize_key(key), keys, opts)
      end

      def increment(key, value, count)
        client.zincrby(normalize_key(key), count, value)
      end

      def decrement(key, value, count)
        client.zincrby(normalize_key(key), -count.abs, value)
      end

      def destroy(key, at)
        client.zrem(normalize_key(key), at)
      end

      def destroy_between(key, start, finish)
        client.zremrangebyrank(normalize_key(key), start - 1, finish - 1)
      end

      def destroy_scores(key, min, max)
        client.zremrangebyscore(normalize_key(key), min, max)
      end

      def destroy_lex(key, min, max, opts = {})
        client.zrevrangebylex(normalize_key(key), max, min, opts)
      end

      def scan(key, cursor, opts = {})
        client.zscan(normalize_key(key), cursor, opts)
      end

    end
  end
end
