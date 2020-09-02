require 'spec_helper'

module RubyEventStore
  module Mappers
    module Transformation
      RSpec.describe DomainEvent do
        let(:uuid)  { SecureRandom.uuid }
        let(:event) {
          TestEvent.new(event_id: uuid,
                        data: {some: 'value'},
                        metadata: {some: 'meta'})
        }
        let(:record)  {
          Record.new(
            event_id:   uuid,
            metadata:   {some: 'meta'},
            data:       {some: 'value'},
            event_type: 'TestEvent',
          )
        }

        specify "#dump" do
          expect(DomainEvent.new.dump(event)).to eq(record)
        end

        specify "#load" do
          loaded = DomainEvent.new.load(record)
          expect(loaded).to eq(event)
          expect(loaded.metadata.to_h).to eq(event.metadata.to_h)
        end
      end
    end
  end
end
