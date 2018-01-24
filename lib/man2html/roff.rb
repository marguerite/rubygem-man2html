module Man2Html
  class Roff
    def initialize(man)
      @man = if man.end_with?('.gz')
	       decompress(man)
	     else
	       open(man, 'r:UTF-8').read
	     end
    end

    def to_html
	    @man.gsub(%r{^\.SH\s(.*?)\n}m, '<h1>\1</h1>' + "\n")
	  .split("\n").each {|l| p l }
    end

    private

    def decompress(man)
      raw = ""
      IO.popen("gzip -d #{man} -c") do |m|
	raw = m.read
      end
      raw
    end
  end
end

Man2Html::Roff.new('cat.1.gz').to_html
