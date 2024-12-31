class TestJob
  include Sidekiq::Job

  def perform(*args)
    puts "testing: #{args.inspect}"
  end
end
