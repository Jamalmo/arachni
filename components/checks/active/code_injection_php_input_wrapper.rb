=begin
    Copyright 2010-2014 Tasos Laskos <tasos.laskos@gmail.com>
    Please see the LICENSE file at the root directory of the project.
=end

# @see OWASP    https://www.owasp.org/index.php/Top_10_2007-Malicious_File_Execution
# @author Tasos "Zapotek" Laskos <tasos.laskos@gmail.com>
# @version 0.1
class Arachni::Checks::CodeExecutionPHPInputWrapper < Arachni::Check::Base

    def self.options
        @options ||= {
            format:    [Format::STRAIGHT],
            body:      "<?php echo 'vDBVBsbVdv'; ?> <?php echo chr(80).chr(76).chr(76).chr(33).chr(56).chr(111).chr(55) ?>",
            substring: 'vDBVBsbVdv PLL!8o7',

            # Add one more mutation (on the fly) which will include the extension
            # of the original value (if that value was a filename) after a null byte.
            each_mutation: proc do |mutation|
                # Don't bother if the current element type can't carry nulls.
                next if !mutation.valid_input_value_data?( "\0" )

                m = mutation.dup

                # Figure out the extension of the default value, if it has one.
                ext = m.default_inputs[m.affected_input_name].to_s.split( '.' )
                ext = ext.size > 1 ? ext.last : nil

                # Null-terminate the injected value and append the ext.
                m.affected_input_value += "\0.#{ext}"

                # Pass our new element back to be audited.
                m
            end
        }
    end

    def run
        audit 'php://input', self.class.options
    end

    def self.info
        {
            name:        'Code injection (php://input wrapper)',
            description: %q{It injects PHP code into the HTTP request body and
                uses the php://input wrapper to try and load it.},
            elements:    [ Element::Form, Element::Link, Element::Cookie, Element::Header ],
            author:      'Tasos "Zapotek" Laskos <tasos.laskos@gmail.com> ',
            version:     '0.1',
            platforms:   [:php],

            issue:       {
                name:        %q{Code injection (php://input wrapper)},
                description: %q{The web application can be forced to execute
                    arbitrary code via the php://input wrapper.},
                references:  {
                    'OWASP' => 'https://www.owasp.org/index.php/Top_10_2007-Malicious_File_Execution'
                },
                tags:        %w(remote injection php code execution),
                cwe:         94,
                severity:    Severity::HIGH
            }
        }
    end

end
