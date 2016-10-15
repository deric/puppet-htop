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

          it { is_expected.to contain_class('htop::params') }
          it { is_expected.to contain_class('htop::install') }

          it { is_expected.to contain_package('htop').with_ensure('present') }

          it { is_expected.to contain_file('/root/.config/htop/htoprc').with(
              {
                ensure: 'file',
              }
            )
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
