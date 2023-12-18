require 'spec_helper'

describe 'htop' do
  _, os_facts = on_supported_os.first
  let(:facts) { os_facts }

  context 'htop class without any parameters' do
    it { is_expected.to compile.with_all_deps }

    it { is_expected.to contain_class('htop') }
    it { is_expected.to contain_class('htop::install') }

    it { is_expected.to contain_package('htop').with_ensure(%r{present|installed}) }
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
          foo: {
            options: {
              hide_threads: '1',
            },
          },
          bar: {
            options: {
              hide_threads: 0,
            },
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
        defaults: {
          sort_key: '47',
        }
      }
    end

    it {
      is_expected.to contain_file(
      '/root/.config/htop/htoprc',
    ).with_content(%r{^sort_key=47})
    }
  end

  context 'without managed package' do
    let(:params) do
      {
        manage_package: false,
      }
    end

    it { is_expected.not_to contain_package('htop').with_ensure(%r{present|installed}) }
  end

  context 'with htop 3 screens' do
    let(:params) do
      {
        users: {
          john: {
            options: {
              config_reader_min_version: 3
            },
            screens: [
              {
                name: 'Main',
                header: 'PID USER PRIORITY NICE M_VIRT M_RESIDENT M_SHARE STATE PERCENT_CPU PERCENT_MEM TIME Command',
                config: {
                  sort_key: 'PERCENT_CPU'
                },
              },
            ],
          },
        }
      }
    end

    it {
      is_expected.to contain_file('/home/john/.config/htop/htoprc')
        .with_ensure('file')
        .with_content(%r{^\.sort_key=PERCENT_CPU})
        .with_content(%r{^screen:Main})
    }
  end
end
