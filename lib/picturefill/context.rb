# CleanRoom
module Picturefill
  class Context
    IMAGE = Struct.new(:src, :media, :options)

    def initialize(&blk)
      @self_before_instance_eval = eval("self", blk.binding)
      instance_eval(&blk)
    end

    def each(&blk)
      (@images ||= []).each(&blk)
    end

  private

    # Usage: image("small.jpg", :ratio => 2, :min => 400, :media => 'custom')
    #        image("small.jpg", '(min-width: 400px)')
    def image(src, options = {})
      media = extract_media!(options)
      (@images ||= []) << IMAGE.new(src, media, options)

      # Do not render anything here!
      return ""
    end

    # Returns: A string
    # Example: "(min-width: 400px) and (min-device-pixel-ratio: 2.0)"
    def extract_media!(options)
      case options
      when String
        options
      when Hash
        min   = options.delete :min
        ratio = options.delete :ratio
        media = options.delete :media

        webkit = options.delete :webkit
        ratio_attribute = webkit ? "-webkit-min-device-pixel-ratio" : "min-device-pixel-ratio"

        min   = "(min-width: #{min}px)" if min
        ratio = case ratio
                when Float
                  "(#{ratio_attribute}: #{ratio})"
                when Integer
                  "(#{ratio_attribute}: %.1f)" % ratio
                when nil
                else
                  raise ArgumentError.new("Only Float && Integer allowed")
                end
        media = "(#{media})" if media

        [min, ratio, media].select { |e| !e.nil? }.join(" and ")
      else
        raise ArgumentError.new("Only hash && string allowed")
      end
    end

    def method_missing(method, *args, &block)
      @self_before_instance_eval.send(method, *args, &block)
    end
  end
end
