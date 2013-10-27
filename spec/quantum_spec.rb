require_relative 'spec_helper'
require 'quantum_leap'

describe Quantum do

  after do
    Quantum.leap_back
  end

  describe '.leap' do
    describe 'without a block' do
      the_present = Time.new
      the_past    = Time.new(1956, 9, 13, 15, 00)
      QuantumLeap::Accelerator.redis = nil

      it 'changes the current time' do
        Quantum.leap(the_past)
        Time.now.must_be_within_delta(the_past, 1)
      end

      it 'changes the current date' do
        Quantum.leap(the_past)
        Date.today.must_equal(the_past.to_date)
      end

      it 'returns the time' do
        Quantum.leap(the_past).must_be_kind_of(Time)
      end
    end

    describe 'without a block with redis' do
      the_present = Time.new
      the_past    = Time.new(1956, 9, 13, 15, 00)
      QuantumLeap::Accelerator.redis = Redis.new
      QuantumLeap::Accelerator.redis_var = 'quantum_leap_list'

      it 'changes the current time' do
        Quantum.leap(the_past)
        Time.now.must_be_within_delta(the_past, 1)
      end

      it 'changes the current date' do
        Quantum.leap(the_past)
        Date.today.must_equal(the_past.to_date)
      end

      it 'returns the time' do
        Quantum.leap(the_past).must_be_kind_of(Time)
      end
    end

    describe 'with a block' do
      the_present = Time.new
      the_past    = Time.new(1974, 10, 24, 15, 00)
      QuantumLeap::Accelerator.redis = nil

      it 'changes time only within the block' do
        Quantum.leap(the_past) do
          Time.now.must_be_within_delta(the_past, 1)
        end
        Time.now.must_be_within_delta(the_present, 1)
      end

      it 'changes date only within the block' do
        Quantum.leap(the_past) do
          Date.today.must_equal(the_past.to_date)
        end
        Date.today.must_equal(the_present.to_date)
      end

      it 'returns the time' do
        Quantum.leap(the_past) {}.must_be_kind_of(Time)
      end
    end

    describe 'with a block with redis' do
      the_present = Time.new
      the_past    = Time.new(1974, 10, 24, 15, 00)
      QuantumLeap::Accelerator.redis = Redis.new
      QuantumLeap::Accelerator.redis_var = 'quantum_leap_list'

      it 'changes time only within the block' do
        Quantum.leap(the_past) do
          Time.now.must_be_within_delta(the_past, 1)
        end
        Time.now.must_be_within_delta(the_present, 1)
      end

      it 'changes date only within the block' do
        Quantum.leap(the_past) do
          Date.today.must_equal(the_past.to_date)
        end
        Date.today.must_equal(the_present.to_date)
      end

      it 'returns the time' do
        Quantum.leap(the_past) {}.must_be_kind_of(Time)
      end
    end

    describe 'with no argument' do
      describe 'without a block' do
        the_past = Time.new(1956, 9, 13, 15, 00)
        QuantumLeap::Accelerator.redis = nil

        it 'defaults to the current time' do
          Quantum.leap
          Time.now.must_be_within_delta(the_past, 1)
        end

        it 'defaults to the current date' do
          Quantum.leap
          Date.today.must_equal(the_past.to_date)
        end

        it 'returns the time' do
          Quantum.leap.must_be_kind_of(Time)
        end
      end

      describe 'with a block' do
        the_present = Time.now
        the_past = Time.new(1956, 9, 13, 15, 00)
        QuantumLeap::Accelerator.redis = nil

        it 'only changes time within the block' do
          Quantum.leap do
            Time.now.must_be_within_delta(the_past, 1)
          end
          Time.now.must_be_within_delta(the_present, 1)
        end

        it 'only changes date within the block' do
          Quantum.leap do
            Date.today.must_equal(the_past.to_date)
          end
          Date.today.must_equal(the_present.to_date)
        end

        it 'returns the time' do
          Quantum.leap {}.must_be_kind_of(Time)
        end
      end
    end

    describe 'with no argument with redis' do
      describe 'without a block' do
        the_past = Time.new(1956, 9, 13, 15, 00)
        QuantumLeap::Accelerator.redis = Redis.new
        QuantumLeap::Accelerator.redis_var = 'quantum_leap_list'

        it 'defaults to the current time' do
          Quantum.leap
          Time.now.must_be_within_delta(the_past, 1)
        end

        it 'defaults to the current date' do
          Quantum.leap
          Date.today.must_equal(the_past.to_date)
        end

        it 'returns the time' do
          Quantum.leap.must_be_kind_of(Time)
        end
      end

      describe 'with a block' do
        the_present = Time.now
        the_past = Time.new(1956, 9, 13, 15, 00)
        QuantumLeap::Accelerator.redis = Redis.new
        QuantumLeap::Accelerator.redis_var = 'quantum_leap_list'

        it 'only changes time within the block' do
          Quantum.leap do
            Time.now.must_be_within_delta(the_past, 1)
          end
          Time.now.must_be_within_delta(the_present, 1)
        end

        it 'only changes date within the block' do
          Quantum.leap do
            Date.today.must_equal(the_past.to_date)
          end
          Date.today.must_equal(the_present.to_date)
        end

        it 'returns the time' do
          Quantum.leap {}.must_be_kind_of(Time)
        end
      end
    end
  end

  describe '.leap_back' do
    the_present = Time.new
    the_past    = Time.new(1972, 6, 15, 15, 00)
    QuantumLeap::Accelerator.redis = nil

    it 'returns to the present time' do
      Quantum.leap(the_past)
      Time.now.must_be_within_delta(the_past, 1)
      Quantum.leap_back
      Time.now.must_be_within_delta(the_present, 1)
    end

    it 'returns to the present date' do
      Quantum.leap(the_past)
      Date.today.must_equal(the_past.to_date)
      Quantum.leap_back
      Date.today.must_equal(the_present.to_date)
    end

    it 'returns the time' do
      Quantum.leap_back.must_be_kind_of(Time)
    end
  end

  describe '.leap_back with redis' do
    the_present = Time.new
    the_past    = Time.new(1972, 6, 15, 15, 00)
    QuantumLeap::Accelerator.redis = Redis.new
    QuantumLeap::Accelerator.redis_var = 'quantum_leap_list'

    it 'returns to the present time' do
      Quantum.leap(the_past)
      Time.now.must_be_within_delta(the_past, 1)
      Quantum.leap_back
      Time.now.must_be_within_delta(the_present, 1)
    end

    it 'returns to the present date' do
      Quantum.leap(the_past)
      Date.today.must_equal(the_past.to_date)
      Quantum.leap_back
      Date.today.must_equal(the_present.to_date)
    end

    it 'returns the time' do
      Quantum.leap_back.must_be_kind_of(Time)
    end
  end
end
