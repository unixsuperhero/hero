module MarkdownListToMatrix
    extend self
    def build_list(lines)
      first = lines.shift
      return [] if first.nil?
      spl = first.split(/[+*-] /, 2)
      cur_depth = spl.first.length
      subs = lines.take_while do |l|
        l_depth = l.split(/[+*-] /, 2).first.length
        l_depth > cur_depth
      end
      if subs.any?
        lines.shift(subs.length)
        [[spl.last, build_list(subs)]] + build_list(lines)
      else
        [spl.last] + build_list(lines)
      end
    end

    def sample
        build_list example_list
    end

    def example_list
      list = <<-HDOC.strip_heredoc
        - Todo/Changelog - use a hash and partials to generate bullet points
        - Hands On Page
          - Improve Designs
          - Button to edit Common Notes inline (show form to add or hide buttons)
          - Change text format of Common Notes buttons to: "Name (Note)"
        - Use 1 table for big screens and a smaller vertical (2 column) table for small devices
        - Add a Settings Manager to manage:
          - Common Note items on Hands On page
          - Invoicing Line Items
        - Reorganize Trade Log building processing
          - Add buttons to Trade Log list
            - Import Cars (vinsolutions report importer)
              - On Imported Cars screen show: imported cars, new count, assigned count (on a trade log already)
                - Make VinsolutionsReportCar many-to-many association
            - New Trade Log (the current Walk Report)
            - Hide Unassigned Cars (anything in New Trade Log will be marked as :hidden)
          - Move Walk Report to the New Trade Log page
      HDOC
      list.lines.map(&:chomp)
    end
end
