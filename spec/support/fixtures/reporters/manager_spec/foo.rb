=begin
    Copyright 2010-2014 Tasos Laskos <tasos.laskos@gmail.com>
    Please see the LICENSE file at the root directory of the project.
=end

class Arachni::Reporters::Foo < Arachni::Reporter::Base

    def run
        File.open( "foo", "w" ) {}
    end

    def self.info
        super.merge( options: [ Options.outfile( 'foo' ) ] )
    end
end
