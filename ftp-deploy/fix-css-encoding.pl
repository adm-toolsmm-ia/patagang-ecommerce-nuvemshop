#!/usr/bin/perl
use strict;
use warnings;
use Encode qw(decode encode);

my $file = $ARGV[0] or die "Usage: perl fix-css-encoding.pl <file>";

print "🔧 Corrigindo encoding de: $file\n";

# Ler arquivo
open my $fh, '<:raw', $file or die "Não consegui ler $file: $!";
my $content = do { local $/; <$fh> };
close $fh;

# Detectar e limpar encoding
print "  Tamanho original: " . length($content) . " bytes\n";

# Remove BOM se existir
$content =~ s/^\xEF\xBB\xBF//; # UTF-8 BOM

# Converte para UTF-8 explicitamente
if (my $decoded = eval { decode('UTF-8', $content, Encode::FB_CROAK) }) {
    $content = $decoded;
    print "  ✅ Detectado como UTF-8\n";
} else {
    print "  ℹ️ Não é UTF-8, testando Latin-1...\n";
    $content = decode('Latin-1', $content);
}

# Remove caracteres problemáticos mas mantém válidos
$content =~ s/[^\x00-\x7F]//g if length($content) > 0;

# Garante que aspas estão corretas
$content =~ s/""/"/g;           # Aspas duplas problemáticas
$content =~ s/\x92/'/g;         # Aspas curvas erradas
$content =~ s/\x93/"/g;         # Aspas curvas erradas
$content =~ s/\x94/"/g;         # Aspas curvas erradas
$content =~ s/\x91/'/g;         # Apóstrofos errados
$content =~ s/\x96/-/g;         # Hífens errados

print "  Tamanho final: " . length($content) . " bytes\n";

# Escrever arquivo corrigido
open $fh, '>:utf8', $file or die "Não consegui escrever em $file: $!";
print $fh $content;
close $fh;

print "✅ Arquivo corrigido com sucesso!\n";
