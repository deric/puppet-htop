require 'spec_helper'

describe 'htop' do
  _, os_facts = on_supported_os.first
  let(:facts) { os_facts }

  context 'htop class without any parameters' do
    it { is_expected.to compile.with_all_deps }

    it { is_expected.to contain_class('htop') }
    it { is_expected.to contain_class('htop::install') }

    it { is_expected.to contain_package('htop').with_ensure('present') }

    it { is_expected.to contain_htop__config('root') }

    it { is_expected.to contain_file('/root/.config').with_ensure('directory') }

    it { is_expected.to contain_file('/root/.config/htop').with_ensure('directory') }

    it {
      is_expected.to contain_file('/root/.config/htop/htoprc')
        .with_ensure('file')
        .with_content(%r{^# Managed})
    }
  end

  context 'manage configs for multiple users' do
    let(:params) do
      {
        users: {
          'foo' => {
            'options' => {
              'hide_threads' => '1',
            }
          },
          'bar' => {
            'options' => {
              'hide_threads' => '0',
            }
          },
        }
      }
    end

    it { is_expected.to contain_htop__config('foo') }
    it { is_expected.to contain_htop__config('bar') }

    it { is_expected.to contain_file('/home/foo/.config').with_ensure('directory') }
    it { is_expected.to contain_file('/home/foo/.config/htop').with_ensure('directory') }
    it { is_expected.to contain_file('/home/bar/.config').with_ensure('directory') }
    it { is_expected.to contain_file('/home/bar/.config/htop').with_ensure('directory') }

    it {
      is_expected.to contain_file('/home/foo/.config/htop/htoprc')
        .with_ensure('file')
        .with_content(%r{^hide_threads=1})
    }

    it {
      is_expected.to contain_file(
      '/home/bar/.config/htop/htoprc',
    ).with({
             ensure: 'file'
           }).with_content(%r{^hide_threads=0})
    }
  end

  context 'update global defaults' do
    let(:params) do
      {
        'config' => {
          'defaults' => {
            'sort_key' => '47'
          }
        }
      }
    end

    it {
      is_expected.to contain_file(
      '/root/.config/htop/htoprc',
    ).with_content(%r{^sort_key=47})
    }
  end
end
