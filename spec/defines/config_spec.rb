# frozen_string_literal: true

require 'spec_helper'

describe 'htop::config' do
  _, os_facts = on_supported_os.first
  let(:facts) { os_facts }
  let(:pre_condition) { 'include htop' }

  context 'config for user' do
    let(:title) { 'john' }
    let(:params) do
      {
        options: {},
        defaults: {},
      }
    end

    it { is_expected.to compile }

    it {
      is_expected.to contain_file('/home/john/.config')
        .with( ensure: 'directory')
    }

    it {
      is_expected.to contain_file('/home/john/.config/htop')
        .with( ensure: 'directory')
    }

    it {
      is_expected.to contain_file('/home/john/.config/htop/htoprc')
        .with( ensure: 'file')
    }
  end
end
