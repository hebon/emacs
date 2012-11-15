#name : new.pm
# --
package $1;

use strict;
use vars qw(@ISA @EXPORT %CONFIG %MSG);

require Exporter;
@ISA = qw(Exporter);
@EXPORT = qw(%CONFIG %MSG);

%CONFIG = (
	SCRIPT_NAME => (\$0 =~ m|([^/]*)$|),
);

%MSG = (
);

1;
