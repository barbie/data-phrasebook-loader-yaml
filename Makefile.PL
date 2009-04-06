use ExtUtils::MakeMaker;
WriteMakefile(
    NAME            => 'Data::Phrasebook::Loader::YAML',
    VERSION_FROM	=> 'lib/Data/Phrasebook/Loader/YAML.pm',
    PREREQ_PM		=> {
		'Data::Phrasebook' => '0.18',
		'YAML'             => '0.35',
        'Test::More'       => '0.47',
    },
    ($] >= 5.005 ?
      (ABSTRACT_FROM => 'lib/Data/Phrasebook/Loader/YAML.pm',
       AUTHOR        => 'Barbie <barbie@cpan.org>') : ()),
    (eval($ExtUtils::MakeMaker::VERSION) >= 6.10 ?
        ( NO_META => 1, ) : ()),
);
