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

    def self.inherited(subclass)
      if model = (subclass.name.sub(/Cacher$/, '').constantize rescue nil)
        model.include Concern
        model.class_eval do
          define_method :cacher do
            @cacher ||= subclass.new(self)
          end
        end
      end
    end

  end
end
