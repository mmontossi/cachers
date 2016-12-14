module Cachers
  class Base

    %i(extend include).each do |action|
      send action, Dsl
    end

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

  end
end
