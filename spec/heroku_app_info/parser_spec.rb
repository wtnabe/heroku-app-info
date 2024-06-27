require "spec_helper"

def fixture_path(name, sort: nil)
  File.join(
    File.dirname(File.dirname(__FILE__)),
    "fixtures",
    [name, sort].compact.join("_") + ".txt"
  )
end

def fixture(name, sort: nil)
  File.read(fixture_path(name, sort: sort))
end

describe HerokuAppInfo::Parser do
  describe "#apps" do
    it "whole apps without title" do
      assert {
        HerokuAppInfo::Parser.new.apps(fixture("apps")) == %w[
          broken-cherry-1618
          delicate-dawn-5590
          late-bird-8823
          snowy-wind-6327
          autumn-butterfly-5286
          bitter-sound-7
          autumn-butterfly-7904
          empty-wind-5901
          icy-grass-2801
          twilight-snowflake-3409
        ]
      }
    end
  end

  describe "#parse" do
    it "app info" do
      assert {
        HerokuAppInfo::Parser.new.parse(fixture("app")) == {
          "Addons" => [
            "heroku-postgresql:essential-1",
            "heroku-redis:premium-0",
            "memcachedcloud:30",
            "papertrail:fixa",
            "scheduler:standard"
          ],
          "Auto Cert Mgmt" => "true",
          "Collaborators" => ["nanashi@example.jp"],
          "Dynos" => {
            "web" => 1,
            "worker" => 1
          },
          "Git URL" => "https://git.heroku.com/app.git",
          "Owner" => "nanashi-team@herokumanager.com",
          "Region" => "us",
          "Repo Size" => "6 MB",
          "Slug Size" => "169 MB",
          "Stack" => "heroku-20",
          "Web URL" => "https://app.herokuapp.com/"
        }
      }
    end

    it "pg info" do
      assert {
        HerokuAppInfo::Parser.new.parse(fixture("app", sort: "pg")) == {
          "Plan" => "essential-1",
          "Status" => "Available",
          "Connections" => "2/20",
          "PG Version" => "14.11",
          "Created" => "2021-01-01 00:00",
          "Data Size" => "101 MB / 10 GB (0.99%) (In compliance)",
          "Tables" => "43/4000 (In compliance)",
          "Fork/Follow" => "Unsupported",
          "Rollback" => "Unsupported",
          "Continuous Protection" => "Off",
          "Add-on" => "postgresql-elliptical-22765"
        }
      }
    end
  end
end
