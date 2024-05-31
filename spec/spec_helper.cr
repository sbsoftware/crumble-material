require "spec"
require "../src/crumble-material"
require "crumble/spec/test_request_context"

class String
  def squish
    split(/\n\s*/).join
  end
end
