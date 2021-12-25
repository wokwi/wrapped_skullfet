macros/skullfet.gds:
	make -C skullfet
	mkdir -p macros
	cp skullfet/gds/* macros
