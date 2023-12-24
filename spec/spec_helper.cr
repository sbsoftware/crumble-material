require "spec"
require "../src/crumble-material"

class String
  def squish
    split(/\n\s*/).join
  end
end
