require "spec_helper"

describe HerokuAppInfo::ContentResolver do
  describe "#resolve" do
    describe "plain text given" do
      it "ext .txt" do
        assert {
          HerokuAppInfo::ContentResolver.resolve("apps", "") == ["apps.txt", ""]
        }
      end
    end

    describe "Hash given" do
      it "return json" do
        assert {
          HerokuAppInfo::ContentResolver.resolve("app", {}) == ["app.json", "{}"]
        }
      end
    end
  end
end
