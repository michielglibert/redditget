$url = $ARGV[0];
use Cwd qw(cwd);
$line=cwd;
system "powershell wget $url -O \'$line/WebPage.html\'";

open(READ, "WebPage.html");
undef $/;
$_=<READ>;

while(m/(?<!Comment as<\/span>)<a class="s103i1tc-0(?! bhkwHs).*?" href=".*?">(.+?)<\/a>/mg) {
	$name = $1;
	m/"s5yqo3m-0.*?">(-?\d+(?:\.\d+)?|Score hidden).*?<\/span>/mg;
	$num = $1;
	print "$1\n";
	if($1 =~ /(\d+\.\d+)/) {
		$num =$1*1000;
	}
	$users{$name}=$num if not exists $users{$name} && $users{$name} < $num;		
}

printf "%-25s %s\n","Username","#Points";
print "------------------------------------\n";
for $key (sort { $users{$b} <=> $users{$a} } keys %users) {
	if($users{$key} > 1000) {
		printf "%-25s %s+\n",$key,$users{$key};
	} else {
		printf "%-25s %s\n",$key,$users{$key};
	}
}

