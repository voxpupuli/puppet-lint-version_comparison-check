require 'spec_helper'

describe 'version_comparison' do
  let(:msg) { 'version compared as number' }

  context 'with fix disabled' do
    context 'when versions are not compared to numbers' do
      let(:code) do
        <<-EOS
        if versioncmp($::lsbmajdistrelease, '4') >= 0 { }
        if versioncmp($version, '1') <= 0 { }
        if versioncmp($some_version, '3') < 0 { }
        if $mod::params::version == '2' { }
        EOS
      end

      it 'does not detect any problems' do
        expect(problems).to have(0).problems
      end
    end

    context 'when versions are compared to numbers' do
      let(:code) do
        <<-EOS
        if $::lsbmajdistrelease >= 4 { }
        if $version <= 1 { }
        if $some_version < 3 { }
        if $mod::params::version == 2 { }
        EOS
      end

      it 'detects 4 problems' do
        expect(problems).to have(4).problems
      end

      it 'creates warnings' do
        expect(problems).to contain_warning(msg).on_line(1).in_column(12)
        expect(problems).to contain_warning(msg).on_line(2).in_column(12)
        expect(problems).to contain_warning(msg).on_line(3).in_column(12)
        expect(problems).to contain_warning(msg).on_line(4).in_column(12)
      end
    end
  end

  context 'with fix enabled' do
    before do
      PuppetLint.configuration.fix = true
    end

    after do
      PuppetLint.configuration.fix = false
    end

    context 'when versions are not compared to numbers' do
      let(:code) do
        <<-EOS
        if versioncmp($::lsbmajdistrelease, '4') >= 0 { }
        if versioncmp($version, '1') <= 0 { }
        if versioncmp($some_version, '3') < 0 { }
        if $mod::params::version == '2' { }
        EOS
      end

      it 'does not detect any problems' do
        expect(problems).to have(0).problems
      end
    end

    context 'when versions are compared to numbers' do
      let(:code) do
        <<-EOS
        if $::lsbmajdistrelease >= 4 { }
        if $version <= 1 { }
        if $some_version < 3 { }
        if $mod::params::version == 2 { }
        if $::operatingsystemmajrelease<'6' { }
        EOS
      end

      it 'detects 5 problems' do
        expect(problems).to have(5).problems
      end

      it 'creates warnings' do
        expect(problems).to contain_fixed(msg).on_line(1).in_column(12)
        expect(problems).to contain_fixed(msg).on_line(2).in_column(12)
        expect(problems).to contain_fixed(msg).on_line(3).in_column(12)
        expect(problems).to contain_fixed(msg).on_line(4).in_column(12)
        expect(problems).to contain_fixed(msg).on_line(5).in_column(12)
      end

      it 'shoulds use versioncmp' do
        expect(manifest).to eq(
          <<-EOS,
        if versioncmp($::lsbmajdistrelease, '4') >= 0 { }
        if versioncmp($version, '1') <= 0 { }
        if versioncmp($some_version, '3') < 0 { }
        if versioncmp($mod::params::version, '2') == 0 { }
        if versioncmp($::operatingsystemmajrelease, '6')<0 { }
        EOS
        )
      end
    end
  end
end
