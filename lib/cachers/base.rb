module Cachers
  class Base

    attr_reader :record

    def initialize(record)
      @record = record
    end

    def cache
      # Sublcass must implement this
    end

    def uncache
      # Subclass must implement this
    end

    def recache
      if record.previous_changes.any?
        previous_record = record.dup
        record.previous_changes.each do |attribute, values|
          previous_record.send "#{attribute}=", values.first
        end
        previous_record.id = record.id
        self.class.new(previous_record).uncache
      else
        uncache
      end
      cache
    end

    def method_missing(name, *args, &block)
      Cachers.client.send name, *args, &block
    end

  end
end
