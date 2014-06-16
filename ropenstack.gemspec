Gem::Specification.new do |s|
	s.name		= 'ropenstack'
	s.version	= '2.0.0'
	s.date		= '2013-01-15'
	s.summary 	= 'Openstack for Ruby'
	s.description 	= 'A Ruby wrapper for all the openstack API calls'
	s.authors	= '["Sam "Tehsmash" Betts"]'
	s.email		= 'sam@code-smash.net'
        s.homepage      = 'https://github.com/CiscoSystems/ropenstack'
	s.files		= `git ls-files`.split("\n")
	s.require_paths = ["lib"]
        s.license       = 'Apache v2'
end
