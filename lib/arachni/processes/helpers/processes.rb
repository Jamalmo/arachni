=begin
    Copyright 2010-2014 Tasos Laskos <tasos.laskos@gmail.com>
    Please see the LICENSE file at the root directory of the project.
=end

# @param (see Arachni::Processes::Manager#kill_reactor)
# @return (see Arachni::Processes::Manager#kill_reactor)
def process_kill_reactor( *args )
    Arachni::Processes::Manager.kill_reactor( *args )
end

# @param (see Arachni::Processes::Manager#kill)
# @return (see Arachni::Processes::Manager#kill)
def process_kill( *args )
    Arachni::Processes::Manager.kill( *args )
end

# @param (see Arachni::Processes::Manager#killall)
# @return (see Arachni::Processes::Manager#killall)
def process_killall( *args )
    Arachni::Processes::Manager.killall( *args )
end

# @param (see Arachni::Processes::Manager#kill_many)
# @return (see Arachni::Processes::Manager#kill_many)
def process_kill_many( *args )
    Arachni::Processes::Manager.kill_many( *args )
end
