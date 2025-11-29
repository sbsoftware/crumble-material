require "spec"
require "../src/crumble-material"
require "crumble/spec/test_handler_context"

class String
  def squish
    split(/\n\s*/).join
  end
end
