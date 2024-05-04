require 'spec_helper'
require 'ronin/cli/commands/asn'
require_relative 'man_page_example'
require 'ronin/support/network/asn/list'

describe Ronin::CLI::Commands::Asn do
  include_examples "man_page"

  subject { described_class.new }

  describe '#run?' do
    pending "when the file does not exist"
    pending "when the file is stale"
    pending "when given an IP address"
    pending "when given an invalid IP address"  # mock #query_ip
    pending "when not given an IP address" # mock #search_asn_records with truncated output
  end

  describe '#stale?' do
    let(:file) { 'file' }

    before do
      subject.options[:file] = file
    end

    it 'calls Support::Network::ASN::List.stale? with the file' do
      expect(Ronin::Support::Network::ASN::List).to receive(:stale?).with(file)
      subject.stale?
    end
  end

  describe '#download' do
    context "with default parameters" do

      let(:url)  { 'https://iptoasn.com/data/ip2asn-combined.tsv.gz' }
      let(:file) { "#{Dir.home}/.cache/ronin/ronin-support/ip2asn-combined.tsv.gz" }
        
      it 'calls Support::Network::ASN::List.download with default parameters' do
        expect(Ronin::Support::Network::ASN::List).to receive(:download).with(
          url: url, 
          path: file
        )
        subject.download
      end
    end

    context "with optional parameters" do

      let(:url)  { 'http://example.com' }
      let(:file) { 'file' }

      before do 
        subject.options[:url]  = url
        subject.options[:file] = file
      end

      it 'calls Support::Network::ASN::List.download with optional parameters' do
        expect(Ronin::Support::Network::ASN::List).to receive(:download).with(
          url: url, 
          path: file
        )
        subject.download
      end
    end
  end

  describe "#update" do
    context "with default parameters" do
      let(:url)  { 'https://iptoasn.com/data/ip2asn-combined.tsv.gz' }
      let(:file) { "#{Dir.home}/.cache/ronin/ronin-support/ip2asn-combined.tsv.gz" }

      it 'calls Support::Network::ASN::List.update with default parameters' do
        expect(Ronin::Support::Network::ASN::List).to receive(:update).with(
          url: url,
          path: file
        )
        subject.update
      end
    end

    context "with optional parameters" do
      let(:url)  { 'http://example.com' }
      let(:file) { 'file' }

      before do
        subject.options[:url]  = url
        subject.options[:file] = file
      end

      it 'calls Support::Network::ASN::List.update with optional parameters' do
        expect(Ronin::Support::Network::ASN::List).to receive(:update).with(
          url: url,
          path: file
        )
        subject.update
      end
    end
  end

  describe "#list_file" do
    let(:file) { 'file' }

    before do
      subject.options[:file] = file
    end

    it 'calls Support::Network::ASN::List.parse' do
      expect(Ronin::Support::Network::ASN::List).to receive(:parse).with(file)
      subject.list_file
    end
  end

  describe "#query_ip" do
    let(:ip) { '127.0.0.1' }

    it 'calls Support::Network::ASN::List.query_ip' do
      expect(Ronin::Support::Network::ASN).to receive(:query).with(ip)
      subject.query_ip(ip)
    end
  end

  pending "#print_asn_records"
  pending "#print_asn_record"
end
