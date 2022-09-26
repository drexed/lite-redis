# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Lite::Redis::Connection do

  describe '.authenticate' do
    it 'to be "OK"' do
      expect(described_class.authenticate('pass')).to eq('OK')
    end
  end

  describe '.connected?' do
    it 'to be true' do
      expect(described_class.connected?).to be(true)
    end
  end

  describe '.database' do
    it 'to be 2' do
      described_class.database(2)

      expect(described_class.database_id).to eq(2)
    end
  end

  describe '.database_id' do
    it 'to be 0' do
      described_class.database(0)

      expect(described_class.database_id).to eq(0)
    end
  end

  describe '.database_size' do
    it 'to be 0' do
      expect(described_class.database_size).to eq(0)
    end

    it 'to be 2' do
      Lite::Redis::String.create(:example1, 'one')
      Lite::Redis::String.create(:example2, 'two')

      expect(described_class.database_size).to eq(2)
    end
  end

  describe '.debug' do
    # TODO
  end

  describe '.disconnect' do
    it 'to be nil' do
      expect(described_class.disconnect).to be_nil
    end
  end

  describe '.echo' do
    it 'to be "Redis"' do
      expect(described_class.echo('Redis')).to eq('Redis')
    end
  end

  describe '.flush' do
    it 'to be 0' do
      Lite::Redis::String.create(:example1, 'one')
      Lite::Redis::String.create(:example2, 'two')
      described_class.flush

      expect(described_class.database_size).to eq(0)
    end
  end

  describe '.flush_all' do
    it 'to be 0' do
      Lite::Redis::String.create(:example1, 'one')
      Lite::Redis::String.create(:example2, 'two')
      described_class.flush_all

      expect(described_class.database_size).to eq(0)
    end
  end

  describe '.info' do
    info_hash = {
      'redis_version' => '3.3.5',
      'connected_clients' => '1',
      'connected_slaves' => '0',
      'used_memory' => '3187',
      'changes_since_last_save' => '0',
      'last_save_time' => '1237655729',
      'total_connections_received' => '1',
      'total_commands_processed' => '1',
      'uptime_in_seconds' => '36000',
      'uptime_in_days' => 0
    }

    it 'to be { ... }' do
      expect(described_class.info).to eq(info_hash)
    end
  end

  describe '.ping' do
    it 'to be "PONG"' do
      expect(described_class.ping).to eq('PONG')
    end
  end

  describe '.quit' do
    it 'to not raise error' do
      expect { described_class.quit }.not_to raise_error
    end
  end

  describe '.reconnect' do
    # TODO
  end

  describe '.rewrite_aof' do
    # TODO
  end

  describe '.save' do
    # TODO
  end

  describe '.saved_at' do
    it "to be #{Time.now.to_i}" do
      expect(described_class.saved_at).to eq(Time.now.to_i)
    end
  end

  describe '.shutdown' do
    it 'to not raise error' do
      expect { described_class.shutdown }.not_to raise_error
    end
  end

  describe '.slave_of' do
    # TODO
  end

  describe '.slowlog' do
    # TODO
  end

  describe '.syncronize' do
    # TODO
  end

  describe '.time' do
    it 'to not raise error' do
      expect { described_class.time }.not_to raise_error
    end
  end

  describe '.with_reconnect' do
    # TODO
  end

  describe '.without_reconnect' do
    # TODO
  end

end
