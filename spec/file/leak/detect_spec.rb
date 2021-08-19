require 'tempfile'

RSpec.describe 'File::Leak::Detect' do
  it 'Leaked file' do
    pending('This test is not pending, it fails correctly on after :each')

    file = Tempfile.create('leak')
  end

  it 'File closed correctly' do
    file = Tempfile.create('leak')
    file.close
  end
end
