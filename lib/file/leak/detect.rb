module FileLeakDetect
  class << self
    attr_accessor :debug
    attr_accessor :enabled
    attr_accessor :global_opened_files

    def config
      yield self
    end
  end
end

FileLeakDetect.debug = false
FileLeakDetect.enabled = true
FileLeakDetect.global_opened_files = {}

RSpec.configure do |config|
  config.before :each do
    next if !FileLeakDetect.enabled

    allow(File).to receive(:open).and_wrap_original do |m, *args, &block|
      file = args[0]
      file = file.path if file.is_a?(File)
      file = file.to_s if file.is_a?(Pathname)
      FileLeakDetect.global_opened_files[file] = 0 if !FileLeakDetect.global_opened_files.include?(file)
      FileLeakDetect.global_opened_files[file] = FileLeakDetect.global_opened_files[file] + 1
      puts "opening file #{file}" if FileLeakDetect.debug
      m.call(*args, &block)
    end

    allow_any_instance_of(File).to receive(:close).and_wrap_original do |m, *args, &block|
      begin
        m.call(*args, &block)
      ensure
        file = m.receiver.path
        # It's seems common behaviour to close a just closed file
        if FileLeakDetect.global_opened_files.has_key?(file)
          puts "closing file #{file}" if FileLeakDetect.debug
          FileLeakDetect.global_opened_files[file] = FileLeakDetect.global_opened_files[file] - 1
          FileLeakDetect.global_opened_files.delete(file) if FileLeakDetect.global_opened_files[file].zero?
        end
      end
    end
  end

  config.after :each do
    begin
      next if !FileLeakDetect.enabled

      # Check that all files are closed
      expect(FileLeakDetect.global_opened_files).to eq({}), 'Lazy programmer, not all files was closed!!!'
    ensure
      FileLeakDetect.global_opened_files = {}
    end
  end
end
