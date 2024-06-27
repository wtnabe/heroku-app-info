require "spec_helper"

describe HerokuAppInfo::Options do
  describe "#apps" do
    it "single app" do
      assert {
        HerokuAppInfo::Options.new(%w[-a aaa]).apps == %w[aaa]
      }
    end

    it "double app" do
      assert {
        HerokuAppInfo::Options.new(%w[-a aaa,bbb]).apps == %w[aaa bbb]
      }
    end
  end

  describe "#app-from-file" do
    it "apps line by line" do
      path = File.join(__dir__, "../fixtures/target-apps.txt")
      HerokuAppInfo::Options.new(["--app-list-from", path]).apps == %w[
        broken-cherry-1618
        delicate-dawn-5590
        late-bird-8823
        snowy-wind-6327
        autumn-butterfly-5286
      ]
    end
  end
end
