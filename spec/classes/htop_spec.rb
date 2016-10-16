require 'spec_helper'

describe 'htop' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "htop class without any parameters" do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('htop') }
          it { is_expected.to contain_class('htop::params') }
          it { is_expected.to contain_class('htop::install') }

          it { is_expected.to contain_package('htop').with_ensure('present') }

          it { is_expected.to contain_htop__config('root') }

          it { is_expected.to contain_file('/root/.config').with(
            {
              ensure: 'directory',
            }
          )}

          it { is_expected.to contain_file('/root/.config/htop').with(
            {
              ensure: 'directory',
            }
          )}

          it { is_expected.to contain_file('/root/.config/htop/htoprc').with(
              {
                ensure: 'file',
              }
            ).with_content(/^# Managed/)
          }

          it { is_expected.to contain_file(
            '/root/.config/htop/htoprc'
            ).with_content(/^sort_key=46/)
          }
        end

        context 'manage configs for multiple users' do
          let(:params) do
            {
              :users => {
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

          it { is_expected.to contain_file('/home/foo/.config').with({ensure: 'directory'})}
          it { is_expected.to contain_file('/home/foo/.config/htop').with({ensure: 'directory'})}
          it { is_expected.to contain_file('/home/bar/.config').with({ensure: 'directory'})}
          it { is_expected.to contain_file('/home/bar/.config/htop').with({ensure: 'directory'})}

          it { is_expected.to contain_file(
            '/home/foo/.config/htop/htoprc'
            ).with({
              ensure: 'file'
            }).with_content(/^hide_threads=1/)
          }

          it { is_expected.to contain_file(
            '/home/bar/.config/htop/htoprc'
            ).with({
              ensure: 'file'
            }).with_content(/^hide_threads=0/)
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

          it { is_expected.to contain_file(
            '/root/.config/htop/htoprc'
            ).with_content(/^sort_key=47/)
          }
        end

      end
    end
  end

  context 'unsupported operating system' do
    describe 'htop class without any parameters on Solaris/Nexenta' do
      let(:facts) do
        {
          :osfamily        => 'Solaris',
          :operatingsystem => 'Nexenta',
        }
      end

      it { expect { is_expected.to contain_package('htop') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
