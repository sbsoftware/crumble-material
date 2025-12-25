require "../spec_helper"
require "digest/md5"

module Crumble::Material::FontLicenseAssetsSpec
  def self.expected_uri(uri_path : String, contents : String) : String
    file, _, extension = uri_path.rpartition('.')
    etag = Digest::MD5.hexdigest(contents)
    "#{file}_#{etag}.#{extension}"
  end

  describe "font license assets" do
    it "registers the Roboto license as an asset" do
      actual_uri = Crumble::Material::RobotoLicense.uri_path
      contents = File.read("#{__DIR__}/../../assets/fonts/Roboto/LICENSE.txt")
      expected = expected_uri("/assets/fonts/Roboto/LICENSE.txt", contents)
      actual_uri.should eq(expected)

      file = AssetFileRegistry.query(actual_uri)
      file.should be_a(TextFile)
      file.not_nil!.mime_type.should eq("text/plain; charset=utf-8")
      file.not_nil!.contents.should eq(contents)
    end

    it "registers the Material Symbols Outlined license as an asset" do
      actual_uri = Crumble::Material::Icon::FontLicense.uri_path
      contents = File.read("#{__DIR__}/../../assets/fonts/MaterialSymbolsOutlined/LICENSE.txt")
      expected = expected_uri("/assets/MaterialSymbolsOutlined_LICENSE.txt", contents)
      actual_uri.should eq(expected)

      file = AssetFileRegistry.query(actual_uri)
      file.should be_a(TextFile)
      file.not_nil!.mime_type.should eq("text/plain; charset=utf-8")
      file.not_nil!.contents.should eq(contents)
    end
  end
end
