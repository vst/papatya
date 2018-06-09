This directory is supposed to contain optional custom startup scripts
for papatya rapache module.

If any, the main startup script will attempt to source them in the
alphabetical order. Note that sub-directories and any files which do
not have `.R` extension are ignored.

The difference between `init.d` and `custom` directories is that
`init.d` is meant to be statically build whereby `custom` is mounted
as a volume.
