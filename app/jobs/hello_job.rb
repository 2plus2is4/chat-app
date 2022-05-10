# frozen_string_literal: true

class HelloJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    # Simulates a long, time-consuming task
    sleep 5
    # Will display current time, milliseconds included
    p "hello from HelloWorldJob #{Time.now.strftime('%F - %H:%M:%S.%L')}"
  end
end
