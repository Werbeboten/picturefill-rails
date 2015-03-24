require "spec_helper"

describe Picturefill::Rails::ViewHelper do
  include RSpec::Rails::HelperExampleGroup

  subject do
    _view.picturefill("default.jpg", "description") {}
  end


  describe "container-span" do
    it "contains data-picture attribute" do
      expect(subject).to match(/<span[^>]*data-picture/)
    end

    it "contains alt attribute with description" do
      expect(subject).to match(/<span[^>]*data-alt=\"description/)
    end
  end


  describe "noscript" do
    it "contains img-tag with description" do
      expect(subject).to match(/<noscript><img[^>]*alt="description"/)
    end

    it "contains img-tag with src" do
      expect(subject).to match(/<noscript><img[^>]*src="\/assets\/default.jpg"/)
    end
  end


  context "without a block" do
    it "raise an ArgumentError" do
      expect {  _view.picturefill("src", "description") }.to raise_error(ArgumentError)
    end
  end


  context "with one image" do
    subject { setup_image("small.jpg") }

    it "renders one containing span" do
      expect(subject).to include('<span data-src="/assets/small.jpg">')
    end
  end


  context "with two images" do
    subject do
      _view.picturefill("src", "description") do
        image("small.jpg")
        image("medium.jpg")
      end
    end

    it "renders two containing span" do
      expect(subject).to include('<span data-src="/assets/small.jpg">')
      expect(subject).to include('<span data-src="/assets/medium.jpg">')
    end
  end


  context "when given :min" do
    subject { setup_image("small.jpg", :min => 400) }

    it "renders data-media with min-width" do
      expect(subject).to include('data-media="(min-width: 400px)')
    end
  end


  context "when given :ratio" do
    subject { setup_image("small.jpg", ratio: 2) }

    it "renders data-media with device-ratio" do
      expect(subject).to include('data-media="(min-device-pixel-ratio: 2.0)')
    end
  end

  context "when given :ratio and :webkit => true" do
    subject { setup_image("small.jpg", ratio: 2, webkit: true) }

    it "renders data-media with -webkit-device-ratio" do
      expect(subject).to include('data-media="(-webkit-min-device-pixel-ratio: 2.0)')
    end
  end


  context "when given :ratio as float" do
    subject { setup_image("small.jpg", ratio: 2.42) }

    it "renders data-media with device-ratio in given precision" do
      expect(subject).to include('data-media="(min-device-pixel-ratio: 2.42)')
    end
  end


  context "when given :media" do
    subject { setup_image("small.jpg", media: 'custom') }

    it "renders data-media with given :media" do
      expect(subject).to include('data-media="(custom)')
    end
  end


  context "when given :min, :ratio && :media" do
    subject { setup_image("small.jpg", ratio: 2, min: 333, media: 'custom') }

    it "renders data-media with given options + custom media" do
      expect(subject).to include('data-media="(min-width: 333px) and (min-device-pixel-ratio: 2.0) and (custom)')
    end
  end


  context "when given '(min-width: 400px)'" do
    subject { setup_image("small.jpg", '(min-width: 400px)') }

    it "renders data-media with given string" do
      expect(subject).to include('data-media="(min-width: 400px)')
    end
  end


  context "when given invalid :ratio" do
    it "raises an ArgumentError" do
      expect {
        setup_image("small.jpg", ratio: ["evil"])
      }.to raise_error(ArgumentError)
    end
  end


  context "when given invalid params" do
    it "raises an ArgumentError" do
      expect {
        setup_image("small.jpg", ["evil"])
      }.to raise_error(ArgumentError)
    end
  end


private

  def setup_image(*args)
    _view.picturefill("src", "description") do
      image(*args)
    end
  end

end
