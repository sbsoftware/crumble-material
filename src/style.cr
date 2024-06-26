require "./element_ids"
require "./classes"

class Crumble::Material::Layout::Style < CSS::Stylesheet
  rules do
    rule html, body, Classes::Content do
      width 100.percent
    end

    rule html, body, Classes::Content do
      minHeight 100.vh
      padding 0
      margin 0
      fontFamily "Helvetica, sans-serif"
    end

    rule body do
      display Flex
      alignItems Stretch
    end
  end
end
