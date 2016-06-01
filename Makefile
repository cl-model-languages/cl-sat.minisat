

all:
	[ -d minisat ] || git clone https://github.com/niklasso/minisat.git
	$(MAKE) -C minisat config
	$(MAKE) -C minisat
