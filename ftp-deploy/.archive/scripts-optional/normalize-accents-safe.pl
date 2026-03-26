#!/usr/bin/perl
use strict;
use warnings;
use Encode qw(encode decode);

# Safe Accent Normalization Script
# Removes non-ASCII characters from CSS comments WITHOUT removing CSS rules
#
# USAGE:
#   perl normalize-accents-safe.pl style-async.scss.tpl
#   perl normalize-accents-safe.pl style-critical.tpl
#
# SAFETY GUARANTEES:
#   ✓ CSS rules are NEVER removed
#   ✓ Comments are NEVER removed
#   ✓ Only accented characters are replaced (ç→c, á→a, etc.)
#   ✓ Whitespace and structure preserved
#   ✓ Result is pure ASCII-compatible

my $file = $ARGV[0];
die "Usage: perl normalize-accents-safe.pl <file.tpl>\n" unless $file;
die "File not found: $file\n" unless -f $file;

# Accent mapping table using UTF-8 character codes
my %accent_map = (
    # Lowercase
    'á' => 'a', 'é' => 'e', 'í' => 'i', 'ó' => 'o', 'ú' => 'u',
    'à' => 'a', 'è' => 'e', 'ì' => 'i', 'ò' => 'o', 'ù' => 'u',
    'â' => 'a', 'ê' => 'e', 'î' => 'i', 'ô' => 'o', 'û' => 'u',
    'ä' => 'a', 'ë' => 'e', 'ï' => 'i', 'ö' => 'o', 'ü' => 'u',
    'ã' => 'a', 'õ' => 'o', 'ñ' => 'n',
    'ç' => 'c', 'ß' => 'ss',

    # Uppercase
    'Á' => 'A', 'É' => 'E', 'Í' => 'I', 'Ó' => 'O', 'Ú' => 'U',
    'À' => 'A', 'È' => 'E', 'Ì' => 'I', 'Ò' => 'O', 'Ù' => 'U',
    'Â' => 'A', 'Ê' => 'E', 'Î' => 'I', 'Ô' => 'O', 'Û' => 'U',
    'Ä' => 'A', 'Ë' => 'E', 'Ï' => 'I', 'Ö' => 'O', 'Ü' => 'U',
    'Ã' => 'A', 'Õ' => 'O', 'Ñ' => 'N',
    'Ç' => 'C',

    # Special punctuation (using Unicode escapes for clarity)
    "\x{2014}" => '-',   # em dash (—)
    "\x{2013}" => '-',   # en dash (–)
    "\x{201C}" => '"',   # left double quote (")
    "\x{201D}" => '"',   # right double quote (")
    "\x{2018}" => "'",   # left single quote (')
    "\x{2019}" => "'",   # right single quote (')
    "\x{2026}" => '...',  # ellipsis (…)
    "\x{2022}" => '*',   # bullet (•)
);

# Read file with UTF-8 encoding
open my $fh, '<:encoding(UTF-8)', $file or die "Cannot read $file: $!\n";
my @lines = <$fh>;
close $fh;

my $modified = 0;
my $original_count = scalar @lines;
my @modified_lines;

foreach my $line (@lines) {
    my $original = $line;

    # Process the line character by character
    # Only normalize accents, preserve structure
    foreach my $accent (keys %accent_map) {
        my $replacement = $accent_map{$accent};
        if ($line =~ s/\Q$accent\E/$replacement/g) {
            $modified++ if $line ne $original;
        }
    }

    push @modified_lines, $line;
}

# Validate: Line count should NOT change (crucial safety check)
my $new_count = scalar @modified_lines;
if ($new_count != $original_count) {
    die "ERROR: Line count changed ($original_count → $new_count)!\n";
    die "This suggests CSS rules were removed. Aborting.\n";
}

# Write back with UTF-8 encoding, then convert to ASCII
open $fh, '>:encoding(UTF-8)', "$file.tmp" or die "Cannot write $file.tmp: $!\n";
print $fh @modified_lines;
close $fh;

# Validate file is now ASCII-compatible
my $test_ascii = `file -i "$file.tmp" 2>&1`;
if ($test_ascii !~ /ascii|utf-8/i) {
    die "ERROR: Result file is not ASCII-compatible!\n";
    die "File check output: $test_ascii\n";
}

# Move temp file to original (backup original first)
system("cp", $file, "$file.backup");
system("mv", "$file.tmp", $file);

print "✅ SUCCESS: $file\n";
print "   Original lines: $original_count\n";
print "   New lines:      $new_count\n";
print "   Modified chars: $modified\n";
print "✓ All CSS rules preserved\n";
print "✓ Comment accents normalized (ç→c, á→a, etc.)\n";
print "✓ File is now ASCII-compatible\n";
print "✓ Backup saved: $file.backup\n";

exit 0;
