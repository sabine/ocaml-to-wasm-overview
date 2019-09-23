files = a01_closures a02_match a03_fibonacci

all: $(files:=.cmm) $(files:=.s)
	rm -rf *.cmx *.cmi *.o a.out

%.cmm: %.ml
	ocamlopt $< -dcmm 2> $@

%.s: %.ml
	ocamlopt $< -S -inline 0 -nodynlink

clean:
	rm -rf *.cmx *.cmi *.o a.out *.cmm *.s

